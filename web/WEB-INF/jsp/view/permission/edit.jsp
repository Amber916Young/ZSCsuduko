<template:user_backend htmlTitle="功能维护" bodyTitle="功能维护">

    <div class=col-md-11">
        <ol class="breadcrumb">
            <li><a href="${cx}/permission/">首页</a></li>
            <li><a href="###">数据列表</a></li>
            <li class="active">修改</li>
        </ol>
        <div class="panel panel-default">
            <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
            <div class="panel-body">
                <form role="form">
                    <div class="form-group">
                        <label >许可名称</label>
                        <input type="text" class="form-control" value="${permission.name}" id="permissionname" placeholder="请输入许可名称">
                    </div>
                    <div class="form-group">
                        <label >链接地址</label>
                        <input type="text" class="form-control" value="${permission.url}" id="url" placeholder="请输入链接地址">
                    </div>
                    <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-pencil"></i> 修改</button>
                    <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </form>
            </div>
        </div>
    </div>

</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_2";
    $(function () {


        $("#updateBtn").click(function(){
            var permissionname = $("#permissionname").val();
            if ( permissionname == "" ) {
                layer.msg("许可名称不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            var loadingIndex = null;
            $.ajax({
                type : "POST",
                url  : "${cx}/permission/update",
                data : {
                    "name" : permissionname,
                    "url"  : $("#url").val(),
                    "id"  : "${param.id}"
                },
                beforeSend : function() {
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    alert("result"+result);
                    if ( result.success ) {
                        layer.msg("许可信息修改成功", {time:1000, icon:6}, function(){
                            window.location.href = "${cx}/permission/";
                        });
                    } else {
                        layer.msg("许可信息修改失败，请重新操作", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                },
                error:function () {
                    alert("ajax请求失败11211");
                }
            });
        });
    });
</script>
