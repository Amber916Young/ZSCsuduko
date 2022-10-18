<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%@ page import="jee.support.constants.OpCode" %>

<head>
    <meta charset="UTF-8">
    <!--IE Compatibility modes-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--Mobile first-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>领航科技公司 :: 用户登录</title>
    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="${cx}/resource/static/assets/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="${cx}/resource/static/assets/font-awesome/4.7.0/css/font-awesome.css">

    <!-- Metis core stylesheet -->
    <link rel="stylesheet"
          href="${cx}/resource/static/bootstrap-adim/main.css">

    <%--<!-- metisMenu stylesheet -->--%>
    <%--<link rel="stylesheet" href="assets/lib/metismenu/metisMenu.css">--%>

    <!-- onoffcanvas stylesheet -->
    <link rel="stylesheet"
          href="${cx}/resource/static/assets/onoffcanvas/onoffcanvas.min.css">

    <!-- animate.css stylesheet -->
    <link rel="stylesheet"
          href="${cx}/resource/static/assets/animate.css/animate.css">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <%--<!--[if lt IE 9]>--%>
    <%--<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>--%>
    <%--<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>--%>
    <%--<![endif]-->--%>

</head>

<body class="login">
<!-- 顶部导航栏 -->
<header class="navbar navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand warning" href="#">
                <span class="glyphicon glyphicon-leaf"></span>
                领航科技公司票据客服系统v1.0
            </a>
        </div>
        <ul class="nav navbar-nav navbar-right">

            <li><a href="###"><span
                    class="glyphicon glyphicon-book"></span>帮助</a></li>
        </ul>
    </div>
</header>

<div class="form-signin">
    <div class="text-center">
        <img src="${cx}/resource/static/img/logo.png" alt="领航科技公司">
    </div>
    <hr>
    <div class="tab-content">
        <div id="login" class="tab-pane active">
            <form action="${cx}/login" method="POST">
                <p class="text-muted text-center">
                    请输入您的账号和密码
                </p>
                <input name="username" type="text" value="" placeholder="用户名"
                       class="form-control top">
                <input name="password" type="password" placeholder="密码"
                       class="form-control bottom">
                <div class="checkbox">
                    <label>
                        <input type="checkbox">记住我
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block"
                        type="submit">登入
                </button>
                <%--账号验证失败--%>
                <c:if test="${login_status == OpCode.INVALID_USER}">
                    <div class="alert alert-danger">
                        用户名或密码错误,请重新输入
                    </div>
                </c:if>
            </form>
        </div>
        <div id="forgot" class="tab-pane">
            <form action="index.html">
                <p class="text-muted text-center">输入你注册的Email地址</p>
                <input type="email" placeholder="mail@domain.com"
                       class="form-control">
                <br>
                <button class="btn btn-lg btn-danger btn-block"
                        type="submit">忘记密码
                </button>
            </form>
        </div>
        <div id="signup" class="tab-pane">
            <form>
                <input id="username" name="username" type="text" placeholder="输入用户名"
                       class="form-control top">
                <div id="usernameResult"></div>
                <input type="email" placeholder="输入email地址(mail@domain.com)"
                       class="form-control middle">

                <input type="password" placeholder="输入密码"
                       class="form-control middle">
                <input type="password" placeholder="再次输入密码"
                       class="form-control bottom">
                <button class="btn btn-lg btn-success btn-block"
                        type="submit">注册
                </button>
            </form>
        </div>
    </div>
    <hr>
    <div class="text-center">
        <ul class="list-inline">
            <li><a class="text-muted" href="#login" data-toggle="tab">登录</a>
            </li>
            <li><a class="text-muted" href="#forgot" data-toggle="tab">找回密码
            </a></li>
            <li><a class="text-muted" href="#signup" data-toggle="tab">注册账号
            </a></li>
        </ul>
    </div>
</div>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${cx}/resource/static/assets/jquery/jquery-2.1.4.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="${cx}/resource/static/assets/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
    (function ($) {
        $(document).ready(function () {
            $('.list-inline li > a').click(function () {
                var activeForm = $(this).attr('href') + ' > form';
                //console.log(activeForm);
                $(activeForm).addClass('animated fadeIn');
                //set timer to 1 seconds, after that, unload the animate animation
                setTimeout(function () {
                    $(activeForm).removeClass('animated fadeIn');
                }, 1000);
            });
        });


    })(jQuery);

    alert("23");
    //    检查是否存在重复的用户名
    $(function () {
        $("#username").blur(function () {
            //发起ajax请求
            var value = $(this).val();

            $.ajax({
                method: "POST",  //提交的方法为POST
                url: "${cx}/checkUsername", //介绍数据URL路径
                data: JSON.stringify({username: value}),   //转换为字符串
                contentType: "application/json",
                success: function (result) {   //成功后的方法
                    if (result == "OK") {
                        $("#usernameResult").removeClass()
                            .addClass("alert alert-success")
                            .show().html("改用户名可以使用")
                    } else {
                        $("#usernameResult").removeClass()
                            .addClass("alert alert-success")
                            .show().html("已经存在，换一个！！");
                        $("#signup:input[name='username']")[0].focus();
                    }
                },
                error: function () {   // ajax请求失败
                    alert("ajax请求执行失败!");
                }
            })
        });
    });


</script>
</body>

</html>

