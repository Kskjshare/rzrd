<%@page import="java.sql.Date"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
        <style>
            .mainwrapassist{ margin:10px; } 
            .mainwrapassist>input{margin-bottom: 10px;}
            .mainwrapassist>a{margin-left: 5px;font-size: 12px;color: blue;cursor: pointer;vertical-align: top;line-height: 28px;}
            .mainwrapassist td{height: 14px;}
            #statusbar{margin: 10px;padding-right: 20px;text-align: right;}
            #statusbar>button{color: ButtonFace;background: rgb(101, 113, 128);border: solid 1px rgb(101, 113, 128);border-radius: 3px; padding: 3px 6px;padding-bottom: 5px; font-size: 12px; word-spacing: 10px;line-height: 1em;font-family: 微软雅黑; vertical-align: middle;display: inline-block;}
            #processing{display: none}
            #processing>h1{ margin: 20px 0;text-align: center;}
            #processing>h1>em{ margin-left: 20px;}
            #processing>p{border: #eee solid 2px;height: 32px;width: 300px; margin: 0 auto; overflow: hidden;}
            #processing>p>span{ background: red;display: block; width: 300px; height: 32px;margin-left: -300px;}
            #abc{display: none;height: 100%;overflow: auto;}
            #abc>h1{margin: 20px;}
            #abc>table{ width: 80%; text-align: center;margin: 20px auto;}
        </style>
    </head>
    <body>
        <form method="post"  class="labelright nomargin" id="uesrupfile">           
            <div class="mainwrapassist notitletoolbar">
                <input type="file" name="img" id="file" multiple><a href="./DWGL.xlsx">下载模板</a>
                <table class="wp100 cellbor">
                    <tr><td>单位编号</td><td>单位名称</td><td>单位全称</td><td>单位地址</td><td>单位负责人</td><td>单位管理员</td><td>单位联系人</td><td>联系电话</td><td>电子邮箱</td></tr>  
                    <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>  
                </table>
            </div>
            <div id="statusbar">
                <button type="button" >提交</button>
            </div>
        </form>
        <div id="processing">
            <h1>导入进度<em>0%</em></h1>
            <p><span></span></p>
        </div>
        <div id="abc">
            <h1></h1>
            <table><tbody></tbody></table>
        </div>
        <%@include  file="/inc/js.html" %>
        <!--<script src="uploads.js" type="text/javascript"></script>-->
        <script>
            var state = "1";
            var set;
            var ts = "";
            var err;
            $("#statusbar>button").click(function () {
                parent.workpageload()
                $("#uesrupfile").hide();
                $("#processing").show();
                set = setInterval(function () {
                    $.get("/delegate/processing.jsp", {'state': state}, function (json) {
                        var a = JSON.parse(json);
                        if (a["nowpage"] != "" && a["allpage"] != "") {
                            var bfb = parseInt(parseInt(a["nowpage"]) * 100 / parseInt(a["allpage"]));
                            $("#processing>h1>em").text(bfb + "%");
                            var ml = -(300 - (3 * bfb));
                            $("#processing>p>span").css("margin-left", ml);
                        }
                    })
                    if (state == "3") {
                        clearInterval(set);
                        $("#processing>p>span").css("margin-left", "-300");
                        $("#processing>h1>em").text("100%");

                        $("#abc>h1").text(ts);
                        if (err != "no") {
                            $("#abc tbody").append("<tr><td>登录名</td><td>电话号码</td><td>单位名称</td><tr>")
                            $.each(err, function (k, v) {
                                $("#abc tbody").append("<tr><td>" + v.loginNameDw + "</td><td>" + v.tel + "</td><td>" + v.company + "</td></tr>")

                            })
                        }
                        $("#processing").hide();
                        $("#abc").show();
                    }
                }, 1000)
                $("#uesrupfile").ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (json) {
                        $.get("/company/excel.jsp", {'n': json.url}, function (e) {
                            var a = JSON.parse(e);
                            var b = parseInt(a.rowsnum);
                            var c = parseInt(a.nonum);
                            var d = c - b;
                            state = "3";
                            if (d != 0) {
                                ts = "共" + c + "条数据,成功导入" + b + "条数据," + d + "条未成功导入,可能原因为默认登录账号(手机号码)已存在或导入格式不正确,未成功导入信息如下"
                            } else {
                                ts = "共" + c + "条数据,成功导入" + b + "条数据"
                            }
                            err = a.err
                        });
                    }});
                return false;
            })
        </script>
    </body>
</html>