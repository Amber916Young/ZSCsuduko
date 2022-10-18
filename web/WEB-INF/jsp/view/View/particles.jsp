<template:index >
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <style >
    .one {
        padding: 2em;
        /*margin-top: 2em;*/
        margin-bottom: 2em;
        background-color: white;
        border-radius: 1em;
        /*height: 2000px;*/
        word-break: break-all;white-space: normal;overflow:auto;
    }
    #commentData a{
        color: #0c1119;
    }
    #commentData a:hover{
        color: #ff3504;
    }

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
        width: 29em;
        background-color: white;
    }
    .header-logo img{
        width: 8em;
        height: auto;

        /* max-width:100%; */
    }

    /*img{*/
        /*width: 2em;*/
    /*}*/

    </style>
    <%--share.css 分享--%>
    <link rel="stylesheet" href="${cx}/resource/static/share/css/share.min.css">
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/css/main.css">
    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">
        <div class="panel-body" >
            <ol class="breadcrumb" style=";border-radius: 0;color: #004957">
                当前位置：
                <li class="breadcrumb-item"><a href="${cx}/index/">网站主页</a></li>
                <li class="breadcrumb-item"><a href="${cx}/index/standard">精选技巧文章首页</a></li>
                <li class="breadcrumb-item active" style="color: #000000">${article.title}</li>
                <input type="hidden" value="${article.url}" id="aurl">
                <input type="hidden" value="${article.title}" id="atitle">
            </ol>
                <%--<h5 class="title">统计页面访问次数</h5>--%>
                <%--<%! int count = 0; %>--%>
                <%--<% count++; %>--%>
                <%--该页面已被访问<%= count %>次--%>
        </div>
    </div>
    <div class="main" style="display: flex;">
        <div class="main-left" style="">
            <div class="one" >
                <input type="hidden" value="${user.username}" id="username">
                <input type="hidden" value="${user.realname}" id="real"/>
                <input type="hidden" value="${article.id}" id="aid">

                <div class=""><strong><h3 style="text-align: center">${article.title}</h3></strong></div>
                <div class=""><strong><h5 style="text-align: left">数独类型：${article.type}</h5></strong></div>
                <div class=""><strong><h6 style="text-align: left">具体名称：${article.typemsg}</h6></strong></div>

                <p style="text-indent:50px;">作者:${article.name}
                    <span class="glyphicon glyphicon-comment " style="color: rgb(255, 5, 69);float: right;margin-right: 20px"><a href="#comment">评论：${allcomments}</a></span>
                </p>
                <hr style="margin-bottom: 1em;margin-top: 1em;color: #0c1119">
                    ${article.content}
                <br><br>

            </div>
            <div style="margin: 0 0 2em 2em">
                <i class="fa fa-share" aria-hidden="true"></i>
                <span  style="color:darkolivegreen;font-weight:bold" >分享一下:</span>
                <div id="social-share" ></div>
            </div>
        </div>
        <div class="main-rightarticle" style="background-color: #fdfdfe;padding-top: 2em;padding-right: 2em;">
            <h4 style="margin-bottom: 0">社团近期活动<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ News</span></span></h4>
            <img src="${cx}/resource/static/img/button.png" alt="01" title="01" id="img_smv_con_222_36" style="height: 20px; width: 232px;">
            <c:forEach var="temp" items="${pageInfo.list}"  varStatus="loop"   begin="0" end="4" step="1">
                <c:if test="${temp.status ==1}">
                    <div  style="font-size: 16px;height: 55px;padding: 10px 10px 0;">
                        <a href="${cx}/view/activity?id=${temp.id}" target="_blank" style="font-family: 微软雅黑;color: rgb(102, 102, 102);" >${temp.title}</a>
                    </div>
                    <div style="border-right: none;border-left: none;border-top: none;display: block;border-width: 1px; border-color: #e5e5e5;border-style: dashed;"></div>
                </c:if>
            </c:forEach>
            <hr style=" border: none; color: red;background: red;height: 1px;margin: 10px 0;">
            <h4 style="margin-bottom: 0">精选文章<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ Articles</span></span></h4>
            <img src="${cx}/resource/static/img/button.png" alt="01" title="01" id="img_smv_con_222_36" style="height: 20px; width: 232px;">
            <c:forEach var="temp2" items="${articlepageInfo.list}" varStatus="loop">
                <c:if test="${temp2.status ==1}">
                    <div style="font-size: 16px;height: 55px;padding: 10px 10px 0;">
                        <a href="${cx}/view/particles?id=${temp2.id}" target="_blank" style="font-family: 微软雅黑;color: rgb(102, 102, 102);" >${temp2.title}</a>
                    </div>
                    <div style="border-right: none;border-left: none;border-top: none;display: block;border-width: 1px; border-color: #e5e5e5;border-style: dashed;"></div>
                </c:if>
            </c:forEach>
            <hr style=" border: none;height: 1px;margin: 10px 0;">
            <h4 style="margin-bottom: 0">社团周边<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ Articles</span></span></h4>
            <img src="${cx}/resource/static/img/button.png" alt="01" title="01" id="img_smv_con_222_36" style="height: 20px; width: 232px;">
            <div class="box"  style=" margin-top:10px;height: 300px;">
                <div class="banner">
                    <!-- 添加图片 -->
                    <div class="move" id="move">
                        <ul style="padding: 0;">
                            <c:forEach var="list" items="${zhoubianList}" >
                                <li><img src="${list.fileUrl}" width="200px" alt="图片损坏"><p style="text-align: center;width: 200px">${list.title}</p></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <!-- 添加控制条 -->
                    <div class="ctrl" id="ctrl"></div>
                </div>
            </div>
        </div>

    </div>

    <!------------------------------------------------------------------------------------->
    <!--评论-->

    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">
        <div>

        </div>

        <div class="comment col-sm-12" style="margin-bottom: 2em">
        <div style="margin-bottom: 1em"><span class="glyphicon glyphicon-user" style="color: rgb(84,84,84);"> <b>用户名：${user.username}</b></span>
            <input type="hidden" id="SaveUsername" value="" disabled="disabled">
        </div>


        <br>
        <div class="form-group" id="">
            <label for="commentData">评论: <b style="margin-left: 3em ;color:#bc656e;">字数限制在200个字符内</b></label>
            <p style="color: #0f5179;margin-left: 2em" id="errormsg"></p>
            <!--禁止拉伸style="resize:none" -->
            <c:choose>
                <c:when test="${user.username==null}">
                    <textarea disabled="disabled"  class="form-control" rows="5" id="msg_comment1" style="width: 600px;resize:none;text-align: center">您还没有登陆</textarea>
                </c:when>
                <c:otherwise>
                    <textarea class="form-control" onkeyup="check()" maxlength="200"  rows="5" id="comment" style="width: 600px;resize:none"></textarea>
                    <br>
                    <button onclick="submitCom()" id="submitCom" type="button" class="btn btn-primary sub" style="margin-left: 500px">提交</button>
                </c:otherwise>
            </c:choose>

            <!--此处显示评论-->
            <div id="commentData" class="comment" >
            </div>
            <table width="100%" >
                <tr >
                    <td colspan="12" align="center">
                        <ul class="pagination">
                        </ul>
                    </td>
                </tr >
            </table>
        </div>
    </div>
    </div>
    <!------------------------------------------------------------------------------------->

</template:index>
<script  type="text/javascript" color="0,0,0" opacity='0.7' zIndex="-2" count="99" src="//cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.min.js"></script>
<script src="${cx}/resource/static/js/myscroll.js"></script>
<%--分享share.js--%>
<%--<script src="http://apps.bdimg.com/libs/jquery/1.8.2/jquery.js"></script>--%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${cx}/resource/static/share/js/jquery.share.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('#banner1').myscroll({
            picEl: $('#move'), //图片父级，不传默认为banner内第1个div
            ctrlEl: $('#ctrl'), //控制条父级，包括小圆点和左右箭头，不传默认为banner内第2个div
            libs: false, //是否创建底部小圆点，true || false,不传默认true
            arrows: false, //是否创建左右箭头，true || false,不传默认true
            autoPlay: true, //是否自动播放，true || false,不传默认true
            time: 2000, //自动播放间隔时间，true || false,不传默认2000
            speed: 400, //图片切换速度，不传默认400
            effect: 'left' //轮播的改变方式 top || left || fade，不传默认left
        });
        //    自定义分享插件
        var title = $("#title").val();
        var url ='http://47.101.190.57:8080${cx}/view/activity?id=${activity.id}';
        <%--alert( '${cx}/view/activity?id=${activity.id}')--%>
        var config = {
            // Location.href=encodeURI("http://cang.baidu.com/do/s?word=百度&ct=21");
            url                 : url, // 网址，默认使用 window.location.href
            source              : 'ZSC数独运动协会', // 来源（QQ空间会用到）, 默认读取head标签：<meta name="site" content="http://overtrue" />
            title               : title, // 标题，默认读取 document.title 或者 <meta name="title" content="share.js" />
            summary             : title,
            appkey              : '',
            description         : '这篇文章不错,分享一下~~', // 描述, 默认读取head标签：<meta name="description" content="PHP弱类型的实现原理分析" />
            image               : '', // 图片, 默认取网页中第一个img标签
            sites               : ['qzone', 'qq', 'weibo','wechat'], // 启用的站点
            // disabled            : ['google', 'facebook', 'twitter'], // 禁用的站点
            wechatQrcodeTitle   : "微信扫一扫：分享", // 微信二维码提示文字
            wechatQrcodeHelper  : '<p>微信里点“分享”，扫一下</p><p>二维码便可将本文分享至朋友圈。</p>',
        };
        // var s = [];
        // for (var i in config) {
        //     s.push(i + '=' + encodeURIComponent(config[i] || ''));
        // }
        // var target_url = "https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?"+s.join('&');
        // alert("target_url  =="+target_url)
        // window.open(target_url, 'qZone', 'height=430, width=400');


        $("#social-share").share(config);
    });

    function check() {
        var regC = /[^ -~]+/g;
        var regE = /\D+/g;
        var str = sign.value;

        if (regC.test(str)){
            sign.value = sign.value.substr(0,200);
        }

        if(regE.test(str)){
            sign.value = sign.value.substr(0,210);
        }
    }
    $(function () {
        var aid=$("#aid").val();
        // var realname = $("#real").val();
        // alert("real"+realname);
        pageQuery(1,aid);
    });

    function pageQuery(pageno,aid) {
        var loadingIndex = null;
        var realname= $("#real").val();
        var jsonData = {"pageno" : pageno, "pagesize" : 5,"aid":aid};
        //实时刷新评论
        $.ajax({
            async: true,
            type: "POST",
            data : jsonData,
            url: "${cx}/comment/queryActivityComment", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var commentPage = result.data;
                    var comments = commentPage.datas;
                <%--<a href="${cx}/view/user?id='+username+'">'--%>
                    $.each(comments, function (i, comment) {

                        if(comment.realname== realname){
                            tableContent +=
                                "<div style='padding:10px;background-color: white;margin: 10px 10px;border-radius: 5px;border: 1px black dotted' id='" + comment.id + "'><img style=' border:1px solid black; border-radius: 30px;width:50px' id='img_nav' class='user-pic' src='"+comment.hurl+"' alt='无法显示'/><a href='${cx}/view/user?id="+comment.username+"'>&nbsp;" + comment.username +"</a>&nbsp;<span style='font-size: 14px;font-family: cursive;'>"+comment.time.substring(0,16)+"发表:</span><br> &nbsp; &nbsp;" + comment.content + "" + "<br>" +
                                "<button class='del' type='button' class='btn btn-success ' style='float: right;font-size: 15px' id='" + comment.id +"' onclick='delCom(this)'>删除</button></div>";

                        }else {
                            tableContent += "<div style='padding:10px;background-color: white;margin: 10px 10px;border-radius: 5px;border: 1px black dotted' id='" + comment.id + "'><img style='border:1px solid black;  border-radius: 30px;width:50px' id='img_nav' class='user-pic' src='"+comment.hurl+"' alt='无法显示'/><a href='${cx}/view/user?id="+comment.username+"'>&nbsp;" +comment.username +"</a>&nbsp;<span style='font-size: 14px;font-family: cursive;'>"+ comment.time.substring(0,16)+"发表:</span><br> &nbsp; &nbsp;" + comment.content + "<br>" + "</div>";
                        }

                     });

                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno - 1) +','+ aid+')">上一页</a></li>';
                    }
                    // alert("commentPage.totalno=="+commentPage.totalno)
                    for (var i = 1; i <= commentPage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i+ ','+aid + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < commentPage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno + 1) + ','+aid+ ')">下一页</a></li>';
                    }
                    $("#commentData").html(tableContent);
                    $(".pagination").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            },
            error: function () {
                layer.msg("查询失败，请联系管理员或检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
    }


    //产生随机数id
    function createRandom2(from, to) {
        var arr;
        var json = {};
        //产生单个随机数
        var ranNum = Math.ceil(Math.random() * (to - from)) + from;
        //通过判断json对象的索引值是否存在 来标记 是否重复
        if (!json[ranNum]) {
            json[ranNum] = 1;
            arr = ranNum;
        }
        return arr;
    }
    function submitCom() {
        var now = new Date().Format("yyyy-MM-dd h:m");
        var comment = $("#comment").val().trim();
        var realname =$("#real").val();
        var username =$("#username").val();
        var aid=$("#aid").val();
        var aurl=$("#aurl").val();
        var atitle=$("#atitle").val();
        var id = createRandom2(1, 1000000);//产生100-1000000的随机数
        if (comment == "" || comment == null) {
            $("#errormsg").html("请输入评论").show(300).delay(3000).hide(300);

            layer.msg("请输入评论", {time:2000, icon:5, shift:6}, function(){
                return;
            });

        } else {
            var data = {};
            data["content"] = comment;
            data["id"] = id;
            data["aid"] = aid;
            data["time"] = now;
            data["realname"] = realname;
            data["username"] = username;
            data["aurl"] = aurl;
            data["atitle"] = atitle;
            // alert("realname"+realname);
            var json = JSON.stringify(data);
            $.ajax({
                async: true,
                type: "POST",
                url: "${cx}/comment/addActivitycomment",
                data: json,
                contentType: 'application/json',
                success: function (result) {
                    if(result.success){
                        pageQuery(1,aid);
                        var comment = $("#comment").val(" ");
                    }else{
                        layer.msg("添加评论失败", {time:2000, icon:5, shift:6}, function(){
                        });
                    }

                },
                error: function () {
                    layer.msg("上传失败，请联系管理员或检查网络", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            });
        }
    }



    //删除评论!!!!!!!!!!!!!
    function delCom(e) {
        var id = e.id;
        // alert("id " +id);
        var data = {};
        data["id"] = id;

        var json = JSON.stringify(data);
        $.ajax({
            async: true,
            type: "POST",
            url: "${cx}/comment/delActivityComment",
            data: json,
            contentType: 'application/json',
            success: function (result) {
                if (result == "success") {
                    $("#" + id).remove();
                }
            },
            error: function () {
                layer.msg("删除失败，请联系管理员或检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
    }



</script>