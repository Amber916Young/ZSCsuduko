<template:index >
    <%--变形数独   此页面没有用--%>
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
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/css/main.css">
    <div class="main" style="margin-left: 2em;margin-right: 2em;background-color: white">
        <div class="panel-body">
            <form class="form-inline" role="form" style="margin-left: 20%">
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
        <div class="" style="position:relative ;height: 1500px" >
            <div class="table-responsive container" >

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

            }
        })
    }
    function ViewDetail(id) {
        window.location.href = "${cx}/view/particles?id="+id;
    }


</script>