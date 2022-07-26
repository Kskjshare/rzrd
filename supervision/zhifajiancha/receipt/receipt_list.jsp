<%@page import="RssEasy.Core.CookieHelper"%>
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
            /*.cellbor tbody>.sel>td{background: #dce6f5}*/
            /*             .cellbor thead,.w30{background:#f0f0f0 }
                       .cellbor tbody tr>td:first-child{display: none}
                       .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="butview" class="butview">详情</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>下发单位</th>
                            <th>发布时间</th>
                            <th>审核状态</th>
                            <th>操作</th>

                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "supervision_inspection");
                            RssListView user_delegation = new RssListView(pageContext, "user_delegation");
                            list.request();
                            list.pagesize = 30;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 10;
                            }
                            int a = 1;
                            list.select().where("typeid=" + list.get("typeid") + " and title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and state<>5 and organizationid =" + UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                                user_delegation.select("company").where("myid=" + list.get("myid")).get_first_rows();
                                if (!user_delegation.isEmpty("company")) {
                                    list.keyvalue("myidcompany", user_delegation.get("company"));
                                }
                        %>
                        <tr ondblclick="ck_dbcflclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                             <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% list.write("title"); %></td>
                            <td><% list.write("myidcompany"); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td supervisioninspectionstate="<%list.write("state");%>"></td>
                            <td>
                                <%
                                    String html = "";
                                    if (list.get("state").equals("1")) {//1为待送回，2为已送回
                                        html += "<a style='text-decoration:none;' href='javascript:toReceipt(" + list.get("id") + ",\"" + list.get("title") + "\")' >送回审核</a>";
                                    } else {
                                        html += "<a style=' text-decoration: none; color:#B0B0B0;' href='javascript:void(0);'>送回审核</a> ";
                                    }
                                    out.print(html);
                                %>

                            </td>
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
        <script>
            var typeid =<%list.write("typeid");%>
        </script>
        <script src="controller.js"></script>
        <script>

                            //送回审核
                            function toReceipt(id, title) {
                                popuplayer.display("/supervision/zhifajiancha/receipt/receipt.jsp?id=" + id + "&title=" + title + "&TB_iframe=true", '送回审核', {width: 600, height: 360});

                            }
                           
        </script>
    </body>
</html>