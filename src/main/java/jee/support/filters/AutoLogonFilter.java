package jee.support.filters;
import jee.support.dao.CUserDao;
import jee.support.entity.CUSER;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jee.support.entity.CookiesUtil;
import jee.support.service.CUserService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class AutoLogonFilter implements Filter{
    public void destroy() {
    }

    private CUserService cuserService;
    private CUserDao cUserDao;

    private FilterConfig config;
    /**
     * 加密解密算法 执行一次加密，两次解密
     */
    public static String convertMD5(String inStr){

        char[] a = inStr.toCharArray();
        for (int i = 0; i < a.length; i++){
            a[i] = (char) (a[i] ^ 't');
        }
        String s = new String(a);
        return s;
    }
    @Override
    public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) arg0;
        HttpServletResponse response = (HttpServletResponse) arg1;
        //1.查看用户是否登录
        CUSER user = (CUSER) request.getSession().getAttribute("user");
        //2.如果用户未登录,判断是否是登录操作，如果不是与登陆有关的操作就自动登录
        if(user == null) {
//            if(!"login".equalsIgnoreCase(request.getParameter("handlerType"))) {
                //3.查看Cookie中是否有自动登录的cookie
                Cookie cookie = CookiesUtil.getCookieByName("autoLoginUser", request.getCookies());
                //4.判断Cookie是否为空，若不为空就登陆
                if(cookie != null) {
                    String autoUser = cookie.getValue();
                    //5.获取Cookie中保存的用户名和密码   username-password
                    String username = autoUser.split("-")[0];
                    String password = autoUser.split("-")[1];
                    String decodePwd = convertMD5(password);
                    //6.登陆用户
                    CUSER loginUser =cuserService.authenticate(username, decodePwd);
                    //7.如果登陆成功将用户保存到session中
                    if(loginUser != null) {
                        request.getSession().setAttribute("user", loginUser);
                        request.getSession().setAttribute("autoLogin","success");
                    }
                }
//            }
        }
        //放行
        arg2.doFilter(request, response);
    }

    public AutoLogonFilter() {
        super();
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        config = filterConfig;
        /*** 注入service  用户查询数据库*/
        ServletContext sc = filterConfig.getServletContext();
        WebApplicationContext cxt =WebApplicationContextUtils.getWebApplicationContext(sc);
        if(cxt != null && cxt.getBean(CUserService.class) != null && cuserService == null) {
            cuserService = (CUserService) cxt.getBean(CUserService.class);
        }
        if(cxt != null && cxt.getBean(CUserDao.class) != null && cUserDao == null) {
            cUserDao = (CUserDao) cxt.getBean(CUserDao.class);
        }
    }

}
