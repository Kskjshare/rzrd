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
            .cellbor tbody>.sel>td{background: #dce6f5}
            .cellbor thead,.w30{background:#f0f0f0 }
            .cellbor tbody tr>td:first-child{display: none}
            .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="modify" class="butedit">重新交办</button>
                <button type="button" transadapter="see" class="butview">查看</button>
                <button type="button" transadapter="append" select="false" class="butreports">报表</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w60"><%
                                String a;
                                if (list.get("type").equals("1")) {
                                    a = "建议编号";
                                } else {
                                    a = "议案编号";
                                }
                                out.print(a); %></th>
                            <th class="w80">题目</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">类型</th>
                            <th class="w60">是否会上</th>
                            <th class="w60">提交日期</th>
                            <th class="w60">办理类型</th>
                            <th class="w60">交办状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.request();
                            int b = 1;
                            list.select().where("title like '%" + list.get("title") + "%' and methoded like '%" + list.get("methoded") + "%' and organizer like '%" + list.get("organizer") + "%' and id like '%" + list.get("id") + "%' and draft like '%" + list.get("draft") + "%' and type like '%" + list.get("type") + "%' and deal like '%" + list.get("deal") + "%'").get_page_desc("realid");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbglclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w30"><% out.print(b); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            <td class="tl"><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td lwstate="<% out.print(list.get("type")); %>"></td>
                            <td state="<% out.print(list.get("meet")); %>"></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                            <td handle="<% out.print(list.get("handle")); %>"></td>
                            <td deal="<% out.print(list.get("deal")); %>"></td>
                           <!--<td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>-->
                    <input type="hidden" value="<% out.print(list.get("type")); %>">
                    </tr>
                    <%
                            b++;
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
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".cellbor tbody tr").click(function () {
                $(this).addClass("sel").siblings().removeClass("sel");
                $(this).find("input").attr("checked", "checked");
            })
        </script>
    </body>
</html>
