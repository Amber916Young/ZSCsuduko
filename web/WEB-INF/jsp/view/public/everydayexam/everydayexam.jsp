<template:user_backend htmlTitle="每日一练" bodyTitle="每日一练">
    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>每日一练</h3>
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
                <button type="button" class="btn btn-danger" onclick="deletesudukos()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/public/suduko/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                <br>
            </div>
            <div class="table-responsive">
                <form id="userForm">
                    <table class="table  table-bordered" >
                        <thead>
                        <tr >
                            <th width="30">#</th>
                            <th width="30"><input type="checkbox" id="allSelBox"></th>
                            <th width="80">题目id</th>
                            <th width="80">题目难度</th>
                            <th width="140">题目类型</th>
                            <th width="80">题目分值</th>
                            <th width="100">出题时间</th>
                            <th width="100">状态</th>
                            <th width="100">操作</th>
                        </tr>
                        </thead>
                        <tbody id="sudukoData">
                        </tbody>
                        <tfoot>
                        <tr >
                            <td colspan="12" align="center">
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


<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_2";
    var likeflg = false;
    $(function (){

        // alert("执行11");
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

            $("#sudukoData :checkbox").each(function(){
                this.checked = flg;
            });
        });




    });


    function pageQuery(pageno) {
        // alert("执行22222");
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 10};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/public/suduko/queryAll", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var sudukoPage = result.data;
                    var sudukos = sudukoPage.datas;
                    // alert("data 长度"+result.length);
                    $.each(sudukos, function (i, suduko) {
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td><input type="checkbox"  id="'+suduko.id+'" name="id" value="' + (i + 1) + '" ></td>';
                        tableContent += '  <td>' + suduko.id + '</td>';
                        tableContent += '  <td>' + suduko.difficulty_level + '</td>';
                        tableContent += '  <td>' + suduko.type + '</td>';
                        tableContent += '  <td>' + suduko.score + '</td>';
                        tableContent += '  <td>' + suduko.time + '</td>';
                        tableContent += '  <td>' + suduko.status + '</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="ViewDetail('+suduko.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button>';
                        tableContent += '	  <button type="button"  onclick="GoDeletesuduko(' + suduko.id + ')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });
                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno - 1) + ')">上一页</a></li>';
                    }

                    for (var i = 1; i <= sudukoPage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < sudukoPage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno + 1) + ')">下一页</a></li>';
                    }
                    $("#sudukoData").html(tableContent);
                    $(".pagination").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
    }


    function ViewDetail(id) {
        window.location.href = "${cx}/view/suduko?id="+id;
    }
    function GoDeletesuduko(id) {
        layer.confirm("是否继续",  {icon: 3, title:'提示'}, function(cindex){
            $.ajax({
                type : "POST",
                url  : "${cx}/public/suduko/delete",
                data : {id : id},
                success : function(result) {
                    if ( result.success ) {
                        // 刷新数据
                        window.location.href = "${cx}/public/suduko";
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
    function deletesudukos() {
        var boxes = $("input[name='id']:checked");
        var id = new Array();
        boxes.each(function(i){
            id[i] = $(this).attr("id");
        });
        if ( boxes.length == 0 ) {
            layer.msg("请选择需要删除的题目信息", {time:2000, icon:5, shift:6}, function(){
            });
        } else {
            layer.confirm("删除选择的题目信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                $.ajax({
                    type : "POST",
                    processData: false,
                    contentType: "application/json",
                    url  : "${cx}/public/suduko/deletes",
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
