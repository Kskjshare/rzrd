<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "sort");
    list.request();
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
            .cellbor{width: 800px}
/*            .cellbor tbody>.sel>td{background: #dce6f5}
            .cellbor thead,.w30{background:#f0f0f0 }
            .cellbor tbody tr>td:first-child{display: none}
            .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" class="butedit">填写意见</button>
                <button type="button" transadapter="see" class="butview">查看建议</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30">选择</th>
                            <th class="w60">建议编号</th>
                            <th class="w100">题目</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">类型</th>
                            <th class="w60">要求结办日期</th>
                            <th class="w60">主办单位</th>
                            <th class="w80">办理类型</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.request();
                            int a = 1;
                            list.select().where("resume like '%" + list.get("resume") + "%' and lwstate like '%" + list.get("lwstate") + "%'  and draft=2 and title like '%" + list.get("title") + "%' and consultation like '%" + list.get("consultation") + "%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("realid")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td lwstate="<% out.print(list.get("lwstate")); %>"></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                            <td><%
                                RssListView company = new RssListView(pageContext, "company_sug"); 
                                company.select().where("id="+list.get("id")+" and companytype=2").get_page_desc("id");
                                while (company.for_in_rows()){
                                out.print("<p>"+company.get("allname")+"</p>");
                                }
                                %></td>
                            <td handle="<% out.print(list.get("handle")); %>"></td>
                    <input type="hidden" value="<% out.print(list.get("type")); %>">
                    </tr>
                    <%
                            a++;
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
        </script>
    </body>
</html>
