<template:user_backend htmlTitle="发表" bodyTitle="发表">
    <link rel="stylesheet" href="${cx}/resource/static/flatpickr/dist/flatpickr.min.css">
        <div class=" col-md-8 " style="margin-left: 30px">
            <ol class="breadcrumb">
                <li><a href="${cx}/public/announcement">首页</a></li>
                <li><a href="">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">新增公告信息<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form">
                        <div class="form-group">
                            <label >编号id</label>
                            <input style="width: 300px"  type="text"  placeholder="不需要填写，后台自动生成" class="form-control" id="id" readonly="readonly">
                        </div>
                        <div class="form-group">
                            <label >届数</label>
                            <input style="width: 300px"  style="width: 300px"  type="text"  placeholder="如果是第一届 输入 1" class="form-control" id="gid" >
                        </div>
                        <div class="form-group">
                            <label>公告内容</label><br>
                                <textarea  id="detail"   style="resize:none"  cols="80" rows="5" ></textarea>

                        </div>
                        <div class="form-group">
                            <label >发布者</label>
                            <input style="width: 300px"  type="text" value="${user.realname}" class="form-control" id="realname" placeholder="请输入真实姓名">
                        </div>
                        <div class="form-group">
                                <%--日期事件选择器--%>
                            <label >请选择发送时间（定时发送）<b>不可更改</b></label><br>
                            <%--<div class="input-group-addon">请选择发送时间（定时发送）<b>不可更改</b></div>--%>
                            <input style="width: 300px"  style="width: 300px" id="date" class="flatpickr-input form-control" data-enable-time=true data-time_24hr=true>
                        </div>

                    </form>
                    <br>
                    <button id="insertBtn" onclick="insertBtn()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </div>
            </div>
        </div>





</template:user_backend>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/flatpickr/dist/flatpickr.js"></script>
<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_3";
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

    $(function () {

        var id = createRandom2(10, 1000000);//产生100-1000000的随机数
        $("#id").attr("value",id)
        // 使用jQuery
        // var nowtime=minDate();
        $(".flatpickr").flatpickr();
        $("#date").flatpickr({
            minDate: "today",
            enableTime: true
        });
    })

    function insertBtn(){
        var date=$("#date").val();
        if (date==""){
            layer.msg("定时发送时间还没有确认", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var time = new Date().Format("yyyy-MM-dd h:m");
        var realname = $("#realname").val();
        var id = $("#id").val();
        var gid = $("#gid").val();
        var content = $("#detail").val();
        alert(content);
        if ( content == "" ) {
            layer.msg("发布内容不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

            });
            return;
        }
        if ( realname == "" ) {
            layer.msg("发布者姓名不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if ( gid == "" ) {
            layer.msg("届数不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }

        var loadingIndex = null;
        var data = {};
        data["realname"]=realname;
        data["id"] = id;
        data["gid"] = gid;
        data["content"] = content;
        data["time"] = time;
        data["date"] = date;
        var json = JSON.stringify(data);
        $.ajax({
            async: false,
            type : "POST",
            url  : "${cx}/public/announcement/insert",
            data : json,
            contentType: 'application/json',
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    layer.msg("公告信息保存成功", {time:1000, icon:6}, function(){
                        window.location.href = "${cx}/public/announcement";
                    });
                } else {
                    layer.msg("公告信息保存失败，请重新操作", {time:2000, icon:5, shift:6}, function(){

                    });
                }
            },
            error:function () {
                alert("ajax失败  ");
            }
        });
    }

</script>