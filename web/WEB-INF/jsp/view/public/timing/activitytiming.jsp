<template:user_backend htmlTitle="定时发布" bodyTitle="定时发布">
    <link rel="stylesheet" href="${cx}/resource/static/ueditor/themes/iframe.css">
    <link rel="stylesheet" href="${cx}/resource/static/flatpickr/dist/flatpickr.min.css">
    <style>
        #date{
            max-width: 320px;
            outline: none;
            border: 1px solid #ddd;
            background: #fbfbfb;
            border-top-right-radius: 3px;
            border-bottom-right-radius: 3px;
            color: rgba(0, 0, 0, 0.87);
            padding: 0 0 0 11px;
            height: 40px;
            width: 100%;
            margin-right: 0;
            /*margin-bottom: 0.5rem;*/
        }
        .input-group{
            margin-bottom: 10px;
        }

    </style>

    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <div class="col-md-11">
    <div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>定时发布</h3>
    </div>
    <div class="panel-body">
        <form class="form-inline" role="form" style="">
            <div class="form-group has-feedback">
                <p><h3>说明：</h3></p>
                <p>此处定时操作按照修改的时间会显示在主页面上，所以请认真核对时间信息。如果已经发布的讯息是不能再次修改时间的，若必须修改就要删除原来的文章，再写一次！ </p>
                <p><b>如果发生错误，请尽快联系该网站管理员<a href="mailto:1207511776@qq.com">1207511776@qq.com</a></b></p>
                <p> <b>不要违规操作造成后台数据阻塞！！</b></p>
            </div>
        </form>
        <hr>
        <form class="form-inline" role="form" style="float:left;">
            <div class="form-group has-feedback">
                <div class="input-group">
                    <div class="input-group-addon">活动id</div>
                    <input  readonly="readonly" value="${activity.id}" id="aid" class="form-control has-success" type="text" placeholder="活动id">
                </div>
                <br>
                <div class="input-group">
                    <div class="input-group-addon">活动标题</div>
                    <input  readonly="readonly"  value="${activity.title}" id="title" class="form-control has-success" type="text" placeholder="活动标题">
                </div>
                <br>

                <div class="input-group">
                    <div class="input-group-addon">活动发布者</div>
                    <input  readonly="readonly"  value="${activity.name}" id="username" class="form-control has-success" type="text" placeholder="活动标题">
                </div>
                <br>

                <input type="hidden" value="${activity.status}" >
                <div class="input-group">

                    <c:choose>
                        <c:when test="${activity.status==1}">
                            <div class="input-group-addon">已发布不可修改</div>
                            <input value="${timing.time}"  type="text"  class="form-control has-success" readonly="readonly">
                        </c:when>
                        <c:otherwise>
                            <%--日期事件选择器--%>
                            <div class="input-group-addon">请选择发送时间（定时发送）</div>
                            <input value="${timing.time}" id="date" class="flatpickr-input" data-enable-time=true data-time_24hr=true readonly="readonly">
                        </c:otherwise>
                    </c:choose>
                      </div>

                <br><br><br>
            </div>
        </form>
        <br><br><br>
        <div style="float:left;margin-left: 80px">
            <c:choose>
                <c:when test="${not empty timing.time and activity.status==0}">
                        <button  class="btn btn-primary" onclick="edit()" id="timebutton">修改</button>
                </c:when>
                <c:when test="${not empty timing.time and activity.status==1}">
                    <button  class="btn  btn-danger" id="timebutton" readonly="readonly">不可修改</button>
                </c:when>
                <c:otherwise>
                    <button  class="btn btn-info" onclick="upload()" id="timebutton">确定</button>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <div>

    </div>


    </div>
    <br>
    <br>
</template:user_backend>

<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/flatpickr/dist/flatpickr.js"></script>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_6";
    function minDate(){
        var date = new Date();
        var seperator1 = "-";
        var seperator2 = ":";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes();
        return currentdate;
    }

    $(function () {
        // 使用jQuery
        var nowtime=minDate();
        $(".flatpickr").flatpickr();
        $("#date").flatpickr({
            minDate: "today",
            enableTime: true
        });
    });



    function upload() {
        //timechoose==false
        var date=$("#date").val();
        var aid =$("#aid").val();
        var title =$("#title").val();
        var username =$("#username").val();

        if (date==""){
            layer.msg("定时发送时间还没有确认", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }

        var loadingIndex = null;
        var flag = {};
        flag["aid"] = aid;
        flag["title"] = title;
        flag["username"] = username;
        flag["date"] = date;
        var json = JSON.stringify(flag);
        $.ajax({
            async: true,
            method:"POST",
            url:"${cx}/timing/activity/upload",
            data:json,
            contentType: 'application/json',
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("定时上传成功", {time:3000, icon:6}, function(){
                        window.location.href = "${cx}/timing/index";
                    });
                }
            },
            error:function () {
                alert("ajax 请求失败")
            }
        })
    }
    function edit() {
        var date=$("#date").val();
        var aid =$("#aid").val();
        var title =$("#title").val();
        var username =$("#username").val();

        if (date==""){
            layer.msg("定时发送时间还没有确认", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }

        var loadingIndex = null;
        var flag = {};
        flag["aid"] = aid;
        flag["title"] = title;
        flag["username"] = username;
        flag["date"] = date;
        var json = JSON.stringify(flag);
        $.ajax({
            async: false,
            method:"POST",
            url:"${cx}/timing/activity/edit",
            data:json,
            contentType: 'application/json',
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("定时上传修改成功", {time:3000, icon:6}, function(){
                        window.location.href = "${cx}/timing/index";
                    });
                }
            },
            error:function () {
                alert("ajax 请求失败")
            }
        })
    }


</script>
