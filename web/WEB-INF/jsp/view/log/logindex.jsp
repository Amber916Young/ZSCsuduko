<template:user_backend htmlTitle="日志记录" bodyTitle="日志记录">
    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>日志记录</h3>
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
                <br>
            </div>
            <div class="table-responsive">
                <form id="userForm">
                    <table class="table  table-bordered" >
                        <thead>
                        <tr >
                            <th width="30">#</th>
                            <th>操作对象</th>
                            <th>请求路径</th>
                            <th>操作者</th>
                            <th>操作状态</th>
                            <th>操作时间</th>
                            <%--<th>操作者</th>--%>
                        </tr>
                        </thead>
                        <tbody id="OperationRecordData">
                        </tbody>
                        <tfoot>
                        <tr >
                            <td colspan="8" align="center">
                                <input value="" id="totalno" type="hidden">
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
    var ItemId = "Item4_1";
    var likeflg = false;


    function pageQuery(pageno) {
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 10};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }
        // alert($("#queryText").val());
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/log/OperationRecord/queryAll", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var pageContents = "";
                    //这里是加载省略号的flag
                    var isHiddenExist = 0;
                    var operationRecordPage = result.data;
                    var operationRecords = operationRecordPage.datas;
                    // alert("data 长度"+result.length);
                    $("#totalno").attr("value",operationRecordPage.totalno);

                    var totalsize = operationRecordPage.totalsize;
                    //页码
                    // alert(operationRecordPage.totalno);
                    for(var i = 1;i<= operationRecordPage.totalno;i++){
                        if(i==pageno){
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';

                        }else{
                            //如果是页首，中间页，页尾，当前页的前后三页则不省略。
                            if(i < 4 || i < (pageno + 3) && i > (pageno - 3)  || i > (operationRecordPage.totalno - 3)){
                                pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                                isHiddenExist=0;
                            }else{
                                if(isHiddenExist==0){
                                    pageContent +='<li ><a  href="javascript:void(0)">...</a></li>';
                                    isHiddenExist=1;
                                }
                            }
                        }
                    }




                    $(".pagination").html(pageContent);
                    $.each(operationRecords, function (i, operationRecord) {
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td>' + operationRecord.operateObject + '</td>';
                        tableContent += '  <td>' + operationRecord.operate + '</td>';
                        tableContent += '  <td>' + operationRecord.userRealname + '</td>';
                        tableContent += '  <td>' + operationRecord.operateState + '</td>';
                        tableContent += '  <td>' + operationRecord.operateTime + '</td>';
                        // tableContent += '  <td>' + operationRecord.operateObjectKey + '</td>';
                        tableContent += '</tr>';
                    });
                    // if (pageno > 1) {
                    //     pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno - 1) + ')">上一页</a></li>';
                    // }
                    //
                    // for (var i = 1; i <= operationRecordPage.totalno; i++) {
                    //
                    //     if (i == pageno) {
                    //         pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                    //     } else {
                    //         pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                    //     }
                    // }
                    //
                    // if (pageno < operationRecordPage.totalno) {
                    //     pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno + 1) + ')">下一页</a></li>';
                    // }
                    $("#OperationRecordData").html(tableContent);
                    // $(".pagination").html(pageContent);
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

            $("#OperationRecordData :checkbox").each(function(){
                this.checked = flg;
            });
        });
        var toatono = $("#totalno").val();

            $(".pagination").createPage({
                totalPage:toatono,
                currPage:14,
                backFn:function(p){
                    console.log("回调函数："+p);
                }

        })


    });

</script>
