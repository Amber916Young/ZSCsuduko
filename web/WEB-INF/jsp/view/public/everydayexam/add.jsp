<template:user_backend htmlTitle="每日一练" bodyTitle="每日一练">

    <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <link type="text/css"  rel="stylesheet" href="${cx}/resource/static/sudoku/sudoku.css">
    <link type="text/css"  rel="stylesheet" href="${cx}/resource/static/sudoku/main.css">
    <link rel="stylesheet" href="${cx}/resource/static/flatpickr/dist/flatpickr.min.css">
    <style>
        .file-preview{
            width: 80%;
        }
        .file-input {
            width: 80%;
        }
    </style>

    <div class="col-md-12">
    <div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>每日一练</h3>
    </div>
    <div class="panel-body">
        <b style="color: darkred ">由于技术原因，无法动态实现非标准九宫的空白表，所以类似于杀手，连续数独都按照图片上传</b><br>
        <b style="color: #ff5a14 ">除标准九宫可以自动计算外，其余答案要自行输入</b><br>
        <b> </b>

        <br>
        <%--<input type="button" onclick="load()" value="检查" class="btn btn-danger">--%>

        <hr>
        <form  target="target" onsubmit="return load()" class="form-inline"  id="from1" enctype="multipart/form-data" role="form" method="post" action="${cx}/public/suduko/upload" style="display: inline;width: 400px;">
            <div class="form-group has-feedback">
                <div class="input-group">
                    <div class="input-group-addon">题目编号:</div>
                    <input class="flatpickr-input form-control has-success" name="id" type="text" readonly="readonly" id="id">
                </div><br><br>
                <div class="input-group">
                    <div class="input-group-addon">题目类型:</div>
                        <select style=" " onclick="ShiftTable(this)"  id="type" name="type" class="form-control has-success">
                            <option value="标准九宫数独">标准九宫数独</option>
                            <option value="标准六宫数独">标准六宫数独</option>
                            <option value="变形六宫数独">变形六宫数独</option>
                            <option value="变形九宫数独">变形九宫数独</option>
                        </select>
                </div>
                    <br><br>
                <div class="input-group">
                    <div class="input-group-addon">本题难度等级:</div>
                    <table class="table" style="float: right">
                        <tr><th>难度</th><th>等级</th></tr>
                        <tr><td>1</td><td>简单</td></tr>
                        <tr><td>2</td><td>普通</td></tr>
                        <tr><td>3</td><td>中等</td></tr>
                        <tr><td>4</td><td>高级</td></tr>
                        <tr><td>5</td><td>骨灰级</td></tr>
                    </table>
                    <select style=" "  id="difficulty_level" name="difficulty_level" class="form-control has-success">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                </div>
                    <br><br>
                <div class="input-group">
                    <div class="input-group-addon">本题分值:</div>
                    <select style=" "   id="score" name="score" class="form-control has-success">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </div><br><br>
                <div class="input-group">
                        <%--日期事件选择器--%>
                    <div class="input-group-addon">请选择发送时间（定时发送）</div>
                    <input id="date" name="time" class="flatpickr-input form-control has-success" data-enable-time=true data-time_24hr=true readonly="readonly">
                </div><br><br>
                <input type="hidden" value="" id="num" name="num">
                <%--<button type="button" class="btn btn-primary "/>上传题目</button>--%>
                <input  class="btn btn-primary" id="submit" type="submit" value="上传题目"/>
                <div id="stander">

                </div>
            </div>
            <form class="form-inline" role="form" style="width: 400px;float: right;">
                <div id="sudokupart"  class="input-group" style="float: right;width: 50%;">
                    <div style="text-align:center; line-height:20px; vertical-align:middle;"></div>
                </div>
            </form>
        </form>
        <div id="freetable" style="width: 400px;margin-left: 550px;">
        </div>

        <input type="hidden" id="answer6">
        <input type="hidden" id="banswer6">
        <input type="hidden" id="answer9">
        <input type="hidden" id="banswer9">

        <input type="hidden" id="trueOrfalse">
    </div>


</template:user_backend>
<%--<script type="text/javascript" src="${cx}/resource/static/sudoku/function.js"></script>--%>
<script type="text/javascript" src="${cx}/resource/static/sudoku/sudoku.js"></script>
<script type="text/javascript" charset="utf-8"  src="${cx}/resource/static/flatpickr/dist/flatpickr.js"></script>

<script type="text/javascript">


    //设置页面对应的菜单选项
    var ItemId = "Item3_2";
    function ShiftTable(e) {
        var type = e.value;
        if(type=="标准九宫数独"){
            $("#sudokupart").html("   <input type='button' class='btn btn-danger' value='计算答案' id='upload_answer' onclick='get_answer()'><form id=\"sudokuform\" >\n" +
                "                    <center>\n" +
                "                        <table id=\"table\" class=\"sudoku\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n" +
                "                            <tbody>\n" +
                "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv00\" class=\"shown1\"><input type=\"text\" id=\"sudokunum00\" maxlength=\"1\" name=\"sudokunum00\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe00\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv01\" class=\"shown1\"><input type=\"text\" id=\"sudokunum01\" maxlength=\"1\" name=\"sudokunum01\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe01\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv02\" class=\"shown1\"><input type=\"text\" id=\"sudokunum02\" maxlength=\"1\" name=\"sudokunum02\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe02\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv03\" class=\"shown1\"><input type=\"text\" id=\"sudokunum03\" maxlength=\"1\" name=\"sudokunum03\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe03\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv04\" class=\"shown1\"><input type=\"text\" id=\"sudokunum04\" maxlength=\"1\" name=\"sudokunum04\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe04\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv05\" class=\"shown1\"><input type=\"text\" id=\"sudokunum05\" maxlength=\"1\" name=\"sudokunum05\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe05\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv06\" class=\"shown1\"><input type=\"text\" id=\"sudokunum06\" maxlength=\"1\" name=\"sudokunum06\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe06\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv07\" class=\"shown1\"><input type=\"text\" id=\"sudokunum07\" maxlength=\"1\" name=\"sudokunum07\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe07\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv08\" class=\"shown1\"><input type=\"text\" id=\"sudokunum08\" maxlength=\"1\" name=\"sudokunum08\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe08\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv10\" class=\"shown1\"><input type=\"text\" id=\"sudokunum10\" maxlength=\"1\" name=\"sudokunum10\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe10\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv11\" class=\"shown1\"><input type=\"text\" id=\"sudokunum11\" maxlength=\"1\" name=\"sudokunum11\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe11\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv12\" class=\"shown1\"><input type=\"text\" id=\"sudokunum12\" maxlength=\"1\" name=\"sudokunum12\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe12\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv13\" class=\"shown1\"><input type=\"text\" id=\"sudokunum13\" maxlength=\"1\" name=\"sudokunum13\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe13\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv14\" class=\"shown1\"><input type=\"text\" id=\"sudokunum14\" maxlength=\"1\" name=\"sudokunum14\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe14\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv15\" class=\"shown1\"><input type=\"text\" id=\"sudokunum15\" maxlength=\"1\" name=\"sudokunum15\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe15\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv16\" class=\"shown1\"><input type=\"text\" id=\"sudokunum16\" maxlength=\"1\" name=\"sudokunum16\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe16\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv17\" class=\"shown1\"><input type=\"text\" id=\"sudokunum17\" maxlength=\"1\" name=\"sudokunum17\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe17\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv18\" class=\"shown1\"><input type=\"text\" id=\"sudokunum18\" maxlength=\"1\" name=\"sudokunum18\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe18\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku2\" ><div id=\"sudokudiv20\" class=\"shown1\"><input type=\"text\" id=\"sudokunum20\" maxlength=\"1\" name=\"sudokunum20\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe20\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv21\" class=\"shown1\"><input type=\"text\" id=\"sudokunum21\" maxlength=\"1\" name=\"sudokunum21\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe21\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv22\" class=\"shown1\"><input type=\"text\" id=\"sudokunum22\" maxlength=\"1\" name=\"sudokunum22\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe22\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv23\" class=\"shown1\"><input type=\"text\" id=\"sudokunum23\" maxlength=\"1\" name=\"sudokunum23\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe23\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv24\" class=\"shown1\"><input type=\"text\" id=\"sudokunum24\" maxlength=\"1\" name=\"sudokunum24\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe24\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv25\" class=\"shown1\"><input type=\"text\" id=\"sudokunum25\" maxlength=\"1\" name=\"sudokunum25\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe25\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv26\" class=\"shown1\"><input type=\"text\" id=\"sudokunum26\" maxlength=\"1\" name=\"sudokunum26\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe26\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv27\" class=\"shown1\"><input type=\"text\" id=\"sudokunum27\" maxlength=\"1\" name=\"sudokunum27\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe27\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv28\" class=\"shown1\"><input type=\"text\" id=\"sudokunum28\" maxlength=\"1\" name=\"sudokunum28\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe28\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku\"><div id=\"sudokudiv30\" class=\"shown1\"><input type=\"text\" id=\"sudokunum30\" maxlength=\"1\" name=\"sudokunum30\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe30\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv31\" class=\"shown1\"><input type=\"text\" id=\"sudokunum31\" maxlength=\"1\" name=\"sudokunum31\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe31\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv32\" class=\"shown1\"><input type=\"text\" id=\"sudokunum32\" maxlength=\"1\" name=\"sudokunum32\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe32\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv33\" class=\"shown1\"><input type=\"text\" id=\"sudokunum33\" maxlength=\"1\" name=\"sudokunum33\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe33\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv34\" class=\"shown1\"><input type=\"text\" id=\"sudokunum34\" maxlength=\"1\" name=\"sudokunum34\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe34\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv35\" class=\"shown1\"><input type=\"text\" id=\"sudokunum35\" maxlength=\"1\" name=\"sudokunum35\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe35\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv36\" class=\"shown1\"><input type=\"text\" id=\"sudokunum36\" maxlength=\"1\" name=\"sudokunum36\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe36\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv37\" class=\"shown1\"><input type=\"text\" id=\"sudokunum37\" maxlength=\"1\" name=\"sudokunum37\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe37\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv38\" class=\"shown1\"><input type=\"text\" id=\"sudokunum38\" maxlength=\"1\" name=\"sudokunum38\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe38\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv40\" class=\"shown1\"><input type=\"text\" id=\"sudokunum40\" maxlength=\"1\" name=\"sudokunum40\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe40\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv41\" class=\"shown1\"><input type=\"text\" id=\"sudokunum41\" maxlength=\"1\" name=\"sudokunum41\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe41\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv42\" class=\"shown1\"><input type=\"text\" id=\"sudokunum42\" maxlength=\"1\" name=\"sudokunum42\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe42\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv43\" class=\"shown1\"><input type=\"text\" id=\"sudokunum43\" maxlength=\"1\" name=\"sudokunum43\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe43\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv44\" class=\"shown1\"><input type=\"text\" id=\"sudokunum44\" maxlength=\"1\" name=\"sudokunum44\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe44\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv45\" class=\"shown1\"><input type=\"text\" id=\"sudokunum45\" maxlength=\"1\" name=\"sudokunum45\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe45\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv46\" class=\"shown1\"><input type=\"text\" id=\"sudokunum46\" maxlength=\"1\" name=\"sudokunum46\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe46\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv47\" class=\"shown1\"><input type=\"text\" id=\"sudokunum47\" maxlength=\"1\" name=\"sudokunum47\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe47\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv48\" class=\"shown1\"><input type=\"text\" id=\"sudokunum48\" maxlength=\"1\" name=\"sudokunum48\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe48\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku2\" ><div id=\"sudokudiv50\" class=\"shown1\"><input type=\"text\" id=\"sudokunum50\" maxlength=\"1\" name=\"sudokunum50\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe50\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv51\" class=\"shown1\"><input type=\"text\" id=\"sudokunum51\" maxlength=\"1\" name=\"sudokunum51\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe51\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv52\" class=\"shown1\"><input type=\"text\" id=\"sudokunum52\" maxlength=\"1\" name=\"sudokunum52\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe52\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv53\" class=\"shown1\"><input type=\"text\" id=\"sudokunum53\" maxlength=\"1\" name=\"sudokunum53\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe53\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv54\" class=\"shown1\"><input type=\"text\" id=\"sudokunum54\" maxlength=\"1\" name=\"sudokunum54\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe54\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv55\" class=\"shown1\"><input type=\"text\" id=\"sudokunum55\" maxlength=\"1\" name=\"sudokunum55\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe55\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv56\" class=\"shown1\"><input type=\"text\" id=\"sudokunum56\" maxlength=\"1\" name=\"sudokunum56\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe56\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv57\" class=\"shown1\"><input type=\"text\" id=\"sudokunum57\" maxlength=\"1\" name=\"sudokunum57\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe57\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv58\" class=\"shown1\"><input type=\"text\" id=\"sudokunum58\" maxlength=\"1\" name=\"sudokunum58\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe58\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv60\" class=\"shown1\"><input type=\"text\" id=\"sudokunum60\" maxlength=\"1\" name=\"sudokunum60\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe60\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv61\" class=\"shown1\"><input type=\"text\" id=\"sudokunum61\" maxlength=\"1\" name=\"sudokunum61\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe61\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv62\" class=\"shown1\"><input type=\"text\" id=\"sudokunum62\" maxlength=\"1\" name=\"sudokunum62\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe62\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv63\" class=\"shown1\"><input type=\"text\" id=\"sudokunum63\" maxlength=\"1\" name=\"sudokunum63\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe63\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv64\" class=\"shown1\"><input type=\"text\" id=\"sudokunum64\" maxlength=\"1\" name=\"sudokunum64\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe64\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv65\" class=\"shown1\"><input type=\"text\" id=\"sudokunum65\" maxlength=\"1\" name=\"sudokunum65\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe65\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv66\" class=\"shown1\"><input type=\"text\" id=\"sudokunum66\" maxlength=\"1\" name=\"sudokunum66\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe66\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv67\" class=\"shown1\"><input type=\"text\" id=\"sudokunum67\" maxlength=\"1\" name=\"sudokunum67\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe67\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv68\" class=\"shown1\"><input type=\"text\" id=\"sudokunum68\" maxlength=\"1\" name=\"sudokunum68\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe68\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv70\" class=\"shown1\"><input type=\"text\" id=\"sudokunum70\" maxlength=\"1\" name=\"sudokunum70\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe70\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv71\" class=\"shown1\"><input type=\"text\" id=\"sudokunum71\" maxlength=\"1\" name=\"sudokunum71\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe71\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv72\" class=\"shown1\"><input type=\"text\" id=\"sudokunum72\" maxlength=\"1\" name=\"sudokunum72\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe72\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv73\" class=\"shown1\"><input type=\"text\" id=\"sudokunum73\" maxlength=\"1\" name=\"sudokunum73\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe73\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv74\" class=\"shown1\"><input type=\"text\" id=\"sudokunum74\" maxlength=\"1\" name=\"sudokunum74\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe74\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv75\" class=\"shown1\"><input type=\"text\" id=\"sudokunum75\" maxlength=\"1\" name=\"sudokunum75\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe75\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv76\" class=\"shown1\"><input type=\"text\" id=\"sudokunum76\" maxlength=\"1\" name=\"sudokunum76\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe76\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv77\" class=\"shown1\"><input type=\"text\" id=\"sudokunum77\" maxlength=\"1\" name=\"sudokunum77\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe77\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv78\" class=\"shown1\"><input type=\"text\" id=\"sudokunum78\" maxlength=\"1\" name=\"sudokunum78\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe78\" class=\"hidden\"></div></td></tr>\n" +
                "                            <tr><td class=\"sudoku2\" ><div id=\"sudokudiv80\" class=\"shown1\"><input type=\"text\" id=\"sudokunum80\" maxlength=\"1\" name=\"sudokunum80\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe80\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv81\" class=\"shown1\"><input type=\"text\" id=\"sudokunum81\" maxlength=\"1\" name=\"sudokunum81\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe81\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv82\" class=\"shown1\"><input type=\"text\" id=\"sudokunum82\" maxlength=\"1\" name=\"sudokunum82\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe82\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv83\" class=\"shown1\"><input type=\"text\" id=\"sudokunum83\" maxlength=\"1\" name=\"sudokunum83\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe83\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv84\" class=\"shown1\"><input type=\"text\" id=\"sudokunum84\" maxlength=\"1\" name=\"sudokunum84\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe84\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv85\" class=\"shown1\"><input type=\"text\" id=\"sudokunum85\" maxlength=\"1\" name=\"sudokunum85\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe85\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv86\" class=\"shown1\"><input type=\"text\" id=\"sudokunum86\" maxlength=\"1\" name=\"sudokunum86\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe86\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv87\" class=\"shown1\"><input type=\"text\" id=\"sudokunum87\" maxlength=\"1\" name=\"sudokunum87\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe87\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv88\" class=\"shown1\"><input type=\"text\" id=\"sudokunum88\" maxlength=\"1\" name=\"sudokunum88\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe88\" class=\"hidden\"></div></td></tr>\n" +
                "                            </tbody>\n" +
                "                        </table>\n" +
                "                    </center>\n" +
                "                </form>");
            $("#freetable").html("");

        }else if(type =="标准六宫数独"){
            $("#sudokupart").html("      <form id=\"sudokuform\" name=\"sudokuform\"  method=\"post\">\n" +
                "                        <center>\n" +
                "                            <table id=\"table\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"sudoku\"><tbody><tr><td class=\"sudoku\" ><div id=\"sudokudiv00\" class=\"shown1\"><input type=\"text\" id=\"sudokunum00\" maxlength=\"1\" name=\"sudokunum00\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe00\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv01\" class=\"shown1\"><input type=\"text\" id=\"sudokunum01\" maxlength=\"1\" name=\"sudokunum01\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe01\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv02\" class=\"shown1\"><input type=\"text\" id=\"sudokunum02\" maxlength=\"1\" name=\"sudokunum02\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe02\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv03\" class=\"shown1\"><input type=\"text\" id=\"sudokunum03\" maxlength=\"1\" name=\"sudokunum03\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe03\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv04\" class=\"shown1\"><input type=\"text\" id=\"sudokunum04\" maxlength=\"1\" name=\"sudokunum04\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe04\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv05\" class=\"shown1\"><input type=\"text\" id=\"sudokunum05\" maxlength=\"1\" name=\"sudokunum05\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe05\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv10\" class=\"shown1\"><input type=\"text\" id=\"sudokunum10\" maxlength=\"1\" name=\"sudokunum10\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe10\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv11\" class=\"shown1\"><input type=\"text\" id=\"sudokunum11\" maxlength=\"1\" name=\"sudokunum11\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe11\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv12\" class=\"shown1\"><input type=\"text\" id=\"sudokunum12\" maxlength=\"1\" name=\"sudokunum12\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe12\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv13\" class=\"shown1\"><input type=\"text\" id=\"sudokunum13\" maxlength=\"1\" name=\"sudokunum13\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe13\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv14\" class=\"shown1\"><input type=\"text\" id=\"sudokunum14\" maxlength=\"1\" name=\"sudokunum14\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe14\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv15\" class=\"shown1\"><input type=\"text\" id=\"sudokunum15\" maxlength=\"1\" name=\"sudokunum15\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe15\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku\" ><div id=\"sudokudiv20\" class=\"shown1\"><input type=\"text\" id=\"sudokunum20\" maxlength=\"1\" name=\"sudokunum20\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe20\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv21\" class=\"shown1\"><input type=\"text\" id=\"sudokunum21\" maxlength=\"1\" name=\"sudokunum21\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe21\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv22\" class=\"shown1\"><input type=\"text\" id=\"sudokunum22\" maxlength=\"1\" name=\"sudokunum22\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe22\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv23\" class=\"shown1\"><input type=\"text\" id=\"sudokunum23\" maxlength=\"1\" name=\"sudokunum23\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe23\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv24\" class=\"shown1\"><input type=\"text\" id=\"sudokunum24\" maxlength=\"1\" name=\"sudokunum24\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe24\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv25\" class=\"shown1\"><input type=\"text\" id=\"sudokunum25\" maxlength=\"1\" name=\"sudokunum25\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe25\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv30\" class=\"shown1\"><input type=\"text\" id=\"sudokunum30\" maxlength=\"1\" name=\"sudokunum30\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe30\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv31\" class=\"shown1\"><input type=\"text\" id=\"sudokunum31\" maxlength=\"1\" name=\"sudokunum31\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe31\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv32\" class=\"shown1\"><input type=\"text\" id=\"sudokunum32\" maxlength=\"1\" name=\"sudokunum32\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe32\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv33\" class=\"shown1\"><input type=\"text\" id=\"sudokunum33\" maxlength=\"1\" name=\"sudokunum33\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe33\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv34\" class=\"shown1\"><input type=\"text\" id=\"sudokunum34\" maxlength=\"1\" name=\"sudokunum34\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe34\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv35\" class=\"shown1\"><input type=\"text\" id=\"sudokunum35\" maxlength=\"1\" name=\"sudokunum35\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe35\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku\" ><div id=\"sudokudiv40\" class=\"shown1\"><input type=\"text\" id=\"sudokunum40\" maxlength=\"1\" name=\"sudokunum40\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe40\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv41\" class=\"shown1\"><input type=\"text\" id=\"sudokunum41\" maxlength=\"1\" name=\"sudokunum41\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe41\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv42\" class=\"shown1\"><input type=\"text\" id=\"sudokunum42\" maxlength=\"1\" name=\"sudokunum42\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe42\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv43\" class=\"shown1\"><input type=\"text\" id=\"sudokunum43\" maxlength=\"1\" name=\"sudokunum43\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe43\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv44\" class=\"shown1\"><input type=\"text\" id=\"sudokunum44\" maxlength=\"1\" name=\"sudokunum44\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe44\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv45\" class=\"shown1\"><input type=\"text\" id=\"sudokunum45\" maxlength=\"1\" name=\"sudokunum45\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe45\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv50\" class=\"shown1\"><input type=\"text\" id=\"sudokunum50\" maxlength=\"1\" name=\"sudokunum50\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe50\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv51\" class=\"shown1\"><input type=\"text\" id=\"sudokunum51\" maxlength=\"1\" name=\"sudokunum51\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe51\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv52\" class=\"shown1\"><input type=\"text\" id=\"sudokunum52\" maxlength=\"1\" name=\"sudokunum52\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe52\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv53\" class=\"shown1\"><input type=\"text\" id=\"sudokunum53\" maxlength=\"1\" name=\"sudokunum53\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe53\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv54\" class=\"shown1\"><input type=\"text\" id=\"sudokunum54\" maxlength=\"1\" name=\"sudokunum54\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe54\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv55\" class=\"shown1\"><input type=\"text\" id=\"sudokunum55\" maxlength=\"1\" name=\"sudokunum55\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe55\" class=\"hidden\"></div></td></tr></tbody></table>\n" +
                "                        </center>\n" +
                "                    </form>\n");
            $("#freetable").html("       <b style=\"color: #ff3557;margin-left: 90px\">此处输入答案</b>\n" +
                "            <button class=\"btn btn-info\" id='upload_answer' onclick=\"upload_answer()\">上传答案</button>    " +
                "<form id=\"sudokuform\" name=\"sudokuform\"  method=\"post\">\n" +
                "                        <center>\n" +
                "                            <table id=\"table\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"sudoku\"><tbody><tr><td class=\"sudoku\" ><div id=\"sudokudiv00\" class=\"shown1\"><input type=\"text\" id=\"sudokunum00\" maxlength=\"1\" name=\"sudokunum00\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe00\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv01\" class=\"shown1\"><input type=\"text\" id=\"sudokunum01\" maxlength=\"1\" name=\"sudokunum01\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe01\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv02\" class=\"shown1\"><input type=\"text\" id=\"sudokunum02\" maxlength=\"1\" name=\"sudokunum02\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe02\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv03\" class=\"shown1\"><input type=\"text\" id=\"sudokunum03\" maxlength=\"1\" name=\"sudokunum03\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe03\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv04\" class=\"shown1\"><input type=\"text\" id=\"sudokunum04\" maxlength=\"1\" name=\"sudokunum04\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe04\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv05\" class=\"shown1\"><input type=\"text\" id=\"sudokunum05\" maxlength=\"1\" name=\"sudokunum05\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe05\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv10\" class=\"shown1\"><input type=\"text\" id=\"sudokunum10\" maxlength=\"1\" name=\"sudokunum10\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe10\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv11\" class=\"shown1\"><input type=\"text\" id=\"sudokunum11\" maxlength=\"1\" name=\"sudokunum11\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe11\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv12\" class=\"shown1\"><input type=\"text\" id=\"sudokunum12\" maxlength=\"1\" name=\"sudokunum12\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe12\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv13\" class=\"shown1\"><input type=\"text\" id=\"sudokunum13\" maxlength=\"1\" name=\"sudokunum13\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe13\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv14\" class=\"shown1\"><input type=\"text\" id=\"sudokunum14\" maxlength=\"1\" name=\"sudokunum14\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe14\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv15\" class=\"shown1\"><input type=\"text\" id=\"sudokunum15\" maxlength=\"1\" name=\"sudokunum15\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe15\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku\" ><div id=\"sudokudiv20\" class=\"shown1\"><input type=\"text\" id=\"sudokunum20\" maxlength=\"1\" name=\"sudokunum20\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe20\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv21\" class=\"shown1\"><input type=\"text\" id=\"sudokunum21\" maxlength=\"1\" name=\"sudokunum21\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe21\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv22\" class=\"shown1\"><input type=\"text\" id=\"sudokunum22\" maxlength=\"1\" name=\"sudokunum22\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe22\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv23\" class=\"shown1\"><input type=\"text\" id=\"sudokunum23\" maxlength=\"1\" name=\"sudokunum23\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe23\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv24\" class=\"shown1\"><input type=\"text\" id=\"sudokunum24\" maxlength=\"1\" name=\"sudokunum24\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe24\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv25\" class=\"shown1\"><input type=\"text\" id=\"sudokunum25\" maxlength=\"1\" name=\"sudokunum25\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe25\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv30\" class=\"shown1\"><input type=\"text\" id=\"sudokunum30\" maxlength=\"1\" name=\"sudokunum30\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe30\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv31\" class=\"shown1\"><input type=\"text\" id=\"sudokunum31\" maxlength=\"1\" name=\"sudokunum31\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe31\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv32\" class=\"shown1\"><input type=\"text\" id=\"sudokunum32\" maxlength=\"1\" name=\"sudokunum32\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe32\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv33\" class=\"shown1\"><input type=\"text\" id=\"sudokunum33\" maxlength=\"1\" name=\"sudokunum33\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe33\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv34\" class=\"shown1\"><input type=\"text\" id=\"sudokunum34\" maxlength=\"1\" name=\"sudokunum34\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe34\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv35\" class=\"shown1\"><input type=\"text\" id=\"sudokunum35\" maxlength=\"1\" name=\"sudokunum35\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe35\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku\" ><div id=\"sudokudiv40\" class=\"shown1\"><input type=\"text\" id=\"sudokunum40\" maxlength=\"1\" name=\"sudokunum40\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe40\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv41\" class=\"shown1\"><input type=\"text\" id=\"sudokunum41\" maxlength=\"1\" name=\"sudokunum41\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe41\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv42\" class=\"shown1\"><input type=\"text\" id=\"sudokunum42\" maxlength=\"1\" name=\"sudokunum42\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe42\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv43\" class=\"shown1\"><input type=\"text\" id=\"sudokunum43\" maxlength=\"1\" name=\"sudokunum43\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe43\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv44\" class=\"shown1\"><input type=\"text\" id=\"sudokunum44\" maxlength=\"1\" name=\"sudokunum44\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe44\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv45\" class=\"shown1\"><input type=\"text\" id=\"sudokunum45\" maxlength=\"1\" name=\"sudokunum45\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe45\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv50\" class=\"shown1\"><input type=\"text\" id=\"sudokunum50\" maxlength=\"1\" name=\"sudokunum50\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe50\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv51\" class=\"shown1\"><input type=\"text\" id=\"sudokunum51\" maxlength=\"1\" name=\"sudokunum51\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe51\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv52\" class=\"shown1\"><input type=\"text\" id=\"sudokunum52\" maxlength=\"1\" name=\"sudokunum52\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe52\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv53\" class=\"shown1\"><input type=\"text\" id=\"sudokunum53\" maxlength=\"1\" name=\"sudokunum53\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe53\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv54\" class=\"shown1\"><input type=\"text\" id=\"sudokunum54\" maxlength=\"1\" name=\"sudokunum54\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe54\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv55\" class=\"shown1\"><input type=\"text\" id=\"sudokunum55\" maxlength=\"1\" name=\"sudokunum55\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe55\" class=\"hidden\"></div></td></tr></tbody></table>\n" +
                "                        </center>\n" +
                "                    </form>\n");
        }else{
            $("#sudokupart").html(" <input  id=\"file-select\"  type=\"file\" name=\"file\"  accept=\"image/*\"  multiple />\n");
            <!-- 文件上传组件属性设置 -->
            $('#file-select').fileinput({
                language: 'zh', //中文
                <%--uploadUrl: '${cx}/public/suduko/uploadPic', //上传路径--%>
                // 'elErrorContainer': '#errorBlock',
                showUpload: false, //是否显示上传文本框里的上传按钮
                // showRemove: false, //是否显示上传文本框里的移除按钮
                // dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
                maxFileCount: 1, //表示允许同时上传的最大文件个数
                enctype: 'multipart/form-data',
                allowedFileTypes: ['image'],//配置允许文件上传的类型
                allowedPreviewTypes: ['image'],//配置所有的被预览文件类型
                allowedPreviewMimeTypes: ['jpg', 'png', 'gif']//控制被预览的所有mime类型

            });
            if(type=="变形六宫数独"){
                $("#freetable").html("       <b style=\"color: #ff3557;margin-left: 90px\">此处输入答案</b>\n" +
                    "            <button class=\"btn btn-info\" id='upload_answer' onclick=\"upload_answer()\">上传答案</button>    " +
                    "<form id=\"sudokuform\" name=\"sudokuform\"  method=\"post\">\n" +
                    "                        <center>\n" +
                    "                            <table id=\"table\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"sudoku\"><tbody><tr><td class=\"sudoku\" ><div id=\"sudokudiv00\" class=\"shown1\"><input type=\"text\" id=\"sudokunum00\" maxlength=\"1\" name=\"sudokunum00\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe00\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv01\" class=\"shown1\"><input type=\"text\" id=\"sudokunum01\" maxlength=\"1\" name=\"sudokunum01\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe01\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv02\" class=\"shown1\"><input type=\"text\" id=\"sudokunum02\" maxlength=\"1\" name=\"sudokunum02\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe02\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv03\" class=\"shown1\"><input type=\"text\" id=\"sudokunum03\" maxlength=\"1\" name=\"sudokunum03\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe03\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv04\" class=\"shown1\"><input type=\"text\" id=\"sudokunum04\" maxlength=\"1\" name=\"sudokunum04\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe04\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv05\" class=\"shown1\"><input type=\"text\" id=\"sudokunum05\" maxlength=\"1\" name=\"sudokunum05\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe05\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv10\" class=\"shown1\"><input type=\"text\" id=\"sudokunum10\" maxlength=\"1\" name=\"sudokunum10\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe10\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv11\" class=\"shown1\"><input type=\"text\" id=\"sudokunum11\" maxlength=\"1\" name=\"sudokunum11\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe11\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv12\" class=\"shown1\"><input type=\"text\" id=\"sudokunum12\" maxlength=\"1\" name=\"sudokunum12\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe12\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv13\" class=\"shown1\"><input type=\"text\" id=\"sudokunum13\" maxlength=\"1\" name=\"sudokunum13\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe13\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv14\" class=\"shown1\"><input type=\"text\" id=\"sudokunum14\" maxlength=\"1\" name=\"sudokunum14\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe14\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv15\" class=\"shown1\"><input type=\"text\" id=\"sudokunum15\" maxlength=\"1\" name=\"sudokunum15\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe15\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku\" ><div id=\"sudokudiv20\" class=\"shown1\"><input type=\"text\" id=\"sudokunum20\" maxlength=\"1\" name=\"sudokunum20\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe20\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv21\" class=\"shown1\"><input type=\"text\" id=\"sudokunum21\" maxlength=\"1\" name=\"sudokunum21\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe21\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv22\" class=\"shown1\"><input type=\"text\" id=\"sudokunum22\" maxlength=\"1\" name=\"sudokunum22\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe22\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv23\" class=\"shown1\"><input type=\"text\" id=\"sudokunum23\" maxlength=\"1\" name=\"sudokunum23\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe23\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv24\" class=\"shown1\"><input type=\"text\" id=\"sudokunum24\" maxlength=\"1\" name=\"sudokunum24\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe24\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv25\" class=\"shown1\"><input type=\"text\" id=\"sudokunum25\" maxlength=\"1\" name=\"sudokunum25\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe25\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv30\" class=\"shown1\"><input type=\"text\" id=\"sudokunum30\" maxlength=\"1\" name=\"sudokunum30\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe30\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv31\" class=\"shown1\"><input type=\"text\" id=\"sudokunum31\" maxlength=\"1\" name=\"sudokunum31\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe31\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv32\" class=\"shown1\"><input type=\"text\" id=\"sudokunum32\" maxlength=\"1\" name=\"sudokunum32\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe32\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv33\" class=\"shown1\"><input type=\"text\" id=\"sudokunum33\" maxlength=\"1\" name=\"sudokunum33\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe33\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv34\" class=\"shown1\"><input type=\"text\" id=\"sudokunum34\" maxlength=\"1\" name=\"sudokunum34\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe34\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv35\" class=\"shown1\"><input type=\"text\" id=\"sudokunum35\" maxlength=\"1\" name=\"sudokunum35\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe35\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku\" ><div id=\"sudokudiv40\" class=\"shown1\"><input type=\"text\" id=\"sudokunum40\" maxlength=\"1\" name=\"sudokunum40\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe40\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv41\" class=\"shown1\"><input type=\"text\" id=\"sudokunum41\" maxlength=\"1\" name=\"sudokunum41\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe41\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv42\" class=\"shown1\"><input type=\"text\" id=\"sudokunum42\" maxlength=\"1\" name=\"sudokunum42\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe42\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv43\" class=\"shown1\"><input type=\"text\" id=\"sudokunum43\" maxlength=\"1\" name=\"sudokunum43\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe43\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv44\" class=\"shown1\"><input type=\"text\" id=\"sudokunum44\" maxlength=\"1\" name=\"sudokunum44\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe44\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv45\" class=\"shown1\"><input type=\"text\" id=\"sudokunum45\" maxlength=\"1\" name=\"sudokunum45\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe45\" class=\"hidden\"></div></td></tr><tr><td class=\"sudoku2\" ><div id=\"sudokudiv50\" class=\"shown1\"><input type=\"text\" id=\"sudokunum50\" maxlength=\"1\" name=\"sudokunum50\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe50\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv51\" class=\"shown1\"><input type=\"text\" id=\"sudokunum51\" maxlength=\"1\" name=\"sudokunum51\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe51\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv52\" class=\"shown1\"><input type=\"text\" id=\"sudokunum52\" maxlength=\"1\" name=\"sudokunum52\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe52\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv53\" class=\"shown1\"><input type=\"text\" id=\"sudokunum53\" maxlength=\"1\" name=\"sudokunum53\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe53\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv54\" class=\"shown1\"><input type=\"text\" id=\"sudokunum54\" maxlength=\"1\" name=\"sudokunum54\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe54\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv55\" class=\"shown1\"><input type=\"text\" id=\"sudokunum55\" maxlength=\"1\" name=\"sudokunum55\" class=\"sudokuinput\" ></div><div id=\"sudokumaybe55\" class=\"hidden\"></div></td></tr></tbody></table>\n" +
                    "                        </center>\n" +
                    "                    </form>\n");
            }else{
                $("#freetable").html("<b style=\"color: #ff3557;margin-left: 90px\">此处输入答案</b><button id='upload_answer' class=\"btn btn-info\" onclick=\"upload_answer()\">上传答案</button>  " +
                    "   <form id=\"sudokuform\" >\n" +
                    "                    <center>\n" +
                    "                        <table id=\"table\" class=\"sudoku\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n" +
                    "                            <tbody>\n" +
                    "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv00\" class=\"shown1\"><input type=\"text\" id=\"sudokunum00\" maxlength=\"1\" name=\"sudokunum00\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe00\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv01\" class=\"shown1\"><input type=\"text\" id=\"sudokunum01\" maxlength=\"1\" name=\"sudokunum01\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe01\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv02\" class=\"shown1\"><input type=\"text\" id=\"sudokunum02\" maxlength=\"1\" name=\"sudokunum02\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe02\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv03\" class=\"shown1\"><input type=\"text\" id=\"sudokunum03\" maxlength=\"1\" name=\"sudokunum03\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe03\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv04\" class=\"shown1\"><input type=\"text\" id=\"sudokunum04\" maxlength=\"1\" name=\"sudokunum04\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe04\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv05\" class=\"shown1\"><input type=\"text\" id=\"sudokunum05\" maxlength=\"1\" name=\"sudokunum05\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe05\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv06\" class=\"shown1\"><input type=\"text\" id=\"sudokunum06\" maxlength=\"1\" name=\"sudokunum06\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe06\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv07\" class=\"shown1\"><input type=\"text\" id=\"sudokunum07\" maxlength=\"1\" name=\"sudokunum07\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe07\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv08\" class=\"shown1\"><input type=\"text\" id=\"sudokunum08\" maxlength=\"1\" name=\"sudokunum08\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe08\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv10\" class=\"shown1\"><input type=\"text\" id=\"sudokunum10\" maxlength=\"1\" name=\"sudokunum10\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe10\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv11\" class=\"shown1\"><input type=\"text\" id=\"sudokunum11\" maxlength=\"1\" name=\"sudokunum11\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe11\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv12\" class=\"shown1\"><input type=\"text\" id=\"sudokunum12\" maxlength=\"1\" name=\"sudokunum12\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe12\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv13\" class=\"shown1\"><input type=\"text\" id=\"sudokunum13\" maxlength=\"1\" name=\"sudokunum13\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe13\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv14\" class=\"shown1\"><input type=\"text\" id=\"sudokunum14\" maxlength=\"1\" name=\"sudokunum14\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe14\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv15\" class=\"shown1\"><input type=\"text\" id=\"sudokunum15\" maxlength=\"1\" name=\"sudokunum15\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe15\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv16\" class=\"shown1\"><input type=\"text\" id=\"sudokunum16\" maxlength=\"1\" name=\"sudokunum16\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe16\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv17\" class=\"shown1\"><input type=\"text\" id=\"sudokunum17\" maxlength=\"1\" name=\"sudokunum17\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe17\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv18\" class=\"shown1\"><input type=\"text\" id=\"sudokunum18\" maxlength=\"1\" name=\"sudokunum18\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe18\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku2\" ><div id=\"sudokudiv20\" class=\"shown1\"><input type=\"text\" id=\"sudokunum20\" maxlength=\"1\" name=\"sudokunum20\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe20\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv21\" class=\"shown1\"><input type=\"text\" id=\"sudokunum21\" maxlength=\"1\" name=\"sudokunum21\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe21\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv22\" class=\"shown1\"><input type=\"text\" id=\"sudokunum22\" maxlength=\"1\" name=\"sudokunum22\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe22\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv23\" class=\"shown1\"><input type=\"text\" id=\"sudokunum23\" maxlength=\"1\" name=\"sudokunum23\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe23\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv24\" class=\"shown1\"><input type=\"text\" id=\"sudokunum24\" maxlength=\"1\" name=\"sudokunum24\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe24\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv25\" class=\"shown1\"><input type=\"text\" id=\"sudokunum25\" maxlength=\"1\" name=\"sudokunum25\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe25\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv26\" class=\"shown1\"><input type=\"text\" id=\"sudokunum26\" maxlength=\"1\" name=\"sudokunum26\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe26\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv27\" class=\"shown1\"><input type=\"text\" id=\"sudokunum27\" maxlength=\"1\" name=\"sudokunum27\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe27\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv28\" class=\"shown1\"><input type=\"text\" id=\"sudokunum28\" maxlength=\"1\" name=\"sudokunum28\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe28\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku\"><div id=\"sudokudiv30\" class=\"shown1\"><input type=\"text\" id=\"sudokunum30\" maxlength=\"1\" name=\"sudokunum30\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe30\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv31\" class=\"shown1\"><input type=\"text\" id=\"sudokunum31\" maxlength=\"1\" name=\"sudokunum31\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe31\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv32\" class=\"shown1\"><input type=\"text\" id=\"sudokunum32\" maxlength=\"1\" name=\"sudokunum32\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe32\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv33\" class=\"shown1\"><input type=\"text\" id=\"sudokunum33\" maxlength=\"1\" name=\"sudokunum33\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe33\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv34\" class=\"shown1\"><input type=\"text\" id=\"sudokunum34\" maxlength=\"1\" name=\"sudokunum34\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe34\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv35\" class=\"shown1\"><input type=\"text\" id=\"sudokunum35\" maxlength=\"1\" name=\"sudokunum35\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe35\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv36\" class=\"shown1\"><input type=\"text\" id=\"sudokunum36\" maxlength=\"1\" name=\"sudokunum36\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe36\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv37\" class=\"shown1\"><input type=\"text\" id=\"sudokunum37\" maxlength=\"1\" name=\"sudokunum37\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe37\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv38\" class=\"shown1\"><input type=\"text\" id=\"sudokunum38\" maxlength=\"1\" name=\"sudokunum38\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe38\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv40\" class=\"shown1\"><input type=\"text\" id=\"sudokunum40\" maxlength=\"1\" name=\"sudokunum40\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe40\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv41\" class=\"shown1\"><input type=\"text\" id=\"sudokunum41\" maxlength=\"1\" name=\"sudokunum41\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe41\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv42\" class=\"shown1\"><input type=\"text\" id=\"sudokunum42\" maxlength=\"1\" name=\"sudokunum42\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe42\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv43\" class=\"shown1\"><input type=\"text\" id=\"sudokunum43\" maxlength=\"1\" name=\"sudokunum43\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe43\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv44\" class=\"shown1\"><input type=\"text\" id=\"sudokunum44\" maxlength=\"1\" name=\"sudokunum44\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe44\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv45\" class=\"shown1\"><input type=\"text\" id=\"sudokunum45\" maxlength=\"1\" name=\"sudokunum45\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe45\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv46\" class=\"shown1\"><input type=\"text\" id=\"sudokunum46\" maxlength=\"1\" name=\"sudokunum46\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe46\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv47\" class=\"shown1\"><input type=\"text\" id=\"sudokunum47\" maxlength=\"1\" name=\"sudokunum47\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe47\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv48\" class=\"shown1\"><input type=\"text\" id=\"sudokunum48\" maxlength=\"1\" name=\"sudokunum48\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe48\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku2\" ><div id=\"sudokudiv50\" class=\"shown1\"><input type=\"text\" id=\"sudokunum50\" maxlength=\"1\" name=\"sudokunum50\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe50\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv51\" class=\"shown1\"><input type=\"text\" id=\"sudokunum51\" maxlength=\"1\" name=\"sudokunum51\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe51\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv52\" class=\"shown1\"><input type=\"text\" id=\"sudokunum52\" maxlength=\"1\" name=\"sudokunum52\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe52\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv53\" class=\"shown1\"><input type=\"text\" id=\"sudokunum53\" maxlength=\"1\" name=\"sudokunum53\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe53\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv54\" class=\"shown1\"><input type=\"text\" id=\"sudokunum54\" maxlength=\"1\" name=\"sudokunum54\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe54\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv55\" class=\"shown1\"><input type=\"text\" id=\"sudokunum55\" maxlength=\"1\" name=\"sudokunum55\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe55\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv56\" class=\"shown1\"><input type=\"text\" id=\"sudokunum56\" maxlength=\"1\" name=\"sudokunum56\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe56\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv57\" class=\"shown1\"><input type=\"text\" id=\"sudokunum57\" maxlength=\"1\" name=\"sudokunum57\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe57\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv58\" class=\"shown1\"><input type=\"text\" id=\"sudokunum58\" maxlength=\"1\" name=\"sudokunum58\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe58\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv60\" class=\"shown1\"><input type=\"text\" id=\"sudokunum60\" maxlength=\"1\" name=\"sudokunum60\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe60\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv61\" class=\"shown1\"><input type=\"text\" id=\"sudokunum61\" maxlength=\"1\" name=\"sudokunum61\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe61\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv62\" class=\"shown1\"><input type=\"text\" id=\"sudokunum62\" maxlength=\"1\" name=\"sudokunum62\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe62\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv63\" class=\"shown1\"><input type=\"text\" id=\"sudokunum63\" maxlength=\"1\" name=\"sudokunum63\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe63\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv64\" class=\"shown1\"><input type=\"text\" id=\"sudokunum64\" maxlength=\"1\" name=\"sudokunum64\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe64\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv65\" class=\"shown1\"><input type=\"text\" id=\"sudokunum65\" maxlength=\"1\" name=\"sudokunum65\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe65\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv66\" class=\"shown1\"><input type=\"text\" id=\"sudokunum66\" maxlength=\"1\" name=\"sudokunum66\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe66\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv67\" class=\"shown1\"><input type=\"text\" id=\"sudokunum67\" maxlength=\"1\" name=\"sudokunum67\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe67\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv68\" class=\"shown1\"><input type=\"text\" id=\"sudokunum68\" maxlength=\"1\" name=\"sudokunum68\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe68\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku\" ><div id=\"sudokudiv70\" class=\"shown1\"><input type=\"text\" id=\"sudokunum70\" maxlength=\"1\" name=\"sudokunum70\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe70\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv71\" class=\"shown1\"><input type=\"text\" id=\"sudokunum71\" maxlength=\"1\" name=\"sudokunum71\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe71\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv72\" class=\"shown1\"><input type=\"text\" id=\"sudokunum72\" maxlength=\"1\" name=\"sudokunum72\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe72\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv73\" class=\"shown1\"><input type=\"text\" id=\"sudokunum73\" maxlength=\"1\" name=\"sudokunum73\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe73\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv74\" class=\"shown1\"><input type=\"text\" id=\"sudokunum74\" maxlength=\"1\" name=\"sudokunum74\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe74\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv75\" class=\"shown1\"><input type=\"text\" id=\"sudokunum75\" maxlength=\"1\" name=\"sudokunum75\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe75\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv76\" class=\"shown1\"><input type=\"text\" id=\"sudokunum76\" maxlength=\"1\" name=\"sudokunum76\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe76\" class=\"hidden\"></div></td><td class=\"sudoku\" ><div id=\"sudokudiv77\" class=\"shown1\"><input type=\"text\" id=\"sudokunum77\" maxlength=\"1\" name=\"sudokunum77\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe77\" class=\"hidden\"></div></td><td class=\"sudoku1\" ><div id=\"sudokudiv78\" class=\"shown1\"><input type=\"text\" id=\"sudokunum78\" maxlength=\"1\" name=\"sudokunum78\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe78\" class=\"hidden\"></div></td></tr>\n" +
                    "                            <tr><td class=\"sudoku2\" ><div id=\"sudokudiv80\" class=\"shown1\"><input type=\"text\" id=\"sudokunum80\" maxlength=\"1\" name=\"sudokunum80\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe80\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv81\" class=\"shown1\"><input type=\"text\" id=\"sudokunum81\" maxlength=\"1\" name=\"sudokunum81\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe81\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv82\" class=\"shown1\"><input type=\"text\" id=\"sudokunum82\" maxlength=\"1\" name=\"sudokunum82\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe82\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv83\" class=\"shown1\"><input type=\"text\" id=\"sudokunum83\" maxlength=\"1\" name=\"sudokunum83\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe83\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv84\" class=\"shown1\"><input type=\"text\" id=\"sudokunum84\" maxlength=\"1\" name=\"sudokunum84\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe84\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv85\" class=\"shown1\"><input type=\"text\" id=\"sudokunum85\" maxlength=\"1\" name=\"sudokunum85\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe85\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv86\" class=\"shown1\"><input type=\"text\" id=\"sudokunum86\" maxlength=\"1\" name=\"sudokunum86\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe86\" class=\"hidden\"></div></td><td class=\"sudoku2\" ><div id=\"sudokudiv87\" class=\"shown1\"><input type=\"text\" id=\"sudokunum87\" maxlength=\"1\" name=\"sudokunum87\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe87\" class=\"hidden\"></div></td><td class=\"sudoku3\" ><div id=\"sudokudiv88\" class=\"shown1\"><input type=\"text\" id=\"sudokunum88\" maxlength=\"1\" name=\"sudokunum88\" class=\"sudokuinput\" value=\"\" ></div><div id=\"sudokumaybe88\" class=\"hidden\"></div></td></tr>\n" +
                    "                            </tbody>\n" +
                    "                        </table>\n" +
                    "                    </center>\n" +
                    "                </form>");
            }

        }

        var id = createRandom2(1,10000000);
        $("#id").attr("value",id)
    }


    function load(){
        //获取表格的行数
        // var store='0';
        // for(var i=0;i<9;i++)
        // { //遍历表格的行
        //      for(var j=0;j<9;j++)
        //      { //遍历每行的列
        //          var sudokunum =$("#sudokunum"+i+j);
        //          var num = sudokunum.val();
        //          if(num==""||num==null||num == undefined){
        //              num='0';
        //          }
        //          store +=num;
        //      }
        // }
        // alert(store);

        var banswer9=$("#banswer9").val();
        var answer6 = $("#answer6").val();

        var score=$("#score").val();
        var difficulty_level=$("#difficulty_level").val();
        // alert("difficulty_level"+difficulty_level);
        var type=$("#type").val();
        var date=$("#date").val();

        if(type=="标准九宫数独"){

            $("#stander").html("<input   id=\"file\"  type=\"file\"  name=\"file\"  accept=\"image/*\"  multiple  style=\"visibility:hidden\"/>\n");
        }if(type=="标准六宫数独"){
            var store='0';
            for(var i=0;i<6;i++)
            { //遍历表格的行
                for(var j=0;j<6;j++)
                { //遍历每行的列
                    var sudokunum =$("#sudokunum"+i+j);
                    var num = sudokunum.val();
                    if(num==""||num==null||num == undefined){
                        num='0';
                    }
                    store +=num;
                }
            }
            $("#num").attr("value",store.substr(1,36));
            $("#stander").html("<input   id=\"file\"  type=\"file\"  name=\"file\"  accept=\"image/*\"  multiple  style=\"visibility:hidden\"/>\n");

        }
        if (date==""){
            layer.msg("定时发送时间还没有确认", {time:2000, icon:5, shift:6}, function(){
            });
            return false;
        }
        if (store==""){
            layer.msg("数独部分获取为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return false;
        }
        if (difficulty_level==""){
            layer.msg("难度等级不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return false;
        }
        if (score==""){
            layer.msg("分数不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return false;
        }
        if (type==""){
            layer.msg("数独类型不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return false;
        }


        var torf=$("#trueOrfalse").val();
        if(torf=="wrong"){
            return false;
        }
        // upload(store.substr(1,81));

    }
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

    
    function upload(sum) {
        var score=$("#score").val();
        var difficulty_level=$("#difficulty_level").val();
        // alert("difficulty_level"+difficulty_level);
        var type=$("#type").val();
        var date=$("#date").val();
        if (date==""){
            layer.msg("定时发送时间还没有确认", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if (sum==""){
            layer.msg("题目不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if (difficulty_level==""){
            layer.msg("难度等级不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if (score==""){
            layer.msg("分数不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        if (type==""){
            layer.msg("数独类型不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var loadingIndex=null;

        var flag = {};
        flag["sum"] = sum;
        flag["difficulty_level"]=difficulty_level;
        flag["score"]=score;
        flag["type"]=type;
        flag["date"] = date;
        flag["date"] = date;

        // alert("sum="+sum);
        var json = JSON.stringify(flag);
        $.ajax({
            async: true,
            method:"POST",
            url:"${cx}/public/suduko/upload",
            data:json,
            contentType: 'application/json',
            dataType: "json",
            cache: false,
            beforeSend : function() {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                alert(result.success);
                if(result.success){
                    layer.msg("上传成功", {time:3000, icon:6}, function(){
                    });
                    window.location.href = "${cx}/public/suduko";
                }else {
                    layer.msg("添加失败", {time: 2000, icon: 5, shift: 6}, function () {
                    });
                }
            },
            error:function () {
                layer.msg("ajax请求失败，请检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        })
    }

    $(function () {

        <!-- 文件上传组件属性设置 -->
        <%--$('#file-select').fileinput({--%>
            <%--language: 'zh', //中文--%>
            <%--&lt;%&ndash;uploadUrl: '${cx}/home/uploadAttachement', //上传路径&ndash;%&gt;--%>
            <%--// 'elErrorContainer': '#errorBlock',--%>
            <%--// showUpload: false, //是否显示上传文本框里的上传按钮--%>
            <%--// showRemove: false, //是否显示上传文本框里的移除按钮--%>
            <%--// dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域--%>
            <%--maxFileCount: 1, //表示允许同时上传的最大文件个数--%>
            <%--enctype: 'multipart/form-data',--%>
            <%--allowedFileTypes: ['image'],//配置允许文件上传的类型--%>
            <%--allowedPreviewTypes: ['image'],//配置所有的被预览文件类型--%>
            <%--allowedPreviewMimeTypes: ['jpg', 'png', 'gif']//控制被预览的所有mime类型--%>
        <%--});--%>
        $(".flatpickr").flatpickr();
        $("#date").flatpickr({
            minDate: "today",
            enableTime: true
        });

    });

//////////////////////////////////////////////////////////////////////////

    function upload_answer() {
        var id=$("#id").val();
        var aaa=$("#freetable :input");
        var store='0';
        var answer;
        var type=$("#type").val();
        var ans =  null;
        if(type=="变形六宫数独"){
            for(var i=1;i<=36;i++)
            { //遍历表格的行
                //遍历每行的列
                var num = aaa[i].value;
                // alert(num);
                if(num==""||num==null||num == undefined){
                    num='0';
                }
                store +=num;

                // alert(store);
            }
            answer=store.substr(1,36);
            $("#banswer6").attr("value",answer);
            ans =  $("#banswer6").val();
        }else if(type=="标准六宫数独"){
            for(var i=1;i<=36;i++)
            { //遍历表格的行
                //遍历每行的列
                var num = aaa[i].value;
                if(num==""||num==null||num == undefined){
                    num='0';
                }
                store +=num;
            }
            answer=store.substr(1,36);
            $("#answer6").attr("value",answer);
            ans =  $("#answer6").val();
        } else{
            for(var i=1;i<=81;i++)
            { //遍历表格的行
                //遍历每行的列
                var num = aaa[i].value;
                // alert(num);
                if(num==""||num==null||num == undefined){
                    num='0';
                }
                store +=num;

                // alert(store);
            }
            answer=store.substr(1,81);
            $("#banswer9").attr("value",answer);
            ans =  $("#banswer9").val();
        }




        if (ans==""){
            layer.msg("数独答案不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
            });
            return false;
        }
        alert(answer);
        var flag = {};
        flag["answer"] = answer;
        flag["id"] = id;
        var json = JSON.stringify(flag);
        $.ajax({
            async: true,
            method:"POST",
            url:"${cx}/public/suduko/anwserupload",
            data:json,
            contentType: 'application/json',
            dataType: "text",
            cache: false,
            success:function (result) {
                if(result=="ok"){
                    layer.msg("添加成功", {time: 2000, icon: 6, shift: 6}, function () {
                        $("#trueOrfalse").attr("value","true");
                        $("#upload_answer").attr('disabled',true);


                    });
                }else {
                    layer.msg("添加失败", {time: 2000, icon: 5, shift: 6}, function () {
                    });
                }
            },
            error:function (result, XMLHttpRequest, textStatus, errorThrown) {
                alert(result);
                layer.msg("ajax请求失败，请检查网络", {time:2000, icon:5, shift:6}, function(){
                });
            }
        })

    }

    //clear all the input
    function clc() {
        var aaa=$("#sudokupart :input");
        for (var i = 0; i < 81; i++) {
            aaa[i].value = "";
            aaa[i].style.color = 'blue';
        }
    }

    //press "show answer" button and show answer then
    function get_answer() {
        var store='0';
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
        $("#num").attr("value",store.substr(1,81));
        $("#banswer9").attr("value",store.substr(1,81));
        var banwers9=$("#banswer9").val();
        alert(banwers9);
        var ann=$("#sudokupart input[type=text]");


        var id=$("#id").val();
        var answer;
        var bool = check_input();
        if (bool) {
        var grid = readAPuzzle();
        if (!isValidGrid(grid)) {
            alert("Invalid input, please try again!");
            $("#trueOrfalse").attr("value","wrong");
        } else {
            if (search(grid)) {
                output_ans();

                var store='0';
                for(var i=0;i<81;i++)
                { //遍历表格的行
                    //遍历每行的列
                    var num = ann[i].value;
                    if(num==""){
                        num=0;
                    }
                    store +=num;

                }
                answer=store.substr(1,81)
                alert(answer);

                var flag = {};
                flag["answer"] = answer;
                flag["id"] = id;
                var json = JSON.stringify(flag);
                $.ajax({
                    async: true,
                    method:"POST",
                    url:"${cx}/public/suduko/anwserupload",
                    data:json,
                    contentType: 'application/json',
                    dataType: "text",
                    cache: false,
                    success:function (result) {
                        if(result=="ok"){
                            layer.msg("添加成功", {time: 2000, icon: 6, shift: 6}, function () {
                                $("#trueOrfalse").attr("value","true");
                                $("#upload_answer").attr('disabled',true);
                            });
                        }else {
                            layer.msg("添加失败", {time: 2000, icon: 5, shift: 6}, function () {
                                $("#trueOrfalse").attr("value","wrong");
                            });
                        }
                    },
                    error:function () {
                        layer.msg("ajax请求失败，请检查网络", {time:2000, icon:5, shift:6}, function(){
                            $("#trueOrfalse").attr("value","wrong");
                        });
                    }
                })
            }
            else {
                $("#trueOrfalse").attr("value","wrong");
                alert("Found no solution!");
            }
        }
        }
    }

    //check if the input are valid
    function check_input() {
        var arr = new Array();
        var ann=$("#sudokupart input[type=text]");

        for (var i = 0; i < 81; i++) {
            // Number(document.getElementsByTagName("input")[i].value);
            arr[i] = ann[i].value;
            // alert(arr[i]);
            if (isNaN(arr[i])) {
                alert('Input should be any number between 1 and 9 !');
                $("#trueOrfalse").attr("value","wrong");
                return false
            }
        }

        if (arr.every(function isZero(x) {
            return x == 0
        })) {
            alert('There is no input!');
            $("#trueOrfalse").attr("value","wrong");
            return false
        }

        return true
    }


    //read a puzzle from the web page
    function readAPuzzle() {
        var arr = new Array();
        var aaa=$("#sudokupart input[type=text]");
        for (var i = 0; i < 81; i++) {
            arr[i] = Number(aaa[i].value);
        }

        var grid = new Array();
        for (var i = 0; i < 9; i++) {
            grid[i] = new Array();
            for (var j = 0; j < 9; j++) {
                grid[i][j] = 0;
            }
        }


        for (var i = 0; i < 81; i++) {
            grid[Math.floor(i / 9)][i % 9] = arr[i];
        }

        return grid
    }

    //Obtain a list of free cells from the puzzle
    function getFreeCellList(grid) {
        var freeCellList = new Array();
        index = 0;

        for (var i = 0; i < 9; i++) {
            for (var j = 0; j < 9; j++) {
                if (grid[i][j] == 0) {
                    freeCellList[index] = new Array(i, j);
                    index++;
                }
            }
        }

        return freeCellList
    }

    //Check whether grid[i][j] is valid in the grid
    function isValid(i, j, grid) {
        //Check whether grid[i][j] is valid at the i's row
        for (var column = 0; column < 9; column++) {
            if ((column != j) && (grid[i][column] == grid[i][j])) {
                return false
            }
        }

        //Check whether grid[i][j] is valid at the j's column
        for (var row = 0; row < 9; row++) {
            if ((row != i) && (grid[row][j] == grid[i][j])) {
                return false
            }
        }

        //Check whether grid[i][j] is valid at the 3-by-3 box
        for (var row = Math.floor(i / 3) * 3; row < Math.floor(i / 3) * 3 + 3; row++) {

            for (var col = Math.floor(j / 3) * 3; col < Math.floor(j / 3) * 3 + 3; col++) {
                if ((row != i) && (col != j) && (grid[row][col] == grid[i][j])) {
                    return false
                }
            }
        }

        return true //The current value at grid[i][j] is valid
    }




    //Check whether the fixed cells are valid in the grid
    function isValidGrid(grid) {
        for (var i = 0; i < 9; i++) {
            for (var j = 0; j < 9; j++) {
                if ((grid[i][j] < 0) || (grid[i][j] > 9) || ((grid[i][j] != 0) && (!isValid(i, j, grid)))) {
                    return false
                }
            }
        }
        return true
    }

    //Search for a solution
    function search(grid) {
        // alert(grid);
        var freeCellList = getFreeCellList(grid);
        // alert("freeCellList"+freeCellList);

        var numberOfFreeCells = freeCellList.length;
        // alert(numberOfFreeCells);

        if (numberOfFreeCells == 0) {
            return true
        }

        var k = 0;  //Start from the first free cell

        while (true) {
            var i = freeCellList[k][0];
            var j = freeCellList[k][1];
            if (grid[i][j] == 0) {
                grid[i][j] = 1;
            }

            if (isValid(i, j, grid)) {
                if (k + 1 == numberOfFreeCells) {
                    //no more free cells
                    return true  //A solution is found
                }
                else {
                    //Move to the next free cell
                    k++;
                }
            }
            else {
                if (grid[i][j] < 9) {
                    //Fill the free cell with the next possible value
                    grid[i][j]++;
                }

                else {
                    //grid[i][j] is 9,backtrack
                    while (grid[i][j] == 9) {
                        if (k == 0) {
                            return false  //No possible value
                        }
                        grid[i][j] = 0;  //Reset to free cell
                        k--;  //Backtrack to the preceding free cell
                        i = freeCellList[k][0];
                        j = freeCellList[k][1];

                    }
                    //Fill the free cell with the next possible value
                    //search continues from this free cell at k
                    grid[i][j]++;
                }
            }
        }

        return true  //A solution is found
    }

    //output the answer on the web page
    function output_ans() {
        var grid = readAPuzzle();
        var grid_original = readAPuzzle();
        var aaa=$("#sudokupart input[type=text]");

        if (search(grid)) {
            for (var i = 0; i < 81; i++) {
                if (grid[Math.floor(i / 9)][i % 9] != grid_original[Math.floor(i / 9)][i % 9]) {
                    aaa[i].value = grid[Math.floor(i / 9)][i % 9];
                    aaa[i].style.color = 'black';
                }
            }
        }

    }

</script>
