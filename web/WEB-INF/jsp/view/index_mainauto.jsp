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

    .news{
        display: flex;
        /*height: 2.5em;*/
        /*width: 35em;*/
        padding: 0.5em 0.5em 0;
    }
    .news a{
        color: black;
        font-size: 1em;
    }
    .news a:hover{
        color: #de7c3b;
    }
    .news img{
        height: 8em;
        border: 1px solid darkslategray;
    }
    .news-img{
        align-items: flex-start;
        flex-basis: 35%;
        margin-right: 1em;
        margin-bottom: 3em;
        width: 20em;
    }

    .header-logo img{
        width: 8em;
        height: auto;

        /* max-width:100%; */
    }

    .news-txt{
        flex: 1;
        height: 100%;
    }

    .news-txt p{
        margin-top: 0.15em;
        font-size: 0.75rem;
        text-align: justify;
        text-indent: 2em;
        /* max-height: 112px;
        overflow: hidden; */
    }


</style>






    <div class="main">
        <div class="main-left">
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
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
                    <img src="${cx}/resource/static/test/3407-swcUID.jpg" alt="" />
                    <div class="carousel-caption" style="color: white">标题 2</div>
                </div>
            </div>
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <div class="" style="margin: 0 2em;">
                <marquee style="height: 5em;" scrollAmount="2" scrollDelay="60"  onmouseover="this.stop()" onmouseout="this.start()"  direction="up" >
                    <i class="fa fa-bullhorn" aria-hidden="true"></i>
                    <a  id="notice1" href="javascript:void(0);"></a><br>
                    <i class="fa fa-bullhorn" aria-hidden="true"></i>
                    <a  id="notice2" href="javascript:void(0);"></a><br>
                    <i class="fa fa-bullhorn" aria-hidden="true"></i>
                    <a  id="notice3" href="javascript:void(0);"></a><br>
                </marquee>
                <div class="" style="text-align: center;margin: 1em 0">
                    <div style="padding: 0 2em;display:inline-block;">
                        <a href="javascript:void(0)">
                            <img alt="Bootstrap Image Preview" src="${cx}/resource/static/index_image/home.png" style="width: 5em;" >
                            <h5>关于我们</h5>
                        </a>
                    </div>
                    <div style="padding: 0 2em;display:inline-block;">
                        <a href="${cx}/clubinformation/functions" >
                            <img alt="Bootstrap Image Preview" src="${cx}/resource/static/index_image/hat.png" style="width: 5em" >
                            <h5>部门介绍</h5>
                        </a>
                    </div>
                    <div style="padding: 0 2em;display:inline-block;">
                        <a href="${cx}/index/connection">
                            <img alt="Bootstrap Image Preview" src="${cx}/resource/static/index_image/note.png" style="width: 5em" >
                            <h5>联系我们</h5>
                        </a>
                    </div>
                </div>
            </div>
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">

            <div style="margin: 0 auto; width: 32em;padding: 0.2em 0;">
                <h4 style="margin-bottom: 0">社团近期活动<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ News</span></span></h4>
                <img src="${cx}/resource/static/img/button.png" alt="01" title="01" id="img_smv_con_222_36" style="    width: 12em;">
                <c:forEach var="temp" items="${pageInfo.list}"  varStatus="loop"   begin="0" end="4" step="1">
                    <c:if test="${temp.status ==1}">
                        <div class="news" >
                            <c:choose>
                                <c:when test="${not empty paurl[loop.count-1]}">
                                    <div class="news-img"><img src="${paurl[loop.count-1]}" alt=""></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="news-img"><img src="${cx}/resource/static/img/nullpic.jpg" alt=""></div>
                                </c:otherwise>
                            </c:choose>
                            <div class="news-txt">
                                <a   href="${cx}/view/activity?id=${temp.id}" target="_blank" >${temp.title}</a>
                                <p>${temp.content}</p>
                                <p style="text-align: right; font-family: 微软雅黑;display: block;">发布者:${temp.name}&nbsp;&nbsp;时间:${temp.time}</p>
                            </div>
                        </div>
                        <div style="border-right: none;border-left: none;border-top: none;display: block;border-width: 1px; border-color: #e5e5e5;border-style: dashed;"></div>
                    </c:if>
                </c:forEach>
                <hr style=" border: none;height: 0.5em;margin: 10px 0;">
                <h4 style="margin-bottom: 0">精选文章<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ Articles</span></span></h4>
                <img src="${cx}/resource/static/img/button.png" alt="01" title="01" id="img_smv_con_222_36" style=" width: 12em;">
                <c:forEach var="temp2" items="${articlepageInfo.list}" varStatus="loop">
                    <c:if test="${temp2.status ==1}">
                        <div  class="news" >
                            <c:choose >
                                <c:when test="${not empty paurl2[loop.count-1]}">
                                    <div class="news-img"><img src="${paurl2[loop.count-1]}" alt=""></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="news-img"><img src="${cx}/resource/static/img/nullpic.jpg" alt=""></div>
                                </c:otherwise>
                            </c:choose>

                            <div class="news-txt">
                                <a href="${cx}/view/particles?id=${temp2.id}" target="_blank"  >${temp2.title}</a>
                                <p>${temp2.content}</p>
                                <p  style="text-align: right;display: block;">发布者:${temp2.name}&nbsp;&nbsp;时间:${temp2.time}</p>
                            </div>
                        </div>
                        <div style="border-right: none;border-left: none;border-top: none;display: block;border-width: 1px; border-color: #e5e5e5;border-style: dashed;"></div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="main-right" style=" background: white;">
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <div id="research">
                    <%--<div style="margin-left: 30px" id="deleteinfo">推荐分辨率90% <a style="cursor:pointer;color: red" onclick="deleteinfo()">×</a></div>--%>
                <form  id="From " class="d1" method="post"  action="${cx}/webIndex/query"   >
                    <input type="text" name="q" id="q" placeholder="搜索从这里开始...">
                    <button type="submit"></button>
                </form>
            </div>
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <div style="width: 90%;margin: 1em auto;background: #F4F4F4">
            <span class="text" >
                    <h4 style="border-bottom: 3px solid #2a6d9e ; width: 10em;border-top:0px;border-left:0px;border-right:0px;">每日一练<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ Practice</span></span></h4>
            </span>
                <div style=" width: 90%; margin: auto;background: #F4F4F4">
                    <div class="table-responsive"  style="font-size: 0.75em">
                        <form id="sudukoFrom" style="font-size: 1em;background: rgba(251,251,251,0.91) none no-repeat fixed center top;" >
                            <table class="table  table-bordered" >
                                <thead style="background-color: rgba(217,217,217,0.66)">
                                    <tr >
                                        <th width="10" >#</th>
                                        <th >题目id</th>
                                            <%--<th >难度</th>--%>
                                        <th >题目类型</th>
                                        <th >分值</th>
                                        <th >发布时间</th>
                                    </tr>
                                </thead>
                                <tbody id="sudukoData" style="font-size: 0.75em;color:#000;">
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

                <%--<hr style=" border: none;height: 0.5em;margin: 10px 0;">--%>
            <div style="width: 90%;margin: 1em auto; ">
                <div>
                    <h4 style="border-bottom: 3px solid #000000 ;border-top:0;border-left:0;border-right:0;">会员积分排行<span style="font-size:20px;color:#a01b0f">&nbsp;/ 总排名</span></h4>
                </div>
                <div class="box"  style="font-size: 0.75em;background-color: #F4F4F4 ">
                    <table width="80%"  border="0" cellspacing="0" cellpadding="0"  style="background-color: rgba(251,251,251,0.91);margin: auto" id="ranking">
                        <tr  style="background-color: rgba(217,217,217,0.66)">
                            <th width="48">#</th>
                            <th>用户名</th>
                            <th>积分</th>
                            <th>届数</th>
                        </tr>
                    </table>
                </div>
            </div>
            <hr style=" border: none;height: 0.5em;margin: 10px 0;">
            <div style="width: 90%;margin: 1em auto;background: #F4F4F4">
                <div>
                    <h4 style="border-bottom: 3px solid #000000 ; border-top:0;border-left:0;border-right:0;">会员积分排行<span style="font-size:20px;color:#7f8c8d">&nbsp;/ 届排名</span></h4>
                </div>
                <div class="box"  style="font-size: 0.75em" >
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" style="background: rgba(251,251,251,0.91) none no-repeat fixed center top;margin: auto" id="c">
                        <tr style="background-color: rgba(217,217,217,0.66)" >
                            <th width="48">#</th>
                            <th>用户名</th>
                            <th>积分</th>
                            <th>届数</th>
                        </tr>
                        <tbody id="ranking2mg" ></tbody>
                        <tbody id="ranking2"></tbody>
                    </table>
                </div>
                <div class="form-group" style="text-align: center;margin-top: 1em;color: #0c1119">
                    <span>第</span>
                    <select style="width: 5em ;display: inline" class="form-control" id="gid" >
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    <span>届</span>
                    <button class="btn btn-primary" onclick="async6()">查询</button>
                </div>
            </div>

        </div>
    </div>
        <%--<hr style=" border: none;height: 0.5em;margin: 10px 0;">--%>
    <div style="margin: 0.25em 2em;">
        <div class="" style="margin:auto;text-align: center;height: 13em ;background: white;" >
            <c:forEach var="list" items="${zhoubianList}" >
                <div style="padding: 0 1em;display:inline-block;line-height: 2em;margin-top: 1em">
                    <img style="border: 1px #de7c3b dashed ;width: 10em;height: 6em" src="${list.fileUrl}" alt="图片损坏"><p style="font-size: 0.75em; width: 10em;">${list.title}</p>
                </div>
            </c:forEach>
        </div>
    </div>


</template:index>


<script>
    async1();
    function async1(){

        $.ajax({
            async: true,
            method:"GET",
            url: "${cx}/index/find_usernameByintegral", //数据URL路径
            contentType: "application/json",
            success: function (result) {   //成功后的方法
                if (result.length<30) {
                    for(var i =0 ;i<result.length;i++){
                        var username = result[i].username.trim();
                        var integral = result[i].integral;
                        var id =  result[i].id;
                        var j=1+i;
                        var addranking = '<tr><td>'+j+'</td><td><a href="${cx}/view/user?id='+username+'">'+username+'</a></td><td>'+integral+'</td><td>'+id+'</td></tr>';

                        $("#ranking").append(addranking);
                    }

                } else {
                    for(var i =0 ;i<30;i++){
                        var username = result[i].username.trim();
                        var integral = result[i].integral;
                        var id =  result[i].id;
                        var j=1+i;
                        var addranking = '<tr><td>'+j+'</td><td><a href="${cx}/view/user?id='+username+'">'+username+'</a></td><td>'+integral+'</td><td>'+id+'</td></tr>';

                        $("#ranking").append(addranking);
                    }
                }
            },
            error: function () {   // ajax请求失败
                layer.msg("ajax请求执行失败!", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
        async2();
    }
    function async2(){
        var noticeid1 = $("#notice1");
        var noticeid2 = $("#notice2");
        var noticeid3 = $("#notice3");
        var notice = $("#notice");
        var not =$("#not");
        $.ajax({
            async: true,
            method:"GET",
            url: "${cx}/index/getNoticeinfo", //数据URL路径
            contentType: "application/json",
            success: function (data) {   //成功后的方法
                // alert("result"+data);
                if (data==null||data==""){
                    var ico="<span class=\"glyphicon glyphicon-volume-down\" style=\"color: rgba(255,84,27,0.54); font-size: 2em;\"> </span>\n";
                    notice.append(ico+"<p>当前没有公告</p>")
                    not.remove();

                }else{
                    // alert("公告长度"+data.length);
                    if(data.length>3){
                        data.length=3;
                    }

                    for(var i =0 ;i<data.length;i++){
                        var content =data[i].content;
                        var time = data[i].time;
                        var noticecontent = "<b>"+content+"</b><p style=\"margin:0 0 0 20px;text-align: right \">发布日期:"+time+"</p>";
                        if(i==0){
                            noticeid1.append(noticecontent);
                        }else if(i ==1){
                            noticeid2.append(noticecontent);
                        }else{
                            noticeid3.append(noticecontent);
                        }

                    }
                }
            },
            error: function () {   // ajax请求失败
                layer.msg("ajax请求执行失败!", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
        async3();
    }
    function async3(){
        //需求：鼠标放到上面的li上，li本身变色(添加类)，下方对应的span也显示出来(添加类);
        //思路：1.点亮上面的盒子。   2.利用索引值显示下面的对应的盒子。

        //1、获取所有的box
        var boxArr = document.getElementsByClassName("box");

        //让每一个box都调用函数
        for (var i = 0; i < boxArr.length; i++) {
            fn(boxArr[i]);
        }

        function fn(element) {
            var liArr = element.getElementsByTagName("li");   //注意，是element获取事件源，不是document获取事件源
            var spanArr = element.getElementsByTagName("span");
            //2.绑定事件（循环绑定）
            for (var i = 0; i < liArr.length; i++) {
                //绑定索引值（新增一个自定义属性：index属性）
                liArr[i].index = i;
                liArr[i].onmouseover = function () {
                    //3.书写事件驱动程序（排他思想）
                    //1.点亮上面的盒子。   2.利用索引值显示下面的盒子。(排他思想)
                    for (var j = 0; j < liArr.length; j++) {
                        liArr[j].className = "";
                        spanArr[j].className = "";
                    }
                    this.className = "current";
                    spanArr[this.index].className = "show"; //【重要】核心代码
                }
            }
        }
        async4();
    }
    function async4() {
        pageQuery(1);
    }
    function pageQuery() {
        // alert("执行22222");
        var loadingIndex = null;

        $.ajax({
            async: true,
            type:"POST",
            url: "${cx}/index/suduko/querysome", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var sudukoPage = result.data;
                    var sudukos = sudukoPage.datas;
                    // alert("data 长度"+result.length);
                    $.each(sudukos, function (i, suduko) {
                        tableContent += '<tr style="border-bottom: 1px solid #ddd;">';
                        tableContent += '  <td style="border:0 ;">' + (i + 1) + '</td>';
                        tableContent += '  <td style="border:0"><a href="${cx}/view/suduko?id='+suduko.id+'"> '+ suduko.id + '</a></td>';
                        // tableContent += '  <td style="border:0">' + suduko.difficulty_level + '</td>';
                        tableContent += '  <td style="border:0">' + suduko.type + '</td>';
                        tableContent += '  <td style="border:0">' + suduko.score + '</td>';
                        tableContent += '  <td style="border:0">' + suduko.time.substring(0,10)+ '</td>';
                        tableContent += '</tr>';
                    });
                    $("#sudukoData").html(tableContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
        async5();
    }



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
        async6()
    }


    function async6() {
        var gid = $("#gid").val();
        if(gid==""){
            gid=1;
        }
        // alert(gid)
        var addranking="";
        var jsonData = {"gid" : gid};
        $("#ranking2mg").html(" ");
        $.ajax({
            async: true,
            method:"GET",
            data : jsonData,
            url: "${cx}/index/integralByGid", //数据URL路径
            contentType: "application/json",
            success: function (result) {   //成功后的方法
                if(result.length==0){
                    addranking +="该届暂时没有排名";
                    $("#ranking2mg").html(addranking);
                    $("#ranking2").html("");
                }else if (result.length<=30) {

                    for(var i =0 ;i<result.length;i++){
                        var username = result[i].username.trim();
                        var integral = result[i].integral;
                        var j=1+i;
                        addranking += '<tr><td>'+j+'</td><td><a href="${cx}/view/user?id='+username+'">'+username+'</a></td><td>'+integral+'</td><td>'+gid+'</td></tr>';
                        $("#ranking2").html(addranking);
                    }

                } else {
                    for(var i =0 ;i<30;i++){
                        var username = result[i].username.trim();
                        var integral = result[i].integral;
                        var j=1+i;
                        addranking += '<tr><td>'+j+'</td><td><a href="${cx}/view/user?id='+username+'">'+username+'</a></td><td>'+integral+'</td><td>'+gid+'</td></tr>';
                        $("#ranking2").html(addranking);
                    }
                }
            },
            error: function () {   // ajax请求失败
                layer.msg("ajax请求执行失败!", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
        // async7();
    }
</script>