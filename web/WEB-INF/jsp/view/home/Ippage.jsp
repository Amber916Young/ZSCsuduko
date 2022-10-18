<template:user_backend htmlTitle="登陆地点" bodyTitle="登陆地点">
    <div class="col-md-11">
        <div class="container-fluid " style="margin-left: 10px">
            <!-- 这里放置页面内容-->
            <!--TODO 表单 ajax技术 -->
            <div class="main_title"><h3 class="fa fa-user"><b> 登陆地点</b></h3></div>
            <div class="form-control-static">
                <p><h4>当前ip</h4></p>
                <p>${ip}</p>
                <hr>
                <p><h4>当前位置</h4></p>
                <p>${ipaddress}</p>
            </div>

        </div>
    </div>
</template:user_backend>
<script>
    //设置页面对应的菜单选项
    var ItemId = "Item2_3";
</script>