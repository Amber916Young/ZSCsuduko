<template:user_backend htmlTitle="发布活动" bodyTitle="发布活动">
    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>社团活动</h3>
            </div>
            <div class="panel-body">
                <form class="form-inline" role="form" style="float:left;">
                    <div class="form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">查询内容</div>
                            <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询关键字">
                        </div>
                    </div>
                    <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>

                </form>
                <button type="button" class="btn btn-danger" onclick="deleteActivitys()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/public/activity/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                <br> <br>
                <b >状态：0 未发表 &nbsp;&nbsp;1 已发表</b>
            </div>

            <hr >
            <div class="table-responsive">
                <form id="userForm">
                    <table class="table  table-bordered" >
                        <thead>
                        <tr >
                            <th width="30">#</th>
                            <th width="30"><input type="checkbox" id="allSelBox"></th>
                            <th>活动标题</th>
                            <th>活动内容</th>
                            <th>发布时间</th>
                            <th>发布者</th>
                            <th>状态</th>
                            <th width="100">操作</th>
                        </tr>
                        </thead>
                        <tbody id="activityData">
                        </tbody>
                        <tfoot>
                        <tr >
                            <td colspan="8" align="center">
                                <ul class="pagination">

                                </ul>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </form>
            </div>
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

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_4";
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
    function pageQuery(pageno) {
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
                        //取出符文本格式  标签去掉
                        var text = richTest(content);
                        if (text.length > 30) {
                            text = text.substr(0, 30);
                            text += ".......";
                        }
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td><input type="checkbox"  id="'+activity.id+'" name="id" value="' + (i + 1) + '" ></td>';
                        tableContent += '  <td>' + activity.title + '</td>';
                        tableContent += '  <td>' + text + '</td>';
                        // tableContent += '  <td>' + activity.content + '</td>';

                        tableContent += '  <td>' + activity.time + '</td>';
                        tableContent += '  <td>' + activity.name + '</td>';
                        tableContent += '  <td>' + activity.status + '</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="ViewDetail('+activity.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button>';
                        if(activity.status==0){
                            tableContent += '      <button type="button" onclick="goUpdatePage(' + activity.id + ')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';

                        }
                        tableContent += '	  <button type="button"  onclick="GoDeleteActivity(' + activity.id + ')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });
                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno - 1) + ')">上一页</a></li>';
                    }

                    for (var i = 1; i <= activityPage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < activityPage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno + 1) + ')">下一页</a></li>';
                    }
                    $("#activityData").html(tableContent);
                    $(".pagination").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
    }

    $(function (){
        pageQuery(1);
        $("#queryBtn").click(function(){
            var queryText =$('#queryText').val();//选中的值
            if ( queryText == "" ) {
                likeflg = false;
            } else {
                likeflg = true;
            }
            pageQuery(1);
        });
        $("#allSelBox").click(function(){
            var flg = this.checked;

            $("#activityData :checkbox").each(function(){
                this.checked = flg;
            });
        });

    });

    function goUpdatePage(id) {
        window.location.href = "${cx}/public/activity/edit?id="+id;
    }
    function ViewDetail(id) {
        window.location.href = "${cx}/view/activity?id="+id;
    }
    function GoDeleteActivity(id) {
        layer.confirm("是否继续",  {icon: 3, title:'提示'}, function(cindex){
            $.ajax({
                type : "POST",
                url  : "${cx}/public/activity/delete",
                data : {id : id},
                success : function(result) {
                    if ( result.success ) {
                        // 刷新数据
                        window.location.href = "${cx}/public/activity";
                    } else {
                        layer.msg("删除失败", {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
            layer.close(cindex);
        }, function(cindex){
            layer.close(cindex);
        });
    }
    function deleteActivitys() {
        var boxes = $("input[name='id']:checked");
        var id = new Array();
        boxes.each(function(i){
            id[i] = $(this).attr("id");
        });
        if ( boxes.length == 0 ) {
            layer.msg("请选择需要删除的活动信息", {time:2000, icon:5, shift:6}, function(){
            });
        } else {
            layer.confirm("删除选择的活动信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                $.ajax({
                    type : "POST",
                    processData: false,
                    contentType: "application/json",
                    url  : "${cx}/public/activity/deletes",
                    data : JSON.stringify(id),
                    dataType: "json",
                    cache: false,
                    success : function(result) {
                        if ( result.success ) {
                            pageQuery(1);
                        } else {
                            layer.msg("删除失败", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });

                layer.close(cindex);
            }, function(cindex){
                layer.close(cindex);
            });
        }
    }

</script>
