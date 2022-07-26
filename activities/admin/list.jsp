<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.text.*"%>
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <!--<button type="button" transadapter="append" select="false" class="butadd">发起活动</button>-->
                <!--<button type="button" transadapter="attendance" class="butedit">考勤情况</button>-->
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <!--<th>召集人</th>-->
                            <th>活动主题</th>
                            <th>报名类型</th>
                            <th>活动类型</th>
                            <th>组织部门</th>
                            <!--
                            <th>报名截止日</th>
                            -->
                            <th>发起日期</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>活动地点</th>
                            <th>活动状态</th>
                            
                            <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <!--sal>(select SAL from emp where ename='CLARK')-->
                        <%
                            CookieHelper cookie = new CookieHelper(request, response);
                            String powergroupid = cookie.Get("powergroupid");
                            RssListView list = new RssListView(pageContext, "activitiesmy");
                            
                            //added by ding
                            RssListView userlist = new RssListView(pageContext, "activities_userlist");
                            userlist.pagesize = 10;
                            userlist.request();
                           
                            list.request();
                            list.pagesize = 30;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 10;
                            }
                            int a = 1;
                           
                            String sql = "";
                            if (powergroupid.equals("22")) {
                                sql = "myid =" + UserList.MyID(request);
//                                        "id=(SELECT activitiesid FROM activities_userlist_list WHERE  userid=" + UserList.MyID(request) + " or myid =" + UserList.MyID(request) + ")";
                            } else {
                                sql = "id in (SELECT activitiesid FROM activities_userlist_list WHERE userid=" + UserList.MyID(request) + ") or myid =" + UserList.MyID(request);
                                if (powergroupid.equals("16")) {
                                    sql = "myid <>0";
                                }
                            }
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td><% out.print(list.get("realname")); %></td>-->
                            <td><% out.print(list.get("title")); %></td>
                           <td><%
                                 if ( list.get("enroll").equals("1") ){
                                    out.print( "自愿报名" );
                                 }
                                 else {
                                     out.print( "指定报名" );
                                 }
                            %></td>  
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("department")); %></td>
                            
                            <!--
                            <td rssdate="<% out.print(list.get("endshijian")); %>,yyyy-MM-dd" ></td>
                            -->
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>
                          
                            
<!--                             <td><%
                                userlist.select().where("activitiesid="+ list.get("id") + " and userid="+ UserList.MyID(request) ).get_page_desc("id");
                                //userlist.select().where("userid="+ UserList.MyID(request) ).get_page_desc("id");
                                while (userlist.for_in_rows()) {
                                    
//                                    if ( list.get("private").equals("1") ) {
//                                        
//                                        if ( list.get("activityState").equals("0") ) {
//                                          out.print( "<em style='color:#00cc33;font-weight:bold;'>未审核</em>" );   
//                                        }
//                                        else {
//                                             out.print( "<em style='color:#999900;font-weight:bold;'>已审核</em>" );
//                                        }
//                                        
//                                        
//                                    }else 
                                    {
                                        if ( userlist.get("attendancetype").equals("1") ) {
                                        out.print( "<em style='color:#00cc33;font-weight:bold;'>未考勤</em>" ); 
                                        }
                                        else {
                                            out.print( "<em style='color:#999900;font-weight:bold;'>已考勤</em>" );

                                        }
                                        }
                                    
                                  
                                    
                                    
                                }
                             %></td>-->
                             
                             
                             
                         <td>
                        <% 
                            
                             long systemTime1 = System.currentTimeMillis();                                  
                            long beginshijian1 = Long.parseLong( list.get("beginshijian") );
                            long finishshijian1 = Long.parseLong( list.get("finishshijian") );
                            
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

                            if ( sysYear ==  beginYear && sysYear ==  finishYear ) {
                                 if ( sysMonth ==  beginMonth && sysMonth ==  finishMonth ) {
                                     if ( sysDay >= beginDay && sysDay <= finishDay  ) {
                                         out.print("<em style='color:orange;font-weight:bold;'>活动中</em>");
                                     }
                                     else if (  sysDay < beginDay ) {
                                          out.print("<em style='color:red;font-weight:bold;'>活动未开始</em>");
                                     }
                                     else if (  sysDay > finishDay ) {
                                          out.print("<em style='color:#a9a9a9;font-weight:bold;'>活动已结束</em>");
                                     }
                                 }
                                 else if ( sysMonth >  finishMonth ) {
                                      out.print("<em style='color:#a9a9a9;font-weight:bold;'>活动已结束</em>");
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      out.print("<em style='color:red;font-weight:bold;'>活动未开始</em>");
                                
                                }
                            }
                            else if ( sysYear  >  finishYear ) {
                                out.print("<em style='color:#a9a9a9;font-weight:bold;'>活动已结束</em>");
                            }   
                             %>
                        </td>
                    
                             
                             
                            
                            <!--<td><% out.print(list.get("note")); %></td>-->
                             <td>
		            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">查看内容</span> 
                            <% 
                            if (cookie.Get("powergroupid").equals("5")){
                            %> 
                            <%
                               }else{
                            %>
                             |  <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">删除</span>
                           
                            <%
                               };
                            %>
                            
                            
                              | <span class="ys kaoqin" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">考勤情况</span>
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
        <script src="controller.js"></script>
             <script>
         $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/activities/admin/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 800, height: 640});
                })
            });
            
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/admin/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 400, height: 120});
                })
            });
             $(function(){
                ﻿$(".kaoqin").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/admin/attendanceDetail.jsp?id=" + id + "&TB_iframe=true", '考勤情况', {width: 850, height: 480});
                })
            });
           
            </script>
    </body>
</html>