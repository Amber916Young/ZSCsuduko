package jee.support.controller;

import jee.support.constants.Constants;
import jee.support.dao.AllUserDao;
import jee.support.entity.*;
import jee.support.service.AllUserService;
import jee.support.service.CUserService;
import jee.support.service.Head_portraitService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.lang.reflect.Method;

import static jee.support.controller.DeleteFileController.delete;
import static jee.support.controller.DeleteFileController.deleteFile;
import static jee.support.entity.CheckIP.getIpAddress;
import static jee.support.entity.IPUtil.getCityInfo;


/**
 * 用户个人操作
 * */
@Controller
@RequestMapping("/home")
public class HomeController {
    @Autowired
    AllUserService allUserService;
    @Autowired
    Head_portraitService head_portraitService;
    // 文件上传路径
    @Resource(name="fileuploadPath")
    private String fileuploadPath;


    /**
     * 个人主页
     * */
    @RequestMapping(value = {"/","/home"})
    public String Goto(@RequestParam("name") String realname,HttpSession session){
        CUSER cuserList = allUserService.QueryUserByrealname(realname);
        session.setAttribute("user",cuserList);
//        System.out.println("cuserList！！！！！！！！！！！！"+cuserList);


        return "home/homepage";
    }



    /**
     * 检查是否有重复用户名     home目录下homepage.jsp
     * */
    @ResponseBody
    @RequestMapping(value = "/checkusername",method = RequestMethod.POST)
    public Object Checkusername(@RequestBody String massage){
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        String username = json.getString("username");
        String realname = json.getString("realname");

//        System.out.println("username="+username);
//        System.out.println("realname="+realname);
        try {
            String flag = allUserService.checkusername(username,realname);
//            System.out.println("flag="+flag);
            if(flag ==null){
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
            }
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

//    @RequestMapping("/upload")
//    //处理文件上传
//    public List uploadFiles(@RequestParam("file") MultipartFile files,
//                            HttpServletRequest request) throws IOException {
//        System.out.println("uploadFiles files:"+files);
//        String savePath = request.getServletContext().getRealPath("/upload");
//        File dir = new File(savePath);
//        //判断上传文件夹是否存在
//        if (!dir.exists()) {
//            dir.mkdirs();
//        }
//
//
//        HttpSession session = request.getSession();
//        //获取当前登录用户
//        CUSER user = (CUSER) session.getAttribute("username");
//        String username= user.getUsername();
//        System.out.println("uploadFiles username:"+username);
//        List hdList = new ArrayList<Head_portrait>();
//
//            Head_portrait head_portrait= new Head_portrait();
//            //文件名为用户名id_文件名
//            String filename = user.getUsername() + "_" + files.getOriginalFilename();
//            //保存文件
//            if (!files.isEmpty()) {
//                File newFile = new File(dir, filename);
//                files.transferTo(newFile);
//                head_portrait.setFileName(filename);
//                head_portrait.setMimeType(files.getContentType());
//                head_portrait.setFileUrl("/upload/" + filename);
//                head_portrait.setUsername(username);
//                head_portraitService.addHead_portrait(head_portrait);
//                hdList.add(head_portrait);
//
//            }
//
//        return hdList;
//    }
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

    /**
     * 用户个人操作  修改密码   第一次输入必须验证原密码正确，原密码输入数组，会在前端hashcode加密
     * 后台第二次md5加密，加密后的密码与数据库user表对比
     * */
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    public Object edit(@RequestParam("password") String password ,@RequestParam("realname") String realname  ,HttpSession session){
       AJAXResult result = new AJAXResult();
        System.out.println("修改密码edit"+password);
        System.out.println("修改realname"+realname);
        String recodePwd = convertMD5(password);
        int sum  = allUserService.updatePwdByrealname(realname,recodePwd);
        CUSER cuserList = allUserService.QueryUserByrealname(realname);
        session.setAttribute("user",cuserList);
        return "home/editpassword";
    }

    /**
     * 用户个人操作 更新个人信息 home目录下的homepage.jsp
     * */
    @RequestMapping({"/update"})
    public Object update(@RequestParam("file") MultipartFile file, CUSER cuser,
                         HttpServletRequest request,HttpSession session) throws Exception {
        AJAXResult result = new AJAXResult();
        System.out.println("update 的user" + cuser);
        String realname = cuser.getRealname().trim();
        String username = cuser.getUsername().trim();
        String email = cuser.getEmail().trim();
        String gender = cuser.getGender().trim();
        String tel = cuser.getTel().trim();
        String department = cuser.getDepartment();
        String sno = cuser.getSno().trim();
        String major = cuser.getMajor().trim();
        String sign = cuser.getSign().trim().trim();

        int serverPort = request.getServerPort();
        String serverName = request.getServerName();
        String path = request.getSession().getServletContext().getContextPath();
        String url ="http://"+serverName+":"+serverPort+path+"/view/user?id="+username;
        String uurl = "http://" + serverName + ":" + serverPort + path ;

        cuser.setSign(sign);
        cuser.setUserUrl(url);
//        System.out.println("update 的user" + cuser);
        //后端判断图像是否更新，因为无论选没选泽file，都是存在的。无法根据数据库对比，名称每次都会更改
        String image_file = request.getParameter("image_file");
        System.err.println(image_file);
        if(!image_file.equals("noexist") ){
            //获取原来的文件名称
            Head_portrait head_portrait = new Head_portrait();
            System.err.println("进入删除");
//        String filename = file.getOriginalFilename();
//        String dir = request.getServletContext().getRealPath("/resource/static/head_portrait/");
//        String pathRoot = request.getSession().getServletContext().getRealPath("");
//        String uuid = UUID.randomUUID().toString().replaceAll("-","");
//        String imageName=file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
//        String path2="/resource/static/head_portrait/" + uuid + "." + imageName;
//        System.out.println("dir==="+dir);
//        System.out.println("pathRoot==="+pathRoot);
            String Furl = fileuploadPath ;
            String directory = "head_portrait";
            String Fresult = HttpRequest.upload(Furl,file,directory);
            ResponseModel rm = JsonUtils.jsonToPojo(Fresult,ResponseModel.class);
            String imageUrl="";
            if(rm.getCode()==0){
                imageUrl = rm.getData().toString();
            }else{
                System.out.println("上传picture有错");
            }
            String imageName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);

            String type = file.getContentType();
//        if (!file.isEmpty()) {
            session.removeAttribute("head_portrait");
            System.out.println("文件开始上传，文件名：" + imageName + "文件大小" + file.getSize());
//            file.transferTo(new File(pathRoot+path2));
//            file.transferTo(newFile);

//            head_portrait.setFileName(uuid);
//            head_portrait.setFileUrl(uurl+path2);

            head_portrait.setFileName(imageName);
            head_portrait.setFileUrl(imageUrl);
            head_portrait.setMimeType(type);
            head_portrait.setRealname(realname);
            System.out.println("head_portrait="+head_portrait);
            if(head_portraitService.checkUsername(head_portrait)== null){
                this.head_portraitService.addHead_portrait(head_portrait);
            }else {
                System.out.println("查找是不是存在这个用户，存在就把原来的删除，只能存一张照片");
                String Usedurl = head_portraitService.getHead_portrait(realname);
                if(Usedurl!=null){
                    this.head_portraitService.deleteHead_portrait(head_portrait);
                    //得到原来的头像路径：
                    delete(Usedurl);
                }

                this.head_portraitService.addHead_portrait(head_portrait);
            }
            System.out.println("文件上传成功");
            session.setAttribute("head_portrait",head_portrait);
            session.setAttribute("picUrl",imageName);
//        }
        }


            //用户自己修改，和后台管理员修改分开写
            this.allUserService.updateByUsername(cuser);
            CUSER cuserList = allUserService.QueryUserByrealname(realname);
//        try {
//
//            result.setSuccess(true);
//        } catch (Exception var4) {
//            var4.printStackTrace();
//            result.setSuccess(false);
//        }
//        return result;
//    }

        session.setAttribute("user",cuserList);
        return "redirect:/user/home";
    }

}
