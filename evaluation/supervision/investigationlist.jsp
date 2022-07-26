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
<!--                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <!--<button type="button" transadapter="file" class="butdfile">归档</button>-->

                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">标题</th>
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
                            <!--<th>管理</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                           
                            String cmd_str = " ";
                            boolean isShowcmd = true ;
                            boolean isShowDelete = true ;
                            boolean isShowEdit = true ;
                            boolean isShowFinishBtn = false ;
                            String class_str = "submit";
                            String progress =  "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ;
                            RssList list = new RssList(pageContext, "supervision_inspection");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
                           
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and myid="+UserList.MyID(request)).get_page_desc("id");
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'" + "and taskDone=1 and typeid=9 and myid="+UserList.MyID(request)).get_page_desc("id");
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'" + "and taskDone=1 and typeid=9").get_page_desc("id");
                           
                     
                           
                            while (list.for_in_rows()) {
                                isShowFinishBtn = false ;
                            if ( list.get("state").equals("1") ) {
                                if ( list.get("leaderpreview").equals("1") ) { //需要预审
                                progress =  "<b style='color:CadetBlue;font-size:14px;' >待审阅</b>" ;
                               //cmd_str = "待审阅";
                               isShowcmd = false ;
                               }else{
                               progress =  "<b style='color:DarkOrange;font-size:14px;' >视察方案主任会议审议中</b>" ;
                               cmd_str = "视察方案提交主任会议审议";
                               cmd_str = "审议完成";
                               class_str = "auditFinish";
                               }
                             
                            }
                            else if ( list.get("state").equals("2") ) {
                             
                               if ( list.get("leaderpreview").equals("1") ) { //需要预审
                               progress =  "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ;
                               cmd_str = "视察方案提交主任会议审议";
                               class_str = "solutionsubmit";
                               }
                               else {
                                progress = "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>";
                                cmd_str = "交办";
                                class_str = "assign";
                                isShowEdit = false ;
                              
                               }
                               
                            }
                            else if ( list.get("state").equals("3") ) {
                              
                                if ( list.get("leaderpreview").equals("1") ) {//需要预审
                                progress = "<b style='color:DarkOrange;font-size:14px;' >审议视察方案中</b>";                       

                                     cmd_str = "审议方案完成";
                                    class_str = "auditFinish";
                                    isShowEdit = false ;
                                }
                                else {
                                
                                    progress = "<b style='color:DarkOrange;font-size:14px;' >视察中</b>";
                                    cmd_str = "主任会议汇报";
                                    isShowcmd  = false ;
                                    isShowEdit = false ;
                                    String organizationid = list.get("organizationid");
                                    String[] organizationids = organizationid.split(",");
                                    for ( int i = 0 ; i < organizationids.length; i ++ ) {
                                       if ( UserList.MyID(request).equals( organizationids[i] )) {
                                           isShowcmd  = true;
                                           break;
                                       }   
                                    }
                                }
                                
                            }
                            else if ( list.get("state").equals("4") ) {
                               
                                  progress = "<b style='color:DarkOrange;font-size:14px;' >视察中</b>";
                                    cmd_str = "调研报告和交办意见提交主任会议审议";
                                  
                                    isShowcmd  = true ;
                                    isShowEdit = false ;
                                    class_str = "assign";
                                    isShowFinishBtn = true ;
 
                                }
                             else if ( list.get("state").equals("5") ) {
                                 progress = "<b style='color:DarkOrange;font-size:14px;' >视察报告和交办意见审议中</b>";
                                 isShowcmd  = true ;                             
                                
                           
                                 cmd_str = "视察报告和交办意见审议完成";
                                 class_str = "auditFinish2";
                                 
                                isShowEdit = false ;
                             }
                            else if ( list.get("state").equals("6") ) {
                                 progress = "<b style='color:CadetBlue;font-size:14px;' >待交办</b>";
                                 isShowcmd  = true ;                             
                                
                               
                                 
                                 cmd_str = "交办";
                                 class_str = "jiaoban";
                                 
                                isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("7") ) {
                                 progress = "<b style='color:DarkOrange;font-size:14px;' >承办单位办理中</b>";
                                 isShowcmd  = false ;                             
                                
                               
                                 isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("8") ) {
                                progress = "<b style='color:CadetBlue;font-size:14px;' >视察已完成</b>";
                                isShowcmd  = true ;                             
                                cmd_str = "满意度测评";
                                class_str = "ys evaluate";
                               
                                isShowEdit = false ;
                                RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
                                evaluationEntity.request();
                                evaluationEntity.select().where("evaluationId="+ list.get("id") + " and typeid=8 and myid="+ UserList.MyID(request) ).get_page_desc("myid");                                   
                                if ( evaluationEntity.totalrows > 0 ){

                                    cmd_str = "查看测评结果";   
                                    class_str = "ys viewEvaluation";
                                }
                                else {
                                    cmd_str = "满意度测评"; 
                                }
                                 
                               
                            }
                          isShowEdit = false ;
                          isShowDelete = false ;

                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td ><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("reviewclass")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("inspecttime")); %>,yyyy-MM-dd" ></td>
                            <td><% out.print(list.get("place")); %></td>                          
                            <td><%out.print(progress); %></td>
                             
                            <td>
                            <%
                            if ( isShowFinishBtn ){
                            %>      
                            <span class="ys finish"  id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >视察完成</span>   |       
                            <%
                            }
                            %>  
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
                popuplayer.display("/supervision/inspection/inspectbutview.jsp?id=" + id + "&TB_iframe=true", '查看详情', {width: 830, height: 360});
                })
            });
            $(function(){
                ﻿$(".submit").click(function(){
                    let id = $(this).attr("id");
                 popuplayer.display("/supervision/inspection/submit.jsp?id=" + id + "&TB_iframe=true", '提交主任会议审议', {width: 830, height: 460});
                 //popuplayer.display("/supervision/topic/duty/inspectReport.jsp?id=" + id, '主任会议审议', {width: 830, height: 460});
                })
            });
            
            $(function(){
                ﻿$(".assign").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/assignview.jsp?id=" + id , '视察报告和交办意见提交主任会议审议', {width: 830, height: 220});
                })
            });
              $(function(){
                ﻿$(".report").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/reportview.jsp?id=" + id , '主任会议汇报', {width: 830, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/edit.jsp?id=" + id , '编辑', {width: 830, height: 360});
                })
            });
             $(function(){
                ﻿$(".finish").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/finishview.jsp?id=" + id , '视察完成', {width: 830, height: 380});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/delete_1.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
            
             $(function(){
                ﻿$(".solutionsubmit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/solutionsubmit.jsp?id=" + id , '视察方案提交主任会议审议', {width: 830, height: 380});
                })
            }); 
            
             $(function(){
                ﻿$(".auditFinish").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/solutionAuditview.jsp?id=" + id , '视察方案审议完成', {width: 830, height: 260});
                })
            });
             $(function(){
                ﻿$(".auditFinish2").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/solutionAuditview1.jsp?id=" + id , '视察报告和交办意见审议完成', {width: 830, height: 360});
                })
            });
            
             $(function(){
                ﻿$(".jiaoban").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/inspection/jiaoban.jsp?id=" + id , '交办', {width: 830, height: 140});
                })
            });
            
             $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluation.jsp?id=" + id   + "&typeid=8", '满意度测评', {width: 830, height: 260});
                })
            });
            
             $(function(){
                ﻿$(".viewEvaluation").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluationview.jsp?id=" + id  + "&typeid=8" , '查看满意度测评', {width: 830, height: 220});
                })
            });
        </script>
    </body>
</html>