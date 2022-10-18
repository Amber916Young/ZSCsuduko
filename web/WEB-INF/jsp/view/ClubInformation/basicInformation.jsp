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
                <h3 style="text-align: center;align-content: center">社团简介</h3>
                <p style="text-indent:2em;"> 电子科技大学中山学院数独运动协会成立于2018年6月。
                    社团成立目的是为了丰富校园文体娱乐活动形式，积极开展活动，营造良好的校园文化氛围。
                    帮助学生冷静思考，培养想像力、逻辑推理能力和创新思维；提高耐心、专注力和毅力。
                    使学生思考问题更有条理性。
                </p>
                <h3 style="text-align: center;align-content: center">社团结构</h3>
                <p style="text-indent:2em;">
                    社团现有81位会员（2018.6-2019.6），设有秘书部，组织部，宣传部，技术部四个部门。
                </p>
                <br>
                <h3 style="text-align: center;align-content: center">社团现任会干</h3>
                <p style="text-align: center">社团指导老师：程东  计算机学院</p>
                <select id="selectid" name="selectid" >
                    <option value="1" ${administrator.id eq "1" ? "selected":""} >2018</option>
                    <option value="2" ${administrator.id eq "2" ? "selected":""} >2019</option>
                    <option value="3" ${administrator.id eq "3"?"selected":""} >2020</option>
                    <option value="4" ${administrator.id eq "4"?"selected":""} >2021</option>
                    <option value="5" ${administrator.id eq "5"?"selected":""} >2022</option>
                </select>
                <input type="button" value="查询" id="check" onclick="GetSelectid()">
                <h6>第${administrator.id}届</h6>
                <form id="userForm">
                    <table class="table  table-bordered" style="">
                        <thead>
                        <tr >
                            <th width="30">#</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>年级</th>
                            <th>学院</th>
                            <th>职位</th>
                        </tr>
                        </thead>
                        <tbody id="userData">
                        </tbody>
                        <tfoot>
                            <%--<tr >--%>
                            <%--<td colspan="8" align="center">--%>
                            <%--<ul class="pagination">--%>

                            <%--</ul>--%>
                            <%--</td>--%>
                            <%--</tr>--%>
                        </tfoot>
                    </table>
                </form>
            </div>
        </div>

    </div>

</template:index>
<script type="text/javascript">
    var ItemId = "Item1";
    function GetSelectid(){
        var sid =$('#selectid').val();//选中的值
        // alert("sid"+sid);
        var loadingIndex = null;
        if(sid==""||sid==null){
            sid=1;
        };
        var jsonData ={};
        jsonData["sid"] = sid;
        var json = JSON.stringify(jsonData);
        var tableContent = "";
        $.ajax({
            async: false,
            type:"POST",
            url: "${cx}/clubinformation/find_basicinformation", //数据URL路径
            data:json,
            contentType: "application/json",
            // cache: false,
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                // alert("data 长度"+result.length);
                for (var i = 0; i < result.length; i++) {
                    var id = result[i].id;
                    var realname = result[i].realname;
                    var gender = result[i].gender;
                    var department = result[i].department;
                    var major = result[i].major;
                    var position = result[i].position;
                    var grade = result[i].grade;
                    var sid = result[i].sid;
                    tableContent += '<tr>';
                    tableContent += '  <td>'+(i+1)+'</td>';
                    tableContent += '  <td>'+realname+'</td>';
                    tableContent += '  <td>'+gender+'</td>';
                    tableContent += '  <td>'+"20"+grade+'</td>';
                    tableContent += '  <td>'+department+'</td>';
                    tableContent += '  <td>'+position+'</td>';
                    tableContent += '</tr>';
                }
                $("#userData").html(tableContent);
            },
            error:function () {
                alert("ajax请求失败0 0");
            }
        })
    }

    $(function (){
        var sid =$('#selectid').val();//选中的值
        var loadingIndex = null;
        // alert("sid"+sid);
        if(sid==""||sid==null){
            sid=1;
        };
        var jsonData ={};
        jsonData["sid"] = sid;
        var json = JSON.stringify(jsonData);
        var tableContent = "";
        $.ajax({
            async: false,
            type:"POST",
            url: "${cx}/clubinformation/find_basicinformation", //数据URL路径
            data:json,
            contentType: "application/json",
            // cache: false,
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                // alert("data 长度"+result.length);
                for (var i = 0; i < result.length; i++) {
                    var id = result[i].id;
                    var realname = result[i].realname;
                    var gender = result[i].gender;
                    var department = result[i].department;
                    var major = result[i].major;
                    var position = result[i].position;
                    var grade = result[i].grade;
                    var sid = result[i].sid;
                    tableContent += '<tr>';
                    tableContent += '  <td>'+(i+1)+'</td>';
                    tableContent += '  <td>'+realname+'</td>';
                    tableContent += '  <td>'+gender+'</td>';
                    tableContent += '  <td>'+"20"+grade+'</td>';
                    tableContent += '  <td>'+department+'</td>';
                    tableContent += '  <td>'+position+'</td>';
                    tableContent += '</tr>';
                }
                $("#userData").html(tableContent);
            },
            error:function () {
                alert("ajax请求失败= =");
            }
        })
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