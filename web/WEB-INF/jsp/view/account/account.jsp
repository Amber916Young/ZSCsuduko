<template:user_backend htmlTitle="社团账目明细" bodyTitle="社团账目明细">

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
                            <select style=""  onchange="queryMA(this)" id="queryText" name="queryText" class="form-control has-success">
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
                            <%--<input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">--%>
                        </div>
                    </div>
                    <button onclick="queryBtn()" id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                </form>
                <button type="button" class="btn btn-danger" onclick="deleteAccounts()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${cx}/account/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
               <br> <br> <br>
                <form class="form-inline" role="form" style="float:left;">
                    <div class="form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">按照届数添加社团金额:</div>
                            <input class="form-control has-success" type="text" placeholder="输入金额(例如：1500)" id="addmoeny"  >
                        </div>
                    </div>
                    <button onclick="GetAddmoeny()"  type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 更改</button>
                </form>
                <br> <br><br>
                    <p>
                        <span>本届的总经费</span>
                        <input type="text" value="${allmoney}" id="allmoney" readonly="readonly" >
                    </p>
                <p>
                    <span>本届的剩余经费</span>
                    <input type="text" value="${balance}" id="money" readonly="readonly" >
                </p>
                <hr style="clear:both;">
                <div class="table-responsive">
                    <form id="roleForm">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"  id="allSelBox"></th>
                                <th>届数</th>
                                <th>活动名称</th>
                                <th>花费金额</th>
                                <th>活动时间</th>
                                <th>剩余金额</th>
                                <th>经费经手人</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>

                            <tbody id="accountData">
                            <tr>
                                <td width="30">1</td>
                                <td width="30"><input type="checkbox" value="1" id=""></td>
                                <td>1</td>
                                <td>第一次社团比赛</td>
                                <td>￥480</td>
                                <td>2019-3-19</td>
                                <td>￥328.1</td>
                                <td>杨叶佳</td>
                                <td width="100">模版不可操作</td>
                            </tr>
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
    var ItemId = "Item1_5";
    var likeflg = false;
    function queryMA(e){
        var id = e.value;
        var jsonData = {"id" : id};
        $.ajax({
            type : "POST",
            url  : "${cx}/account/balance",
            data : jsonData,
            success : function(result) {
                if(result=="fail"){
                    $("#allmoney").val("本届暂时没有收入");
                    $("#money").val("本届暂时没有余额");
                    layer.msg("本届没有收入", {time:2000, icon:5, shift:6}, function(){

                    });
                }else{
                    var arr=new Array();
                    arr= result.split("?");
                    // alert(arr.length);
                    var balance=arr[0];
                    var allmoney=arr[1];
                    $("#allmoney").val(allmoney);
                    $("#money").val(balance);
                }


            }
        });
    }
    $(function () {
        var queryText = $("#queryText").val();
        if(queryText==""||queryText==null){
            queryText=1;
        }
        var jsonData = {"id" : queryText};
        $.ajax({
            type : "POST",
            url  : "${cx}/account/balance",
            data : jsonData,
            success : function(result) {
                var arr=new Array();
                arr= result.split("?");
                // alert(arr.length);
                var balance=arr[0];
                var allmoney=arr[1];
                $("#allmoney").val(allmoney);
                $("#money").val(balance);

            }
        });
        pageQuery(1);
        $("#queryBtn").click(function(){
            var queryText = $("#queryText").val();


            if ( queryText == "" ) {
                likeflg = false;
            } else {
                likeflg = true;
            }
            // alert("queryBtn" +queryText);

            pageQuery(1);
        });

        $("#allSelBox").click(function(){
            var flg = this.checked;
            $("#accountData :checkbox").each(function(){
                this.checked = flg;
            });
        });
    });





    // 分页查询
    function pageQuery( pageno ) {
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 20};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }

        $.ajax({
            type : "POST",
            url  : "${cx}/account/pageQuery",
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

                    var accountPage = result.data;
                    var accounts = accountPage.datas;

                    $.each(accounts, function(i, account){
                        tableContent += '<tr>';
                        tableContent += '  <td>'+(i+1)+'</td>';
                        tableContent += '  <td><input type="checkbox" name="id" value="'+account.id+'"></td>';
                        tableContent += '  <td>'+account.gid+'</td>';
                        tableContent += '  <td>'+account.name+'</td>';
                        tableContent += '  <td>'+account.expenditure+'</td>';
                        tableContent += '  <td>'+account.time+'</td>';
                        tableContent += '  <td>'+account.balance+'</td>';
                        tableContent += '  <td>'+account.pname+'</td>';
                        tableContent += '  <td>';

                        tableContent += '      <button type="button" onclick="ViewDetail('+account.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';

                        tableContent += '      <button type="button" onclick="goUpdatePage('+account.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '	  <button type="button" onclick="goDelete('+account.id+')"  class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });

                    if ( pageno > 1 ) {
                        pageContent += '<li><a href="#" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                    }

                    for ( var i = 1; i <= accountPage.totalno; i++ ) {
                        if ( i == pageno ) {
                            pageContent += '<li class="active"><a  href="#">'+i+'</a></li>';
                        } else {
                            pageContent += '<li ><a href="#" onclick="pageQuery('+i+')">'+i+'</a></li>';
                        }
                    }

                    if ( pageno < accountPage.totalno ) {
                        pageContent += '<li><a href="#" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                    }

                    $("#accountData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("收据信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        });
    }

    function ViewDetail(id) {
        window.location.href = "${cx}/account/view?id="+id;
    }


    function goUpdatePage(id) {
        window.location.href = "${cx}/account/edit?id="+id;
    }


    function goDelete(id) {
        alert("delete");
        layer.confirm("删除账目, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
            $.ajax({
                type : "POST",
                url  : "${cx}/account/delete",
                data : {
                    id : id
                },
                success : function(result) {
                    if ( result.success ) {
                        // 刷新数据
                        window.location.href = "${cx}/account/";

                    } else {
                        layer.msg("信息删除失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });

            layer.close(cindex);
        }, function(cindex){
            layer.close(cindex);
        });
    }

    function GetAddmoeny() {
        var addmoeny = $("#addmoeny").val();
        var selectid =$('#selectid').val();//选中的值

        if(selectid==""||selectid==null){
            selectid=1;
        };
        if(addmoeny==""){
            layer.msg("添加金额不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var jsonData ={};
        var loadingIndex = null;
        jsonData["addmoeny"] = addmoeny;
        jsonData["selectid"] = selectid;
        var json = JSON.stringify(jsonData);

        layer.confirm("当前选择添加的是第"+selectid+"届的经费, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
            layer.close(cindex);

            $.ajax({
                async: false,
                type:"POST",
                url: "${cx}/account/upload", //数据URL路径
                data:json,
                contentType: "application/json",
                // cache: false,
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success:function (result) {
                    if(result=="ok"){
                        layer.msg("添加成功", {time:2000, icon:6, shift:6}, function(){
                        });
                        window.location.href = "${cx}/account/";
                    }else {
                        layer.msg("添加失败", {time:2000, icon:5, shift:6}, function(){
                        });
                    }

                },
                error:function () {
                    layer.msg("Ajax执行失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            })
            layer.close(cindex);
        }, function(cindex){
            layer.close(cindex);
        });

    }

    function GetSelectid(){
        var selectid =$('#selectid').val();//选中的值

        var loadingIndex = null;
        if(selectid==""||selectid==null){
            selectid=1;
        };
        var jsonData ={};
        jsonData["selectid"] = selectid;

        var json = JSON.stringify(jsonData);
        $.ajax({
            async: false,
            type:"POST",
            url: "${cx}/account/find_accountByid", //数据URL路径
            data:json,
            contentType: "application/json",
            // cache: false,
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var accountPage = result.data;
                    var accounts = accountPage.datas;
                    $.each(accounts, function(i, account){
                        tableContent += '<tr>';
                        tableContent += '  <td>'+(i+1)+'</td>';
                        tableContent += '  <td><input type="checkbox" name="id" value="'+account.id+'"></td>';
                        tableContent += '  <td>'+account.gid+'</td>';
                        tableContent += '  <td>'+account.name+'</td>';
                        tableContent += '  <td>'+account.expenditure+'</td>';
                        tableContent += '  <td>'+account.time+'</td>';
                        tableContent += '  <td>'+account.balance+'</td>';
                        tableContent += '  <td>'+account.pname+'</td>';
                        tableContent += '  <td>';
                        tableContent += '      <button type="button" onclick="ViewDetail('+account.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        tableContent += '      <button type="button" onclick="goUpdatePage('+account.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent += '	  <button type="button" onclick="goDelete('+account.id+')"  class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent += '  </td>';
                        tableContent += '</tr>';
                    });

                    if ( pageno > 1 ) {
                        pageContent += '<li><a href="###" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                    }

                    for ( var i = 1; i <= accountPage.totalno; i++ ) {
                        if ( i == pageno ) {
                            pageContent += '<li class="active"><a  href="###">'+i+'</a></li>';
                        } else {
                            pageContent += '<li ><a href="###" onclick="pageQuery('+i+')">'+i+'</a></li>';
                        }
                    }

                    if ( pageno < accountPage.totalno ) {
                        pageContent += '<li><a href="###" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                    }

                    $("#accountData").html(tableContent);
                    $(".pagination").html(pageContent);
                } else {
                    layer.msg("收据信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            },
            error:function () {
                alert("ajax请求失败0 0");
            }
        })
    }





    //TODO bug 获取不到id 待检查
    function deleteAccounts() {
        // var boxes = $("#userData :checkbox");  感觉这个有点问题
        var boxes = $("input[name='id']:checked");

        var id = new Array();
        boxes.each(function(i){
            id[i] = $(this).attr("id");
            alert(id[i]);
        });


        if ( boxes.length == 0 ) {
            layer.msg("请选择需要删除的账目信息", {time:2000, icon:5, shift:6}, function(){

            });
        } else {
            layer.confirm("删除选择的账目信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                // 删除选择的用户信息
                $.ajax({
                    type : "POST",
                    processData: false,
                    contentType: "application/json",
                    url  : "${cx}/account/deletes",
                    data : JSON.stringify(id),
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

    function goDelete( id ) {
        layer.confirm("删除账目id【"+id+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

            // 删除用户信息
            $.ajax({
                type : "POST",
                url  : "${cx}/account/delete",
                data : { id : id },
                success : function(result) {
                    if ( result.success ) {
                        pageQuery(1);
                    } else {
                        layer.msg("账目信息删除失败", {time:2000, icon:5, shift:6}, function(){

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