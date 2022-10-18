<template:index>
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

    <div class="main" style="margin-bottom: 3em;margin-left: 2em;margin-right: 2em;background-color: white">

            <%@ include file="/WEB-INF/tags/template/basicsidebar.jsp"%>

        <div style="flex-basis: 75%;padding: 2em 0 3em 6em;" class="main-right" >
            <%--<h6 style="text-align: right;" id="nowtime"> 现在时间:</h6>--%>
            <div>
                <h4 style="text-align: center;align-content: center">社团成员资格获取</h4>
                <p style="text-indent:2em; color: black">
                    凡能遵守国家宪法及法律法规，承认本协会章程，自愿履行协会义务的电子科技大学中山学院在校全日制学生均可申请入会
                    暂无需会费，只要有兴趣就可以加入。每年10月社团招新找到数独社团帐篷报名即可入会

                </p>
                <h4 style="text-align: center;align-content: center">社团成员资格取消</h4>
                <p style="">
                    1、由本人提出书面申请，经本社团理事会审核通过后方可退会；<br>
                    2、严重违反本协会章程或触犯法律法规者，经本社团理事会审核通过后撤消其会员资格；<br>
                    3、未履行协会义务或不参加协会活动规定次数以上者视为自动退会；<br>
                    4、退会前应结清会费（培训费）余额并予以清还；<br>

                </p>
                <h4 style="text-align: center;align-content: center">会员享有以下权利</h4>
                <p style="">
                    1、参加社团举办／组织参与的各类活动；<br>
                    2、参加本社团活动的优先权；<br>
                    3、本社团的选举权、被选举权和表决权；<br>
                    4、对本社团工作的批评建议权和监督权；<br>
                    5、参与校社团联及本社团的评优工作；<br>
                    6、入会自愿、退会自由；<br>
                </p>

                <h4 style="text-align: center;align-content: center">会员履行下列义务</h4>
                <p style="">
                    1、维护社团团结和谐的气氛；<br>
                    2、执行本社团的各种决议；<br>
                    3、维护校社团联及本社团的合法权益；<br>
                    4、按有关规定交纳会费；<br>
                    5、完成本社团布置的任务；<br>
                    6、积极参与社团每项活动；<br>
                    7、向本社团反映情况，提供有关资料；<br>
                </p>
            </div>
        </div>

    </div>

</template:index>
<script type="text/javascript">
    var ItemId = "Item4";
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