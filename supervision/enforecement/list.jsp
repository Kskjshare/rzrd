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
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <!--<button type="button" transadapter="file" class="butdfile">归档</button>-->

                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>执法检查主题</th>
                            <th>发布时间</th>
                            <th>执法检查时间</th>
                            <th>执法检查地点</th>
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
                            String progress =  "<b style='color:CadetBlue;font-size:14px;' >执法检查中</b>" ;
                            RssList list = new RssList(pageContext, "supervision_enforcement");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
                           
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and typeid="  + req.get("typeid") + " and myid="+UserList.MyID(request)).get_page_desc("id");
                           
                           
                            while (list.for_in_rows()) {
                             isShowFinishBtn = false ;
                             
                            if ( list.get("state").equals("1") ) {
                               if ( list.get("leaderpreview").equals("1") ) { //需要预审
                                progress =  "<b style='color:CadetBlue;font-size:14px;' >待审阅</b>" ;
                               //cmd_str = "待审阅";
                               isShowcmd = false ;
                               }else{
                               progress =  "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ;
                               cmd_str = "执法检查方案提交主任会议审议";
                               class_str = "solutionsubmit";
                               }
                               isShowEdit = true ;
                             
                            }
                            else if ( list.get("state").equals("2") ) {
                                 isShowEdit = false ;
                               if ( list.get("leaderpreview").equals("1") ) { //需要预审
                               progress =  "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ;
                               cmd_str = "执法检查方案提交主任会议审议";
                               class_str = "solutionsubmit";
                               }
                               else {
                                progress = "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>";
                                cmd_str = "交办";
                                class_str = "assign";
                               
                                isShowFinishBtn = true ;
                               }
                               
                            }
                            else if ( list.get("state").equals("3") ) {
                              
                                if ( list.get("leaderpreview").equals("1") ) {//需要预审
                                    progress = "<b style='color:DarkOrange;font-size:14px;' >主任会审议检查方案中</b>";
                                    cmd_str = "审议方案完成";
                                    class_str = "auditFinish";
                                    isShowEdit = false ;
                                    isShowFinishBtn = false ;
                                }
                                else {
                                
                                    progress = "<b style='color:DarkOrange;font-size:14px;' >待出执法工作报告</b>";
                                    isShowEdit = false ;
                                    isShowFinishBtn = false ;
                                    isShowcmd = false ;
                                }
                                
                            }
                            else if ( list.get("state").equals("4") ) {
                               
                                if ( list.get("leaderpreview").equals("1") ) {//需要预审
                                    progress = "<b style='color:DarkOrange;font-size:14px;' >待出执法工作报告</b>";
                                    cmd_str = "执法检查报告和交办意见提交主任会议审议";
                                  
                                    isShowcmd  = false ;
                                    isShowEdit = false ;
                                    class_str = "assign";
                                    isShowFinishBtn = false ;
                                    
//                                    String organizationid = list.get("organizationid");
//                                    String[] organizationids = organizationid.split(",");
//                                    for ( int i = 0 ; i < organizationids.length; i ++ ) {
//                                       if ( UserList.MyID(request).equals( organizationids[i] )) {
//                                           isShowcmd  = true;
//                                           break;
//                                       }   
//                                    }
                                }else{
                                
                                
                                progress = "<b style='color:CadetBlue;font-size:14px;' >执法检查中</b>";
                               
                                isShowEdit = false ;
                                isShowcmd  = true ;                              
                                cmd_str = "提交执法报告";
                                class_str = "assign";
                                
                                }
                            }
                            else if ( list.get("state").equals("5") ) {
                                isShowEdit = false ;
                                isShowcmd  = false ;                              
                                isShowFinishBtn = false ;  
                               if ( list.get("needsubmitmeeting").equals("2") )  {//不需要
                                 
                                    progress = "<b style='color:CadetBlue;font-size:14px;' >不需要提交主任会议</b>";
                                }else {
                                   isShowcmd  = true ;                              
                                   cmd_str = "提交执法报告";
                                   class_str = "assign";
                                   progress = "<b style='color:CadetBlue;font-size:14px;' >已提交执法工作报告,待出执法报告</b>";
                                }
                                             
                               
                               
                            }
                            else if ( list.get("state").equals("6") ) {
                                 progress = "<b style='color:CadetBlue;font-size:14px;' >主任会审议执法检查报告中</b>";
                                 isShowcmd  = true ;                             
                                
                                 isShowFinishBtn = false ;
                                 
                                 cmd_str = "提交常委会审议";
                                 class_str = "committeeAudit";
                                 
                                isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("7") ) {
                                 progress = "<b style='color:CadetBlue;font-size:14px;' >常委会审议执法检查报告中</b>";
                                 isShowcmd  = true ;                             
                                 cmd_str = "交办";
                                 class_str = "jiaoban";
                                 isShowFinishBtn = false ;
                                 isShowEdit = false ;
                            }
                            else if ( list.get("state").equals("8") ) {
                            		if ( list.get("leaderpreview").equals("2") )  {//不需要
                            		  progress = "<b style='color:CadetBlue;font-size:14px;' >被检查单位研究处理中</b>";
	                                isShowcmd  = false ;                             	                               
	                                isShowFinishBtn = false ;
	                                isShowEdit = false ;	                               
                            	  }
                            	  else {
	                                progress = "<b style='color:CadetBlue;font-size:14px;' >执法检查已完成</b>";
	                                isShowcmd  = true ;                             
	                                cmd_str = "满意度测评";
	                                class_str = "ys evaluate";
	                                isShowFinishBtn = false ;
	                                isShowEdit = false ;
	                                RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
	                                evaluationEntity.request();
	                                evaluationEntity.select().where("evaluationId="+ list.get("id") + " and typeid=9 and myid="+ UserList.MyID(request) ).get_page_desc("myid");                                   
	                                if ( evaluationEntity.totalrows > 0 ){
	
	                                    cmd_str = "查看测评结果";   
	                                    class_str = "ys viewEvaluation";
	                                }
	                                else {
	                                    cmd_str = "满意度测评"; 
	                                }
                                }
                                 
                                 
                            }
                            else if ( list.get("state").equals("9") ) {
                          		
                                progress = "<b style='color:CadetBlue;font-size:14px;' >执法检查已完成</b>";
                                isShowcmd  = true ;                             
                                cmd_str = "满意度测评";
                                class_str = "ys evaluate";
                                isShowFinishBtn = false ;
                                isShowEdit = false ;
                                RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
                                evaluationEntity.request();
                                evaluationEntity.select().where("evaluationId="+ list.get("id") + " and typeid=9 and myid="+ UserList.MyID(request) ).get_page_desc("myid");                                   
                                if ( evaluationEntity.totalrows > 0 ){

                                    cmd_str = "查看测评结果";   
                                    class_str = "ys viewEvaluation";
                                }
                                else {
                                    cmd_str = "满意度测评"; 
                                }     
                                
                                cmd_str = "设置满意度测评";
                                class_str = "ys evaluationsetting";                       
                          }
                           else if ( list.get("state").equals("10") ) {
                          		
                                progress = "<b style='color:CadetBlue;font-size:14px;' >满意度测评中</b>";
                                isShowcmd  = true ;                             
                                cmd_str = "满意度测评";
                                class_str = "ys evaluate";
                                isShowFinishBtn = false ;
                                isShowEdit = false ;
                                RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
                                evaluationEntity.request();
                                evaluationEntity.select().where("evaluationId="+ list.get("id") + " and typeid=9 and myid="+ UserList.MyID(request) ).get_page_desc("myid");                                   
                                if ( evaluationEntity.totalrows > 0 ){

                                    cmd_str = "查看测评结果";   
                                    class_str = "ys viewEvaluation";
                                }
                                else {
                                    cmd_str = "满意度测评"; 
                                }     
                                        
                          }
                          else if ( list.get("state").equals("11") ) {
                          		
                                progress = "<b style='color:CadetBlue;font-size:14px;' >执法检查已完成</b>";
                                isShowFinishBtn = false ;
                                isShowEdit = false ;
                                isShowcmd = false ;
                                             
                          }

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
                            <span class="ys finish"  id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >执法检查完成</span>   |       
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
                popuplayer.display("/supervision/enforecement/inspectbutview.jsp?id=" + id + "&TB_iframe=true", '查看详情', {width: 830, height: 360});
                })
            });
            $(function(){
                ﻿$(".submit").click(function(){
                    let id = $(this).attr("id");
                 popuplayer.display("/supervision/enforecement/submit.jsp?id=" + id + "&TB_iframe=true", '提交主任会议审议', {width: 830, height: 460});
                 //popuplayer.display("/supervision/topic/duty/inspectReport.jsp?id=" + id, '主任会议审议', {width: 830, height: 460});
                })
            });
            
            $(function(){
                ﻿$(".assign").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/assignview.jsp?id=" + id , '执法检查报告和交办意见提交主任会议审议', {width: 830, height: 260});
                })
            });
          
            
            $(function(){
                ﻿$(".committeeAudit").click(function(){//auditFinish
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/solutionAuditview.jsp?id=" + id , '提交常委会审议', {width: 830, height: 360});
                })
            });
            $(function(){
                ﻿$(".auditFinish2").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/solutionAuditview1.jsp?id=" + id , '执法检查报告和交办意见审议完场', {width: 830, height: 360});
                })
            });
            
            $(function(){
                ﻿$(".report").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/reportview.jsp?id=" + id , '主任会议汇报', {width: 830, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/edit.jsp?id=" + id , '编辑', {width: 830, height: 360});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/delete_1.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
            
            $(function(){
                ﻿$(".finish").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/investigation/finishview.jsp?id=" + id , '执法检查完成', {width: 830, height: 380});
                })
            });
            
             $(function(){
                ﻿$(".solutionsubmit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/solutionsubmit.jsp?id=" + id , '执法检查方案提交主任会议审议', {width: 830, height: 380});
                })
            });
            
            $(function(){
                ﻿$(".jiaoban").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/jiaoban.jsp?id=" + id , '交办', {width: 830, height: 260});
                })
            });
            
            $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluation.jsp?id=" + id   + "&typeid=9", '满意度测评', {width: 830, height: 280});
                })
            });
            
             $(function(){
                ﻿$(".viewEvaluation").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluationview.jsp?id=" + id  + "&typeid=9" , '查看满意度测评', {width: 830, height: 280});
                })
            });
            
             $(function(){
                ﻿$(".evaluationsetting").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/enforecement/evaluationsetting.jsp?id=" + id , '开启满意度测评', {width: 560, height: 240});
                })
            });
            
        </script>
    </body>
</html>