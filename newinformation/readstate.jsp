<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "lzmessage_news");
    RssListView entity2 = new RssListView(pageContext, "lzmessage_news");
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();

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
                <input type="text" name="searchkey">
                <button class="quicksearch">查询</button>
                <button id="wd">未读人员</button>
                <button id="yd">已读人员</button>
                <input type="hidden" name="type" value="<% out.print(entity.get("type").isEmpty() ? "1" : entity.get("type"));%>">
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th>姓名</th>
                            <th>电话号码</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String type = entity.get("type");
                            String instr = "";
                            String notinstr = "";
                            String sql = "";
                            String view = "";
                            entity.select().where("type=1 and realid=" + entity.get("realid")).query();
                            while (entity.for_in_rows()) {
                                instr += "," + entity.get("objid");
                            }
                            instr = instr.substring(0, instr.length());
                            int a = 1;
                           
                            out.print("<script>console.log('" + instr + "');</script>");
                            if (type.equals("2")) {
//                                view = "user_delegation";
                                entity2.select().where("type=2 and realid=" + req.get("realid")).query();
                                while (entity2.for_in_rows()) {
                                    notinstr += "," + entity2.get("objid");
                                }
                                out.print("<script>console.log('" + notinstr + "');</script>");
                                notinstr = notinstr.substring(0, notinstr.length());
//                                sql = "(myid in (" + instr + ") or parentid in (" + instr + ") or mission in (" + instr + ")) and myid not in (" + notinstr + ")";
                                view = "lzmessage_news";
                                sql = "type=2 and realid=" + req.get("realid");
                            } else {
                                view = "lzmessage_news";
                                sql = "type=1 and realid=" + req.get("realid");
                            }
                            RssListView list = new RssListView(pageContext, view);
                            list.request();
                            list.pagesize = 30;
                            list.select().where(sql).get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("state").equals("2") ? list.get("realname") : list.get("allname"));%></td>
                            <td><% out.print(list.get("telphone"));%></td>
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
                <!--                <input type="hidden" name="action" value="append" />
                                <button type="submit">确定</button>-->
            </div>
        </form>
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script type="text/javascript">
            $("#wd").click(function () {
                $("input[name='type']").val("1")
            })
            $("#yd").click(function () {
                $("input[name='type']").val("2")
            })
            var page = $("input[name='type']").val();
            $(".footer>span>a").each(function () {
                var href = $(this).attr("href")
                var arry = []
                arry = href.split("&");
                $(this).attr("href", arry[0] + "&" + arry[1] + "&type=" + page)
            })
        </script>
    </body>
</html>
