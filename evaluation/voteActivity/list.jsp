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
    String powerid = cookie.Get("powergroupid");
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
                
                <%
                  if ( !powerid.equals("5") )
                %>    
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <!--<button type="button" transadapter="file" class="butdfile">归档</button>-->

                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>序号</th>
                            <th>标题</th>
                            <th>投票类型</th>
                            <th>发布时间</th>
                            <th>会议届次</th>
                            <th>会议时间</th>
                            
                            <th>状态</th>
                            
                            <th>操作</th>
                            <!--<th>管理</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                          
                           String state = "未投票";
                           boolean voteBtnShow = true ;
                           
                            RssList votedList = new RssList(pageContext, "vote_evaluation");
                            votedList.request();
   
                           
                            RssList list = new RssList(pageContext, "vote_activity");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                                                       
//                          list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'" ).get_page_desc("id");
                    
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and votetype like '%" + URLDecoder.decode(list.get("votetype"), "utf-8") + "%'" ).get_page_desc("id");

                           
                            while (list.for_in_rows()) {
                                state = "未投票";
                                voteBtnShow = true ;
                                String sql = "";
                                sql = "evaluationId="+ list.get("id");
                                votedList.select().where(sql).get_page_desc("shijian");
                                while (votedList.for_in_rows( )) {
                                    if ( votedList.get("myid").equals( cookie.Get("myid") ) ) {
                                        voteBtnShow = false;
                                        state = "已投票";
                                        break;
                                    }
                                }
   


                           
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td ><% out.print(list.get("title")); %></td>
                            <td ><% 
                                if ( list.get("votetype").equals("1")){
                                    out.print( "全部人员" ); 
                                }
                                else {
                                    out.print( "指定人员" ); 
                                }
                               
                            %></td>
                            
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>

                            <td><% out.print(list.get("session")); %></td>
                            <td rssdate="<% out.print(list.get("meetingshijian")); %>,yyyy-MM-dd" ></td>
                            
                                                       

                            <td><%out.print( state ); %></td>
                             
                            <td>
                               
                            <span class="ys result"  id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" ><%out.print("投票结果");%></span>
                            <%
                            if ( voteBtnShow ){
                            %>      
                             | <span class="ys vote"  id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" ><%out.print("我要投票");%></span> 
                            <%
                            }
                            %>
                             | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span>   
                            <%
                            if ( !powerid.equals("5") ){
                            %>    
                            | <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span> 
                             | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span>   
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
        <script src="controller.js"></script>
        <script>
              
           
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/evaluation/voteActivity/edit.jsp?id=" + id , '编辑', {width: 830, height: 460});
                })
            });
             $(function(){
                ﻿$(".vote").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/evaluation/voteActivity/votesubmit.jsp?id=" + id , '我要投票', {width: 830, height: 380});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/evaluation/voteActivity/delete_1.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
            
            
            
             $(function(){
                ﻿$(".result").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/evaluation/voteActivity/evaluationview.jsp?id=" + id  + "&typeid=8" , '投票结果', {width: 830, height: 420});
                })
            });
        </script>
    </body>
</html>