<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<!--该模板定义了页面的四个参数,即页面中的可变部分 -->
<!--参数1 html页面的标题title,参数类型为字符串-->
<%@ attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true"
              required="true" %>
<!--参数2 主页面标题bodyTitle,参数类型为字符串-->
<%@ attribute name="bodyTitle" type="java.lang.String" rtexprvalue="true"
              required="true" %>
<!--参数2 主页面标题bodyTitle,参数类型为区域代码段-->
<%@ attribute name="headContent" fragment="true" required="false" %>
<!--参数2 主页面标题bodyTitle,参数类型为区域代码段-->
<%@ attribute name="sideBar" fragment="true" required="true" %>
<%@ attribute name="bodyScript" fragment="true" required="false" %>
<!--包含的基本页面-->
<%@ include file="/WEB-INF/jsp/view/base.jspf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="AmberYoung">
    <title>数独运动协会 :: ${htmlTitle}</title>
    <!-- Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${cx}/resource/static/assets/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- font-awesome -->
    <link rel="stylesheet" href="${cx}/resource/static/assets/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- bootstrap table-->
    <link rel="stylesheet" href="${cx}/resource/static/assets/bootstrap-table/1.12.1/bootstrap-table.min.css">

    <!-- metis Menu-->
    <link rel="stylesheet" href="${cx}/resource/static/assets/metismenu/3.0.3/metisMenu.min.css">
    <link rel="stylesheet" href="${cx}/resource/static/assets/metismenu/3.0.3/css/mm-vertical.css">
    <link rel="stylesheet"  href="${cx}/resource/static/assets/metismenu/3.0.3/prism.css">
    <%--<link rel="stylesheet"--%>
    <%--href="${cx}/resource/static/assets/metismenu/3.0.3/animate.css">--%>
    <link rel="stylesheet" href="${cx}/resource/static/css/HideMenu/css/custom.css">
    <%--个人中心 日期选择器 等插件--%>


    <!-- 站点 自定义 样式 -->
    <link rel="stylesheet" href="${cx}/resource/static/css/site.css">
    <link rel="stylesheet" href="${cx}/resource/static/assets/bootstrap-fileinput/fileinput.min.css">

    <link rel="stylesheet" href="${cx}/resource/static/css/doc.min.css">
    <%--layer--%>
    <%--ztree--%>
    <link href="${cx}/resource/static/assets/ztree/zTreeStyle.css" rel="stylesheet">
    <%--<link rel="stylesheet" href="${cx}/resource/static/css/main.css">--%>
    <style type="text/css">
        .user-pic {
            float: left;
            width: 60px;
            height: 60px;
            padding: 2px;
            border: 1px solid #585858;
            border-radius: 8px;
            margin-right: 15px;
        }
        /*  */
        body{
            padding-top: 0;
        }
        /*.user-info {*/
            /**/
            /*color: #ccc;*/
            /*display: inline;*/
        /*}*/
        .gap{
            margin-top: 10px;
            margin-left: 20px;
        }

        /*.input-group  {*/
            /*width: 50%;*/
        /*}*/
        .file-input{
            width: 50%;
        }
        .file-preview{
            width: 60%;
        }
    </style>

    <!--jsp:invoke 表示此处插入具体页面的头部内容-->
    <jsp:invoke fragment="headContent"/>
</head>

<body>
<!-- 顶部导航栏 -->
<header class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${cx}/index/"><span class="glyphicon glyphicon-leaf"></span>数独运动协会</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="###"><span class="glyphicon glyphicon-user"></span>${user.username} </a></li>
            <li><a href="${cx}/logout"><span class="glyphicon glyphicon-log-out"></span>注销</a></li>
        </ul>
    </div>
</header>

<!-- 主体内容 -->
<section class="container-fluid">
    <!-- 侧边栏 菜单 -->
    <jsp:invoke fragment="sideBar"/>
    <!-- 页面主体 -->
    <div id="content" class="col-sm-10">

        <div class="page-header">
            <h4><span class="glyphicon glyphicon-home"></span> 主页 <span class="icon-home fa fa-angle-double-right"></span>${bodyTitle}</h4>
        </div><!-- /.page-header -->

        <div class="page-content">
            <%--页面主体内容--%>
            <jsp:doBody/>
        </div>
    </div>
</section>
<%--<%@ include file="/WEB-INF/jsp/view/footer.jsp" %>--%>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${cx}/resource/static/assets/jquery/jquery-2.1.4.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="${cx}/resource/static/assets/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${cx}/resource/static/assets/bootstrap-fileinput/fileinput.min.js"></script>
<script src="${cx}/resource/static/assets/bootstrap-fileinput/fileinput_locale_zh.js"></script>
<!-- metisMenu -->
<script src="${cx}/resource/static/assets/metismenu/3.0.3/metisMenu.min.js"></script>
<!-- 站点 自定义 函数库 -->
<script src="${cx}/resource/static/js/site.js"></script>

<script src="${cx}/resource/static/js/docs.min.js"></script>
<script src="${cx}/resource/static/assets/layer/3.1.1/layer.js"></script>
<script src="${cx}/resource/static/assets/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${cx}/resource/static/js/DateFormat.js"></script>
<!-- 页面 自定义 JS -->
<script>

    <%--详细样例需要参考metisMenu的demo--%>
    $(function () {
        $('#menu').metisMenu();

        //根据页面传进来的ItemId设置菜单状态
        // var url = window.location;
        //获取Id对应的菜单
        console.log("ItemId=" + ItemId);
        var element = $('#' + ItemId);

        console.log(element.html());

        if (element.is(':empty')) {
            return;
        }

        //如果以0结尾，对应菜单项标题菜单
        if (ItemId.charAt(ItemId.length - 1) == '0') {
            element.addClass('menuItemColor');
            element.css('color', 'white');
            //展开菜单
            element.parent().addClass("mm-active");
            element.next().addClass("mm-show");
            return;
        }
        //处理非第一个节点
        //获取<a></a>当前菜单项对应的父元素
        var currentItemLi = element.parent();
        //设置li的样式,高亮当前选项
        currentItemLi.addClass('active');
        //获取上一级ul元素
        var parentItemUl = currentItemLi.parent();
        //展开菜单
        parentItemUl.addClass("mm-show");
        var parentItemLi = parentItemUl.parent();
        // console.log("元素的html内容:"+parentItemLi.html());
        //设置父菜单项为active 状态
        parentItemLi.addClass("mm-active");
    });
    //根据传进去的参数设置菜单的状态



</script>

</body>
</html>
