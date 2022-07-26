<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView list = new RssListView(pageContext, "user_delegation");
    RssList user_group = new RssList(pageContext, "user_group");
    RssList user_group_verify = new RssList(pageContext, "user_group");
    list.request();
    if (req.get("action").equals("append")) {
        String[] str = req.get("id").split(",");

        for (int idx = 0; idx < str.length; idx++) {
            user_group_verify.select("count(*) as num").where("groupid=" + req.get("groupid") + " and userid=" + str[idx]).get_first_rows();
            if (user_group_verify.get("num").equals("0")) {
                user_group.keyvalue("groupid", req.get("groupid")).keyvalue("userid", str[idx]).timestamp();
                user_group.append().submit();
            }
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
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
                            <th>代表团</th>
                            <th>职务</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("state=2 and (realname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%') and mission like '%" + req.get("dbtid") + "%'").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("delegationname")); %></td>
                            <td><% out.print(list.get("daibiaoDWjob")); %></td>
                            <td style="display: none;"><% out.print(list.get("daibiaoDWaddress")); %></td>
                            <td style="display: none;"><% out.print(list.get("telphone")); %></td>
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
             if ($("[name='id']").val() == undefined || $("[name='id']").val() == "") {
                    alert("请填写小组名称");
                    $("[name='realname']").focus();
                    return false;
                }
        });
    </script>
</body>
</html>