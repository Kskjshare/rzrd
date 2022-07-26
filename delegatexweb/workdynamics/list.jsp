<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect" powerid="427">删除</button>
                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>信息分类</th>
                            <th>标题</th>
                            <th>发布者</th>
                            <!--<th>阅读次数</th>-->
                            <th>录入日期</th>
                            <th>是否发布</th>
                             <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                           
                            //处理本站相关人员发布的信息，纸有本站相关人员能看到                        
                            RssListView list_contactstation = new RssListView(pageContext, "contactstation");
                            list_contactstation.request();
                           
                            RssListView list = new RssListView(pageContext, "workdynamics");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            boolean released = false ;
                            String powergroupid =  cookie.Get("powergroupid");
                            boolean isAudit = false ;
                            if ( powergroupid.equals("7")) { //选工委
                                isAudit = true ;
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(req.get("classify"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'").get_page_desc("id");

                            }
                            else {
                                list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(req.get("classify"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'").get_page_desc("id");
                            }
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(req.get("classify"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                            released = false ;
                            //处理本站相关人员发布的信息，纸有本站相关人员能看到
                            if ( !isAudit ) {
                                if ( !UserList.MyID(request).equals( list.get("myid")) ) {
                                    list_contactstation.remove();
                                    list_contactstation.select().where("myid=" + list.get("myid") ).get_page_desc("id");
                                    if ( list_contactstation.totalrows == 0 ) {
                                        //如果不是站长账号
                                        continue;
                                    }
                                }
                            }

                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td dynamicclass="<% out.print(list.get("classify")); %>"></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <!--<td><% out.print(list.get("readnum")); %></td>-->
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <%
                            if ( list.get("state").equals("1")){
                            %>
                            <td style="color:green;font-weight:bold;" noticestate="<% 
                                //out.print(list.get("state"));
                                out.print("是");
                                released = true ;
                                %>"></td>
                            <%
                            }else if( list.get("state").equals("2")){
                               
                            %>
                            <td style="color:red;font-weight:bold;" noticestate="<% 
                                out.print("否");
                               // out.print(list.get("state")); 
                            %>"></td>
                            <%
                            };
                            %>
                            <td>
                                
                            <%    
                            if ( released  && isAudit ) {                          
                            %>
                             <span class="ys release" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >审核</span> |
                             <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span> | 
                             <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span>  | 
                            <% 
                            }
                            %>    
                            
                           
                           <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span>
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
                popuplayer.display("/delegatexweb/workdynamics/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 780, height: 600});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/delegatexweb/workdynamics/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 230, height: 80});
                })
            });
             $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/delegatexweb/workdynamics/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 440});
                })
            });
            
             $(function(){
                ﻿$(".release").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/delegatexweb/workdynamics/auditview.jsp?id=" + id + "&TB_iframe=true", '审核', {width: 830, height: 340});
                })
            });
            
        </script>
    </body>
</html>