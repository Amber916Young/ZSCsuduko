<template:index >
    <style>
        body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td { margin:0; padding:0; }
        body, button, input, select, textarea { font:em/1.5tahoma, arial, \5b8b\4f53; }
        body{    color: #000;}
        h1, h2, h3, h4, h5, h6{ font-size:100%; }
        address, cite, dfn, em, var { font-style:normal; }
        code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
        small{ font-size:em; }
        ul, ol { list-style:none; }
        a { text-decoration:none;
            font: normal 600 em / em "å®‹ä½“",Helvetica,Arial,Verdana,sans-serif;color: #333333;}
        a:hover { color: #da3a21;}
        .underline{
            background-color: #da3a21;
            position: absolute;
            display: block;
            overflow: hidden;
            left: 50%;
            bottom: em;
            width: 0;
            height:em;
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
        img{
            width: 12em;
        }
    </style>

    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">
        <%@ include file="/WEB-INF/tags/template/basicsidebar.jsp"%>
        <div style="flex-basis: 75%;padding: 2em 0 3em 6em;" class="main-right" >
            <h6 style="text-align: right;" id="nowtime"> 现在时间:</h6>
            <div>
                <h3 style="text-align: center;align-content: center">各部门职能</h3>
                <hr>
                <div  style="height: auto;border: aliceblue">
                    <h5>秘书部：</h5>
                    <p>
                        1、协助社长掌握本社运行情况，草拟各项规章制定，管理日常工作；<br>
                        2、负责组织、协调和监督其他职能部门工作；<br>
                        3、负责社团的日常资料管理；贫困学生以及其他需要帮助的个人（或团体）资料的整理保存；<br>
                        4、负责社团各部门及成员的签到、例会、日常工作考评；<br>
                        5、负责工作通知及协调各部门，组织社团内部交流，增强组织凝聚力；<br>
                        6、做好会议记录及收取整理各部负责人学期工作计划及期末活动总结；<br>
                        7、做好社团财务管理工作。<br>
                    </p>
                </div>

                <hr>

                <div  style="color: #0000cc">
                    <h5>组织部：</h5>
                    <p>
                        1、负责社团活动的策划、组织及后勤保障工作；<br>
                        2、组织丰富多彩的活动，培养学生的兴趣爱好，丰富同学的生活，陶冶学生的情操；<br>
                        3、协调其余各部及分社等的活动安排。<br>
                    </p>
                </div>

                <hr>

                <div  style="color: #6e1881">
                    <h5>宣传部：</h5>
                    <p>
                        1、负责社团活动的相关宣传文字、图片、广告等的策划、设计和发布工作，并能够搜集相关信息，并将活动成果归纳成文字材料；<br>
                        2、负责社团学校内的宣传工作,负责社团与其它社团的联系，通过各种形式宣传社团，进一步扩大社团在校内外的影响，为社团的进一步发展创造良好的外部环境；<br>
                        3、负责社团学校内的宣传工作；<br>
                        4、宣传社团的宗旨和精神。<br>
                    </p>
                </div>

                <hr>

                <div  style="color: #0f5179">
                    <h5>技术部：</h5>
                    <p>
                        1、负责社团成员数独交流的日常工作，保证社员数独学习和交流的正常运行；<br>
                        2、负责社团的更新内容以及各项技术方面的事宜；<br>
                        3、积极配合、满足各部的技术要求。<br>
                    </p>

                </div>

                <hr>
                <h3 style="text-align: center;align-content: center">社团现任负责人</h3>
                <br>
                <c:forEach items="${adminPhotos}" var="adminPhotos">
                    <c:if test="${adminPhotos.id==1}">
                        <c:if test="${adminPhotos.position=='会长'}">
                            <div class="col-md-4" >
                                <h5>会长：${adminPhotos.realname}</h5>
                                <img src="${adminPhotos.fileUrl}">
                            </div>
                        </c:if>
                        <c:if test="${adminPhotos.position=='副会长'}">
                            <div class="col-md-4" >
                                <h5>副会长：${adminPhotos.realname}</h5>
                                <img style="width: 200px" src="${adminPhotos.fileUrl}">
                            </div>
                        </c:if>
                        <c:if test="${adminPhotos.position=='秘书长'}">
                            <div class="col-md-4" >
                                <h5>秘书长：${adminPhotos.realname}</h5>
                                <img src="${adminPhotos.fileUrl}">
                            </div>
                        </c:if>
                    </c:if>
                </c:forEach>

                
                <%--<div class="col-md-4">--%>
                    <%--<h5>副会长</h5>--%>
                    <%--<img src="/resource/static/img/社团二维码.jpg">--%>
                <%--</div>--%>
                <%----%>
                <%--<div class="col-md-4">--%>
                    <%--<h5>秘书长</h5>--%>
                    <%--<img src="/resource/static/img/社团二维码.jpg">--%>
                <%--</div>--%>


            </div>
        </div>
    </div>

</template:index>
<script type="text/javascript">
    var ItemId = "Item5";
    $(function (){

    });


    function getNowDate() {
        var date = new Date();
        var sign1 = "-";
        var sign2 = ":";
        var year = date.getFullYear() // 年
        var month = date.getMonth() + 1; // 月
        var day  = date.getDate(); // 日
        var hour = date.getHours(); // 时
        var minutes = date.getMinutes(); // 分
        var seconds = date.getSeconds() //秒
        var weekArr = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期天'];
        var week = weekArr[date.getDay()];
        // 给一位数数据前面加 “0”
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (day >= 0 && day <= 9) {
            day = "0" + day;
        }
        if (hour >= 0 && hour <= 9) {
            hour = "0" + hour;
        }
        if (minutes >= 0 && minutes <= 9) {
            minutes = "0" + minutes;
        }
        if (seconds >= 0 && seconds <= 9) {
            seconds = "0" + seconds;
        }
        var currentdate = year + sign1 + month + sign1 + day + " " + hour + sign2 + minutes + sign2 + seconds + " " + week;
        return currentdate;


    }
    $("#nowtime").append(getNowDate());



</script>