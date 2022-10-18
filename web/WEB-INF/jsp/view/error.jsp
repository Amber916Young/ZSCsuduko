<%--
  Created by IntelliJ IDEA.
  User: 杨叶佳
  Date: 2019/3/4
  Time: 13:04
  To change this template use File | Settings | File Templates.
--%>
<%--这是权限过滤 非法访问跳转的页面--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<html>
<head>
    <title>error</title>
</head>
<body>
非法路径访问！☺☺
<p>3秒后跳转至首页</p>

<%
    response.setHeader("refresh", "3;URL=index/");//这里的3,是你要确定的时间秒URL是要跳转的地址
%>
</body>
</html>
