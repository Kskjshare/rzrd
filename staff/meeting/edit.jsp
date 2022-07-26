<%@page import="RssEasy.MySql.RssClassifyList"%>
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
    RssList entity = new RssList(pageContext, "meeting");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("relationid");
        switch (entity.get("action")) {
            case "append":
//                if (entity.select().where("id=" + entity.get("id")).get_first_rows()) {
//                    out.print("<script>alert('会议编码已存在！');</script>");
//                } else {
//                    out.print(entity.get("year"));
                    entity.append().submit();
                    new RssClassifyList(pageContext, "session").createclassifyjson();
                    PoPupHelper.adapter(out).iframereload();
                    PoPupHelper.adapter(out).showSucceed();
//                }
                break;
            case "update":
                entity.remove("id");
                entity.update().where("id=?", entity.get("relationid")).submit();
                new RssClassifyList(pageContext, "session").createclassifyjson();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
    }
    entity.select().where("id=?", entity.get("relationid")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 formor">
                    <tr>
                        <td class="tr w100 ">会议编码：</td>
                        <td class="backdce"><input type="text" maxlength="80" class="w200" name="id" value="<% entity.write("id"); %>" disabled="true"/></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">届次名称：</td>
                        <td class="backdce"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">会议名称：</td>
                        <td class="backdce"><select type="text" maxlength="80" class="w260" name="companytypeeeid" dict-select="companytypeeeclassify" def="<% entity.write("companytypeeeid"); %>" ></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">对应时间日期：</td>
                        <td class="backdce"><input type="text" class="w150 Wdate" id="startdate" name="startdate"  rssdate="<% out.print(entity.get("startdate")); %>,yyyy-MM-dd HH:mm:ss" onFocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss', startDate: '%y-%M-%d 00:00:00', maxDate: '#F{$dp.$D(\'enddate\')}'})" readonly="readonly" />&Tilde;
                                            <input  type="text" class="w150 Wdate" id="enddate" name="enddate"  rssdate="<% out.print(entity.get("enddate")); %>,yyyy-MM-dd HH:mm:ss" onFocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss', startDate: '%y-%M-%d 23:59:59', minDate: '#F{$dp.$D(\'startdate\')}'})" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">会议说明：</td>
                        <td class="backdce"><input type="textarea" maxlength="150" class="w200" name="remark" value="<% entity.write("remark"); %>"/></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("relationid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("relationid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                $(".footer>button").click(function () {
                     if ($("[name='startdate']").val() == undefined || $("[name='startdate']").val() == "") {
                        alert("请填写对应日期");
                        $("[name='startdate']").focus();
                        return false;
                    }
                    if ($("[name='enddate']").val() == undefined || $("[name='enddate']").val() == "") {
                        alert("请填写对应日期");
                        $("[name='enddate']").focus();
                        return false;
                    }

                    $(".Wdate").each(function () {
                        if ($(this).val() != undefined && $(this).val() != "") {
                            var timestamp = new Date($(this).val());
                            $(this).val(timestamp / 1000);
                        }
                    })
                })
        </script>
    </body>
</html>
