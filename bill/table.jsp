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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="advsearch">高级查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butadd">删除</button>
                <button type="button" transadapter="see" class="butview">查看</button>
                <button type="button" transadapter="append" select="false" class="butreports">报表</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <input type="hidden" id="draft" value="<% out.print(list.get("draft")); %>"/>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w60">序号</th>
                            <th class="w60">提交类型</th>
                            <th class="w80">建议题目</th>
                            <th class="w60">处理方式</th>
                            <th class="w60">征求意见方式</th>
                            <th class="w80">建议主办单位</th>
                            <th class="w60">可否联名提出</th>
                            <th class="w60">可否网上公开</th>
                            <th class="w120">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.request();
                            int a = 1;
                            list.select().where("title like '%"+list.get("title")+"%' and methoded like '%"+list.get("methoded")+"%' and organizer like '%"+list.get("organizer")+"%' and id like '%"+list.get("id")+"%' and type in('3','4')").get_page_desc("realid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td>lw<% out.print(list.get("lwid")); %></td>
                            <td classify="<% out.print(list.get("lwstate")); %>"></td>
                            <td class="tl"><% out.print(list.get("title")); %></td>
                            <td methoded="<% out.print(list.get("methoded")); %>"></td>
                            <td opinioned="<% out.print(list.get("opinioned")); %>"></td>
                            <td><% out.print(list.get("organizer")); %></td>
                            <td state="<% out.print(list.get("seconded")); %>"></td>
                            <td state="<% out.print(list.get("permission")); %>"></td>
                            <!--<td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>-->
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
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
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".cellbor tbody tr").click(function () {
                $(this).addClass("sel").siblings().removeClass("sel");
                $(this).find("input").attr("checked", "checked");
            });
        </script>
    </body>
</html>
