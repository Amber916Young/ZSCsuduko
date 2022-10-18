package jee.support.controller;

import com.github.pagehelper.PageInfo;
import jee.support.entity.*;
import jee.support.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

import static jee.support.entity.CheckIP.getIpAddress;
import static jee.support.entity.IPUtil.getCityInfo;

@Controller
@RequestMapping({"/user"})
public class UserController {

    @Autowired
    private CUserService cUserService;
    @Autowired
    private RoleService roleService;

    @Autowired
    private PublicService publicService;
    @Autowired
    private AdministratorService administratorService;
    //此操作为用户自己来实现的
    @Autowired
    private AllUserService allUserService;
    @Autowired
    private CommentService commentService;


    /**
     * 用户进入主页，  注意这和homecontroller不一样，第一次登陆经过是这次的映射
     **/
    @RequestMapping(value = {"/home"},method = RequestMethod.GET)
    public String GoToHomePage(HttpSession session){
        CUSER cuser =  (CUSER) session.getAttribute("user");
        String realname = cuser.getRealname();
        CUSER cuserList = allUserService.QueryUserByrealname(realname);
//        System.out.println("cuserList！！！！！！！！！！！！"+cuserList);
        session.setAttribute("user",cuserList);
        return "home/homepage";
    }
    @RequestMapping(value = {"/logip"})
    public String GotoLogip(Model model,HttpServletRequest request){
        String ip = getIpAddress(request);
        System.err.println(getCityInfo(ip));
        String ipaddress=getCityInfo(ip);
        model.addAttribute("ip",ip);
        model.addAttribute("ipaddress",getCityInfo(ip));
        System.out.println("ipppppppppppppp"+ip);
        return "home/Ippage";
    }
    /**
     * 查看用户做题
     **/
    @RequestMapping(value = {"/suduko"},method = RequestMethod.GET)
    public String GoTosudukoPage(@RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "size", defaultValue = "15") int size,
                                 Model model, HttpSession session) {
//        System.out.println("进入GoTosudukoPage1");
        CUSER cuser = (CUSER) session.getAttribute("user");
        String username = cuser.getUsername();
        PageInfo<UserScore> pageInfo = allUserService.GetMyAllsuduko(page,size,username);
//        System.out.println("进入GoTosudukoPage pageInfo"+pageInfo);
        model.addAttribute("pageInfo", pageInfo);
        return "home/mysuduko/mysuduko";
    }

    //更改密码
    @RequestMapping(value = "/editpwd",method = RequestMethod.GET)
    public String editpd(HttpSession session,Model model){
        CUSER cuser = (CUSER) session.getAttribute("user");
        String password = cuser.getPassword();
        String decode = convertMD5(password);
        model.addAttribute("decode",decode);

        return "home/editpassword";
    }





    //批量删除！！！！！！！！！！！
    @ResponseBody
    @RequestMapping({"/deletes"})
    public Object deletes(@RequestBody String [] realname) {
        AJAXResult result = new AJAXResult();

        System.out.println("realname"+realname);
        try {
            Map<String, Object> map = new HashMap();
            map.put("realnames", realname);
            this.cUserService.deleteUsers(map);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/delete"},method = RequestMethod.POST)
    public Object delete(String realname) {
        AJAXResult result = new AJAXResult();
        try {
            this.cUserService.deleteUserById(realname);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
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



    //管理员操作 user目录下的更新界面
    @ResponseBody
    @RequestMapping(value = {"/update"},method = RequestMethod.POST)
    public Object update(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        System.out.println(massage);
        JSONObject json = JSONObject.fromObject(massage);
        String realname = json.getString("realname");
        String username = json.getString("username");
        String email = json.getString("email");
        String password = json.getString("password");
        String recodePwd = convertMD5(password);

        String gender = json.getString("gender");
        String tel = json.getString("tel");
        String department = json.getString("department");
        String sno = json.getString("sno");
        String major = json.getString("major");
        int level = json.getInt("level");
//        String head_portrait = json.getString("head_portrait");
        int id = json.getInt("id");
        int grade = json.getInt("grade");

        int integral = json.getInt("integral");
        String userUrl = json.getString("userUrl");
        String createtime = json.getString("createtime");

        try {
            CUSER cuser = new CUSER();
            cuser.setId(id);
            cuser.setGrade(grade);
            cuser.setUsername(username);
            cuser.setRealname(realname);
            cuser.setEmail(email);
            cuser.setPassword(recodePwd);
            cuser.setGender(gender);
            cuser.setTel(tel);
            cuser.setDepartment(department);
            cuser.setSno(sno);
            cuser.setMajor(major);
            cuser.setLevel(level);
//            cuser.setHead_portrait(head_portrait);
            cuser.setIntegral(integral);
            cuser.setUserUrl(userUrl);
            cuser.setCreatetime(createtime);

            this.cUserService.updateUser(cuser);
            //更改主表user 用户的个人信息，那么如果该同学是会干administrator表也相应改变
            administrator admin = administratorService.findadminByRealname(realname);
            administrator admin2 = new administrator();
            if(admin!=null){
                String position = admin.getPosition();
                int sid = admin.getSid();
                administratorService.deleteUserByRealname(realname);
                admin2.setPosition(position);
                admin2.setId(id);
                admin2.setSid(sid);
                admin2.setSno(sno);
                admin2.setGender(gender);
                admin2.setGrade(grade);
                admin2.setMajor(major);
                admin2.setDepartment(department);
                admin2.setRealname(realname);
                administratorService.insertAdmin(admin2);
            }

            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    //管理员操作 user目录下的edit.jsp
    @RequestMapping({"/edit"})
    public String edit(String id, Model model) {
        System.out.println("edit realname"+id);
        CUSER user = this.cUserService.queryByUsername(id);
        String password = user.getPassword();
        String decode1 = convertMD5(password);
        model.addAttribute("decode1",decode1);
        model.addAttribute("muser", user);
        return "users/edit";
    }

    //进入分配页面
    @RequestMapping(value = {"/assign"})
    public String assign(String id, Model model) {
        CUSER user = this.cUserService.queryByUsername(id);
        System.out.println("assign realname id"+id);
//        String username = "'"+id+"'";
        System.out.println("realname "+id);
        model.addAttribute("muser", user);
        List<Role> roles = this.roleService.queryAll();
        List<Role> assingedRoles = new ArrayList<Role>();
        List<Role> unassignRoles = new ArrayList<Role>();
        List<String> roleids = this.cUserService.queryRoleidsByUsername(id);
//        System.out.println("roleids"+roleids);
        //TODO 有错  不能比较
        for(Role role :roles){
            if(roleids.contains(Integer.toString(role.getId()))){
                assingedRoles.add(role);
            }else {
                unassignRoles.add(role);
            }
        }
        model.addAttribute("assingedRoles", assingedRoles);
        model.addAttribute("unassignRoles", unassignRoles);
        return "users/assign";
    }

    //TODO 在分配角色时候会干应该自动加入到administrator表或者更新
     public void UpdateAministrator(String  username){
        //获取该用户的所有信息
        CUSER  cuser = cUserService.findByRealname(username);
        List<Integer> roleids = this.roleService.findnameByid(username);
        administrator admin = new administrator();
        admin.setDepartment(cuser.getDepartment());
        admin.setGender(cuser.getGender());
        admin.setGrade(cuser.getGrade());
        admin.setRealname(cuser.getRealname());
        admin.setMajor(cuser.getMajor());
        admin.setSno(cuser.getSno());
        admin.setId(cuser.getId());
        String positions =" ";
        if(roleids.size()==1){
            positions = this.roleService.findnameByroleid(roleids.get(0));
            admin.setSid(roleids.get(0));
            admin.setPosition(positions);
        }else{
            int maxroleid=Collections.min(roleids);
            admin.setSid(maxroleid);
            for(int i=0;i<roleids.size();i++){
                String position = this.roleService.findnameByroleid(roleids.get(i));
                positions = position+','+positions;
            }
            System.out.println(positions);
            admin.setPosition(positions);
        }
        administratorService.deleteUserByRealname(cuser.getRealname());
        administratorService.insertAdmin(admin);
     }


    @ResponseBody
    @RequestMapping({"/doAssign"})
    public Object doAssign(String  username, Integer[] unassignroleids) {
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("realname", username);
            map.put("roleids", unassignroleids);
            /**TODO
             * 自动加入管理员表  一旦分配角色就是管理员，不过后期可能会多一个普通用户角色，
             * 要做判断，不是所有角色都应该加入管理员表
            **/
            this.cUserService.insertUserRoles(map);
            if(unassignroleids.length!=1){
                for(int i = 0;i<unassignroleids.length;i++){
                    if(unassignroleids[i]==8){
                        System.err.println("普通会员");
                    }
                }
                UpdateAministrator(username);
            }
            if(unassignroleids.length==1){
                if(unassignroleids[0]==8){
                }else {
                    UpdateAministrator(username);
                }
            }

            result.setSuccess(true);
        } catch (Exception var5) {
            var5.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }



    @ResponseBody
    @RequestMapping(value = {"/dounAssign"},method = RequestMethod.POST)
    public Object dounAssign(String username, Integer[] assignroleids) {
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("realname", username);
            map.put("roleids", assignroleids);
            this.cUserService.deleteUserRoles(map);
           administrator admin= administratorService.findadminByRealname(username);
           if(admin!=null){
               UpdateAministrator(username);
           }
            result.setSuccess(true);
        } catch (Exception var5) {
            var5.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/insert"} )
    public Object insert(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        System.out.println(massage);
        JSONObject json = JSONObject.fromObject(massage);
        String realname = json.getString("realname");
        String username = json.getString("username");
        String email = json.getString("email");
        String password = json.getString("password");
        String recodePwd = convertMD5(password);
        String gender = json.getString("gender");
        String tel = json.getString("tel");
        String department = json.getString("department");
        String sno = json.getString("sno");
        String major = json.getString("major");
        int level = json.getInt("level");
        int integral = json.getInt("integral");
        int id = json.getInt("id");
        int grade = json.getInt("grade");
        String userUrl = json.getString("userUrl");
        String createtime = json.getString("createtime");
        //初始密码

        try {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            cuser.setCreatetime(sdf.format(new Date()));
            CUSER cuser = new CUSER();
            if(cuser.getDepartment()==null||cuser.getDepartment()==""){
                cuser.setDepartment("社会人员");
                cuser.setMajor("社会人员");
                cuser.setSno("000000");
            }
            if(cuser.getMajor()==null||cuser.getMajor()==""){
                cuser.setMajor("社会人员");
                cuser.setSno("000000");
            }
            cuser.setId(id);
            cuser.setGrade(grade);
            cuser.setRealname(realname);
            cuser.setUsername(username);
            cuser.setEmail(email);
            cuser.setPassword(recodePwd);
            cuser.setGender(gender);
            cuser.setTel(tel);
            cuser.setDepartment(department);
            cuser.setSno(sno);
            cuser.setMajor(major);
            cuser.setLevel(level);
            cuser.setIntegral(integral);
            cuser.setUserUrl(userUrl);
            cuser.setCreatetime(createtime);
            this.cUserService.insertUser(cuser);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    @RequestMapping({"/add"})
    public String add() {
        return "users/add";
    }


    @RequestMapping(value = {"/"},method = RequestMethod.GET)
    public String GoToUserPage(){
        return "users/user";
    }
    @ResponseBody
    @RequestMapping({"/pageQuery"})
    public Object pageQuery(String queryText, Integer pageno, Integer pagesize) {
        AJAXResult result = new AJAXResult();

        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<CUSER> users = this.cUserService.pageQueryData(map);
            int totalsize = this.cUserService.pageQueryCount(map);
            int totalno = 0;

            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }

            Page<CUSER> userPage = new Page();
            userPage.setDatas(users);
            userPage.setTotalno(totalno);
            userPage.setTotalsize(totalsize);
            userPage.setPageno(pageno);
            result.setData(userPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }



//    @RequestMapping({"/"})
//    public String index1(@RequestParam(required = false,defaultValue = "1") Integer pageno, @RequestParam(required = false,defaultValue = "2") Integer pagesize, Model model) {
//        Map<String, Object> map = new HashMap();
//        map.put("start", (pageno - 1) * pagesize);
//        map.put("size", pagesize);
//        List<CUSER> users = this.cUserService.pageQueryData(map);
//        model.addAttribute("users", users);
//        //当前页码
//        model.addAttribute("pageno", pageno);
//        int totalsize = this.cUserService.pageQueryCount(map);
//
//        int totalno =0;
//        //计算总页码
//        if (totalsize % pagesize == 0) {
//            totalno = totalsize / pagesize;
//        } else {
//            totalno = totalsize / pagesize + 1;
//        }
//
//        model.addAttribute("totalno", totalno);
//        return "users/user";
//    }

    //进入个人评论中心  用户操作
    @RequestMapping(value = "/comment",method = RequestMethod.GET)
    public String GotoUserComment(Model model,HttpSession session,
                                  @RequestParam(value = "page", defaultValue = "1") int page,
                                  @RequestParam(value = "size", defaultValue = "20") int size){
        CUSER cuser = (CUSER)session.getAttribute("user");
        String realname = cuser.getRealname();
        String username = cuser.getUsername();

//        List<Comment> commentList = cUserService.getUserCommentByrealname(realname);
        PageInfo<Comment> pageInfo = commentService.getCommentIndex(page,size,realname);
        List<Comment> commentList =pageInfo.getList();

        List<Object> activities = new ArrayList<>();
        List<Object> articles = new ArrayList<>();
        for(Comment list:commentList){
            int aid = list.getAid();
            Activity activity = publicService.getActivityByaid(aid);
            Article article = publicService.getArticleByaid(aid);
            if(activity!=null){
                activities.add(activity);
            }if(article!=null){
                articles.add(article);
            }
        }
        articles.addAll(activities);

//        System.out.println(activities);
        System.out.println("总共长度"+articles.size());
//        System.out.println("总共"+articles);
        pageInfo.setList(commentList);
//        model.addAttribute("activities",activities);
//        model.addAttribute("articles",articles);
        model.addAttribute("articles",articles);
        model.addAttribute("commentList",commentList);
        model.addAttribute("pageInfo",pageInfo);
        return "/home/usercomment";
    }



}
