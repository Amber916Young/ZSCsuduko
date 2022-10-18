<template:user_backend htmlTitle="发布活动" bodyTitle="发布活动">
    <link rel="stylesheet" href="${cx}/resource/static/ueditor/themes/iframe.css">
    <link rel="stylesheet" href="${cx}/resource/static/flatpickr/dist/flatpickr.min.css">
    <style>
        #date{
            max-width: 320px;
            outline: none;
            border: 1px solid #ddd;
            background: #fbfbfb;
            border-top-right-radius: 3px;
            border-bottom-right-radius: 3px;
            color: rgba(0, 0, 0, 0.87);
            padding: 0 0 0 11px;
            height: 40px;
            width: 100%;
            margin-right: 0;
            /*margin-bottom: 0.5rem;*/
        }

    </style>

    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <div class="col-md-11">
    <div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>编辑活动</h3>
    </div>
    <b style="margin-left: 20px;text-align: center;color: darkred ; font-size: 16px">注意：若编辑后返回没有看到原内容请刷新</b>

    <div class="panel-body">
        <form class="form-inline" role="form" style="float:left;">
            <div class="form-group has-feedback">
                <div class="input-group">
                    <div class="input-group-addon">活动标题</div>
                    <input id="TitleText" class="form-control has-success" type="text" value="${preview.title}" placeholder="请输入活动标题">
                </div>
                <%--<input id="Acontent"   type="hidden" value="${preview.content}" >--%>
                <%--TODO  严重bug   如果内容带图片无法识别--%>
                <%--<c:choose>--%>
                    <%--<c:when test="${preview.content}"></c:when>--%>
                <%--</c:choose>--%>
                <input id="aid"   type="hidden" value="${preview.aid}" >
                <input id="id"   type="hidden" value="${preview.id}" >

                <br><br><br>
            </div>


        </form>
    </div>
    <script id="content" name="content" type="text/plain"  ></script>
    <div>
    <%--<input id="temp" type="hidden" value="${preview.content}"/>--%>
    <script id="editor" type="text/plain" style="width:100%;height:500px;">
            ${preview.content}
        </script>
    </div>

        <button onclick="ViewDetail(${preview.aid})" class="btn btn-warning" value="预览"/>预览</button>

        <button onclick="edit()" class="btn btn-info" value="修改"/>修改</button>


    </div>


    </div>
    <%--<button onclick="getContent()">获得内容</button>--%>
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
    var ItemId = "Item3_4";


    $(function () {
       // var content= $("#Acontent").val();
        <%--var content= "${preview.content}";--%>

        <%--&lt;%&ndash;alert(content);&ndash;%&gt;--%>
        <%--//判断ueditor 编辑器是否创建成功--%>
        <%--var ue = UE.getEditor('editor');--%>
        // ue.addListener("ready", function () {
        //
        //     // editor准备好之后才可以使用
        //     ue.setContent(content);
        //
        // });

        UE.getEditor('editor', {

            toolbars: [[//工具条
                // 'anchor', //锚点
                'undo', //撤销
                'redo', //重做
                'bold', //加粗
                'indent', //首行缩进
                // 'snapscreen', //截图
                'italic', //斜体
                'underline', //下划线
                'strikethrough', //删除线
                'subscript', //下标
                'fontborder', //字符边框
                'superscript', //上标
                'removeformat', //清除格式

                'formatmatch', //格式刷

                'fontfamily', //字体
                'fontsize', //字号
                'paragraph', //段落格式
                // 'source', //源代码
                // 'blockquote', //引用
                'pasteplain', //纯文本粘贴模式
                'selectall', //全选
                'rowspacingtop', //段前距
                'rowspacingbottom', //段后距
                'pagebreak', //分页
                // 'insertframe', //插入Iframe

                'justifyleft', //居左对齐
                'justifyright', //居右对齐
                'justifycenter', //居中对齐
                'justifyjustify', //两端对齐
                'forecolor', //字体颜色
                'backcolor', //背景色
                'insertorderedlist', //有序列表
                'insertunorderedlist', //无序列表
                'imagecenter', //居中
                'wordimage', //图片转存
                'lineheight', //行间距
                'touppercase', //字母大写
                'tolowercase', //字母小写
                'background', //背景
                // 'edittip ', //编辑提示
                'customstyle', //自定义标题
                'autotypeset', //自动排版
                'fullscreen', //全屏
                // 'print', //打印
                'horizontal', //分隔线
                'time', //时间
                'date', //日期
                'link', //超链接

                'unlink', //取消链接
                'edittable', //表格属性
                'edittd', //单元格属性
                'inserttable', //插入表格
                'insertrow', //前插入行
                'insertcol', //前插入列
                'mergeright', //右合并单元格
                'mergedown', //下合并单元格
                'deleterow', //删除行
                'deletecol', //删除列
                'splittorows', //拆分成行
                'splittocols', //拆分成列
                'splittocells', //完全拆分单元格
                'deletecaption', //删除表格标题
                'inserttitle', //插入标题
                'mergecells', //合并多个单元格
                'deletetable', //删除表格
                // 'cleardoc', //清空文档
                'insertparagraphbeforetable', //”表格前插入行”
                // 'insertcode', //代码语言

                'simpleupload', //单图上传
                'insertimage', //多图上传
                'imagenone', //默认
                'imageleft', //左浮动
                'imageright', //右浮动

                'emotion', //表情
                'spechars', //特殊字符
                'searchreplace', //查询替换
                'map', //Baidu地图
                // 'gmap', //Google地图
                'insertvideo', //视频
                // 'help', //帮助

                // 'directionalityltr', //从左向右输入
                // 'directionalityrtl', //从右向左输入

                // 'attachment', //附件

                // 'webapp', //百度应用

                'template', //模板
                // 'scrawl', //涂鸦
                'music', //音乐

                'drafts', // 从草稿箱加载
                'charts', // 图表
                'preview', //预览

            ]]
        });
    });

    <%--<!-- 文件上传组件属性设置 -->--%>
    <%--$('#file-select').fileinput({--%>
        <%--language: 'zh', //中文--%>
        <%--&lt;%&ndash;uploadUrl: '${cx}/home/upload', //上传路径&ndash;%&gt;--%>
        <%--'elErrorContainer': '#errorBlock',--%>
        <%--showCaption:true,  //显示文件路径等信息--%>
        <%--showUpload: false, //是否显示上传文本框里的上传按钮--%>
        <%--showRemove: false, //是否显示上传文本框里的移除按钮--%>
        <%--// dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域--%>
        <%--maxFileCount: 1, //表示允许同时上传的最大文件个数--%>
        <%--enctype: 'multipart/form-data',--%>
        <%--// allowedFileTypes: ['image', 'doc'],//配置允许文件上传的类型--%>
        <%--allowedPreviewTypes: ['image'],//配置所有的被预览文件类型--%>
        <%--allowedPreviewMimeTypes: ['jpg', 'png', 'gif','bmp']//控制被预览的所有mime类型--%>
    <%--});--%>

    function edit() {


        var TitleText= $("#TitleText").val();
        var id=$("#aid").val();
        if (TitleText==""){
            layer.msg("标题不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var arr = [];
        arr.push(UE.getEditor('editor').getContent());
        if (arr==null){
            layer.msg("内容不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var con = arr.toString();
        var loadingIndex = null;
        var flag = {};
        flag["content"] = con;
        flag["TitleText"] = TitleText;
        flag["id"] = id;

        var json = JSON.stringify(flag);
        $.ajax({
            async: false,
            method:"POST",
            url:"${cx}/public/article/editArticle",
            data:json,
            contentType: 'application/json',
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("上传成功", {time:3000, icon:6}, function(){
                        window.location.href = "${cx}/public/article";
                    });
                }
            },
            error:function () {
                alert("ajax 请求失败")
            }
        })
    }
    function getContent(content) {
        var arr = [];
        // arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        // arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        // UE.getEditor('editor').setContent(content);


        // alert(arr.join("\n"));
    }
    function ViewDetail(id) {

        var TitleText= $("#TitleText").val();
        var id=$("#aid").val();
        if (TitleText==""){
            layer.msg("标题不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var arr = [];
        arr.push(UE.getEditor('editor').getContent());
        if (arr==null){
            layer.msg("内容不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var con = arr.toString();
        var loadingIndex = null;
        var flag = {};
        flag["content"] = con;
        flag["TitleText"] = TitleText;
        flag["id"] = id;
        var json = JSON.stringify(flag);
        $.ajax({
            async: true,
            method:"POST",
            url:"${cx}/preview/BeforeArticle",
            data:json,
            contentType: 'application/json',
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                // alert("result"+result);
                if(result){
                    layer.msg("渲染成功", {time:2000, icon:6}, function(){
                        window.location.href = "${cx}/preview/previewArt?id="+result;

                    });
                }

            },
            error:function () {
                alert("ajax 请求失败")
            }
        })



    }

    $(function () {
        //富文本编辑器
        UE.getEditor('editor');
        UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
        UE.Editor.prototype.getActionUrl = function(action){
            // alert(action);
            if(action == '/uploadImage'){
                return '${cx}/ued/uploadImage';
            }else if(action == '/uploadvideo'){
                return '${cx}/ued/uploadvideo';
            }else{
                return this._bkGetActionUrl.call(this, action);
            }

        }
    });

</script>
