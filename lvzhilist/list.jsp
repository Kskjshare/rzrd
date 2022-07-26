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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <!--                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                                <button type="button" transadapter="edit" class="butedit">编辑</button>-->
<!--                <button type="button" transadapter="delete" class="butdelect" powerid="166">删除</button>-->
                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <button type="button" transadapter="export" class="butreports">导出</button>
                <button type="button"  transadapter="list" select="false" >满意度测评</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>代表姓名</th>
                            <th>代表证号</th>
                            <th>代表团</th>
                            <!--<th>年份</th>-->
                            <th>建议</th>
                            <th>议案</th>
                            <th>代表视察</th>
                            <th>专题调研</th>
                            <th>执法检查</th>
                            <th>参加会议</th>
                            <th>学习培训</th>
                            <th>代表意见征询</th>
                            <th>总分数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_delegation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("code like '%" + URLDecoder.decode(list.get("code"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state=2").get_page_desc("myid");
                            while (list.for_in_rows()) {
                                int num = 0;
                                String[] ta = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                                RssListView list3 = new RssListView(pageContext, "sort");
                                list3.query("SELECT lwstate,COUNT(*) AS num FROM sort_list_view WHERE myid=" + list.get("myid") + " and draft=2 GROUP BY lwstate");
                                while (list3.for_in_rows()) {
                                    if (list3.get("lwstate").equals("1")) {
                                        ta[7] = list3.get("num");
                                        num += Integer.valueOf(list3.get("num"));
                                    }
                                    if (list3.get("lwstate").equals("2")) {
                                        ta[8] = list3.get("num");
                                        num += Integer.valueOf(list3.get("num"));
                                    }
                                }
                                RssListView list4 = new RssListView(pageContext, "activities_userlist");
                                list4.query("SELECT classify,COUNT(*) AS num FROM activities_userlist_list_view WHERE userid=" + list.get("myid") + " and attendancetype=2 GROUP BY classify");
                                while (list4.for_in_rows()) {
                                    int z = Integer.parseInt(list4.get("classify"));
                                    ta[z] = list4.get("num");
                                    num += Integer.valueOf(list4.get("num"));
                                }
                                //意见征询
                                RssListView list2 = new RssListView(pageContext, "sort");
                                RssListView list1 = new RssListView(pageContext, "sort");
                                list2.query("SELECT myid,resume,consultation,COUNT(*) AS num FROM sort_list_view WHERE draft=2 and myid=" + list.get("myid") + " GROUP BY myid,resume,consultation");
                                list1.query("SELECT userid,resume,consultation,COUNT(*) AS num FROM sortuser_list_view WHERE draft=2 and userid=" + list.get("myid") + " GROUP BY userid,resume,consultation");
                                String[] use = {"0", "0"};
                                while (list1.for_in_rows()) {
                                    if (list1.get("resume").equals("1") && list1.get("consultation").equals("0")) {
                                        use[0] = list1.get("num");
                                    } else if (list1.get("resume").equals("1") && list1.get("consultation").equals("1")) {
                                        use[1] = list1.get("num");
                                    }
                                }
                                String[] taa = {"0", "0", "0"};
                                while (list2.for_in_rows()) {
                                    if (list2.get("resume").equals("1") && list2.get("consultation").equals("1")) {
                                        taa[2] = list2.get("num");
                                    }
                                }
                                int numm = Integer.parseInt(use[0]) + Integer.parseInt(use[1]) + Integer.parseInt(taa[2]);
                                num += numm;
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("delegationname").isEmpty() ? "无" : list.get("delegationname")); %></td>
<!--                            <td><% out.print(list.get("year").isEmpty() ? "无" : list.get("year")); %></td>-->
                            <td><% out.print(ta[7]); %></td>
                            <td><% out.print(ta[8]); %></td>
                            <td><% out.print(ta[1]); %></td>
                            <td><% out.print(ta[2]); %></td>
                            <td><% out.print(ta[3]); %></td>
                            <td><% out.print(ta[4]); %></td>
                            <td><% out.print(ta[5]); %></td>
                            <td><% out.print(numm); %></td>
                            <td><% out.print(num); %></td>
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
        <!--        <script>
                    $("select[pagesize]").change(function() {
            alert();
        })
                </script>-->
    </body>
</html>