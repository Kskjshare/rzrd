<%@page import="RssEasy.DAL.Pagination"%>
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
    RssListView entity = new RssListView(pageContext, "comment_user");
    entity.request();
    entity.select().where("suggestid="+entity.get("id")).get_page_asc("myid");
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
            .cellbor>tbody>tr>td{;border: #6caddc solid thin;line-height: 34px;position: relative;}
            .cellbor{width: 90%;margin: 10px auto;border: 0}
            .cellbor tr td:first-child{width: 70px;text-align: right;border: 0;}
            .cellbor tr td>span{position: absolute;right: 5px;top: 0px;}
             .cellbor tr td>div{text-align: right;}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;height: 200px;}
            #matter>div{height: 180px;overflow: auto;}
        </style>
    </head>
    <body>
        <table class="cellbor">
            <%
                int allnum = 0;
             while (entity.for_in_rows()) {
                 allnum++;
                   %>
                   <tr><td><span><% out.print(entity.get("state").equals("2")||entity.get("state").equals("5")||entity.get("state").equals("9") ? entity.get("realname") : entity.get("allname"));%>：</span></td><td><% out.print(entity.get("matter"));%><div rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd HH:mm:ss" ></div></td></tr>
            <% 
                }
if (allnum == 0) {
        out.print("<script>alert('暂无点评数据');</script>");
        
    }
            %>
        </table>
        <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(entity.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(entity, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
