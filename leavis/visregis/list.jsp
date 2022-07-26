<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
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
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <!--<th>信访件编号</th>-->
                            <th>信访主题</th>
                            <th>信访人</th>
                           
                            <th>信访日期</th>
                            <th>问题属地</th>
                            <th>信访原因</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "petition");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            
                            CookieHelper cookie = new CookieHelper(request, response);
                            String powergroupid = cookie.Get("powergroupid");
                            String parentid = cookie.Get("parentid");
                            String sql = "";
                            if (powergroupid.equals("16")) {
                                sql = "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and type=2 and handle is null";

                            } else {
                                sql = "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and type=2 and handle is null and gtdepar="+parentid+"";
                            }
                            
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
//                                user_delegation.select("company").where("myid in (" + list.get("organizationid") + ")").get_first_rows();
//                                list.keyvalue("userrolecompany", user_delegation.get("company"));
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td><% out.print(list.get("petition")); %></td>-->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("petitioner")); %></td>
                                                         
                            <td rssdate="<% out.print(list.get("datapetition")); %>,yyyy-MM-dd"></td>


                            <td><% out.print(list.get("problemter")); %></td>
                            <!--
                            <td petitionclassify="<% out.print(list.get("petitionclassify")); %>"></td>
                            -->
                            
                            <td><%
                                if ( list.get("petitionclassify").equals("1") ) {
                                    out.print( "参政议政" ); 
                                }
                                else if ( list.get("petitionclassify").equals("2") ) {
                                    out.print( "政策法规" ); 
                                }
                                else if ( list.get("petitionclassify").equals("3") ) {
                                    out.print( "工作原因" ); 
                                }
                                else if ( list.get("petitionclassify").equals("4") ) {
                                    out.print( "干部作风" ); 
                                }
                                else if ( list.get("petitionclassify").equals("5") ) {
                                    out.print( "信访人因素" ); 
                                }
                                else if ( list.get("petitionclassify").equals("6") ) {
                                    out.print( "自然灾害" ); 
                                }
                                else if ( list.get("petitionclassify").equals("7") ) {
                                    out.print( "涉外因素" ); 
                                }
                                if ( list.get("petitionclassify").equals("8") ) {
                                    out.print( "其他" ); 
                                }
                            %></td>

                            <td>
		            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold;">查看内容</span>
                             | <span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:red;font-weight: bold;">删除</span> 
                             | <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:orange;font-weight: bold;">编辑</span>  
                             | <span class="ys export" id="<% out.print(list.get("id")); %>" style="color:purple;font-weight: bold;">导出</span>                            

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
          $("#blockul>li").click(function () {
              $(this).addClass("sel").siblings().removeClass("sel");
              $(this).find("input").prop("checked", true);
          })


          $(function(){
              ﻿$(".view").click(function(){
                  let id = $(this).attr("id");
                  popuplayer.display("/leavis/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 1248, height: 740 });
              })
          });

          $(function(){
              ﻿$(".delete").click(function(){
                  let id = $(this).attr("id");
                  popuplayer.display("/leavis/visregis/delete.jsp?relationid=" + id + "&TB_iframe=true", '删除', {width: 400, height: 120});
              })
          });

          $(function(){
              ﻿$(".edit").click(function(){
                  let id = $(this).attr("id");
                  popuplayer.display("/leavis/visregis/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 1248, height: 740 });
              })
          });


        $(function(){
              ﻿$(".export").click(function(){
                  let id = $(this).attr("id");
                  location.href = "/leavis/visregis/companylist.jsp?relationid=" + id;
//                  popuplayer.display("/leavis/visregis/companylist.jsp?relationid=" + id + "&TB_iframe=true", '导出', {width: 960, height: 600 });
              })
          });
      </script>
    </body>
</html>