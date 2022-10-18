<template:user_backend htmlTitle="社团账目明细" bodyTitle="社团账目明细">

    <div class="col-md-8 " style="margin-left: 30px">
        <ol class="breadcrumb">
            <li><a href="${cx}/account/">首页</a></li>
            <li><a href="">数据列表</a></li>
            <li class="active">新增</li>
        </ol>
        <div class="panel panel-default">
            <div class="panel-heading">用户基本信息<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
            <div class="panel-body">
                <form role="form">
                    <div class="form-group">
                        <label >编号id</label>
                        <input type="text"  placeholder="不需要填写，后台自动生成" class="form-control" id="id" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label >届数</label>
                        <input type="text" class="form-control" id="gid" placeholder="第几届会干">
                    </div>
                    <div class="form-group">
                        <label >活动名称</label>
                        <input type="text"class="form-control" id="name" placeholder="活动名称">
                    </div>
                    <div class="form-group">
                        <label >活动明细
                        <textarea style="resize:none"  id="detail" cols="80" rows="5"></textarea>
                        </label>
                    </div>
                    <div class="form-group">
                        <label >活动花费</label>
                        <input type="text"  class="form-control" id="expenditure" placeholder="活动花费">
                    </div>
                    <div class="form-group">
                        <label >活动时间</label>
                        <input type="text" class="form-control" id="time" placeholder="活动时间 格式：2019-03-21">
                    </div>
                    <div class="form-group">
                        <label >剩余金额</label>
                        <input type="text" value="" class="form-control" id="balance" placeholder="不需要填写，后台自动生成"  readonly="readonly">
                        <input type="button " class="btn btn-default "  onclick="checkBalance()" value="计算余额" >
                    </div>

                    <div class="form-group">
                        <label >经手人姓名</label>
                        <input type="text" class="form-control" id="pname" placeholder="经手人姓名（一般为秘书长）">
                    </div>
                </form>
                    <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                </form>
            </div>
        </div>
    </div>

</template:user_backend>

<script type="text/javascript">
    //设置页面对应的菜单选项
    var ItemId = "Item1_5";
    //产生随机数id
    function createRandom2(from, to) {
        var arr;
        var json = {};
        //产生单个随机数
        var ranNum = Math.ceil(Math.random() * (to - from)) + from;
        //通过判断json对象的索引值是否存在 来标记 是否重复
        if (!json[ranNum]) {
            json[ranNum] = 1;
            arr = ranNum;
        }
        return arr;
    }


    function checkBalance(){
        // var balance = $("#balance").val();
        var gid = $("#gid").val();
        var expenditure=$("#expenditure").val();
        if ( gid == "" ) {
            layer.msg("届数不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if ( expenditure == "" ) {
            layer.msg("活动花费不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

            });
            return;
        }
        var data = {};
        data["gid"]=gid;
        data["expenditure"]=expenditure;
        var json = JSON.stringify(data);
        $.ajax({
            async: false,
            type : "POST",
            url  : "${cx}/account/checkBalance",
            data : json,
            contentType: 'application/json',
            success:function (result) {
                if(result!=0){
                    layer.msg("剩余余额 ￥"+result+"，请继续填写其他信息", {time:3000, icon:6}, function(){

                        $("#balance").attr("value",result);
                    });
                }
            },
            error:function () {
                alert("ajax 请求失败")
            }
        })
    }


    $(function () {
        var id = createRandom2(100, 1000000);//产生100-1000000的随机数
        $("#id").attr("value",id)

        $("#resetBtn").click(function(){
            // Jquery[0] ==> DOM
            // $(DOM) ==> Jquery
            $("#userForm")[0].reset();
        });

        $("#updateBtn").click(function() {
            var name = $("#name").val();
            var gid = $("#gid").val();
            var detail = $("#detail").val();
            var expenditure=$("#expenditure").val();
            var time = $("#time").val();
            var balance = $("#balance").val();
            var pname = $("#pname").val();
            var id = $("#id").val();

            alert(detail);
            if ( pname == "" ) {
                layer.msg("经手人不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            if ( time == "" ) {
                layer.msg("活动时间不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( expenditure == "" ) {
                layer.msg("活动花费不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( detail == "" ) {
                layer.msg("活动明细不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( gid == "" ) {
                layer.msg("届数不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }
            if ( name == "" ) {
                layer.msg("活动名称不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }


            var loadingIndex = null;

            var data = {};
            data["name"]=name;
            data["gid"] = gid;
            data["detail"] = detail;
            data["id"] = id;
            data["expenditure"] = expenditure;
            data["time"] = time;
            data["balance"] = balance;
            data["pname"]=pname;

            var json = JSON.stringify(data);
            $.ajax({
                async: false,
                type : "POST",
                url  : "${cx}/account/insert",
                data : json,
                contentType: 'application/json',
                beforeSend : function() {
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if ( result.success ) {
                        layer.msg("新账目表添加成功", {time:2000, icon:6}, function(){
                            window.location.href = "${cx}/account/";
                        });
                    } else {
                        layer.msg("新账目表添加失败，请重新操作", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                },
                error:function () {
                    alert("ajax失败  ");
                }
            });

        });


    });
</script>
