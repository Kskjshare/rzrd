<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
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
          .ys{
                color: blue;
            }
            .delete{
                color: red;
            }   
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                
                <input type="hidden" id="transadapter" find="[name='id']:checked" />

                <%
                    if ( powerid.equals("7")){
                %>
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>    
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="430">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="429">删除</button>
                
                <button type="button" transadapter="demonstration1" class="butedit">设为规范化联络站</button>
                <button type="button" transadapter="demonstration" class="butedit">设为示范联络站</button>
                <button type="button" transadapter="demonstration2" class="butedit">设为明星联络站</button>
                <button type="button" transadapter="demonstration3" class="butdelect">恢复</button>
                 <%
                   }
                %>
                
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>站点名称</th>
                            <!--<th>所属乡镇(街道)</th>-->

                            <th>规范化等级</th>
                            <th>站长</th>
                            <th>站长电话</th>

                            <th>联络员</th>
                            <th>联络员电话</th>
                            <th>操作</th>


                            <!--<th>添加时间</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList contactstation = new RssList(pageContext, "contactstation_new");
                            contactstation.request();
                            contactstation.select().where("id=?", req.get("id")).get_first_rows();

                            String level_str= "普通联络站";
                            String style = "color:black;";
                            RssListView list = new RssListView(pageContext, "contactstation_sub");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' " + " and stationid=" + contactstation.get("stationid") ).get_page_desc("id");
                            while (list.for_in_rows()) {
                                
                            if ( list.get("demonstration").equals("2")) {
                                level_str= "示范联络站";
                                style = "color:red;font-weight:bold;";
                            }
                            else if ( list.get("demonstration").equals("3") ) {
                                level_str= "规范化联络站";
                                style = "color:green;font-weight:bold;";
                            }
                            else if ( list.get("demonstration").equals("4") ) {
                                level_str= "明星联络站" ;
                                style = "color:orange;font-weight:bold;";
                            }
                            else {
                                level_str= "普通联络站";
                                style = "color:black";
                            }
                        %>
                        <tr ondblclick="ck_dbAbRlclick();" idd="<% out.print(list.get("id")); %>" myid="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><i style="margin: 0 5px; color: red;" class="iconfont iconhongqi"></i><% out.print(list.get("title")); %></td>
                            <!--<td><% out.print(list.get("name")); %></td>-->
                            <td class="levelState" style="<% out.print(style); %>" demonstration="<% out.print( level_str ); %>"></td>
                            <td><% out.print(list.get("master")); %></td>
                            <td><% out.print(list.get("mastertelephone")); %></td>

                            <td><% out.print(list.get("linkman")); %></td>
                            <td><% out.print(list.get("linkmantelephone")); %></td>

                            <!--<td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd " ></td>-->
                            
                            <td>
  		            <%
                            
                            if ( ( powerid != null && ( ("7").equals( powerid ) )) || ( powerid != null && ( ("16").equals( powerid ) )) )
                            {
                            %>
                            <span class="delete delete" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">删除</span> 
                            |<span class="ys edit" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">编辑</span> 
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
                popuplayer.display("/contactstation/substation/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 560, height: 400});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/substation/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 230, height: 80});
                })
            });   
        </script>
    </body>
</html>