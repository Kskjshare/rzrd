<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>APP下载</title>
        <style type="text/css">
            html { font-size: calc(100vw/750*100); }
            * {
                margin: 0;
                padding: 0;
            }
            img {
                width: 100%;
                height: auto;
            }
            #imgId{
                margin-left: -1rem;
                width: 2rem;
                position: fixed;
                left: 50%;
                bottom: 1.5rem;
            }
        </style>
    </head>
    <body>
        <div align="center">
            <img src="img/bg.jpg" style="margin: 0 auto ">
            <a id="imgId"><img src="img/btn.png"></a>
        </div>
        <script src="/js/jquery.min.js" type="text/javascript"></script>

        <script language="javascript">
            $(function () {
                $("#imgId").click(function () {
                    download();
                });
            });

            function download() {
                var cssText =
                        "#weixin-tip{position: fixed; left:0; top:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80); width: 100%; height:100%; z-index: 100;} #weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}";
                var u = navigator.userAgent;
                if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) { //安卓手机
                    //判断使用环境
                    if (is_weixin()) {
                        loadHtml();
                        loadStyleText(cssText);
                    } else {
                        window.location.href = "download.jsp";
                    }
                } else if (u.indexOf('iPhone') > -1) { //苹果手机
                    window.location.href = "https://itunes.apple.com/cn/app/id1239249767?mt=8";
                } else if (u.indexOf('Windows Phone') > -1) {
                    //winphone手机
                    alert("机型不匹配！");
                }
            }

            function is_weixin() {
                var ua = navigator.userAgent.toLowerCase();
                if (ua.match(/MicroMessenger/i) == "micromessenger") {
                    return true;
                } else {
                    return false;
                }
            }

            function loadHtml() {
                var div = document.createElement('div');
                div.id = 'weixin-tip';
                div.innerHTML = '<p><img src="img/live_weixin.png" alt="请在微浏览器打开"/></p>';
                document.body.appendChild(div);
            }

            function loadStyleText(cssText) {
                var style = document.createElement('style');
                style.rel = 'stylesheet';
                style.type = 'text/css';
                try {
                    style.appendChild(document.createTextNode(cssText));
                } catch (e) {
                    style.styleSheet.cssText = cssText; //ie9以下
                }
                var head = document.getElementsByTagName("head")[0]; //head标签之间加上style样式
                head.appendChild(style);
            }
        </script>
    </body>
</html>