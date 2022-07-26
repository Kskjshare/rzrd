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
    RssList entity2 = new RssList(pageContext, "yyl_evaluation");
    RssList entity = new RssList(pageContext, "yyl_evaluation");
    entity.request();
    entity2.request();
    if (!entity2.get("action").isEmpty()) {
        switch (entity2.get("action")) {
            case "append":
                entity2.append().submit();
                break;
            case "update":
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
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;}
            .b95{width:95%; height: 100px; margin: 5px 0;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" name="file" multiple>
        </form>
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">信息处理</td>
                    </tr>
                    <tr>
                        <td class="dce w150 ">承办建议单位：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="companyname" value="<% entity.write("companyname"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w150 ">承办建议数（件）：</td>
                        <td><input type="number" maxlength="80" class="w50" name="peoplenumber" value="<% entity.write("peoplenumber"); %>" /></td>
                        <td class="dce w150 ">年份：</td>
                        <td><select class="w260" name="year" dict-select="evalyear" def="<% entity.write("year"); %>"></select>
                    </tr>
                    <tr>
                        <td class="dce w150 " colspan="4">办理结果：</td>
                    </tr>
                    <tr>
                        <td>已答复（件）</td>
                        <td><input type="text"></td>
                        <td>未答复（件）</td>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <td>已解决（件）</td>
                        <td><input type="text"></td>
                        <td>列入计划解决（件）</td>
                        <td><input type="text"></td>
                    </tr>
                    <tr>
                        <td>条件限制无法解决（件）</td>
                        <td colspan="3"><input type="text"></td>
                    </tr>
                    <tr>
                        <td class="dce w150 ">备注：</td>
                        <td colspan="3"><textarea type="text"  class="b95" name="note"><% entity.write("note"); %></textarea></td>
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
        <script>
        </script>
    </body>
</html>
