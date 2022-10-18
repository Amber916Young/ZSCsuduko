<template:user_backend htmlTitle="个人评论" bodyTitle="个人评论">

    <div class="col-md-11">
        <div class="container-fluid " style="margin-left: 10px">
            <!-- 这里放置页面内容-->
            <!--TODO 表单 ajax技术 -->
            <div class="main_title"><h3 class="fa fa-user"><b> 个人评论</b></h3></div>
            &nbsp;&nbsp;<strong>总${pageInfo.total}记录数,每页${pageInfo.pageSize}条,共${pageInfo.pages}页.
            当前第${pageInfo.pageNum}页, 记录范围:${pageInfo.startRow}-${pageInfo.endRow},
            共${pageInfo.size}条记录 </strong>  <br>  <br>
            <c:forEach var="list" items="${commentList}" varStatus="loop">
                <c:if test="${not empty articles[loop.count-1]}">
                    <%--<c:if test="${articles.id == commentList.aid}">--%>
                        <div class="col-md-4" style="padding: 10px;margin-right: 40px;border:1px solid #a5b6c8;background:#eef3f7;margin-bottom: 20px;position:relative;">
                            <h4><b><a target="_blank"  href="${list.aurl}">标题：${list.atitle}</a></b></h4>
                            <p><b>评论内容:</b>${list.content}</p>
                            <span class=""><b>评论时间:</b>${list.time.substring(0,16)}</span>
                        </div>
                    <%--</c:if>--%>
                </c:if>
            </c:forEach>
        </div>
        <div class=" text-center" style="margin-top: 70px">
            <zsc:page url="${cx}/user/comment"/>
        </div>
    </div>
</template:user_backend>
<script>
    //设置页面对应的菜单选项
    var ItemId = "Item2_5";

    $(document).ready(function () {

    });

</script>