package jee.support.controller;

import jee.support.dao.AdministratorDao;
import jee.support.entity.*;
import jee.support.service.AdministratorService;
import jee.support.service.CUserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = {"/clubinformation"})
public class ClubInformationController {
    @Autowired
    private CUserService cUserService;
    @Autowired
    AdministratorService administratorService;

    //基本资料
    @RequestMapping(value = {"/basicinformation"},method = RequestMethod.GET)
    public String GotoBasicinformation(Model model){
        System.out.println("进入basicinformation");
        model.addAttribute("information",1);
        return "ClubInformation/basicInformation";
    }
    //组织章程
    @RequestMapping(value = {"/constitution"} ,method = RequestMethod.GET)
    public String GotoConstitution(Model model){
        System.out.println("进入constitution");
        model.addAttribute("information",2);
        return "ClubInformation/constitution";
    }
    //会员列表，TODO 这个需要从数据库中导入
    @RequestMapping(value = {"/memberlist"},method = RequestMethod.GET)
    public String GotoMemberlist(Model model){
        System.out.println("进入memberlist");
        model.addAttribute("information",4);
        return "ClubInformation/memberlist";
    }

    //TODO 这个需要从数据库中导入
    @ResponseBody
    @RequestMapping(value = "/find_memberlist",method = RequestMethod.POST)
    public Object find_memberlist(  Integer pageno, Integer pagesize,Integer sid ){
        AJAXResult result = new AJAXResult();
        System.out.println("id=="+sid);
        Map<String, Object> map = new HashMap();
        map.put("start", (pageno - 1) * pagesize);
        map.put("size", pagesize);
        map.put("id",sid);
        List<CUSER> users = this.cUserService.pageQueryDatatBysid(map);
        int totalsize = this.cUserService.pageQueryCountBysid(map);
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

        System.out.println("result  =="+result);
        return result;
    }


    //入会申请
    @RequestMapping(value = {"/applymembership"},method = RequestMethod.GET)
    public String GotoApplymembership(Model model){
        System.out.println("进入applymembership");
        model.addAttribute("information",5);
        return "ClubInformation/applymembership";
    }


    //动态导出现任会干
    @ResponseBody
    @RequestMapping(value = "/find_basicinformation",method = RequestMethod.POST)
    public List<administrator> constitution( @RequestBody  String sid ,Model model ){
        JSONObject json = JSONObject.fromObject(sid);
//        System.out.println("sid=="+sid);
        int id =  Integer.parseInt(json.getString("sid"));
//        System.out.println("id=="+id);
        List<administrator> admini = administratorService.findAll(id);
//        System.out.println("admini  =="+admini);
        model.addAttribute("administrator",admini);
        return admini;
    }


    //各部门职能
    @RequestMapping(value = {"/functions"},method = RequestMethod.GET)
    public String GotoFunction(Model model){
        System.out.println("进入functions");
        //得到所有会干信息，在adminphoto表中查询，因为要头像显示
        List<AdminPhoto> adminPhotos = administratorService.getAllPUser();
        model.addAttribute("adminPhotos",adminPhotos);
        model.addAttribute("information",3);
        return "ClubInformation/functions";
    }
}
