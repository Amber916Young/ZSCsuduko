package jee.support.filters;

import jee.support.entity.CUSER;
import jee.support.entity.SessionContext;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Map;


public class SessionListener implements HttpSessionListener {
    public static SessionContext sessionContext = SessionContext.getInstance();

    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        System.out.println(" 搜索session已经创建"+session.hashCode());
        sessionContext.AddSession(httpSessionEvent.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        ServletContext sc = session.getServletContext();
        Map<String,HttpSession> userMap = (Map<String, HttpSession>) sc.getAttribute("userMap");
        CUSER cuser = (CUSER) session.getAttribute("user");
        userMap.remove(cuser.getRealname());
//        session.invalidate();
        System.out.println("session已经销毁"+session.hashCode());
//        sessionContext.DelSession(httpSessionEvent.getSession());
        //获取cookie

    }



}
