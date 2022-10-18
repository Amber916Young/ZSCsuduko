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
    </style>

    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">

        <%@ include file="/WEB-INF/tags/template/basicsidebar.jsp"%>

        <div style="flex-basis: 75%;padding: 2em 0 3em 6em;" class="main-right" >
                    <h6 style="text-align: right;" id="nowtime"> 现在时间:</h6>
           <div>
               <h3 style="text-align: center;align-content: center">社团章程</h3>
               <p style="text-indent:2em; color: black">
                   作为协会的创建者，我们不得不考虑协会今后发展的问题，我们会在今年的工作中发掘有能力的新人，并且为协会的发展制定发展方向。
               </p>
               <h4 style="text-align: center;align-content: center">管理制度</h4>
               <p style="text-indent:2em;">
                   社团一切权力属于社团成员。社团成员依照章程规定，通过各种途径和形式，管理社团事物。
                   社团应遵循既要发扬民主，又要加强纪律；既要活跃气氛，又要保证秩序的活动原则，完善自我管理，确保健康发展。
               </p>
               <h4 style="text-align: center;align-content: center">财务管理</h4>
               <p style="text-indent:2em;">
                   秘书长保管账本及社团资金。经费由会员会费支持，社团定期举办传统活动，花费均公开透明。
               </p>

               <h4 style="text-align: center;align-content: center">社团负责人产生，罢免，权限</h4>
               <p style="text-indent:2em; ">
                   除第一任会干，此后会干经选拔任命。社团一切活动都由会长，副会长及秘书长商量策划，不得单独组织任何活动。
                   部门部长定期上报工作总结。每个部门相互监督相互制衡，若破坏社团内部和谐投票决定撤销职位。
               </p>
               <h4 style="text-align: center;align-content: center">章程的修改程序</h4>
               <p style="text-indent:2em; ">
                   对本社团章程的修改程序，由社团联、本社团执行机构或10名以上本社团成员联名提出，并交经本社团会员大会审议。
               </p>
               <h4 style="text-align: center;align-content: center">社团终止程序</h4>
               <p style=" ">
                   1.社团完成宗旨或自行解散或由之分立、合并等原因需要注销的，由社团执行机构提出终止动议。<br>
                   2.本社团终止动议须经会员大会表决通过，并报指导单位审查同意。<br>
                   3.本社团终止前，须在组织下成立清算组织，清理债权债务，处理善后事宜。清算期间，不开展清算以外的活动。<br>
                   5.本社团经XXX办理注销登记手续后既为终止。<br>
                   6.本社团终止后的剩余财产，在团委的监督下，按照相关管理条例的有关规定处理。
               </p>
               <h4 style="text-align: center;align-content: center">考勤</h4>
               <p style="text-indent:2em;margin-bottom: 70px">
                   把考勤放在工作计划的第一位，是因为作为社团联合会领导下的协会，我们会严格要求自己，遵守社联的各项规章制度。
                   我们协会的负责人会按时参加例会，
                   凡事社联下发的工作我们会保质保量的完成，并且争取在新的学期能有创新性活动，为能打造精品社团而努力。
               </p>
               <h4 style="text-align: center;align-content: center">活动</h4>
               <p style="text-indent:2em;">
                   每学期我们准备了一两次面向全校的活动，将和教学穿插进行，这样不仅是对会员学习情况的检查，
                   而且通过这些活动可以吸引更多的人参加我们协会的活动，提高协会的知名度和响应度。
               </p>

               <h4 style="text-align: center;align-content: center"> </h4>
               <p style="text-indent:2em;">
               </p>
               <%--<h4 style="text-align: center;align-content: center"> </h4>--%>
               <%--<p style="text-indent:2em;margin-bottom: 70px">--%>
               <%--</p>--%>
               <%--<h4 style="text-align: center;align-content: center"> </h4>--%>
               <%--<p style="text-indent:2em;margin-bottom: 70px">--%>
               <%--</p>  --%>
               <%--<h4 style="text-align: center;align-content: center"> </h4>--%>
               <%--<p style="text-indent:2em;margin-bottom: 70px">--%>
               <%--</p>--%>
           </div>
       </div>

    </div>

</template:index>
<script type="text/javascript">
    var ItemId = "Item2";
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