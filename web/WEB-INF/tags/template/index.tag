<%--
  Created by IntelliJ IDEA.
  User: 杨叶佳
  Date: 2019/2/8
  Time: 21:47
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ tag contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ include file="footer.jsp" %>--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ tag import="jee.support.constants.OpCode" %>
<%@ tag import="jee.support.entity.StringUtils" %>
<!--该模板定义了页面的四个参数,即页面中的可变部分 -->
<!--参数1 html页面的标题title,参数类型为字符串-->
<%--<%@ attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true" %>--%>

<!--参数2 主页面标题bodyTitle,参数类型为字符串-->
<%--<%@ attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true" required="true" %>--%>

<!--参数2 主页面标题bodyTitle,参数类型为区域代码段-->
<%@ attribute name="headContent" fragment="true" required="false" %>
<%--TODO 这个页面需要传递的val有哪些都需要写进来  比如导航页要一直显示用户的基本url 名称--%>
<%--<%@ attribute name="username" type="java.lang.String" rtexprvalue="true" required="true" %>--%>
<%--<%@ attribute name="userurl" type="java.lang.String" rtexprvalue="true" required="true" %>--%>

<!--参数2 主页面标题bodyTitle,参数类型为区域代码段-->
<%--<%@ attribute name="sideBar" fragment="true" required="true" %>--%>
<%--<%@ attribute name="bodyScript" fragment="true" required="false" %>--%>

<!--包含的基本页面-->
<%@ include file="/WEB-INF/jsp/view/base.jspf" %>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width= , initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="${cx}/resource/static/img/favicon.ico" type="image/x-icon" rel="icon">
    <title>数独运动协会</title>
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/css/main.css">
    <link rel="stylesheet" href="${cx}/resource/static/css/index.css">
    <link href="https://cdn.bootcss.com/bootstrap-select/1.12.4/css/bootstrap-select.min.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${cx}/resource/static/assets/bootstrap/3.3.7/css/bootstrap.min.css">
    <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">--%>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="${cx}/resource/static/assets/font-awesome/4.7.0/css/font-awesome.css">
    <!--导航栏 bootsnav-->
    <link rel="stylesheet" href="${cx}/resource/static/bootsnav/css/bootsnav.css">
    <%--<link rel="stylesheet" href="${cx}/resource/static/bootsnav/css/overwrite.css">--%>
    <link rel="stylesheet" href="${cx}/resource/static/bootsnav/skins/color.css">
    <link href="${cx}/resource/static/bootsnav/css/animate.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/bootsnav/css/htmleaf-demo.css">
    <link href="${cx}/resource/static/bootsnav/css/style.css" rel="stylesheet">

    <%--轮播插件--%>
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/lunbo/jSlider.css" />
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
        body{
            background: #e5e5e5 none no-repeat fixed center top;
        }
        html{
            min-width:950px;
            /*min-width:850px;*/
        }

        .header{
            display: flex;
            justify-content: space-between;
            background-color: #feffff;
            margin-left: 2em;
            margin-right: 2em;
            margin-top: 1em;
            height: 7em;
        }

        .header-logo{
            /* width: 50%; */
            margin: auto 3em;
        }

        .header-nav{
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .header-nav li{
            display: inline;
            box-sizing: border-box;
            padding: 0.5em;
        }
    </style>
</head>
<body style="padding-right: 0px !important;">
<div class="header">
    <div class="header-logo">
        <img src="${cx}/resource/static/bootsnav/images/brand/logo_black.png" alt="logo" >
        <div style="display:contents;vertical-align: middle;font-size: 1.25em"><b>数独运动协会</b></div>
    </div>
    <div class="header-nav" style="font-size: 1em;">
        <ul >
            <li><a href="${cx}/index/">首页</a><i class="underline"></i></li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">关于</a>
                <span class="caret"></span>
                <ul class="dropdown-menu">
                    <li><a href="${cx}/clubinformation/basicinformation">基本资料</a></li>
                    <li><a href="${cx}/clubinformation/constitution">组织章程</a></li>
                    <li><a href="${cx}/clubinformation/functions">部门职责</a></li>
                    <li><a href="${cx}/clubinformation/memberlist">会员列表</a></li>
                    <li><a href="${cx}/clubinformation/applymembership">入会申请</a></li>
                </ul>
            </li>

            <li><a href="${cx}/index/suduko">数独题库</a></li>
            <li><a href="${cx}/index/standard">技巧文章</a></li>
            <li><a href="${cx}/index/activity">社团活动</a></li>
            <li><a href="${cx}/index/connection">联系</a></li>
            <c:choose>
                <c:when test="${user.username==null||user.username==' '}">
                    <li><a id="login" onclick="myModalShow()" data-target="#myModal" href="#" id="UserHomepage">登陆</a></li>
                </c:when>
                <c:otherwise>
                    <li ><a href="${cx}/user/home" id="user_infom"><span class="glyphicon glyphicon-home" style="color: rgb(113, 132, 193);"></span>欢迎 ${user.username}</a></li>
                    <li> <a href="${cx}/logout">注销</a></li>
                    <input type="hidden" value="${autoLogin}" id="identyauto">
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

    <!-- 模态框 -->
    <div class="modal fade" id="myModal" style="text-align: center">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h4 class="modal-title center text-primary">用户登陆</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- 模态框主体 -->
                <div class="modal-body">
                    <form method="post" action="${cx}/login" onsubmit="Recodepwd()"  >
                        <div >
                            <label  class="fa fa-user">用户名：</label>
                            <input type="text" name="username" placeholder="username" >
                        </div>
                        <div style="margin-top: 1em">
                            <label class="fa fa-key">密码：</label>
                            <input type="password" id="password" placeholder="password" >
                            <input type="hidden" id="pwd" name="password">
                        </div>
                        <br>
                        <c:if test="${login_status == OpCode.INVALID_USER}">
                            <div class="alert alert-danger">
                                用户名或密码错误,请重新输入
                            </div>
                        </c:if>
                        <c:if test="${not empty loginmsg}">
                            <div class="alert alert-danger">
                                    ${loginmsg}
                            </div>
                        </c:if>
                        <div style="margin-top: 1.2em">
                            <button  class="btn btn-primary col-sm-4 col-sm-offset-4">登陆</button>
                        </div>
                    </form><br>
                    <div style="margin-top: 1em">
                        <%--<a class="fa fa-paste" href="#" style="text-align: left">忘记密码？</a> &nbsp;&nbsp;--%>
                        <input type="checkbox" id="rememberMe" onclick="rememberMe()"> 记住我
                    </div>
                </div>
                <!-- 模态框底部 -->
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</div>
<%--内容--%>
<jsp:doBody/>

<%--<div id="goTop" style="display: block;text-align: center"></div>--%>
<%@ include file="/WEB-INF/jsp/view/footer.jsp"%>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${cx}/resource/static/assets/jquery/jquery-2.1.4.min.js"></script>
<%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>

<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="${cx}/resource/static/assets/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
<%--MD5加密--%>
<script src="${cx}/resource/static/js/jquery.md5.js"></script>
<%--轮播--%>
<%--<script src="${cx}/resource/static/lunbo/jquery-latest.min.js"></script>--%>
<script src="${cx}/resource/static/lunbo/jquery.jSlider.js"></script>

<script src="${cx}/resource/static/assets/bootstrap-fileinput/fileinput.min.js"></script>
<script src="${cx}/resource/static/assets/bootstrap-fileinput/fileinput_locale_zh.js"></script>
<!-- metisMenu -->
<script src="${cx}/resource/static/assets/metismenu/3.0.3/metisMenu.min.js"></script>
<!-- 站点 自定义 函数库 -->
<script src="${cx}/resource/static/js/site.js"></script>
<script src="${cx}/resource/static/bootsnav/js/bootsnav.js"></script>
<script src="${cx}/resource/static/js/docs.min.js"></script>
<script src="${cx}/resource/static/assets/layer/3.1.1/layer.js"></script>
<script src="${cx}/resource/static/assets/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${cx}/resource/static/js/DateFormat.js"></script>
<%--登陆注册--%>
<%--自定义的js--%>

<script>

    function myModalShow(){
        $('#myModal').modal('show');
    }
    $('#hide_password').on('click', function () {
        var password =$("#password").val();
        var node_password=$("#password");
        var node_attr=$("#password").attr("type");
        if(node_attr == "password"){
            if(password!=null||password!=" "){
                node_password.attr("type","text");
            }else{
                return;
            }
        } else{
            node_password.attr("type","password");
        }
    });

    //    检查是否存在重复的用户名
    $(function () {
        var autoLogin = $("#identyauto").val();
        console.info(autoLogin);
        if(autoLogin=="success"){
            $.ajax({
                method: "POST",  //提交的方法为POST
                url: "${cx}/autologin", //数据URL路径
            })
        }



        $("#change_login").click(function () {
            alert("点击登陆");
            $("#myModal2").attr("display","none");
            $("#myModal").modal();
        });

        $("#check_null").click(function () {
            var username = $(".username").val();
            var password = $(".password").val();
            if(username==null||username==""){
                layer.msg("登陆账号不能为空，请输入",{time:2000,icon:5,shift:6},function () {

                });
                return;
            }

        });
        $("#checkusername").blur(function () {
            //发起ajax请求

            var value = $(this).val();
            $.ajax({
                method: "POST",  //提交的方法为POST
                url: "${cx}/checkUsername", //数据URL路径
                data: JSON.stringify({username: value}),   //转换为字符串
                contentType: "application/json",
                success: function (result) {   //成功后的方法
                    if (result == "OK") {
                        $("#usernameResult").removeClass()
                            .addClass("alert alert-success")
                            .show("slow").html("这个用户名可以使用");
                        // $('#usernameResult').fadeOut(3000,"slow");
                        $('#usernameResult').delay(2000).hide(0);
                    }else if(result=="no"){
                        $("#usernameResult").removeClass()
                            .addClass("alert alert-success")
                            .show("slow").html("用户名不能为空");
                        $('#usernameResult').delay(2000).hide(0);
                    }
                    else {
                        $("#usernameResult").removeClass()
                            .addClass("alert alert-danger")
                            .show().html("已经存在，换一个！！");
                        $('#usernameResult').delay(2000).hide(0);
                        $("#signup:input[name='username']")[0].focus();
                    }
                },
                error: function () {   // ajax请求失败
                    alert("ajax请求执行失败!");
                }
            })
        });
    });




    function rememberMe() {
        var remFlag = $("input[type='checkbox']").is(':checked');

        if(remFlag==true){ //如果选中设置remFlag为true
            //cookie存用户名和密码,回显的是真实的用户名和密码,存在安全问题.
            var conFlag = confirm("记录密码功能不宜在公共场所(如网吧等)使用,以防密码泄露.您确定要使用此功能吗?");
            if(conFlag){ //确认标志
                $("#remFlag").val(true);
            }else{
                $("input[type='checkbox']").removeAttr('checked');
                $("#remFlag").val(false);
            }
        }else{ //如果没选中设置remFlag为false
            $("#remFlag").val(false);
        }
    }
    function Recodepwd() {
        //表单提交时对输入的密码进行加密， 避免抓包分析破解密码
        var password=$("#password").val();
        var pwd=$.md5(password);
        // alert("pwd"+pwd);
        $("#pwd").val(pwd);
    }

</script>
</body>
</html>
