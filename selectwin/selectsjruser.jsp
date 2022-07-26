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
                            <th class="w30"></th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>类型</th>
                            <th>邮箱</th>
                            <th>电话</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            list.request();
                            int a = 1;
                            list.pagesize=30;
                            if (list.get("seltype").equals("4")) {
                                list.select().where("(mission=" + list.get("parentid") + " or myid=" + list.get("parentid") + ") and (allname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%' or realname like '%" + list.get("searchkey") + "%')").get_page_desc("myid");
                            } else if (list.get("seltype").equals("0")) {
                                list.select().where("company like '%" + list.get("searchkey") + "%' or allname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%' or realname like '%" + list.get("searchkey") + "%'").get_page_desc("myid");
                            } else {
                                list.select().where("( parentid=" + list.get("parentid") + " or myid=" + list.get("parentid") + ") and (allname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%' or realname like '%" + list.get("searchkey") + "%')").get_page_desc("myid");
                            }

                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="radio" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("code")); %></td>
                            <%
                                String name = "";
                                if (list.get("state").equals("2")) {
                                    name = list.get("realname");
                                } else if (list.get("state").equals("3")) {
                                    name = list.get("company");
                                } else {
                                    name = list.get("allname");
                                }
                            %>
                            <td><% out.print(name);%></td>
                            <td usertype="<% out.print(list.get("state")); %>"></td>
                            <td><% out.print(list.get("email")); %></td>
                            <td><% out.print(list.get("telphone")); %></td>
                        </tr>
                        <%
                                a++;
                            }
                            if (a == 1) {
                                out.print("<script> alert('暂无可选择人员')</script>");
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
            var e;
            if (check.length == "1") {
                e = {"myid": check.attr("value"), "email": check.parents("tr").find("td").eq(4).text(), "telphone": check.parents("tr").find("td").eq(5).text(), "myname": check.parents("tr").find("td").eq(3).text()}
            } else {
                alert("请选择");
                return false;
            }
            RssWin.winsendmsg(e);
            window.close();
        });
    </script>
</body>
</html>