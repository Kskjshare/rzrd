<%-- 
    Document   : download
    Created on : 2018-7-23, 15:25:01
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>抚州市智慧政协履职服务平台APP下载</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="apple-touch-icon" href="touch-icon-iphone.png" />
        <style>
            h1{font-size: 42px;color: #b71b00 ;text-indent: 10%}
            div{text-align: center;margin: 170px 0 50px 0;}
            p{text-align: center; padding-top: 5%; padding-bottom: 10%; padding-left: 10%; padding-right: 10%;font-size: 30px;}
            span{color: #b71b00}
        </style>
    </head>
    <body>
        <h1>抚州市智慧政协履职服务平台APP下载</h1>
        <div><a href="/upfile/app/apk/RuzhouApp.apk" download="履职系统"><img src="css/limg/android.png" alt=""/></a></div>
        <p>如使用微信扫描<span>暂不支持直接下载</span>,您需要点击微信右上角图标后选择浏览器打开,建议选择系统自带浏览器。</p>
        <script src="js/jquery.min.js"></script>
        <script>
            function is_weixn() {
                var ua = navigator.userAgent.toLowerCase();
                if (ua.match(/MicroMessenger/i) == "micromessenger") {
                    alert('请在浏览器中打开此链接');
                    return true;
                } else {
//                    alert('已开始下载履职系统app')
                }
            }
            $("a").click(function() {
            is_weixn()
})
        </script>
    </body>
</html>
