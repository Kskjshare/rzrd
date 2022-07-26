<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "activitiesmy");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    list.request();
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
               
                <!--<button type="button" transadapter="append" select="false" class="butadd">发起活动</button>-->
                
                 <button type="button" transadapter="delete" select="false" class="butdelect">删除</button>
                <button type="button" transadapter="audit" class="butview"  powerid="95">审核</button>

                 <!--
                <button type="button" transadapter="doattendance" class="butedit">手动补签</button>
                <button type="button" transadapter="attendance" class="butview">述职人员</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                -->
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="classify" value="<%list.write("classify");%>" />
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            
                            <th class="w30"><input name="all"  type="checkbox"></th>
                           <!--  
                            <th>编号</th>
                           -->
                            <th>标题</th>
                            <th>发起人</th>
                            <th>履职类型</th>
                            <th>发布时间</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>审核状态</th>
                           <!--
                            <th>关闭原因</th>
                            -->
                            <th>操作</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <!--sal>(select SAL from emp where ename='CLARK')-->
                        <%
                            

                            list.pagesize = 30;
//                            if (!list.get("pagesize").isEmpty()) {
//                                list.pagesize = Integer.valueOf(list.get("pagesize"));
//                            } else {
//                                list.pagesize = 10;
//                            }
                            int a = 1;
                            String powergroupid = cookie.Get("powergroupid");
                            String sql = "";
//                            if (powergroupid.equals("22")) {
//                                sql = "myid =" + UserList.MyID(request);
//                            } else {
//                                sql = "myid =" + UserList.MyID(request);
//                                if (powergroupid.equals("16")) {
//                                    sql = "myid <>0";
//                                }
//                            }

                            if (cookie.Get("powergroupid").equals("22")) {
                              sql = "private=1 and myid =" + UserList.MyID(request);  
                            }
                            else {
                                sql = "private=1" ;
                            }
                            
                            sql += " and classify=" + list.get("classify") ;
                            //sql += " and title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'";
                           
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                                
                            boolean isShowaudit = false ;
                            String tips = "<b style='color:red;font-size:14px;' >未审核</b>" ;
                            //out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                            if (powergroupid.equals("7"))  { // 选工委
                                isShowaudit = true ;
                                if ( list.get("privateaudit").equals("1") ) {
                                    isShowaudit = false ;
                                }
                             }
                            
                            boolean isShowAttachment = false ;
                            if ( list.get("enclosure").isEmpty() ) {
                                 //isShowAttachment = true;
                             }
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>"  style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                           
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" idState="<%out.print(list.get("state"));%>" /></td>
                            <!--
                            <td><% out.print(list.get("realid")); %></td>
                             -->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td activitiestypeclassify="<%list.write("classify");%>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                            <td><%
                                if ( list.get("privateaudit").equals("1") ) {
                                    tips = "<b style='color:green;font-size:14px;' >已审核通过</b>" ;
                                    out.print( tips );
                                }
                                else if ( list.get("privateaudit").equals("2") ) {
                                    tips = "<b style='color:grey;font-size:14px;' >审核未通过</b>" ;
                                    out.print( tips );    
                                }
                                else {
                                  //out.print("未审核");
                                  tips = "<b style='color:red;font-size:14px;' >未审核</b>" ;
                                  out.print( tips );   
                                }
                                %></td>
                              <!--
                            <td><% out.print(list.get("closenote")); %></td>
                              -->
                            
                             
                             <td>                                              
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span>
                            <!--<span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看参与人</span> |-->                            
                            | <span class="delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">删除</span> 
                           <%
                            if (  isShowaudit ) { 
                           %>
                         
                            |<span class="ys sign" id="<% out.print(list.get("id")); %>" userid="<% out.print(list.get("myid"));  %>"  private="<% out.print(list.get("private"));  %>" style="color:blue;font-weight:bold;">审核</span> 
                            <%
                           }
                           %>
                           
                           <%
                            if (  isShowAttachment ) 
                            { 
                           %>
                         
                            |<span class="ys viewImage" id="<% out.print(list.get("id")); %>" userid="<% out.print(list.get("myid"));  %>"  private="<% out.print(list.get("private"));  %>" style="color:blue;font-weight:bold;">查看附件</span> 
                            <%
                           }
                           %>
                           
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
            var classify =<%req.write("classify");%>
//            var State = <%list.write("state");%>
//            console.log(State,"vvv")
        </script>
        <script src="controller.js"></script>
        <script>
            function closeDbLzhd(id) {
                popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true", '填写关闭原因', {width: 600, height: 330});
            }
            
             $(function(){
                ﻿$(".start").click(function(){
                //let id = $(this).attr("id");
                 popuplayer.display("/activities/v2/admin/edit.jsp?classify="+$("#classify").val()+"&TB_iframe=true", '发起活动', {width: 500, height: 550});
                })
            });    
            
            $(function(){
                ﻿$(".edit").click(function(){
                  let id = $(this).attr("id");  
                   popuplayer.display("/activities/v2/admin/edit.jsp?id=" + id + "&TB_iframe=true", '编辑活动', {width: 500, height: 550});
                })
            });  
            
            
            $(function(){
                ﻿$(".sign").click(function(){
                   let id = $(this).attr("id");
                   let userid = $(this).attr("userid");
                   let private = $(this).attr("private");
                   //popuplayer.display("/activities/v2/admin/doattendance.jsp?id=" + id + "&TB_iframe=true", '审核', {width: 600, height: 450});
                   if ( private == 1 ) {
                        popuplayer.display("/activities/v2/admin/activiiesAudit.jsp?id=" + id + "&userid=" + userid , '审核', {width: 600, height: 450});
                   }else {
                        popuplayer.display("/activities/admin/attendanceAudit.jsp?id=" + id + "&userid=" + userid , '审核', {width: 600, height: 450});
                   }
                   
                })
            });  
            
            $(function(){
                ﻿$(".viewImage").click(function(){
                   let id = $(this).attr("id");
                    popuplayer.display("/activities/v2/admin/imageview.jsp?id=" + id + "&TB_iframe=true", '查看附件',{width: 1496, height: 820});
                })
            });  
            
            
             $(function(){
                ﻿$(".chakan").click(function(){
                   let id = $(this).attr("id");
//                    popuplayer.display("/activities/v2/admin/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容',{width: 600, height: 550});
                    popuplayer.display("/activities/v2/admin/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容',{width: 1506, height: 860});

                })
            });  
            
             
              $(function(){
                ﻿$(".view").click(function(){
                   let id = $(this).attr("id");
                  popuplayer.display("/activities/v2/admin/attendance.jsp?id=" + id+ "&TB_iframe=true", '履职人员', {width: 800, height:500});
                })
            });  
            
             $(function(){
                ﻿$(".delete").click(function(){
                   let id = $(this).attr("id");
                  popuplayer.display("/activities/v2/admin/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 300, height: 80});
                })
            });  
            
            
            
        </script>
    </body>
</html>