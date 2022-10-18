package jee.support.controller;

import jee.support.entity.*;
import jee.support.service.CUserService;
import jee.support.service.CommentService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentService commentService;
    @Autowired
    CUserService cUserService;


    /**
     * 新增评论
     * */
    @ResponseBody
    @RequestMapping(value = "/addActivitycomment",method = RequestMethod.POST)
    public Object ActivityAddcoment(@RequestBody String massage) {
        AJAXResult result = new AJAXResult();
        try {
    //        System.out.println("进入addcomment");
            //转化为json对象读取
    //        System.out.println(massage);
            JSONObject json = JSONObject.fromObject(massage);
            int id = Integer.parseInt(json.getString("id"));
            String content = json.getString("content");
            int aid = Integer.parseInt(json.getString("aid"));
            String realname = json.getString("realname");
            String time = json.getString("time");
            String username = json.getString("username");
            String aurl = json.getString("aurl");
            String atitle=json.getString("atitle");
            Comment comment = new Comment();
            comment.setAid(aid);
            comment.setContent(content);
            comment.setId(id);
            comment.setTime(time);
            comment.setAurl(aurl);
            comment.setAtitle(atitle);
            comment.setRealname(realname);
            comment.setUsername(username);
            commentService.InsertActivityAddcoment(comment);
            result.setSuccess(true);
        } catch (Exception var4) {
            var4.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }



    /**
     * 删除评论
     * */
    @ResponseBody
    @RequestMapping(value = "/delActivityComment",method = RequestMethod.POST)
    public String delActivityComment(@RequestBody String massage) {
        //转化为json对象读取
//        System.out.println("delActivityComment");
//        System.out.println(massage);
        try{
            JSONObject json = JSONObject.fromObject(massage);
            String id = json.getString("id");
            commentService.DeleteActivityComment(id);
        }catch (Exception var4) {
            var4.printStackTrace();
            return "fail";
        }
        return "success";
    }


    //查询评论
    @ResponseBody
    @RequestMapping(value = "/queryActivityComment" ,method = RequestMethod.POST)
    public Object queryAllSuduko(Integer pageno, Integer pagesize, Integer aid , Model model){
        AJAXResult result = new AJAXResult();
        System.out.println("pageno"+pageno+"  pagesize"+pagesize);
        try {
            Map<String, Object> map = new HashMap();
            map.put("start", (pageno - 1) * pagesize);
            map.put("size", pagesize);
            map.put("aid", aid);
            List<Comment> comments = this.commentService.pageQueryActivityCommentData(map);
            int totalsize = this.commentService.pageQueryActivityCommentCount(map);
            CUSER cuser = new CUSER();
            List<CUSER> cuserList  = new ArrayList<>();
            for(Comment comment :comments) {
                String realname = comment.getRealname();
                String username = comment.getUsername();
                if(realname==null){
                    cuser = cUserService.findByUsername(username);
                } else if(username==null){
                    cuser = cUserService.findByRealname(realname);
                }else{
                    cuser = cUserService.findByUsernameOrRealname(realname,username);
                }
                cuserList.add(cuser);
                String rn=cuser.getRealname();
                Head_portrait head_portrait =  cUserService.findHead_portraitByrealname(rn);;
                //获取头像 根据真实姓名
                String hurl = head_portrait.getFileUrl();
                comment.setHurl(hurl);
            }
            int totalno = 0;
            if (totalsize % pagesize == 0) {
                totalno = totalsize / pagesize;
            } else {
                totalno = totalsize / pagesize + 1;
            }
            Page<Comment> commentPage = new Page();
            commentPage.setDatas(comments);
            commentPage.setTotalno(totalno);
            commentPage.setTotalsize(totalsize);
            commentPage.setPageno(pageno);
            result.setData(commentPage);
            result.setSuccess(true);
        } catch (Exception var10) {
            var10.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }




}
