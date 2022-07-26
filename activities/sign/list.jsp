<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*,java.text.*"%>

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
               
                <!--<button type="button" transadapter="edit" class="butadd">手动报名</button>-->
                 <!--
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="198">删除</button>
                   -->
                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
              
                <!--<button type="button" transadapter="butview" class="butview" powerid="302">查看</button>-->
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>活动主题</th>
                            <th>活动类型</th>
                            <th>活动地点</th>
                            <th>组织部门</th>
                            <th>发起日期</th>
                            <th>报名截止时间</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            
                            <th>状态</th>
                            <th>操作</th>
                            <!--
                            <th>召集人</th>
                            -->
                           
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%                            
//                            CookieHelper cookie = new CookieHelper(request, response);
                            RssListView list = new RssListView(pageContext, "activitiesmy"); //activities_userlist
                            list.request();
                            list.pagesize = 30;
                            int a = 1;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" 
                                    + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" 
                                    + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" 
                                    + URLDecoder.decode(list.get("realname"), "utf-8") + "%'" + " and enroll=1").get_page_desc("id");
                              //+ URLDecoder.decode(list.get("realname"), "utf-8") + "%' and endshijian>=" + System.currentTimeMillis() / 1000 + " and enroll=1").get_page_desc("id");
                            
                            if (  cookie.Get("powergroupid").equals("5") ) {   //ding  
                                //list = new RssListView(pageContext, "activities_userlist");
                                //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and endshijian>=" + System.currentTimeMillis() / 1000).get_page_desc("id");

                            } else //                                if (cookie.Get("powergroupid").equals("22")) {
                            //                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and mission=" + UserList.MyID(request) + " and endshijian>=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            //                            } else 
                            {
//                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") 
//                                        + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") 
//                                        + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") 
//                                        + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") 
//                                        + "%' and userid=" + UserList.MyID(request) + " and endshijian>=" + System.currentTimeMillis() / 1000).get_page_desc("id");
                            }
                            
                            //added by ding 
                            RssList userlist = new RssList(pageContext, "activities_userlist");
                            userlist.request();
                            //end
                            int joinDone = 0 ;
                            
                            int userFound = 0 ; // 新活动还没报名用户 0: 没有找到记录
                            while (list.for_in_rows()) {
                                joinDone = 0 ;
                                //if (cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16") ) {
                                if ( cookie.Get("powergroupid").equals("5")) { //ding   
                                    //RssList userlist = new RssList(pageContext, "activities_userlist");
                                  
//                                    userlist.select().where("activitiesid=?", list.get("id")).get_first_rows();
                                    userlist.clear("jointype"); //必须清楚，否则记住第一次找到的数据
                                    userlist.select().where("activitiesid="+list.get("id") +" and userid="+ UserList.MyID(request) ).get_first_rows();
                                   // if ( userlist.totalrows == 0 ) {
                                        //如果没有记录，说明还没有用户报名.需要做特殊处理（不是好的解决方案)
                                        //userFound = 0 ;
                                   // }
                                    userFound = userlist.totalrows;
                        %>
                        <tr ondblclick="ck_dbchlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                                <%
                                } else {
                                %>
                        <tr ondblclick="ck_dbchlclick();" idd="<% out.print(list.get("idd")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("idd")); %>" /></td>
                                <%
                                    }
                                %>
                            <td><% out.print(list.get("title"));%></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("place")); %></td>
                            <td><% out.print(list.get("department")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("endshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                             <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                           
                            <td>
                                <% 
                                
                        //   time                          
                           
                            Date nowTime = new Date(System.currentTimeMillis());
                            //SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
                            SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            String retStrFormatNowDate = sdFormatter.format(nowTime);
                            
                            String datasplit [] = retStrFormatNowDate.split("-");                 
                            int sysYear = Integer.valueOf( datasplit[0]).intValue();
                            int sysMonth = Integer.valueOf( datasplit[1]).intValue();
                            int sysDay = Integer.valueOf( datasplit[2]).intValue();
                           
                            nowTime = new Date(Long.parseLong( list.get("finishshijian") )*1000);
                            sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            retStrFormatNowDate = sdFormatter.format(nowTime);
                            String datasplit1 [] = retStrFormatNowDate.split("-");          
                            int beginYear = Integer.valueOf( datasplit1[0]).intValue();
                            int beginMonth = Integer.valueOf( datasplit1[1]).intValue();
                            int beginDay = Integer.valueOf( datasplit1[2]).intValue();
                            
                         
                            
                            String Strtips = "<em style='color:orange;font-weight:bold;'>报名中</em>";
                            int needsignBtn = 1 ;
                            int isDeadline = 0 ;
                            if ( sysYear >=  beginYear && sysYear <=  beginYear ) {
                                 if ( sysMonth ==  beginMonth  ) {
                                     if ( sysDay == beginDay  ) {
                                         //out.print("活动中");
                                     }
                                     else if (  sysDay < beginDay ) {
                                          //out.print("活动未开始");
                                          //Strtips = "报名中";
                                          //needsignBtn = 1;
                                     }
                                      else if (  sysDay > beginDay ) {
                                          //out.print("活动未开始");
                                          Strtips = "<em style='color:#a9a9a9;font-weight:bold;'>报名已截止</em>";
                                          needsignBtn = 0;
                                          isDeadline = 1 ;
                                     }
                                    
                                 }
                                 else if ( sysMonth >  beginMonth ) {
                                      //out.print("活动已结束");
                                       Strtips = "<em style='color:#a9a9a9;font-weight:bold;'>报名已截止</em>";
                                       needsignBtn = 0 ;
                                       isDeadline =  1;
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      //Strtips = "<em style='color:#a9a9a9;font-weight:bold;'>报名未开始</em>"; 
                                      Strtips = "<em style='color:orange;font-weight:bold;'>报名中</em>";
                                      needsignBtn = 0 ;
                                
                                }
                            }
                            else if ( sysYear  >  beginYear ) {
                               //out.print("报名已截止");
                                 Strtips = "<em style='color:#a9a9a9;font-weight:bold;'>报名已截止</em>";
                                 needsignBtn = 0 ;
                                 isDeadline =  1;
                            }
                            //end

                            
                                
                                if ( cookie.Get("powergroupid").equals("7")) {
                                     //选工委账号登录                                    
                                    if ( list.get("maxperson").equals( list.get("currentperson") ) ) 
                                    out.print("<em style='color:red;font-weight:bold;'>报名已满</em>");   
                                    else {
                                     //out.print("报名中");
                                    long systemTime = System.currentTimeMillis()/1000;                                  
                                    long endshijian = Long.parseLong(list.get("finishshijian"));
                               
//                                    if ( systemTime >  endshijian ){
//                                        out.print("报名已截止"); 
//                                    }
//                                    else {
//                                    out.print("报名中"); 
//                                    }
                                       out.print(Strtips);  
                                    }
                                    
                                    
                                }
                                else {
                                    if( userlist.get("jointype").equals("2")){
                                        out.print("<em style='color:orange;font-weight:bold;'>已报名</em>");
                                        joinDone = 1 ;
                                        needsignBtn = 0 ;
                                    }else {
                                        if ( isDeadline == 1){
                                            out.print("<em style='color:#a9a9a9;font-weight:bold;'>报名已截止</em>"); 
                                            needsignBtn = 0;
                                        }else {
                                            if ( list.get("currentperson").equals( list.get("maxperson") )) {
                                            out.print("<em style='color:red;font-weight:bold;'>报名已满</em>");
                                            }
                                            else
                                            out.print("<em style='color:green;font-weight:bold;'>未报名</em>");
                                       // out.print(userlist.totalrows);
                                        }
                                        joinDone =  0 ;
                                    }
                                }
                                
                                
                                
                              
                                if ( list.get("maxperson").equals( list.get("currentperson") ) ) {
                                    joinDone = 1 ;
                                  
                                }
                                //
                                if (  cookie.Get("powergroupid").equals("5") ) {
                                    if ( ( userlist.get("jointype").equals("1" ) || joinDone == 0  ) && ( isDeadline == 0 ) ) {
                                        needsignBtn =  1;
                                    }
                                    
                                    if ( userFound > 0  ) {
                                        needsignBtn =  0 ;
                                    }
                                   
                                }else {
                                    needsignBtn =  0 ;
                                }
                                
                                if ( list.get("maxperson").equals( list.get("currentperson") ) ) {
                                    joinDone = 1 ;
                                    needsignBtn = 0 ;
                                }
                                
                                
                                %></td>
                            <td>
		            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">查看内容</span>  
                            <%
                             if( needsignBtn == 1  ){                          
//                             if( (  userlist.get("jointype").equals("1" )|| joinDone ==  0 ) && cookie.Get("powergroupid").equals("5") &&   needsignBtn == 1 ){
                            %>                            
                            | <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">报名</span> 
                            </td>    
                            <%
                            };
                            %>
                            
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
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/activities/sign/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 840, height: 480});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/sign/signview.jsp?id=" + id + "&TB_iframe=true", '报名', {width: 500, height: 550});
                })
            });
           
            </script>
        
        
    </body>
</html>