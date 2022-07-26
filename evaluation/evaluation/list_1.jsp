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
            .noscore{color: #6caddc;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey">  <button type="submit" select="false" class="quicksearch">查询</button>
                <button type="button"  transadapter="mysuggest" select="false" >我的建议办理满意度测评</button>
                <button type="button"  transadapter="company" select="false" >单位办理满意度情况</button>
                <button type="button" transadapter="see" class="butview">查看</button>
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
                            <th>联系电话</th>
                            <th>承办数量</th>
                            <th>是否打分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            RssListView company = new RssListView(pageContext, "company_sugnum");
                            RssList score = new RssList(pageContext, "companyscore");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("(code like '%" + list.get("searchkey") + "%' or allname like '%" + list.get("searchkey") + "%') and state like '%3%' and powergroupid not in (7,19,20)").get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("allname")); %></td>
                            <td><% out.print(list.get("workaddress")); %></td>
                            <td><% out.print(list.get("linkman")); %></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <td><%
                                if (company.select().where("type=2 and myid=" + list.get("myid")).get_first_rows()) {
                                    out.print(company.get("num"));
                                } else {
                                    out.print("0");
                                }
                                %></td>
                            <td><%
                                if (score.select().where("companyid=" + list.get("myid") + " and myid=" + UserList.MyID(request)).get_first_rows()) {
                                    out.print("<span>已评分</span>");
                                } else {
                                    out.print("<span class='noscore'>未评分</span>");
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
            </div>
        </form>
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".noscore").click(function () {
                var score = $(this).parent().parent().find("[name='id']").val();
                popuplayer.display("/evaluation/evaluation/score.jsp?id=" +score + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
            })
        </script>
    </body>
</html>