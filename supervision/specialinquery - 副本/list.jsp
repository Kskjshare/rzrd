<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>

<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    String powerid = cookie.Get("powergroupid");
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
    evaluationEntity.request();
    
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
                            <th>发起者</th>
                            <th>发布时间</th>          
                            <th>当前进度</th>
                            <!--
                            <th>上会时间</th>
                            <th>会次</th>
                            -->
                            
                            <th>操作</th>                         
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            boolean isShowFirstButton = true ;
                            
                            String class_str = "";
                            String cmd_str = "";
                            RssList list = new RssList(pageContext, "supervision_special_inquery");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8")+ "%' and typeid="  + req.get("typeid") + " and myid="+ UserList.MyID(request) ).get_page_desc("id");
                            while (list.for_in_rows()) {
                            boolean isCompanyEvaluation = false ;    
                            //user.select().where("myid=" + list.get("initiator")).get_first_rows();
                            user.select().where("myid=" + UserList.MyID(request)).get_first_rows();

                            
                            //为了处理所有人都可以投票测评，这里需要做特殊处理。
                            
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td ><% out.print(list.get("title")); %></td>
                            <td><% out.print( user.get("realname") );%></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>                                 
                            <td><% 
                                if ( list.get("state").equals("1") ) {                                  
                                   
                                   
                                    if ( list.get("leaderpreview").equals("1") ) { //需要预审
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待审阅</b>" ); 
                                       
                                        isShowFirstButton = false;
                                    }else {
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                                        class_str = "ys directormeeting";
                                        cmd_str = "提交主任会议审议 | "; 
                                        isShowFirstButton = true;
                                    }                            
                                  
                                }
                                else if ( list.get("state").equals("2") ) {
                                    
                                     if (  list.get("leaderpreview").equals("1") ) {
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                                        class_str = "ys directormeeting";
                                        cmd_str = "提交主任会议审议 | "; 
                                        isShowFirstButton = true;
                                    }else {
                                    out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议中</b>" ); 
                                    class_str = "ys auditpass";
                                    cmd_str = "常委会审议 | ";
                                    if (  list.get("initiator").equals("3") ) {
                                        class_str = "ys sencondaudit";
                                    }
                                     }
                                }
                                else if ( list.get("state").equals("3") ) {
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >专题询问方案主任会议通过</b>" );
                                 //class_str = "ys songjiao";
                                 //cmd_str = "送交 | ";
                                 cmd_str = "召开专题会 | ";
                                 class_str = "ys directorAuditdone";
                                 isShowFirstButton = true; 
                                }
                                else if ( list.get("state").equals("4") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >专题询问方案主任会议不通过</b>" );
                                 //class_str = "ys provider";
                                 //cmd_str = "提交调研报告 | ";
                                 
                                 //class_str = "ys submitreport";
                                 //cmd_str = "提交总询问问题提纲 | ";
                                 
                                 //isShowFirstButton = true;
                                }
                                else if ( list.get("state").equals("5") ){
                                    
                                    if ( list.get("needsubmitmeeting").equals("2") ) { //需要审批                              
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >不需提交主任会议审议</b>" );
                                        isShowFirstButton = false;
                                    }
                                    else {
                                        out.print( "<b style='color:red;font-size:14px;' >专题询问方案被主任会议驳回</b>" );
                                        class_str = "ys feedback";
                                        cmd_str = "主任会议审议 | ";  
                                        isShowFirstButton = true;
                                    }
                                 
                                }
                                else if ( list.get("state").equals("6") ){
                                 out.print( "<b style='color:DarkOrange;font-size:14px;' >总询问问题提纲准备中</b>" );   
                                 class_str = "ys submitreport";
                                 cmd_str = "提交主任会议审议 | ";  
                                 isShowFirstButton = true;
                                }
                                else if ( list.get("state").equals("7") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议总询问问题提纲</b>" );
                                
                                 cmd_str = "主任会议审议完成 | "; 
                                 class_str = "ys directorAuditdone";
                                 isShowFirstButton = true; 
                                }
                                else if ( list.get("state").equals("8") ){
                                   class_str = "ys evaluate";
                                    
                                    out.print( "<b style='color:DarkOrange;font-size:14px;' >专题询问会中</b>" );
                                    //evaluationEntity.select().where("evaluationId="+ list.get("id") + " and myid="+ UserList.MyID(request) ).get_first_rows();
                                    evaluationEntity.select().where("evaluationId="+ list.get("id") + " and myid="+ UserList.MyID(request) ).get_page_desc("myid");
                                   
                                    
                                    if ( evaluationEntity.totalrows > 0 ){
                                    
                                        cmd_str = "查看测评结果 | ";   
                                        class_str = "ys viewEvaluation";
                                    }
                                    else {
                                        cmd_str = "满意度测评 | "; 
                                    }
                                     isShowFirstButton = true; 
                                }
                                else if ( list.get("state").equals("9") ){
                                 if ( list.get("evaluationSwitch").equals("1") ) {
                                    out.print( "<b style='color:DarkOrange;font-size:14px;' >满意度测评中</b>" ); 
                                    class_str = "ys viewEvaluation";
                                    cmd_str = "查看测评结果 | ";  
                                     isShowFirstButton = true;   
                                 }
                                 else
                                  out.print( "<b style='color:CadetBlue;font-size:14px;' >特定问题调查已完结</b>" );    
                                 
                              
                                }
                                else if ( list.get("state").equals("10") ){
                                 out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议意见办理中</b>" );  
                                 //class_str = "ys committefeedback";
                                 //cmd_str = "反馈意见 | ";  
                                 isShowFirstButton = false;
       
                                }
                                else if ( list.get("state").equals("15") ){
                                 out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议中</b>" );  
                                 class_str = "ys assign";
                                 cmd_str = "交办 | ";  
                                 isShowFirstButton = true;
       
                                }
                                else if ( list.get("state").equals("16") ){
                                 out.print( "<b style='color:DarkOrange;font-size:14px;' >承办单位办理中</b>" );  
                                
                                 isShowFirstButton = false;
       
                                }
                                else if ( list.get("state").equals("11") ){
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >已完结</b>" );  
                                class_str = "ys viewEvaluation";
                                cmd_str = "查看满意度测评 | ";  
                                isCompanyEvaluation = true ;
                                }
                                else if ( list.get("state").equals("12") ){
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >已反馈意见</b>" );                                
                                }
                                else if ( list.get("state").equals("13") ){
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >已向常委会提出书面报告</b>" ); 
                                    class_str = "ys evaluate";
                                    
                                   
                                    //evaluationEntity.select().where("evaluationId="+ list.get("id") + " and myid="+ UserList.MyID(request) ).get_first_rows();
                                    evaluationEntity.select().where("evaluationId="+ list.get("id") + " and myid="+ UserList.MyID(request) ).get_page_desc("myid");
                                   
                                    
                                    if ( evaluationEntity.totalrows > 0 ){
                                    
                                        cmd_str = "查看测评结果 | ";   
                                        class_str = "ys viewEvaluation";
                                    }
                                    else {
                                        cmd_str = "满意度测评 | "; 
                                    }
                                }
                            %></td>
                        
                            
                            <td>
                            
                          
                            <%
                            if ( isShowFirstButton ) {
                            %>
                            <span class= "<% out.print(class_str);%>" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" ><%out.print(cmd_str);%></span>
                            <%                          
                            }
                            %>
                            
                            <%
                            if (  Integer.parseInt( list.get("state")) == 8  ) { //满意度测评
                            %>
                            <span class= "ys committeeAudit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >提交常委会审议</span> |
                            <%                          
                            }
                            %>
                            
                            
                            <%
                            if (  Integer.parseInt( list.get("state")) <= 1  ) {
                            %>
                            <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span> | 
                            <%                          
                            }
                            %>
                            <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span> | 
                            
                            <% 
                            if (  isCompanyEvaluation  ) {                         
                            %> 
                            <span class="ys companyEvaluation" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >单位满意度测评</span> | 
                            <%   
                            }
                            %>
                            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span>
                            
                                  
                            
                            <!--a href="duty/list.jsp?id=<% out.print(list.get("id")); %>&status=1">议题管理页面</a-->
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
        <script>
            var typeid =<%list.write("typeid");%>
        </script>
        <script src="controller.js"></script>
        <script>
            $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/detailview.jsp?id=" + id, '查看内容', {width: 830, height: 300});
                })
            });
             $(function(){
            ﻿$(".delete").click(function(){
                let id = $(this).attr("id");
             //popuplayer.display("/supervision/zhifajiancha/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
             popuplayer.display("/supervision/specialinquery/delete_1.jsp?id=" + id, '删除', {width: 300, height: 80});
             
            })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 830, height: 300});
                })
            });
            
            $(function(){
                ﻿$(".directormeeting").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/supervision/topic/inspectReport.jsp?id=" + id + "&TB_iframe=true", '提交主任会议', {width: 830, height: 260});
                 popuplayer.display("/supervision/specialinquery/directormeetingsubmit.jsp?id=" + id, '提交主任会议审议', {width: 830, height: 360});
                })
            });
            
            $(function(){
                ﻿$(".auditpass").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/submit.jsp?id=" + id , '审议通过', {width: 830, height: 340});
                })
            });
            $(function(){
                ﻿$(".sencondaudit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/secondsubmit.jsp?id=" + id , '常委会审议', {width: 830, height: 340});
                })
            });
            
            
            
            $(function(){
                ﻿$(".songjiao").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/submit.jsp?id=" + id , '送交', {width: 830, height: 420});
                })
            });
            
            $(function(){
                ﻿$(".provider").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/provider.jsp?id=" + id , '调研报告', {width: 680, height: 260});
                })
            });
            
             $(function(){
                ﻿$(".submitreport").click(function(){
                    let id = $(this).attr("id");
                 //popuplayer.display("/supervision/specialinquery/issuereport.jsp?id=" + id , '提交总询问问题提纲', {width: 630, height: 260});
                 popuplayer.display("/supervision/specialinquery/provider.jsp?id=" + id , '提交总询问问题提纲', {width: 630, height:180});
                })
            });
            $(function(){
                ﻿$(".committeeAudit").click(function(){
                    let id = $(this).attr("id");
//                popuplayer.display("/supervision/specialinquery/assign.jsp?id=" + id , '常委会审议', {width: 860, height: 260});
                popuplayer.display("/supervision/specialinquery/committeeAudit.jsp?id=" + id , '常委会审议', {width: 860, height: 280});
                })
            });
            
            $(function(){
                ﻿$(".assign").click(function(){
                    let id = $(this).attr("id");
               popuplayer.display("/supervision/specialinquery/assign.jsp?id=" + id , '交办', {width: 860, height: 200});
           
                })
            });
            
            $(function(){
                ﻿$(".committeeAuditFinish").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/evaluationsetting.jsp?id=" + id , '开启满意度测评', {width: 560, height: 240});
                })
            });
            $(function(){
                ﻿$(".committefeedback").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/submit.jsp?id=" + id , '征求意见', {width: 880, height: 520});
                })
            });
             $(function(){
                ﻿$(".sendReporttoCommittee").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/submit.jsp?id=" + id , '向常委会出报告', {width: 880, height: 640});
                })
            });
            
             $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluation.jsp?id=" + id   + "&typeid=5", '满意度测评', {width: 830, height: 280});
                })
            });
            
            
            
            $(function(){
                ﻿$(".companyEvaluation").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/supervision/companyEvaluationList.jsp?id=" + id  + "&typeid=5" , '单位满意度测评', {width: 860, height: 380});
                })
            });
            
            $(function(){
                ﻿$(".viewEvaluation").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluationview.jsp?id=" + id  + "&typeid=5" , '查看满意度测评', {width: 830, height: 240});
                })
            });
            
             $(function(){
                ﻿$(".forumEvaluate").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/forumEvaluate.jsp?id=" + id  + "&typeid=5" , '满意度测评', {width: 830, height: 280});
                })
            });
             $(function(){
                ﻿$(".directorAuditdone").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/directorAuditdone.jsp?id=" + id  + "&typeid=5" , '召开专题会', {width: 830, height: 300});
                })
            });
            
            
            
        </script>
    </body>
</html>