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
            td>img{height: 20px}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey">  <button type="submit" select="false" class="quicksearch" powerid="169">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" powerid="165">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="166">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="167">删除</button>
                <button type="button" transadapter="apd" select="false" class="butreports" powerid="168">导入</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30" rowspan="2"></th>
                            <th class="w30" rowspan="2"></th>
                            <th rowspan="2">被测评单位</th>
                            <th rowspan="2">测评内容</th>
                            <!--<th rowspan="2">参加测评委员(人数)</th>-->
                            <!--<th colspan="3">测评档次</th>-->
                            <th colspan="3">结果评定</th>
                            <th rowspan="2">备注</th>
                            <th rowspan="2">年份</th>
                        </tr>
                        <tr>
                            <!--                            <th>满意</th>
                                                        <th>基本满意</th>
                                                        <th>不满意</th>-->
                            <th>满意</th>
                            <th>基本满意</th>
                            <th>不满意</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "yyl_evaluation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("companyname like '%" + list.get("searchkey") + "%' or year like '%" + list.get("searchkey") + "%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("companyname")); %></td>
                            <td><% out.print(list.get("content")); %></td>
                            <!--<td><% out.print(list.get("peoplenumber")); %></td>-->
<!--                            <td><% out.print(list.get("grade").equals("1") ? "<img src='../../css/limg/check.png'/>" : "");%></td>
                            <td><% out.print(list.get("grade").equals("2") ? "<img src='../../css/limg/check.png'/>" : "");%></td>
                            <td><% out.print(list.get("grade").equals("3") ? "<img src='../../css/limg/check.png'/>" : "");%></td>-->
                            <td><% out.print(list.get("result").equals("1") ? "<img src='../../css/limg/check.png'/>" : "");%></td>
                            <td><% out.print(list.get("result").equals("2") ? "<img src='../../css/limg/check.png'/>" : "");%></td>
                            <td><% out.print(list.get("result").equals("3") ? "<img src='../../css/limg/check.png'/>" : "");%></td>
                            <td><% out.print(list.get("note")); %></td>
                            <td><% out.print(list.get("year")); %></td>
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
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script>
            $(".noscore").click(function () {
                var score = $(this).parent().parent().find("[name='id']").val();
                popuplayer.display("/evaluation/evaluation/score.jsp?id=" + score + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
            })
        </script>
    </body>
</html>