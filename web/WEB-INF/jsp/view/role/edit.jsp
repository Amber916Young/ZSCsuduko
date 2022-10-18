<template:user_backend htmlTitle="许可维护" bodyTitle="许可维护">

        <div class=col-md-11">
            <ol class="breadcrumb">
                <li><a href="${cx}/role/">首页</a></li>
                <li><a href="###">数据列表</a></li>
                <li class="active">编辑</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form">
                        <div class="form-group">
                            <label >职位/身份名称</label>
                            <input type="text" class="form-control" id="rolename" placeholder="请输入更改的职位/身份名称">
                        </div>

                        <button id="insertBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_3";
    $(function () {
        $("#insertBtn").click(function(){
            var rolename = $("#rolename").val();
            alert(rolename);
            if ( rolename == "" ) {
                layer.msg("名称不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
                });
                return;
            }

            var loadingIndex = null;
            $.ajax({
                type : "POST",
                url  : "${cx}/role/upload",
                data : {
                    "name" : rolename,
                    "id":${param.id}
                },
                beforeSend : function() {
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    alert("result"+result);
                    if ( result.success ) {
                        layer.msg("信息保存成功", {time:1000, icon:6}, function(){
                            window.location.href = "${cx}/role/";
                        });
                    } else {
                        layer.msg("信息保存失败，请重新操作", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                },
                error:function () {
                    alert("ajax请求失败");
                }


            });
        });
    });
</script>