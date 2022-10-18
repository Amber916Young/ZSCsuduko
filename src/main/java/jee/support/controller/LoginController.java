package jee.support.controller;

import jee.support.constants.OpCode;
import jee.support.constants.Constants;
import jee.support.entity.*;
import jee.support.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class LoginController {
    @Autowired
    CUserService cuserService;
    @Autowired
    AllUserService allUserService;

    @Autowired
    Head_portraitService head_portraitService;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    AdministratorService administratorService;
    @Autowired
    RoleService roleService;

    private String authUriSet ="authUriSet";

    @RequestMapping(value = {"/error"})
    public String error(){
        return "error";
    }


    //ajax
    @PostMapping("/checkUsername")
    @ResponseBody
    public String checkUsername(@RequestBody CUSER cuser) {

        String uername =  cuser.getUsername();
        if (uername==null||uername==""){
            return "no";
        } else if(cuserService.findByUsername(cuser.getUsername())==null){

            return "OK";
        }
        return "FAIl";
    }


    //注销
    @RequestMapping(value = {"/logout"}, method = RequestMethod.GET)
    public String logout(HttpSession session,HttpServletRequest  request,HttpServletResponse response) {
        session.invalidate();
        Cookie[] cookies=request.getCookies();
        for(Cookie cookie: cookies){
            cookie.setMaxAge(0);
            cookie.setPath("/");  //路径一定要写上，不然销毁不了
            response.addCookie(cookie);
        }
        return "redirect:/index/shudu_main";
    }

    void KeepUser_Session( HttpServletRequest request,
                           HttpSession session,CUSER cuser){

        session.setAttribute("user", cuser);
        // 获取用户权限信息
        String realname = cuser.getRealname();
        RefreshAllmessage(realname, session);
        //在登录的时候要判断是不是管理员  也就是说需要判断你的身份
        String flag = RefreshAdminByrealname(realname, session);
        if (flag == "no") {
//                System.out.println("这个是普通会员");
        }
        List<Permission> permissions = permissionService.queryPermissionsByUser(cuser);
        Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
        Permission root = null;
        Set<String> uriSet = new HashSet<String>();
        for (Permission permission : permissions) {
            permissionMap.put(permission.getId(), permission);
            //不是空字符串
            if (permission.getUrl() != null && !"".equals(permission.getUrl())) {
                //授权
                uriSet.add(session.getServletContext().getContextPath() + permission.getUrl());
            }
        }
        session.setAttribute(authUriSet, uriSet);
        for (Permission permission : permissions) {
            Permission child = permission;
            if (child.getPid() == 0) {
                root = permission;
            } else {
                Permission parent = permissionMap.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        session.setAttribute("rootPermission", root);
        request.getSession().setAttribute(Constants.SESSION_USER, cuser);
    }
    //身份验证
    @RequestMapping(value = "/autologin", method = RequestMethod.POST)
    public String autologin(HttpServletRequest request,
                        HttpSession session){
        CUSER cuser = (CUSER)session.getAttribute("user");
        Permission root = (Permission)session.getAttribute("rootPermission");
//        System.out.println("autologin    !!!!!!!!!!!!!!!!"+root);
        if(root==null){
            KeepUser_Session(request,session, cuser);
            System.out.println("autologin进入   !!!!!!!!!!!!!!!!");
            session.setAttribute("autoLogin","stop");
        }
        return "index_mainauto";
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

    //身份验证
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpServletRequest request,
                        HttpServletResponse response,
                        HttpSession session,Model model
    ) throws ServletException, IOException {
        Map<String, HttpSession> userMap = (Map<String, HttpSession>) request.getServletContext().getAttribute("userMap");
        if (userMap == null) {
            userMap = new HashMap<String, HttpSession>();
        }
        //3.查看Cookie中是否有自动登录的cookie
        Cookie cookie = CookiesUtil.getCookieByName("autoLoginUser", request.getCookies());
        CUSER cuserlogin = (CUSER) session.getAttribute("user");
        //4.判断Cookie是否为空，若不为空就登陆
        if (cuserlogin != null) {
            model.addAttribute("loginmsg", "错误1：您已经登陆了,不可重复登陆");
            return "index_mainauto";
        }
        if (cookie != null) {
            String autoUser = cookie.getValue();
            System.out.println("autoUser" + autoUser);
            model.addAttribute("loginmsg", "错误2：您已经登陆了,不可重复登陆");
            return "index_mainauto";
        }
        if (userMap.get(username) == null) {
            //对哈希码进行加密
            String recodePwd = convertMD5(password);
            CUSER cuser = cuserService.authenticate(username, recodePwd);
            if (cuser == null) {
                request.setAttribute(Constants.LOGIN_STATUS, OpCode.INVALID_USER);
                //如果失败，就返回原来都界面
                return "index_mainauto";
            } else {
                userMap.put(cuser.getRealname(), session);
                request.getServletContext().setAttribute("userMap", userMap);
                request.changeSessionId();
                KeepUser_Session(request, session, cuser);
                cookie = new Cookie("autoLoginUser", username + "-" + password);
                cookie.setMaxAge(3600 * 24 * 30);//设置最大失效时间 一年
                response.addCookie(cookie);
                String realname = cuser.getRealname();
                int numberOfSessions = userMap.size();
                session.setAttribute("numberOfSessions", numberOfSessions);
                return "redirect:/user/home?name=" + realname;
            }
        } else {
            System.out.println("重复登陆");
            model.addAttribute("loginmsg", "错误3;您已经登陆了,不可重复登陆");
            return "index_mainauto";
        }
    }

    //TODO 暂时不设计注册
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String register(@RequestParam("realname") String realname,
                           @RequestParam("username") String username,
                           @RequestParam("password") String password,
                           @RequestParam("email") String email,
            HttpServletRequest request,
            HttpSession session
    ){
//        System.out.println("username" + username);
//        System.out.println("password" + password);
        Date date = new Date();
        System.out.println(date);
        String dateStr = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
        System.out.println(dateStr);
        CUSER cuser = new CUSER();
        cuser.setRealname(realname);
        cuser.setUsername(username);
        cuser.setPassword(password);
        cuser.setEmail(email);
        cuser.setCreatetime(dateStr);

        cuserService.insertUser(cuser);
        //新建用户是没有头像的
        RefreshAllmessage(realname,session);
        if(cuser !=null){
           request.changeSessionId();
           session.setAttribute("user", cuser);
           request.getSession().setAttribute(Constants.SESSION_USER, cuser);
           return "redirect:index_main";
       }else{
           return "index_mainauto.0";
       }

    }


    //调用这个方法可以更新homepage 的图片（头像）
    void RefreshAllmessage(String realname ,HttpSession session){
        Head_portrait head_portrait= head_portraitService.selectAllmessage(realname);
        session.setAttribute("head_portrait",head_portrait);
    }


    //调用这个方法是在登陆时候找到是不是管理员身份
    //管理员一定是会员
    String RefreshAdminByrealname(String realname ,HttpSession session){
        administrator admin = administratorService.findadminByRealname(realname);
        if(admin==null){
            return "no";
        }
        session.setAttribute("admin",admin);
//        System.out.println("判断你的身份admin"+admin);
      return "yes";
    }

}