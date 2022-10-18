<template:index>
    <style>
        body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td { margin:0; padding:0; }
        body, button, input, select, textarea { font:1em/1.5tahoma, arial, \5b8b\4f53; }
        body{    color: #000;}
        h1, h2, h3, h4, h5, h6{ font-size:100%; }
        address, cite, dfn, em, var { font-style:normal; }
        code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
        small{ font-size:1em; }
        ul, ol { list-style:none; }
        a { text-decoration:none;
            font: normal 600 1em / 2em "å®‹ä½“",Helvetica,Arial,Verdana,sans-serif;color: #333333;}
        a:hover { color: #da3a21;}
        .underline{
            background-color: #da3a21;
            position: absolute;
            display: block;
            overflow: hidden;
            left: 50%;
            bottom: -em;
            width: 0;
            height: em;
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
                <li class="breadcrumb-item"><a href="${cx}/index/">网站主222页</a></li>
                <li class="breadcrumb-item active" style="color: #000000">查询页</li>
            </ol>


            搜索&nbsp;<front style="color:red" >${q}</front>&nbsp;的结果&nbsp;（总共搜索到）&nbsp;${resultTotal}&nbsp;条记录
        </div>
        <div class=""  >
            <div class="table-responsive container" >
                <c:choose>
                    <c:when test="${activityList.size()==0}">
                        <div align="center" style="padding-top: 2em">未查到，请换个关键字</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="blog" items="${activityList}">
                            <li style="padding-top: 2em">
                                <span style="color: #0b6694"><b>标题：</b></span>&nbsp;&nbsp;
                                <span class="title">
                                    <a href="${cx}/view/activity?id=${blog.id}" target="_blank">${blog.title}</a>
                                </span>
                                <span class="summary"><span style="color: #0b6694">摘要：</span>${blog.content}...</span>
                                <a>&nbsp;&nbsp;&nbsp;发布日期${blog.time}</a>
                            </li>

                        </c:forEach>

                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>




</template:index>
<script type="text/javascript">


</script>