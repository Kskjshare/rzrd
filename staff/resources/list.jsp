<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <style>
            .mkname{text-align: left}
            .mk1{text-indent: 30px;background: url(../../css/limg/folder.png) no-repeat 10px 4px;background-size:20px 15px; }
            .mk2{text-indent: 40px;background: url(../../css/limg/folder.png) no-repeat 20px 4px;background-size:20px 15px;}
            .mk3{text-indent: 45px;background: url(../../css/limg/folder2.png) no-repeat 25px 4px;background-size:13px 15px;}
            .cellbor tbody tr td:nth-child(2){color: #186aa3}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="append" select="false">增加</button>
                <button type="button" transadapter="update">编辑</button>
                <!--<button type="button" transadapter="delete">删除</button>-->
                <button type="button" id="djaaa">生成权限</button>
                <button type="button" transadapter="json" select="false">创建JSON</button>
                <input type="hidden" id="transadapter" find="[name='pid']:checked" />
            </div>
            <div class="bodywrap nofooter">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <!--<img src="" alt=""/>-->
                            <!--<th class="w30">选择</th>-->
                            <th class="w50"><input type="checkbox" id="all"></th>
                            <th>资源名称</th>
                            <th>资源编码</th>
                            <th>资源路径</th>
                            <th>资源图片</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script src="../../js/menudata.js" type="text/javascript"></script>
        <script>
            $(function () {
                var ht = "<tbody>";
                var num = 1;
                $.each(menudata, function (k, v) {
                    ht += "<tr><td>" + num + "</td><td><input type='checkbox' class='offset' offsetid='" + und(v.powerid) + "' offsetname='" + v.text + "'></td><td class='mkname mk1'>" + v.text + "</td><td>" + und(v.powerid) + "</td><td>" + und(v.url) + "</td><td>资源图片</td></tr>"
                    num++
                    $.each(v.children, function (k1, v1) {
                        if (v1.text != "功能栏") {
                            ht += "<tr><td>" + num + "</td><td><input type='checkbox' class='offset' offsetid='" + und(v1.powerid) + "' offsetname='" + v1.text + "'></td><td class='mkname mk2'>" + v1.text + "</td><td>" + und(v1.powerid) + "</td><td>" + und(v1.url) + "</td><td>资源图片</td></tr>"
                            num++
                            $.each(v1.children, function (k2, v2) {
                                if (v2.text != "首页") {
                                    ht += "<tr><td>" + num + "</td><td><input type='checkbox' class='offset' offsetid='" + und(v2.powerid) + "' offsetname='" + v2.text + "'></td><td class='mkname mk3'>" + v2.text + "</td><td>" + und(v2.powerid) + "</td><td>" + und(v2.url) + "</td><td>资源图片</td></tr>"
                                    num++
                                }
                            })
                        }
                    });
                });
                ht += "</tbody>"
                $(".cellbor").append(ht);
//                $("#djaaa").click(function () {
//                var offsetid = [];
//                var offsetname = [];
//                var offsetidstr = [];
//                var offsetnamestr = [];
//                $(".offset:checked").each(function () {
//                    var o = $(this).attr("offsetid")
//                    if ( o != "-") {
//                        offsetid.push($(this).attr("offsetid"))
//                        offsetname.push($(this).attr("offsetname"))
//                    }
//                })
//                offsetidstr = offsetid.join(",");
//                offsetnamestr = offsetname.join(",");
//                var urla =encodeURI("/staff/resources/edit_1.jsp?offsetidstr="+offsetidstr +"&offsetnamestr="+offsetnamestr)
//                popuplayer.display(urla)
//            })
            })
            function und(n) {
                if (n == "" || n == undefined || n == null) {
                    return "-";
                } else {
                    return n;
                }
            }
            $("#all").change(function () {
                if ($(this).is(":checked")) {
                    $(".offset").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $(".offset").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })
            

        </script>
    </body>
</html>
