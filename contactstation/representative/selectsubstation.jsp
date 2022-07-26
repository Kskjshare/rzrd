<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
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
                <!--<input type="text" name="searchkey"><button class="quicksearch">查询</button>-->
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"></th>
                            <th>联络站名称</th>
<!--                            <th>代表团</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                           
                            
                            RssList list = new RssList(pageContext, "contactstation_sub");
//                            RssListView list = new RssListView(pageContext, "contactstation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
//                            list.select("myid="+ req.get("mission")).get_page_desc("id");
                            list.select().where("myid=?", req.get("mission")).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="radio" name="id" value="<% out.print(list.get("substationid")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <!--<td ssxarea="<% out.print(list.get("street")); %>"></td>-->
                            <!--<td><% out.print(list.get("allname")); %></td>-->
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
                e.push({"id": $(this).attr("value"), "name": $(this).parents("tr").find("td").eq(2).text()})
            })
            if (e.length == 0) {
                alert("请选择站点");
                return false;
            }
            RssWin.winsendmsg(e);
            window.close();
        });
    </script>
</body>
</html>