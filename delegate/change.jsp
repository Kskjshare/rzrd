<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    UserList enity = new UserList(pageContext);
    enity.request();
    if (req.get("action").equals("delete")) {
        enity.remove("relationid", "action");
        enity.update().where("myid in (" + req.get("relationid") + ")").submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
            em{font-size: 12px;color: red;margin-left: 2px;}
            .w656{width: 649px;}
            .borderred{border-color:red; }
            #abc{position: absolute;left: -10000px;}
            td>h1{text-align: center;margin: 20px;}
            .w254{width: 254px;}
            .w260{width: 260px;}
            .w258{width: 258px;}
            .checksel{height: 32px;}
            .checksel>p{min-height: 26px; border: solid 1px #cbcbcb;padding: 0 2px;border-radius: 3px;line-height: 26px;background: #fff;background:url("/css/limg/mnselect.png") no-repeat 245px 10px; }
            /*#sessionlist>p>span{display: block;}*/
            .checksel ul{position: relative;z-index: 9999;display: none;background: #fff;border: #cbcbcb solid 1px;}
            .checksel li{line-height: 32px;font-size: 12px;padding: 0 3px;}
            .popupwrap>div:first-child {
                height: 90%;
            }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                <table class="wp100 formor">
                    <tr>
                        <td class="tr w100 ">请选择届次：<em class="red">*</em></td>
                        <td><div class="checksel" id="sessionlist"><p class="w254"></p><ul class="w258"></ul></div></td>
                        <!--                <select name="session" dict-select="sessionclassify">
                                        </select>-->
                        <!--                <select name="sessionid" dict-select="sessionclassify">
                                        </select>-->
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
                <input type="hidden" name="sessionlist" value="<% out.print(enity.get("sessionlist"));%>">
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script>
            $(".footer>button").click(function () {
                var sessionlistval = ",";
                $("#sessionlist p").find("span").each(function () {
                    var sesid = $(this).attr("sesid");
                    sessionlistval += sesid + ",";
                })
                $("input[name='sessionlist']").val(sessionlistval)
            })
            var sessionlist = $("input[name='sessionlist']").val().split(",");
            $.each(dictdata["sessionclassify"], function (k, v) {
                if (sessionlist.indexOf(k) != "-1") {
                    $("#sessionlist p").append("<span sesid=" + k + ">" + v[0] + "<span>")
                    $("#sessionlist ul").append('<li class="w254"><label><input checked="checked" sesid=' + k + ' type="checkbox" ><span>' + v[0] + '</span></label></li>')
                } else {
                    $("#sessionlist ul").append('<li class="w254"><label><input sesid=' + k + ' type="checkbox" ><span>' + v[0] + '</span></label></li>')
                }
            })
            checksel();
            $(".popupwrap").click(function () {
                $(".checksel").find("ul").hide();
            })
        </script>
    </body>
</html>
