<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.text.*"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
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
            .view{font-weight:bold;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" class="res"  style="float:right;margin-right:3%;">返回上一级</button>
<!--                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                
                <button type="button" transadapter="append" select="false" class="butadd">发起活动</button>
                 <button type="button" transadapter="delete" class="butdelect">删除</button>-->
                 <!--
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                
               
                <button type="button" transadapter="butview" class="butview">查看</button>
                <button type="button" transadapter="export" class="butreports">导出</button>
                  -->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <!--<th class="w30"><input name="all"  type="checkbox"></th>-->
                            <th>活动主题</th>
                            <th>活动类型</th>
                            <th>组织部门</th>
                            <th>活动地点</th>
                            <!--
                            <th>报名截止日</th>
                            -->
                             <th>发起日期</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                           
                            <!--<th>召集人</th>-->
                            <th>状态</th>
                             <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            CookieHelper cookie = new CookieHelper(request, response);
                            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                            //RssListView list = new RssListView(pageContext, "activitiesmy");
                            RssListView list = new RssListView(pageContext, "activities_userlist");
                            list.request();
                            list.pagesize = 30;
                            int a = 1;
//                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%'").get_page_desc("id");
                       
                         
                         
//                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' and department like '%" + URLDecoder.decode(list.get("department"), "utf-8") 
//                                    + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%'" + " and userid="+req.get("id")).get_page_desc("id");
                            list.select().where("classify=6" + " and auditState=2 and userid="+ req.get("id")).get_page_desc("id");
                            
                            String type = "参加视察";
                            while (list.for_in_rows()) {                              
                                 int classify = Integer.parseInt( list.get("classify") );
                                if ( classify < 6 || classify > 8 ) {
                                    continue;
                                }
                                if ( classify ==  6  ) {
                                    type = "参加视察";
                                }
                                else if ( classify == 7 ) {
                                    type = "参加调研";
                                }
                                else {
                                    type = "参加执法检查";
                                }
                        %>
                        <tr ondblclick="ck_dbcglclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <!--<td><input type="checkbox" name="id" value="<% // out.print(list.get("id")); %>" /></td>-->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print( type ); %></td>
                            <td><% out.print(list.get("department")); %></td>
                             <td><% out.print(list.get("place")); %></td>
                             <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                           
                            <!--<td><% out.print(list.get("realname")); %></td>-->
                           
                            <!--<td><% out.print(list.get("note")); %></td>-->
                            
                            
                            
                            <td>
                            <% 
                            if ( list.get("private").equals("3") ) {
                                  out.print("活动已结束");
                            }else {      
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
                                         out.print("活动中");
                                     }
                                     else if (  sysDay < beginDay ) {
                                          out.print("活动未开始");
                                     }
                                     else if (  sysDay > finishDay ) {
                                          out.print("活动已结束");
                                     }
                                 }
                                 else if ( sysMonth >  finishMonth ) {
                                      out.print("活动已结束");
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      out.print("活动未开始");
                                
                                }
                            }
                            else if ( sysYear  >  finishYear ) {
                                out.print("活动已结束");
                            }
                        }


                        %>
                                     
                        </td>
                            
                            
                             <td>
		            <span class="ys view" id="<% out.print(list.get("activitiesid")); %>" style="color:blue">查看内容</span>                          
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
                     popuplayer.display("/activities/start/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 500, height: 550});
                })
            });
            
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/activities/start/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
                })
            });
             $(".res").click(function () {
            history.go(-1);
            });
           //返回上一级
           
            </script>
        
    </body>
</html>