<template:user_backend htmlTitle="修改密码" bodyTitle="修改密码">
    <div class="col-md-11">
        <div class="container-fluid " style="margin-left: 10px">
            <!-- 这里放置页面内容-->
            <!--TODO 表单 ajax技术 -->
            <div class="main_title"><h3 class="fa fa-user"><b> 个人密码</b></h3></div>
            <div class="form-control-static">
                <p><h4>修改密码</h4></p>
                <hr>
                <b style="color:darkred;">需要输入正确原来的密码才可以提交</b>
                <form id="userForm" >
                    <div class="gap">
                        <label>请输入原的密码：</label>
                        <input type="text"  id="edit_pwd" onblur="Check(this)"/>
                    </div>
                    <input type="hidden" id="realname" name="realname" value="${user.realname}"/>
                    <input type="hidden" id="beforePwd" value="${decode}" />
                    <div class="gap">
                        <label>请输入需要更改的密码：</label>
                        <input  type="text"  id="password" name="password"/>
                    </div>

                </form>
                <div class="gap">
                    <button id="submit" onclick="UpLoad()" style="margin-left:40px" class="btn btn-primary" type="button" value="提交">提交</button>
                </div>
            </div>

        </div>
    </div>
</template:user_backend>
<script>
    //设置页面对应的菜单选项
    var ItemId = "Item2_2";

    $(document).ready(function () {
        $("#submit").attr("disabled",true);
    });
    function Check(e) {
        var beforePwd = $("#beforePwd").val();
        var pwd=$.md5(e.value);
        if(pwd==""){
            $("#submit").attr("disabled",true);
            layer.msg("原来密码为空", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        else if(beforePwd==pwd){
            layer.msg("原来密码正确", {time:2000, icon:6, shift:6}, function(){
                $("#submit").attr("disabled",false);
            });
        }else{
            $("#submit").attr("disabled",true);
            layer.msg("原来密码不正确，请重新输入", {time:2000, icon:5, shift:6}, function(){
            });
        }
    }

    function UpLoad() {
        var loadingIndex = null;
        var realname =$("#realname").val();
        var password =$("#password").val().trim();
        var pwd=$.md5(password);
        alert("pwd"+pwd);
        var edit_pwd = $("#edit_pwd").val().trim();
        if(edit_pwd==""){
            $("#submit").attr("disabled",true);
            layer.msg("原来密码为空", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if(password==""){
            $("#submit").attr("disabled",true);
            layer.msg("修改密码为空", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var jsonData = {"realname" : realname, "password" : pwd};

        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/home/edit", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    layer.msg("修改密码成功", {time:2000, icon:6, shift:6}, function(){
                        window.location.href="${cx}/user/editpwd"
                    });
                }else {
                    layer.msg("修改密码成功", {time:2000, icon:6, shift:6}, function(){
                        window.location.href="${cx}/user/editpwd"
                    });
                }
            }
        })
    }


</script>