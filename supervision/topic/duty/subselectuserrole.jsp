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
                    <button type="button" style="margin-left:5%;"  class="res">返回上一级</button>
                    <!--zyx end-->  
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"></th>
                            <th>编号</th>
                            <th>名称</th>
                            <th>联系人</th>
                            <th>电话</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_delegation");
                            list.request();
                            int a = 1;
                            list.pagesize=30;
                            list.select().where("state=3 and (company like '%"+list.get("searchkey")+"%' or danweiCode like '%"+list.get("searchkey")+"%' or realname like '%"+list.get("searchkey")+"%')" ).get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="radio" name="id" value="<% out.print(list.get("myid")); %>" company="<% out.print(list.get("company")); %>" postcode="<% out.print(list.get("postcode")); %>" homeaddress="<% out.print(list.get("homeaddress")); %>"  /></td>
                            <td><% out.print(list.get("danweiCode")); %></td>
                            <td><% out.print(list.get("state").equals("5") ? list.get("company") : list.get("company"));%></td>
                            <td><% out.print(list.get("linkman")); %></td>
                            <td><% out.print(list.get("worktel")); %></td>
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
            var check = $("input[name='id']:checked");
            var e ;
            if (check.length == "1") {
               e = {"myid": check.attr("value"), "myname": check.parents("tr").find("td").eq(3).text()}
            } else {
                alert("请选择");
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