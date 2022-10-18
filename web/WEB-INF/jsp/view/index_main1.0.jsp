<template:mian_page>
    <link rel="stylesheet" href="${cx}/resource/static/css/index.css">
    <link href="https://cdn.bootcss.com/bootstrap-select/1.12.4/css/bootstrap-select.min.css" rel="stylesheet">

    <style>
        .sudukoData tr:hover{
           background-color: #e6fcff;
        }
        .sudukoData a {
            color:rgb(102, 102, 102);
        }
        .sudukoData a:hover{
            color: #0e1d2e;
            text-decoration:underline;
        }
        a:hover{
            color: #a01b0f;
            text-decoration:underline;
        }
        a{
            color: #10326b;
        }
        .row{
            width: 1280px;
            margin: 0 auto;
            padding: 15px 140px;
        }
        .col-sm-12{

            margin: 0 auto;
        }
        /*.col-sm-6{*/
            /*width: 500px;*/
        /*}*/
        .ac{
             float:left;
         }
        /*.col-sm-3{*/
            /*width: 300px;*/
        /*}*/
    </style>
    <%--<iframe src="http://cn.sudokupuzzle.org/online.php" frameborder="0" width="425" scrolling="no"style="height:485px !important;height:475px;" ></iframe>--%>

    <%--<div class="container-fluid" style="width:100%;min-width:720px;background-color:#fafafa;">--%>
        <div class="row">
            <div class="col-sm-12" >
                <marquee style="height: 100px;" scrollAmount="2" scrollDelay="60"  onmouseover="this.stop()" onmouseout="this.start()"  direction="up" >
                    <i class="fa fa-bullhorn" aria-hidden="true"></i>
                    <a  id="notice1" href="javascript:void(0);"></a><br>
                    <i class="fa fa-bullhorn" aria-hidden="true"></i>
                    <a  id="notice2" href="javascript:void(0);"></a><br>
                    <i class="fa fa-bullhorn" aria-hidden="true"></i>
                    <a  id="notice3" href="javascript:void(0);"></a><br>
                </marquee>
            </div>
            <div class="col-sm-12" style="text-align: center;">
                <div style="padding: 0 50px;display:inline-block;">
                    <a href="javascript:void(0)">
                        <img alt="Bootstrap Image Preview" src="https://images.mituo.cn/mui147/upload/201805/1527663141.png" style="width: 70px;" >
                        <h5>关于我们</h5>
                    </a>
                </div>
                <div style="padding: 0 50px;display:inline-block;">
                    <a href="${cx}/clubinformation/functions" >
                        <img alt="Bootstrap Image Preview" src="https://images.mituo.cn/mui147/upload/201805/1527663449.png" style="width: 70px;" >
                        <h5>部门介绍</h5>
                    </a>
                </div>
                <div style="padding: 0 50px;display:inline-block;">
                    <a href="${cx}/index/connection">
                        <img alt="Bootstrap Image Preview" src="https://images.mituo.cn/mui147/upload/201805/1527663941.png" style="width: 70px;" >
                        <h5>联系我们</h5>
                    </a>
                </div>
            </div>
            <div class="col-sm-12" style="">
                <p style="color: #0c1119">&nbsp;&nbsp;&nbsp;&nbsp;电子科技大学中山学院数独运动协会成立于2018年6月。 社团成立目的是为了丰富校园文体娱乐活动形式，积极开展活动，营造良好的校园文化氛围。 帮助学生冷静思考，培养想像力、逻辑推理能力和创新思维；提高耐心、专注力和毅力。 使学生思考问题更有条理性。</p>
            </div>
        </div>
        <div class="row" style="padding: 15px 140px;width: 1400px;">
            <div class="col-sm-6" style="float: left;background-color: #fbfcfd; ">
                <span class="text" >
                    <h4 style="border-bottom: 3px solid #2a6d9e ; width: 220px;border-top:0px;border-left:0px;border-right:0px;">每日一练<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ Practice</span></span></h4>
                    <%--<img src="${cx}/resource/static/img/button.png" alt="01" title="01"  style="height: 20px; width: 232px;">--%>
                </span>
                <div style=" width: 100%; ">
                    <div class="table-responsive" style="">
                        <form id="sudukoFrom">
                            <table class="table  table-bordered" >
                                <thead>
                                <tr>
                                    <th width="30" >#</th>
                                    <th >题目id</th>
                                    <th >难度</th>
                                    <th >题目类型</th>
                                    <th >分值</th>
                                    <th >发布时间</th>
                                </tr>
                                </thead>
                                <tbody id="sudukoData" style="color:#000;">
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-sm-3" style="float: left;background-color: #fdfdfe">
                <div>
                    <h4 style="border-bottom: 3px solid #000000 ;border-top:0px;border-left:0px;border-right:0px;">会员积分排行<span style="font-size:20px;color:#a01b0f">&nbsp;/ 总排名</span></h4>
                </div>
                <div class="box" style="color:#000;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 10px"  id="ranking">
                        <tr >
                            <th width="48">#</th>
                            <th>用户名</th>
                            <th>积分</th>
                            <th>届数</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="col-sm-3" style="float: left;background-color: #fdfdfe">
                <div><h4 style="border-bottom: 3px solid #000000 ; border-top:0px;border-left:0px;border-right:0px;">会员积分排行<span style="font-size:20px;color:#7f8c8d">&nbsp;/ 届排名</span></h4></div>
                <div class="box" >
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 10px"  id="c">
                        <tr >
                            <th width="48">#</th>
                            <th>用户名</th>
                            <th>积分</th>
                            <th>届数</th>
                        </tr>
                        <tbody id="ranking2mg"></tbody>
                        <tbody id="ranking2"></tbody>
                    </table>
                </div>
                <div class="form-group" style="text-align: center;margin-top: 15px;color: #0c1119">
                    <span>第</span>
                    <select style="width: 100px ;display: inline" class="form-control" id="gid" >
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
        <div class="row" style="">
            <div class="col-sm-12" style="width: 1000px;background-color: #fdfdfe">
                <h4 style="margin-bottom: 0">社团近期活动<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ News</span></span></h4>
                <img src="${cx}/resource/static/img/button.png" alt="01" title="01"  style="height: 20px; width: 232px;">
            </div>
            <c:forEach var="temp" items="${pageInfo.list}"  varStatus="loop"   begin="0" end="9" step="1">
                <c:if test="${temp.status ==1}">
                        <div class="col-sm-6 ac" style="background-color: #fdfdfe">
                            <div  style="font-size: 16px;height: 55px;padding: 10px 10px 0;">
                                <a href="${cx}/view/activity?id=${temp.id}" target="_blank" style="font-family: 微软雅黑;color: rgb(102, 102, 102);" >${temp.title}</a>
                                <div style="text-align: right; font-size: 14px;font-family: 微软雅黑;display: block;">发布者:${temp.name}&nbsp;&nbsp;时间:${temp.time}</div>
                            </div>
                            <div style="border-right: none;border-left: none;border-top: none;display: block;border-width: 1px; border-color: #e5e5e5;border-style: dashed;"></div>
                        </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="row" style="">
            <div class="col-sm-12" style="width: 1000px;background-color: #fdfdfe">
                <h4 style="margin-bottom: 0">精选文章<span style="color:#7f8c8d"><span style="font-size:20px">&nbsp;/ Articles</span></span></h4>
                <img src="${cx}/resource/static/img/button.png" alt="01" title="01" id="img_smv_con_222_36" style="height: 20px; width: 232px;">
            </div>
            <c:forEach var="temp2" items="${articlepageInfo.list}" varStatus="loop"  begin="0" end="9" step="1">
                <c:if test="${temp2.status ==1}">
                    <div class="col-sm-6 ac" style="background-color: #fdfdfe">
                        <div style="font-size: 16px;height: 55px;padding: 10px 10px 0;">
                            <a href="${cx}/view/particles?id=${temp2.id}" target="_blank" style="font-family: 微软雅黑;color: rgb(102, 102, 102);" >${temp2.title}</a>
                            <div style="text-align: right; font-size: 14px;font-family: 微软雅黑;display: block;">发布者:${temp2.name}&nbsp;&nbsp;时间:${temp2.time}</div>
                        </div>
                        <div style="border-right: none;border-left: none;border-top: none;display: block;border-width: 1px; border-color: #e5e5e5;border-style: dashed;"></div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

            <%--<div class="col-sm-4" style="background-color: #fdfdfe">--%>
            <%--<div style="margin-left: 29px" >--%>
            <%--当前系统共有 ${numberOfSessions} 活动用户.<br /><br />--%>
            <%--<c:forEach items="${sessionList}" var="s">--%>
            <%--会话ID:${s.id} - 用户名:${s.getAttribute("username")}--%>
            <%--<c:if test="${s.id == pageContext.session.id}">&nbsp;(当前用户)</c:if><br/>--%>
            <%--</c:forEach>--%>
            <%--</div>--%>
            <%--</div>--%>
        <div class="row" style="margin-bottom: 20px;background-color: #fdfdfe;margin: 0 auto;" >
            <hr style=" border: none; color: #0e1d2e;background: #0e1d2e;height: 2px;margin: 10px 0;">

            <div class="col-md-12" style="text-align: center;" >
                <c:forEach var="list" items="${zhoubianList}" >
                    <div style="padding: 0 15px;display:inline-block;">
                        <img style="border: 1px #de7c3b dashed ;width: 160px;height: 90px" src="${list.fileUrl}" alt="图片损坏"><p style="width: 200px">${list.title}</p>
                    </div>
                </c:forEach>

            </div>

        </div>


    <%--</div>--%>
</template:mian_page>

<script>
    async1();
    function async1(){

        $.ajax({
            async: true,
            method:"GET",
            url: "${cx}/index/find_usernameByintegral", //数据URL路径
            contentType: "application/json",
            success: function (result) {   //成功后的方法
                if (result.length<18) {
                    for(var i =0 ;i<result.length;i++){
                        var username = result[i].username.trim();
                        var integral = result[i].integral;
                        var id =  result[i].id;
                        var j=1+i;
                        var addranking = '<tr><td>'+j+'</td><td><a href="${cx}/view/user?id='+username+'">'+username+'</a></td><td>'+integral+'</td><td>'+id+'</td></tr>';

                        $("#ranking").append(addranking);
                    }

                } else {
                    for(var i =0 ;i<18;i++){
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
                    var ico="<span class=\"glyphicon glyphicon-volume-down\" style=\"color: rgba(255,84,27,0.54); font-size: 40px;\"> </span>\n";
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
                        tableContent += '<tr style="border-bottom: 1px solid #ddd;font-size: 14px;">';
                        tableContent += '  <td style="border:0 ;">' + (i + 1) + '</td>';
                        tableContent += '  <td style="border:0"><a href="${cx}/view/suduko?id='+suduko.id+'"> '+ suduko.id + '</a></td>';
                        tableContent += '  <td style="border:0">' + suduko.difficulty_level + '</td>';
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
        async6();
    }



    <%--function async5() {--%>
        <%--var i=0;--%>
        <%--var con="";--%>
        <%--$.ajax({--%>
            <%--async: true,--%>
            <%--method:"GET",--%>
            <%--url: "${cx}/index/carousel", //数据URL路径--%>
            <%--contentType: "application/json",--%>
            <%--success: function (result) {   //成功后的方法--%>
                <%--// alert(result.length);--%>
                <%--if(result.length==null){--%>
                    <%--console.info("carousel null");--%>
                <%--} else if(result.length==1){--%>
                    <%--var title = result[0].title;--%>
                    <%--var url = result[0].url;--%>
                    <%--var aurl = result[0].aurl;--%>
                    <%--con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='First slide'><div class='carousel-caption'><a href='" + aurl + "' style=\"color: white\">" + title + "</a></div>"--%>
                    <%--$("#carousel1").html(con);--%>
                <%--} else if(result.length==2) {--%>
                    <%--for (i = 0; i < 2; i++) {--%>
                        <%--var title = result[i].title;--%>
                        <%--var url = result[i].url;--%>
                        <%--var aurl = result[i].aurl;--%>
                        <%--if (i == 0) {--%>
                            <%--con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='First slide'><div class='carousel-caption'><a href='" + aurl + "' style=\"color: white\">" + title + "</a></div>"--%>
                            <%--$("#carousel1").html(con);--%>
                        <%--} else {--%>
                            <%--con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='Second slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"--%>
                            <%--$("#carousel2").html(con);--%>

                        <%--}--%>
                    <%--}--%>
                <%--}else if(result.length>=3){--%>
                    <%--for (i = 0; i < 3; i++) {--%>
                        <%--var title = result[i].title;--%>
                        <%--var url = result[i].url;--%>
                        <%--var aurl = result[i].aurl;--%>
                        <%--if (i == 0) {--%>
                            <%--con = "<img src='" + url + "'  style=' bject-fit:cover;'  alt='First slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"--%>
                            <%--$("#carousel1").html(con);--%>
                        <%--} else if (i == 1) {--%>
                            <%--con = "<img src='" + url + "'  style=' object-fit:cover;'  alt='Second slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"--%>
                            <%--$("#carousel2").html(con);--%>

                        <%--} else {--%>
                            <%--con = "<img src='" + url + "'  style='object-fit:cover;'  alt='Third slide'><div class='carousel-caption'><a href='" + aurl + "'>" + title + "</a></div>"--%>
                            <%--$("#carousel3").html(con);--%>
                        <%--}--%>

                    <%--}--%>
                <%--}--%>


            <%--},--%>
            <%--error: function () {   // ajax请求失败--%>
                <%--layer.msg("ajax请求执行失败!", {time:2000, icon:5, shift:6}, function(){--%>
                <%--});--%>
            <%--}--%>
        <%--});--%>

    <%--}--%>


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
                }else if (result.length<=15) {

                    for(var i =0 ;i<result.length;i++){
                        var username = result[i].username.trim();
                        var integral = result[i].integral;
                        var j=1+i;
                        addranking += '<tr><td>'+j+'</td><td><a href="${cx}/view/user?id='+username+'">'+username+'</a></td><td>'+integral+'</td><td>'+gid+'</td></tr>';
                        $("#ranking2").html(addranking);
                    }

                } else {
                    for(var i =0 ;i<15;i++){
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