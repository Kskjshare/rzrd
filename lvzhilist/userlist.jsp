<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州市区、市、县、乡人大代表履职信息表", "utf-8") + ".xls");
    response.addHeader("Content-Type", "application/ms-excel");
    response.addHeader("Pragma", "no-cache");
    response.addHeader("Expires", "0");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
                    <thead>
                        <tr>
                            <th class="w30"></th>
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
                            <th>代表评价</th>
                            <th>总履职数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "user_delegation");
                            RssListView list3 = new RssListView(pageContext, "sort");
                            list.request();
                            int a = 1;
                            list.pagesize = 100000;//梁小竹修改，修改原因，如果不写的话，默认查数据库只会查十条
//                            System.out.println("-+-+-+-+-" + list.get("relationid"));//测试说明拿到数据但是只解析了十条
                            list.select().where("state=2 and myid in ("+ list.get("relationid") +")").get_page_desc("myid");
                            while (list.for_in_rows()) {
                                int num = 0;
                                String[] ta = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
                                
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
        <!--</table>-->
    </body>
   
    <ml>