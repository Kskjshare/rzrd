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
    RssList entity2 = new RssList(pageContext, "contactstation");
    RssListView entity = new RssListView(pageContext, "contactstation");
    entity.request();
    entity2.request();
    if (!entity2.get("action").isEmpty()) {
        switch (entity2.get("action")) {
            case "append":
                entity2.append().submit();
                break;
            case "update":
                entity2.remove("id");
                entity2.update().where("id=?", entity2.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
            .cellbor>tbody>tr>td>textarea{height: 50px; margin: 3px 0;width: 170px;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            
            
            .cellbor>tbody>tr>td>textarea{height: 30px; margin: 3px 0;width: 99%;}
            .cellbor>tbody>tr>td>input{height: 24px;width: 99%;}
            .cellbor>tbody>tr>td>select{height: 24px;width: 99%;}

            
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">联络站名称</td>
                        <td colspan="5"><input type="text" maxlength="80"  name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">行政村</td>
                        <td><select id="street" name="street" dict-select="ssxarea" def="<% entity.write("street");%>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">地址</td>
                        <td><textarea type="text"  name="address" ><% entity.write("address"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">开放时间</td>
                        <td><input type="text" maxlength="80"  name="opentime" onFocus="WdatePicker({lang: 'zh-cn'})" value="<% entity.write("opentime"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">代表团</td>
                        <td><input readonly="readonly" id="myid" value="<% entity.write("allname"); %>"><input type="hidden" name="myid" value="<% entity.write("myid"); %>"></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
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
//            var selected = $("[name='street']").val()
//            $.each(dictdata["ssxarea"], function (k, v) {
//                if (v[1] != "0") {
//                    if (selected == k) {
//                        $("#street").append("<option selected='selected' value='" + k + "' pid='" + v[1] + "'>" + v[0] + "</option>")
//                    } else {
//                        $("#street").append("<option value='" + k + "' pid='" + v[1] + "'>" + v[0] + "</option>")
//                    }
//                }
//            })
//            $("#street").change(function () {
//                $("[name='street']").val($("#street").val());
//            })

        </script>
    </body>
</html>
