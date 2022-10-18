package jee.support.controller;
import jee.support.entity.*;
import jee.support.service.AdministratorService;
import jee.support.service.CUserService;
import jee.support.service.RoleService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping({"/admin"})
public class AdminController {

    @Autowired
    AdministratorService administratorService;

    @Autowired
    private CUserService cUserService;
    @Autowired
    RoleService roleService;

    @Resource(name="fileuploadPath")
    private String fileuploadPath;

//    redirect:
    @RequestMapping(value = {"/"})
    public String admin(){
        return "admin/admin";
    }

    @RequestMapping({"/add"})
    public String add() {
        return "admin/add";
    }


    /**
     * admin目录下的add.jsp   此功能删除
     * */
    @ResponseBody
    @RequestMapping(value = {"/insert"} )
    public Object insert(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
//        System.out.println(massage);
        JSONObject json = JSONObject.fromObject(massage);
        String realname = json.getString("realname");
        String position = json.getString("position");
        int id = Integer.parseInt(json.getString("id"));
        String gender = json.getString("gender");
        String department = json.getString("department");
        String sno = json.getString("sno");
        String major = json.getString("major");
        int grade = json.getInt("grade");
        int sid=roleService.findnameByposition(position);
        try {
            administrator admin = new administrator();
            admin.setDepartment(department);
            admin.setGender(gender);
            admin.setGrade(grade);
            admin.setId(id);
            admin.setMajor(major);
            admin.setPosition(position);
            admin.setRealname(realname);
            admin.setSno(sno);
            admin.setSid(sid);
//            System.out.println("insert"+admin);
            this.administratorService.insertAdmin(admin);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    /**
     * admin目录下的edit.jsp   此功能删除
     * */
    @RequestMapping({"/edit"})
    public String edit(@RequestParam("id") String id , Model model) {
//        System.out.println("id"+id);
        administrator auser = new administrator();
        AdminPhoto adminPhoto = new AdminPhoto();
        //进入编辑,获取信息
        auser = administratorService.getauser(id);

        adminPhoto = administratorService.getPuser(auser);
        model.addAttribute("auser",auser);
        model.addAttribute("adminPhoto",adminPhoto);

        return "admin/edit";
    }

    /**
     * admin目录下的edit.jsp   此功能删除
     * */
    @RequestMapping({"/update"})
    public Object update(@RequestParam("file") MultipartFile file,administrator admin) throws Exception {
        System.err.println(admin);
        String sno =admin.getSno();
        String realname = admin.getRealname();
        String position = admin.getPosition();
        int sid = admin.getSid();
        int gid = admin.getId();  //TODO 这是第几届的会干！！！维护很重要
        AdminPhoto adminPhoto = new AdminPhoto();

        //检查原来是否有图片，把原来的删除
        AdminPhoto adminPhoto1 =administratorService.CheckAdminPhotoBySno(adminPhoto);
        if(adminPhoto1!=null){
            administratorService.DeleteAdminPhotoBySno(adminPhoto);
        }else{
            String Furl = fileuploadPath ;
            String directory = "adminphoto";
            String Fresult = HttpRequest.upload(Furl,file,directory);
            ResponseModel rm = JsonUtils.jsonToPojo(Fresult,ResponseModel.class);
            String imageUrl="";
            if(rm.getCode()==0){
                imageUrl = rm.getData().toString();
            }else{
                System.out.println("上传有错");
            }
            String imageName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
            String type = file.getContentType();
            System.out.println("文件开始上传，文件名：" + imageName + "文件大小" + file.getSize());
            adminPhoto.setFileName(imageName);
            adminPhoto.setFileUrl(imageUrl);
            adminPhoto.setMimeType(type);
            adminPhoto.setRealname(realname);
            adminPhoto.setSno(sno);
            adminPhoto.setPosition(position);
            adminPhoto.setSid(sid);
            adminPhoto.setId(gid);
            administratorService.addAdminPhoto(adminPhoto);
        }
        String id = admin.getRealname();
        return "redirect:/admin/edit?id="+id;
    }



//    @ResponseBody
//    @RequestMapping({"/update"})
//    public Object update(@RequestBody String massage) {
//        AJAXResult result = new AJAXResult();
//        JSONObject json = JSONObject.fromObject(massage);
//        String realname = json.getString("realname");
//        String position = json.getString("position");
//        int id = Integer.parseInt(json.getString("id"));
//        String gender = json.getString("gender");
//        String department = json.getString("department");
//        String sno = json.getString("sno");
//        String major = json.getString("major");
//        int grade = json.getInt("grade");
//        int sid=roleService.findnameByposition(position);
////        System.out.println(massage);
//
//        try {
//            administrator admin = new administrator();
//            admin.setDepartment(department);
//            admin.setGender(gender);
//            admin.setGrade(grade);
//            admin.setId(id);
//            admin.setMajor(major);
//            admin.setPosition(position);
//            admin.setRealname(realname);
//            admin.setSno(sno);
//            admin.setSid(sid);
//            CUSER cuser = new CUSER();
//            cuser.setGrade(grade);
//            cuser.setGender(gender);
//            cuser.setSno(sno);
//            cuser.setDepartment(department);
//            cuser.setId(id);
//            cuser.setRealname(realname);
//            this.administratorService.updateAdmin(admin);
//            this.cUserService.updateUserByrealname(cuser);
//            result.setSuccess(true);
//        } catch (Exception var4) {
//            var4.printStackTrace();
//            result.setSuccess(false);
//        }
//        return result;
//    }



    //TODO 暂时没有完成删除后权限降级
    @ResponseBody
    @RequestMapping({"/delete"})
    public Object delete(String realname) {
        AJAXResult result = new AJAXResult();
        try {
            this.administratorService.deleteUserByRealname(realname);
            this.administratorService.deleteUserByRealnameRole_user(realname);
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
    public Object deletes(@RequestBody String [] realname) {
        AJAXResult result = new AJAXResult();

        System.out.println("realname"+realname);
        try {
            Map<String, Object> map = new HashMap();
            map.put("realnames", realname);
            this.administratorService.deleteUsers(map);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }
}
