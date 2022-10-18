<template:user_backend htmlTitle="定时发布" bodyTitle="定时发布">

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
            </div>
            <div class="panel-body">
                <form class="form-inline" role="form" style="float:left;">
                    <div class="form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">查询内容</div>
                            <input id="TitleText" class="form-control has-success" type="text" placeholder="请输入查询关键字">
                        </div>
                    </div>
                    <button onclick="queryBtn()" id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                </form>
                <br>
                <hr style="clear:both;">
                <b>发布状态 1：已发布 and 0：未发布</b>
                <p><b style="color: darkred">注意：已经发布的文章不可修改时间，必须删除重写</b></p>
                <hr style="clear:both;">
                <b style="font-size: 25px">社团活动</b>
                <div class="table-responsive">
                    <form id="userForm">
                        <table class="table  table-bordered" >
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>活动标题</th>
                                <th>活动内容</th>
                                <th>编辑时间</th>
                                <%--<th>定时时间</th>--%>
                                <th>发布状态</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="activityData">
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="8" align="center">
                                    <ul class="pagination" id="pagination1">

                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </form>
                </div>
                <hr>
                <b style="font-size: 25px">技巧文章(精选文章)</b>
                <div class="table-responsive">
                    <form id="articleFrom">
                        <table class="table  table-bordered" >
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>文章标题</th>
                                <th>文章内容</th>
                                <th>编辑时间</th>
                                    <%--<th>定时时间</th>--%>
                                <th>发布状态</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="articleData">
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="8" align="center" >
                                    <ul class="pagination" id="pagination2">

                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </form>
                </div>



                <hr>
            </div>
        </div>
    </div>


</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_6";
    var likeflg = false;

    function richTest(content){
        // 去除 富文本格式
        var data =content;
        data = data.replace(/(\n)/g, "");
        data = data.replace(/(\t)/g, "");
        data = data.replace(/(\r)/g, "");
        data = data.replace(/<\/?[^>]*>/g, "");
        data = data.replace(/\s*/g, "");
        return data;

    }
    function pageQueryactivity(pageno) {
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 10};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/public/activity/queryAll", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var activityPage = result.data;
                    var activitys = activityPage.datas;
                    // alert("data 长度"+result.length);
                    $.each(activitys, function (i, activity) {
                        var content = activity.content;
                        var contentlen = content.length;
                        // alert("contentlen=="+contentlen);
                        var text = richTest(content);
                        if (text.length > 30) {
                            text = text.substr(0, 30);
                            text += ".......";
                        }
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td>' + activity.title + '</td>';
                        tableContent += '  <td>' + text + '</td>';
                        tableContent += '  <td>' + activity.time + '</td>';
                        // tableContent += '  <td>' + activity.time + '</td>';
                        tableContent += '  <td>' + activity.status + '</td>';

                        tableContent += '  <td>';
                        //TODO 此处是前往定时发布页面
                        tableContent += '      <button type="button" onclick="goAssignIndexPage(' + activity.id + ')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });
                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQueryactivity(' + (pageno - 1) + ')">上一页</a></li>';
                    }

                    for (var i = 1; i <= activityPage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQueryactivity(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < activityPage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQueryactivity(' + (pageno + 1) + ')">下一页</a></li>';
                    }
                    $("#activityData").html(tableContent);
                    $("#pagination1").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
    }

////////////////////////////////////////////////////////////////////////////
    function pageQueryarticle(pageno) {
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 10};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/public/article/queryAll", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var articlePage = result.data;
                    var articles = articlePage.datas;
                    // alert("data 长度"+result.length);
                    $.each(articles, function (i, article) {
                        var content = article.content;
                        var contentlen = content.length;
                        // alert("contentlen=="+contentlen);
                        var text = richTest(content);
                        if (text.length > 30) {
                            text = text.substr(0, 30);
                            text += ".......";
                        }
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td>' + article.title + '</td>';
                        tableContent += '  <td>' + text + '</td>';
                        tableContent += '  <td>' + article.time + '</td>';
                        // tableContent += '  <td>' + activity.time + '</td>';
                        tableContent += '  <td>' + article.status + '</td>';

                        tableContent += '  <td>';
                        //TODO 此处是前往定时发布页面
                        tableContent += '      <button type="button" onclick="goAssignArticleIndexPage(' + article.id + ')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });
                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQueryarticle(' + (pageno - 1) + ')">上一页</a></li>';
                    }

                    for (var i = 1; i <= articlePage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQueryarticle(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < articlePage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQueryarticle(' + (pageno + 1) + ')">下一页</a></li>';
                    }
                    $("#articleData").html(tableContent);
                    $("#pagination2").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
    }


    $(function (){
        pageQueryactivity(1);
        pageQueryarticle(1);
    });

    function goAssignIndexPage(aid) {
        window.location.href = "${cx}/timing/activity?id="+aid;
    }
    function goAssignArticleIndexPage(aid) {
        window.location.href = "${cx}/timing/article?id="+aid;
    }

</script>
