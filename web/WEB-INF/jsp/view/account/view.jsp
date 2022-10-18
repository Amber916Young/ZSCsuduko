<template:user_backend htmlTitle="会干信息维护" bodyTitle="会干信息维护">

    <div class="col-md-8 " style="margin-left: 30px">
        <ol class="breadcrumb">
            <li><a href="${cx}/account/">首页</a></li>
            <li><a href="###">数据列表</a></li>
            <li class="active">查看明细</li>
        </ol>
        <div class="panel panel-default">
            <div class="panel-heading">账目基本信息<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
            <div class="panel-body">
                <form role="form">
                    <div class="form-group">
                        <label >编号id</label>
                        <input type="text" value="${account.id}" class="form-control" id="id" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label >届数</label>
                        <input type="text" value="${account.gid}" class="form-control" id="gid" readonly="readonly" placeholder="第几届会干">
                    </div>
                    <div class="form-group">
                        <label >活动名称</label>
                        <input type="text" value="${account.name}" class="form-control" id="name" readonly="readonly" placeholder="活动名称">
                    </div>
                    <div class="form-group">
                        <label >活动明细</label><br>
                        <textarea id="detail" cols="30" rows="10" readonly="readonly">${account.detail}
                        </textarea>
                    </div>
                    <div class="form-group">
                        <label >活动花费</label>
                        <input type="text" value="${account.expenditure}" class="form-control" readonly="readonly" id="expenditure" placeholder="活动花费">
                    </div>
                    <div class="form-group">
                        <label >活动时间</label>
                        <input type="text" value="${account.time}" class="form-control" id="time" readonly="readonly" placeholder="活动时间">
                    </div>
                    <div class="form-group">
                        <label >剩余金额</label>
                        <input type="text" value="${account.balance}" class="form-control" id="balance" readonly="readonly" placeholder="剩余金额">
                    </div>
                    <div class="form-group">
                        <label >经手人</label>
                        <input type="text" value="${account.pname}" class="form-control" id="pname" readonly="readonly" placeholder="经手人姓名（一般为秘书长）">
                    </div>


                </form>
                    <%--<button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>--%>
                    <%--<button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>--%>
                </form>
            </div>
        </div>
    </div>

</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_5";
    $(function () {

        $.ajax({




        })

    });
</script>
