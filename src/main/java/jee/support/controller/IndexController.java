package jee.support.controller;

import com.github.pagehelper.PageInfo;
import jee.support.entity.*;
import jee.support.service.CUserService;
import jee.support.service.PublicService;
import jee.support.service.TimingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 主页   反馈信息最多最复杂   加载的部分
 * */
@RequestMapping("/index")
@Controller
public class IndexController {
    @Autowired
    CUserService cuserService;
    @Autowired
    PublicService publicService;
    @Autowired
    TimingService timingService;

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
    //设置系统主页
    @RequestMapping(value = {"","/","shudu_main"})
    public String index(@RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "size", defaultValue = "11") int size,
                        Model model, HttpSession session) {
        //TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!定时发送时间验证
        String time = getNowTime();
        int sum = timingService.updatestatus(time.substring(0,16));
        List<Timing> activityList = new ArrayList<>();
        List<Timing> articleList = new ArrayList<>();
        //存取主页文章图片，在轮播表中存放
        List<Object> picUrl = new ArrayList<>();
        List<Object> picUrl2 = new ArrayList<>();

        List<Carousel> carousel = new ArrayList<>();
        List<Carousel> carousel2 = new ArrayList<>();


        Timing Tactivity =null;
        Timing Tarticle =null;
        if(sum==0){
            System.out.println(sum+"没有需要发布的内容");
        }else{
            //如果有修改的条数，表示有些内容已经到发布时间，所以把这些内容拿出来 status=1
            List<Timing> timings = GetAllStatusFromTiming();
//            System.out.println(sum+"需要发布的内容");
            int oid=0;
            String type;
            for(Timing t:timings){
                oid = t.getOid();
                type = "activity";
                String ttpey =t.getType();
                updatestatusBytype(oid,type);
                if(ttpey.equals("activity")){
                    Tactivity = GettimeByoid(oid,type);
                    activityList.add(Tactivity);
                    //把所有的轮播加入list表，因为aid是乱的，url要重新排序
//                    Carousel carouselpic = publicService.queryCarouselPicurlByAid(oid);
//                    carousel.add(carouselpic);
//                    if(carouselpic==null){
//                        carousel.add(null);
//                    }else{
//                        carousel.add(carouselpic);
//                    }
                }
            }
            for(Timing t:timings){
                oid = t.getOid();
                type = "article";
                String ttpey =t.getType();
                updatestatusBytype(oid,type);
                if(ttpey.equals("article")){
                    Tarticle = GettimeByoid(oid,type);
                    articleList.add(Tarticle);
//                    Carousel carouselpic = publicService.queryCarouselPicurlByAid(oid);
//                    if(carouselpic==null){
//                        carousel2.add(null);
//                    }else{
//                        carousel2.add(carouselpic);
//                    }

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
        PageInfo<Activity> pageInfo = publicService.getActivityIndex(page,size);
        PageInfo<Article> articlepageInfo = publicService.getArticleIndex(page,size);
//        System.out.println("articlepageInfo"+articlepageInfo);

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
            String content = a.getContent();
            //使用String的replaceAll方法将标签去掉，注意里面的参数
            content=content.replaceAll("<[.[^<]]*>", "");
            if(content.length()>150){
                content = content.substring(0,150);
                content +="........";
            }
            a.setContent(content);
            String url = publicService.queryCarouselPicurlByAid2(aid);
            if(url!=null){
                picUrl2.add(url);
            }else{
                picUrl2.add(null);
            }
        }
        articlepageInfo.setList(articleList1);

        for(Activity a :activityList1){
            int aid = a.getId();
            String content = a.getContent();
            for(Timing t:activityList){
                int oid = t.getOid();
                if(oid == aid){
                    String realtime = t.getTime();
                    a.setTime(realtime);
                }
            }
            //使用String的replaceAll方法将标签去掉，注意里面的参数
            content=content.replaceAll("<[.[^<]]*>", "");
            if(content.length()>150){
                content = content.substring(0,150);
                content +="........";
            }
            a.setContent(content);
            String url = publicService.queryCarouselPicurlByAid2(aid);
            if(url!=null){
                picUrl.add(url);
            }else{
                picUrl.add(null);
            }

        }
        pageInfo.setList(activityList1);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("articlepageInfo", articlepageInfo);
        model.addAttribute("activityList",activityList);
        model.addAttribute("articleList",articleList);
        model.addAttribute("paurl",picUrl); //activity
        model.addAttribute("paurl2",picUrl2); //article
        model.addAttribute("carouselactivity",carousel); //activity
        model.addAttribute("carouselarticle",carousel2); //article

        System.err.println(picUrl);
        System.err.println(picUrl2);

        model.addAttribute("zhoubianList",newList);
//        return "index_main";
        return "index_mainauto";
    }




    //首页显示的时间是定时的时间，而不是编辑的时间
    public Timing GettimeByoid(int id,String type){
        Timing timingList = timingService.gettimeByoid(id,type);
        return timingList;
    }


    //单独写一个方法 更新timing表和相对应表的status=1  表明已经发布
    public void updatestatusBytype(int oid,String type){
        switch (type){
            case "activity":
//                System.out.println("执行 activity 方法 来修改statues");
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


    //前往 社团文章页面
    @RequestMapping(value = {"/activity"})
    public String GotoActivityIndex() {
        return "View/activity";
    }

    //TODO 暂时没有完善逻辑
    @ResponseBody
    @RequestMapping(value = {"/find_usernameByintegral"}, method = RequestMethod.GET)
    public List<CUSER> find_usernameByintegral(){
//        System.out.println("Main 进find_usernameByintegral");
        List<CUSER> list = cuserService.find_usernameByintegral();
        if(list==null){
            System.out.println("当前没有排名");
        }
        return list;
    }



    @ResponseBody
    @RequestMapping(value = {"/integralByGid"}, method = RequestMethod.GET)
    public List<CUSER> integralByGid(Integer gid){
//        System.out.println("Main integralByGid");
        List<CUSER> list = cuserService.integralByGid(gid);
        if(list==null){
            System.out.println("当前没有排名");
        }
        return list;
    }

    //加载公告信息 getNoticeinfo
    @ResponseBody
    @RequestMapping(value = {"/getNoticeinfo"},method = RequestMethod.GET)
    public List<Announcement> getNoticeinfo(){
        String time = getNowTime();
        int sum = timingService.updatestatus(time.substring(0,16));
        if(sum==0){
//            System.out.println(sum+"没有需要发布的内容");
        }else{
            //如果有修改的条数，表示有些内容已经到发布时间，所以把这些内容拿出来 status=1
            List<Timing> timings = GetAllStatusFromTiming();
            int oid=0;
            String type;
            for(Timing t:timings){
                oid = t.getOid();
                type = "notice";
                updatestatusBytype(oid,type);
                publicService.updateNoticestatusByoid(oid);
            }
        }
        List<Notice> notices=publicService.GetNotice();
//        System.out.println("notcies"+notices);
        /**
         * 取出来是正序，123 nid。根据正序查询
         * */
        if(notices.isEmpty()){
            System.out.println("当前没有公告");
            return null;
        }
        List<Announcement> announcements= new ArrayList<>();
        int aid=0;
        for(Notice notice :notices){
            aid=notice.getAid();
//            System.out.println("aid="+aid);
            announcements.add(GetNotice(aid));
        }
        System.err.println(announcements);
        return announcements;
    }

    private Announcement GetNotice(int aid){
        return publicService.GetNoticeByAid(aid);
    }


    @RequestMapping(value = {"/connection"})
    public String connection() {
        return "connection";
    }


    //对轮播位置进行排序
    void oderCarousel(List<Carousel> List,int flag,Activity activity,Article article){
        int aid=0;
        int status=0;
        if(flag==0){
            status = activity.getStatus();
            if(status==1){
                aid=activity.getId();
                List.add(QueryCarouselByid(aid));
            }
        }else{
            status=article.getStatus();
            if(status==1){
                aid=article.getId();
                List.add(QueryCarouselByid(aid));
            }
        }
    }

    //加载轮播部分
    @ResponseBody
    @RequestMapping("/carousel")
    public List<Carousel> Indexcarousel(){
//        System.out.println("进入主页轮播 映射");
        /**
         * 根据时间倒叙取之前三个轮播表内容，虽然取之出来排序的是在轮播表
         * 并不知道得到的aid是activity还是article，这就导致在合并为一个list表顺序不一致
         * */
        List<Carousel> carousels=publicService.QueryAllCarousel();
        List<Carousel> List = new ArrayList<>();

        Activity activity =new Activity();
        Article article =new Article();
        int status=0;
        int i=0;
        int flag =0;
        for(Carousel carousel :carousels){
            i++;
            int id = carousel.getAid();
            if(QueryActivityStatusByid(id)!=null){
                activity=QueryActivityStatusByid(id);
                flag=0;
            }else{
                article=QueryArticleStatusByid(id);
                flag=1;
            }if(article==null){
                continue;
            }if(activity==null){
                continue;
            }
            oderCarousel(List,flag,activity,article);

        }

//        int aid=0;
//        for(Activity activity1 : activity){
//            if(activity1==null){
//                System.out.println("此轮播暂时为到时间");
//                continue;
//            }
//            status=activity1.getStatus();
//            if(status==1){
//                aid = activity1.getId();
//                List.add(QueryCarouselByid(aid));
//            }else if(status==0) {
//                System.err.println("没有进入 status==0");
//            }else {
//                System.err.println("错误！！！！！！！！！！！！！！");
//            }
//        }
//        for(Article article1 : article){
//            if(article1==null){
//                System.out.println("此轮播暂时为到时间");
//                continue;
//            }
//            status=article1.getStatus();
//            if(status==1){
//                aid = article1.getId();
//                List.add(QueryCarouselByid(aid));
//            }else if(status==0) {
////                System.err.println("没有进入 status==0");
//            }else {
//                System.err.println("错误！！！！！！！！！！！！！！");
//            }
//        }

        return List;
    }


    //单独写3个方法 根据aid字段获取轮播表信息，根据轮播表的aid得到是活动还是文章。
    public Carousel QueryCarouselByid(int aid){
        return publicService.QueryCarouselByid(aid);
    }
    public Activity QueryActivityStatusByid(int id){
        return publicService.getActivityStatusByid(id);
    }
    public Article QueryArticleStatusByid(int id){
        return publicService.getArticleStatusByid(id);
    }


    //数独排名
    @ResponseBody
    @RequestMapping(value = "/suduko/querysome" ,method = RequestMethod.POST)
    public Object querysomeSuduko(){
        AJAXResult result = new AJAXResult();
//        System.out.println("suduko 主页请求");
        //TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!定时发送时间验证
        String time = getNowTime();
//        System.out.println("现在时间是："+time.substring(0,16));
        int sum = timingService.updatestatus(time.substring(0,16));
        if(sum==0){
//            System.out.println(sum+"没有需要发布的内容");
        }else{
            //如果有修改的条数，表示有些内容已经到发布时间，所以把这些内容拿出来 status=1
            List<Timing> timings = GetAllStatusFromTiming();
            int oid=0;
            String type;
            for(Timing t:timings){
                oid = t.getOid();
                type = "suduko";
                updatestatusBytype(oid,type);
            }
        }
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", 0);
            map.put("size", 10);
            List<Suduko> sudukos = this.publicService.pageQuerySudukoIndexDataBy10(map);
            int totalno = 0;
            Page<Suduko> sudukoPage = new Page();
            sudukoPage.setDatas(sudukos);
            sudukoPage.setTotalno(totalno);
            sudukoPage.setTotalsize(10);
            sudukoPage.setPageno(0);
            result.setData(sudukoPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/suduko")
    public String GotoSuduindex(){
        return "/View/sudukoindex";
    }
    @ResponseBody
    @RequestMapping(value = "/suduko/queryAll" ,method = RequestMethod.POST)
    public Object queryAllSuduko(String queryText, Integer pageno, Integer pagesize){
        AJAXResult result = new AJAXResult();
//        System.out.println("suduko 主页请求");
        String time = getNowTime();
        int sum = timingService.updatestatus(time.substring(0,16));
        if(sum==0){
//            System.out.println(sum+"没有需要发布的内容");
        }else{
            //如果有修改的条数，表示有些内容已经到发布时间，所以把这些内容拿出来 status=1
            List<Timing> timings = GetAllStatusFromTiming();
            System.out.println(sum+"suduko需要发布的内容");
            int oid=0;
            String type;
            for(Timing t:timings){
                oid = t.getOid();
                type = "suduko";
                updatestatusBytype(oid,type);
            }
        }
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<Suduko> sudukos = this.publicService.pageQuerySudukoIndexData(map);
            int totalsize = this.publicService.pageQuerySudukoCountIndex(map);
            int totalno = 0;

            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<Suduko> sudukoPage = new Page();
            sudukoPage.setDatas(sudukos);
            sudukoPage.setTotalno(totalno);
            sudukoPage.setTotalsize(totalsize);
            sudukoPage.setPageno(pageno);
            result.setData(sudukoPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 社团周边的替换显示
     */

    @ResponseBody
    @RequestMapping("/zhoubian")
    public String GotoShowzhoubian(Model model){

        return "ok";
    }



    //数独文章  link
    @RequestMapping("/standard")
    public String GotoStandardshudu(@RequestParam(value = "page", defaultValue = "1") int page,
                                    @RequestParam(value = "size", defaultValue = "6") int size,
                                    Model model){
        String type = "标准";
        List<Timing> articleTime = publicService.getArticleByStandard(type);
        PageInfo<Article> pageInfo = publicService.getArticleIndex(page,size);

//        System.out.println("??=========="+pageInfo);
        List<Article> articleList = publicService.pageQueryArticleDataBytype(type);
//        List<Article> aaa = new ArrayList<>();
        List<Article> articleList1 =pageInfo.getList();
        for(Article article :articleList1){
            String content = article.getContent();
            //使用String的replaceAll方法将标签去掉，注意里面的参数
            content=content.replaceAll("<[.[^<]]*>", "");
            if(content.length()>40){
                content = content.substring(0,40);
                content +="........";
            }
            article.setContent(content);
            int id = article.getId();
            for(Timing t :articleTime){
                int oid = t.getOid();
                if(oid==id){
                    String realtime = t.getTime();
                    article.setTime(realtime);
                }
            }
        }
        pageInfo.setList(articleList1);
        model.addAttribute("articleList",articleList);
        model.addAttribute("articleTime",articleTime);
        model.addAttribute("pageInfo",pageInfo);
        return "/View/particlesindex";
    }

    //主页文章列表
    @RequestMapping("/deformation")
    public String GotFormationhudu(Model model){
        String type = "变形";
        List<Article> articleList = publicService.pageQueryArticleDataBytype(type);
//        int len = publicService.pageQueryArticleCountBytype(type);
        List<Timing> articleTime = publicService.getArticleByStandard(type);
        int len = articleList.size();
        model.addAttribute("articleList",articleList);
        model.addAttribute("articlelen",len);
//        System.out.println("articleTime"+articleTime);

        return "/View/deformationindex";
    }
}
