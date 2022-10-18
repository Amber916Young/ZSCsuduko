package jee.support.filters;

import jee.support.entity.Activity;
import jee.support.entity.CUSER;
import jee.support.entity.Suduko;
import jee.support.service.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

public class UrlInterceptor extends HandlerInterceptorAdapter {
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
     * url路径验证没有发表的文章是不可以看的 只有发表的用户能预览
     * */

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取用户的请求地址，判断当前的路径是否需要权限验证
        String uri = request.getRequestURI();
        String url="http://" + request.getServerName() //服务器地址
                + ":"
                + request.getServerPort()           //端口号
                + request.getRequestURI();

        String queryurl=request.getQueryString();
        if(null!=queryurl){
            url+="?"+queryurl;
        }

        String path = request.getSession().getServletContext().getContextPath();
        HttpSession session = request.getSession();
        List<Activity> activities = publicService.QueryAllActivity();
        List<Suduko> sudukos = publicService.QueryAlSuduko();
        CUSER loginUser =(CUSER)session.getAttribute("user");
        List<String> uriSet1 = new ArrayList<>();

        List<String> uriSet2 = new ArrayList<String>();

//        System.out.println(activities);
        System.out.println(sudukos);
        for(Activity activity :activities){
            if(activity.getUrl()!=null && activity.getStatus()==1) {
                uriSet1.add(activity.getUrl());
//                System.out.println("uriSet1===="+uriSet1);

            }
        }
        for(Suduko suduko:sudukos){
            if(suduko.getUrl()!=null && suduko.getStatus()==1) {
                uriSet2.add(suduko.getUrl());
//                System.out.println("uriSet2===="+uriSet2);
            }
        }

        String[] urlArray = url.split("/");
//        System.out.println("urlArray.length="+urlArray.length);
        if(urlArray.length>=3) {
            if (url.contains("/view/activity")) {
//                System.out.println(" view 存在");
                if (uriSet1.contains(url)) {
//                    System.out.println("存在");
                    return true;
                } else {
                    response.sendRedirect(path + "/error");
                    return false;
                }
            }
            if (url.contains("/view/suduko")) {
                if (uriSet2.contains(url)) {
//                    System.out.println("存在");
                    return true;
                } else {
                    response.sendRedirect(path + "/error");
                    return false;
                }
            }
        }

        return  true;

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
    }
}
