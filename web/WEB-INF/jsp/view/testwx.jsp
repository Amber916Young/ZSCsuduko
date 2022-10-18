<%@ page import="jee.support.wx.WxUtil" %>
<%@ page import="java.util.Map" %>
  Created by IntelliJ IDEA.
  User: amber
  Date: 2019/12/22
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${cx}/resource/static/share/css/share.min.css">
    <style>
        .row{padding: 20px 0 0 20px}
        .row-pad{padding: 20px 0 0 60px}
    </style>
</head>
<body>
<div class="row-pad">
    <h1>test</h1>
</div>


<ol>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="social-share" data-sites="weibo, qq, qzone"></div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="share-component" data-disabled="wechat , facebook, twitter, google"></div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="social-share"></div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="social-share" data-initialized="true">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<a href="#" class="social-share-icon icon-weibo"></a>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<a href="#" class="social-share-icon icon-qq"></a>&ndash;%&gt;--%>
            <%--&lt;%&ndash;<a href="#" class="social-share-icon icon-qzone"></a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="social-share" data-mode="prepend">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<a href="javascript:" class="social-share-icon icon-heart"></a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div id="share-1"></div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>

    <%--<li class="row">--%>
        <%--<div id="share-2"></div>--%>
    <%--</li>--%>



    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div id="share-3" data-sites="weibo, qq, qzone"></div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<li class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div id="share-4" data-disabled="wechat , facebook, twitter, google"></div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
</ol>
<div id="social-share" ></div>

<%
    //签名
    String url = request.getScheme()+"://";
    url+=request.getHeader("host");
    url+=request.getRequestURI();
    if(request.getQueryString()!=null){
        url+="?"+request.getQueryString();
    }

    Map<String,String> sign = WxUtil.getSign(url);
    String timestamp = sign.get("timestamp");
    String nonceStr = sign.get("nonceStr");
    String jsapi_ticket = sign.get("jsapi_ticket");
    String signature = sign.get("signature");
//String url = sign.get("url");
//    out.print(sign);

%>
<div class="fl">分享到：</div>
<div onclick="shareTo('qzone')">
    <img src="http://zixuephp.net/static/images/qqzoneshare.png" width="30">
</div>
<div onclick="shareTo('qq')">
    <img src="http://zixuephp.net/static/images/qqshare.png" width="32">
</div>
<div onclick="shareTo('sina')">
    <img src="http://zixuephp.net/static/images/sinaweiboshare.png" width="36">
</div>
<div onclick="shareTo('wechat')">
    <img src="http://zixuephp.net/static/images/wechatshare.png"  width="32">
</div>

<script src="http://apps.bdimg.com/libs/jquery/1.8.2/jquery.js"></script>
<%--<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>--%>
<script src="${cx}/resource/static/share/js/jquery.share.min.js"></script>
<script type="text/javascript">
    function shareTo(stype) {
        var ftit = '';
        var flink = '';
        var lk = '';
        //获取文章标题
        ftit = $('.pctitle').text();
        //获取网页中内容的第一张图片
        flink = $('.pcdetails img').eq(0).attr('src');
        if (typeof flink == 'undefined') {
            flink = '';
        }
        //当内容中没有图片时，设置分享图片为网站logo
        if (flink == '') {
            lk = 'http://' + window.location.host + '/static/images/logo.png';
        }
        //如果是上传的图片则进行绝对路径拼接
        if (flink.indexOf('/uploads/') != -1) {
            lk = 'http://' + window.location.host + flink;
        }
        //百度编辑器自带图片获取
        if (flink.indexOf('ueditor') != -1) {
            lk = flink;
        }
        //qq空间接口的传参
        if (stype == 'qzone') {
            window.open('https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=' + document.location.href + '?sharesource=qzone&title=' + ftit + '&pics=' + lk + '&summary=' + document.querySelector('meta[name="description"]').getAttribute('content'));
        }
        //新浪微博接口的传参
        if (stype == 'sina') {
            window.open('http://service.weibo.com/share/share.php?url=' + document.location.href + '?sharesource=weibo&title=' + ftit + '&pic=' + lk + '&appkey=2706825840');
        }
        //qq好友接口的传参
        if (stype == 'qq') {
            window.open('http://connect.qq.com/widget/shareqq/index.html?url=' + document.location.href + '?sharesource=qzone&title=' + ftit + '&pics=' + lk + '&summary=' + document.querySelector('meta[name="description"]').getAttribute('content') + '&desc=php自学网，一个web开发交流的网站');
        }
        //生成二维码给微信扫描分享
        if (stype == 'wechat') {
            window.open('inc/qrcode_img.php?url=http://zixuephp.net/article-1.html');
        }
    }

    $(function () {
        // $('#share-1').share();
        // $('#share-2').share({
        //     sites: ['qzone', 'qq', 'weibo','wechat',
        //
        //     ]});
        // $('#share-3').share();
        // $('#share-4').share();

        var config = {
            url                 : '', // 网址，默认使用 window.location.href
            source              : '', // 来源（QQ空间会用到）, 默认读取head标签：<meta name="site" content="http://overtrue" />
            // title               : '', // 标题，默认读取 document.title 或者 <meta name="title" content="share.js" />
            origin              : '', // 分享 @ 相关 twitter 账号
            // description         : '', // 描述, 默认读取head标签：<meta name="description" content="PHP弱类型的实现原理分析" />
            image               : '', // 图片, 默认取网页中第一个img标签
            sites               : ['qzone', 'qq', 'weibo','wechat'], // 启用的站点
            // disabled            : ['google', 'facebook', 'twitter'], // 禁用的站点
            title               : '234',
            description         : '123',
            wechatQrcodeTitle   : "微信扫一扫：享", // 微信二维码提示文字
            wechatQrcodeHelper  : '<p>微信里点“???”，扫一下</p><p>二维码便可将本文分享至朋友圈。</p>',
        };

        $("#social-share").share(config);
        // $("#share-2").share('.social-share-cs',$config);

    });

    wx.config({
        debug: false,
        appId: <%="'"+WxUtil.APPID+"'"%>,
        timestamp: <%="'"+timestamp+"'"%>,
        nonceStr: <%="'"+nonceStr+"'"%>,
        signature: <%="'"+signature+"'"%>,
        jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'] // 功能列表，我们要使用JS-SDK的什么功能
    });
    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在 页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready 函数中。
    wx.ready(function(){
        // 获取"分享到朋友圈"按钮点击状态及自定义分享内容接口
        wx.onMenuShareTimeline({
            title: '慧锐通电子书架', // 分享标题
            link: 'http://www.wrtrd.net/book/',
            imgUrl: 'http://www.wrtrd.net/book/images/wxbook.jpg' ,// 分享图标
            success: function () {
                alert( "成功");
            }

        });


        // 获取"分享给朋友"按钮点击状态及自定义分享内容接口
        wx.onMenuShareAppMessage({
            title: '慧锐通电子书架', // 分享标题
            desc: '慧锐通产品介绍的电子画册，含数字对讲、模拟对讲、云对讲、智能互联、蓝牙门禁等系统！', // 分享描述
            link: 'http://www.wrtrd.net/book/',
            imgUrl: 'http://www.wrtrd.net/book/images/wxbook.jpg', // 分享图标
            type: 'link' // 分享类型,music、video或link，不填默认为link
        });


        //获取"分享到QQ"按钮点击状态及自定义分享内容接口
        wx.onMenuShareQQ({
            title: '慧锐通电子书架', // 分享标题
            desc: '慧锐通产品介绍的电子画册，含数字对讲、模拟对讲、云对讲、智能互联、蓝牙门禁等系统！', // 分享描述
            link: 'http://www.wrtrd.net/book/', // 分享链接
            imgUrl: 'http://www.wrtrd.net/book/images/wxbook.jpg' // 分享图标
        });


        //获取"分享到腾讯微博"按钮点击状态及自定义分享内容接口
        wx.onMenuShareWeibo({
            title: '慧锐通电子书架', // 分享标题
            desc: '慧锐通产品介绍的电子画册，含数字对讲、模拟对讲、云对讲、智能互联、蓝牙门禁等系统！', // 分享描述
            link: 'http://www.wrtrd.net/book/', // 分享链接
            imgUrl: 'http://www.wrtrd.net/book/images/wxbook.jpg' // 分享图标
        });


        //获取"分享到QQ空间"按钮点击状态及自定义分享内容接口
        wx.onMenuShareQZone({
            title: '慧锐通电子书架', // 分享标题
            desc: '慧锐通产品介绍的电子画册，含数字对讲、模拟对讲、云对讲、智能互联、蓝牙门禁等系统！', // 分享描述
            link: 'http://www.wrtrd.net/book/', // 分享链接
            imgUrl: 'http://www.wrtrd.net/book/images/wxbook.jpg' // 分享图标
        });
        wx.error(function(res){
            // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
            alert("errorMSG:"+res);
        });
    });
    $(function () {
        var setting = {
            async: {
                enable: true,
                url:"${cx}/permission/loadData",
                autoParam:["id", "name=n", "level=lv"]
            },
            //当前展现方式
            view: {
                selectedMulti: false,
                //用户自定义的控件
                addDiyDom: function(treeId, treeNode){
                    var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                    }

                },
                //鼠标放上去就可以看到图标
                addHoverDom: function(treeId, treeNode){
                    var aObj = $("#" + treeNode.tId + "_a");
                    aObj.attr("href", "javascript:;");
                    if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                    var s = '<span id="btnGroup'+treeNode.tId+'">';
                    if ( treeNode.level == 0 ) {
                        s += '<a  onclick="addNode('+treeNode.id+')" href="#" ></a>';
                    } else if ( treeNode.level == 1 ) {
                        s += '<a   onclick="editNode('+treeNode.id+')" href="#" title="修改权限信息"></a>';
                        if (treeNode.children.length == 0) {
                            s += '<a  onclick="deleteNode('+treeNode.id+')" href="#" ></a>';
                        }
                        s += '<a  onclick="addNode('+treeNode.id+')" href="#" ></a>';
                    } else if ( treeNode.level == 2 ) {
                        s += '<a   onclick="editNode('+treeNode.id+')" href="#" title="修改权限信息"></a>';
                        s += '<a  onclick="deleteNode('+treeNode.id+')" href="#"></a>';
                    }
                    s += '</span>';
                    aObj.after(s);
                },
                removeHoverDom: function(treeId, treeNode){
                    $("#btnGroup"+treeNode.tId).remove();
                }
            }
        };
        /*
        var zNodes =[
            { name:"父节点1 - 展开11111", open:true,
                children: [
                    { name:"父节点11 - 折叠",
                        children: [
                            { name:"叶子节点111"},
                            { name:"叶子节点112"},
                            { name:"叶子节点113"},
                            { name:"叶子节点114"}
                        ]},
                    { name:"父节点12 - 折叠",
                        children: [
                            { name:"叶子节点121"},
                            { name:"叶子节点122"},
                            { name:"叶子节点123"},
                            { name:"叶子节点124"}
                        ]},
                    { name:"父节点13 - 没有子节点", isParent:true}
                ]},
            { name:"父节点2 - 折叠",
                children: [
                    { name:"父节点21 - 展开", open:true,
                        children: [
                            { name:"叶子节点211"},
                            { name:"叶子节点212"},
                            { name:"叶子节点213"},
                            { name:"叶子节点214"}
                        ]},
                    { name:"父节点22 - 折叠",
                        children: [
                            { name:"叶子节点221"},
                            { name:"叶子节点222"},
                            { name:"叶子节点223"},
                            { name:"叶子节点224"}
                        ]},
                    { name:"父节点23 - 折叠",
                        children: [
                            { name:"叶子节点231"},
                            { name:"叶子节点232"},
                            { name:"叶子节点233"},
                            { name:"叶子节点234"}
                        ]}
                ]},
            { name:"父节点3 - 没有子节点", isParent:true}

        ];
        */
        // 异步获取树形结构数据
        $.fn.zTree.init($("#permissionTree"), setting);
    });
</script>
</body>
</html>
