<template:user_backend htmlTitle="会干信息维护" bodyTitle="会干信息维护">

        <div class=" col-md-8 " style="margin-left: 30px">
            <ol class="breadcrumb">
                <li><a href="${cx}/admin/">首页</a></li>
                <li><a href="###">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">用户基本信息<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form">
                        <div class="form-group">
                        <label >真实姓名</label>
                        <input type="text" value="realname" class="form-control" id="realname" placeholder="请输入用户真实名称">
                        </div>
                        <div class="form-group">
                            <label >性别</label>
                            <span class=" fa fa-mars"></span><input value="男" name="gender" type="radio" id="male"  checked="checked">男
                            <span class="fa fa-venus" ></span><input value="女" name="gender" type="radio" id="female" >女
                        </div>

                        <div class="form-group">
                            <label >任职部门</label>
                            <input type="text" value="" class="form-control" id="position" placeholder="请输入部门">
                            <%--<p class="help-block label label-warning"> </p>--%>
                        </div>
                        <div class="form-group">
                            <label >年级</label>
                            <input value="16" type="text" class="form-control" id="grade" placeholder="请输入年级16\17\18">
                        </div>
                        <div class="form-group">
                            <label >届数</label>
                            <input value="1" type="text" class="form-control" id="id" placeholder="第几届会员">
                        </div>
                        <div class="form-group">
                            <label >所在单位(学院)</label>
                            <input type="text" value="测试数据" class="form-control" id="department" placeholder="请输入所在单位（学院）">
                        </div>
                        <div class="form-group">
                            <label >学号</label>
                            <input value="测试数据" type="text" class="form-control" id="sno" placeholder="请输入学号">
                        </div>
                        <div class="form-group">
                            <label >专业</label>
                            <input value="测试数据" type="text" class="form-control" id="major" placeholder="请输入专业">
                        </div>


                    </form>
                    <button id="insertBtn" onclick="insertBtn()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </div>
            </div>
        </div>



    <script type="text/javascript">
        //设置页面对应的菜单选项
        var ItemId = "Item1_4";
        function insertBtn(){
            var realname = $("#realname").val();
            var id = $("#id").val();
            var grade = $("#grade").val();
            var gender = $("input[name='gender']:checked").val();
            var sno=$("#sno").val();
            var department = $("#department").val();
            var position = $("#position").val();
            var major = $("#major").val();

            if ( major == "" ) {
                layer.msg("专业不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( position == "" ) {
                layer.msg("职位不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( department == "" ) {
                layer.msg("学院不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( sno == "" ) {
                layer.msg("学号不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( gender == "" ) {
                layer.msg("性别不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( realname == "" ) {
                layer.msg("登录账号不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( id == "" ) {
                layer.msg("届数不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( grade == "" ) {
                layer.msg("年级不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            var loadingIndex = null;

            var data = {};
            data["realname"]=realname;
            data["position"] = position;
            data["gender"] = gender;
            data["id"] = id;
            data["department"] = department;
            data["sno"] = sno;
            data["major"] = major;
            data["grade"]=grade;
            var json = JSON.stringify(data);
            $.ajax({
                async: false,
                type : "POST",
                url  : "${cx}/admin/insert",
                data : json,
                contentType: 'application/json',
                beforeSend : function() {
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.success ) {
                        layer.msg("管理员（会干）信息保存成功", {time:1000, icon:6}, function(){
                            window.location.href = "${cx}/admin/";
                        });
                    } else {
                        layer.msg("用户信息保存失败，请重新操作", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                },
                error:function () {
                    alert("ajax失败  ");
                }
            });
        }

    </script>

</template:user_backend>
