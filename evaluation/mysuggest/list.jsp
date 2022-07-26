<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "company_sug");
    CookieHelper cookie = new CookieHelper(request, response);
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
        <style>
            .cellbor{width: 800px}
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .noscore{color: #6caddc;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <!--<button type="button" transadapter="append" class="butedit">评分</button>-->
                <button type="button"  transadapter="mysuggest" select="false" >单位办理满意度情况</button>
                <button type="button"  transadapter="company" select="false" >承办单位测评</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30">选择</th>
                            <th class="w60">建议编号</th>
                            <th class="w100">题目</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">类型</th>
                            <th class="w60">主办单位</th>
                            <th class="w60">得分</th>
                            <th class="w60">评分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("resume=1 and lwstate like '%" + list.get("lwstate") + "%'  and draft=2 and title like '%" + list.get("title") + "%' and consultation=1 and myid="+UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("realid")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td lwstate="<% out.print(list.get("lwstate")); %>"></td>
                            <td><%out.print(list.get("allname")); %></td>
                            <td><%
                                RssList option = new RssList(pageContext, "opinion");
                                option.select().where("myid=" + cookie.Get("myid") + " and proposal="+list.get("id")).get_first_rows();
                                out.print(option.get("allscore"));
                                %></td>
                            <td><% out.print(option.get("allscore").equals("0")?"<span class='noscore'>未评分</span>":"已评分");%></td>
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
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".noscore").click(function () {
                var score = $(this).parent().parent().find("[name='id']").val();
                popuplayer.display("/evaluation/mysuggest/score.jsp?id=" +score + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
            })
        </script>
    </body>
</html>
