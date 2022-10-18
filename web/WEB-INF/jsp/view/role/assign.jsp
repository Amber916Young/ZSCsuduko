<template:user_backend htmlTitle="许可维护" bodyTitle="许可维护">

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
            </div>
            <div class="panel-body">
                <button class="btn btn-success" onclick="doAssign()">分配许可</button>
                <ul id="permissionTree" class="ztree"></ul>
            </div>
        </div>
    </div>


</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_3";

    $(function () {

        var setting = {
            check : {
                enable : true
            },
            async: {
                enable: true,
                url:"${cx}/permission/loadAssignData?roleid=${param.id}",
                autoParam:["id", "name=n", "level=lv"]
            },
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                    }

                }
            }
        };

        $.fn.zTree.init($("#permissionTree"), setting);
    });
    function doAssign() {
        var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
        var nodes = treeObj.getCheckedNodes(true);
        if ( nodes.length == 0 ) {
            layer.msg("请选择需要分配的许可信息", {time:2000, icon:5, shift:6}, function(){

            });
        } else {
            var d = "roleid=${param.id}";
            $.each(nodes, function(i, node){
                d += "&permissionids="+node.id
            });
            $.ajax({
                type : "POST",
                url  : "${cx}/role/doAssign",
                data : d,
                success : function (result) {
                    if ( result ) {
                        layer.msg("分配许可信息成功", {time:2000, icon:6}, function(){
                            window.location.href = "${cx}/role/";
                        });
                    } else {
                        layer.msg("分配许可信息失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }
    }
</script>