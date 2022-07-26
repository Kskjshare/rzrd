<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "opinion");
    list.request();
%>
<!DOCTYPE html>
<html>scr_suggest
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
/*            .cellbor tbody>.sel>td{background: #dce6f5}
            .cellbor thead,.w30{background:#f0f0f0 }
            .cellbor tbody tr>td:first-child{display: none}
            .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="edit" class="butedit">修改意见</button>
                <button type="button" transadapter="see" class="butview">查看建议</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"></th>
                            <th class="w60">单位名称</th>
                            <th class="w60">建议编号</th>
                            <th class="w60">建议标题</th>
                            <th class="w60">是否收到答复函</th>
                            <th class="w60">满意程度</th>
                            <th class="w60">承办人业务能力</th>
                            <th class="w60">沟通的主动性</th>
                            <th class="w60">交流的充分性</th>
                            <th class="w60">办理的针对性</th>
                            <th class="w60">对问题的共识度</th>
                            <th class="w60">对建议办理的具体评价</th>
                            <th class="w60">总分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.request();
                            int a = 1;
                            list.select().where("opname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%'  and type=1 ").get_page_desc("realid");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcdlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td>
                                <input type="radio" name="id" value="<% out.print(list.get("id")); %>"  rid="<% out.print(list.get("opinionid")); %>"/></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("company")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td state="<% out.print(list.get("reply")); %>"></td>
                            <td effect="<% out.print(list.get("effect")); %>"></td>
                            <td><% out.print(list.get("business")); %></td>
                            <td><% out.print(list.get("initiative")); %></td>
                            <td><% out.print(list.get("communication")); %></td>
                            <td><% out.print(list.get("counter")); %></td>
                            <td><% out.print(list.get("consensus")); %></td>
                            <td><% out.print(list.get("evaluate")); %></td>
                            <td><% out.print(list.get("allscore")); %></td>
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
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
        </script>
    </body>
</html>
