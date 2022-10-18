<template:user_backend htmlTitle="每日一练" bodyTitle="每日一练">
    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <style>
        .con {
            border: dotted 1px #53504d;
            border-radius:5px ;
            width: 80%;
            margin-left: 50px;
            margin-right: 50px;
            margin-bottom: 20px;
            background: rgba(241, 241, 241, 1);
        }
    </style>
    <div class="col-md-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>我的题库</h3>
            </div>
            <div class="panel-body">
                <form class="form-inline" role="form" style="float:left;">
                    <%--<div class="form-group has-feedback">--%>
                        <%--<div class="input-group">--%>
                            <%--<div class="input-group-addon">查询内容</div>--%>
                            <%--<input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询关键字">--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </form>
                <%--<button onclick="queryBtn()" id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>--%>

                <br>
            </div>
            <div class="table-responsive">
                <form id="userForm">
                    &nbsp;&nbsp;<strong>总${pageInfo.total}记录数,每页${pageInfo.pageSize}条,共${pageInfo.pages}页.
                        当前第${pageInfo.pageNum}页, 记录范围:${pageInfo.startRow}-${pageInfo.endRow},
                        共${pageInfo.size}条记录
                        </strong>  <br>  <br>
                    <c:forEach var="userscore" items="${pageInfo.list}" varStatus="a">
                        <div class="con" style="float: left">
                            <a href="${cx}/view/suduko?id=${userscore.sudukoid}" style="text-indent:15px;" ><h5><strong>题目id:${userscore.id}</strong></h5></a>
                            &nbsp;&nbsp;<span class="">我的完成日期：${userscore.finishTime}</span>
                            &nbsp;&nbsp;<span class="">我的完成时间：${userscore.totaltime}秒</span>
                        </div>
                    </c:forEach>
                        <div class="col-md-8 text-right">
                        <zsc:page url="${cx}/user/suduko"/>
                        </div>
                </form>
            </div>
        </div>


    </div>
<br>
    <br>
</template:user_backend>


<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item2_4";
    var likeflg = false;
    <%--$(function (){--%>

        <%--pageQuery(1);--%>
        <%--$("#queryBtn").click(function(){--%>
            <%--var queryText =$('#queryText').val();//选中的值--%>
            <%--if ( queryText == "" ) {--%>
                <%--likeflg = false;--%>
            <%--} else {--%>
                <%--likeflg = true;--%>
            <%--}--%>
            <%--pageQuery(1);--%>
        <%--});--%>
        <%--$("#allSelBox").click(function(){--%>
            <%--var flg = this.checked;--%>

            <%--$("#sudukoData :checkbox").each(function(){--%>
                <%--this.checked = flg;--%>
            <%--});--%>
        <%--});--%>

    <%--});--%>


    <%--function pageQuery(pageno) {--%>
        <%--var loadingIndex = null;--%>
        <%--var jsonData = {"pageno" : pageno, "pagesize" : 10};--%>
        <%--if ( likeflg == true ) {--%>
            <%--jsonData.queryText = $("#queryText").val();--%>
        <%--}--%>
        <%--$.ajax({--%>
            <%--async: false,--%>
            <%--type:"POST",--%>
            <%--data : jsonData,--%>
            <%--url: "${cx}/user/suduko/queryAll", //数据URL路径--%>
            <%--beforeSend : function(){--%>
                <%--loadingIndex = layer.msg('处理中', {icon: 16});--%>
            <%--},--%>
            <%--success : function(result) {--%>
                <%--layer.close(loadingIndex);--%>
                <%--if ( result.success ) {--%>
                    <%--// 局部刷新页面数据--%>
                    <%--var tableContent = "";--%>
                    <%--var pageContent = "";--%>
                    <%--var sudukoPage = result.data;--%>
                    <%--var sudukos = sudukoPage.datas;--%>
                    <%--// alert("data 长度"+result.length);--%>
                    <%--$.each(sudukos, function (i, suduko) {--%>
                        <%--tableContent += '<tr>';--%>
                        <%--tableContent += '  <td>' + (i + 1) + '</td>';--%>
                        <%--tableContent += '  <td><input type="checkbox"  id="'+suduko.id+'" name="id" value="' + (i + 1) + '" ></td>';--%>
                        <%--tableContent += '  <td>' + suduko.id + '</td>';--%>
                        <%--tableContent += '  <td>' + suduko.difficulty_level + '</td>';--%>
                        <%--tableContent += '  <td>' + suduko.type + '</td>';--%>
                        <%--tableContent += '  <td>' + suduko.score + '</td>';--%>
                        <%--tableContent += '  <td>' + suduko.time + '</td>';--%>
                        <%--tableContent += '  <td>';--%>
                        <%--tableContent += '      <button type="button" onclick="ViewDetail('+suduko.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';--%>
                        <%--tableContent += '	  <button type="button"  onclick="GoDeletesuduko(' + suduko.id + ')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';--%>
                        <%--tableContent += '  </td>';--%>
                        <%--tableContent += '</tr>';--%>
                    <%--});--%>
                    <%--if (pageno > 1) {--%>
                        <%--pageContent += '<li><a href="" onclick="pageQuery(' + (pageno - 1) + ')">上一页</a></li>';--%>
                    <%--}--%>

                    <%--for (var i = 1; i <= sudukoPage.totalno; i++) {--%>
                        <%--if (i == pageno) {--%>
                            <%--pageContent += '<li class="active"><a  href="#">' + i + '</a></li>';--%>
                        <%--} else {--%>
                            <%--pageContent += '<li ><a href="#" onclick="pageQuery(' + i + ')">' + i + '</a></li>';--%>
                        <%--}--%>
                    <%--}--%>

                    <%--if (pageno < sudukoPage.totalno) {--%>
                        <%--pageContent += '<li><a href="#" onclick="pageQuery(' + (pageno + 1) + ')">下一页</a></li>';--%>
                    <%--}--%>
                    <%--$("#sudukoData").html(tableContent);--%>
                    <%--$(".pagination").html(pageContent);--%>
                <%--}else {--%>
                    <%--layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){--%>
                    <%--});--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>


    function ViewDetail(id) {
        window.location.href = "${cx}/view/suduko?id="+id;
    }



</script>
