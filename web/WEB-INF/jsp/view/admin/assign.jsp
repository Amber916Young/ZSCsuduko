<template:user_backend htmlTitle="会干信息维护" bodyTitle="会干信息维护">

        <div class=" col-md-8 " style="margin-left: 30px">
            <ol class="breadcrumb">
                <li><a href="${cx}/user/">首页</a></li>
                <li><a href="###">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="roleForm" role="form" class="form-inline">
                        <p>当前分配角色的用户名是：<input type="text"  name="realname" value="${admin.realname}" readonly></p>
                        <div class="form-group">
                            <label >未分配角色列表</label><br>
                            <select id="leftList" name="unassignroleids" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${unassignRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="left2RightBtn" onclick="left2RightBtn()" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="right2LeftBtn" onclick="right2LeftBtn()" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label>已分配角色列表</label><br>
                            <select id="rightList" name="assignroleids" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${assingedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>



    <script type="text/javascript">
        //设置页面对应的菜单选项
        var ItemId = "Item1_4";

        function right2LeftBtn(){
            var opts = $("#rightList :selected");
            if ( opts.length == 0 ) {
                layer.msg("请选择需要取消分配的角色数据", {time:2000, icon:5, shift:6}, function(){

                });
            } else {
                $.ajax({
                    type : "POST",
                    url  : "${cx}/user/dounAssign",
                    data : $("#roleForm").serialize(),
                    success : function(result) {
                        if ( result.success ) {
                            $("#leftList").append(opts);
                            layer.msg("取消分配角色数据成功", {time:2000, icon:6}, function(){
                            });
                        } else {
                            layer.msg("取消分配角色数据失败", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });

            }
        }
        function left2RightBtn(){
            var opts = $("#leftList :selected");
            if ( opts.length == 0 ) {
                layer.msg("请选择需要分配的角色数据", {time:2000, icon:5, shift:6}, function(){

                });
            } else {

                $.ajax({
                    type : "POST",
                    url  : "${cx}/user/doAssign",
                    data : $("#roleForm").serialize(),
                    success : function(result) {
                        if ( result.success ) {
                            $("#rightList").append(opts);
                            layer.msg("分配角色数据成功", {time:2000, icon:6}, function(){
                            });
                        } else {
                            layer.msg("分配角色数据失败", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });
            }
        }

    </script>

</template:user_backend>
