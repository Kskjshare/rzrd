<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>

<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
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
                <!--<button type="button" transadapter="edit" class="butadd">手动考勤</button>-->
                <!--
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="199">删除</button>
                -->
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>活动主题</th>
                            <th>报名类型</th>
                            <th>活动类型</th>
                            <th>组织部门</th>
                             <th>发起日期</th>
                             <!--
                            <th>报名截止日</th>
                             -->
                            <th>开始时间</th>
                             <th>结束时间</th>
                            <th>活动地点</th>
                            <!--
                            <th>召集人</th>
                            -->
                           <%      
                           if ( cookie.Get("powergroupid").equals("5") ) {
                           %>
                           <th>考勤状态</th>
                            <%      
                           }
                           %>
                            <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%      
                                  
                            String listID = "idd";
                            RssListView list = new RssListView(pageContext, "activities_userlist");
                            
                            if ( cookie.Get("powergroupid").equals("7") ){ //因为atcitivities_userlist表里面的myid 变成了代表的id。
                                list = new RssListView(pageContext, "activitiesmy");
                                listID = "id";
                            }
                            list.request();
                            list.pagesize = 30;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 10;
                            }
                            int a = 1;
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            if (cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16")) {
                                list = new RssListView(pageContext, "activities_userlist");
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            } else if (cookie.Get("powergroupid").equals("22")) {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and mission =" + UserList.MyID(request) + " and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            } 
                            else if ( cookie.Get("powergroupid").equals("7") ) { //选工委账号
//                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" 
//                                        + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" 
//                                        + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" 
//                                        + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and myid="
//                                        +UserList.MyID(request)+" and finishshijian>=" + System.currentTimeMillis() / 1000 
//                                        + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                                
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" 
                                        + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") 
                                        + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and myid="
                                        + UserList.MyID(request)
//                                        + " and finishshijian>=" + System.currentTimeMillis() / 1000  + " and beginshijian<=" + System.currentTimeMillis() / 1000 
                                ).get_page_desc("id");

                               
                            }
                            else {
//                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" 
//                                        + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") 
//                                        + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and userid="+UserList.MyID(request) 
//                                        +" and finishshijian>=" + System.currentTimeMillis() / 1000 + " and beginshijian<=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                                
//                                 list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" 
//                                        + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") 
//                                        + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and userid="+ UserList.MyID(request) 
//                                        ).get_page_desc("id");
                                //name field removed by ding     
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") 
                                        + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and userid="+ UserList.MyID(request) 
                                        ).get_page_desc("id");
                                }
                           
                            
//                            
//                            Date nowTime = new Date(System.currentTimeMillis());
//                            //SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
//                            SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
//                            String retStrFormatNowDate = sdFormatter.format(nowTime);
//                            String datasplit [] = retStrFormatNowDate.split("-");
//                  
//                            int sysYear = Integer.valueOf( datasplit[0]).intValue();
//                            int sysMonth = Integer.valueOf( datasplit[1]).intValue();
//                            int sysDay = Integer.valueOf( datasplit[1]).intValue();
                            
                            while (list.for_in_rows()) {
                                

                                 
                                //added by ding for ignore records of outday
                                String stips = "系统时间";
                                 String etips = "系统时间";
                                //long systemTime = System.currentTimeMillis() / 1000; 
                                long systemTime = System.currentTimeMillis()/1000;   
                                
                                long beginshijian = Long.parseLong(list.get("beginshijian"));
                                long finishshijian = Long.parseLong(list.get("finishshijian"));
                                
                                 if ( systemTime < beginshijian ) {
                                     stips = "系统时间小于开始时间";
                                 }else {
                                     stips = "系统时间大于开始时间";
                                 }
                                  if ( systemTime < finishshijian ) {
                                     etips = "系统时间小于结束时间";
                                 }else {
                                     etips = "系统时间大于结束时间";
                                 }
                                
                                  
                            int isActivityOngoing = 1 ;
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

                            if ( sysYear >=  beginYear && sysYear <=  finishYear ) {
                                 if ( sysMonth ==  beginMonth && sysMonth ==  finishMonth ) {
                                     if ( sysDay >= beginDay && sysDay <= finishDay  ) {
                                         //out.print("活动中");
                                        
                                     }
                                     else if (  sysDay < beginDay ) {
                                         // out.print("活动未开始");
                                         isActivityOngoing =  0 ;
                                         
                                     }
                                     else if (  sysDay > finishDay ) {
                                          //out.print("活动已结束");
                                          isActivityOngoing = 0 ;
                                           
                                     }
                                 }
                                 else if ( sysMonth >  finishMonth ) {
                                      //out.print("活动已结束");
                                      isActivityOngoing =  0 ;
                                     
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      //out.print("活动未开始");
                                      isActivityOngoing = 0;
                                       
                                
                                }
                            }
                            else if ( sysYear  >  finishYear ) {
                                //out.print("活动已结束");
                                isActivityOngoing = 0 ;
                                 
                            }


                                         
                             
                            if ( isActivityOngoing == 0 ){
                                 continue;
                            }

                                

                        %>
                        <tr ondblclick="ck_dbcilclick();" idd="<% out.print(list.get(listID)); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print( a ); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get(listID)); %>" /></td>
                            
                           

                            <td><% out.print(list.get("title"));%></td>
                            <td><%
                                 if ( list.get("enroll").equals("1") ){
                                    out.print( "自愿报名" );
                                 }
                                 else {
                                     out.print( "指定报名" );
                                 }
                            %></td> 
                            
                            <td><% out.print(list.get("name"));%></td>
                            <td><% out.print(list.get("department"));%></td>
                            
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                             
                            <!--
                            <td rssdate="<% out.print(list.get("endshijian")); %>,yyyy-MM-dd" ></td>
                            -->
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>
                            
                             <% if ( cookie.Get("powergroupid").equals("5")) { %>
                                 
                             <td>
                                <% 
                                if(list.get("attendancetype").equals("2")){
                                    out.print("<em style='color:#00cc33;font-weight:bold;'>已考勤</em>");
                                }else {
                                    out.print("<em style='color:#999900;font-weight:bold;'>未考勤</em>");
                                }
                                %>
                             </td>
                             <% }%>
                             
                            <td>                                              
                            <span class="ys chakan" id="<% out.print(list.get(listID)); %>" style="color:blue;font-weight: bold;">查看内容</span> 
                            <%
                            if(list.get("attendancetype").equals("1")){
                            %>
                            | <span class="ys kaoqin" id="<% out.print(list.get(listID)); %>" style="color:blue;font-weight: bold;">考勤</span> 
                            <%
                                }
                            %>
                            </td>
                            <!--
                            <%
                                if ((cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16"))) {
                            %>
                            <td><% out.print(list.get("realname")); %></td>
                            <%
                            } else {
                            %>
                            <td><% out.print(list.get("myname")); %></td>
                            <%
                                }
                            %>
                            -->
                           
                            <!--<td><% out.print(list.get("note")); %></td>-->
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
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/activities/ongoing/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 840, height: 580});
                })
            });
            
             $(function(){
                ﻿$(".kaoqin").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/ongoing/attendance.jsp?id=" + id + "&TB_iframe=true", '考勤', {width: 600, height:380});
                })
            });
        </script>
    </body>
</html>