<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%
    StaffList.IsLogin(request, response);
//    RssList list = new RssList(pageContext, "evaluation_batch");
    RssList list = new RssList(pageContext, "permission");
    RssList scores = new RssList(pageContext, "evaluation_score");
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    list.request();
    
    RssListView users = new RssListView(pageContext, "user_delegation");
    users.request();
    int totalDelegate = 0;
    users.pagesize = 30;
    users.select().where("code like '%" + URLDecoder.decode(users.get("code"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(users.get("realname"), "utf-8") + "%' and state=2").get_page_desc("myid");
    totalDelegate = users.totalrows ;
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="append" select="false" class="butadd">添加</button>
               
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>名称</th>
                            <th>测评人数</th>
                            <th>状态</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            int a = 1;
//                            String sql = "1=1";
                            String sql = "";
                            sql += "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'";
                            list.select().where(sql).get_page_desc("id");
                            
                            String state = "未开始";
                            while (list.for_in_rows()) {
                                scores.select("count(*) as num").where("batchid=" + list.get("id")).get_first_rows();
                                
                               
                                //时间判断
                               
                                Date nowTime = new Date(System.currentTimeMillis());
                                //SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
                                SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                                String retStrFormatNowDate = sdFormatter.format(nowTime);

                                String datasplit [] = retStrFormatNowDate.split("-");                 
                                int sysYear = Integer.valueOf( datasplit[0]).intValue();
                                int sysMonth = Integer.valueOf( datasplit[1]).intValue();
                                int sysDay = Integer.valueOf( datasplit[2]).intValue();

                                nowTime = new Date(Long.parseLong( list.get("beginshijian") )*1000);
                                sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                                retStrFormatNowDate = sdFormatter.format(nowTime);
                                String datasplit1 [] = retStrFormatNowDate.split("-");          
                                int beginYear = Integer.valueOf( datasplit1[0]).intValue();
                                int beginMonth = Integer.valueOf( datasplit1[1]).intValue();
                                int beginDay = Integer.valueOf( datasplit1[2]).intValue();

                                nowTime = new Date(Long.parseLong( list.get("finishshijian") )*1000);
                                sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                                retStrFormatNowDate = sdFormatter.format(nowTime);
                                String datasplit2 [] = retStrFormatNowDate.split("-");          
                                int finishYear = Integer.valueOf( datasplit2[0]).intValue();
                                int finishMonth = Integer.valueOf( datasplit2[1]).intValue();
                                int finishDay = Integer.valueOf( datasplit2[2]).intValue();

                                if ( sysYear >=  beginYear && sysYear <=  finishYear ) {
                                    //out.print("111111"); out.print(sysMonth);out.print("|");out.print(beginMonth);out.print("|");out.print(finishMonth);
                                     if ( sysMonth ==  beginMonth && sysMonth ==  finishMonth ) {
                                         //out.print("222222");
                                         if ( sysDay >= beginDay && sysDay <= finishDay  ) {
                                            state = "测评进行中";
                                            
                                         }
                                         else if (  sysDay < beginDay ) {
                                            state = "测评未开始";
                                            
                                         }
                                         else if (  sysDay > finishDay ) {
                                              //out.print("活动已结束");
                                            state = "测评已结束";
                                            
                                         }
                                     }
                                     else if ( sysMonth >  finishMonth ) {
                                          
                                        state = "测评已结束";
                                        

                                    }
                                    else if ( sysMonth <=  finishMonth  && sysMonth >=  beginMonth  ) {
                                          
                                        state = "测评进行中";
                                        

                                    }
                                    else if ( sysMonth <  beginMonth ) {
                                        
                                        state = "测评未开始";
                                        

                                    }
                                }
                                else if ( sysYear  >  finishYear ) {
                                    
                                     state = "测评已结束";
                                }
                                
                                
                                if ( list.get("switch").equals("0")) {
                                     state = "测评已关闭";
                                }


                                //end









                        %>
                        <tr idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>

                            <!--<td><% scores.write("num"); %>人</td>-->
                            <td><%
                                if ( list.get("switch").equals("1")) {
                                    out.print( totalDelegate );
                                }
                                else {
                                    
                                }
                                ;
                            %></td>
                            <!--<td evaluationstate="<% //list.write("state");%>"></td>-->
                            <td evaluationstate="<%out.print(state);%>"></td>
<!--                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd HH:mm:ss" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd HH:mm:ss" ></td>-->
                            
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                            <td>
                                <%
                                    String html = "";
//                                    if (list.get("state").equals("0")) {
//                                        html += "<a style='text-decoration: none;' href='javascript:start(\"" + list.get("id") + "\")'>删除</a>&nbsp;&nbsp;|&nbsp;&nbsp;";
//                                    }else if (list.get("state").equals("1")) {
//                                        html += "<a style='text-decoration: none;' href='javascript:close(\"" + list.get("id") + "\")'>编辑</a>&nbsp;&nbsp;|&nbsp;&nbsp;";
//                                    } else {
//                                        html+="";
//                                    }
                                    
                                        html += "<a style='text-decoration: none;font-weight:bold;' href='javascript:edit(\"" + list.get("id") + "\")'>编辑</a>&nbsp;&nbsp;|&nbsp;&nbsp;";
                                       
//                                    html += "&nbsp;|&nbsp;<a style=' text-decoration: none;' href='javascript:flowStepRecord(\"" + list.get("id") + "\");'>日志</a>";
                                    out.print(html);
                                %>
                                <!--<a href="score_list.jsp?batchid=<%list.write("id");%>">查看测评情况</a>-->
                                <a style="font-weight:bold;" href="/opinion/evaluation/totalEvaluationList.jsp">查看测评情况</a>
                                
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
        </script>
        <script src="controller.js"></script>
        <script>
            function start(id) {
                popuplayer.display("/activities/evaluation/start.jsp?id=" + id + "&TB_iframe=true", '手动开始', {width: 300, height: 100});
            }
            function close(id) {
                popuplayer.display("/activities/evaluation/close.jsp?id=" + id + "&TB_iframe=true", '手动结束', {width: 300, height: 100});
            }
            function edit(id) {
                popuplayer.display("/activities/evaluation/permission_edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 800, height: 550});
            }
            ﻿transadapter["append"] = function (t)
            {
                popuplayer.display("/activities/evaluation/permission_append.jsp?", '发起测评', {width: 800, height: 550});
            }
        </script>
    </body>
</html>