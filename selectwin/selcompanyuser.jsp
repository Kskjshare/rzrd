<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
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
        <form method="post" id="mainwrap">
            <div class="toolbar">
                   <input type="text" name="searchkey"><button class="quicksearch">查询</button>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>职务</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            list.request();
                            list.pagesize=30;
                            int a = 1;
                            list.select().where("state=5 and (realname like '%"+list.get("searchkey")+"%' or lianxirenCode like '%"+list.get("searchkey")+"%')").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" sexid="<% out.print(list.get("sex")); %>" birthday="<% out.print(list.get("birthday")); %>" telphone="<% out.print(list.get("telphone")); %>"/></td>
                            <td><% out.print(list.get("lianxirenCode")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("job")); %></td>
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
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </div>
    </form>
    <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
    <%@include  file="/inc/js.html" %>
    <script src="controller.js"></script>
    <script type="text/javascript">
        $('.footer>button').click(function () {
            var e = [];
            $("input[name='id']:checked").each(function () {
                e.push({"myid": $(this).attr("value"), "realname": $(this).parents("tr").find("td").eq(3).text(),"lianxirenCode": $(this).parents("tr").find("td").eq(2).text(),"sex": $(this).attr("sexid"),"job": $(this).parents("tr").find("td").eq(4).text(),"telphone": $(this).attr("telphone"),"birthday": $(this).attr("birthday")})
            })
            if (e.length == 0) {
                alert("请选择单位人员");
                return false;
            }
            RssWin.winsendmsg(e);
            window.close();
        });
    </script>
</body>
</html>