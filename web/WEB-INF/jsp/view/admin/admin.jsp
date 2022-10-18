<template:user_backend htmlTitle="会干信息维护" bodyTitle="会干信息维护">

    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
            </div>
            <div class="panel-body">
                <form class="form-inline" role="form" style="float:left;">
                    <div class="form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">按照届数查询:</div>
                            <select style=" "  id="queryText" name="queryText" class="form-control has-success">
                                <option value="1" ${account.id eq "1" ? "selected":""} >2018</option>
                                <option value="2" ${account.id eq "2" ? "selected":""} >2019</option>
                                <option value="3" ${account.id eq "3"?"selected":""} >2020</option>
                                <option value="4" ${account.id eq "4"?"selected":""} >2021</option>
                                <option value="5" ${account.id eq "5"?"selected":""} >2022</option>
                                <option value="6" ${account.id eq "6" ? "selected":""} >2023</option>
                                <option value="7" ${account.id eq "7"?"selected":""} >2024</option>
                                <option value="8" ${account.id eq "8"?"selected":""} >2025</option>
                                <option value="9" ${account.id eq "9"?"selected":""} >2026</option>
                            </select>
                        </div>

                    </div>
                    <button onclick="queryBtn()" id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>

                </form>
                <button type="button" class="btn btn-danger" onclick="deleteUsers()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <%--<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/admin/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>--%>
                <br>
                <hr style="clear:both;">
                <br>
                <div class="table-responsive">
                    <form id="userForm">
                        <table class="table  table-bordered" >
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" id="allSelBox"></th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>年级</th>
                                <th>学院</th>
                                <th>学号</th>
                                <th>专业</th>
                                <th>职位</th>
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
    var ItemId = "Item1_4";
    var likeflg = false;
    function pageQuery() {
        var sid =$('#queryText').val();//选中的值

        var loadingIndex = null;
        if(sid==""||sid==null){
            sid=1;
        };
        var jsonData ={};
        jsonData["sid"] = sid;
        var json = JSON.stringify(jsonData);
        var tableContent = "";
        $.ajax({
            async: false,
            type:"POST",
            url: "${cx}/clubinformation/find_basicinformation", //数据URL路径
            data:json,
            contentType: "application/json",
            // cache: false,
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                // alert("data 长度"+result.length);
                for (var i = 0; i < result.length; i++) {
                    var id = result[i].id;
                    var realname = result[i].realname;
                    var gender = result[i].gender;
                    var department = result[i].department;
                    var major = result[i].major;
                    var position = result[i].position;
                    var grade = result[i].grade;
                    var sid = result[i].sid;
                    var sno = result[i].sno;
                    tableContent += '<tr>';
                    tableContent += '  <td>'+(i+1)+'</td>';
                    tableContent += '  <td><input type="checkbox"  id="'+realname+'"  name="id" value="'+(i+1)+'" ></td>';
                    tableContent += '  <td>'+realname+'</td>';
                    tableContent += '  <td>'+gender+'</td>';
                    tableContent += '  <td>'+"20"+grade+'</td>';
                    tableContent += '  <td>'+department+'</td>';
                    tableContent += '  <td>'+sno+'</td>';
                    tableContent += '  <td>'+major+'</td>';
                    tableContent += '  <td>'+position+'</td>';
                    tableContent += '  <td>';
                    // tableContent += '      <button type="button" onclick="goAssignPage(\''+realname+'\')"  class="btn btn-success btn-xs"><i  class=" glyphicon glyphicon-check"></i></button>';
                    tableContent += '      <button type="button" onclick="goUpdatePage(\''+realname+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                    tableContent += '	  <button type="button"  onclick="deleteUser(\''+realname+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                    tableContent += '  </td>';
                    tableContent += '</tr>';
                }
                $("#userData").html(tableContent);
            },
            error:function () {
                alert("ajax请求失败0 0");
            }
        })
    }

    $(function (){

        $("#queryBtn").click(function(){
            var sid =$('#queryText').val();//选中的值
            if ( sid == "" ) {
                likeflg = false;
            } else {
                likeflg = true;
            }
            pageQuery();
        });

        $("#allSelBox").click(function(){
            var flg = this.checked;

            $("#userData :checkbox").each(function(){
                this.checked = flg;
            });
        });
        var sid =$('#queryText').val();//选中的值
        var loadingIndex = null;
        if(sid==""||sid==null){
            sid=1;
        };
        var jsonData ={};
        jsonData["sid"] = sid;
        var json = JSON.stringify(jsonData);
        var tableContent = "";
        $.ajax({
            async: false,
            type:"POST",
            url: "${cx}/clubinformation/find_basicinformation", //数据URL路径
            data:json,
            contentType: "application/json",
            // cache: false,
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                // alert("data 长度"+result.length);
                for (var i = 0; i < result.length; i++) {
                    var id = result[i].id;
                    var realname = result[i].realname;
                    var gender = result[i].gender;
                    var department = result[i].department;
                    var major = result[i].major;
                    var position = result[i].position;
                    var grade = result[i].grade;
                    var sid = result[i].sid;
                    var sno = result[i].sno;
                    tableContent += '<tr>';
                    tableContent += '  <td>'+(i+1)+'</td>';
                    tableContent += '  <td><input type="checkbox"  id="'+realname+'"  name="id" value="'+(i+1)+'" ></td>';
                    tableContent += '  <td>'+realname+'</td>';
                    tableContent += '  <td>'+gender+'</td>';
                    tableContent += '  <td>'+"20"+grade+'</td>';
                    tableContent += '  <td>'+department+'</td>';
                    tableContent += '  <td>'+sno+'</td>';
                    tableContent += '  <td>'+major+'</td>';
                    tableContent += '  <td>'+position+'</td>';
                    tableContent += '  <td>';
                    // tableContent += '      <button type="button" onclick="goAssignPage(\''+realname+'\')"  class="btn btn-success btn-xs"><i  class=" glyphicon glyphicon-check"></i></button>';
                    tableContent += '      <button type="button" onclick="goUpdatePage(\''+realname+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                    tableContent += '	  <button type="button"  onclick="deleteUser(\''+realname+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                    tableContent += '  </td>';
                    tableContent += '</tr>';
                }
                $("#userData").html(tableContent);
            },
            error:function () {
                alert("ajax请求失败= =");
            }
        })
    });

    function goUpdatePage(realname) {
        window.location.href = "${cx}/admin/edit?id="+realname;
    }

    function goAssignPage(realname) {
        window.location.href = "${cx}/admin/assign?id="+realname;
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
                    url  : "${cx}/admin/deletes",
                    data : JSON.stringify(realname),
                    dataType: "json",
                    cache: false,
                    success : function(result) {
                        if ( result.success ) {
                            pageQuery();
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
                url  : "${cx}/admin/delete",
                data : { realname : realname },
                success : function(result) {
                    if ( result.success ) {
                        pageQuery();
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
