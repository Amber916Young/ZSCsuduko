<template:user_backend htmlTitle="发布周边" bodyTitle="发布周边">


    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <div class="col-md-11">
    <div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>发布周边</h3>
    </div>
    <div class="panel-body">
        <form class="form-inline" role="form" style="float:left;">
            <br><br><br>
        </form>
    </div>
        <form onsubmit="return upload()" action="${cx}/public/zhoubian/insert" method="post" id="UpLoadPhotoform" enctype="multipart/form-data">
            <div class="form-group has-feedback">
                <div class="input-group">
                    <div class="input-group-addon">周边标题</div>
                    <input name="title" id="TitleText" class="form-control has-success" type="text" placeholder="请输入活动标题">
                </div>
                <br><br><br>
            </div>
            <input id="file-select" type="file" name="file" accept="image/*"/>
            <button  class="btn btn-primary " value="上传"/>上传</button>
        </form>

    </div>


    </div>
    <br>
    <br>
</template:user_backend>
<%--ueditor 文本编辑器--%>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/ueditor/ueditor.parse.js"></script>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/flatpickr/dist/flatpickr.js"></script>


<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_7";


    $(function () {

    });

    <!-- 文件上传组件属性设置 -->
    $('#file-select').fileinput({
        language: 'zh', //中文
        <%--uploadUrl: '${cx}/home/upload', //上传路径--%>
        'elErrorContainer': '#errorBlock',
        showCaption:true,  //显示文件路径等信息
        showUpload: false, //是否显示上传文本框里的上传按钮
        showRemove: false, //是否显示上传文本框里的移除按钮
        // dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        maxFileCount: 1, //表示允许同时上传的最大文件个数
        enctype: 'multipart/form-data',
        // allowedFileTypes: ['image', 'doc'],//配置允许文件上传的类型
        allowedPreviewTypes: ['image'],//配置所有的被预览文件类型
        allowedPreviewMimeTypes: ['jpg', 'png', 'gif','bmp']//控制被预览的所有mime类型
    });

    function upload() {
        var TitleText = $("#TitleText").val();
        if (TitleText == "") {
            layer.msg("标题不能为空，请输入", {time: 2000, icon: 5, shift: 6}, function () {
            });
            return false;
        }
    }


</script>
