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
                <!--<button type="button" transadapter="append" select="false" class="butadd">增加</button>-->
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <!--<button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <!--<button type="button" transadapter="file" class="butdfile">归档</button>-->

                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <!--<th class="w30"><input name="all"  type="checkbox"></th>-->
                            <th>标题</th>
                            <!--<th>调研主题</th>-->
                            <th>发布时间</th>
                            <th>发起者</th>
                            <!--<th>调研地点</th>-->
                            <th>状态</th>
                            <!--
                            <th>上会时间</th>
                            <th>会次</th>
                            -->
                            
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                           
                            //测评表
                            RssList evaluationlist = new RssList(pageContext, "supervision_evaluation");
                            evaluationlist.request();                          
                            evaluationlist.pagesize = 3000;
                           
                    
                           
                            String progress =  "<b style='color:CadetBlue;font-size:14px;' >已向常委会提出书面报告</b>" ;
                            RssList list = new RssList(pageContext, "supervision_specialwork");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and taskDone=1 and typeid=" + req.get("typeid") ).get_page_desc("id");
                    
                            while (list.for_in_rows()) {
                                progress = "<b style='color:CadetBlue;font-size:14px;' >已向常委会提出书面报告</b>";
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <!--<td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>-->
                            <td ><% out.print(list.get("title")); %></td>
                            <!--<td><% // out.print(list.get("reviewclass")); %></td>-->
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                           
                            <td ><% 
                                //out.print(list.get("initiator")); 
                                if ( list.get("initiator").equals("1")){
                                     out.print("委室"); 
                                }
                                else if ( list.get("initiator").equals("2")){
                                    out.print("主任会议"); 
                                }
                                else{
                                     out.print("常委会成员联名");
                                }
                            %></td>
                            <!--<td><% // out.print(list.get("place")); %></td>-->                          
                            <td><%out.print(progress); %></td>
                             
                            <td>
                            <%
                            //evaluationlist.select().where("title like '%" + URLDecoder.decode(evaluationlist.get("title"), "utf-8") + "%'and typeid=" + req.get("typeid") + " and myid=" + UserList.MyID(request) ).get_first_rows();
                            evaluationlist.select().where("typeid=" + req.get("typeid") + " and myid=" + UserList.MyID(request) ).get_first_rows();
                           
                            if ( evaluationlist.get("myid").equals( UserList.MyID(request))) {
                            %>
                            <span class="ys satisfactionview" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看满意度</span> | 
                            <%
                            }else{
                            %>
                            <span class="ys evalute" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >测评</span> |  
                            <span class="ys satisfactionview" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看满意度</span>  | 
                            <%
                            }
                            %>
                            <span class="ys viewDetail" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看详情</span>  
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
                popuplayer.display("/supervision/specialReport/specialworkview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
                })
            });
            
            
             $(function(){
                ﻿$(".evalute").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluation.jsp?id=" + id + "&typeid=1", '测评', {width: 830, height: 360});
                })
            });
            
            $(function(){
                ﻿$(".satisfactionview").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/evaluationview.jsp?id=" + id + "&typeid=1", '查看测评满意度', {width: 560, height: 280});
                })
            });
 
        </script>
    </body>
</html>