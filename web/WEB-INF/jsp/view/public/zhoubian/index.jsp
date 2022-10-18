<template:user_backend htmlTitle="更换周边部分" bodyTitle="更换周边部分">

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
            </div>
            <%--<button type="button" class="btn btn-danger" onclick="deleteActivitys()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>--%>
            <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/public/zhoubian/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
            <br> <br>
            <div class="panel-body">
                <c:choose>
                    <c:when test="${empty zhoubianList}">
                        <b style="color:red;"> 目前首页周边部分暂时为空</b>
                    </c:when>
                    <c:otherwise>
                        <b style="font-size: 16px">已经发布</b><br>
                        <hr>
                        <c:forEach var="list" items="${zhoubianList}">

                                <div class="col-sm-4 col-md-3" style="margin-bottom: 20px;height: 330px;position:relative;">
                                    <b>标题：<input type="text" readonly="readonly" value="${list.title}"></b><br>
                                    <b>发布时间：${list.time.substring(0,10)}</b>
                                    <div class="thumbnail">
                                        <img  width="200px" src="${list.fileUrl}">
                                    </div>
                                    <div class="caption" style="margin-bottom:0px;position: absolute">
                                        <a href="${cx}/public/zhoubian/del/${list.id}" class="btn btn-primary" role="button">删除</a>
                                    </div>
                                </div>

                        </c:forEach>
                        <hr>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>


</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_7";


    $(function (){


    });



</script>
