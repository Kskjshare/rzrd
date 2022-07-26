<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="file" class="butdfile">归档</button>

                <button type="button" transadapter="butview" class="butview">查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>视察主题</th>
                            <th>发布时间</th>
                            <th>视察时间</th>
                            <th>视察地点</th>
                            <th>状态</th>
                            <!--
                            <th>上会时间</th>
                            <th>会次</th>
                            -->
                            
                            <th>操作</th>
                            <th>管理</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "supervision_topic");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td ><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("reviewclass")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("inspecttime")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>                          
                            <td><% 
                                if ( list.get("progress").equals("1") )
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >视察中</b>" ); 
                                else if ( list.get("progress").equals("2") )
                                    out.print( "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>" ); 
                                else if ( list.get("progress").equals("2") )
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >办理中</b>" );
                            %></td>
                         
                            
                            <td>
                            
                             <%
                             if ( list.get("progress").equals("1") ){
                             %>  
                            
                            <span class="ys submitToMeeting" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >主任会议审议</span> 
                            | <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span> 
                            | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span> 
                            | <span class="ys viewDetail" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看详情</span>  
                            <% 
                                }else if ( list.get("progress").equals("2") ){
                            %>  
                            
                            <span class="ys jiaoban" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >交办</span> 
                            |<span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span> 
                            |<span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span> 
                            |<span class="ys viewDetail" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看详情</span>
                            <% 
                            }
                            %>  
                                  
                            
                            <!--a href="duty/list.jsp?id=<% out.print(list.get("id")); %>&status=1">议题管理页面</a-->
                            </td>
                            
                            <td>
                           
                            <a href="duty/list.jsp?id=<% out.print(list.get("id")); %>&status=1">议题管理页面</a>
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
                ﻿$(".viewDetail").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/topic/inspectbutview.jsp?id=" + id + "&TB_iframe=true", '查看详情', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".submitToMeeting").click(function(){
                    let id = $(this).attr("id");
                 popuplayer.display("/supervision/inspection/submit.jsp?id=" + id + "&TB_iframe=true", '提交主任会议审议', {width: 830, height: 460});
                 //popuplayer.display("/supervision/topic/duty/inspectReport.jsp?id=" + id, '主任会议审议', {width: 830, height: 460});
                })
            });
            
              $(function(){
                ﻿$(".jiaoban").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/topic/duty/assigneview.jsp?id=" + id , '交办', {width: 830, height: 260});
                })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/topic/edit.jsp?id=" + id , '编辑', {width: 830, height: 560});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/topic/delete_1.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
        </script>
    </body>
</html>