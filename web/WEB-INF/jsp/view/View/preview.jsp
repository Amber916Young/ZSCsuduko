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


        .header-logo img{
            width: 8em;
            height: auto;

            /* max-width:100%; */
        }



        .news-txt p{
            margin-top: 0.15em;
            font-size: 0.75rem;
            text-align: justify;
            text-indent: 2em;
            /* max-height: 112px;
            overflow: hidden; */
        }
        .one {
            padding: 20px;
            margin-top: 20px;
            margin-bottom: 20px;
            background-color: white;
            border-radius: 5px;
            /*height: 2900px;*/
            word-break: break-all;white-space: normal;overflow:auto;
        }
    </style>


    <section class="container" style="background: rgba(0,0,0,0.05);margin-top: 80px;margin-bottom: 80px">
        <b style="text-align: center;color: darkred ; font-size: 20px">此为链接预览，非正式发送内容</b>
        <div>
            <b style="text-align: left;color: #00b9de ; font-size: 16px"><a href="${cx}/public/activity/edit?id=${preview.aid}">返回编辑区</a></b>
        </div>
        <div class="col-sm-12">
            <div class="one" >

                <input type="hidden" value="${preview.aid}" id="aid">
                <div class="title"><strong><h3 style="text-align: center">${preview.title}</h3></strong></div>
                <p style="text-indent:50px;">
                </p>
                <hr style="margin-bottom: 10px;margin-top: 10px;color: #0c1119">
                    ${preview.content}
            </div>
        </div>

    </section>



</template:index>
