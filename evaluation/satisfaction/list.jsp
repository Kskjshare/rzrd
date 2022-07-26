<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
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
        <style>
            .noscore{color: #6caddc;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
               <input type="text" name="searchkey"> <button type="submit" select="false" class="quicksearch">查询</button>
<!--                <button type="button"  transadapter="mysuggest" select="false" >我的建议办理满意度测评</button>-->
                <button type="button"  transadapter="company" select="false" >承办单位测评</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input  name="all" type="checkbox"></th>
                            <th>编号</th>
                            <th>单位名称</th>
                            <th>单位地址</th>
                            <th>联系人</th>
                            <th>单位电话</th>
                            <th>代表征询得分</th>
                            <th>建议征询得分</th>
                            <th>总平均分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("(code like '%" + list.get("searchkey") + "%' or allname like '%" +list.get("searchkey")+ "%') and state like '%3%'").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("danweiCode")); %></td>
                            <td><% out.print(list.get("company")); %></td>
                            <td><% out.print(list.get("workaddress")); %></td>
                            <td><% out.print(list.get("linkman")); %></td>
                            <td><% out.print(list.get("worktel")); %></td>
                            <td><% out.print(list.get("zxallscore")); %></td>
                            <td><% out.print(list.get("allscore")); %></td>
                            <td><%
                                int allscore = Integer.parseInt(list.get("allscore"));
                                int zxscore = Integer.parseInt(list.get("zxallscore"));
                                int all = (allscore+zxscore)/2;
                                out.print(all);
                                %></td>
                        </tr>
                        <%                                a++;
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
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".noscore").click(function () {
                var score = $(this).parent().parent().find("[name='id']").val();
                popuplayer.display("/evaluation/evaluation/score.jsp?id=" + score + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
            })
        </script>
    </body>
</html>