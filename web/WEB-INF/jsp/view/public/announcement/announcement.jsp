<template:user_backend htmlTitle="发表" bodyTitle="发表">

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>发表公告</h3>
            </div>
            <div class="panel-body">
                <form class="form-inline" role="form" style="float:left;">
                    <div class="form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">查询条件</div>
                            <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                        </div>
                    </div>
                    <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                </form>
                <button type="button" class="btn btn-danger" onclick="deleteNotices()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/public/announcement/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                <br>
                <hr style="clear:both;">
                <p><b style="color: darkred">注意：在添加公告的时候已经定时了，要记得发布哦~</b></p>
                <hr style="clear:both;">
                <div class="table-responsive">
                    <form id="userForm">
                        <table class="table  table-bordered" style="">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" id="allSelBox"></th>
                                <th width="50">届数</th>
                                <th >发布内容</th>
                                <th width="140">发布时间</th>
                                <th width="80">发布用户</th>
                                <th width="80">状态</th>
                                <th width="80">操作</th>
                            </tr>
                            </thead>
                            <tbody id="userData">
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="10" align="center">
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
    </div>



</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_3";
    var likeflg = false;
    $(function () {
        pageQuery(1);

        $("#queryBtn").click(function(){
            var queryText = $("#queryText").val();
            if ( queryText == "" ) {
                likeflg = false;
            } else {
                likeflg = true;
            }

            pageQuery(1);
        });

        $("#allSelBox").click(function(){
            var flg = this.checked;

            $("#userData :checkbox").each(function(){
                this.checked = flg;
            });
        });
    });


    // 分页查询
    function pageQuery( pageno ) {
        var loadingIndex = null;

        var jsonData = {"pageno" : pageno, "pagesize" : 10};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }

        $.ajax({
            type : "POST",
            url  : "${cx}/public/announcement/pageQuery",
            data : jsonData,
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var announcementPage = result.data;
                    var announcements = announcementPage.datas;
                    $.each(announcements, function(i, announcement){
                        tableContent += '<tr>';
                        tableContent += '  <td>'+(i+1)+'</td>';
                        tableContent += '  <td><input type="checkbox"  id="'+ announcement.id+'"  name="id" value="'+(i+1)+'" ></td>';
                        tableContent += '  <td>'+announcement.gid+'</td>';
                        tableContent += '  <td >'+announcement.content+'</td>';
                        tableContent += '  <td>'+announcement.time+'</td>';
                        tableContent += '  <td>'+announcement.realname+'</td>';
                        tableContent += '  <td>'+announcement.status+'</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="goViewPage(\''+announcement.id+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '	  <button type="button"  onclick="deleteNotice(\''+announcement.id+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });

                    if ( pageno > 1 ) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                    }

                    for ( var i = 1; i <= announcementPage.totalno; i++ ) {
                        if ( i == pageno ) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">'+i+'</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery('+i+')">'+i+'</a></li>';
                        }
                    }

                    if ( pageno < announcementPage.totalno ) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                    }

                    $("#userData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("公告信息分页查询失败", {time:2000, icon:5, shift:6}, function(){

                    });
                }
            }
        });
    }

    function goViewPage(id) {
        window.location.href = "${cx}/public/announcement/view?id="+id;
    }



    function deleteNotices() {
        // var boxes = $("#userData :checkbox");  感觉这个有点问题
        var boxes = $("input[name='id']:checked");

        var id = new Array();
        boxes.each(function(i){
            id[i] = $(this).attr("id");
            // alert(id[i]);
        });


        if ( boxes.length == 0 ) {
            layer.msg("请选择需要删除的公告信息", {time:2000, icon:5, shift:6}, function(){

            });
        } else {
            layer.confirm("删除选择的公告信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                $.ajax({
                    type : "POST",
                    processData: false,
                    contentType: "application/json",
                    url  : "${cx}/public/announcement/deletes",
                    data : JSON.stringify(id),
                    dataType: "json",
                    cache: false,
                    success : function(result) {
                        if ( result.success ) {
                            pageQuery(1);
                        } else {
                            layer.msg("公告信息删除失败", {time:2000, icon:5, shift:6}, function(){

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

    function deleteNotice( id ) {
        layer.confirm("删除公告信息【"+id+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

            // 删除用户信息
            $.ajax({
                type : "POST",
                url  : "${cx}/public/announcement/delete",
                data : { id : id },
                success : function(result) {
                    if ( result.success ) {
                        pageQuery(1);
                    } else {
                        layer.msg("公告信息删除失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });

            layer.close(cindex);
        }, function(cindex){
            layer.close(cindex);
        });
    }



</script>
