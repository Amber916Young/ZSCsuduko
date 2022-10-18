<template:index >
    <style type="text/css">
        .post-intro:hover{
            background-color: rgba(215, 239, 255, 0.4);
        }
        .post-intro a:hover{text-decoration:underline;}
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
            display: flex;
            margin-top: 0.2em;
        }
    </style>
    <div class="container-fluid" style="margin-top: 0.2em;width: 97%;">
        <ol class="breadcrumb" style=";border-radius: 0;color: #004957">
            当前位置：
            <li class="breadcrumb-item"><a href="${cx}/index/">网站主页</a></li>
            <li class="breadcrumb-item active" style="color: #000000"></li>
        </ol>
    </div>
    <div class="container-fluid" style="margin-bottom: 5em" >
        <div class="panel-body">
            搜索&nbsp;<front style="color:red">${q}</front>&nbsp;的结果&nbsp;（总共搜索到）&nbsp;${resultTotal}&nbsp;条记录
        </div>
        <div class="" style="position:relative " >
            <div class="table-responsive container" >
                <c:choose>
                    <c:when test="${activityList.size()==0}||${articleList.size()==0}">
                        <div align="center" style="padding-top: 20px">未查到，请换个关键字</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="blog" items="${activityList}" varStatus="status">
                            <div class="archive-list-item" style="padding: 13px;background: #fbfbfb;border-top: 1px solid #efefef;border-bottom: 1px solid #efefef;">
                                <div class="post-intro">
                                    <li style="padding-top: 20px;list-style:none;">
                                        <h5 style="color: #64854c"><b>标题:</b>
                                            <span class="title">
                                        <a href="${cx}/view/activity?id=${blog.id}" target="_blank">${blog.title}</a>
                                    </span>
                                            <i class="fa fa-external-link"></i>
                                        </h5>&nbsp;&nbsp;
                                        <span style="color: #0e1b70"><b>摘要:</b></span> <span class="summary" id="summary${status.count}">${blog.content}...</span>
                                        <span style="float: right">发布日期:<a href="${cx}/view/activity?id=${blog.id}" target="_blank">&nbsp;&nbsp;${blog.time}</a></span>
                                    </li>
                                </div>
                            </div>
                            <c:if test="${status.last}">
                                <input type="hidden" value="${status.count+1}" id="count">
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${articleList.size()==0}||${activityList.size()==0}">
                        <%--<div align="center" style="padding-top: 20px">未查到，请换个关键字</div>--%>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="blog2" items="${articleList}" varStatus="status2">
                            <div class="archive-list-item" style="padding: 13px;background: #fbfbfb;border-top: 1px solid #efefef;border-bottom: 1px solid #efefef;">
                                <div class="post-intro">
                                    <li style="padding-top: 20px;list-style:none;">
                                        <h5 style="color: #64854c"><b>标题:</b>
                                            <span class="title">
                                                    <a href="${cx}/view/particles?id=${blog2.id}" target="_blank">${blog2.title}</a>
                                                </span>
                                            <i class="fa fa-external-link"></i>
                                        </h5> &nbsp;&nbsp;
                                        <span style="color: #0e1b70"><b>摘要:</b></span> <span class="summary" id="summary2${status2.count}">${blog2.content}...</span>
                                        <span style="float: right">发布日期:<a href="${cx}/view/particles?id=${blog2.id}" target="_blank">&nbsp;&nbsp;${blog2.time}</a></span>
                                    </li>
                                </div>
                            </div>
                            <c:if test="${status2.last}">
                                <input type="hidden" value="${status2.count+1}" id="count2">
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</template:index>
<script type="text/javascript">

    // $(function () {
    //     var count=$("#count").val();
    //     var count2=$("#count2").val();
    //     // alert("count"+count);
    //     console.info("count=="+count);
    //     for(var i =1;i<=count;i++){
    //         var content = $("#summary"+i).text();
    //         // console.info("content=="+content);
    //         var content1_2 =  removeHTMLTag(content);
    //         // console.info("content1_2=="+content1_2);
    //         // console.info("#summary"+i)
    //         $("#summary"+i).text(content1_2);
    //     }
    //     console.info("count2=="+count2);
    //     for(var j= 1;j<=count2;j++){
    //         var content2 = $("#summary2"+j).text();
    //         // console.info("#summary2"+j)
    //         // console.info(content2);
    //         var content2_2 =  removeHTMLTag(content2);
    //         // console.info(content2_2);
    //         $("#summary2"+j).text(content2_2);
    //     }
    // } );

    // TODO 有bug 暂时没能去除富文本格式
    // function removeHTMLTag(str) {
    //     // str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
    //     // str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
    //     // str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
    //     // str = str.replace(/&nbsp;/ig, '');//去掉&nbsp;
    //     // str = str.replace(/<[^>]+>|&[^>]+;/g,"").trim();
    //     //
    //     // console.log(str);
    //     // return str;
    //
    //     var data =str;
    //     data = data.replace(/(\n)/g, "");
    //     data = data.replace(/(\t)/g, "");
    //     data = data.replace(/(\r)/g, "");
    //     data = data.replace(/<\/?[^>]*>/g, "");
    //     data = data.replace(/\s*/g, "");
    //     return data;
    // }

</script>