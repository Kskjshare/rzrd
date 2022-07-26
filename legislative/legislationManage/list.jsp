<%@page import="java.net.URLDecoder"%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
//    RssList entity = new RssList(pageContext, "legislative_planning");
//    entity.request();
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
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>立法规划项目名称</th>
                            <th>起草部门</th>
                            <th>类别</th>
                            <th>立法规划年度</th>
                            <th>备注</th>
                            <th>状态</th>

                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "LegislativeProject");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>    
                            <td><% out.print(list.get("department")); %></td>                            
                            <td><% out.print(list.get("classificationname")); %></td>                            
                            <td><% out.print(list.get("yearname")); %></td>                            
                            <td><% out.print(list.get("remarks")); %></td>                            
                            <td><%
                                
                                if ( list.get("state").equals("1") ) {
                                 out.print( "拟定五年规划项目" );     
                                }
                                else  if ( list.get("state").equals("2") ) {
                                 out.print( "条件成熟提请审议" );     
                                }
                                else  if ( list.get("state").equals("3") ) {
                                 out.print( "需继续研究讨论" );     
                                }
                                else  if ( list.get("state").equals("4") ) {
                                 out.print( "主任会议通过" );     
                                }
                                else  if ( list.get("state").equals("5") ) {
                                 out.print( "主任会议不通过" );     
                                }
                                 else  if ( list.get("state").equals("7") ) {
                                 out.print( "常委会议通过" );     
                                }
                                else  if ( list.get("state").equals("8") ) {
                                 out.print( "常委会议不通过" );     
                                }
                                else  {
                                 out.print( "未办理" );     
                                }
                            %></td>                            

                            <td>   
                            
                            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看</span> | 
                            <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:green;font-weight: bold" >修改</span> | 
                            <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:red;font-weight: bold" >删除</span>
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

        <script src="./controller.js">
        </script>

        <script>
            
             $(function(){
            ﻿$(".handle").click(function(){
                let id = $(this).attr("id");
             popuplayer.display("/legislative/legislationManage/handleview.jsp?id=" + id + "&TB_iframe=true", '办理', {width: 460, height: 320});
             
            })
            });
            
            $(function(){
            ﻿$(".view").click(function(){
                let id = $(this).attr("id");
             popuplayer.display("/legislative/legislationManage/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 320});
             
            })
            });
           
            $(function(){
            ﻿$(".delete").click(function(){
                let id = $(this).attr("id");
             popuplayer.display("/legislative/legislationManage/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 380, height: 180});
             
            })
            });
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/legislative/legislationManage/edit.jsp?id=" + id + "&TB_iframe=true", '修改', {width: 830, height: 360});
                })
            });

        </script>

    </body>
</html>