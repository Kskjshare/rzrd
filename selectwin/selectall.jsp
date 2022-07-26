<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    RssListView list = new RssListView(pageContext, "user_delegation");
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
    </head>
    <style>
        .toolbar>label{margin-left: 5px;}
    </style>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey"><button class="quicksearch">查询</button> 
                <%
                    if (!(cookie.Get("powergroupid").equals("22"))) {
                %>
                <label><input type="radio" name="nav" value="2">代表列表</label>
                <label><input type="radio" name="nav" value="4">代表团列表</label><label><input type="radio" name="nav"  value="3">单位列表</label>
                    <%
                        }
                    %>
                <!--<label><input type="radio" name="nav"  value="5">工作人员列表</label>-->
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <!--<th>编号</th>-->
                            <th>
                                <%
                                    if (list.get("state").equals("4") || list.get("state").equals("3")) {
                                %>
                                名称
                                <%
                                } else {
                                %>
                                姓名
                                <%
                                    }
                                %>
                            </th>
                            <th>
                                <%
                                    if (list.get("state").equals("4") || list.get("state").equals("3")) {
                                %>
                                管理员
                                <%
                                } else {
                                %>
                                代表团
                                <%
                                    }
                                %>
                            </th>
                            <th>电话</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.pagesize=30;
                            int a = 1;
                            String str = "";
                            if (!list.get("state").isEmpty()) {
                                str = list.get("state");
                            } else {
                                str = "2";
                            }
                            if (cookie.Get("powergroupid").equals("22")) {
//                            list.select().where("state like '%" + str + "%' and (realname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%')").get_page_desc("myid");
                                list.select().where("state=2 and (realname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%') and mission like '%" + cookie.Get("myid") + "%'").get_page_desc("myid");
                            } else {
                                list.select().where("state like '%" + str + "%' and (realname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%')").get_page_desc("myid");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" sellzstate="<% out.print(list.get("state")); %>" /></td>
                            <!--<td><% out.print(list.get("code")); %></td>-->

                            <td>
                                <%
                                    if (!(list.get("state").equals("4") || list.get("state").equals("3"))) {
                                        out.print(list.get("realname"));
                                    } else {
                                        out.print(list.get("account"));
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    if (!(list.get("state").equals("4") || list.get("state").equals("3"))) {
                                        out.print(list.get("delegationname"));
                                    } else {
                                        out.print(list.get("linkman"));
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    if (!(list.get("state").equals("3"))) {
                                        out.print(list.get("telphone"));
                                    } else {
                                        out.print(list.get("worktel"));
                                    }
                                %></td>
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
                <input type="hidden" name="state" />
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
                e.push({"myid": $(this).attr("value"), "realname": $(this).parents("tr").find("td").eq(2).text(), "state": $(this).attr("sellzstate")})
            })
            if (e.length == 0) {
                alert("请选择");
                return false;
            }
            RssWin.winsendmsg(e);
            window.close();
        });

        $("button").click(function () {
            if ($("input[name='nav']:checked").length == "1") {
                var ind = $("input[name='nav']:checked").val();
                if (ind == 3 || ind == 4) {
                    $("thead tr>th:eq(2)").text("名称");
                    $("thead tr>th:eq(3)").text("管理员");
                }
                $("[name='state']").val(ind)
            }
        })
    </script>
</body>
</html>