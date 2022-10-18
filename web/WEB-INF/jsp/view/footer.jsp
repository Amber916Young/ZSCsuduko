<%--
  Created by IntelliJ IDEA.
  User: 杨叶佳
  Date: 2019/2/11
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>

<style >
    ul{
        list-style: none;
    }

    .footerinner ul li a{
        text-decoration: none;
        color: white;
    }
    .footerinner ul li a:hover{
        color: greenyellow;
    }

    input{
        border:none;
        outline:none;
        font-family: "微软雅黑";
        font-weight: 100;
    }
    img{
        outline: none;
        border:none;
    }
    .share{
        /*width: 300px;*/
        margin:0 auto;
        overflow: hidden;
    }
    .share li{
        float: left;
        height: 50px;
        padding:5px 14px;
    }
    .share li img{
        width: 40px;
        height: 40px;
        cursor: pointer;
        border-radius: 20px;

    }

    .code_wrap{
        position: absolute;
        left:60%;
        top:-235px;
        margin-left: -600px;
        width:900px;
        z-index:-1;
    }
    .code{
        width: 100%;
        overflow: hidden;
        position: relative;
    }
    .code li{
        float: left;
        width: 200px;
        height:240px;
    }
    .code li img{
        width: 200px;
        /*height:240px;*/

        display: none;
    }

    .code li img.weibo{

        position: absolute;
        left: 180px;
    }
    .code li img.qq{
        position: absolute;
        left: 250px;

    }
    .code li img.twitter{
        position: absolute;
        left:320px;
    }
    .code li img.wechat{
        position:absolute;
        left:390px;
    }
    .footerinner{
        /*height: 100%;*/
        margin:0 auto;
        position: relative;
    }
    .footerinfoTop{
        margin:10px 0;
    }
    .footerinfoTop p{
        line-height: 22px;
    }
    .footerinfoBottom{
        font-size: 12px;
    }
    .footerinfoBottom .min{
        font-size:12px;
    }
    .info{
        color: white;
    }
    #footimage img{
        width: 2em;
    }
    #footimage a{
           color: white;
       }
    #footimage a:hover{
        color: #de7c3b;
    }
</style>
<footer class="navbar navbar-default " id="footer-bar" style="display: block;width:100%;position:relative; border-radius: 0px;border:0; background-color: #424242;margin-bottom: 0">


    <div class="footerinfo">
        <div class="footerinfoTop" style="margin-left: 50%">
            <ul class="share" >
                <%--<li>--%>
                    <%--<img class="weibo_icon" src="${cx}/resource/static/img/share1.png" alt="">--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<img class="qq_icon" src="${cx}/resource/static/img/share2.png" alt="">--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<img class="twitter_icon" src="${cx}/resource/static/img/share3.png" alt="">--%>
                <%--</li>--%>
                <li>
                    <img style="text-align: center" class="wechat_icon" src="${cx}/resource/static/img/share4.png" alt="">
                </li>
            </ul>
            <div class="code_wrap">
                <ul class="code">
                    <%--<li><img class="weibo" src="${cx}/resource/static/img/社团二维码.jpg" alt=""></li>--%>
                    <%--<li><img class="qq" src="${cx}/resource/static/img/社团二维码.jpg" alt=""></li>--%>
                    <%--<li><img class="twitter" src="${cx}/resource/static/img/社团二维码.jpg" alt=""></li>--%>
                    <li><img class="wechat" src="${cx}/resource/static/img/社团二维码.jpg" alt=""></li>
                </ul>
            </div>
        </div>
        <div class="footerinfoBottom">

        </div>
    </div>
        <div class="footerinner" style=";margin-top: 20px">
            <ul style="margin-left: 35%; font-size: 14px;margin-top:10px ;font-family:  Helvetica, Arial, sans-serif">
                <%--<li>--%>
                <%--联系我们：&nbsp;<a href="javascript:void(0)" onMouseout="hideImg()" onmouseover="showImg()">微信</a>--%>
                <%--<div id="wxImg" style="display:none;height: 50px;background: #f00;position: absolute;"><img width="200px" src="${cx}/resource/static/img/社团二维码.jpg"></div>--%>
                <%--</li>--%>

                <li class="info">
                    相关网站：
                    <a href="https://www.oubk.com/">欧泊科数独</a>
                    <span style="color: white;border:1px solid #f1f1f1;height:10px;margin-left: 10px;margin-right: 10px"></span>
                    <a href="http://cn.sudokupuzzle.org/">免费在线数独游戏</a>
                    <span style="color: white;border:1px solid #f1f1f1;height:10px;margin-left: 10px;margin-right: 10px"></span>
                    <a href="https://www.sudokukingdom.com/">sudokukingdom</a>

                </li>
                <li class="info">
                    实用工具：
                    <a href="http://llang.net/sudoku/calsudoku.html">数独求解器</a>
                </li>
                <li class="info">
                    我们的邮箱：
                    <a href="mailto:ZSCShuduClub@163.com">ZSCShuduClub@163.com</a>
                </li>
                <li class="info" >
                    <img src="${cx}/resource/static/index_image/beian.png" style="width: 2em">
                    备案号：
                    <a href="http://www.beian.miit.gov.cn" >粤ICP备19160048号-1</a>

                </li>
            </ul>

        </div>


    <hr style="margin-bottom:10px ;border: 1px solid #8e8f8c">
    <div class="text-center info" style="font-size: 12px">
        &copy;2019-2020 ZSCSUDOKU 电子科技大学中山学院数独运动协会 版权所有
        <br>
    </div>
    <div class="text-center info " id="footimage" style="font-size: 12px">
        建议使用1920*1080分辨率浏览
        <br>
        建议浏览器：<img src="${cx}/resource/static/index_image/Chrome.png"><a href="https://www.google.cn/intl/zh-CN/chrome/">谷歌Google Chrome</a>，<img src="${cx}/resource/static/index_image/firefox.png"><a href="http://www.firefox.com.cn/">火狐firefox</a>，<img src="${cx}/resource/static/index_image/edge.png"><a href="https://www.microsoft.com/en-us/windows/microsoft-edge">Microsoft Edge</a>
        <br><br><br>
    </div>
</footer>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${cx}/resource/static/assets/jquery/jquery-2.1.4.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="${cx}/resource/static/assets/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
    // function showImg() {
    //     document.getElementById("wxImg").style.display="block";
    // }
    // function hideImg() {
    //     document.getElementById("wxImg").style.display="none";
    // }

    /*底部二维码*/
    $(function () {
        $(".weibo_icon").hover(function(){
            $(".weibo").fadeIn(500);
            $(".qq,.twitter,.wechat").fadeOut(0);
            $(".code_wrap").css("z-index",200);
        },function(){
            $(".weibo").fadeOut(0);
            $(".code_wrap").css("z-index",-1);
        });

        $(".qq_icon").hover(function(){
            $(".qq").fadeIn(500);
            $(".weibo,.twitter,.wechat").fadeOut(0);
            $(".code_wrap").css("z-index",200);
        },function(){
            $(".qq").fadeOut(0);
            $(".code_wrap").css("z-index",-1);
        });
        $(".twitter_icon").hover(function(){
            $(".twitter").fadeIn(500);
            $(".weibo,.qq,.wechat").fadeOut(0);
            $(".code_wrap").css("z-index",200);
        },function(){
            $(".twitter").fadeOut(0);
            $(".code_wrap").css("z-index",-1);
        });
        $(".wechat_icon").hover(function(){
            $(".wechat").fadeIn(500);
            $(".weibo,.qq,.twitter").fadeOut(0);
            $(".code_wrap").css("z-index",200);
        },function(){
            $(".wechat").fadeOut(0);
            $(".code_wrap").css("z-index",-1);
        });
        $(".weibo,.twitter,.wechat").hover(function(){
            $(this).fadeIn(0);
            $(".code_wrap").css("z-index",200);
        },function(){
            $(this).fadeOut(500);
            $(".code_wrap").css("z-index",-1);
        });
    })




</script>