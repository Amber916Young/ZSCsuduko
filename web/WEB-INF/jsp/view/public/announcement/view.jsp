<template:user_backend htmlTitle="发表公告" bodyTitle="发表公告">
        <div class=" col-md-8 " style="margin-left: 30px">
            <ol class="breadcrumb">
                <li><a href="${cx}/public/announcement">首页</a></li>
                <li><a href="">数据列表</a></li>
                <li class="active">正在进行替换，替换位置为首页公告栏</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">公告信息内容如下<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${announcement.status == 1}">
                            <b style="color: #1abc9c;font-size: 16px"> 已经发布</b>
                        </c:when>
                        <c:otherwise>
                            <b style="color: #bc3929;font-size: 16px"> 暂时未发布</b>
                        </c:otherwise>
                    </c:choose>

                    <hr>
                    <form role="form">
                        <div class="form-group">
                            <label >编号id</label>
                            <input style="width: 300px"  type="text" value="${announcement.id}" class="form-control" id="id" readonly="readonly">
                        </div>
                        <div class="form-group">
                            <label >届数</label>
                            <input style="width: 300px"  type="text"  value="${announcement.gid}"class="form-control" id="gid" >
                        </div>
                        <div class="form-group">
                            <label>公告内容</label><br>
                                <textarea readonly="readonly" id="detail"   value="${announcement.content}" style="resize:none"  cols="80" rows="5">${announcement.content}</textarea>

                        </div>
                        <div class="form-group">
                            <label >发布者</label>
                            <input style="width: 300px" type="text" value="${announcement.realname}" class="form-control" id="realname" placeholder="请输入真实姓名">
                        </div>
                        <c:if test="${announcement.status == 0}">
                            <div class="form-group">
                                <b style="margin-left: 20px">检查改位置之前是否有公告，不然重合会替换</b>
                                <label >发布公告栏位置 1 or 2 or 3？？</label>
                                <select id="selectid">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                                <input type="button" value="检查" onclick="CheckNoticeBynid()">检查</input>
                            </div>
                        </c:if>
                    </form>
                    <c:if test="${announcement.status == 0}">
                        <button id="insertBtn" onclick="UPTONOTICE()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 正式发布</button>
                    </c:if>

                    <%--<button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>--%>
                </div>
            </div>
        </div>





</template:user_backend>



<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item3_3";
    function CheckNoticeBynid(){

        var selectid = $("#selectid").val();
        // alert("selectid   "+selectid);
        $.ajax({
            type : "POST",
            // processData: true,
            // contentType: "application/json",
            //告诉服务器，我要发什么类型的数据
            url  : "${cx}/public/announcement/CheckNoticeBynselectid",
            data : {"selectid":selectid},
            // dataType: "json",
            //告诉服务器，我要想什么类型的数据，如果没有指定，那么会自动推断是返回 XML，还是JSON，还是script，还是String
            cache: false,
            success : function(result) {
                if ( result.success ) {
                    layer.confirm("是否替换原来位置的公告, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                        layer.close(cindex);
                    }, function(cindex){
                        layer.close(cindex);
                    });

                } else {
                    layer.msg("此位置暂时没有公告，请继续", {time:3000, icon:6, shift:6}, function(){

                    });
                }
            },
            error:function () {
                layer.msg("ajax请求失败", {time:2000, icon:5, shift:6}, function(){

                });
            }

        })
    }
    $(function () {



    });

    function UPTONOTICE() {
        // var selectid = $("#selectid").val();
        var selectid = $("#selectid").val();

        var id = $("#id").val();
        alert(id);
        $.ajax({
            type : "POST",
            url  : "${cx}/public/announcement/upload",
            data : { "id" : id ,"selectid":selectid},
            cache: false,
            success : function(result) {
                if ( result.success ) {
                    layer.msg("公告信息发布成功", {time:2000, icon:6, shift:6}, function(){
                        window.location.href = "${cx}/public/announcement";
                    });
                } else {
                    layer.msg("公告信息发布失败", {time:2000, icon:5, shift:6}, function(){

                    });
                }
            }
        })
    }

</script>