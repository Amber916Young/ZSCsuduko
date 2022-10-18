<template:user_backend htmlTitle="会干信息维护" bodyTitle="修改">

    <div class="col-md-8 " style="margin-left: 30px">
        <ol class="breadcrumb">
            <li><a href="${cx}/admin/">首页</a></li>
            <li><a href="###">数据列表</a></li>
            <li class="active">修改</li>
        </ol>
        <div class="panel panel-default">
            <div class="panel-heading">会干信息公开至主页<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
            <div class="panel-body">
                <form   id="userForm" enctype="multipart/form-data" method="post" action="${cx}/admin/update">
                    <div class="gap form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">真实头像:</div>
                            <img style="border: 1px solid black" width="200" src="${adminPhoto.fileUrl}"/>
                        </div>
                        <input  id="file-select"  type="file" name="file"  accept="image/*"  multiple />
                    </div>
                    <div class="form-group">
                        <label >真实姓名</label>
                        <input  type="text" name="realname" value="${auser.realname}" class="form-control" id="realname" placeholder="请输入用户真实名称" readonly="readonly">
                    </div>
                    <div class="form-group" id="gender">
                        <label >性别</label>
                        <span class=" fa fa-mars"></span>
                        <input readonly="readonly"  value="男" name="gender" type="radio" id="male"  <c:if test="${auser.gender=='男'}">checked="checked"</c:if>>男
                        <span class="fa fa-venus" ></span>
                        <input readonly="readonly" value="女" name="gender" type="radio" id="female" <c:if test="${auser.gender=='女'}">checked="checked"</c:if>>女
                    </div>

                    <div class="form-group">
                        <label >任职部门</label>
                        <input readonly="readonly" name="position" type="text" value="${auser.position}" class="form-control" id="position" placeholder="请输入部门">
                    </div>
                    <div class="form-group">
                        <label >年级</label>
                        <input  readonly="readonly" name="grade" value="${auser.grade}" type="text" class="form-control" id="grade" placeholder="请输入年级16\17\18">
                    </div>
                    <div class="form-group">
                        <label >届数</label>
                        <input readonly="readonly" name="id" value="${auser.id}" type="text" class="form-control" id="id" placeholder="第几届会员">
                        <input  readonly="readonly" name="sid" value="${auser.sid}" type="hidden" class="form-control" id="id" placeholder="第几届会员">
                    </div>
                    <div class="form-group">
                        <label >所在单位(学院)</label>
                        <input readonly="readonly" name="department" type="text" value="${auser.department}" class="form-control" id="department" placeholder="请输入所在单位（学院）">
                    </div>
                    <div class="form-group">
                        <label >学号</label>
                        <input readonly="readonly" name="sno" value="${auser.sno}" type="text" class="form-control" id="sno" placeholder="请输入学号">
                    </div>
                    <div class="form-group">
                        <label >专业</label>
                        <input readonly="readonly" name="major" value="${auser.major}" type="text" class="form-control" id="major" placeholder="请输入专业">
                    </div>
                        <%--<button id="updateBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-plus"></i> 上传个人图片</button>--%>
                        <%--<button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>--%>
                </div>
            </form>
        </div>
    </div>

</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_4";
    $(function () {
        <!-- 文件上传组件属性设置 -->
        $('#file-select').fileinput({
            language: 'zh', //中文
            <%--uploadUrl: '${cx}/home/uploadAttachement', //上传路径--%>
            // 'elErrorContainer': '#errorBlock',
            // showUpload: false, //是否显示上传文本框里的上传按钮
            // showRemove: false, //是否显示上传文本框里的移除按钮
            // dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
            maxFileCount: 1, //表示允许同时上传的最大文件个数
            enctype: 'multipart/form-data',
            allowedFileTypes: ['image'],//配置允许文件上传的类型
            allowedPreviewTypes: ['image'],//配置所有的被预览文件类型
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif']//控制被预览的所有mime类型
        });
        $("#resetBtn").click(function(){
            // Jquery[0] ==> DOM
            // $(DOM) ==> Jquery
            $("#userForm")[0].reset();
        });

        $("#updateBtn").click(function() {
            var realname =$("#realname").val();
            var position =$("#position").val();
            var gender =$("#gender input[name=gender]:radio[checked]").val()
            alert(gender);
            var id =$("#id").val();
            var department =$("#department").val();
            var grade =$("#grade").val();
            var major =$("#major").val();
            var sno =$("#sno").val();


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
                url  : "${cx}/admin/update",
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

        });


    });
</script>
