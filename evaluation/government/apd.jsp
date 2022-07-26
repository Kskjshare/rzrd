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
                <input type="file" name="img" id="file" multiple><a href="/upfile/moban/framework.xlsx">下载模板</a>
                <table class="wp100 cellbor">
                    <tr><td>被测评单位</td><td>测评内容</td><td>参加测评代表()人数</td><td>测评档次</td><td>结果评定</td><td>备注</td><td>年份</td></tr>  
                    <tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>  
                </table>
            </div>

            <div id="statusbar">
                <button id="button" type="button">提交</button>
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
        <script>
            var state = "1";
            var set;
            var ts = "";
            var err;
            $("#button").click(function () {
                parent.workpageload()
                $("#uesrupfile").hide();
                $("#processing").show();
                set = setInterval(function () {
                    $.get("/delegate/processing.jsp", {'state': state}, function (json) {
                        var a = JSON.parse(json);
//                        console.log(a);
                        if (a["nowpage"] != "" && a["allpage"] != "") {
                            var bfb = parseInt(parseInt(a["nowpage"]) * 100 / parseInt(a["allpage"]));
                            $("#processing>h1>em").text(bfb + "%");
                            var ml = -(300 - (3 * bfb));
                            $("#processing>p>span").css("margin-left", ml);
                        }
                    })
                    if (state == "2") {
                        clearInterval(set);
                        $("#processing>p>span").css("margin-left", "-300");
                        $("#processing>h1>em").text("100%");
                        
                        $("#abc>h1").text(ts);
                        if (err != "no") {
                            $("#abc tbody").append("<tr><td>被测评单位</td><td>测评内容</td><tr>")
                            $.each(err, function (k, v) {
                                $("#abc tbody").append("<tr><td>" + v.realname + "</td><td>" + v.tel + "</td></tr>")

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
                        $.get("/evaluation/government/excel.jsp", {'n': json.url}, function (e) {
                            var a = JSON.parse(e);
                            var b = parseInt(a.rowsnum);
                            var c = parseInt(a.nonum);
                            var d = c - b;
                            state = "2";
                            if (d != 0) {
                                ts = "共" + c + "条数据,成功导入" + b + "条数据," + d + "条未成功导入,可能原因为导入格式不正确或数据为空,未成功导入信息如下"
                            } else {
                                ts = "共" + c + "条数据,成功导入" + b + "条数据"
                            }
                            err = a.err
                        });
                    }});
                return false;
            })
//                        popuplayer.close();
//                        parent.quicksearch("/delegate/list.jsp?" + Math.floor(Math.random() * 100))
            
            
        </script>
    </body>
</html>