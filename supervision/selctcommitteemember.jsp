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
                 <!--zyx-->
                <button type="button" style="margin-left:23%;" class="res">返回上一级</button>
            <!--zyx end-->   
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>人大常委会成员</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "committee_member");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("powergroupid=5 and (realname like '%" + list.get("searchkey") + "%')").get_page_asc("myid");
                            //list.select().where("powergroupid=5").get_page_asc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" company="<% out.print(list.get("realname")); %>" /></td>
                            <td><% out.print(list.get("state").equals("1") ? list.get("realname") : list.get("realname"));%></td>
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
                e.push({"myid": $(this).attr("value"), "realname": $(this).parents("tr").find("td").eq(2).text()})
            })
            if (e.length == 0) {
                alert("请选择成员");
                return false;
            }
            RssWin.winsendmsg(e);
            window.close();
        });
      // zyx                    
            $(".res").click(function () {
                history.go(-1);
            });
//            zyx end  
    </script>
</body>
</html>