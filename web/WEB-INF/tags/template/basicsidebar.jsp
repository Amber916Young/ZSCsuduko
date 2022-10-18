<%--
  Created by IntelliJ IDEA.
  User: 杨叶佳
  Date: 2019/3/8
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 主体内容 -->
<style type="text/css">
    #bul li{

        height:3em;
        line-height:3em;
        text-align:center;

    }
    #bul{
        list-style-type:none;
        background-color: #ffc043;
        height:3em;
        text-align:center;
        padding: 0;
    }
</style>


<div class="main-left" style="padding-top: 4em">
    <input type="hidden" value="${information}" id="infor">
    <div>
        <ul class="sidebar-menu" id="bul">
            <li >协会资讯</li>
            <li  id="ItemId1">
                <a href="${cx}/clubinformation/basicinformation " id="a1">
                    <i class="fa fa-dashboard"></i> <span>基本资料</span>
                </a>
            </li>
            <li  id="ItemId2" >
                <a href="${cx}/clubinformation/constitution" id="a2">
                    <i class="fa fa-files-o"></i>
                    <span>组织章程</span>
                </a>
            </li>
            <li id="ItemId3">
                <a href="${cx}/clubinformation/functions"  id="a3">
                    <i class="fa fa-th"></i> <span>部门职能</span>
                </a>
            </li>
            <li id="ItemId4">
                <a href="${cx}/clubinformation/memberlist" id="a4">
                    <i class="fa fa-th"></i> <span>会员列表</span>
                </a>
            </li>
            <li id="ItemId5">
                <a href="${cx}/clubinformation/applymembership" id="a5">
                    <i class="fa fa-th"></i> <span>入会申请</span>
                </a>
            </li>
        </ul>
    </div>


</div>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${cx}/resource/static/assets/jquery/jquery-2.1.4.min.js"></script>
<script>
    $(function () {
       var info = $("#infor").val();
       var ItemId1 = $("#ItemId1");
       var ItemId2 = $("#ItemId2");
       var ItemId3 = $("#ItemId3");
       var ItemId4 = $("#ItemId4");
       var ItemId5 = $("#ItemId5");
       if(info==1){
           ItemId1.css("background-color","#eaafa0");
           $("#a1").css("color","black");
       }else if(info==2){
           ItemId2.css("background-color","#eab0ad");
           $("#a2").css("color","black");
       }else if(info==3){
           ItemId3.css("background-color","#eac3b0");
           $("#a3").css("color","black");
       }else if(info==4){
           ItemId4.css("background-color","#eab2bc");
           $("#a4").css("color","black");
       }else if(info==5){
           ItemId5.css("background-color","#eaa8d0");
           $("#a5").css("color","black");
       }
    });
</script>




