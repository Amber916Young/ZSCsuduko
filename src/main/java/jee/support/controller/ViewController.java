package jee.support.controller;

import com.github.pagehelper.PageInfo;
import jee.support.entity.*;
import jee.support.service.*;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 类似于预览界面  只不过此处控制器是 正式发表的内容。
 * 包括活动，文章，下方评论显示，用户头像获取
 **/
@RequestMapping("/view")
@Controller
public class ViewController {
    @Autowired
    PublicService publicService;
    @Autowired
    CommentService commentService;
    @Autowired
    CUserService cUserService;
    @Autowired
    Head_portraitService head_portraitService;
    @Autowired
    UserScoreService userScoreService;
    @Autowired
    AllUserService allUserService;

    @Autowired
    TimingService timingService;

    @ResponseBody
    @RequestMapping(value = "/activity/queryAll" ,method = RequestMethod.POST)
    public Object queryAllActivity(String queryText, Integer pageno, Integer pagesize){
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<Activity> activities = this.publicService.pageQueryActivityDataBystatue1(map);
            int totalsize = this.publicService.pageQueryActivityCountBystatue1(map);
            int totalno = 0;
            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<Activity> activityPage = new Page();
            activityPage.setDatas(activities);
            activityPage.setTotalno(totalno);
            activityPage.setTotalsize(totalsize);
            activityPage.setPageno(pageno);
            result.setData(activityPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    void GetActivityandArticle(Model model){
        List<Timing> activityList = new ArrayList<>();
        List<Timing> articleList = new ArrayList<>();
        PageInfo<Activity> pageInfo = publicService.getActivityIndex(1,5);
        PageInfo<Article> articlepageInfo = publicService.getArticleIndex(1,5);
        List<Article> articleList1 =articlepageInfo.getList();
        List<Activity> activityList1 =pageInfo.getList();
        //TODO 取出 的文章表，和时间表，oid和id进行对比，对比成功之后替换正确的发布时间，而并非编辑时间
        for(Article a :articleList1){
            int aid = a.getId();
            for(Timing t:articleList){
                int oid = t.getOid();
                if(oid==aid){
                    String realtime = t.getTime();
                    a.setTime(realtime);
                }
            }
        }
        articlepageInfo.setList(articleList1);
        for(Activity a :activityList1){
            int aid = a.getId();
            for(Timing t:activityList){
                int oid = t.getOid();
                if(oid==aid){
                    String realtime = t.getTime();
                    a.setTime(realtime);
                }
            }
        }
//周边部分更新
        List<Zhoubian> zhoubianList = publicService.Queryzhoubian();
        List<Zhoubian> newList = new ArrayList<>();
//        System.out.println(zhoubianList);
        if(zhoubianList.size()>5){
            newList = zhoubianList.subList(0, 5);
        }else{
            newList=zhoubianList;
        }
        pageInfo.setList(activityList1);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("articlepageInfo", articlepageInfo);
        model.addAttribute("activityList",activityList);
        model.addAttribute("articleList",articleList);
        model.addAttribute("zhoubianList",newList);

    }

    @RequestMapping("/activity")
    public String GotoViewActivity(@RequestParam("id") int id, Model model) {
//        System.out.println("GotoViewActivity id" + id);
        HashMap<String, Object> activities = new HashMap<String, Object>();
        activities = publicService.QueryActivity(id);
        int allcomments=commentService.pageQueryCommentCount(id);
        if(allcomments==0){
            model.addAttribute("allcomments",0);
        }
        String name = (String)activities.get("name");
        String time = (String)activities.get("time");
        String title = (String)activities.get("title");
        String content = (String)activities.get("content");
        int status = (int)activities.get("status");
        String url = (String)activities.get("url");


        Activity activity = new Activity();
        activity.setTitle(title);
        activity.setId(id);
        activity.setTime(time);
        activity.setContent(content);
        activity.setName(name);
        activity.setStatus(status);
        activity.setUrl(url);
        model.addAttribute("allcomments",allcomments);
        model.addAttribute("activity",activity);
        GetActivityandArticle(model);
        return "View/article";
    }


//    获取
    @RequestMapping("/suduko")
    public String GotoViewSuduko(@RequestParam("id") int id, Model model) {
        HashMap<String,Object> shudu= publicService.GetSudukoByid(id);
        SudukoImg sudukoImg = publicService.GetSudukoImgByid(id);
//        UserScore userScore = publicService.GetuserScoreByid(id);
        if(sudukoImg!=null){
            model.addAttribute("sudukoImg",sudukoImg);
        }
        String num = (String) shudu.get("num");
        String type = (String)shudu.get("type");
        String difficulty_level =(String) shudu.get("difficulty_level");
        //string===>int
        int score = (int)shudu.get("score");
        String time = (String)shudu.get("time");
        Suduko suduko = new Suduko();
        suduko.setId(id);
        suduko.setType(type);
        suduko.setScore(score);
        suduko.setTime(time);
        suduko.setNum(num);
        suduko.setDifficulty_level(difficulty_level);
        String  typpe="suduko";
        Timing timing = timingService.gettimeByoid(id,typpe);
//        System.out.println("ttttt"+timing);
        model.addAttribute("suduko",suduko);
        model.addAttribute("timingsuduko",timing);

        String answer = userScoreService.getSudukoAnswerByid(id);
        String useranswer = userScoreService.getUserAnswerByid(id);
//        System.out.println("useranswer???"+useranswer);
//        System.out.println("aaaaannnnsss??"+answer);
        if(useranswer!=null){
            if(useranswer.equals(answer)){
                model.addAttribute("answer","0");
            }else{
                model.addAttribute("answer",answer);
            }
        }



        return "View/suduko";
    }

    @ResponseBody
    @RequestMapping(value = "/Altercarousel",method = RequestMethod.POST)
    public Object Altercarousel(Integer id,Model model ){
        AJAXResult result = new AJAXResult();
        List<Carousel> carousel=publicService.QueryCarousel(id);
        Carousel b = new Carousel();
        try {
            for (Carousel list : carousel) {
                b.setAid(list.getAid());
                b.setUrl(list.getUrl());
                b.setTitle(list.getTitle());
                b.setTime(list.getTime());
                b.setFilename(list.getFilename());
                b.setId(list.getId());
                b.setAurl(list.getAurl());
//                System.out.println("list" + list);
            }
            model.addAttribute("carousel", b);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    @ResponseBody
    @RequestMapping(value = "/Altercarousel2",method = RequestMethod.POST)
    public Object Altercarousel2(Integer id,Model model ){
        AJAXResult result = new AJAXResult();
        List<Carousel> carousel=publicService.QueryCarousel(id);
//        System.out.println("carousel" + carousel);
        Carousel b = new Carousel();
        try {
            for (Carousel list : carousel) {
                b.setAid(list.getAid());
                b.setUrl(list.getUrl());
                b.setTitle(list.getTitle());
                b.setTime(list.getTime());
                b.setFilename(list.getFilename());
                b.setId(list.getId());
                b.setAurl(list.getAurl());


                System.out.println("list" );
            }
            model.addAttribute("carousel", b);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    //查看别人的信息 ！！！！！！！！！！！！！！！！！！！！！   交互作用
    /**可以看到别人做的题目数量  积分，姓名等信息
     *
     * */
    @RequestMapping("/user")
    public String GotoViewUser(@RequestParam("id") String id, Model model) {
        CUSER user= cUserService.queryByCUsername(id);

        Head_portrait head_portrait= head_portraitService.selectAllmessage(user.getRealname().trim());
//        System.out.println(head_portrait);
        PageInfo<UserScore> pageInfo = allUserService.GetMyAllsuduko(1,4,id);

//        System.out.println("进入GoTosudukoPage pageInfo"+pageInfo);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("viewuser",user);
        model.addAttribute("viewht",head_portrait);
        return "View/user";
    }




    @RequestMapping("/particles")
    public String GotoViewArticle(@RequestParam("id") int id, Model model) {
//        System.out.println("GotoViewArticle id" + id);
        HashMap<String, Object> articles = new HashMap<String, Object>();
        articles = publicService.QueryArticle(id);
        int allcomments=commentService.pageQueryCommentCount(id);
        if(allcomments==0){
            model.addAttribute("allcomments",0);
        }

//        System.out.println("aaaaaa" + articles);
        String name = (String)articles.get("name");
        String time = (String)articles.get("time");
        String title = (String)articles.get("title");
        String content = (String)articles.get("content");
        int status = (int)articles.get("status");
        String url = (String)articles.get("url");
        String type = (String)articles.get("type");
        String typemsg = (String)articles.get("typemsg");
        Article article = new Article();
        article.setTitle(title);
        article.setId(id);
        article.setTime(time);
        article.setContent(content);
        article.setName(name);
        article.setStatus(status);
        article.setUrl(url);
        article.setTypemsg(typemsg);
        article.setType(type);
        model.addAttribute("allcomments",allcomments);
        model.addAttribute("article",article);
        GetActivityandArticle(model);
        return "View/particles";
    }





}
