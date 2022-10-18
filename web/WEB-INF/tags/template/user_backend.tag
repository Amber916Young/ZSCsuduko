<%--普通用户的后台模板,添加了左侧导航栏--%>
<%--定义页面的编码类型--%>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%--定义当前模板需要传入的变量--%>
<%@ attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true" %>
<%@ attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true" required="true" %>
<%@ attribute name="extraHeadContent" fragment="true" required="false" %>
<%--定义扩展使用的传入变量--%>
<%@ attribute name="extraNavigationContent" fragment="true" required="false" %>
<%@ include file="/WEB-INF/jsp/view/base.jspf" %>
<!--template:main表示使用main的模板-->
<template:basic_backend htmlTitle="${htmlTitle}" bodyTitle="${bodyTitle}">
  <jsp:attribute name="headContent">
        <jsp:invoke fragment="extraHeadContent"/>
  </jsp:attribute>
    <jsp:attribute name="sideBar">
        <aside id="sidebar" class="sidebar-nav col-sm-2" style="font-size: 0.9em;">
            <div class="" style="padding-top: 10px;padding-left: 10px">
                <div class="">
                    <img id="img_nav" class="user-pic" src="${head_portrait.fileUrl}" alt="无法显示"/>
                </div>
                <div class="user-info">
                    <!--TODO 根据后台对比，显示用户的信息 -->
                    <span class="user-name" id="user-name"> <b>${user.username}</b></span>
                    <span class="user-role">
                        <c:choose>
                            <c:when test="${admin.position == null}">
                            普通会员
                            </c:when>
                            <c:otherwise>
                            ${admin.position}
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <div style="text-align: left">
                        <div style="margin-top: 10px">
                            <%--粉丝<a href="#" class="fens">343</a>&nbsp;--%>
                            <%--关注<a href="#" class="focus">0</a>--%>
                            积分：${user.integral}
                        </div>
                    </div>
                    <div style="height: 50px;border: 2px #000000 dashed;margin-top: 20px;margin-right: 10px">
                        <span id="msg_sign" style="padding:3px;font-size: 13px;font-family: '微软雅黑', 'Helvetica Neue', Helvetica, Arial, sans-serif">
                            <c:if test="${empty user.sign}">
                                这个人很懒，什么都没有留下
                            </c:if>
                            <c:if test="${not empty user.sign}">
                                ${user.sign}
                            </c:if>
                        </span>
                        <input type="hidden" id="hiddenMsg_sign " value="这个人很懒，什么都没有留下" disabled="disabled">
                    </div>
                    <!--TODO 后台查看粉丝或者关注数-->

                </div>
            </div>
            <br>
            <nav class="sidebar-nav">
                <ul class="metismenu" id="menu">
                        <li>
                            <a href="###" id="Item0.0"><span class="fa fa-fw fa-github fa-lg"></span>主页</a>
                        </li>
                    <c:forEach items="${rootPermission.children}" var="permission">
                        <c:if test="${empty permission.children}">
                              <li>
                                  <a href="###" id="${permission.icon}"><span class="fa fa-fw fa-github fa-lg"></span>${permission.name}</a>
                              </li>
                        </c:if>
                        <c:if test="${not empty permission.children}">
                             <li class="">
                                 <a  href="###" class="has-arrow" id="${permission.icon}"><span class="fa fa-fw fa-book fa-lg"></span>${permission.name}</a>
                                 <ul class="mm-collapse">
                                     <c:forEach items="${permission.children}" var="child">
                                          <li><a href="${cx}${child.url}" id="${child.icon}">${child.name}</a></li>
                                     </c:forEach>
                                 </ul>
                             </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </nav>
        </aside>
        <!--该属性暂时没用-->
        <jsp:invoke fragment="extraNavigationContent"/>
    </jsp:attribute>

    <jsp:body>
        <!--页面主体 -->
        <jsp:doBody/>
    </jsp:body>


</template:basic_backend>
<%--MD5加密--%>
<script src="${cx}/resource/static/js/jquery.md5.js"></script>