<template:user_backend htmlTitle="用户维护" bodyTitle="用户维护">

        <div class=" col-md-8 " style="margin-left: 30px">
            <ol class="breadcrumb">
                <li><a href="${cx}/user/">首页</a></li>
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
                            <label >用户名称</label>
                            <input type="text" value="测试数据" class="form-control" id="username" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label >邮箱地址</label>
                            <input type="email"value="212198@qq.com" class="form-control" id="email" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <div class="form-group">
                            <label >性别</label>
                            <span class=" fa fa-mars"></span><input value="男" name="gender" type="radio" id="male"  checked="checked">男
                            <span class="fa fa-venus" ></span><input value="女" name="gender" type="radio" id="female" >女
                        </div>
                        <div class="form-group">
                            <label >密码</label>
                            <input type="text" value="123456" class="form-control"  id="password" placeholder="请输入密码">
                        </div>
                        <div class="form-group">
                            <label >联系电话</label>
                            <input type="text" value="测试数据" class="form-control" id="tel" placeholder="请输入电话号码">
                        </div>
                        <div class="form-group">
                            <label >年级</label>
                            <input value="16" type="text" class="form-control" id="grade" placeholder="请输入年级">
                        </div>
                        <div class="form-group">
                            <label >会员届数</label>
                            <input value="1" type="text" class="form-control" id="id" placeholder="第几届会员">
                        </div>
                        <div class="form-group">
                            <label >所在单位(学院)</label>
                            <input type="text" value="测试数据" class="form-control" id="department" placeholder="请输入所在单位（学院）">
                        </div>
                        <div class="form-group">
                            <label >学号</label>
                            <input value="测试数据" type="text" class="form-control" id="sno" placeholder="请输入学号">
                            <p class="help-block label label-warning">如果是学生必须添加学号</p>
                        </div>
                        <div class="form-group">
                            <label >专业</label>
                            <input value="测试数据" type="text" class="form-control" id="major" placeholder="请输入专业">
                            <p class="help-block label label-warning">如果是学生必须添加专业</p>
                        </div>

                        <div class="form-group">
                            <label >主页地址</label>
                            <input value="测试数据" type="text" class="form-control" id="userUrl" placeholder="请输入主页地址">
                        </div>

                    </form>
                    <button id="insertBtn" onclick="insertBtn()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </div>
            </div>
        </div>



    <script type="text/javascript">
        //设置页面对应的菜单选项
        var ItemId = "Item1_1";
        function insertBtn(){
            var now = new Date().Format("yyyy-MM-dd h:m");
            var realname = $("#realname").val();
            var id = $("#id").val();
            var grade = $("#grade").val();

            var username = $("#username").val();
            var email = $("#email").val();
            var gender = $("input[name='gender']:checked").val();
            var password = $("#password").val();
            var pwd=$.md5(password);
            var sno=$("#sno").val();
            var tel = $("#tel").val();
            var department = $("#department").val();
            var major = $("#major").val();
            var userUrl = $("#userUrl").val();

            // alert("username"+username);
            // alert("email"+email);
            // alert("gender"+gender);
            // alert("tel"+tel);
            // alert("department"+department);
            // alert("major"+major);
            // alert("tel"+tel);
            // alert("userurl"+userurl);


            if ( username == "" ) {
                layer.msg("登录账号不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( tel == "" ) {
                layer.msg("电话号码不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( email == "" ) {
                layer.msg("电子邮箱不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            var loadingIndex = null;

            var data = {};
            data["realname"]=realname;
            data["username"] = username;
            data["email"] = email;
            data["password"] = pwd;
            data["gender"] = gender;
            data["tel"] = tel;
            data["department"] = department;
            data["sno"] = sno;
            data["major"] = major;
            data["level"] = 1;
            data["integral"] = 0;
            data["userUrl"] = userUrl;
            data["createtime"] = now;
            data["id"]=id;
            data["grade"]=grade;
            var json = JSON.stringify(data);
            // alert(json);
            // alert(data);
            $.ajax({
                async: false,
                type : "POST",
                url  : "${cx}/user/insert",
                data : json,
                contentType: 'application/json',
                beforeSend : function() {
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.success ) {
                        layer.msg("用户信息保存成功", {time:1000, icon:6}, function(){
                            window.location.href = "${cx}/user/";
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
