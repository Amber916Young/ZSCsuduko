<template:index >
    <%--数独--%>
    <link type="text/css"  rel="stylesheet" href="${cx}/resource/static/sudoku/sudoku.css">
    <link type="text/css"  rel="stylesheet" href="${cx}/resource/static/sudoku/main.css">
    <link rel="stylesheet" type="text/css" href="${cx}/resource/static/css/mystyle.css"/>


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

    .one {
        padding: 2em;
        margin-top: 2em;
        margin-bottom: 2em;
        /*background-color: white;*/
        border-radius: 0.75em;
        font-family: "Microsoft YaHei", "宋体", "Segoe UI", "Lucida Grande", Helvetica, Arial, sans-serif, FreeSans, Arimo;

    }
        .two{
            /*margin-left: 150px;*/
            margin-bottom: 1em;
            font-size: 1em;
            font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
        }
        #btable6 input{
            height: 38px;

        }
        #wrongtable6 input{
            height: 38px;
        }


</style>
    <div class="main" style="background-color: white;margin-left: 2em;margin-right: 2em;" >
        <div class="panel-body" style="margin: auto">
            <ol class="breadcrumb" style=";border-radius: 0;color: #004957 ;float: left">
                当前位置：
                <li class="breadcrumb-item"><a href="${cx}/index/">网站主页</a></li>
                <li class="breadcrumb-item"><a href="${cx}/index/suduko">数独练习</a></li>
                <li class="breadcrumb-item active" style="color: #000000">${suduko.type}</li>
            </ol>
            <div class="one" >
                <div class="two">
                    <h4>每日一练 ${timingsuduko.time.substring(0,10)}</h4>
                    题号id：${suduko.id}
                    <input type="hidden" value="${suduko.id}" id="id">
                    <input type="hidden" value="${user.username}" id="username">
                    <input type="hidden" value="${user.realname}" id="realname">
                </div>
                <div class="two">
                    难度等级：${suduko.difficulty_level}
                    <input type="hidden" value="${suduko.difficulty_level}" id="difficulty_level">
                </div>
                <div class="two">
                    分值：${suduko.score}
                    <input type="hidden" value="${suduko.score}" id="score">
                </div>
                <div class="two">
                    数独类型：${suduko.type}
                    <input type="hidden" value="${suduko.type}" id="type">
                </div>
                <div class="two">
                    耗时:<input type="text" id="spendtime" name="spendtime" readonly=true style="width:80px; border:0px; background:#FFFFFF; padding:2px 0px 0px 10px" value="00:00" />
                </div>

                <div id="sudokupart" style="text-align: center;width: 100%;">
                    <input type="hidden" value="${sudukoImg.type}" id="sudukoImg_type">
                    <input type="hidden" value="" id="sudukourl">
                    <%--<input type="hidden" value="">--%>
                    <%--<input type="hidden" value="">--%>
                <hr style="margin: 0 ">
                    <form id="sudokuform" name="sudokuform" >

                    <c:choose>
                        <c:when test="${not empty sudukoImg}">
                            <b>此题为变形数独，请根据图片在空白表格写上答案</b><br><br>
                            <div style="float: left;margin-bottom: 3em">
                                <img style="border: 1px solid black; width:300px "  src="${sudukoImg.fileUrl}"/>
                                <c:choose>
                                    <c:when test="${not empty user}">
                                        <div id="submit3" style="margin-top: 2em"></div>
                                    </c:when>
                                    <c:otherwise>
                                        <b style="color: darkred" > 您还没有登陆，不能做题</b>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                                <c:choose >
                                    <c:when test="${sudukoImg.type=='变形六宫数独'}">
                                        <c:if test="${not empty user}">
                                            <br><br> <input type="hidden" id="answer" value="${answer}">
                                        </c:if>

                                        <div style="" >
                                            <center>
                                                <table id="btable6" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div id="b6sudokudiv00" class="shown1"><input type="text" id="b6sudokunum00" maxlength="1" name="b6sudokunum00" class="sudokuinput" value="" ></div><div id="b6sudokumaybe00" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv01" class="shown1"><input type="text" id="b6sudokunum01" maxlength="1" name="b6sudokunum01" class="sudokuinput" value="" ></div><div id="b6sudokumaybe01" class="hidden"></div></td><td class="sudoku1" ><div id="b6sudokudiv02" class="shown1"><input type="text" id="b6sudokunum02" maxlength="1" name="b6sudokunum02" class="sudokuinput" value="" ></div><div id="b6sudokumaybe02" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv03" class="shown1"><input type="text" id="b6sudokunum03" maxlength="1" name="b6sudokunum03" class="sudokuinput" value="" ></div><div id="b6sudokumaybe03" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv04" class="shown1"><input type="text" id="b6sudokunum04" maxlength="1" name="b6sudokunum04" class="sudokuinput" value="" ></div><div id="b6sudokumaybe04" class="hidden"></div></td><td class="sudoku1" ><div id="b6sudokudiv05" class="shown1"><input type="text" id="b6sudokunum05" maxlength="1" name="b6sudokunum05" class="sudokuinput" value="" ></div><div id="b6sudokumaybe05" class="hidden"></div></td></tr><tr><td class="sudoku2" ><div id="b6sudokudiv10" class="shown1"><input type="text" id="b6sudokunum10" maxlength="1" name="b6sudokunum10" class="sudokuinput" value="" ></div><div id="b6sudokumaybe10" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv11" class="shown1"><input type="text" id="b6sudokunum11" maxlength="1" name="b6sudokunum11" class="sudokuinput" value="" ></div><div id="b6sudokumaybe11" class="hidden"></div></td><td class="sudoku3" ><div id="b6sudokudiv12" class="shown1"><input type="text" id="b6sudokunum12" maxlength="1" name="b6sudokunum12" class="sudokuinput" value="" ></div><div id="b6sudokumaybe12" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv13" class="shown1"><input type="text" id="b6sudokunum13" maxlength="1" name="b6sudokunum13" class="sudokuinput" value="" ></div><div id="b6sudokumaybe13" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv14" class="shown1"><input type="text" id="b6sudokunum14" maxlength="1" name="b6sudokunum14" class="sudokuinput" value="" ></div><div id="b6sudokumaybe14" class="hidden"></div></td><td class="sudoku3" ><div id="b6sudokudiv15" class="shown1"><input type="text" id="b6sudokunum15" maxlength="1" name="b6sudokunum15" class="sudokuinput" value="" ></div><div id="b6sudokumaybe15" class="hidden"></div></td></tr><tr><td class="sudoku" ><div id="b6sudokudiv20" class="shown1"><input type="text" id="b6sudokunum20" maxlength="1" name="b6sudokunum20" class="sudokuinput" value="" ></div><div id="b6sudokumaybe20" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv21" class="shown1"><input type="text" id="b6sudokunum21" maxlength="1" name="b6sudokunum21" class="sudokuinput" value="" ></div><div id="b6sudokumaybe21" class="hidden"></div></td><td class="sudoku1" ><div id="b6sudokudiv22" class="shown1"><input type="text" id="b6sudokunum22" maxlength="1" name="b6sudokunum22" class="sudokuinput" value="" ></div><div id="b6sudokumaybe22" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv23" class="shown1"><input type="text" id="b6sudokunum23" maxlength="1" name="b6sudokunum23" class="sudokuinput" value="" ></div><div id="b6sudokumaybe23" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv24" class="shown1"><input type="text" id="b6sudokunum24" maxlength="1" name="b6sudokunum24" class="sudokuinput" value="" ></div><div id="b6sudokumaybe24" class="hidden"></div></td><td class="sudoku1" ><div id="b6sudokudiv25" class="shown1"><input type="text" id="b6sudokunum25" maxlength="1" name="b6sudokunum25" class="sudokuinput" value="" ></div><div id="b6sudokumaybe25" class="hidden"></div></td></tr><tr><td class="sudoku2" ><div id="b6sudokudiv30" class="shown1"><input type="text" id="b6sudokunum30" maxlength="1" name="b6sudokunum30" class="sudokuinput" value="" ></div><div id="b6sudokumaybe30" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv31" class="shown1"><input type="text" id="b6sudokunum31" maxlength="1" name="b6sudokunum31" class="sudokuinput" value="" ></div><div id="b6sudokumaybe31" class="hidden"></div></td><td class="sudoku3" ><div id="b6sudokudiv32" class="shown1"><input type="text" id="b6sudokunum32" maxlength="1" name="b6sudokunum32" class="sudokuinput" value="" ></div><div id="b6sudokumaybe32" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv33" class="shown1"><input type="text" id="b6sudokunum33" maxlength="1" name="b6sudokunum33" class="sudokuinput" value="" ></div><div id="b6sudokumaybe33" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv34" class="shown1"><input type="text" id="b6sudokunum34" maxlength="1" name="b6sudokunum34" class="sudokuinput" value="" ></div><div id="b6sudokumaybe34" class="hidden"></div></td><td class="sudoku3" ><div id="b6sudokudiv35" class="shown1"><input type="text" id="b6sudokunum35" maxlength="1" name="b6sudokunum35" class="sudokuinput" value="" ></div><div id="b6sudokumaybe35" class="hidden"></div></td></tr><tr><td class="sudoku" ><div id="b6sudokudiv40" class="shown1"><input type="text" id="b6sudokunum40" maxlength="1" name="b6sudokunum40" class="sudokuinput" value="" ></div><div id="b6sudokumaybe40" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv41" class="shown1"><input type="text" id="b6sudokunum41" maxlength="1" name="b6sudokunum41" class="sudokuinput" value="" ></div><div id="b6sudokumaybe41" class="hidden"></div></td><td class="sudoku1" ><div id="b6sudokudiv42" class="shown1"><input type="text" id="b6sudokunum42" maxlength="1" name="b6sudokunum42" class="sudokuinput" value="" ></div><div id="b6sudokumaybe42" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv43" class="shown1"><input type="text" id="b6sudokunum43" maxlength="1" name="b6sudokunum43" class="sudokuinput" value="" ></div><div id="b6sudokumaybe43" class="hidden"></div></td><td class="sudoku" ><div id="b6sudokudiv44" class="shown1"><input type="text" id="b6sudokunum44" maxlength="1" name="b6sudokunum44" class="sudokuinput" value="" ></div><div id="b6sudokumaybe44" class="hidden"></div></td><td class="sudoku1" ><div id="b6sudokudiv45" class="shown1"><input type="text" id="b6sudokunum45" maxlength="1" name="b6sudokunum45" class="sudokuinput" value="" ></div><div id="b6sudokumaybe45" class="hidden"></div></td></tr><tr><td class="sudoku2" ><div id="b6sudokudiv50" class="shown1"><input type="text" id="b6sudokunum50" maxlength="1" name="b6sudokunum50" class="sudokuinput" value="" ></div><div id="b6sudokumaybe50" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv51" class="shown1"><input type="text" id="b6sudokunum51" maxlength="1" name="b6sudokunum51" class="sudokuinput" value="" ></div><div id="b6sudokumaybe51" class="hidden"></div></td><td class="sudoku3" ><div id="b6sudokudiv52" class="shown1"><input type="text" id="b6sudokunum52" maxlength="1" name="b6sudokunum52" class="sudokuinput" value="" ></div><div id="b6sudokumaybe52" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv53" class="shown1"><input type="text" id="b6sudokunum53" maxlength="1" name="b6sudokunum53" class="sudokuinput" value="" ></div><div id="b6sudokumaybe53" class="hidden"></div></td><td class="sudoku2" ><div id="b6sudokudiv54" class="shown1"><input type="text" id="b6sudokunum54" maxlength="1" name="b6sudokunum54" class="sudokuinput" value="" ></div><div id="b6sudokumaybe54" class="hidden"></div></td><td class="sudoku3" ><div id="b6sudokudiv55" class="shown1"><input type="text" id="b6sudokunum55" maxlength="1" name="b6sudokunum55" class="sudokuinput" value="" ></div><div id="b6sudokumaybe55" class="hidden"></div></td></tr></tbody></table>
                                            </center>
                                        </div>
                                        <c:if test="${not empty user}">
                                            <div id="bianwrong6" style="">
                                                    <%--<center>--%>
                                                    <%--<table id="" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr></tbody></table>--%>
                                                    <%--</center>--%>
                                            </div>
                                        </c:if>

                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${not empty user}">
                                            <br><br> <input type="hidden" id="answer" value="${answer}">
                                        </c:if>

                                        <div style="">
                                                <center>
                                                    <table id="btable9" class="sudoku" cellspacing="0" cellpadding="0" border="0">
                                                        <tbody>
                                                        <tr><td class="sudoku" ><div id="b9sudokudiv00" class="shown1"><input type="text" id="b9sudokunum00" maxlength="1" name="sudokunum00" class="sudokuinput" value="" ></div><div id="b9sudokumaybe00" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv01" class="shown1"><input type="text" id="b9sudokunum01" maxlength="1" name="sudokunum01" class="sudokuinput" value="" ></div><div id="b9sudokumaybe01" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv02" class="shown1"><input type="text" id="b9sudokunum02" maxlength="1" name="sudokunum02" class="sudokuinput" value="" ></div><div id="b9sudokumaybe02" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv03" class="shown1"><input type="text" id="b9sudokunum03" maxlength="1" name="sudokunum03" class="sudokuinput" value="" ></div><div id="b9sudokumaybe03" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv04" class="shown1"><input type="text" id="b9sudokunum04" maxlength="1" name="sudokunum04" class="sudokuinput" value="" ></div><div id="b9sudokumaybe04" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv05" class="shown1"><input type="text" id="b9sudokunum05" maxlength="1" name="sudokunum05" class="sudokuinput" value="" ></div><div id="b9sudokumaybe05" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv06" class="shown1"><input type="text" id="b9sudokunum06" maxlength="1" name="sudokunum06" class="sudokuinput" value="" ></div><div id="b9sudokumaybe06" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv07" class="shown1"><input type="text" id="b9sudokunum07" maxlength="1" name="sudokunum07" class="sudokuinput" value="" ></div><div id="b9sudokumaybe07" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv08" class="shown1"><input type="text" id="b9sudokunum08" maxlength="1" name="sudokunum08" class="sudokuinput" value="" ></div><div id="b9sudokumaybe08" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku" ><div id="b9sudokudiv10" class="shown1"><input type="text" id="b9sudokunum10" maxlength="1" name="sudokunum10" class="sudokuinput" value="" ></div><div id="b9sudokumaybe10" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv11" class="shown1"><input type="text" id="b9sudokunum11" maxlength="1" name="sudokunum11" class="sudokuinput" value="" ></div><div id="b9sudokumaybe11" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv12" class="shown1"><input type="text" id="b9sudokunum12" maxlength="1" name="sudokunum12" class="sudokuinput" value="" ></div><div id="b9sudokumaybe12" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv13" class="shown1"><input type="text" id="b9sudokunum13" maxlength="1" name="sudokunum13" class="sudokuinput" value="" ></div><div id="b9sudokumaybe13" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv14" class="shown1"><input type="text" id="b9sudokunum14" maxlength="1" name="sudokunum14" class="sudokuinput" value="" ></div><div id="b9sudokumaybe14" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv15" class="shown1"><input type="text" id="b9sudokunum15" maxlength="1" name="sudokunum15" class="sudokuinput" value="" ></div><div id="b9sudokumaybe15" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv16" class="shown1"><input type="text" id="b9sudokunum16" maxlength="1" name="sudokunum16" class="sudokuinput" value="" ></div><div id="b9sudokumaybe16" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv17" class="shown1"><input type="text" id="b9sudokunum17" maxlength="1" name="sudokunum17" class="sudokuinput" value="" ></div><div id="b9sudokumaybe17" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv18" class="shown1"><input type="text" id="b9sudokunum18" maxlength="1" name="sudokunum18" class="sudokuinput" value="" ></div><div id="b9sudokumaybe18" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku2" ><div id="b9sudokudiv20" class="shown1"><input type="text" id="b9sudokunum20" maxlength="1" name="sudokunum20" class="sudokuinput" value="" ></div><div id="b9sudokumaybe20" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv21" class="shown1"><input type="text" id="b9sudokunum21" maxlength="1" name="sudokunum21" class="sudokuinput" value="" ></div><div id="b9sudokumaybe21" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv22" class="shown1"><input type="text" id="b9sudokunum22" maxlength="1" name="sudokunum22" class="sudokuinput" value="" ></div><div id="b9sudokumaybe22" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv23" class="shown1"><input type="text" id="b9sudokunum23" maxlength="1" name="sudokunum23" class="sudokuinput" value="" ></div><div id="b9sudokumaybe23" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv24" class="shown1"><input type="text" id="b9sudokunum24" maxlength="1" name="sudokunum24" class="sudokuinput" value="" ></div><div id="b9sudokumaybe24" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv25" class="shown1"><input type="text" id="b9sudokunum25" maxlength="1" name="sudokunum25" class="sudokuinput" value="" ></div><div id="b9sudokumaybe25" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv26" class="shown1"><input type="text" id="b9sudokunum26" maxlength="1" name="sudokunum26" class="sudokuinput" value="" ></div><div id="b9sudokumaybe26" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv27" class="shown1"><input type="text" id="b9sudokunum27" maxlength="1" name="sudokunum27" class="sudokuinput" value="" ></div><div id="b9sudokumaybe27" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv28" class="shown1"><input type="text" id="b9sudokunum28" maxlength="1" name="sudokunum28" class="sudokuinput" value="" ></div><div id="b9sudokumaybe28" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku" ><div id="b9sudokudiv30" class="shown1"><input type="text" id="b9sudokunum30" maxlength="1" name="sudokunum30" class="sudokuinput" value="" ></div><div id="b9sudokumaybe30" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv31" class="shown1"><input type="text" id="b9sudokunum31" maxlength="1" name="sudokunum31" class="sudokuinput" value="" ></div><div id="b9sudokumaybe31" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv32" class="shown1"><input type="text" id="b9sudokunum32" maxlength="1" name="sudokunum32" class="sudokuinput" value="" ></div><div id="b9sudokumaybe32" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv33" class="shown1"><input type="text" id="b9sudokunum33" maxlength="1" name="sudokunum33" class="sudokuinput" value="" ></div><div id="b9sudokumaybe33" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv34" class="shown1"><input type="text" id="b9sudokunum34" maxlength="1" name="sudokunum34" class="sudokuinput" value="" ></div><div id="b9sudokumaybe34" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv35" class="shown1"><input type="text" id="b9sudokunum35" maxlength="1" name="sudokunum35" class="sudokuinput" value="" ></div><div id="b9sudokumaybe35" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv36" class="shown1"><input type="text" id="b9sudokunum36" maxlength="1" name="sudokunum36" class="sudokuinput" value="" ></div><div id="b9sudokumaybe36" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv37" class="shown1"><input type="text" id="b9sudokunum37" maxlength="1" name="sudokunum37" class="sudokuinput" value="" ></div><div id="b9sudokumaybe37" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv38" class="shown1"><input type="text" id="b9sudokunum38" maxlength="1" name="sudokunum38" class="sudokuinput" value="" ></div><div id="b9sudokumaybe38" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku" ><div id="b9sudokudiv40" class="shown1"><input type="text" id="b9sudokunum40" maxlength="1" name="sudokunum40" class="sudokuinput" value="" ></div><div id="b9sudokumaybe40" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv41" class="shown1"><input type="text" id="b9sudokunum41" maxlength="1" name="sudokunum41" class="sudokuinput" value="" ></div><div id="b9sudokumaybe41" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv42" class="shown1"><input type="text" id="b9sudokunum42" maxlength="1" name="sudokunum42" class="sudokuinput" value="" ></div><div id="b9sudokumaybe42" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv43" class="shown1"><input type="text" id="b9sudokunum43" maxlength="1" name="sudokunum43" class="sudokuinput" value="" ></div><div id="b9sudokumaybe43" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv44" class="shown1"><input type="text" id="b9sudokunum44" maxlength="1" name="sudokunum44" class="sudokuinput" value="" ></div><div id="b9sudokumaybe44" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv45" class="shown1"><input type="text" id="b9sudokunum45" maxlength="1" name="sudokunum45" class="sudokuinput" value="" ></div><div id="b9sudokumaybe45" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv46" class="shown1"><input type="text" id="b9sudokunum46" maxlength="1" name="sudokunum46" class="sudokuinput" value="" ></div><div id="b9sudokumaybe46" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv47" class="shown1"><input type="text" id="b9sudokunum47" maxlength="1" name="sudokunum47" class="sudokuinput" value="" ></div><div id="b9sudokumaybe47" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv48" class="shown1"><input type="text" id="b9sudokunum48" maxlength="1" name="sudokunum48" class="sudokuinput" value="" ></div><div id="b9sudokumaybe48" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku2" ><div id="b9sudokudiv50" class="shown1"><input type="text" id="b9sudokunum50" maxlength="1" name="sudokunum50" class="sudokuinput" value="" ></div><div id="b9sudokumaybe50" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv51" class="shown1"><input type="text" id="b9sudokunum51" maxlength="1" name="sudokunum51" class="sudokuinput" value="" ></div><div id="b9sudokumaybe51" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv52" class="shown1"><input type="text" id="b9sudokunum52" maxlength="1" name="sudokunum52" class="sudokuinput" value="" ></div><div id="b9sudokumaybe52" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv53" class="shown1"><input type="text" id="b9sudokunum53" maxlength="1" name="sudokunum53" class="sudokuinput" value="" ></div><div id="b9sudokumaybe53" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv54" class="shown1"><input type="text" id="b9sudokunum54" maxlength="1" name="sudokunum54" class="sudokuinput" value="" ></div><div id="b9sudokumaybe54" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv55" class="shown1"><input type="text" id="b9sudokunum55" maxlength="1" name="sudokunum55" class="sudokuinput" value="" ></div><div id="b9sudokumaybe55" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv56" class="shown1"><input type="text" id="b9sudokunum56" maxlength="1" name="sudokunum56" class="sudokuinput" value="" ></div><div id="b9sudokumaybe56" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv57" class="shown1"><input type="text" id="b9sudokunum57" maxlength="1" name="sudokunum57" class="sudokuinput" value="" ></div><div id="b9sudokumaybe57" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv58" class="shown1"><input type="text" id="b9sudokunum58" maxlength="1" name="sudokunum58" class="sudokuinput" value="" ></div><div id="b9sudokumaybe58" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku" ><div id="b9sudokudiv60" class="shown1"><input type="text" id="b9sudokunum60" maxlength="1" name="sudokunum60" class="sudokuinput" value="" ></div><div id="b9sudokumaybe60" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv61" class="shown1"><input type="text" id="b9sudokunum61" maxlength="1" name="sudokunum61" class="sudokuinput" value="" ></div><div id="b9sudokumaybe61" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv62" class="shown1"><input type="text" id="b9sudokunum62" maxlength="1" name="sudokunum62" class="sudokuinput" value="" ></div><div id="b9sudokumaybe62" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv63" class="shown1"><input type="text" id="b9sudokunum63" maxlength="1" name="sudokunum63" class="sudokuinput" value="" ></div><div id="b9sudokumaybe63" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv64" class="shown1"><input type="text" id="b9sudokunum64" maxlength="1" name="sudokunum64" class="sudokuinput" value="" ></div><div id="b9sudokumaybe64" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv65" class="shown1"><input type="text" id="b9sudokunum65" maxlength="1" name="sudokunum65" class="sudokuinput" value="" ></div><div id="b9sudokumaybe65" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv66" class="shown1"><input type="text" id="b9sudokunum66" maxlength="1" name="sudokunum66" class="sudokuinput" value="" ></div><div id="b9sudokumaybe66" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv67" class="shown1"><input type="text" id="b9sudokunum67" maxlength="1" name="sudokunum67" class="sudokuinput" value="" ></div><div id="b9sudokumaybe67" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv68" class="shown1"><input type="text" id="b9sudokunum68" maxlength="1" name="sudokunum68" class="sudokuinput" value="" ></div><div id="b9sudokumaybe68" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku" ><div id="b9sudokudiv70" class="shown1"><input type="text" id="b9sudokunum70" maxlength="1" name="sudokunum70" class="sudokuinput" value="" ></div><div id="b9sudokumaybe70" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv71" class="shown1"><input type="text" id="b9sudokunum71" maxlength="1" name="sudokunum71" class="sudokuinput" value="" ></div><div id="b9sudokumaybe71" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv72" class="shown1"><input type="text" id="b9sudokunum72" maxlength="1" name="sudokunum72" class="sudokuinput" value="" ></div><div id="b9sudokumaybe72" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv73" class="shown1"><input type="text" id="b9sudokunum73" maxlength="1" name="sudokunum73" class="sudokuinput" value="" ></div><div id="b9sudokumaybe73" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv74" class="shown1"><input type="text" id="b9sudokunum74" maxlength="1" name="sudokunum74" class="sudokuinput" value="" ></div><div id="b9sudokumaybe74" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv75" class="shown1"><input type="text" id="b9sudokunum75" maxlength="1" name="sudokunum75" class="sudokuinput" value="" ></div><div id="b9sudokumaybe75" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv76" class="shown1"><input type="text" id="b9sudokunum76" maxlength="1" name="sudokunum76" class="sudokuinput" value="" ></div><div id="b9sudokumaybe76" class="hidden"></div></td><td class="sudoku" ><div id="b9sudokudiv77" class="shown1"><input type="text" id="b9sudokunum77" maxlength="1" name="sudokunum77" class="sudokuinput" value="" ></div><div id="b9sudokumaybe77" class="hidden"></div></td><td class="sudoku1" ><div id="b9sudokudiv78" class="shown1"><input type="text" id="b9sudokunum78" maxlength="1" name="sudokunum78" class="sudokuinput" value="" ></div><div id="b9sudokumaybe78" class="hidden"></div></td></tr>
                                                        <tr><td class="sudoku2" ><div id="b9sudokudiv80" class="shown1"><input type="text" id="b9sudokunum80" maxlength="1" name="sudokunum80" class="sudokuinput" value="" ></div><div id="b9sudokumaybe80" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv81" class="shown1"><input type="text" id="b9sudokunum81" maxlength="1" name="sudokunum81" class="sudokuinput" value="" ></div><div id="b9sudokumaybe81" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv82" class="shown1"><input type="text" id="b9sudokunum82" maxlength="1" name="sudokunum82" class="sudokuinput" value="" ></div><div id="b9sudokumaybe82" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv83" class="shown1"><input type="text" id="b9sudokunum83" maxlength="1" name="sudokunum83" class="sudokuinput" value="" ></div><div id="b9sudokumaybe83" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv84" class="shown1"><input type="text" id="b9sudokunum84" maxlength="1" name="sudokunum84" class="sudokuinput" value="" ></div><div id="b9sudokumaybe84" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv85" class="shown1"><input type="text" id="b9sudokunum85" maxlength="1" name="sudokunum85" class="sudokuinput" value="" ></div><div id="b9sudokumaybe85" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv86" class="shown1"><input type="text" id="b9sudokunum86" maxlength="1" name="sudokunum86" class="sudokuinput" value="" ></div><div id="b9sudokumaybe86" class="hidden"></div></td><td class="sudoku2" ><div id="b9sudokudiv87" class="shown1"><input type="text" id="b9sudokunum87" maxlength="1" name="sudokunum87" class="sudokuinput" value="" ></div><div id="b9sudokumaybe87" class="hidden"></div></td><td class="sudoku3" ><div id="b9sudokudiv88" class="shown1"><input type="text" id="b9sudokunum88" maxlength="1" name="sudokunum88" class="sudokuinput" value="" ></div><div id="b9sudokumaybe88" class="hidden"></div></td></tr>
                                                        </tbody>
                                                    </table>
                                                </center>
                                        </div>
                                        <c:if test="${not empty user}">
                                            <div id="bianwrong9" style="">
                                                    <%--<center>--%>
                                                    <%--</center>--%>
                                            </div>
                                        </c:if>

                                    </c:otherwise>
                                </c:choose>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${suduko.type=='标准六宫数独'}">
                                    <b style="margin-bottom: 2em">此题为标准六宫数独</b>
                                    <c:if test="${not empty user}">
                                        <br><br> <input type="hidden" id="answer" value="${answer}">
                                        <div id="wrong" style="">

                                        </div>
                                    </c:if>


                                    <center>
                                        <%--<table id="table6" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div id="stand6sudokudiv00" class="shown1"><input type="text" id="stand6sudokunum00" maxlength="1" name="sudokunum00" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe00" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv01" class="shown1"><input type="text" id="stand6sudokunum01" maxlength="1" name="sudokunum01" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe01" class="hidden"></div></td><td class="sudoku1" ><div id="stand6sudokudiv02" class="shown1"><input type="text" id="stand6sudokunum02" maxlength="1" name="sudokunum02" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe02" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv03" class="shown1"><input type="text" id="stand6sudokunum03" maxlength="1" name="sudokunum03" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe03" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv04" class="shown1"><input type="text" id="stand6sudokunum04" maxlength="1" name="sudokunum04" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe04" class="hidden"></div></td><td class="sudoku1" ><div id="stand6sudokudiv05" class="shown1"><input type="text" id="stand6sudokunum05" maxlength="1" name="sudokunum05" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe05" class="hidden"></div></td></tr><tr><td class="sudoku2" ><div id="stand6sudokudiv10" class="shown1"><input type="text" id="stand6sudokunum10" maxlength="1" name="sudokunum10" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe10" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv11" class="shown1"><input type="text" id="stand6sudokunum11" maxlength="1" name="sudokunum11" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe11" class="hidden"></div></td><td class="sudoku3" ><div id="stand6sudokudiv12" class="shown1"><input type="text" id="stand6sudokunum12" maxlength="1" name="sudokunum12" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe12" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv13" class="shown1"><input type="text" id="stand6sudokunum13" maxlength="1" name="sudokunum13" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe13" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv14" class="shown1"><input type="text" id="stand6sudokunum14" maxlength="1" name="sudokunum14" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe14" class="hidden"></div></td><td class="sudoku3" ><div id="stand6sudokudiv15" class="shown1"><input type="text" id="stand6sudokunum15" maxlength="1" name="sudokunum15" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe15" class="hidden"></div></td></tr><tr><td class="sudoku" ><div id="stand6sudokudiv20" class="shown1"><input type="text" id="stand6sudokunum20" maxlength="1" name="sudokunum20" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe20" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv21" class="shown1"><input type="text" id="stand6sudokunum21" maxlength="1" name="sudokunum21" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe21" class="hidden"></div></td><td class="sudoku1" ><div id="stand6sudokudiv22" class="shown1"><input type="text" id="stand6sudokunum22" maxlength="1" name="sudokunum22" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe22" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv23" class="shown1"><input type="text" id="stand6sudokunum23" maxlength="1" name="sudokunum23" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe23" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv24" class="shown1"><input type="text" id="stand6sudokunum24" maxlength="1" name="sudokunum24" class="sudokuinput2" value="" ></div><div id="stand6sudokumaybe24" class="hidden"></div></td><td class="sudoku1" ><div id="stand6sudokudiv25" class="shown1"><input type="text" id="stand6sudokunum25" maxlength="1" name="sudokunum25" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe25" class="hidden"></div></td></tr><tr><td class="sudoku2" ><div id="stand6sudokudiv30" class="shown1"><input type="text" id="stand6sudokunum30" maxlength="1" name="sudokunum30" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe30" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv31" class="shown1"><input type="text" id="stand6sudokunum31" maxlength="1" name="sudokunum31" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe31" class="hidden"></div></td><td class="sudoku3" ><div id="stand6sudokudiv32" class="shown1"><input type="text" id="stand6sudokunum32" maxlength="1" name="sudokunum32" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe32" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv33" class="shown1"><input type="text" id="stand6sudokunum33" maxlength="1" name="sudokunum33" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe33" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv34" class="shown1"><input type="text" id="stand6sudokunum34" maxlength="1" name="sudokunum34" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe34" class="hidden"></div></td><td class="sudoku3" ><div id="stand6sudokudiv35" class="shown1"><input type="text" id="stand6sudokunum35" maxlength="1" name="sudokunum35" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe35" class="hidden"></div></td></tr><tr><td class="sudoku" ><div id="stand6sudokudiv40" class="shown1"><input type="text" id="stand6sudokunum40" maxlength="1" name="sudokunum40" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe40" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv41" class="shown1"><input type="text" id="stand6sudokunum41" maxlength="1" name="sudokunum41" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe41" class="hidden"></div></td><td class="sudoku1" ><div id="stand6sudokudiv42" class="shown1"><input type="text" id="stand6sudokunum42" maxlength="1" name="sudokunum42" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe42" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv43" class="shown1"><input type="text" id="stand6sudokunum43" maxlength="1" name="sudokunum43" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe43" class="hidden"></div></td><td class="sudoku" ><div id="stand6sudokudiv44" class="shown1"><input type="text" id="stand6sudokunum44" maxlength="1" name="sudokunum44" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe44" class="hidden"></div></td><td class="sudoku1" ><div id="stand6sudokudiv45" class="shown1"><input type="text" id="stand6sudokunum45" maxlength="1" name="sudokunum45" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe45" class="hidden"></div></td></tr><tr><td class="sudoku2" ><div id="stand6sudokudiv50" class="shown1"><input type="text" id="stand6sudokunum50" maxlength="1" name="sudokunum50" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe50" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv51" class="shown1"><input type="text" id="stand6sudokunum51" maxlength="1" name="sudokunum51" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe51" class="hidden"></div></td><td class="sudoku3" ><div id="stand6sudokudiv52" class="shown1"><input type="text" id="stand6sudokunum52" maxlength="1" name="sudokunum52" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe52" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv53" class="shown1"><input type="text" id="stand6sudokunum53" maxlength="1" name="sudokunum53" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe53" class="hidden"></div></td><td class="sudoku2" ><div id="stand6sudokudiv54" class="shown1"><input type="text" id="stand6sudokunum54" maxlength="1" name="sudokunum54" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe54" class="hidden"></div></td><td class="sudoku3" ><div id="stand6sudokudiv55" class="shown1"><input type="text" id="stand6sudokunum55" maxlength="1" name="sudokunum55" class="sudokuinput" value="" ></div><div id="stand6sudokumaybe55" class="hidden"></div></td></tr></tbody></table>                                    </center>--%>
                                            <table id="table6" cellpadding="0" cellspacing="0" border="0" class="sudoku">
                                                <tbody>
                                                <tr>
                                                    <td class="sudoku" ><div id="stand6sudokudiv00" class="shown1"></div><div id="stand6sudokumaybe00" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv01" class="shown1"></div><div id="stand6sudokumaybe01" class="hidden"></div></td>
                                                    <td class="sudoku1" ><div id="stand6sudokudiv02" class="shown1"></div><div id="stand6sudokumaybe02" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv03" class="shown1"></div><div id="stand6sudokumaybe03" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv04" class="shown1"></div><div id="stand6sudokumaybe04" class="hidden"></div></td>
                                                    <td class="sudoku1" ><div id="stand6sudokudiv05" class="shown1"></div><div id="stand6sudokumaybe05" class="hidden"></div></td>
                                                </tr>
                                                <tr>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv10" class="shown1"></div><div id="stand6sudokumaybe10" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv11" class="shown1"></div><div id="stand6sudokumaybe11" class="hidden"></div></td>
                                                    <td class="sudoku3" ><div id="stand6sudokudiv12" class="shown1"></div><div id="stand6sudokumaybe12" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv13" class="shown1"></div><div id="stand6sudokumaybe13" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv14" class="shown1"></div><div id="stand6sudokumaybe14" class="hidden"></div></td>
                                                    <td class="sudoku3" ><div id="stand6sudokudiv15" class="shown1"></div><div id="stand6sudokumaybe15" class="hidden"></div></td>
                                                </tr>
                                                <tr>
                                                    <td class="sudoku" ><div id="stand6sudokudiv20" class="shown1"></div><div id="stand6sudokumaybe20" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv21" class="shown1"></div><div id="stand6sudokumaybe21" class="hidden"></div></td>
                                                    <td class="sudoku1" ><div id="stand6sudokudiv22" class="shown1"></div><div id="stand6sudokumaybe22" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv23" class="shown1"></div><div id="stand6sudokumaybe23" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv24" class="shown1"></div><div id="stand6sudokumaybe24" class="hidden"></div></td>
                                                    <td class="sudoku1" ><div id="stand6sudokudiv25" class="shown1"></div><div id="stand6sudokumaybe25" class="hidden"></div></td>
                                                </tr>
                                                <tr>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv30" class="shown1"></div><div id="stand6sudokumaybe30" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv31" class="shown1"></div><div id="stand6sudokumaybe31" class="hidden"></div></td>
                                                    <td class="sudoku3" ><div id="stand6sudokudiv32" class="shown1"></div><div id="stand6sudokumaybe32" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv33" class="shown1"></div><div id="stand6sudokumaybe33" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv34" class="shown1"></div><div id="stand6sudokumaybe34" class="hidden"></div></td>
                                                    <td class="sudoku3" ><div id="stand6sudokudiv35" class="shown1"></div><div id="stand6sudokumaybe35" class="hidden"></div></td>
                                                </tr>
                                                <tr>
                                                    <td class="sudoku" ><div id="stand6sudokudiv40" class="shown1"></div><div id="stand6sudokumaybe40" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv41" class="shown1"></div><div id="stand6sudokumaybe41" class="hidden"></div></td>
                                                    <td class="sudoku1" ><div id="stand6sudokudiv42" class="shown1"></div><div id="stand6sudokumaybe42" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv43" class="shown1"></div><div id="stand6sudokumaybe43" class="hidden"></div></td>
                                                    <td class="sudoku" ><div id="stand6sudokudiv44" class="shown1"></div><div id="stand6sudokumaybe44" class="hidden"></div></td>
                                                    <td class="sudoku1" ><div id="stand6sudokudiv45" class="shown1"></div><div id="stand6sudokumaybe45" class="hidden"></div></td>
                                                </tr>
                                                <tr>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv50" class="shown1"></div><div id="stand6sudokumaybe50" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv51" class="shown1"></div><div id="stand6sudokumaybe51" class="hidden"></div></td>
                                                    <td class="sudoku3" ><div id="stand6sudokudiv52" class="shown1"></div><div id="stand6sudokumaybe52" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv53" class="shown1"></div><div id="stand6sudokumaybe53" class="hidden"></div></td>
                                                    <td class="sudoku2" ><div id="stand6sudokudiv54" class="shown1"></div><div id="stand6sudokumaybe54" class="hidden"></div></td>
                                                    <td class="sudoku3" ><div id="stand6sudokudiv55" class="shown1"></div><div id="stand6sudokumaybe55" class="hidden"></div></td>
                                                </tr>
                                                </tbody>
                                            </table>
                                    </center>
                                </c:when>
                                <c:when test="${suduko.type=='标准九宫数独'}">
                                    <b style="margin-bottom: 2em">此题为标准九宫数独</b>
                                    <c:if test="${not empty user}">
                                        <br><br> <input type="hidden" id="answer" value="${answer}">
                                        <div id="wrong9">
                                        </div>
                                    </c:if>
                                    <div style="">
                                        <center>
                                            <table id="table9" class="sudoku" cellspacing="0" cellpadding="0" border="0">
                                                <tbody>
                                                <tr><td class="sudoku" onclick="clicktd(0,0)"><div id="sudokudiv00" class="shown1"></div><div id="sudokumaybe00" class="hidden"></div></td><td class="sudoku" onclick="clicktd(0,1)"><div id="sudokudiv01" class="shown1"></div><div id="sudokumaybe01" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(0,2)"><div id="sudokudiv02" class="shown1"></div><div id="sudokumaybe02" class="hidden"></div></td><td class="sudoku" onclick="clicktd(0,3)"><div id="sudokudiv03" class="shown1"></div><div id="sudokumaybe03" class="hidden"></div></td><td class="sudoku" onclick="clicktd(0,4)"><div id="sudokudiv04" class="shown1"></div><div id="sudokumaybe04" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(0,5)"><div id="sudokudiv05" class="shown1"></div><div id="sudokumaybe05" class="hidden"></div></td><td class="sudoku" onclick="clicktd(0,6)"><div id="sudokudiv06" class="shown1"></div><div id="sudokumaybe06" class="hidden"></div></td><td class="sudoku" onclick="clicktd(0,7)"><div id="sudokudiv07" class="shown1"></div><div id="sudokumaybe07" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(0,8)"><div id="sudokudiv08" class="shown1"></div><div id="sudokumaybe08" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku" onclick="clicktd(1,0)"><div id="sudokudiv10" class="shown1"></div><div id="sudokumaybe10" class="hidden"></div></td><td class="sudoku" onclick="clicktd(1,1)"><div id="sudokudiv11" class="shown1"></div><div id="sudokumaybe11" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(1,2)"><div id="sudokudiv12" class="shown1"></div><div id="sudokumaybe12" class="hidden"></div></td><td class="sudoku" onclick="clicktd(1,3)"><div id="sudokudiv13" class="shown1"></div><div id="sudokumaybe13" class="hidden"></div></td><td class="sudoku" onclick="clicktd(1,4)"><div id="sudokudiv14" class="shown1"></div><div id="sudokumaybe14" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(1,5)"><div id="sudokudiv15" class="shown1"></div><div id="sudokumaybe15" class="hidden"></div></td><td class="sudoku" onclick="clicktd(1,6)"><div id="sudokudiv16" class="shown1"></div><div id="sudokumaybe16" class="hidden"></div></td><td class="sudoku" onclick="clicktd(1,7)"><div id="sudokudiv17" class="shown1"></div><div id="sudokumaybe17" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(1,8)"><div id="sudokudiv18" class="shown1"></div><div id="sudokumaybe18" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku2" onclick="clicktd(2,0)"><div id="sudokudiv20" class="shown1"></div><div id="sudokumaybe20" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(2,1)"><div id="sudokudiv21" class="shown1"></div><div id="sudokumaybe21" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(2,2)"><div id="sudokudiv22" class="shown1"></div><div id="sudokumaybe22" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(2,3)"><div id="sudokudiv23" class="shown1"></div><div id="sudokumaybe23" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(2,4)"><div id="sudokudiv24" class="shown1"></div><div id="sudokumaybe24" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(2,5)"><div id="sudokudiv25" class="shown1"></div><div id="sudokumaybe25" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(2,6)"><div id="sudokudiv26" class="shown1"></div><div id="sudokumaybe26" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(2,7)"><div id="sudokudiv27" class="shown1"></div><div id="sudokumaybe27" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(2,8)"><div id="sudokudiv28" class="shown1"></div><div id="sudokumaybe28" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku" onclick="clicktd(3,0)"><div id="sudokudiv30" class="shown1"></div><div id="sudokumaybe30" class="hidden"></div></td><td class="sudoku" onclick="clicktd(3,1)"><div id="sudokudiv31" class="shown1"></div><div id="sudokumaybe31" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(3,2)"><div id="sudokudiv32" class="shown1"></div><div id="sudokumaybe32" class="hidden"></div></td><td class="sudoku" onclick="clicktd(3,3)"><div id="sudokudiv33" class="shown1"></div><div id="sudokumaybe33" class="hidden"></div></td><td class="sudoku" onclick="clicktd(3,4)"><div id="sudokudiv34" class="shown1"></div><div id="sudokumaybe34" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(3,5)"><div id="sudokudiv35" class="shown1"></div><div id="sudokumaybe35" class="hidden"></div></td><td class="sudoku" onclick="clicktd(3,6)"><div id="sudokudiv36" class="shown1"></div><div id="sudokumaybe36" class="hidden"></div></td><td class="sudoku" onclick="clicktd(3,7)"><div id="sudokudiv37" class="shown1"></div><div id="sudokumaybe37" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(3,8)"><div id="sudokudiv38" class="shown1"></div><div id="sudokumaybe38" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku" onclick="clicktd(4,0)"><div id="sudokudiv40" class="shown1"></div><div id="sudokumaybe40" class="hidden"></div></td><td class="sudoku" onclick="clicktd(4,1)"><div id="sudokudiv41" class="shown1"></div><div id="sudokumaybe41" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(4,2)"><div id="sudokudiv42" class="shown1"></div><div id="sudokumaybe42" class="hidden"></div></td><td class="sudoku" onclick="clicktd(4,3)"><div id="sudokudiv43" class="shown1"></div><div id="sudokumaybe43" class="hidden"></div></td><td class="sudoku" onclick="clicktd(4,4)"><div id="sudokudiv44" class="shown1"></div><div id="sudokumaybe44" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(4,5)"><div id="sudokudiv45" class="shown1"></div><div id="sudokumaybe45" class="hidden"></div></td><td class="sudoku" onclick="clicktd(4,6)"><div id="sudokudiv46" class="shown1"></div><div id="sudokumaybe46" class="hidden"></div></td><td class="sudoku" onclick="clicktd(4,7)"><div id="sudokudiv47" class="shown1"></div><div id="sudokumaybe47" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(4,8)"><div id="sudokudiv48" class="shown1"></div><div id="sudokumaybe48" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku2" onclick="clicktd(5,0)"><div id="sudokudiv50" class="shown1"></div><div id="sudokumaybe50" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(5,1)"><div id="sudokudiv51" class="shown1"></div><div id="sudokumaybe51" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(5,2)"><div id="sudokudiv52" class="shown1"></div><div id="sudokumaybe52" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(5,3)"><div id="sudokudiv53" class="shown1"></div><div id="sudokumaybe53" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(5,4)"><div id="sudokudiv54" class="shown1"></div><div id="sudokumaybe54" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(5,5)"><div id="sudokudiv55" class="shown1"></div><div id="sudokumaybe55" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(5,6)"><div id="sudokudiv56" class="shown1"></div><div id="sudokumaybe56" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(5,7)"><div id="sudokudiv57" class="shown1"></div><div id="sudokumaybe57" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(5,8)"><div id="sudokudiv58" class="shown1"></div><div id="sudokumaybe58" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku" onclick="clicktd(6,0)"><div id="sudokudiv60" class="shown1"></div><div id="sudokumaybe60" class="hidden"></div></td><td class="sudoku" onclick="clicktd(6,1)"><div id="sudokudiv61" class="shown1"></div><div id="sudokumaybe61" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(6,2)"><div id="sudokudiv62" class="shown1"></div><div id="sudokumaybe62" class="hidden"></div></td><td class="sudoku" onclick="clicktd(6,3)"><div id="sudokudiv63" class="shown1"></div><div id="sudokumaybe63" class="hidden"></div></td><td class="sudoku" onclick="clicktd(6,4)"><div id="sudokudiv64" class="shown1"></div><div id="sudokumaybe64" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(6,5)"><div id="sudokudiv65" class="shown1"></div><div id="sudokumaybe65" class="hidden"></div></td><td class="sudoku" onclick="clicktd(6,6)"><div id="sudokudiv66" class="shown1"></div><div id="sudokumaybe66" class="hidden"></div></td><td class="sudoku" onclick="clicktd(6,7)"><div id="sudokudiv67" class="shown1"></div><div id="sudokumaybe67" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(6,8)"><div id="sudokudiv68" class="shown1"></div><div id="sudokumaybe68" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku" onclick="clicktd(7,0)"><div id="sudokudiv70" class="shown1"></div><div id="sudokumaybe70" class="hidden"></div></td><td class="sudoku" onclick="clicktd(7,1)"><div id="sudokudiv71" class="shown1"></div><div id="sudokumaybe71" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(7,2)"><div id="sudokudiv72" class="shown1"></div><div id="sudokumaybe72" class="hidden"></div></td><td class="sudoku" onclick="clicktd(7,3)"><div id="sudokudiv73" class="shown1"></div><div id="sudokumaybe73" class="hidden"></div></td><td class="sudoku" onclick="clicktd(7,4)"><div id="sudokudiv74" class="shown1"></div><div id="sudokumaybe74" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(7,5)"><div id="sudokudiv75" class="shown1"></div><div id="sudokumaybe75" class="hidden"></div></td><td class="sudoku" onclick="clicktd(7,6)"><div id="sudokudiv76" class="shown1"></div><div id="sudokumaybe76" class="hidden"></div></td><td class="sudoku" onclick="clicktd(7,7)"><div id="sudokudiv77" class="shown1"></div><div id="sudokumaybe77" class="hidden"></div></td><td class="sudoku1" onclick="clicktd(7,8)"><div id="sudokudiv78" class="shown1"></div><div id="sudokumaybe78" class="hidden"></div></td></tr>
                                                <tr><td class="sudoku2" onclick="clicktd(8,0)"><div id="sudokudiv80" class="shown1"></div><div id="sudokumaybe80" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(8,1)"><div id="sudokudiv81" class="shown1"></div><div id="sudokumaybe81" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(8,2)"><div id="sudokudiv82" class="shown1"></div><div id="sudokumaybe82" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(8,3)"><div id="sudokudiv83" class="shown1"></div><div id="sudokumaybe83" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(8,4)"><div id="sudokudiv84" class="shown1"></div><div id="sudokumaybe84" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(8,5)"><div id="sudokudiv85" class="shown1"></div><div id="sudokumaybe85" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(8,6)"><div id="sudokudiv86" class="shown1"></div><div id="sudokumaybe86" class="hidden"></div></td><td class="sudoku2" onclick="clicktd(8,7)"><div id="sudokudiv87" class="shown1"></div><div id="sudokumaybe87" class="hidden"></div></td><td class="sudoku3" onclick="clicktd(8,8)"><div id="sudokudiv88" class="shown1"></div><div id="sudokumaybe88" class="hidden"></div></td></tr>
                                                </tbody>
                                            </table>
                                        </center>
                                    </div>

                                </c:when>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                        <div >

                        </div>


                    </form>


                    <input type="hidden" id="nowtype" name="nowtype" value="0" />

                    <input type="hidden" id="NowSudoku2" name="NowSudoku" value="" />

                    <input type="hidden" id="spendtime2" name="spendtime" value="" />

                    <input type="hidden" id="hintnums2" name="hintnums" value="" />
                    <br>

                    <c:choose>
                        <c:when test="${not empty user}">
                            <div id="submit2" style="margin-top: 20px"> </div>
                        </c:when>
                        <c:otherwise>
                            <b style="color: darkred" > 您还没有登陆，不能做题</b>
                        </c:otherwise>
                    </c:choose>
                </div>
                <input type="hidden" id="num" name="num" value="${suduko.num}" />
            </div>

        </div>
    </div>
</template:index>
<%--数独--%>
<script type="text/javascript" src="${cx}/resource/static/sudoku/function.js"></script>
<%--<script type="text/javascript" src="${cx}/resource/static/sudoku/sudoku.js"></script>--%>

<script type="text/javascript">

    var timestart=0;
    var NowX,NowY;
    var timeflag=true;
    var sudokusteps=new Array();
    var nowstep=0;
    var sudokustepcontents=new Array();
    var sudokuchecks=new Object();
    var stand6sudokuchecks=new Object();
    var stand6sudokumaybes=new Object();
    var sudokumaybes=new Object();
    var sudokux=new Object();
    var sudokuy=new Object();
    var sudoku9=new Object();
    var changeflag=true;
    for(var i=0;i<9;i++){
        sudokuchecks[i]=new Array(9);
    }
    for(var i=0;i<6;i++){
        stand6sudokuchecks[i]=new Array(6);
    }
    for(var i=0;i<9;i++){
        sudokumaybes[i]=new Array(9);
    }
    for(var i=0;i<6;i++){
        stand6sudokumaybes[i]=new Array(6);
    }
    $(function () {
        // alert(window.location.href);
        $("#sudukourl").attr("value",window.location.href);
        timestart=0;
        var num = $("#num").val();
        var type= $("#type").val();
        // alert(type);
        var sudukoImg_type= $("#sudukoImg_type").val();
        //一开始进入数据库检查又没有写过这道题
        var id=$("#id").val();
        var username=$("#username").val();
        var jsonData = {"sudukoid" : id,"username":username};
        var loadingIndex=null;

        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/userscore/checkfinish", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {
                layer.close(loadingIndex);
                if (result.success ) {
                    var finishSuduko = result.data;
                    if(finishSuduko==null||finishSuduko=="" ){

                        if(sudukoImg_type == ""){
                            // alert(sudukoImg_type);
                            // alert(num);
                            if(type=="标准九宫数独"){
                                drawsudoku(num);
                            }else{
                                drawsudoku2(num);
                            }

                        }else{
                            $("#submit3").append(" <br><input type=\"button\" class=\"btn btn-primary\" value=\"完成提交\" onclick=\"EndSub()\" />");
                            SetValue("spendtime","00:00");
                            sudokusteps.length=0;
                            sudokustepcontents.length=0;
                            starttime();
                        }

                    }else{
                        // alert(finishSuduko);
                        locksudoku(finishSuduko);
                    }
                }else {
                    layer.msg("请联系网站管理员", {time:3000, icon:5, shift:6}, function(){
                    });
                }
            },
            error:function () {
                layer.msg("上传数据失败，请检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        });
        var annww=$("#answer").val();
        if(type=="标准六宫数独"){
            if(annww==""){
                $("#wrong").html(" ");
            } else  if(annww=="0"){
                $("#wrong").html("<b style=\"color: #198522\">真厉害 这题您做对了 ，分数已加</b>");
            }else {
                $("#wrong").html('  <center>\n' +
                    '                                            <table id="wrongtable6" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr></tbody></table>\n' +
                    '                                        </center>\n' +
                    '                                        <b style="color: red">真遗憾，这题您没有做对 ,请看正确答案</b>');

                var ann =$("#wrongtable6 div");
                var numstr=annww;
                var noo,number;
                for(var i=0;i<6;i++)
                {
                    for(var j=0;j<6;j++){
                        noo=i*6+j;
                        number=numstr.substr(noo,1);
                        ann[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                    }

                }

            }
        }else if(type=="标准九宫数独"){
            if(annww==""){
                $("#wrong9").html(" ");

            }
            else if(annww=="0"){
                $("#wrong9").html("<b style=\"color: #198522\">真厉害 这题您做对了 ，分数已加</b>");
            }else{
                $("#wrong9").html('         <center>\n' +
                    '                                            <table style="margin:0" id="wrongtable9 " class="sudoku" cellspacing="0" cellpadding="0" border="0">\n' +
                    '                                                <tbody>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                    '                                                </tbody>\n' +
                    '                                            </table>\n' +
                    '                            </center>' +
                    ' <b style="color: red;">真遗憾，这题您没有做对 ,请看正确答案</b>');


                var divArr =$("#wrong9 div");
                // var divArr =$("#wrongtable9").find("div");
                $("#table9").attr("style","margin-top:3em");
                var numstr=annww;
                var noo,number;
                for(var i=0;i<9;i++)
                {
                    for(var j=0;j<9;j++){
                        noo=i*9+j;
                        number=numstr.substr(noo,1);
                        // alert(number);
                        divArr[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                    }

                }
            }

        }else if(type=="变形九宫数独"){
            if(annww==""){
                $("#bianwrong9").html(" ");
            }
            else if(annww=="0"){
                $("#bianwrong9").html("<b style=\"color: #198522\">真厉害 这题您做对了 ，分数已加</b>");
            }else{
                $("#bianwrong9").html('         <center>\n' +
                    '                                            <table  id=" " class="sudoku" cellspacing="0" cellpadding="0" border="0">\n' +
                    '                                                <tbody>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                    '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                    '                                                </tbody>\n' +
                    '                                            </table>\n' +
                    '                            </center>' +
                    ' <b style="color: red">真遗憾，这题您没有做对 ,请看正确答案</b>');


                var divArr =$("#bianwrong9 div");
                // var divArr =$("#wrongtable9").find("div");
                $("#btable9").attr("style","margin-bottom:3em");
                var numstr=annww;
                var noo,number;
                for(var i=0;i<9;i++)
                {
                    for(var j=0;j<9;j++){
                        noo=i*9+j;
                        number=numstr.substr(noo,1);
                        // alert(number);
                        divArr[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                    }

                }
            }
        }else if(type=="变形六宫数独"){
            if(annww==""){
                $("#bianwrong6").html(" ");
            } else  if(annww=="0"){
                $("#bianwrong6").html("<b style=\"color: #198522;margin-left: 350px;\">真厉害 这题您做对了 ，分数已加</b>");
            }else {
                $("#bianwrong6").html('  <center>\n' +
                    '                                            <table style="margin-top: 3em" id="" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr></tbody></table>\n' +
                    '                                        </center>\n' +
                    '                                        <b style="color: red;">真遗憾，这题您没有做对 ,请看正确答案</b>');

                var ann =$("#bianwrong6 div");
                $("#btable6").attr("style","");
                var numstr=annww;
                var noo,number;
                for(var i=0;i<6;i++)
                {
                    for(var j=0;j<6;j++){
                        noo=i*6+j;
                        number=numstr.substr(noo,1);
                        ann[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                    }

                }

            }
        }


    });


    function drawsudoku(num){
        var i,j,no,o1,o2,o3,sudokunum;
        for(i=0;i<9;i++){
            for(j=0;j<9;j++){
                no=i*9+j;
                o1=document.getElementById("sudokudiv"+i+j);
                o2=document.getElementById("sudokumaybe"+i+j);
                o3=document.getElementById("sudokunum"+i+j);
                if(o1) o1.className="shown1";
                if(o2) o2.className="hidden";
                //字符串中抽取从 start 下标开始的指定数目的字符。
                sudokunum=num.substr(no,1);
                sudokuchecks[i][j]="/";
                if(sudokunum=="0"){
                    o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokuinput\" value=\"\" onkeyup=\"checktd("+i+","+j+");\" />"
                    sudokumaybes[i][j]="123456789";
                }
                else{
                    o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
                }
            }
        }
        $("#submit2").append(" <input type=\"button\" class=\"btn btn-primary\" value=\"完成提交\" onclick=\"EndSub()\" />");
        SetValue("spendtime","00:00");
        sudokusteps.length=0;
        sudokustepcontents.length=0;

    }

    function drawsudoku2(num){
        var i,j,no,o1,o2,o3,sudokunum;
        // alert(num);
        for(i=0;i<6;i++){
            for(j=0;j<6;j++){
                no=i*6+j;
                o1=document.getElementById("stand6sudokudiv"+i+j);
                o2=document.getElementById("stand6sudokumaybe"+i+j);
                o3=document.getElementById("stand6sudokunum"+i+j);
                if(o1) o1.className="shown1";
                if(o2) o2.className="hidden";
                //字符串中抽取从 start 下标开始的指定数目的字符。
                sudokunum=num.substr(no,1);
                stand6sudokuchecks[i][j]="/";
                if(sudokunum=="0"){
                    o1.innerHTML="<input type=\"text\" id=\"stand6sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokuinput\" value=\"\"  />"
                    stand6sudokumaybes[i][j]="123456";
                }
                else{
                    o1.innerHTML="<input type=\"text\" id=\"stand6sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
                }
            }
        }
        $("#submit2").append(" <input type=\"button\" class=\"btn btn-primary\" value=\"完成提交\" onclick=\"EndSub()\" />");
        SetValue("spendtime","00:00");
        starttime();
        sudokusteps.length=0;
        sudokustepcontents.length=0;
    }
    function starttime(){
        if(timestart==0) printtime();
    }
    function clicktd(i,j){
        var o1=document.getElementById("sudokunum"+NowX+NowY);
        var o2=document.getElementById("sudokunum"+i+j);
        var flag=true;
        if(o2){
            if(o1){
                switch(o1.className){
                    case "sudokuinput2": o1.className="sudokuinput";
                        break;
                    case "sudokucheck2": o1.className="sudokucheck";
                        break;
                }
            }
            NowX=i;
            NowY=j;
            switch(o2.className){
                case "sudokuinput": o2.className="sudokuinput2";
                    break;
                case "sudokucheck": o2.className="sudokucheck2";
                    break;
                default: flag=false;
            }
            if(flag){
                var o3=document.getElementById("hintbutton");
                var o4=document.getElementById("maybetype");
                var o5=document.getElementById("maybebutton");
                var o6=document.getElementById("maybetype");
                if(o3) o3.disabled=false;
                if(o4) o4.disabled=false;
                if(o5) o5.disabled=false;
                o3=document.getElementById("sudokudiv"+i+j);
                if(o3){
                    if(o3.className=="hidden"){
                        if(o6) o6.checked=true;
                        SetShown("maybediv",1);
                    }
                    else{
                        if(o6) o6.checked=false;
                        SetShown("maybediv",0);
                    }
                }
                starttime();
            }
            else{
                o1=document.getElementById("hinttype0");
                if(o1 && o1.checked) SetDisable("hintbutton",true)
                SetDisable("maybetype",true);
                SetDisable("maybebutton",true);
                SetShown("maybediv",0);
            }
        }
    }
    function checktd(i,j){
        var o1=document.getElementById("sudokunum"+i+j);
        var nownum=o1.value;
        var m,n;
        if(nownum!=""){
            if(isNaN(Number(nownum))){
                o1.value="";
                return;
            }
            for(m=0;m<9;m++){
                if(m!=i){
                    checknum(i,j,m,j);
                }
            }
            for(m=0;m<9;m++){
                if(m!=j){
                    checknum(i,j,i,m);
                }
            }
            var xstart=i-i%3;
            var ystart=j-j%3;
            for(m=xstart;m<xstart+3;m++){
                for(n=ystart;n<ystart+3;n++){
                    if(m!=i && n!=j) checknum(i,j,m,n);
                }
            }
            if(sudokuchecks[i][j]=="/"){
                if(document.getElementById("checktype").checked || o1.className=="sudokucheck2" || o1.className=="sudokuerror3"){
                    o1.className="sudokucheck";
                }
                else o1.className="sudokuinput2";
            }
            else{
                switch(o1.className){
                    case "sudokuinput2": o1.className="sudokuerror2";
                        break;
                    case "sudokucheck2": o1.className="sudokuerror3";
                        break;
                }
            }
        }
        else{
            for(m=0;m<9;m++){
                if(m!=i){
                    checknum2(i,j,m,j);
                }
            }
            for(m=0;m<9;m++){
                if(m!=j){
                    checknum2(i,j,i,m);
                }
            }
            var xstart=i-i%3;
            var ystart=j-j%3;
            for(m=xstart;m<xstart+3;m++){
                for(n=ystart;n<ystart+3;n++){
                    if(m!=i && n!=j) checknum2(i,j,m,n);
                }
            }
            sudokuchecks[i][j]="/";
            o1.className="sudokuinput2";
        }
        if(changeflag){
            sudokusteps.length=++nowstep;
            sudokustepcontents.length=nowstep;
            sudokusteps[nowstep-1]=""+i+j;
            sudokustepcontents[nowstep-1]=nownum;
        }
        // checkstep();
    }
    function checknum(i,j,m,n){
    	var o1=document.getElementById("sudokunum"+i+j);
    	var o2=document.getElementById("sudokunum"+m+n);
    	if(o1.value==o2.value){
    		if(sudokuchecks[i][j].indexOf("/"+m+n+"/")==-1) sudokuchecks[i][j]+=""+m+n+"/";
    		if(sudokuchecks[m][n].indexOf("/"+i+j+"/")==-1) sudokuchecks[m][n]+=""+i+j+"/";
    	}
    	else{
    		sudokuchecks[i][j]=sudokuchecks[i][j].replace("/"+m+n+"/","/");
    		sudokuchecks[m][n]=sudokuchecks[m][n].replace("/"+i+j+"/","/");
    	}
    	if(sudokuchecks[m][n]=="/"){
    		switch(o2.className){
    			case "sudokuerror1": o2.className="sudokutitle";
    		    	                  break;
    			case "sudokuerror2": o2.className="sudokuinput";
    			                      break;
    			case "sudokuerror3": o2.className="sudokucheck";
    			                      break;
    		}
    	}
    	else{
    		switch(o2.className){
    			case "sudokutitle": o2.className="sudokuerror1";
    		    	                  break;
    			case "sudokuinput": o2.className="sudokuerror2";
    			                      break;
    			case "sudokucheck": o2.className="sudokuerror3";
    			                      break;
    		}
    	}
    }
    function checknum2(i,j,m,n){
    	var o1=document.getElementById("sudokunum"+i+j);
    	var o2=document.getElementById("sudokunum"+m+n);
    	sudokuchecks[m][n]=sudokuchecks[m][n].replace("/"+i+j+"/","/");
    	if(sudokuchecks[m][n]=="/"){
    		switch(o2.className){
    			case "sudokuerror1": o2.className="sudokutitle";
    		    	                  break;
    			case "sudokuerror2": o2.className="sudokuinput";
    			                      break;
    			case "sudokuerror3": o2.className="sudokucheck";
    			                      break;
    		}
    	}
    	else{
    		switch(o2.className){
    			case "sudokutitle": o2.className="sudokuerror1";
    		    	                  break;
    			case "sudokuinput": o2.className="sudokuerror2";
    			                      break;
    			case "sudokucheck": o2.className="sudokuerror3";
    			                      break;
    		}
    	}
    }
    //TODO 耗时  事实记录
    function printtime(){
        if(timeflag){
            if(timestart==0) timestart=new Date().getTime();
            var timeend=new Date().getTime();
            var totaltime=Math.ceil((timeend-timestart)/1000);
            var minute=Math.floor(totaltime/60);
            var second=totaltime % 60;
            if(minute<10) timestr="0";
            else timestr="";
            timestr+=minute+":";
            if(second<10) timestr+="0";
            timestr+=second;
            SetValue("spendtime",timestr);
            setTimeout("printtime()",1000);
        }
    }


    function load(){
        //获取表格的行数
        var store='0';
        var type = $("#type").val();
        if(type=="标准九宫数独"){
            for(var i=0;i<9;i++)
            { //遍历表格的行
                for(var j=0;j<9;j++)
                { //遍历每行的列
                    var sudokunum =$("#sudokunum"+i+j);
                    var num = sudokunum.val();
                    if(num==""||num==null||num == undefined){
                        num='0';
                    }
                    store +=num;
                }
            }
            return store.substr(1,81);
        }else if(type=="变形九宫数独"){
            for(var i=0;i<9;i++)
            { //遍历表格的行
                for(var j=0;j<9;j++)
                { //遍历每行的列
                    var sudokunum =$("#b9sudokunum"+i+j);
                    var num = sudokunum.val();
                    if(num==""||num==null||num == undefined){
                        num='0';
                    }
                    store +=num;
                }
            }
            return store.substr(1,81);
        } else if(type=="变形六宫数独" ){
            for(var i=0;i<6;i++)
            { //遍历表格的行
                for(var j=0;j<6;j++)
                { //遍历每行的列
                    var b6sudokunum =$("#b6sudokunum"+i+j);
                    var num = b6sudokunum.val();
                    if(num==""||num==null||num == undefined){
                        num='0';
                    }
                    store +=num;
                }
            }
            return store.substr(1,36);
        }else if(type=="标准六宫数独" ){
            // alert("type==\"标准六宫数独\"");
            for(var i=0;i<6;i++)
            { //遍历表格的行
                for(var j=0;j<6;j++)
                { //遍历每行的列
                    var stand6sudokunum =$("#stand6sudokunum"+i+j);
                    var num = stand6sudokunum.val();
                    if(num==""||num==null||num == undefined){
                        num='0';
                    }
                    store +=num;
                }
            }
            return store.substr(1,36);
        }

    }
    //TODO 完成提交按钮触发事件
    function EndSub(){
        var i,j;
        var realname = $("#realname").val();
        var username = $("#username").val();

        if(username==null||realname==null||username==''||realname==''){
            layer.msg("您没有登陆不可提交!", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var timeend=new Date().getTime();
        var totaltime=Math.ceil((timeend-timestart)/1000);
        timeflag=false;
        var hintnum=GetValue('hintnums');
        var type =$("#type").val();
        if(type=="标准九宫数独"){
            // for(i=0;i<9;i++){
            //     for(j=0;j<9;j++){
            //         if(GetValue("sudokunum"+i+j)==""){
            //             alert("您的解答不完全，请填写完全后提交");
            //             timeflag=true;
            //             return;
            //         }
            //         if(sudokuchecks[i][j]!="/"){
            //             alert("您的解答存在错误，请核对后重新提交");
            //             timeflag=true;
            //             return;
            //         }
            //     }
            // }
        }

        // var score=Math.ceil(15*60*2000*(Number(GetValue("nowtype"))+1)/(totaltime*(Math.ceil(hintnum/2)+1)));
        // alert("totaltime"+totaltime);
        var finishSuduko = load();
        // alert(finishSuduko);
        var id=$("#id").val();
        var username=$("#username").val();
        var score =$("#score").val();
        var jsonData = {"sudukoid" : id,"username":username,"totaltime":totaltime,"score":score,"finishSuduko":finishSuduko};
        var loadingIndex=null;
        $.ajax({
            async: true,
            type:"POST",
            data : jsonData,
            url: "${cx}/userscore/upload", //数据URL路径
            beforeSend : function(){
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function(result) {

                layer.close(loadingIndex);
                var shuduPage = result.data;
                var answer = shuduPage.answer;
                var wAr = shuduPage.wAr;
                $("#answer").val(answer);
                // alert(answer);
                // alert(wAr);
                if ( result.success ) {
                    var flag = locksudoku(finishSuduko);
                    // alert(flag);
                    if(flag=="ok"){
                        if(wAr=="wrong"){
                            if(type == "标准九宫数独"){
                                $("#wrong9").html('         <center>\n' +
                        '                                            <table id="wrongtable9 " class="sudoku" cellspacing="0" cellpadding="0" border="0">\n' +
                        '                                                <tbody>\n' +
                        '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku"><div  class="shown1"></div></td><td class="sudoku1"><div  class="shown1"></div></td></tr>\n' +
                        '                                                    <tr><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku2"><div  class="shown1"></div></td><td class="sudoku3"><div  class="shown1"></div></td></tr>\n' +
                        '                                                </tbody>\n' +
                        '                                            </table>\n' +
                                    '                            </center>' +
                                    ' <b style="color: red">真遗憾，这题您没有做对 ,请看正确答案</b>');

                                var ann =$("#wrong9  div");
                                layer.msg("您本题有错误", {time:2000, icon:5, shift:6}, function(){
                                });

                                var numstr=answer;
                                var noo,number;
                                for(var i=0;i<9;i++)
                                {
                                    for(var j=0;j<9;j++){
                                        noo=i*9+j;
                                        number=numstr.substr(noo,1);
                                        ann[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                                    }

                                }
                            } else if(type == "标准六宫数独"){
                                $("#wrong").html('  <center>\n' +
                                    '                                            <table id="wrongtable6" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr></tbody></table>\n' +
                                    '                                        </center>\n' +
                                    '                                        <b style="color: red">真遗憾，这题您没有做对 ,请看正确答案</b>');

                                var ann =$("#wrongtable6 div");
                                layer.msg("您本题有错误", {time:2000, icon:5, shift:6}, function(){
                                });

                                var numstr=answer;
                                var noo,number;
                                for(var i=0;i<6;i++)
                                {
                                    for(var j=0;j<6;j++){
                                        noo=i*6+j;
                                        number=numstr.substr(noo,1);
                                        ann[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                                    }

                                }
                            } else if(type == "变形九宫数独"){

                            } else if(type == "变形六宫数独"){
                                $("#bianwrong6").html('  <center>\n' +
                                    '                                            <table style="margin-left: 800px" cellpadding="0" cellspacing="0" border="0" class="sudoku"><tbody><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr><tr><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku" ><div  class="shown1"></div></td><td class="sudoku1" ><div  class="shown1"></div></td></tr><tr><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku2" ><div  class="shown1"></div></td><td class="sudoku3" ><div  class="shown1"></div></td></tr></tbody></table>\n' +
                                    '                                        </center>\n' +
                                    '                                        <b style="color: red">真遗憾，这题您没有做对 ,请看正确答案</b>');

                                var ann =$("#bianwrong6 div");
                                layer.msg("您本题有错误", {time:2000, icon:5, shift:6}, function(){
                                });
                                var numstr=answer;
                                var noo,number;
                                for(var i=0;i<6;i++)
                                {
                                    for(var j=0;j<6;j++){
                                        noo=i*6+j;
                                        number=numstr.substr(noo,1);
                                        ann[noo].innerHTML= "<input type=\"text\"   value=\""+number+"\" readonly=true />"
                                    }

                                }
                            }


                        }else{
                            layer.msg("您本题正确", {time:2000, icon:6, shift:6}, function(){
                            });
                        }
                    }
                    var sudukourl=  $("#sudukourl").val();
                    window.location.href=sudukourl;
                }else {
                    layer.msg("上传数据失败，请联系网站管理员", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            },
            error:function () {
                layer.msg("上传数据失败，请检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        })
    }


    //完成之后封锁此题
    function locksudoku(finishSuduko){
        var i,j,no,o1,o2,o3,sudokunum;
        var type= $("#type").val();
        if(type=="标准九宫数独"){
            for(i=0;i<9;i++){
                for(j=0;j<9;j++){
                    no=i*9+j;
                    o1=document.getElementById("sudokudiv"+i+j);
                    o2=document.getElementById("sudokumaybe"+i+j);
                    o3=document.getElementById("sudokunum"+i+j);
                    if(o1) o1.className="shown1";
                    if(o2) o2.className="hidden";
                    //字符串中抽取从 start 下标开始的指定数目的字符。
                    sudokunum=finishSuduko.substr(no,1);
                    o1.innerHTML="<input type=\"text\" id=\"sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
                }
            }
        }else if(type=="变形六宫数独"){
            for(i=0;i<6;i++){
                for(j=0;j<6;j++){
                    no=i*6+j;
                    o1=document.getElementById("b6sudokudiv"+i+j);
                    o2=document.getElementById("b6sudokumaybe"+i+j);
                    o3=document.getElementById("b6sudokunum"+i+j);
                    if(o1) o1.className="shown1";
                    if(o2) o2.className="hidden";
                    //字符串中抽取从 start 下标开始的指定数目的字符。
                    sudokunum=finishSuduko.substr(no,1);
                    o1.innerHTML="<input type=\"text\" id=\"b6sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
                }
            }
        }else if(type=="变形九宫数独"){
            for(i=0;i<9;i++){
                for(j=0;j<9;j++){
                    no=i*9+j;
                    o1=document.getElementById("b9sudokudiv"+i+j);
                    o2=document.getElementById("b9sudokumaybe"+i+j);
                    o3=document.getElementById("b9sudokunum"+i+j);
                    if(o1) o1.className="shown1";
                    if(o2) o2.className="hidden";
                    //字符串中抽取从 start 下标开始的指定数目的字符。
                    sudokunum=finishSuduko.substr(no,1);
                    o1.innerHTML="<input type=\"text\" id=\"b9sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
                }
            }

        } else if(type=="标准六宫数独"){
            for(i=0;i<6;i++){
                for(j=0;j<6;j++){
                    no=i*6+j;
                    o1=document.getElementById("stand6sudokudiv"+i+j);
                    o2=document.getElementById("stand6sudokumaybe"+i+j);
                    o3=document.getElementById("stand6sudokunum"+i+j);
                    if(o1) o1.className="shown1";
                    if(o2) o2.className="hidden";
                    //字符串中抽取从 start 下标开始的指定数目的字符。
                    sudokunum=finishSuduko.substr(no,1);
                    o1.innerHTML="<input type=\"text\" id=\"stand6sudokunum"+i+j+"\" maxlength=\"1\" name=\"sudokunum"+i+j+"\" class=\"sudokutitle\" value=\""+sudokunum+"\" readonly=true />"
                }
            }
        }

        SetValue("spendtime","00:00")
        sudokusteps.length=0;
        sudokustepcontents.length=0;
        // window.location.reload();

        return "ok";

    }




</script>