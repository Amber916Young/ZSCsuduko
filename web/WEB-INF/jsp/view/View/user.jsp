<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<template:index >
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/css/main.css">

    <style>
         body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td { margin:0; padding:0; }
        body, button, input, select, textarea { font:12px/1.5tahoma, arial, \5b8b\4f53; }
        body{    color: #000;}
        h1, h2, h3, h4, h5, h6{ font-size:100%; }
        address, cite, dfn, em, var { font-style:normal; }
        code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
        small{ font-size:12px; }
        ul, ol { list-style:none; }
        a { text-decoration:none;
            font: normal 600 14px / 22px "å®‹ä½“",Helvetica,Arial,Verdana,sans-serif;color: #333333;}
        a:hover { color: #da3a21;}
        .underline{
            background-color: #da3a21;
            position: absolute;
            display: block;
            overflow: hidden;
            left: 50%;
            bottom: -5px;
            width: 0;
            height: 1px;
            opacity: 0;
            -webkit-transition: all 0.6s cubic-bezier(0.215,0.61,0.355,1) 0s;
            transition: all 0.6s cubic-bezier(0.215,0.61,0.355,1) 0s;}
        sup { vertical-align:text-top; }
        sub{ vertical-align:text-bottom; }
        legend { color:#000; }
        fieldset, img { border:0; }
        button, input, select, textarea { font-size:100%; }
        table { border-collapse:collapse; border-spacing:0; }
        .navbar-nav>li>a {
            padding-top: 0;
            padding-bottom: 0;
            /*line-height:0*/
        }

        .header-nav li{
            display: inline;
            box-sizing: border-box;
            padding: 0.5em;
        }
        .header-logo img{
            width: 8em;
            height: auto;

            /* max-width:100%; */
        }
         .main{
             margin-top: 0.2em;
         }
        .txt{
            font: normal 600 14px / 22px "å®‹ä½“",Helvetica,Arial,Verdana,sans-serif;
        }
    </style>

    <div class="main" style="height: 30em">
        <div class="main-left" style="padding: 0 0 0 6em;background-color: white;" >
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <c:choose>
                <c:when test="${not empty viewuser}">
                    <c:if test="${not empty viewht}">
                        <div class="txt">
                                <p>
                                    <span>头像: </span>&nbsp;&nbsp;
                                    <img style="width: 200px; border: 1px solid black" src="${viewht.fileUrl}"/>
                                </p>
                        </div>
                    </c:if>
                    <c:if test="${not empty  viewuser.username}">
                        <div class="txt">用户名：${viewuser.username}</div>

                    </c:if>
                    <c:if test="${not empty  viewuser.integral}">
                        <div class="txt">用户积分：${viewuser.integral}</div>

                    </c:if>
                    <c:if test="${not empty  viewuser.grade}">
                        <div class="txt">年级：${viewuser.grade}</div>
                    </c:if>
                    <c:if test="${not empty  viewuser.department}">
                        <div class="txt">学院：${viewuser.department}</div>

                    </c:if>
                    <c:if test="${not empty  viewuser.gender}">
                        <div class="txt">性别：${viewuser.gender}</div>

                    </c:if>
                    <c:if test="${not empty  viewuser.sign}">
                        <div class="txt">个性签名：${viewuser.sign}</div>
                    </c:if>

                </c:when>
                <c:otherwise>
                    <b style="color: #1cd9ff"> 当前用户信息无法加载，可能是用户注销了</b>
                </c:otherwise>
            </c:choose>
        </div>

        <div  class="main-right" style="flex-basis: 50%; margin-right: 2em;  background-color: white;padding: 0 3em 0 0">
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <div class="table-responsive">
                <c:choose>
                    <c:when test="${pageInfo.total==0}">
                        <span class="glyphicon glyphicon-remove-sign" style="color: red"></span>
                        <b  style="color: darkred">当前用户暂时还没有做题哦~</b>
                    </c:when>
                    <c:otherwise>
                        <span class="glyphicon glyphicon-thumbs-up" style="color: green"></span>
                        <b style="color: red">当前用户完成题目情况</b><br><br>
                        <form id="userForm">
                            &nbsp;&nbsp;<strong>总${pageInfo.total}记录数,每页${pageInfo.pageSize}条,共${pageInfo.pages}页.
                            当前第${pageInfo.pageNum}页, 记录范围:${pageInfo.startRow}-${pageInfo.endRow},
                            共${pageInfo.size}条记录
                        </strong>  <br>  <br>
                            <c:forEach var="userscore" items="${pageInfo.list}" varStatus="a">
                                <div class="" style="margin-bottom: 1em;border: 1px #62d6ff dotted ">
                                    <a href="${cx}/view/suduko?id=${userscore.sudukoid}" style="text-indent:15px;" ><h5><strong>题目id:${userscore.id}</strong></h5></a>
                                    &nbsp;&nbsp;<span class="">完成日期：${userscore.finishTime}</span>
                                    &nbsp;&nbsp;<span class="">完成时间：${userscore.totaltime}秒</span>
                                </div>
                            </c:forEach>
                            <div class="text-right" style="text-align: center;">
                                <zsc:page url="${cx}/user/suduko"/>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
        </div>
    </div>
    </div>
</template:index>
