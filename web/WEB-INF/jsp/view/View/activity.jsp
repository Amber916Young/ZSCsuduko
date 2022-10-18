<template:index >
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/css/main.css">
    <style>
        body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td { margin:0; padding:0; }
        body, button, input, select, textarea { font:12px/1.5tahoma, arial, \5b8b\4f53; }
        body{    color: #000;}
        h1, h2, h3, h4, h5, h6{ font-size:100%; }
        address, cite, dfn, em, var { font-style:normal; }
        code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
        small{ font-size:12px; }
        ul, ol { list-style:none; }
        a { text-decoration:none;
            font: normal 600 14px / 22px "å®‹ä½“",Helvetica,Arial,Verdana,sans-serif;color: #333333;}
        a:hover { color: #da3a21;}
        .underline{
            background-color: #da3a21;
            position: absolute;
            display: block;
            overflow: hidden;
            left: 50%;
            bottom: -5px;
            width: 0;
            height: 1px;
            opacity: 0;
            -webkit-transition: all 0.6s cubic-bezier(0.215,0.61,0.355,1) 0s;
            transition: all 0.6s cubic-bezier(0.215,0.61,0.355,1) 0s;}
        sup { vertical-align:text-top; }
        sub{ vertical-align:text-bottom; }
        legend { color:#000; }
        fieldset, img { border:0; }
        button, input, select, textarea { font-size:100%; }
        table { border-collapse:collapse; border-spacing:0; }
        .navbar-nav>li>a {
            padding-top: 0;
            padding-bottom: 0;
            /*line-height:0*/
        }

        .header-nav li{
            display: inline;
            box-sizing: border-box;
            padding: 0.5em;
        }

        .main{
            display: flex;
            margin-top: 0.2em;
        }

        .main-left{
            flex:1;
            margin-left: 2em;

            background-color: white;
        }

        .main-right{
            flex-basis: 33.33%;
            background-color: #white;
            margin-right: 2em;
        }



        .header-logo img{
            width: 8em;
            height: auto;

            /* max-width:100%; */
        }

        temp a{
            color: #004957;
        }
        temp a:hover{
            text-decoration:underline;
            color: #ff7932;
        }
        footer a{
            color: white;
        }
    </style>
    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">
        <div class="panel-body">
            <ol class="breadcrumb" style=";border-radius: 0;color: #004957">
                当前位置：
                <li class="breadcrumb-item"><a href="${cx}/index/">网站主页</a></li>
                <li class="breadcrumb-item active" >活动首页</li>
            </ol>
            <div class="table-responsive container" style="margin-top: 5em">
            <form id="userForm">
                <table class="table  table-bordered" >
                    <thead>
                    <tr >
                        <th width="60">序号</th>
                        <th>活动标题</th>
                        <th>活动内容</th>
                        <th>发布时间</th>
                    </tr>
                    </thead>
                    <tbody id="activityData">
                    </tbody>
                    <tfoot >
                    <tr >
                        <td colspan="6" align="center">
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





</template:index>
<script type="text/javascript">

    // var likeflg = false;

    function richTest(content){
        // 去除 富文本格式
        var data =content;
        data = data.replace(/(\n)/g, "");
        data = data.replace(/(\t)/g, "");
        data = data.replace(/(\r)/g, "");
        data = data.replace(/<\/?[^>]*>/g, "");
        data = data.replace(/\s*/g, "");
        return data;
    }
    function pageQuery(pageno) {
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 20};
        // if ( likeflg == true ) {
        //     jsonData.queryText = $("#queryText").val();
        // }
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/view/activity/queryAll", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var activityPage = result.data;
                    var activitys = activityPage.datas;
                    // alert("data 长度"+result.length);
                    $.each(activitys, function (i, activity) {
                        var content = activity.content;
                        var contentlen = content.length;
                        // alert("contentlen=="+contentlen);
                        var text = richTest(content);
                        if (text.length > 30) {
                            text = text.substr(0, 30);
                            text += ".......";
                        }
                        tableContent += '<tr>';
                        tableContent += '  <td>' + (i + 1) + '</td>';
                        tableContent += '  <td><a href="${cx}/view/activity?id='+activity.id+'"> '+ activity.title + '</a></td>';
                        tableContent += '  <td>' + text + '</td>';
                        tableContent += '  <td>' + activity.time + '</td>';
                        tableContent += '</tr>';
                    });
                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno - 1) + ')">上一页</a></li>';
                    }

                    for (var i = 1; i <= activityPage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < activityPage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno + 1) + ')">下一页</a></li>';
                    }
                    $("#activityData").html(tableContent);
                    $(".pagination").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
    }

    $(function (){
        pageQuery(1);
        $("#queryBtn").click(function(){
            var queryText =$('#queryText').val();//选中的值
            if ( queryText == "" ) {
                likeflg = false;
            } else {
                likeflg = true;
            }
            pageQuery(queryText);
        });
    });


</script>