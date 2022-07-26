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
    RssList list = new RssList(pageContext, "releasum");
    RssList entity = new RssList(pageContext, "releasum_reldirector");
    list.request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        String[] releasumidarr = entity.get("id").split(",");
        System.out.println(entity.get("id"));
        System.out.println(releasumidarr);
        for (int i = 0; i < releasumidarr.length; i++) {
            entity.keyvalue("releasumid", releasumidarr[i]);
            entity.timestamp();
            entity.append().submit();
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
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>分类</th>
                            <th>创建时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + req.get("searchkey") + "%'").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td releasumclassify="<% out.print(list.get("classifyid")); %>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td>
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
    <script>
//        $('.footer>button').click(function () {
//            var e = [];
//            $("input[name='id']:checked").each(function () {
//                 alert($(this).attr("value"))
//                e.push({"id": $(this).attr("value")})
//            })
//            if (e.length == 0) {
//                alert("请选择单位");
//                return false;
//            }
//
//        });
    </script>
    <script src="controller.js"></script>

</body>
</html>