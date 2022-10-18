<template:user_backend htmlTitle="更换轮播部分" bodyTitle="更换轮播部分">
        <div class=" col-md-8 " style="margin-left: 30px">
            <ol class="breadcrumb">
                <li><a href="${cx}/public/changeimage">首页</a></li>
                <li><a href="${cx}/public/changeimage">数据列表</a></li>
                <li class="active">当前文章id = ${article.id}</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <strong><a href="${cx}/view/particles?id=${article.id}">${article.title}</a></strong>
                    <p >作者:${article.name}</p>
                    <div><b>该片文章发布状态:</b></div><p>${article.status}</p>
                </div>
                <b style="font-size: 16px;color : darkred">如果文章发布状态为1，则会立即发布至轮播处</b>

            </div><br>


            <form action="${cx}/public/changeimage/upload2" method="post" id="UpLoadPhotoform"
                  enctype="multipart/form-data">
                <input id="aid" type="hidden" value="${article.id}"  name="aid"/>
                <input id="title" type="hidden" value="${article.title}"  name="title"/>
                <input id="aurl" type="hidden" value="${cx}/view/particles?id=${article.id}"  name="aurl"/>
                <input id="id" value="${carousel.id}" type="hidden">
                <c:if test="${empty carousel}" >
                    <b style="font-size: 18px">请选择封面，因为轮播部分是图片轮播</b>
                    <input id="file" type="file" name="file" accept="image/*"/>
                    <br/>
                    <input type="submit" value="上传" style="color: black"/>
                </c:if>
            </form> <br>
            <p>
                <c:if test="${not empty carousel}" >
                    <b style="font-size: 18px">已经发布于轮播处</b>
                    <div class="col-sm-4 col-md-3">
                        <div class="thumbnail">
                            <img src="${carousel.url}">
                            <c:if test="${article.status==0}">
                                <div class="caption">
                                    <a href="${cx}/public/changeimage/del2/${carousel.id}/${article.id}" class="btn btn-primary" role="button">删除</a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </p>
          <br>
            <c:if test="${article.status==0}">
                <div>
                    <button style="text-align: center" class="btn btn-primary" onclick="Altercarousel2()">上传至轮播处</button>
                </div>
            </c:if>


        </div>
    <br>  <br>  <br>  <br>
</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_5";
    $(function () {

    });

    function Altercarousel2() {
        var aid = $("#aid").val();
        var jsonData = {"id":aid};
        var loadingIndex=null;
        $.ajax({
             async: true,
             type:"POST",
             data:jsonData,
             url: "${cx}/view/Altercarousel2", //数据URL路径
        beforeSend : function() {
            loadingIndex = layer.msg('处理中', {icon: 16});
        },
        success : function(result) {
            layer.close(loadingIndex);
            if (result.success) {
                layer.msg("更改成功", {time: 2000, icon: 6, shift: 6}, function () {
                });
            } else {
                layer.msg("更改失败", {time: 2000, icon: 5, shift: 6}, function () {
                });
            }
        }
        });
    }



</script>