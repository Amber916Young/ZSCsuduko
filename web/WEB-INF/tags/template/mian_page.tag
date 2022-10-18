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

<html  style=" overflow-x: scroll;
    height: auto;
    min-width: 1400px;">
<head >
    <title>数独运动协会</title>
    <meta name="viewport" content="width=device-width, initial-scale=1 , minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${cx}/resource/static/assets/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${cx}/resource/static/assets/font-awesome/4.7.0/css/font-awesome.css">
    <!--导航栏 bootsnav-->
    <link rel="stylesheet" href="${cx}/resource/static/bootsnav/css/bootsnav.css">

    <link rel="stylesheet" href="${cx}/resource/static/bootsnav/css/overwrite.css">
    <link rel="stylesheet" href="${cx}/resource/static/bootsnav/skins/color.css">
    <link href="${cx}/resource/static/bootsnav/css/animate.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/bootsnav/css/htmleaf-demo.css">
    <link href="${cx}/resource/static/bootsnav/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="${cx}/resource/static/vidbacking/css/jquery.vidbacking.css"/>

<%--轮播插件--%>
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/lunbo/jSlider.css" />
    <link rel="stylesheet" href="${cx}/resource/static/css/index.css">

    <style type="text/css">

        .carousel-caption a{
            color: white;
        }
        .carousel-caption a:hover{
            color: #ff7148;
        }
        img {  max-width: 100%; }

        #goTop {
            width: 50px;
            height: 50px;
            display: none;
            position: fixed;
            bottom: 300px;
            right: 1%;
            cursor: pointer;
            z-index: 1000;
            /*background: url(https://icon.fengniao.com/bbs/Index/images/bbsRightMenu.png) no-repeat -80px 0;*/
        }

        .navbar-brand > img{
            width: 0;
        }


        .d1 {
            background: #A3D0C3;
            width: 300px;
            float:right;
            margin-top: 20px;
            margin-right: 20px;
        }
        .d1 input {
            width: 258px;
            height: 42px;
            padding-left: 10px;
            border: 2px solid #7BA7AB;
            /*border-radius: 5px;*/
            outline: none;
            background: #F9F0DA;
            color: #9E9C9C;
        }
        .d1 button {
            float: right;
            top: 0;
            right: 0px;
            width: 42px;
            height: 42px;
            border: none;
            background: #7BA7AB;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }
        .d1 button:before {
            content: "\f002";
            font-family: FontAwesome;
            font-size: 16px;
            color: #F9F0DA;
        }
    </style>
</head>
<body style="height: auto;position: relative;">

<!-- Start Navigation   -->
<div class="container-fluid"  style="width:100%;min-width:720px;padding: 0">
    <nav class="navbar navbar-default navbar-fixed white bootsnav on no-full no-background">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="javascript:void(0);"  style="width:300px;">
                    <img src="${cx}/resource/static/bootsnav/images/brand/logo_wite.png" class="logo logo-display"
                         alt="无法显示" >
                    <img src="${cx}/resource/static/bootsnav/images/brand/logo_black.png" class="logo logo-scrolled"
                         alt="无法显示" >
                    <span>数独运动协会</span>
                </a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-menu">
                <ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
                    <li><a href="${cx}/index/">主页</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">关于协会</a>
                        <ul class="dropdown-menu">
                            <li><a href="${cx}/clubinformation/basicinformation">基本资料</a></li>
                            <li><a href="${cx}/clubinformation/constitution">组织章程</a></li>
                            <li><a href="${cx}/clubinformation/functions">部门职责</a></li>
                            <li><a href="${cx}/clubinformation/memberlist">会员列表</a></li>
                            <li><a href="${cx}/clubinformation/applymembership">入会申请</a></li>
                        </ul>
                    </li>
                    <%--<li class="dropdown">--%>
                    <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">趣味数独大赏</a>--%>
                    <%--<ul class="dropdown-menu">--%>
                    <%--<li class="dropdown">--%>
                    <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">变形数独</a>--%>
                    <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="#">杀手数独</a></li>--%>
                    <%--<li><a href="#">对角线数独</a></li>--%>
                    <%--<li><a href="#">数比数独</a></li>--%>
                    <%--<li><a href="#">窗口数独</a></li>--%>
                    <%--<li><a href="#">连续数独</a></li>--%>
                    <%--<li><a href="#">摩天楼独</a></li>--%>
                    <%--</ul>--%>
                    <%--</li>--%>
                    <%--<li >--%>
                    <%--<a href="#" class="dropdown-menu" ata-toggle="dropdown">标准九宫数独</a>--%>
                    <%--&lt;%&ndash;class="dropdown-toggle" d&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<ul class="dropdown-menu">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#">入门级</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#">中级</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#">高级</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li><a href="#">骨灰级</a></li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</ul>&ndash;%&gt;--%>
                    <%--</li>--%>
                    <%--</ul>--%>
                    <%--</li>--%>
                    <li><a href="${cx}/index/suduko" class="dropdown-toggle" data-toggle="dropdown">每日练习题</a></li>
                    <li><a href="${cx}/index/standard" class="dropdown-toggle" data-toggle="dropdown">数独技巧</a></li>
                    <%--<li class="dropdown">--%>
                    <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">数独技巧</a>--%>
                    <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="${cx}/index/standard">标准九宫数独</a></li>--%>
                    <%--<li><a href="${cx}/index/deformation">变形数独</a></li>--%>
                    <%--</ul>--%>
                    <%--</li>--%>
                    <li><a href="${cx}/index/activity" class="dropdown-toggle" data-toggle="dropdown">社团活动</a></li>
                    <li><a href="${cx}/index/connection">联系我们</a></li>
                    <c:choose>
                        <c:when test="${user.username==null||user.username==' '}">
                            <li><a id="login" data-toggle="modal" data-target="#myModal" href="###" id="UserHomepage">登陆</a></li>
                            <%--<li><a id="register" data-toggle="modal" data-target="#myModal2" href="" id="hiddenPage">注册</a></li>--%>
                        </c:when>
                        <c:otherwise>
                            <li ><a href="${cx}/user/home" id="user_infom"><span class="glyphicon glyphicon-home" style="color: rgb(113, 132, 193);"></span>欢迎 ${user.username}</a></li>
                            <li> <a href="${cx}/logout">注销</a></li>
                            <input type="hidden" value="${autoLogin}" id="identyauto">
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Start Home -->
    <%--<div class="pageheader fixed-demo dark" id="video-back" style=" height: 240px; padding-top: 110px; position: relative">--%>
        <%--<h2 class="title container" style="width: 400px; position: absolute; margin-left:15%;">数独运动协会</h2>--%>
        <%--<p class="container" style="position: absolute; margin-left: 15%; margin-top: 60px;">全称：电子科技大学中山学院数独运动协会</p>--%>
        <%--<div style=" position: absolute;--%>
            <%--padding: 10px;margin-left: 760px; text-indent: 2em; margin-bottom: 300px; width: 600px;">--%>
            <%--<div  width="400px" style="border-left: 2px white solid ;line-height:18px;background-image: url(${cx}/resource/static/img/bg.png);width:400px;bottom: 0; left: 0;;color: white">--%>
                <%--<p style="padding-left: 3px">--%>
                    <%--电子科技大学中山学院数独运动协会成立于2018年6月。--%>
                    <%--社团成立目的是为了丰富校园文体娱乐活动，营造良好的校园文化氛围。--%>
                    <%--帮助学生冷静思考、提高耐心、专注力和毅力。--%>
                <%--</p>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--
    data-navigation：控制是否显示前后导航按钮。值可以设置为"always", "none" 或 "hover"。
    data-indicator：控制是否显示圆点导航按钮。值可以设置为"always", "none" 或 "hover"。
    data-speed：控制轮播图的切换速度，单位毫秒。默认值为500。
    data-delay：控制轮播图的播放速度，单位毫秒，默认值为5000。
    data-transition：控制轮播图的动画过渡类型，值可以设置为"slide" 或 "fade"。
    data-loop：控制轮播图是否循环播放。
    data-group：该属性在gallery模式下使用。用于将图片进行分组。
    --%>
    <div id="slider1" class="jSlider" style="margin: 0 auto;" data-loop="true" >
        <div id="carousel1">
            <img src="${cx}/resource/static/test/test.jpg" alt="" />
            <div class="carousel-caption" style="color: white">标题 1</div>
        </div>
        <div id="carousel2">
            <img src="${cx}/resource/static/test/3407-swcUID.jpg" alt="" />
            <div class="carousel-caption" style="color: white">标题 2</div>
        </div>
        <div id="carousel3">
            <img src="${cx}/resource/static/test/test.jpg" alt="" />
            <div class="carousel-caption" style="color: white">标题 3</div>
        </div>
    </div>
    <%--参考 link http://www.htmleaf.com/jQuery/Slideshow-Scroller/201808025258.html --%>

    <!-- End Home -->
    <div class="row" style="padding: 10px 120px">
        <div class="col-sm-3" style="margin-left: 30px" id="deleteinfo">推荐分辨率90% <a style="cursor:pointer;color: red" onclick="deleteinfo()">×</a></div>
        <div class="col-sm-4 col-sm-offset-4">
            <form  id="From " class="d1" method="post"  action="${cx}/webIndex/query"   >
                <input type="text" name="q" id="q" placeholder="搜索从这里开始...">
                <button type="submit"></button>
            </form>
        </div>
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
                        <div style="margin-top: 10px">
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
                        <div style="margin-top: 15px">
                            <button  class="btn btn-primary col-sm-4 col-sm-offset-4">登陆</button>
                        </div>
                    </form><br>
                    <div style="margin-top: 10px">
                        <%--<a class="fa fa-paste" href="#" style="text-align: left">忘记密码？</a> &nbsp;&nbsp;--%>
                        <input type="checkbox" id="rememberMe" onclick="rememberMe()"> 记住我
                    </div>
                    <%
                        //产生随机数，和密码一起生成MD5
                        request.getSession().setAttribute("md5RandomKey", StringUtils.getRandomNum(8));
                    %>
                </div>
                <!-- 模态框底部 -->
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</div>




<!-- 模态框 register-->
<%--TODO 不设置 注册页面，仅仅提供给本社会员使用--%>
<%--<div class="modal fade" id="myModal2" style="text-align: center">--%>
    <%--<div class="modal-dialog">--%>
        <%--<div class="modal-content">--%>

            <%--<!-- 模态框头部 -->--%>
            <%--<div class="modal-header">--%>
                <%--<h4 class="modal-title center text-primary">用户注册</h4>--%>
                <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
            <%--</div>--%>

            <%--<!-- 模态框主体 -->--%>
            <%--<div class="modal-body " >--%>
                <%--<form action="${cx}/register" method="post">--%>
                    <%--<div class="gap">--%>
                        <%--<label class="fa fa-user">真实姓名：</label>--%>
                        <%--<input type="text" id="realname" class="realname" name="realname" placeholder="realname">--%>
                    <%--</div>--%>
                    <%--<div class="gap">--%>
                        <%--<label class="fa fa-user">用户名：</label>--%>
                        <%--<input type="text" id="checkusername" class="username" name="username" placeholder="username">--%>
                    <%--</div>--%>
                    <%--<div id="usernameResult"></div>--%>
                    <%--<diiv class="gap">--%>
                        <%--<label class="fa fa-empire">邮箱：</label>--%>
                        <%--<input type="text" name="email" placeholder="mail@domain.com">--%>
                    <%--</diiv>--%>
                    <%--<diiv class="gap">--%>
                        <%--<label class="fa fa-key">密码：</label>--%>
                        <%--<input class="password" id="password" type="password" name="password" placeholder="password">--%>
                        <%--<input type="checkbox" id="hide_password">查看密码</input>--%>
                    <%--</diiv>--%>
                    <%--<diiv class="gap">--%>
                        <%--<label class="fa fa-key">再次输入密码：</label>--%>
                        <%--<input type="password" id="repeat_password" name="repeat_password" placeholder="repeat_password">--%>
                    <%--</diiv>--%>
                    <%--<div id="passwordResult"></div>--%>
                    <%--<!--<label for="remember-me">记住我</label>-->--%>
                    <%--<!--<input type="checkbox" id="remember-me" />-->--%>
                    <%--<div class="gap">--%>
                        <%--<label>已成为会员?--%>
                            <%--<a id="change_login"  class="btn btn-danger" type="button" value="login" href="" data-target="#myModal">点击登陆</a>--%>
                        <%--</label>--%>
                    <%--</div>--%>
                    <%--<br><br>--%>
                    <%--<button id="check_null" class="btn btn-primary col-sm-4 col-sm-offset-4">注册</button>--%>

                <%--</form>--%>
            <%--</div>--%>
            <%--<!-- 模态框底部 -->--%>
            <%--<div class="modal-footer">--%>
            <%--</div>--%>

        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>


<%--内容--%>
<div id="page_content" style="background-color: rgb(255,255,255) ;width: 1400px;
    margin: 0 auto;">
        <!--页面主体 -->
    <jsp:doBody/>
</div>
<div id="goTop" style="display: block;text-align: center"></div>
<%@ include file="/WEB-INF/jsp/view/footer.jsp"%>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${cx}/resource/static/assets/jquery/jquery-2.1.4.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="${cx}/resource/static/assets/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
    function deleteinfo() {
        $("#deleteinfo").html(" ");
    }
    function checkData(){
        var question = $("#question").val.trim();
        if(question==""||question==null){
            alert("请输入需要查询的关键字");
            return false;
        }else{
            return true;
        }
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
        async5();
        var autoLogin = $("#identyauto").val();
        console.info(autoLogin);
        if(autoLogin=="success"){
            $.ajax({
                method: "POST",  //提交的方法为POST
                url: "${cx}/autologin", //数据URL路径
            })
        }


        // //记住密码功能
        // var str = getCookie("loginInfo");
        // str = str.substring(1,str.length-1);
        // var username = str.split(",")[0];
        // var password = str.split(",")[1];
        // //自动填充用户名和密码
        // $("#username").val(username);
        // $("#password").val(password);
        // if(str!=null && str!=""){
        //     $("input[type='checkbox']").attr("checked", true);
        // }

        //检查两次密码是否一致
        // $("#repeat_password").blur(function () {
        //
        //     var password = $("#password").val();
        //     var repeat_password=$("#repeat_password").val();
        //     alert(password);
        //     alert(repeat_password);
        //
        //     if(password==null||password==" "){
        //         $("#passwordResult").removeClass().addClass("alert alert-danger").show().html("密码不能为空");
        //         $('#passwordResult').delay(2000).hide(0);
        //         return;
        //     }else if(repeat_password==null||repeat_password==" "){
        //         $("#passwordResult").removeClass().addClass("alert alert-danger").show().html("重复密码不能为空");
        //         $('#passwordResult').delay(2000).hide(0);
        //         return;
        //     }else {
        //         if(password!=repeat_password){
        //             $("#passwordResult").removeClass().addClass("alert alert-danger").show().html("两次密码不一致，请检查");
        //             $('#passwordResult').delay(2000).hide(0);
        //             return;
        //         }
        //     }
        //
        // });

        // $("#change_Register").click(function () {
        //     alert("点击注册");
        //     $("#myModal").attr("display","none");
        //     $("#myModal2").modal();
        // });

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


    //自动登陆 填充 strat
    //获取cookie
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i=0; i<ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1);
            if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
        }
        return "";
    }

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
    //end
    function async5() {
        var i=0;
        var con="";
        $.ajax({
            async: true,
            method:"GET",
            url: "${cx}/index/carousel", //数据URL路径
            contentType: "application/json",
            success: function (result) {   //成功后的方法
                // alert(result.length);
                if(result.length==null){
                    console.info("carousel null");
                } else if(result.length==1){
                    var title = result[0].title;
                    var url = result[0].url;
                    var aurl = result[0].aurl;
                    con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='First slide'><div class='carousel-caption'><a href='" + aurl + "' style=\"color: white\">" + title + "</a></div>"
                    $("#carousel1").html(con);
                } else if(result.length==2) {
                    for (i = 0; i < 2; i++) {
                        var title = result[i].title;
                        var url = result[i].url;
                        var aurl = result[i].aurl;
                        if (i == 0) {
                            con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='First slide'><div class='carousel-caption'><a href='" + aurl + "' style=\"color: white\">" + title + "</a></div>"
                            $("#carousel1").html(con);
                        } else {
                            con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='Second slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"
                            $("#carousel2").html(con);

                        }
                    }
                }else if(result.length>=3){
                    for (i = 0; i < 3; i++) {
                        var title = result[i].title;
                        var url = result[i].url;
                        var aurl = result[i].aurl;
                        if (i == 0) {
                            con = "<img src='" + url + "'  style=' bject-fit:cover;'  alt='First slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"
                            $("#carousel1").html(con);
                        } else if (i == 1) {
                            con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='Second slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"
                            $("#carousel2").html(con);

                        } else {
                            con = "<img src='" + url + "'  style='object-fit:cover;'  alt='Third slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"
                            $("#carousel3").html(con);
                        }

                    }
                }
            },
            error: function () {   // ajax请求失败
                layer.msg("ajax请求执行失败!", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
    }
</script>
</body>
</html>
