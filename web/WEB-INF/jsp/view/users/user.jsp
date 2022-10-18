<template:user_backend htmlTitle="用户维护" bodyTitle="用户维护">

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
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
                <%--<br><br>--%>
                <%--<form class="form-inline" role="form" style="float:left;">--%>
                    <%--<div class="form-group has-feedback">--%>
                        <%--<div class="input-group">--%>
                            <%--<div class="input-group-addon">按照届数查询:</div>--%>
                            <%--<select style=" "  id="queryText2" name="queryText" class="form-control has-success">--%>
                                <%--<option value="1" ${account.id eq "1" ? "selected":""} >2018</option>--%>
                                <%--<option value="2" ${account.id eq "2" ? "selected":""} >2019</option>--%>
                                <%--<option value="3" ${account.id eq "3"?"selected":""} >2020</option>--%>
                                <%--<option value="4" ${account.id eq "4"?"selected":""} >2021</option>--%>
                                <%--<option value="5" ${account.id eq "5"?"selected":""} >2022</option>--%>
                                <%--<option value="6" ${account.id eq "6" ? "selected":""} >2023</option>--%>
                                <%--<option value="7" ${account.id eq "7"?"selected":""} >2024</option>--%>
                                <%--<option value="8" ${account.id eq "8"?"selected":""} >2025</option>--%>
                                <%--<option value="9" ${account.id eq "9"?"selected":""} >2026</option>--%>
                            <%--</select>--%>
                        <%--</div>--%>

                    <%--</div>--%>
                    <%--<button onclick="queryBtn()" id="queryBtn2" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>--%>

                <%--</form>--%>


                <button type="button" class="btn btn-danger" onclick="deleteUsers()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/user/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                <br>
                <hr style="clear:both;">
                <div class="table-responsive">
                    <form id="userForm">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" id="allSelBox"></th>
                                <th>真实姓名</th>
                                <th>用户名</th>
                                <th>邮箱</th>
                                <%--<th>身份</th>--%>
                                <th>学院</th>
                                <th>学号</th>
                                <th>年级</th>
                                <th>届数</th>
                                <th>总积分</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>

                            <tbody id="userData">


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
    </div>


</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_1";
    var likeflg = false;
    $(function () {

        // alert("进入分页查询");
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
    // $("tbody .btn-success").click(function(){
    //     window.location.href = "assignRole.html";
    // });
    // $("tbody .btn-primary").click(function(){
    //     window.location.href = "edit.html";
    // });

    // 分页查询
    function pageQuery( pageno ) {
        var loadingIndex = null;

        var jsonData = {"pageno" : pageno, "pagesize" : 20};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }

        $.ajax({
            type : "POST",
            url  : "${cx}/user/pageQuery",
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

                    var userPage = result.data;
                    var users = userPage.datas;

                    $.each(users, function(i, user){
                        tableContent += '<tr>';
                        tableContent += '  <td>'+(i+1)+'</td>';
                        tableContent += '  <td><input type="checkbox"  id="'+ user.realname+'"  name="id" value="'+(i+1)+'" ></td>';
                        tableContent += '  <td>'+user.realname+'</td>';
                        tableContent += '  <td>'+user.username+'</td>';
                        tableContent += '  <td>'+user.email+'</td>';
                        tableContent += '  <td>'+user.department+'</td>';
                        tableContent += '  <td>'+user.sno+'</td>';
                        tableContent += '  <td>'+user.grade+'</td>';
                        tableContent += '  <td>'+user.id+'</td>';
                        tableContent += '  <td>'+user.integral+'</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="goAssignPage(\''+user.realname+'\')"  class="btn btn-success btn-xs"><i  class=" glyphicon glyphicon-check"></i></button>';
                        tableContent += '      <button type="button" onclick="goUpdatePage(\''+user.realname+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '	  <button type="button"  onclick="deleteUser(\''+user.realname+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });

                    if ( pageno > 1 ) {
                        pageContent += '<li><a href="###" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                    }

                    for ( var i = 1; i <= userPage.totalno; i++ ) {
                        if ( i == pageno ) {
                            pageContent += '<li class="active"><a  href="###">'+i+'</a></li>';
                        } else {
                            pageContent += '<li ><a href="###" onclick="pageQuery('+i+')">'+i+'</a></li>';
                        }
                    }

                    if ( pageno < userPage.totalno ) {
                        pageContent += '<li><a href="###" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                    }

                    $("#userData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("用户信息分页查询失败", {time:2000, icon:5, shift:6}, function(){

                    });
                }
            }
        });
    }

    function goUpdatePage(realname) {
        window.location.href = "${cx}/user/edit?id="+realname;
    }

    function goAssignPage(realname) {
        window.location.href = "${cx}/user/assign?id="+realname;
    }


    function deleteUsers() {
        // var boxes = $("#userData :checkbox");  感觉这个有点问题
        var boxes = $("input[name='id']:checked");

        var realname = new Array();
        boxes.each(function(i){
            realname[i] = $(this).attr("id");
            alert(realname[i]);
        });


        if ( boxes.length == 0 ) {
            layer.msg("请选择需要删除的用户信息", {time:2000, icon:5, shift:6}, function(){

            });
        } else {
            layer.confirm("删除选择的用户信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                // 删除选择的用户信息
                $.ajax({
                    type : "POST",
                    processData: false,
                    contentType: "application/json",
                    url  : "${cx}/user/deletes",
                    data : JSON.stringify(realname),
                    dataType: "json",
                    cache: false,
                    success : function(result) {
                        if ( result.success ) {
                            pageQuery(1);
                        } else {
                            layer.msg("用户信息删除失败", {time:2000, icon:5, shift:6}, function(){

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

    function deleteUser( realname ) {
        layer.confirm("删除用户信息【"+realname+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

            // 删除用户信息
            $.ajax({
                type : "POST",
                url  : "${cx}/user/delete",
                data : { realname : realname },
                success : function(result) {
                    if ( result.success ) {
                        pageQuery(1);
                    } else {
                        layer.msg("用户信息删除失败", {time:2000, icon:5, shift:6}, function(){

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
