package jee.support.controller;

//import com.sun.org.apache.xpath.internal.operations.Mod;
import jee.support.entity.*;
import jee.support.service.AccountService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


//秘书长和秘书部可以记录花费
@RequestMapping("/account")
@Controller
public class AccountConroller {

    @Autowired
    AccountService accountService;

    @RequestMapping("/")
    public String GotoAccountPage(Model model) {
//        int id=1;
//        List<Account> Allexpenditure = Getaccounts_expenditureBygid(id);
//        double allmeony =Getmoney(id);
//        double sum=0.0;
//        double balance=0.0;
//
//        for(Account Allexpenditures :Allexpenditure){
//            sum+=Allexpenditures.getExpenditure();
//        }
//        System.out.println(" allmeony sum=="+allmeony+"   "+sum);
//
//        balance= allmeony-sum;
//        model.addAttribute("allmoney",allmeony);
//        model.addAttribute("balance",balance);
        return "account/account";
    }



//    @ResponseBody
//    @RequestMapping(value = "/find_accountByid",method = RequestMethod.POST)
//    public List<Account> constitution( @RequestBody  String selectid ,Model model ){
//        JSONObject json = JSONObject.fromObject(selectid);
//        System.out.println("selectid=="+selectid);
//        int id =  Integer.parseInt(json.getString("selectid"));
//        System.out.println("id=="+id);
//        List<Account> account = accountService.findAllById(id);
//
//        model.addAttribute("account",account);
//        return account;
//    }




    /**
     * 得到社团账户余额
     * */
    @ResponseBody
    @RequestMapping(value = "/balance",method = RequestMethod.POST)
    public String  GetBalanceByid(Integer id){
        double allmeony =Getmoney(id);
        double sum=0.0;
        double balance=0.0;
        if(allmeony==0){
            return "fail";
        }
        List<Account> Allexpenditure = Getaccounts_expenditureBygid(id);
        for(Account Allexpenditures :Allexpenditure){
            sum+=Allexpenditures.getExpenditure();
        }
        System.out.println(" allmeony sum=="+allmeony+"   "+sum);
        balance= allmeony-sum;
        String bAndA = balance+"?"+allmeony;
        return  bAndA;
    }

    @ResponseBody
    @RequestMapping({"/pageQuery"})
    public Object pageQuery(String queryText, Integer pageno, Integer pagesize,Model model) {
        AJAXResult result = new AJAXResult();

        int id=1;
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            if (queryText==null){
                id= 1;
                System.out.println(id);
            }else{
                id= Integer.parseInt(queryText);
                System.out.println(id);
            }


            List<Account> accounts = this.accountService.pageQueryData(map);
//            List<Money> monies = this.accountService.queryMoneyByid(id);
//            if(monies!=null){
//
//                model.addAttribute("allmoney",monies);
//                double balance = GetBalanceByid(id);
//                model.addAttribute("balance",balance);
//            }
            int totalsize = this.accountService.pageQueryCount(map);
            int totalno = 0;

            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<Account> accountPage = new Page();
            accountPage.setDatas(accounts);
            accountPage.setTotalno(totalno);
            accountPage.setTotalsize(totalsize);
            accountPage.setPageno(pageno);
            result.setData(accountPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }


    //添加总金额
    @ResponseBody
    @RequestMapping(value = {"/upload"}, method = RequestMethod.POST)
    public String addmoenyByid(@RequestBody String massage,Model model ) {
        JSONObject json = JSONObject.fromObject(massage);
        double addmoeny = Double.valueOf(json.getString("addmoeny"));
        int selectid = Integer.parseInt(json.getString("selectid"));
        System.out.println("进入addmoenyByid addmoeny,selectid" + addmoeny + "," + selectid);
        //在添加之前检查是否有钱
        Money money1 = new Money();
        Money money2 = new Money();
        if (accountService.checkmoney(selectid)==null) {
            //总金额
            money1.setAccount_money(addmoeny);
            money1.setId(selectid);
            System.out.println("进入if");
            accountService.addmoeny(money1);
            //总金额 第二个表    account表  gid  余额
            model.addAttribute("allmoney", money1);
            return "ok";
        } else{
            System.out.println("进入else");
            //获得这一届所有的明细表
            money2.setAccount_money(addmoeny);
            money2.setId(selectid);
            List<Account> accounts = Getaccounts(selectid);
            //获取原来的总金额
            double allmoeny = Getmoney(selectid);
            System.out.println("allmoeny："+allmoeny);
            accountService.updatemoney(money2);
            //总金额 第二个表    account表  gid  余额
            double realmoney=0.0;
            //新加入的金额与原来的比较，按照道理是比原来的高 这些都是money表的数据 和account无关
            if(addmoeny>allmoeny){
                 realmoney = addmoeny-allmoeny;
            }else{
                 realmoney = addmoeny-allmoeny;
            }

            int t=0;
            //TODO 这里应该是循环更新，一届有很多活动
            System.out.println("马上开始执行 循环accounts"+accounts.size()+"  "+accounts);
            for(Account account :accounts){
                t++;
                int id;
                id= account.getId();

                //获得原来的余额
                System.out.println("id  t="+id+"   "+t);
                double before_balance =GetBalance(id);
                double nowBalance = realmoney+before_balance;
                System.out.println("before_balance  t="+before_balance);
                System.out.println("nowBalance  t="+nowBalance);
                //说明以前有值，要更新  所以account表里面的余额要变化
                accountService.setAccountmoeny(nowBalance,id);
            }
            //都更新完毕，再次查找money表 获取现在的金额
            double allmoney =Getmoney(selectid);
            money1.setAccount_money(allmoney);
            money1.setId(selectid);

            model.addAttribute("allmoney",money1);
            return "ok";
        }
    }

    @RequestMapping("/add")
    public String GotoAdd(){
        return "account/add";
    }




    /**
     * account目录下的add.jsp  自动计算余额
     * */
    @ResponseBody
    @RequestMapping(value = {"/checkBalance"},method = RequestMethod.POST)
    public double checkBalance(@RequestBody String massage , Model model){
        JSONObject json = JSONObject.fromObject(massage);

        int gid =  Integer.parseInt( json.getString("gid"));
        //花费
        double expenditure = Double.valueOf(json.getString("expenditure"));
        System.out.println("expenditure=="+expenditure);
        List<Account> Allexpenditure = Getaccounts_expenditureBygid(gid);
        double allmeony =Getmoney(gid);
        double sum=0.0;
        for(Account Allexpenditures :Allexpenditure){
            sum+=Allexpenditures.getExpenditure();
        }
        System.out.println(" allmeony sum=="+allmeony+"   "+sum);
        double balance =allmeony-(sum+expenditure);
        System.out.println("balance=="+balance);
        model.addAttribute("balance",balance);
        return  balance;
    }



    @ResponseBody
    @RequestMapping(value = {"/insert"}  ,method = RequestMethod.POST)
    public Object insert(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        System.out.println(massage);
        JSONObject json = JSONObject.fromObject(massage);

        String name = json.getString("name");
        int gid = Integer.parseInt( json.getString("gid"));
        String detail = json.getString("detail");
        int id =  Integer.parseInt(json.getString("id"));
        double expenditure = Double.valueOf(json.getString("expenditure"));
        String time = json.getString("time");
        double balance = Double.valueOf(json.getString("balance"));
        String pname = json.getString("pname");
        Account account = new Account();
        account.setExpenditure(expenditure);
        account.setBalance(balance);
        account.setDetail(detail);
        account.setGid(gid);
        account.setName(name);
        account.setId(id);
        account.setPname(pname);
        account.setTime(time);




        try {
            accountService.insertAccount(account);

            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping({"/delete"})
    public Object delete(String id) {
        AJAXResult result = new AJAXResult();
        try {
            this.accountService.deleteAccountById(id);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    //批量删除！！！！！！！！！！！
    @ResponseBody
    @RequestMapping({"/deletes"})
    public Object deletes(@RequestBody String [] id) {
        AJAXResult result = new AJAXResult();

        System.out.println("id"+id);
        try {
            Map<String, Object> map = new HashMap();
            map.put("ids", id);
            this.accountService.deleteAccountsByid(map);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @RequestMapping(value = {"/view"},method = RequestMethod.GET)
    public String viewAccount(@RequestParam("id") int id,
                             Model model) {
        Account account = accountService.getAccount(id);
        model.addAttribute("account", account);
        return "account/view";
    }

    /**
     * account目录下的edit.jsp  修改账本信息
     * */
    @RequestMapping(value = {"/edit"},method = RequestMethod.GET)
    public String UpdataAccount(@RequestParam("id") int id,
                             Model model) {
        Account account = accountService.getAccount(id);
        model.addAttribute("account", account);
        return "account/edit";
    }

    /**
     * account目录下的edit.jsp  修改账本信息更新
     * */
    @ResponseBody
    @RequestMapping(value = {"/update"}  ,method = RequestMethod.POST)
    public Object update(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        System.out.println(massage);
        JSONObject json = JSONObject.fromObject(massage);
        String name = json.getString("name");
        int gid = Integer.parseInt( json.getString("gid"));
        String detail = json.getString("detail");
        int id =  Integer.parseInt(json.getString("id"));
        double expenditure = Double.valueOf(json.getString("expenditure"));
        String time = json.getString("time");
        double balance = Double.valueOf(json.getString("balance"));
        String pname = json.getString("pname");
        Account account = new Account();
        account.setExpenditure(expenditure);
        account.setBalance(balance);
        account.setDetail(detail);
        account.setGid(gid);
        account.setName(name);
        account.setId(id);
        account.setPname(pname);
        account.setTime(time);
        try {
            accountService.updateAccount(account);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }


    //总金额
    public double Getmoney(int id){
        //检查这个存不存在 该信息
        int sum = accountService.checkIsNot(id);
        if(sum==0){
            return 0;
        }
        double allmoney = accountService.getmoney(id);

        return allmoney;
    }

    //根据 id 查询余额
    private double GetBalance(int id){
        return accountService.GetBalance(id);
    }

    //获取这一届的所有活动
    private List<Account> Getaccounts(int id){
        return accountService.Getaccounts(id);
    }

    //获取这一届所有的花费  不是余额
    private List<Account> Getaccounts_expenditureBygid(int gid){
        return accountService.Getaccounts_expenditureBygid(gid);
    }

    //更新数据金额，一旦总金额更变 ，原来的account 余额也会变更
//    void ChangeAccountBalance(int id,double money){
//
//    }



}
