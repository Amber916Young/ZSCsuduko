package jee.support.controller;

import jee.support.entity.*;
import jee.support.service.*;
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
 * 预览表   写文章活动 在未发布之前都可进行修改并且预览
 * */
@Controller
@RequestMapping("/preview")
public class PreviewController {
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


    /**
     *
     **/
    @ResponseBody
    @RequestMapping(value = "/BeforeActivity",method = RequestMethod.POST)
    public Object GotoPreviewActivity(@RequestBody String massage, HttpServletRequest httpServletRequest) {
        JSONObject json = JSONObject.fromObject(massage);
        String content = json.getString("content");
        String TitleText = json.getString("TitleText");
        int aid = Integer.parseInt(json.getString("id"));
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        int serverPort = httpServletRequest.getServerPort();
        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
        String url ="http://"+serverName+":"+serverPort+path+"/preview/activity?id="+aid;
        Preview preview = new Preview();
        preview.setAid(aid);
        preview.setTitle(TitleText);
        preview.setContent(content);
        preview.setUrl(url);
        preview.setId(id);
        int sum = publicService.checkPreviewByaid(aid);
        if(sum!=0){
            publicService.deletePreviewByaid(aid);
        }
        publicService.insertPreview(preview);

        return id;
    }

    @RequestMapping("/activity")
    public String GotoPreviewActivity(@RequestParam("id") int id, Model model) {
        HashMap<String, Object> previews = new HashMap<String, Object>();

//        System.out.println("预览");
        previews = publicService.QueryPreviewByid(id);
        int id1 = (int)previews.get("id");
        int aid = (int)previews.get("aid");
        if(aid==id){
            System.out.println("aid id 相等");
        }
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

        return "View/preview";
    }



    //此处是预览推文内容，不是活动内容！！！！！！！！注意，因为两个技术实现很相似，请不要看错
    @ResponseBody
    @RequestMapping(value = "/BeforeArticle",method = RequestMethod.POST)
    public Object GotoPreviewArticle(@RequestBody String massage, HttpServletRequest httpServletRequest) {
        JSONObject json = JSONObject.fromObject(massage);
        String content = json.getString("content");
        String TitleText = json.getString("TitleText");
        int aid = Integer.parseInt(json.getString("id"));
        RandomNumber randomNumber = new RandomNumber();
        int id = randomNumber.CreateRandomNumber();
        int serverPort = httpServletRequest.getServerPort();
        String serverName = httpServletRequest.getServerName();
        String path = httpServletRequest.getSession().getServletContext().getContextPath();
        String url ="http://"+serverName+":"+serverPort+path+"/preview/particles?id="+aid;
        Preview preview = new Preview();
        preview.setAid(aid);
        preview.setTitle(TitleText);
        preview.setContent(content);
        preview.setUrl(url);
        preview.setId(id);
        int sum = publicService.checkPreviewArtByaid(aid);
        if(sum!=0){
            publicService.deletePreviewArtByaid(aid);
        }
        publicService.insertPreviewArticle(preview);

        return id;
    }


    //根据id 跳转，实际上和普通发布没有区别，仅仅用于内部人员方便查看内容。
    @RequestMapping("/previewArt")
    public String GotoPreviewparticles(@RequestParam("id") int id, Model model) {
        HashMap<String, Object> previews = new HashMap<String, Object>();
        previews = publicService.QueryPreviewarticlesByid(id);
        int id1 = (int)previews.get("id");
        int aid = (int)previews.get("aid");
        if(aid==id){
            System.out.println("aid id 相等");
        }
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
        return "View/previewArt";
    }
}
