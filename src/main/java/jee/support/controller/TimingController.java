package jee.support.controller;

import jee.support.dao.TimingDao;
import jee.support.entity.*;
import jee.support.service.PublicService;
import jee.support.service.TimingService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;


/**
 * 定时发送
 * */
@Controller
@RequestMapping("/timing")
public class TimingController {

    @Autowired
    PublicService publicService;
    @Autowired
    TimingService timingService;

    @RequestMapping("/index")
    public String index(){
        return "/public/timing/index";
    }

    @RequestMapping("/activity")
    public String GototimingActivity(@RequestParam("id") int id, Model model) {
//        System.out.println("GototimingActivity id" + id);
        HashMap<String, Object> activities = new HashMap<String, Object>();
        activities = publicService.QueryActivity(id);
        HashMap<String,Object> timings = new HashMap<String, Object>();
        timings = timingService.QueryTimingById(id);
        if(timings!=null){
            String Ttime = (String)timings.get("time");
            int Tid = (int)timings.get("id");
            int Tstatus =  (int)timings.get("status");
            String Toptime = (String)timings.get("optime");
            String Ttype = (String)timings.get("type");
            Timing timing = new Timing();
            timing.setTime(Ttime);
            timing.setOptime(Toptime);
            timing.setType(Ttype);
            timing.setStatus(Tstatus);
            timing.setId(Tid);
            model.addAttribute("timing",timing);
        }

        String name = (String)activities.get("name");
        String time =  (String)activities.get("time");
        String title =  (String)activities.get("title");
        String content =  (String)activities.get("content");
        int status = (int) activities.get("status");

//        System.out.println("name" + name);
//        System.out.println("time" + time);
//        System.out.println("title" + title);
//        System.out.println("content" + content);
        Activity activity = new Activity();
        activity.setTitle(title);
        activity.setId(id);
        activity.setTime(time);
        activity.setContent(content);
        activity.setName(name);
        activity.setStatus(status);
        model.addAttribute("activity",activity);
        return "/public/timing/activitytiming";
    }

    @ResponseBody
    @RequestMapping(value = "/activity/upload",method = RequestMethod.POST)
    public Object uploadactivitytiming(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        int aid = Integer.parseInt(json.getString("aid"));
        String title = json.getString("title");
        String date = json.getString("date");
        String username = json.getString("username");
        String type="activity";

        HashMap<String, Object> activities = new HashMap<String, Object>();
        activities = publicService.QueryActivity(aid);
        //TODO  这里是后期添加的定时发送时间
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        try {
            Timing timing = new Timing();
            timing.setId(id);
            timing.setOid(aid);
            timing.setStatus(0);
            timing.setType(type);
            timing.setOptime(time);
            timing.setTime(date);
            timingService.inserttiming(timing);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }


    //修改发表时间  应该删除timing 表内容  其次是要更改 activity表的status =0
    @ResponseBody
    @RequestMapping(value = "/activity/edit",method = RequestMethod.POST)
    public Object updateactivitytiming(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        int aid = Integer.parseInt(json.getString("aid"));
        String title = json.getString("title");
        String date = json.getString("date");
        String username = json.getString("username");
        String type="activity";

        int num =timingService.deleteBeforeByOid(aid,type);
        if(num==0){
            System.out.println("当前timing表没有该数据");
        }

//        publicService.updatestatusActivityByoid(aid);

        //TODO  这里是后期添加的定时发送时间
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        try {
            Timing timing = new Timing();
            timing.setId(id);
            timing.setOid(aid);
            timing.setStatus(0);
            timing.setType(type);
            timing.setOptime(time);
            timing.setTime(date);
            timingService.inserttiming(timing);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
/////////////////////////////////////////////////////TODO 这里是对文章 的操作

    @RequestMapping("/article")
    public String GototimingArticle(@RequestParam("id") int id, Model model) {
        System.out.println("GototimingArticle id" + id);
        HashMap<String, Object> articles = new HashMap<String, Object>();
        articles = publicService.QueryArticles(id);
        HashMap<String,Object> timings = new HashMap<String, Object>();
        timings = timingService.QueryTimingById(id);
        if(timings!=null){
            String Ttime = (String)timings.get("time");
            int Tid = (int)timings.get("id");
            int Tstatus =  (int)timings.get("status");
            String Toptime = (String)timings.get("optime");
            String Ttype = (String)timings.get("type");
            Timing timing = new Timing();
            timing.setTime(Ttime);
            timing.setOptime(Toptime);
            timing.setType(Ttype);
            timing.setStatus(Tstatus);
            timing.setId(Tid);
            model.addAttribute("timing",timing);
        }

//        System.out.println("aaaaaa" + articles);
        String name = (String)articles.get("name");
        String time =  (String)articles.get("time");
        String title =  (String)articles.get("title");
        String content =  (String)articles.get("content");
        int status = (int) articles.get("status");


        Article article = new Article();
        article.setTitle(title);
        article.setId(id);
        article.setTime(time);
        article.setContent(content);
        article.setName(name);
        article.setStatus(status);
        model.addAttribute("article",article);
        return "/public/timing/articletiming";
    }

    @ResponseBody
    @RequestMapping(value = "/article/upload",method = RequestMethod.POST)
    public Object uploadarticletiming(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        int aid = Integer.parseInt(json.getString("aid"));
        String title = json.getString("title");
        String date = json.getString("date");
        String username = json.getString("username");
        String type="article";

        HashMap<String, Object> activities = new HashMap<String, Object>();
        activities = publicService.QueryArticle(aid);
        //TODO  这里是后期添加的定时发送时间
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        try {
            Timing timing = new Timing();
            timing.setId(id);
            timing.setOid(aid);
            timing.setStatus(0);
            timing.setType(type);
            timing.setOptime(time);
            timing.setTime(date);
            timingService.inserttiming(timing);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }


    //修改发表时间  应该删除timing 表内容  其次是要更改 article =0
    @ResponseBody
    @RequestMapping(value = "/article/edit",method = RequestMethod.POST)
    public Object updatearticletiming(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        int aid = Integer.parseInt(json.getString("aid"));
        String title = json.getString("title");
        String date = json.getString("date");
        String username = json.getString("username");
        String type="article";
        int num =timingService.deleteBeforeByOid(aid,type);
        if(num==0){
            System.out.println("当前timing表没有该数据");
        }
        //TODO  这里是后期添加的定时发送时间
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        try {
            Timing timing = new Timing();
            timing.setId(id);
            timing.setOid(aid);
            timing.setStatus(0);
            timing.setType(type);
            timing.setOptime(time);
            timing.setTime(date);
            timingService.inserttiming(timing);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

}
