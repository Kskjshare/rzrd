<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);

//    RssList entity = new RssList(pageContext, "contactstation_new");

    RssList editentity = new RssList(pageContext, "station_sub_id");
    CookieHelper cookie = new CookieHelper(request, response);
//    editentity.request();
    editentity.request();
    if (!editentity.get("action").isEmpty()) {
        switch (editentity.get("action")) {
            case "append":
//                editentity.timestamp();
                editentity.keymyid(cookie.Get("myid"));
                editentity.append().submit();
                break;
            case "update":
                editentity.remove("id");
                editentity.update().where("id=?", editentity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    editentity.select().where("id=?", editentity.get("id")).get_first_rows();

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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor>tbody>tr>td>textarea{height: 30px; margin: 3px 0;width: 95%;}
            .cellbor>tbody>tr>td>input{width: 98%;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}

        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
<!--                    <tr>
                        <td class="dce w120 ">名称<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" name="title" value="<% editentity.write("title"); %>" /></td>
                    </tr>-->
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">联络站名称<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="80"  name="name" value="<% editentity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">联络站ID<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="80"  name="myid" value="<% editentity.write("myid"); %>" /></td>
                    </tr>
                    
<!--                    <tr>
                        <td class="dce w100 ">所属联络站：</td>
                        <td id="stationsel">
                            <input class="b95" readonly="readonly" value="<% editentity.write("name"); %>"/>
                            <input type="hidden" name="stationid" id="stationid" value="<% editentity.write("stationid"); %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">开放时间：</td>
                        <td><textarea type="text"  name="opentime"><% editentity.write("opentime"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">地址：</td>
                        <td><textarea type="text"  name="address"><% editentity.write("address"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">站长：</td>
                        <td><textarea type="text"  name="master"><% editentity.write("master"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">站长电话：</td>
                        <td><textarea type="text"  name="mastertelephone"><% editentity.write("mastertelephone"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">联络员：</td>
                        <td><textarea type="text"  name="linkman"><% editentity.write("linkman"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">联络员电话：</td>
                        <td><textarea type="text"  name="linkmantelephone"><% editentity.write("linkmantelephone"); %></textarea></td>
                    </tr>-->
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(editentity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(editentity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/street.js"></script>
        <script>
            $("#myid").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                    $("#myid").val(dict.myname)
                    $("[name='myid']").val(dict.myid)
                }
                RssWin.open("/selectwin/selectoneuser_1.jsp?state=4", 600, 500);
            })
            $("#stationsel>input").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    var userrolename = [], userroleval = [];
                    $.each(dict, function (k, v) {
                        userrolename.push(v.name)
                        userroleval.push(v.id)
                    })
                    $("#stationsel").find("input:first").val(userrolename)
                    $("#stationid").val(userroleval)
                }
                RssWin.open("/contactstation/substation/selectstation.jsp", 700, 650);
            });
        </script>
    </body>
</html>
