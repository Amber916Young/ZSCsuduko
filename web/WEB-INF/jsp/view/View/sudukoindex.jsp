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

        .news{
            display: flex;
            /*height: 2.5em;*/
            padding: 0.5em 0.5em 0;
        }
        .news a{
            color: black;
            font-size: 1em;
        }
        .news a:hover{
            color: #de7c3b;
        }
        .news img{
            height: 8em;
            border: 1px solid darkslategray;
        }
        .news-img{
            align-items: flex-start;
            flex-basis: 35%;
            margin-right: 1em;
            margin-bottom: 3em;
            width: 10em;
        }

        .header-logo img{
            width: 8em;
            height: auto;

            /* max-width:100%; */
        }

        .news-txt{
            flex: 1;
            height: 100%;
        }

        .news-txt p{
            margin-top: 0.15em;
            font-size: 0.75rem;
            text-align: justify;
            text-indent: 2em;
            /* max-height: 112px;
            overflow: hidden; */
        }


    </style>
    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white" >
        <div class="panel-body" style="margin:auto;">
            <div>
                <ol class="breadcrumb" style="border-radius: 0;color: #004957">
                    当前位置：
                    <li class="breadcrumb-item"><a href="${cx}/index/">网站主页</a></li>
                    <li class="breadcrumb-item active" style="color: #000000">数独练习</li>
                </ol>
            </div>
            <div class="panel-body">
                <form class="form-inline" role="form" style="float: right">
                    <div class="form-group has-feedback">
                        <div class="input-group">
                            <div class="input-group-addon">查询内容</div>
                            <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询关键字">
                        </div>
                    </div>
                    <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                </form>
                <br>
            </div>
            <div class="" style="position:relative ;" >
                <div class="table-responsive container" >
                    <form id="userForm">
                        <table class="table  table-bordered" >
                            <thead>
                            <tr style="background-color: rgba(175,221,225,0.47)">
                                <th width="30">#</th>
                                <th width="70">题目编号</th>
                                <th style="color: #004957" width="100">题目难度</th>
                                <th style="color: darkred" width="140">题目类型</th>
                                <th width="100">题目分值</th>
                                <th width="100">出题时间</th>
                                <%--<th width="100">状态</th>--%>
                                <th width="50">查看</th>
                            </tr>
                            </thead>
                            <tbody id="sudukoData">
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



</template:index>
<script type="text/javascript">
    var likeflg = false;
    $(function (){
        pageQuery(1);
        $("#queryBtn").click(function(){
            var queryText =$('#queryText').val();//选中的值
            if ( queryText == "" ) {
                likeflg = false;
            } else {
                likeflg = true;
            }
            pageQuery(1);
        });
    });


    function pageQuery(pageno) {
        // alert("执行22222");
        var loadingIndex = null;
        var jsonData = {"pageno" : pageno, "pagesize" : 20};
        if ( likeflg == true ) {
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/index/suduko/queryAll", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if ( result.success ) {
                    // 局部刷新页面数据
                    var tableContent = "";
                    var pageContent = "";
                    var sudukoPage = result.data;
                    var sudukos = sudukoPage.datas;
                    // alert("data 长度"+result.length);
                    $.each(sudukos, function (i, suduko) {
                        if(suduko.status==1){
                            tableContent += '<tr>';
                            tableContent += '  <td>' + (i + 1) + '</td>';
                            tableContent += '  <td>' + suduko.id + '</td>';
                            tableContent += '  <td>' + suduko.difficulty_level + '</td>';
                            tableContent += '  <td>' + suduko.type + '</td>';
                            tableContent += '  <td>' + suduko.score + '</td>';
                            tableContent += '  <td>' + suduko.time.substring(0,10) + '</td>';
                            // tableContent += '  <td>' + suduko.status + '</td>';
                            tableContent += '  <td>';
                            tableContent += '      <button type="button" onclick="ViewDetail('+suduko.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button>';
                            tableContent += '  </td>';
                            tableContent += '</tr>';
                        }
                    });
                    if (pageno > 1) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno - 1) + ')">上一页</a></li>';
                    }

                    for (var i = 1; i <= sudukoPage.totalno; i++) {
                        if (i == pageno) {
                            pageContent += '<li class="active"><a  href="javascript:void(0)">' + i + '</a></li>';
                        } else {
                            pageContent += '<li ><a href="javascript:void(0)" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }

                    if (pageno < sudukoPage.totalno) {
                        pageContent += '<li><a href="javascript:void(0)" onclick="pageQuery(' + (pageno + 1) + ')">下一页</a></li>';
                    }
                    $("#sudukoData").html(tableContent);
                    $(".pagination").html(pageContent);
                }else {
                    layer.msg("信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        })
    }
    function ViewDetail(id) {
        window.location.href = "${cx}/view/suduko?id="+id;
    }


</script>