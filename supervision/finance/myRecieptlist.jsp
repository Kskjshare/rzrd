<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "user_delegation");
    //RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
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
<!--                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <!--<button type="button" transadapter="file" class="butdfile">归档</button>-->

                <button type="button" transadapter="butview" class="butview">查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>发起者</th>
                            <th>发布时间</th>                          
                            <th>当前进度</th>
                            <!--
                            <th>上会时间</th>
                            <th>会次</th>
                            -->
                            
                            <th>操作</th>
                            <!--<th>管理</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                           
                            boolean isMyRecieveTask;
                            String cmd_str = " ";
                            boolean isShowcmd = true ;
                            boolean isShowDelete = true ;
                            boolean isShowEdit = true ;
                            String class_str = "submit";
                            String progress =  "<b style='color:CadetBlue;font-size:14px;' >办理中</b>" ;
                            RssList list = new RssList(pageContext, "supervision_finance");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;                         
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and myid="+UserList.MyID(request)).get_page_desc("id");
                            list.select().where("state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and typeid="+ req.get("typeid") ).get_page_desc("id");
                            while (list.for_in_rows()) {
                            user.select().where("myid=" + list.get("initiator")).get_first_rows();
                                 
                            isMyRecieveTask = false ; 
                            String organizationid = list.get("userroleid");
                            
                            String[] organizationids  = organizationid.split(","); ;
                            if ( !organizationid.isEmpty() ) {
                               
                                organizationids = organizationid.split(",");
                                for ( int i = 0 ; i < organizationids.length; i ++ ) {
                                   if ( UserList.MyID(request).equals( organizationids[i] )) {
                                       isShowcmd  = true;
                                       isMyRecieveTask = true ;
                                       isShowDelete = false ;
                                     
                                       cmd_str = "提交办理情况报告";
                                       class_str = "assign";
                                       break;
                                   }   
                                }   
                            }
                           
                             if ( !isMyRecieveTask  ) {
                                 //we will skip when my account doesn't belong to this task 
                                 continue;
                             }
                                
                                
                                
                           
                            if ( list.get("state").equals("10") ) {
                               
                                progress = "<b style='color:CadetBlue;font-size:14px;' >办理中</b>";                            
                                isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("11") ) {
                               
                                progress = "<b style='color:CadetBlue;font-size:14px;' >已提交办理情况报告</b>";                            
                                isShowEdit = false ;
                            }


                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td ><% out.print(list.get("title"));%><%out.print(UserList.MyID(request));%></td>
                            <td><% out.print( user.get("realname") );%></td>
                            <!--<td><% out.print(list.get("reviewclass"));%></td>-->
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <!--<td rssdate="<% out.print(list.get("inspecttime")); %>,yyyy-MM-dd" ></td>-->
                            <!--<td><% out.print(list.get("place")); %></td>-->                          
                            <td><%out.print(progress); %></td>
                             
                            <td>
                            <%
                            if ( isShowcmd ){
                            %>      
                            <span class="<% out.print(class_str);%>"  id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" ><%out.print(cmd_str);%></span>   |       
                            <%
                            }
                            %>
                            
                            <%
                            if ( isShowDelete ){
                            %>      
                            <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span>  |                       
                            <%
                            }
                            %>   
                            
                            <%
                            if ( isShowEdit ){
                            %>                              
                          <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span>  | 
                            <%
                            }
                            %>   
                        
                            <span class="ys viewDetail" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看详情</span>  
                            </td>
                            
<!--                            <td>
                            <a href="duty/list.jsp?id=<% out.print(list.get("id")); %>&status=1">议题管理页面</a>
                            </td>-->
                            
                            
                            
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
                popuplayer.display("/supervision/finance/detailview.jsp?id=" + id , '查看详情', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".submit").click(function(){
                    let id = $(this).attr("id");
                 popuplayer.display("/supervision/finance/submit.jsp?id=" + id, '提交主任会议审议', {width: 830, height: 460});
                 //popuplayer.display("/supervision/topic/duty/inspectReport.jsp?id=" + id, '主任会议审议', {width: 830, height: 460});
                })
            });
            
            $(function(){
                ﻿$(".assign").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/finance/assignHandleReport.jsp?id=" + id , '提交办理情况报告', {width: 420, height: 180});
                })
            });
              $(function(){
                ﻿$(".report").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/finance/reportview.jsp?id=" + id , '主任会议汇报', {width: 830, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/finance/edit.jsp?id=" + id , '编辑', {width: 830, height: 560});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/finance/delete_1.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
        </script>
    </body>
</html>