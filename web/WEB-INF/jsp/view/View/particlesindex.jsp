<%@ page import="jee.support.entity.Article" %>
<%@ page import="java.util.ArrayList" %>
<template:index>
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

    .main{
        display: flex;
        margin-top: 0.2em;
    }

    .main-left{
        flex:1;
        margin-left: 2em;

        background-color: white;
    }

    .main-right{
        flex-basis: 33.33%;
        background-color: #white;
        margin-right: 2em;
    }



    .header-logo img{
        width: 8em;
        height: auto;

        /* max-width:100%; */
    }

    temp a{
        color: #004957;
    }
    temp a:hover{
        text-decoration:underline;
        color: #ff7932;
    }
    footer a{
        color: white;
    }
</style>

    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">
        <div class="panel-body">
            <ol class="breadcrumb" style=";border-radius: 0;color: #004957">
                当前位置：
                <li class="breadcrumb-item"><a href="${cx}/index/">网站主页</a></li>
                <li class="breadcrumb-item active" >数独技巧</li>
            </ol>

            <%--<form class="form-inline" role="form" style="margin-left: 20%">--%>
                <%--<div class="form-group has-feedback">--%>
                    <%--<div class="input-group">--%>
                        <%--<div class="input-group-addon">查询内容</div>--%>
                        <%--<input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询关键字">--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>--%>
            <%--</form>--%>

            <div class="table-responsive container" >
                <form id="userForm">
                <c:choose>
                    <c:when test="${not empty articleList}">
                        &nbsp;&nbsp;<strong>总${pageInfo.total}记录数,每页${pageInfo.pageSize}条,共${pageInfo.pages}页.
                        当前第${pageInfo.pageNum}页, 记录范围:${pageInfo.startRow}-${pageInfo.endRow},
                        共${pageInfo.size}条记录 </strong>  <br>  <br>
                        <c:forEach var="temp" items="${pageInfo.list}" varStatus="loop"  >
                            <div  class="temp col-md-4" style="border: 2px dotted #004957;width: 40%;padding-left: 10px;margin-right: 50px ;margin-bottom: 25px">
                                <b><p style="color: #004957;text-align: left" > 数独类型：${temp.type}</p></b>
                                <c:if test="${temp.type.equals('变形九宫数独')||temp.type.equals('变形六宫数独')}">
                                    <h6>${temp.typemsg}</h6>
                                </c:if>
                                <p><h4><a href="${temp.url}">标题：${temp.title}</a></h4></p>
                                <h6>作者：${temp.name}&nbsp;&nbsp; 时间：${temp.time}</h6>
                                <div style="padding-left: 10px;padding-right: 10px;border: 1px solid #d7c5fc ;background-color: #cde4fc;width: 94%;margin-bottom: 10px">
                                    ${temp.content}
                                </div>
                                <a href="${temp.url}">more>></a>
                            </div>
                        </c:forEach>
                        <div class="col-md-8 text-right" style="margin-top: 70px">

                            <zsc:page url="${cx}/index/standard"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                    <div class="col-md-4" style="border: 5px dotted #004957;width: 40%;padding-left: 10px;margin-right: 50px ;margin-bottom: 25px">
                        <p style="color: red"> 当前没有写技巧文章</p>
                    </div>
                    </c:otherwise>
                </c:choose>
                </form>

                <%--<div class="col-md-4" style="border: 5px dotted #004957;width: 40%;padding-left: 10px;margin-right: 50px ;margin-bottom: 25px">--%>
                    <%--<p><h4><a href="#"标题>sss</a></h4></p>--%>
                    <%--<h5>作者：sss</h5>--%>
                    <%--<div style="padding-left: 10px;padding-right: 10px;border: 1px solid #d7c5fc ;background-color: #cde4fc;width: 94%;margin-bottom: 10px">--%>
                        <%--neir--%>
                    <%--</div><a href="#">more</a>--%>
                <%--</div>--%>

            </div>
        </div>
    </div>




</template:index>
<script type="text/javascript">

    function ViewDetail(id) {
        window.location.href = "${cx}/view/particles?id="+id;
    }


</script>