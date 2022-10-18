package jee.support.controller;

import com.github.pagehelper.StringUtil;
import jee.support.entity.Activity;
import jee.support.entity.Article;
import jee.support.entity.WebIndex;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * luence 全文检索
 **/
@Controller
@RequestMapping("/webIndex")
public class WebIndexController {

    private WebIndex webIndex = new WebIndex();


    /**
     * 根据关键字查询/webIndex/query
     * */

    @RequestMapping(value = {"/query"},method = RequestMethod.POST)
    public ModelAndView query(@RequestParam(value = "q",required = false)String q,
                              @RequestParam(value = "page",required = false)String page,
                              HttpServletRequest request) throws Exception {
        System.out.println("q="+q+"  page"+page);
        if(StringUtil.isEmpty(page)){
            page="1";
        }
        ModelAndView mav = new ModelAndView();
        mav.addObject("mainPage","view/View/webindex.jsp");
        //在luence 中查询
        List<Activity> activityList = webIndex.searchActivity(q.trim());
        List<Article> articleList = webIndex.searchArticle(q.trim());
        mav.addObject("q",q);
        mav.addObject("activityList",activityList);
        mav.addObject("articleList",articleList);
        mav.addObject("resultTotal",activityList.size()+articleList.size());
        mav.addObject("pageTitle","搜索关键字'"+q+"'结果页面");
        mav.setViewName("webindex");
        return mav;
    }


//    @RequestMapping(value = {"/query"},method = RequestMethod.POST)
//    public ModelAndView query(@RequestParam(value="q" ,required =false ) String q) {
//        System.out.println("进入+"+q);
//        return null;
//    }

}
