package jee.support.controller;

import jee.support.constants.Constants;
import jee.support.entity.*;
import jee.support.service.CommentService;
import jee.support.service.PublicService;
import jee.support.service.TimingService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.rmi.server.ExportException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/public")
public class PublicController {

    @Autowired
    public PublicService publicService;
    @Autowired
    public TimingService timingService;
    @Autowired
    private CommentService commentService;
    private WebIndex webIndex = new WebIndex();
    // 文件上传路径
    @Resource(name="fileuploadPath")
    private String fileuploadPath;

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

    //单独写一个方法，根据类型更新状态
    public void UpdateTime(String type){
        //TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!定时发送时间验证
        String time = getNowTime();
        //字符串截取 eg.2019-12-25 14:24
        int sum = timingService.updatestatus(time.substring(0,16));
        if(sum==0){
            System.out.println(sum+"没有需要发布的内容");
        }else{
            //如果有修改的条数，表示有些内容已经到发布时间，所以把这些内容拿出来 status=1
            List<Timing> timings = GetAllStatusFromTiming();
            System.out.println(sum+"  "+type+"需要发布的内容");
            int oid=0;
            for(Timing t:timings){
                oid = t.getOid();
                updatestatusBytype(oid,type);
            }
        }
    }
    //单独写一个方法，根据类型更新状态
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

        }
    }
    //////////////////////////////////////////////////////////////发布活动，类似于推文   预告 和  总结推文  可以附带评论功能
    @RequestMapping("/activity")
    public String GotoActivity(){
        UpdateTime("activity");
        return "public/activity/activity";
    }
    @RequestMapping("/activity/add")
    public String GotoAddActivity(){
        return "public/activity/add";
    }

    //进入edit.jsp 内容应当从preview表中获取  包括活动 ，竞选文章  这个表相当于回收站
    @RequestMapping("/activity/edit")
    public String GotoEditActivity(@RequestParam("id") int id,Model model){

        HashMap<String, Object> previews = publicService.QueryPreviewByaid(id);
        int id1 = (int)previews.get("id");
        int aid = (int)previews.get("aid");

        String title = (String)previews.get("title");
        String content = (String)previews.get("content");
        String url = (String)previews.get("url");
        Preview preview = new Preview();
        preview.setId(id1);
        preview.setUrl(url);
        preview.setContent(content);
        preview.setTitle(title);
        preview.setAid(aid);
        model.addAttribute("preview",previews);
        return "public/activity/edit";
    }
    //修改文章
    @ResponseBody
    @RequestMapping(value = "/activity/editActivity" ,method = RequestMethod.POST)
    public Object EditActivity(@RequestBody String massage, Model model, HttpSession session, HttpServletRequest httpServletRequest){
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        String content = json.getString("content");
        String TitleText = json.getString("TitleText");
        int id = Integer.parseInt(json.getString("id"));

        int status = 0;
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        CUSER loginUser =(CUSER)session.getAttribute("user");
        String realname = loginUser.getRealname();
        int serverPort = httpServletRequest.getServerPort();
        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
        String url ="http://"+serverName+":"+serverPort+path+"/view/activity?id="+id;
        try {
            Activity activity = new Activity();
            activity.setContent(content);
            activity.setName(realname);
            activity.setTime(time);
            activity.setTitle(TitleText);
            activity.setId(id);
            activity.setUrl(url);
            activity.setStatus(status);
            System.out.println(activity);
            publicService.UpdataActivity(activity);
            webIndex.updateIndex(activity);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }


    @ResponseBody
    @RequestMapping(value = "/activity/queryAll" ,method = RequestMethod.POST)
    public Object queryAllActivity(String queryText, Integer pageno, Integer pagesize){
        AJAXResult result = new AJAXResult();

        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<Activity> activities = this.publicService.pageQueryActivityData(map);
            int totalsize = this.publicService.pageQueryActivityCount(map);
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

    //上传文章
    @ResponseBody
    @RequestMapping(value = "/activity/upload" ,method = RequestMethod.POST)
    public Object UploadActivity(@RequestBody String massage, Model model, HttpSession session, HttpServletRequest httpServletRequest){
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        String content = json.getString("content");
        String TitleText = json.getString("TitleText");
        int status = 0;
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
//        System.out.println("massage==" + json);
        CUSER loginUser =(CUSER)session.getAttribute("user");
        String realname = loginUser.getRealname();
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        int id2 = randomNumber.CreateRandomNumber();


        int serverPort = httpServletRequest.getServerPort();

        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
//        System.out.println("path==/support" + path);
        String url ="http://"+serverName+":"+serverPort+path+"/view/activity?id="+id;
        String url2 ="http://"+serverName+":"+serverPort+path+"/preview/activity?id="+id;
//        System.out.println("path==/url" + url);
        try {
            Activity activity = new Activity();
            activity.setContent(content);
            activity.setName(realname);
            activity.setTime(time);
            activity.setTitle(TitleText);
            activity.setId(id);
            activity.setUrl(url);
            activity.setStatus(status);
            publicService.insertActivity(activity);
            webIndex.addIndex(activity);//此处 用于文章检索

            Preview preview = new Preview();
            preview.setAid(id);
            preview.setTitle(TitleText);
            preview.setContent(content);
            preview.setUrl(url2);
            preview.setId(id2);
            publicService.insertPreview(preview);
//            webIndex.updateIndex(activity);

            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/activity/delete"},method = RequestMethod.POST)
    public Object Activitydelete(Integer id) {
        AJAXResult result = new AJAXResult();
        try {
            String type="activity";
            System.out.println("!!!!!!!!!!!!!id"+id);

            int num =timingService.deleteBeforeByOid(id,type);
            if(num==0){
                System.out.println("当前timing表没有该数据");
            }

//            DeleteByoidAndType deleteByoidAndType = new DeleteByoidAndType();
//            deleteByoidAndType.SetData(id,type);
//            if(deleteByoidAndType.DeleteTimingByoidAndType(id,type)==0){
//                System.out.println("当前timing表没有该数据");
//            }

            this.publicService.deleteActivityByid(id);
            this.publicService.deleteCarouselByid(id);
            this.commentService.DeleteActivityCommentByaid(id);
            webIndex.deleteIndex(Integer.toString(id));
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    //批量删除！！！！！！！！！！！
    @ResponseBody
    @RequestMapping(value = {"/activity/deletes"},method = RequestMethod.POST)
    public Object Activitydeletes(@RequestBody String [] id) {
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("ids", id);
            String type ="activity";
            map.put("type",type);
            int num =timingService.deleteBeforeByMap(map);
            if(num==0) {
                System.out.println("当前timing表没有该数据");
            }
            this.publicService.deleteActivityByids(map);
            this.publicService.deleteCarouselByids(map);
            this.commentService.DeleteActivityCommentByaids(map);
            for(int a = 0 ;a<id.length;a++){
                webIndex.deleteIndex(id[a]);
            }
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //////////////////////////////////////////////////////////////发布题目
    @RequestMapping("/suduko")
    public String GoToquestionPage()
    {
        UpdateTime("suduko");
        return "/public/everydayexam/everydayexam";
    }
    @RequestMapping("/suduko/add")
    public String GoToquestionAddPage(){
        return "/public/everydayexam/add";
    }

    //TODO 新增定时发送功能 修改表字段


    @RequestMapping(value = "/suduko/upload",method = RequestMethod.POST)
    public Object QuestionUpload(@RequestParam("file") MultipartFile file,Suduko suduko,
                                 HttpServletRequest httpServletRequest)throws IOException {
        AJAXResult result = new AJAXResult();
        System.out.println("进入uploadFiles");
        String uploadTime = suduko.getTime();
        String sum = suduko.getNum();
        String type = suduko.getType();
        int id = suduko.getId();
        System.out.println(suduko);
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
//        int id = randomNumber.CreateRandomNumber2();
        int idImg = randomNumber.CreateRandomNumber3();
        int serverPort = httpServletRequest.getServerPort();
        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
        String url = "http://" + serverName + ":" + serverPort + path + "/view/suduko?id=" + id;
        String uurl = "http://" + serverName + ":" + serverPort + path ;
        int status = 0;
//        suduko.setId(id);
        suduko.setTime(time);
        suduko.setUrl(url);
        suduko.setStatus(status);
        suduko.setNum(sum);
        System.out.println(suduko);
        publicService.insertSuduko(suduko);
        try {
//            String filename = file.getOriginalFilename();
//            String dir = httpServletRequest.getServletContext().getRealPath("/resource/static/upload");
//            String pathRoot = httpServletRequest.getSession().getServletContext().getRealPath("");
//            String uuid = UUID.randomUUID().toString().replaceAll("-","");
//            String imageName=file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
//            String path2="/resource/static/upload/" + uuid + "." + imageName;

            if (!file.isEmpty()) {
//                System.out.println("文件开始上传，文件名：" + filename + "文件大小" + file.getSize());
//                file.transferTo(new File(pathRoot+path2));
                String Furl = fileuploadPath;
                String directory ="sudukoImg";
                String Fresult = HttpRequest.upload(Furl,file,directory);
                ResponseModel rm = JsonUtils.jsonToPojo(Fresult,ResponseModel.class);
                String imageUrl = "";
                if(rm.getCode()==0){
                    imageUrl=rm.getData().toString();
                }
                String imageName= file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
                String typeImg = file.getContentType();
                SudukoImg sudukoImg = new SudukoImg();
                sudukoImg.setFileName(imageName);
//                sudukoImg.setFileUrl(uurl+path2);
                sudukoImg.setFileUrl(imageUrl);
                sudukoImg.setMimeType(typeImg);
                sudukoImg.setId(idImg);
                sudukoImg.setSid(id);
                sudukoImg.setType(type);
                publicService.insertSudukoImg(sudukoImg);
            }
            //TODO  这里是添加进入timing表中等待发送
            int Tid = randomNumber.CreateRandomNumber();
            Timing timing = new Timing();
            timing.setId(Tid);
            timing.setStatus(0);
            timing.setType("suduko");
            timing.setOptime(time);
            timing.setOid(id);
            timing.setTime(uploadTime);
            timingService.inserttiming(timing);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return "redirect:/public/suduko/add";
    }


    @ResponseBody
    @RequestMapping(value = "/suduko/anwserupload" ,method = RequestMethod.POST)
    public String anwserupload(@RequestBody  String massage){
        JSONObject json = JSONObject.fromObject(massage);
        String answer = json.getString("answer");
        int id = Integer.parseInt(json.getString("id"));
        publicService.insertSudukoAnwser(answer,id);
        return "ok";
    }
    //此处有主页全部查找数独请求


    @ResponseBody
    @RequestMapping(value = "/suduko/queryAll" ,method = RequestMethod.POST)
    public Object queryAllSuduko(String queryText, Integer pageno, Integer pagesize){
        AJAXResult result = new AJAXResult();
        System.out.println("pageno"+pageno+"  pagesize"+pagesize);
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<Suduko> sudukos = this.publicService.pageQuerySudukoData(map);
            int totalsize = this.publicService.pageQuerySudukoCount(map);
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

    @ResponseBody
    @RequestMapping(value = {"/suduko/delete"},method = RequestMethod.POST)
    public Object Sudukodelete(int id) {
        AJAXResult result = new AJAXResult();
        String type="suduko";
        int num =timingService.deleteBeforeByOid(id,type);
        if(num==0){
            System.out.println("当前timing表没有该数据");
        }
        try {
            this.publicService.deleteSudukoByid(id);
            this.publicService.deleteSudukoAnswerByid(id);
            int sum =publicService.deleteSudukoImgByid(id);
            if(sum==0){
                System.out.println("这个不是图片类型");
            }
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //批量删除！！！！！！！！！！！
    @ResponseBody
    @RequestMapping(value = {"/suduko/deletes"},method = RequestMethod.POST)
    public Object Sudukodeletes(@RequestBody String [] id) {
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            String type ="suduko";
            map.put("ids", id);
            map.put("type",type);
            int num =timingService.deleteBeforeByMap(map);
            if(num==0){
                System.out.println("当前timing表没有该数据");
            }
            this.publicService.deleteSudukoByids(map);
            this.publicService.deleteSudukoAnswerByids(map);
            int sum =publicService.deleteSudukoImgByMap(map);
            if(sum==0){
                System.out.println("这个不是图片类型");
            }
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }


    //////////////////////////////////////////////////////////////更换轮播图片
    @RequestMapping("/changeimage")
    public String GoToChangeimage(){
        return "public/changeimage/index";
    }

    /**
     * 进入轮播图片上传主页   这里的id activity
     * */
    @RequestMapping("/changeimage/activity")
    public String GotoViewActivity(@RequestParam("id") int id, Model model) {
//        System.out.println("GotoViewActivity id" + id);
        HashMap<String, Object> activities = new HashMap<String, Object>();
        activities = publicService.QueryActivity(id);
        List<Carousel> carousel=publicService.QueryCarousel(id);
//        System.out.println("carousel" + carousel);
        Carousel c = new Carousel();
        if(carousel.size()!=0){
            for(Carousel list :carousel){
                c.setTime(list.getTime());
                c.setAid(list.getAid());
               c.setUrl(list.getUrl());
               c.setTitle(list.getTitle());
               c.setFilename(list.getFilename());
               c.setId(list.getId());
               c.setAurl(list.getAurl());
               System.out.println("list" + list);
            }
            model.addAttribute("carousel",c);
        }else{
            model.addAttribute("carousel",null);
        }
        String name = (String)activities.get("name");
        String time = (String)activities.get("time");
        String title = (String)activities.get("title");
        String content = (String)activities.get("content");
        int status = (int)activities.get("status");
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
        return "public/changeimage/assign";
    }


    /**
     * 轮播图片上传   这里的aid 是activity
     * */
    @RequestMapping(value = "/changeimage/upload",method = RequestMethod.POST)
    public String UpLoadPhoto(@RequestParam("aid") int aid,
                              @RequestParam("title") String title,
                              @RequestParam("aurl") String aurl,
                              @RequestParam("file") MultipartFile file,
                              HttpServletRequest request,
                              Model model)throws IllegalStateException, Exception {
        AJAXResult result = new AJAXResult();
        // 获取原来文件名
        System.out.println("/changeimage/upload file" + file);
//        String filename = file.getOriginalFilename();
        // 获取保存文件的物理路径
//        String pathRoot = request.getSession().getServletContext().getRealPath("");
//        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
//        String imageName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".") + 1);
//        String path = "/resource/static/carousel/" + uuid + "." + imageName;
//        if (!file.isEmpty()) {
//            File newFile = new File(path, imageName);
//            file.transferTo(new File(pathRoot + path));
//        }
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber4();

//        int serverPort = request.getServerPort();
//        String serverName = request.getServerName();
//        String path2 = request.getSession().getServletContext().getContextPath();

        String url = fileuploadPath;
        String directory ="carousel";
        String Fresult = HttpRequest.upload(url,file,directory);
        ResponseModel rm = JsonUtils.jsonToPojo(Fresult,ResponseModel.class);
        String imageUrl = "";
        if(rm.getCode()==0){
            imageUrl=rm.getData().toString();
        }
        String imageName= file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);


        Carousel carousel = new Carousel();
        carousel.setTime(time);
        carousel.setAid(aid);
        carousel.setAurl(aurl);
        carousel.setId(id);
        carousel.setTitle(title);
        carousel.setFilename(imageName);
//        carousel.setUrl("http://"+serverName+":"+serverPort+path2 + path);
        carousel.setUrl(imageUrl);

        publicService.UpLoadPhoto(carousel);
        model.addAttribute("carousel", carousel);
        return "redirect:/public/changeimage/activity?id=" + aid;
    }

    /**
     * 进入轮播图片上传主页   这里的id article
     * */
    @RequestMapping("/changeimage/article")
    public String GotoViewArticle(@RequestParam("id") int id, Model model) {
        HashMap<String, Object> articles = new HashMap<String, Object>();
        articles = publicService.QueryArticle(id);
        List<Carousel> carousel=publicService.QueryCarousel(id);
        Carousel c = new Carousel();
        if(carousel.size()!=0){
            for(Carousel list :carousel){
                c.setTime(list.getTime());
                c.setAid(list.getAid());
                c.setUrl(list.getUrl());
                c.setTitle(list.getTitle());
                c.setFilename(list.getFilename());
                c.setId(list.getId());
                c.setAurl(list.getAurl());
            }
            model.addAttribute("carousel",c);
        }else{
            model.addAttribute("carousel",null);
        }
        String name = (String)articles.get("name");
        String time = (String)articles.get("time");
        String title = (String)articles.get("title");
        String content = (String)articles.get("content");
        int status = (int)articles.get("status");

        Article article = new Article();
        article.setTitle(title);
        article.setId(id);
        article.setTime(time);
        article.setContent(content);
        article.setName(name);
        article.setStatus(status);
        model.addAttribute("article",article);
        return "public/changeimage/assign2";
    }
    /**
     * 进入轮播图片上传主页   这里的aid upload2
     * */
    @RequestMapping(value = "/changeimage/upload2",method = RequestMethod.POST)
    public String UpLoadPhoto2(@RequestParam("aid") int aid,
                              @RequestParam("title") String title,
                              @RequestParam("aurl") String aurl,
                              @RequestParam("file") MultipartFile file,
                              HttpServletRequest request,
                              Model model)throws Exception {
        // 获取原来文件名
        // 获取保存文件的物理路径
        String url = fileuploadPath;
        String directory ="carousel";
        String Fresult = HttpRequest.upload(url,file,directory);
        ResponseModel rm = JsonUtils.jsonToPojo(Fresult,ResponseModel.class);
        String imageUrl = "";
        if(rm.getCode()==0){
            imageUrl=rm.getData().toString();
        }
        String imageName= file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);
        String typeImg = file.getContentType();

//        String pathRoot = request.getSession().getServletContext().getRealPath("");
//        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
//        String imageName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".") + 1);
//        String path = "/resource/static/carousel/" + uuid + "." + imageName;
//        if (!file.isEmpty()) {
//            File newFile = new File(path, imageName);
//            file.transferTo(new File(pathRoot + path));
//        }

        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber4();


//        int serverPort = request.getServerPort();
//        String serverName = request.getServerName();
//        String path2 = request.getSession().getServletContext().getContextPath();

        Carousel carousel = new Carousel();
        carousel.setTime(time);
        carousel.setAid(aid);
        carousel.setAurl(aurl);
        carousel.setId(id);
        carousel.setTitle(title);
        carousel.setFilename(imageName);
//        carousel.setUrl("http://"+serverName+":"+serverPort+path2 + path);
        carousel.setUrl(imageUrl);
        publicService.UpLoadPhoto(carousel);
        model.addAttribute("carousel", carousel);
        return "redirect:/public/changeimage/article?id=" + aid;
    }


    @RequestMapping(value = "/changeimage/del/{id}/{aid}", method = RequestMethod.GET)
    public String changeimage_del(@PathVariable("id") String id,@PathVariable("aid") String aid){
        //调用delete方法删除图片
        //上传图片后重定向回UpLoadPhoto页面
        publicService.changeimage_del(id);
        return "redirect:/public/changeimage/activity?id="+aid;
    }

    @RequestMapping(value = "/changeimage/del2/{id}/{aid}", method = RequestMethod.GET)
    public String changeimage_del2(@PathVariable("id") String id,@PathVariable("aid") String aid){
        //调用delete方法删除图片
        //上传图片后重定向回UpLoadPhoto页面
        int Iid = Integer.parseInt(id);
        publicService.deleteArticleByid(Iid);
        return "redirect:/public/changeimage/particle?id="+aid;
    }

    //////////////////////////////////////////////////////////////更换轮播图片



    //////////////////////////////////////////////////////////////发布公告
    @RequestMapping("/announcement")
    public String GoToannouncement(){
        return "public/announcement/announcement";
    }

    @RequestMapping(value = {"/announcement/view"},method = RequestMethod.GET)
    public String GoToannouncementView(@RequestParam("id") int id,
                                       Model model){
        Announcement announcement = publicService.getAnnouncementByid(id);
        String type = "notice";
        //根据type 和 id 查询
//        Timing timing = timingService.QueryTimingByIdAndType();
        model.addAttribute("announcement", announcement);
        return "public/announcement/view";
    }



    //TODO 公告处理   后期增加定时发布功能
    @ResponseBody
    @RequestMapping(value = {"/announcement/CheckNoticeBynselectid"},method = RequestMethod.POST)
    public Object CheckNoticeBynselectid(Integer selectid){
        AJAXResult result = new AJAXResult();
        System.out.println("CheckNoticeBynselectid  selectid==="+selectid);
        try {
            int flag = MenthodCheckNoticeBynid(selectid);
            System.out.println("CheckNoticeBynselectid  flag==="+flag);
            if (flag == 0){
                result.setSuccess(false);
            }else  result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    public int  MenthodCheckNoticeBynid(int id){
        return publicService.CheckNoticeBynid(id);
    }


    //发表公告  正式发表
    @ResponseBody
    @RequestMapping(value = {"/announcement/upload"},method = RequestMethod.POST)
    public Object upToNotice(Integer id,Integer selectid){
        AJAXResult result = new AJAXResult();
        System.out.println("upToNotice  id=selectid=="+id+" "+selectid);
        Announcement announcement = publicService.getAnnouncementByid(id);
        publicService.deletenoticeByid(selectid);

        Notice notice = new Notice();
        notice.setAid(announcement.getId());
        RandomNumber randomNumber = new RandomNumber();
        notice.setId(randomNumber.CreateRandomNumber4());
        notice.setNid(selectid);

       try {
           publicService.SetNoticeByid(notice);
           result.setSuccess(true);
       }catch (Exception var4){
           var4.printStackTrace();
           result.setSuccess(false);
       }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/announcement/insert"}  ,method = RequestMethod.POST)
    public Object insert(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        System.out.println(massage);
        JSONObject json = JSONObject.fromObject(massage);
        String realname = json.getString("realname");
        int id = Integer.parseInt( json.getString("id"));
        String date = json.getString("date");
        int gid =  Integer.parseInt(json.getString("gid"));
        String content = json.getString("content").trim();
        System.out.println(content);
        String time = json.getString("time");
        //TODO  这里是添加进入timing表中等待发送
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String Ttime =format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int Tid = randomNumber.CreateRandomNumber();
        Timing timing = new Timing();
        timing.setId(Tid);
        timing.setStatus(0);
        timing.setType("notice");
        timing.setOptime(Ttime);
        timing.setOid(id);
        timing.setTime(date);
        timingService.inserttiming(timing);
        //TODO //////////////////////////////////////////
        Announcement announcement = new Announcement();
        announcement.setContent(content);
        announcement.setGid(gid);
        announcement.setId(id);
        announcement.setTime(time);
        announcement.setRealname(realname);
        announcement.setStatus(0);
        try {
            publicService.insertannouncement(announcement);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping(value = {"/announcement/add"})
    public String GoToupadte(){
        return "public/announcement/add";
    }


    //公告主页
    @ResponseBody
    @RequestMapping(value = {"/announcement/pageQuery"} ,method = RequestMethod.POST)
    public Object pageQuery(String queryText, Integer pageno, Integer pagesize) {
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<Announcement> announcements = this.publicService.pageQueryData(map);
            int totalsize = this.publicService.pageQueryCount(map);
            int totalno = 0;

            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<Announcement> announcementPage = new Page();
            announcementPage.setDatas(announcements);
            announcementPage.setTotalno(totalno);
            announcementPage.setTotalsize(totalsize);
            announcementPage.setPageno(pageno);
            result.setData(announcementPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping({"/announcement/delete"})
    public Object delete(int id) {
        AJAXResult result = new AJAXResult();
        try {
            String type="notice";
            int num =timingService.deleteBeforeByOid(id,type);
            if(num==0){
                System.out.println("当前timing表没有该数据");
            }

            this.publicService.deleteAnnouncemnetById(id);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    //批量删除！！！！！！！！！！！
    @ResponseBody
    @RequestMapping({"/announcement/deletes"})
    public Object deletes(@RequestBody String [] id) {
        AJAXResult result = new AJAXResult();

        System.out.println("id"+id);
        try {
            Map<String, Object> map = new HashMap();
            map.put("ids", id);
            String type ="notice";
            map.put("type",type);
            int num =timingService.deleteBeforeByMap(map);
            if(num==0) {
                System.out.println("当前timing表没有该数据");
            }
            this.publicService.deleteAnnouncemnetByids(map);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }




//////////////////////////////////////////////////////////////社团周边的替换

    @RequestMapping(value = "/zhoubian",method = RequestMethod.GET)
    public String gotozhoubian(Model model){
        List<Zhoubian> zhoubianList = publicService.Queryzhoubian();
        System.out.println(zhoubianList);
        model.addAttribute("zhoubianList",zhoubianList);
        return "public/zhoubian/index";
    }
    @RequestMapping(value = "/zhoubian/add",method = RequestMethod.GET)
    public String gotoAddzhoubian(){
        return "public/zhoubian/add";
    }


    //插入广告 周边
    @RequestMapping(value = "/zhoubian/insert",method = RequestMethod.POST)
    public String Insertzhoubian( @RequestParam("title") String title,
                                 @RequestParam("file") MultipartFile file,
                                 HttpServletRequest request) throws Exception {
        Zhoubian zhoubian = new Zhoubian();
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = format0.format(ltime.getTime());
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber4();
            // 获取保存文件的物理路径
        String url = fileuploadPath;
        String directory ="zhoubian";
        String result = HttpRequest.upload(url,file,directory);
        ResponseModel rm = JsonUtils.jsonToPojo(result,ResponseModel.class);
        String imageUrl = "";
        if(rm.getCode()==0){
            imageUrl=rm.getData().toString();
        }
        String imageName= file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".")+1);

        String typeImg = file.getContentType();
//        String pathRoot = request.getSession().getServletContext().getRealPath("");
//        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
//        String imageName = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf(".") + 1);
//        String path = request.getSession().getServletContext().getContextPath();
//        String path2 = "/resource/static/zhoubian/" + uuid + "." + imageName;
//        if (!file.isEmpty()) {
//            file.transferTo(new File(pathRoot + path2));
//            System.out.println("文件开始上传，文件名：" + imageName + "文件大小" + file.getSize());
//        }
//
//        int serverPort = request.getServerPort();
//        String serverName = request.getServerName();
//        String uurl = "http://" + serverName + ":" + serverPort + path ;
//        System.out.println("uurl + path2"+uurl + path2);


        zhoubian.setFileName(imageName);
        zhoubian.setFileUrl(imageUrl);
        zhoubian.setId(id);
        zhoubian.setMimeType(typeImg);
        zhoubian.setTitle(title);
        zhoubian.setTime(time);
        publicService.insertZhoubian(zhoubian);
        return "redirect:/public/zhoubian";
    }

    @RequestMapping(value = "/zhoubian/del/{id}", method = RequestMethod.GET)
    public String zhoubian_del(@PathVariable("id") int id){
        //调用delete方法删除图片
        //上传图片后重定向回UpLoadPhoto页面
        publicService.zhoubian_del(id);
        return "redirect:/public/zhoubian";
    }
//////////////////////////////////////////////////////////////社团周边的替换


////////////////////////////////发表文章////////////////////////////////////////////////////
    @RequestMapping("/article")
    public String GotoArticle() { return "public/article/article";}
    @RequestMapping("/article/add")
    public String GotoAddArticle(){return "public/article/add";}
    @ResponseBody
    @RequestMapping(value = "/article/queryAll" ,method = RequestMethod.POST)
    public Object queryAllArticle(String queryText, Integer pageno, Integer pagesize){
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("queryText", queryText);
            List<Article> articles = this.publicService.pageQueryArticleData(map);
            int totalsize = this.publicService.pageQueryArticleCount(map);
            int totalno = 0;

            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<Article> articlePage = new Page();

            articlePage.setDatas(articles);
            articlePage.setTotalno(totalno);
            articlePage.setTotalsize(totalsize);
            articlePage.setPageno(pageno);
            result.setData(articlePage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    @ResponseBody
    @RequestMapping(value = "/article/upload" ,method = RequestMethod.POST)
    public Object UploadArticle(@RequestBody String massage, Model model, HttpSession session, HttpServletRequest httpServletRequest){
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        String content = json.getString("content");
        String TitleText = json.getString("TitleText");
        String typemsg = json.getString("typemsg");
        String type = json.getString("type");
        int status = 0;
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        CUSER loginUser =(CUSER)session.getAttribute("user");
        String realname = loginUser.getRealname();
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        int serverPort = httpServletRequest.getServerPort();
        String schgenme=httpServletRequest.getProtocol();
        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
        String url ="http://"+serverName+":"+serverPort+path+"/view/particles?id="+id;
        int id2 = randomNumber.CreateRandomNumber();
        String url2 ="http://"+serverName+":"+serverPort+path+"/preview/particles?id="+id;
        System.out.println("path==/url" + url);
        try {
            Article article = new Article();
            article.setContent(content);
            article.setName(realname);
            article.setTime(time);
            article.setTitle(TitleText);
            article.setId(id);
            article.setUrl(url);
            article.setType(type);
            article.setTypemsg(typemsg);
            article.setStatus(status);
            publicService.insertArticle(article);
            webIndex.addIndex2(article);

            Preview preview = new Preview();
            preview.setAid(id);
            preview.setTitle(TitleText);
            preview.setContent(content);
            preview.setUrl(url2);
            preview.setId(id2);
            publicService.insertPreviewArticle(preview);
//            webIndex.updateIndex2(article);

            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = {"/article/delete"},method = RequestMethod.POST)
    public Object Articledelete(Integer id) {
        AJAXResult result = new AJAXResult();
        try {
            String type="article";
            int num =timingService.deleteBeforeByOid(id,type);
            if(num==0){
                System.out.println("当前timing表没有该数据");
            }

            this.publicService.deleteArticleByid(id);
            this.publicService.deleteCarouselByid(id);
            this.commentService.DeleteActivityCommentByaid(id);
            webIndex.deleteIndex2(Integer.toString(id));
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
    //批量删除！！！！！！！！！！！
    @ResponseBody
    @RequestMapping(value = {"/article/deletes"},method = RequestMethod.POST)
    public Object Articledeletes(@RequestBody String [] id) {
        AJAXResult result = new AJAXResult();
        try {
            Map<String, Object> map = new HashMap();
            map.put("ids", id);
            String type ="article";
            map.put("type",type);
            int num =timingService.deleteBeforeByMap(map);
            if(num==0) {
                System.out.println("当前timing表没有该数据");
            }
            this.publicService.deleteArticleByids(map);
            this.publicService.deleteCarouselByids(map);
            this.commentService.DeleteActivityCommentByaids(map);
            for(int a = 0 ;a<id.length;a++){
                webIndex.deleteIndex(id[a]);
            }

            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    //进入edit.jsp 内容应当从preview表中获取  包括活动 ，竞选文章  这个表相当于回收站
    @RequestMapping("/article/edit")
    public String GotoEditArticle(@RequestParam("id") int id,Model model){
        HashMap<String, Object> previews = publicService.QueryPreviewArticleByaid(id);
        int id1 = (int)previews.get("id");
        int aid = (int)previews.get("aid");
        System.err.println(id1);
        String title = (String)previews.get("title");
        String content = (String)previews.get("content");
        String url = (String)previews.get("url");
        Preview preview = new Preview();
        preview.setId(id1);
        preview.setUrl(url);
        preview.setContent(content);
        preview.setTitle(title);
        preview.setAid(aid);
        model.addAttribute("preview",previews);
        return "public/article/edit";
    }
    //修改文章
    @ResponseBody
    @RequestMapping(value = "/article/editArticle" ,method = RequestMethod.POST)
    public Object EditArticle(@RequestBody String massage, Model model, HttpSession session, HttpServletRequest httpServletRequest){
        AJAXResult result = new AJAXResult();
        JSONObject json = JSONObject.fromObject(massage);
        String content = json.getString("content");
        String TitleText = json.getString("TitleText");
        int id = Integer.parseInt(json.getString("id"));

        int status = 0;
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time =format0.format(ltime.getTime());
        CUSER loginUser =(CUSER)session.getAttribute("user");
        String realname = loginUser.getRealname();
        int serverPort = httpServletRequest.getServerPort();
        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
        String url ="http://"+serverName+":"+serverPort+path+"/view/particles?id="+id;
        try {
            Article article = new Article();
            article.setContent(content);
            article.setName(realname);
            article.setTime(time);
            article.setTitle(TitleText);
            article.setId(id);
            article.setUrl(url);
            article.setStatus(status);
            publicService.UpdataArticle(article);
            webIndex.updateIndex2(article);
            result.setSuccess(true);
        }catch (Exception var4){
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }





/////////////////////////////////////////////发表文章////////////////
}


