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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey">  <button type="submit" select="false" class="quicksearch">查询</button>
                <!--                <button type="button"  transadapter="mysuggest" select="false" >我的建议办理满意度测评</button>
                                                <button type="button"  transadapter="company" select="false" >单位办理满意度情况</button>-->
                <button type="button" transadapter="see" class="butview" powerid="195">查看</button>
                <button type="button" transadapter="append" class="butedit" powerid="196">评分</button>
                <!--                <button type="button" transadapter="see" class="butview">查看</button>
                                <button type="button" transadapter="append" select="false" class="butadd" powerid="">增加</button>
                                <button type="button" transadapter="edit" class="butedit"powerid="">编辑</button>
                                <button type="button" transadapter="delete" class="butdelect" powerid="">删除</button>
                                <button type="button" transadapter="apd" select="false" class="butreports" powerid="">导入</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <!--<th class="w30" rowspan="2"></th>-->
                            <th class="w30" rowspan="2"></th>
                            <th rowspan="2">序号</th>
                            <th rowspan="2">承办建议单位</th>
                            <th rowspan="2">承办建议数(件)</th>
                            <th colspan="6">办理结果</th>
                            <!--<th colspan="3">办理程序(30分)</th>-->
                            <!--<th colspan="3">测评情况(70分)</th>-->
                            <th colspan="3">结果评定</th>
                            <th rowspan="2">备注</th>
                            <th rowspan="2">年份</th>
                        </tr>
                        <tr>
                            <th>已答复(件)</th>
                            <th>未答复(件)</th>
                            <th>已解决(件)</th>
                            <th>正在解决(件)</th>
                            <th>列入计划解决(件)</th>
                            <th>条件限制无法解决(件)</th>
                            <!--                            <th>领导重视5分</th>                            
                                                        <th>制度建设5分</th>
                                                        <th>办理情况20分</th>
                                                        <th>常委会测评占30%</th>
                                                        <th>全体代表测评占20%</th>
                                                        <th>提建议代表测评占20%</th>-->
                            <th>满意(80-100)分</th>
                            <th>基本满意(60-79分)</th>
                            <th>不满意(59分以下)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_cbdweval");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("state like '%3%' and (allname like '%" + list.get("searchkey") + "%' or year like '%" + list.get("searchkey") + "%')").get_page_desc("myid");
                            while (list.for_in_rows()) {
                                String a0 = "0", a1 = "0", a2 = "0", a3 = "0", a4 = "0";
                                RssListView list4 = new RssListView(pageContext, "sort");
                                list4.query("SELECT resume,companyid,type,degree,COUNT(*) as num FROM company_sug_list_view WHERE type=1 and draft=2 and examination=2 and handlestate=3 and deal=1 and companyid=" + list.get("myid") + " GROUP BY degree,type,resume");
                                while (list4.for_in_rows()) {
                                    if (list4.get("resume").equals("1")) {
                                        switch (list4.get("degree")) {
                                            case "1":
                                                a1 = list4.get("num");
                                                break;
                                            case "2":
                                                a2 = list4.get("num");
                                                break;
                                            case "3":
                                                a3 = list4.get("num");
                                                break;
                                            case "4":
                                                a4 = list4.get("num");
                                                break;
                                        }
                                    } else {
                                        a0 = list4.get("num");
                                    }
                                }
                                String my = "", jbmy = "", bmy = "";
                                if (!list.get("result").isEmpty()) {
                                    int result = Integer.valueOf(list.get("result"));
                                    if (result >= 80) {
                                        my = "" + result + "";
                                    } else if (80 > result && result >= 60) {
                                        jbmy = "" + result + "";
                                    } else {
                                        bmy = "" + result + "";
                                    }
                                }

                        %>
                        <tr ondblclick="ck_MdbBlclick();" idd="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td  class="w30"><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(a); %></td>
                            <td><% out.print(list.get("allname"));%></td>
                            <td><% out.print(Integer.valueOf(a0) + Integer.valueOf(a1) + Integer.valueOf(a2) + Integer.valueOf(a3) + Integer.valueOf(a4));%></td>
                            <td><% out.print(Integer.valueOf(a1) + Integer.valueOf(a2) + Integer.valueOf(a3) + Integer.valueOf(a4));%></td>
                            <td><%out.print(a0);%></td>
                            <td><%out.print(a1);%></td>
                            <td><%out.print(a2);%></td>
                            <td><%out.print(a3);%></td>
                            <td><%out.print(a4);%></td>
<!--                            <td><%out.print(list.get("impsorce").isEmpty() ? "0" : list.get("impsorce"));%></td>
                            <td><%out.print(list.get("sysscore").isEmpty() ? "0" : list.get("sysscore"));%></td>
                            <td><%out.print(list.get("scorescore").isEmpty() ? "0" : list.get("scorescore"));%></td>
                            <td><%out.print(list.get("cwheval").isEmpty() ? "0" : list.get("cwheval"));%></td>
                            <td><%out.print(list.get("qtdbeval").isEmpty() ? "0" : list.get("qtdbeval"));%></td>
                            <td><%out.print(list.get("tjydbeval").isEmpty() ? "0" : list.get("tjydbeval"));%></td>-->
                            <td><% out.print(my);%></td>
                            <td><% out.print(jbmy);%></td>
                            <td><% out.print(bmy);%></td>
                            <td><%out.print(list.get("cbdwnote"));%></td>
                            <td><%out.print(list.get("year"));%></td>
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
        <script src="controller.js" type="text/javascript"></script>
        <script>
                            $(".noscore").click(function () {
                                var score = $(this).parent().parent().find("[name='id']").val();
                                popuplayer.display("/evaluation/evaluation/score.jsp?id=" + score + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
                            })
                            function ck_MdbBlclick() {

                                $('tbody tr').dblclick(function () {

                                    popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 300});
//            popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 500});
                                })

                            }
        </script>
    </body>
</html>