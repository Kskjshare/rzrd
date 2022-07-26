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
                            <th>调研主题</th>
                            <th>发布时间</th>
                            <th>调研时间</th>
                            <th>调研地点</th>
                            <th>状态</th>
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
                            String progress =  "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ;
                            RssList list = new RssList(pageContext, "supervision_inspection");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;                         
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and myid="+UserList.MyID(request)).get_page_desc("id");
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and typeid="+ req.get("typeid") ).get_page_desc("id");

                            while (list.for_in_rows()) {
                            isMyRecieveTask = false ; 
                            boolean needpreview = false ;
                            isShowDelete = false ;
                            isShowEdit = false ;
                          
                            if ( list.get("previewleadername").contains( UserList.MyID(request))  ) {//如果是状态为1 ，并且需要领导预审的话，
                                isMyRecieveTask = true ;
                                needpreview = true ;
                            }
                            
                            
//                            if ( list.get("state").equals("1") && list.get("leaderpreview").equals("1") ) { //如果是状态为1 ，并且需要领导预审的话，
//                              if ( list.get("previewleadername").contains(UserList.MyID(request)) ) {
//                                isMyRecieveTask = true ;
//                                needpreview = true ;
//                              }
//                            }
                           
                             if ( !isMyRecieveTask  ) {
                                 //we will skip when my account doesn't belong to this task 
                                 continue;
                             }
                                
                                
                                
                            if ( list.get("state").equals("1") ) {
                               progress =  "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ;
                               cmd_str = "提交主任会议审议";
                               if ( needpreview ) { //需要审批
                                    progress =  "<b style='color:CadetBlue;font-size:14px;' >待审阅</b>" ;
                                    cmd_str = "审阅";
                                    class_str = "preview";
                               }
                             
                            }
                            else if ( list.get("state").equals("2") ) {
                             
                                if ( list.get("leaderpreview").equals("1") ) {
                                progress = "<b style='color:DarkOrange;font-size:14px;' >已审阅</b>";
                                isShowcmd  = false ;
                                }
                                else {
                                    isShowcmd = true ;
                                }
                               
                            }
                            else if ( list.get("state").equals("3") ) {
                              
                                progress = "<b style='color:DarkOrange;font-size:14px;' >调研中</b>";
                                cmd_str = "主任会议汇报";
                                class_str = "report";
                                isShowEdit = false ;

                                
                            }
                            else if ( list.get("state").equals("4") ) {
                               
                                progress = "<b style='color:CadetBlue;font-size:14px;' >调研已经完成</b>";
                                isShowcmd = false;
                                isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("5") ) {
                                 if ( list.get("leaderpreview").equals("1") ) {
                                   progress = "<b style='color:CadetBlue;font-size:14px;' >不需要提交主任会议</b>";
                                   isShowcmd  = false ;     
                                 }
                                 else {
                                 progress = "<b style='color:DarkOrange;font-size:14px;' >调研报告和交办意见审议中</b>";
                                 isShowcmd  = false ;                             
                                
                                 cmd_str = "审议调研报告和交办意见完成";
                                 class_str = "auditFinish2";
                                 
                                 isShowEdit = false ;
                                 }
                            }
                            else if ( list.get("state").equals("6") ) {
                                 progress = "<b style='color:CadetBlue;font-size:14px;' >调研报告和交办意见审议结束</b>";
                                 isShowcmd  = false ;                             
                                 cmd_str = "交办";
                                 class_str = "jiaoban";
                                 
                                isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("7") ) {
                                progress = "<b style='color:DarkOrange;font-size:14px;' >承办单位办理中</b>";
                                cmd_str = "主任会议汇报";
                                isShowcmd  = true ;              
                                class_str = "report";                          
                                isShowEdit = false ;
                            }
                             else if ( list.get("state").equals("8") ) {
                                 progress = "<b style='color:CadetBlue;font-size:14px;' >调研已完成</b>";
                                 isShowcmd  = false ;                             
                                
                                
                                 isShowEdit = false ;
                            }


                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td ><% out.print(list.get("title"));%></td>
                            <td><% out.print(list.get("reviewclass"));%></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("inspecttime")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>                          
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
                popuplayer.display("/supervision/investigation/inspectbutview.jsp?id=" + id + "&TB_iframe=true", '查看详情', {width: 830, height: 360});
                })
            });
            $(function(){
                ﻿$(".submit").click(function(){
                    let id = $(this).attr("id");
                 popuplayer.display("/supervision/investigation/submit.jsp?id=" + id + "&TB_iframe=true", '提交主任会议审议', {width: 830, height: 460});
                 //popuplayer.display("/supervision/topic/duty/inspectReport.jsp?id=" + id, '主任会议审议', {width: 830, height: 460});
                })
            });
            
            $(function(){
                ﻿$(".assign").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/investigation/assignview.jsp?id=" + id , '交办', {width: 830, height: 460});
                })
            });
              $(function(){
                ﻿$(".report").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/investigation/reportview.jsp?id=" + id , '主任会议汇报', {width: 830, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/investigation/edit.jsp?id=" + id , '编辑', {width: 830, height: 560});
                })
            });
            
            
            
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/investigation/delete.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
            
             $(function(){
                ﻿$(".preview").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/investigation/preview.jsp?id=" + id , '审阅', {width: 830, height: 320});
                })
            });
        </script>
    </body>
</html>