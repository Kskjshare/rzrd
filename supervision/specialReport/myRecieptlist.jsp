<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    
    
    RssList entity = new RssList(pageContext, "supervision_userrole_specialwork");
    entity.request();
    entity.pagesize = 2;
    //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
    entity.select().where("title like '%" + URLDecoder.decode( entity.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode( entity.get("state"), "utf-8") + "%' and userroleid="+UserList.MyID(request)).get_page_desc("id");

    RssList evaluationEntity = new RssList(pageContext, "supervision_evaluation");
    evaluationEntity.request();
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
-->                <button type="button" transadapter="delete" class="butdelect">删除</button><!--
                <button type="button" transadapter="file" class="butdfile">归档</button>-->

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
                            <th>类别</th>
                            <th>制定方案时间</th>          
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
                            String class_str = "";
                            String cmd_str = "";
                            RssList list = new RssList(pageContext, "supervision_userrole_specialwork");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and state<>2 and myid="+UserList.MyID(request)).get_page_desc("id");
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%' and userroleid="+UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td ><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("reviewclass")); %></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <!--<td rssdate="<% out.print(list.get("inspectTime")); %>,yyyy-MM-dd" ></td>-->
                            <!--<td><% out.print(list.get("place")); %></td>-->                          
                            <td><% 
                               
                                if ( list.get("state").equals("1") ) {
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                                    class_str = "ys submitToMeeting";
                                    cmd_str = "提交主任会议 | ";
                                }
                                else if ( list.get("state").equals("2") ) {
                                    out.print( "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>" ); 
                                    class_str = "ys auditpass";
                                    cmd_str = "主任会议审议通过 | ";
                                }
                                else if ( list.get("state").equals("3") ) {
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >方案实施中</b>" );
                                 class_str = "ys songjiao";
                                 cmd_str = "送交 | ";
                                }
                                else if ( list.get("state").equals("4") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >专项报告准备中</b>" );
                                 class_str = "ys inquery";
                                 cmd_str = "征求意见 | ";
                                }
                               else if ( list.get("state").equals("5") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                                
                                }
                                else if ( list.get("state").equals("6") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >意见征求已通过</b>" );                               
                                }
                                else if ( list.get("state").equals("7") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >意见已反馈</b>" );
                                 class_str = "ys inquery";
                                 cmd_str = "查看反馈意见 | ";
                                }
                                else if ( list.get("state").equals("8") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议中</b>" );
                                 
                                }
                                else if ( list.get("state").equals("9") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议意见处理中</b>" );
                                 class_str = "ys inqueryCommittee";
                                 cmd_str = "完成常委会审议意见 | ";
                                }
                                else if ( list.get("state").equals("10") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );                             
                                }
                                else if ( list.get("state").equals("11") ){
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见已通过</b>" );                                
                                }
                                else if ( list.get("state").equals("12") ){
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >已反馈意见</b>" );   
                                 class_str = "ys inquerylast";
                                 cmd_str = "查看反馈意见 | ";
                                }
                                else if ( list.get("state").equals("13") ){
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >已向常委会提出书面报告</b>" ); 
                                    class_str = "ys evaluate";
                                    
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
                            
                          
                             
                            <span class= "<% out.print(class_str);%>" id="<% out.print(list.get("iid")); %>" style="color:blue;font-weight: bold" ><%out.print(cmd_str);%></span>
                            <!--<span class="ys edit" id="<% out.print(list.get("iid")); %>" style="color:blue;font-weight: bold" >编辑</span> |--> 
                            <!--<span class="ys delete" id="<% out.print(list.get("iid")); %>" style="color:blue;font-weight: bold" >删除</span> |--> 
                            <span class="ys view" id="<% out.print(list.get("iid")); %>" style="color:blue;font-weight: bold" >查看内容</span>                       
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
        <script>
            var typeid =<%list.write("typeid");%>
        </script>
        <script src="controller.js"></script>
        <script>
            $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/specialworkview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 440});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/delete_1.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 830, height: 560});
                })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/editSpecialreport.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 830, height: 560});
                })
            });
            
            $(function(){
                ﻿$(".submitToMeeting").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/supervision/topic/inspectReport.jsp?id=" + id + "&TB_iframe=true", '提交主任会议', {width: 830, height: 260});
                 popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id, '提交主任会议', {width: 830, height: 460});
                })
            });
            
            $(function(){
                ﻿$(".auditpass").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id , '审议通过', {width: 830, height: 320});
                })
            });
            
            $(function(){
                ﻿$(".songjiao").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id , '送交', {width: 830, height: 420});
                })
            });
            
            $(function(){
                ﻿$(".inquery").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id , '征求意见', {width: 860, height: 560});
                })
            });
            
            $(function(){
                ﻿$(".feedback").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id , '查看反馈意见', {width: 830, height: 420});
                })
            });
            
            $(function(){
                ﻿$(".inqueryCommittee").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id , '提交常委会意见报告', {width: 860, height: 500});
                })
            });
            
         $(function(){
                ﻿$(".inquerylast").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialReport/submit.jsp?id=" + id , '查看反馈意见', {width: 860, height: 580});
                })
            });
            
            $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluation.jsp?id=" + id , '满意度测评', {width: 830, height: 320});
                })
            });
            
            $(function(){
                ﻿$(".viewEvaluation").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluationview.jsp?id=" + id , '查看满意度测评', {width: 830, height: 280});
                })
            });
        </script>
    </body>
</html>