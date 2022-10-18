package jee.support.controller;

import com.github.pagehelper.PageInfo;
import jee.support.entity.*;
import jee.support.service.CUserService;
import jee.support.service.PublicService;
import jee.support.service.TimingService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;



//TODO 忽略
@RequestMapping("/mini")
@Controller
public class MiniprogramController {
    @Autowired
    CUserService cuserService;
    @Autowired
    TimingService timingService;
    @Autowired
    PublicService publicService;
    /**
     * 加密解密算法 执行一次加密，两次解密
     */
    public static String convertMD5(String inStr){

        char[] a = inStr.toCharArray();
        for (int i = 0; i < a.length; i++){
            a[i] = (char) (a[i] ^ 't');
        }
        String s = new String(a);
        return s;
    }

    @ResponseBody
    @RequestMapping(value = {"/findintegralmini"}, method = RequestMethod.GET)
    public List<CUSER> findintegralmini(){
        List<CUSER> list = cuserService.find_usernameByintegralmini();
        if(list==null){
            System.out.println("当前没有排名");
        }
        return list;
    }

    @ResponseBody
    @RequestMapping(value = {"/login"}, method = RequestMethod.POST)
    public CUSER loginmini(@RequestBody String massage){
        JSONObject json = JSONObject.fromObject(massage);
        String username= json.getString("username");
        String password = json.getString("password");
        //对哈希码进行加密
        String recodePwd = convertMD5(password);
        CUSER cuser = cuserService.authenticate(username, recodePwd);
        cuser.setPassword(null);
        System.err.println(cuser);
        return cuser;
    }


    //单独写一个计算现在时间的方法
    public String getNowTime(){
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        return time;
    }
    //单独写一个方法 用于获取timing内容
    public List<Timing> GetAllStatusFromTiming(){
        List<Timing> timings = timingService.getAllStatus();
        return timings;
    }
    //首页显示的时间是定时的时间，而不是编辑的时间
    public Timing GettimeByoid(int id,String type){
        Timing timingList = timingService.gettimeByoid(id,type);
        return timingList;
    }
    public void updatestatusBytype(int oid,String type){
        switch (type){
            case "activity":
                publicService.updatestatusBytypeAndoid(oid);
                break;
            case "notice" :
                publicService.updatestatusByannoncementtypeAndoid(oid);
                publicService.updatestatusBynoticetypeAndoid(oid);
                break;
            case "suduko" :
                publicService.updatestatusBysudukotypeAndoid(oid);
                break;
            case "article" :
                publicService.updatestatusArticleBytypeAndoid(oid);
                break;
            case " 3" :
                publicService.updatestatusBytypeAndoid(oid);
                break;
        }
    }
//    @ResponseBody
//    @RequestMapping(value = {"/Article"}, method = RequestMethod.GET)
//    public List<Article> Article(){
//        //TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!定时发送时间验证
//        String time = getNowTime();
//        int sum = timingService.updatestatus(time.substring(0,16));
//        List<Timing> articleList = new ArrayList<>();
//        Timing Tarticle =null;
//        if(sum==0){
//            System.out.println(sum+"没有需要发布的内容");
//        }else{
//            //如果有修改的条数，表示有些内容已经到发布时间，所以把这些内容拿出来 status=1
//            List<Timing> timings = GetAllStatusFromTiming();
//            int oid=0;
//            String type;
//
//            for(Timing t:timings){
//                oid = t.getOid();
//                type = "article";
//                String ttpey =t.getType();
//                updatestatusBytype(oid,type);
//                if(ttpey.equals("article")){
//                    Tarticle = GettimeByoid(oid,type);
//                    articleList.add(Tarticle);
//                }
//            }
//        }
//
//        PageInfo<Article> articlepageInfo = publicService.getArticleIndex(1,11);
//
//        List<Article> articleList1 =articlepageInfo.getList();
//        //TODO 取出 的文章表，和时间表，oid和id进行对比，对比成功之后替换正确的发布时间，而并非编辑时间
//        for(Article a :articleList1){
//            int aid = a.getId();
//            for(Timing t:articleList){
//                int oid = t.getOid();
//                if(oid==aid){
//                    String realtime = t.getTime();
//                    a.setTime(realtime);
//                }
//            }
//        }
//        articlepageInfo.setList(articleList1);
//
//
//
//
//    }

//    @ResponseBody
//    @RequestMapping(value = {"/Activity"}, method = RequestMethod.GET)
//    public List<Activity> Activity(){
//
//
//
//
//
//    }
}
