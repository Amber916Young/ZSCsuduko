package jee.support.filters;

import jee.support.entity.CUSER;
import jee.support.entity.OperationRecord;
import jee.support.service.OperationRecordMapperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LogInterceptor  implements HandlerInterceptor {
    @Autowired
    OperationRecordMapperService operationRecordMapper;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        return true;
    }

    /**
     * 控制器执行完毕之后的逻辑操作
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }
    /**
     * 完成试图渲染之后的方法
     */
    /**
     * 方法执行后拦截
     * 用来记录所有请求中的操作日志
     * @param request
     * @return
     * @throws Exception
     */

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        //相对路径 /tongche/metadata/all
        String url = request.getRequestURI();
        //请求方式 POST
        String method = request.getMethod();
        String[] urlArray = url.split("/");
        if(urlArray.length>=2){
//            System.out.println("url======="+url);
            //判断是否是增加操作
            //||("ins".equalsIgnoreCase(urlArray[3].substring(0,3)))
            if(url.contains("insert")||url.contains("upload")&&("POST".equalsIgnoreCase(method))){
//                System.out.println("add213435======="+urlArray[2]);
                addOperation(request,url+"||ADD操作",urlArray[2],0);
            }
            if(url.contains("doAssign")&&("POST".equalsIgnoreCase(method))){
//                System.out.println("doAssign======="+urlArray[2]);
                addOperation(request,url+"||doAssign操作",urlArray[2],0);
            }
            if(url.contains("dounAssign")&&("POST".equalsIgnoreCase(method))){
//                System.out.println("add213435======="+urlArray[2]);
                addOperation(request,url+"||dounAssign操作",urlArray[2],0);
            }
            if(url.contains("del")||url.contains("delete")||url.contains("deletes")&&("POST".equalsIgnoreCase(method))){
//                System.out.println("delete213435======="+urlArray[2]);
//                int id = (int)request.getAttribute("id");
                addOperation(request,url+"||delete操作",urlArray[2],0);
            }
            if(url.contains("update")&&("POST".equalsIgnoreCase(method))){
//                System.out.println("add213435======="+urlArray[2]);
                addOperation(request,url+"||update操作",urlArray[2],0);
            }
//            if("upload".equalsIgnoreCase(urlArray[4].substring(0,6))||"insert".equalsIgnoreCase(urlArray[4].substring(0,6))&&("POST".equalsIgnoreCase(method))){
//                System.out.println("add=======");
//                addOperation(request,url+"||ADD操作",urlArray[2],0);
//                System.out.println("add=======222");
//            }
//            if("doAssign".equalsIgnoreCase(urlArray[4].substring(0,6))&&("POST".equalsIgnoreCase(method))){
//                System.out.println("doAssign=======");
//                addOperation(request,url+"||doAssign操作",urlArray[2],0);
//                System.out.println("doAssign=======222");
//            }
//            if("dounAssign".equalsIgnoreCase(urlArray[4].substring(0,6))&&("POST".equalsIgnoreCase(method))){
//                System.out.println("dounAssign=======");
//                addOperation(request,url+"||dounAssign操作",urlArray[2],0);
//                System.out.println("dounAssign=======222");
//            }
//            //判断是否是删除操作
//            if("del".equalsIgnoreCase(urlArray[4].substring(0,6))||"delete".equalsIgnoreCase(urlArray[4].substring(0,6))||"deletes".equalsIgnoreCase(urlArray[4].substring(0,6))&&("POST".equalsIgnoreCase(method))){
//                //当前操作的对象的ID
//                System.out.println("del=======");
//                int id = (int)request.getAttribute("id");
//                addOperation(request,"DELETE",urlArray[2],id);
//                System.out.println("del=======222");
//
//            }
//            //判断是否是修改操作
//            if("update".equalsIgnoreCase(urlArray[3].substring(0,3))&&("POST".equalsIgnoreCase(method))){
//                System.out.println("upd=======");
//                addOperation(request,"UPDATE",urlArray[2],0);
//                System.out.println("upd=======222");
//            }
        }else{
//            log.info("不合法的URL："+url);
            System.out.println("不合法的URL："+url);
        }

    }

    /**
     * 向操作日志中增加数据的方法
     * @param request
     * @param operate  操作
     * @param operateObject  操作对象
     */
    public void addOperation(HttpServletRequest request, String operate, String operateObject,int id){
        //构造操作日志对象
        OperationRecord operationRecord = new OperationRecord();
        //首先拿到目前的登陆用户
        HttpSession session = request.getSession();
        CUSER loginUser =(CUSER)session.getAttribute("user");
        operationRecord.setOperateObject(operateObject);
        operationRecord.setOperate(operate);
        operationRecord.setUserRealname(loginUser.getRealname());
        Date ltime = new Date();
        SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = format0.format(ltime.getTime());
        operationRecord.setOperateTime(time);
        operationRecord.setOperateState(1);
        if(id>0){
            operationRecord.setOperateObjectKey(id);
        }
        operationRecordMapper.insertSelective(operationRecord);
        System.out.println("添加操作日志成功");
    }

}
