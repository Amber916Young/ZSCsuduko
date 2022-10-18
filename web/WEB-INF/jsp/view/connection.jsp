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
        <%--<h6 style="text-align: center;" id="nowtime"> 现在时间:</h6>--%>
        <div class="main-left" style="padding: 0 2em;">
            <div>
                <h4 style="margin-top: 6em;text-align: center;align-content: center">意见与建议反馈</h4>
                <br>
                <br>
                <br>
                <p style="text-indent:2em;">
                    如果您对本社团有更好的意见或者建议请发送电子邮件：
                    <a href="mailto:ZSCShuduClub@163.com">
                        ZSCShuduClub@163.com
                    </a>
                </p>
                <p style="text-indent:2em;font-size: 1em;color: darkred"><b>或者</b>直接发送给管理员<i class="fa fa-hand-o-right" aria-hidden="true"></i> </p>

            </div>
        </div>
        <%--<div class="col-sm-1" style="width:em;font-family: 'Microsoft YaHei';text-align: center ;margin: 0 auto ;line-height: 5em">--%>
            <%--<b>或者</b>--%>
        <%--</div>--%>


        <%--TODO 暂时未写后端内容--%>
        <div class="main-right " style="flex-basis: 40%;" >
            <h4 style="margin-top: 1em;text-align: center;align-content: center">发送给管理员</h4>
            <from class="panel panel-default" >
                <div class="gap form-group has-feedback">
                    <div class="input-group">
                        <div class="input-group-addon">真实姓名:</div>
                        <input style="border:1px solid #a3a3a3" class=" has-success" type="text" id="realname" name="realname"  >
                        <span class="alert-success">可选</span>
                    </div>
                </div>
                <div class="gap form-group has-feedback">
                    <div class="input-group">
                        <div class="input-group-addon">用户名：</div>
                        <input style="border:1px solid #a3a3a3" class=" has-success" type="text" id="username" name="username" >
                        <span class="alert-info">我该用什么称呼您？</span>
                    </div>
                </div>
                <div class="gap form-group has-feedback">
                    <div class="input-group">
                        <div class="input-group-addon">联系方式:</div>
                        <input style="border:1px solid #a3a3a3" class=" has-success" type="text" id="phonenumber" name="phonenumber"  >
                        <span class="alert-danger">必填</span>
                    </div>
                </div>
                <div class="gap form-group has-feedback">
                    <div class="input-group">
                        <div class="input-group-addon">意见或者建议：</div>
                        <textarea style="width: 12em;height: 6em;resize: none"></textarea>
                    </div>
                </div>
                <div class="gap form-group has-feedback" style="float: right;margin-right: 1em;">
                    <div class="input-group">
                        <button class="btn btn-info" >提交</button>
                    </div>
                </div>
            </from>
        </div>
    </div>

</template:index>
<script type="text/javascript">
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