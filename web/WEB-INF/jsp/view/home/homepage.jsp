<template:user_backend htmlTitle="个人信息" bodyTitle="个人信息">

    <style>
        .gap input,select,textarea{
            height: 35px;
            font-family: "Adobe 仿宋 Std R", sans-serif;
        }
        .gap{
            margin-left: 40px;
        }

    </style>
    <div class="col-md-11">
        <div class="container-fluid " style="margin-left: 10px">
            <!-- 这里放置页面内容-->
            <!--TODO 表单 ajax技术 -->
            <div class="main_title"><h3 class="fa fa-user"><b> 个人资料</b></h3></div>
            <div class="form-control-static">
                <p><h4>基本信息</h4></p>
                <hr>
                <div class="panel panel-default">
                    <form   id="userForm" enctype="multipart/form-data" method="post" action="${cx}/home/update" onsubmit="return checkFile()">
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">头像:</div>
                                <img style="border: 1px solid black" width="200px" src="${head_portrait.fileUrl}"/>
                                <%--判断是否存在头像更改，不存在就不替换。--%>
                                <input type="hidden"  name="image_file" id="image_file" value="exist">
                            </div>
                            <input  id="file-select"  type="file" name="file"  accept="image/*"  multiple onchange="uploadChange()"/>
                        </div>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">真实姓名：</div>
                                <input class=" has-success" type="text" id="realname" name="realname"  value="${user.realname}" readonly="readonly">
                                <span class="alert-danger">不可更改</span>
                            </div>
                        </div>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">用户名：</div>
                                <input type="text"  onblur="CheckUsername(this)" id="username" name="username"  value="${user.username}" >
                            </div>
                        </div>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">电子邮箱：</div>
                                <input type="text" id="hiddenEmail" onblur="CheckEmail(this)" name="email"  value="${user.email}" placeholder="请输入电子邮箱">
                            </div>
                        </div>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">联系方式：</div>
                                <input type="text" id="tel" onblur="CheckTel(this)" name="tel" value="${user.tel}"   placeholder="请输入电话号码">
                            </div>
                        </div>
                        <p id="info" style="color: darkred;margin-left: 60px;"></p>

                        <div class="gap form-group has-feedback" >
                            <div class="input-group">
                                <div class="input-group-addon">性别：</div>
                                <div style="border: 1px solid #ccc;width: 100px">
                                    &nbsp;&nbsp;
                                    <input value="男" onchange="Gender(this)" <c:if test="${user.gender=='男' }">checked="checked"</c:if> type="radio" name="sex" > 男
                                    &nbsp;&nbsp;
                                    <input value="女" onchange="Gender(this)" <c:if test="${user.gender=='女' }">checked="checked"</c:if> type="radio" name="sex" > 女
                                </div>
                                <input type="hidden" value="" name="gender" id="gender">
                            </div>
                        </div>
                        <p  style="color: darkred;margin-left: 60px;"><b>为方便会员申请素拓，以下信息请如实核对</b></p>
                        <p  style="color: darkred;margin-left: 60px;"><b>如果信息有错请联系会干</b></p>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">学院（系）：</div>
                                <select id="department" name="department"  >
                                    <option value="经贸学院" ${user.department eq "经贸学院" ? "selected":""} >经贸学院</option>
                                    <option value="计算机学院" ${user.department eq "计算机学院" ? "selected":""} >计算机学院</option>
                                    <option value="电子信息学院" ${user.department eq "电子信息学院"?"selected":""} >电子信息学院</option>
                                    <option value="机电工程学院" ${user.department eq "机电工程学院"?"selected":""} >机电工程学院</option>
                                    <option value="管理学院" ${user.department eq "管理学院"?"selected":""} >管理学院</option>
                                    <option value="人文社会科学院" ${user.department eq "人文社会科学院"?"selected":""} >人文社会科学院</option>
                                    <option value="外国语学院" ${user.department eq "外国语学院"?"selected":""} >外国语学院</option>
                                    <option value="材料与食品学院" ${user.department eq "材料与食品学院"?"selected":""} >材料与食品学院</option>
                                    <option value="艺术设计学院" ${user.department eq "艺术设计学院"?"selected":""} >艺术设计学院</option>


                                </select>
                            </div>
                        </div>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">学号：</div>
                                <input readonly="readonly" type="text" id="sno" name="sno"  value="${user.sno}" placeholder="例如：2017030208047" >
                            </div>
                        </div>
                        <div class="gap form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">专业：</div>
                                <input type="text" id="major" name="major"  value="${user.major}"  readonly="readonly">
                                <span class="alert-danger">格式16xxx</span>
                            </div>
                        </div>
                        <b style="margin-left: 60px">字数限制在40个字符内</b>
                        <div class="gap form-group has-feedback" >
                            <div class="input-group">
                                <div class="input-group-addon">个性签名：</div>
                                <textarea class="input-group-addon" onkeyup="check()" maxlength="40" id="sign" style="line-height: 2;padding:0;resize:none;width: 60%;background-color: #ffffff" draggable="false" name="sign" cols="40" rows="4" placeholder="请输入您的签名" >${user.sign}</textarea>
                            </div>
                        </div>
                        <div class="gap form-group has-feedback" style="margin-bottom: 20px">
                            <%--<input id="submit" onclick="SSSubmit()" style="margin-left:40px" class="btn btn-primary"--%>
                                   <%--type="button" name="submit" value="提交">--%>
                                <input  class="btn btn-primary" id="submit" type="submit" value="提交"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template:user_backend>
<script>
    //设置页面对应的菜单选项
    var ItemId = "Item2_1";

    function check() {
        var regC = /[^ -~]+/g;
        var regE = /\D+/g;
        var str = sign.value;

        if (regC.test(str)){
            sign.value = sign.value.substr(0,40);
        }

        if(regE.test(str)){
            sign.value = sign.value.substr(0,50);
        }
    }
    function Gender(e){
        //性别获取
        var sex = e.value;
        // alert(sex);
        var gender =$("#gender");
        gender.attr("value",sex);

    }

    function CheckEmail(e) {
        var mail = e.value.trim();
        if (mail != '') {//判断
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            if (!reg.test(mail)) {
                layer.msg("邮箱格式不正确，请重新输入", {time:2000, icon:5, shift:6}, function(){

                });
                $("#submit").attr('disabled', true);
                return;
            }else {
                $("#submit").attr('disabled', false);
            }
        }
    }
    function CheckTel(e) {
        var tel = e.value.trim();
        // alert(tel);
        if (tel != '' || tel!=null) { //判断
            var isMobile=/^(?:13\d|15\d)\d{5}(\d{3}|\*{3})$/;
            var isPhone=/^((0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;
            if (!isMobile.test(tel)&& !isPhone.test(tel)) {
                $("#info").text("请正确填写电话号码，例如:13415764179或0321-4816048");
                layer.msg("电话号码格式不正确，请重新输入", {time: 2000, icon: 5, shift: 6}, function () {

                });
                $("#submit").attr('disabled', true);
                return;
            } else {
                $("#info").text("");

                $("#submit").attr('disabled', false);
            }
        }
    }


    function CheckUsername(e){
        var username = e.value.trim();
        var realname = $("#realname").val().trim();
        var data = {};
        data["username"]=username;
        data["realname"]=realname;
        // alert(username);
        var loadingIndex=null;
        var json = JSON.stringify(data);
        if (username == ""||username==null){
            layer.msg("用户名不能为空，请重新输入", {time:2000, icon:5, shift:6}, function(){
            });
            $("#submit").attr('disabled',true);
            return;
        }else{
            $("#submit").attr('disabled',false);
        }


        $.ajax({
            async: true,
            type : "POST",
            url  : "${cx}/home/checkusername",
            data : json,
            contentType: 'application/json',
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    layer.msg("用户名没有重名", {time:1000, icon:6}, function(){
                    });
                } else {
                    $(" #username").val(" ");
                    layer.msg("用户名有重名，请重新输入", {time:2000, icon:5, shift:6}, function(){

                    });



                }
            },
            error:function () {
                layer.msg("检查重名失败，请检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });

    }
    $(document).ready(function () {


        <!-- 文件上传组件属性设置 -->
        $('#file-select').fileinput({
            language: 'zh', //中文
            <%--uploadUrl: '${cx}/home/uploadAttachement', //上传路径--%>
            // 'elErrorContainer': '#errorBlock',
            // showUpload: false, //是否显示上传文本框里的上传按钮
            // showRemove: false, //是否显示上传文本框里的移除按钮
            // dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
            maxFileCount: 1, //表示允许同时上传的最大文件个数
            enctype: 'multipart/form-data',
            allowedFileTypes: ['image'],//配置允许文件上传的类型
            allowedPreviewTypes: ['image'],//配置所有的被预览文件类型
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif']//控制被预览的所有mime类型
        });
        //性别获取
        var sex = $("input[name='sex' ]").val();
        // alert(sex);
        var gender =$("#gender");
        gender.attr("value",sex);


        // var option = {
        //     enableHighAccuracy:true, //设置提升定位的精准度
        //     maximumAge:0,  //禁用缓存
        //     timeout:30000  //开始获取定位信息30秒后超时
        // }
        // if(navigator.geolocation){  //判断是否支持Geolocation API
        //     navigator.geolocation.getCurrentPosition(showPosition,showError,option)
        // }


    });
    // function showPosition(position){
    //     var lat = position.coords.latitude;  //获取纬度
    //     var lon = position.coords.longitude;  //获取经度
    //     alert("您的纬度是:"+lat+ "，经度是："+lon);
    // }
    // function showError(error){
    //     switch(error.code){
    //         case error.PERMISSION_DENIED:
    //             alert("您拒绝了地理定位服务");
    //             break;
    //         case error.POSITION_UNAVAILABLE:
    //             alert("无法获取您的位置");
    //             break;
    //         case error.TIMEOUT:
    //             alert("超时");
    //             break;
    //     }
    // }
    function uploadChange() {
        $("input[name='file']").each(function(){
            if($(this).val()!="") {
                //存在新图片
                console.info("1"+$(this).val());
            }
            console.info("2"+$(this).val());
        });

    }
    function checkFile() {
        var fileFlag = false;
        $("input[name='file']").each(function(){
            if($(this).val()!="") {
                // alert("3"+$(this).val())
                console.info("3"+$(this).val());
                //存在新图片
                fileFlag = true;
                return true;
            }else{
                fileFlag = false;
                // alert("4"+$(this).val())
                $("#image_file").val("noexist");
                // alert($("#image_file").val());
                console.info("4"+$(this).val());
                return false;
            }

        });
        return ;
    }

</script>