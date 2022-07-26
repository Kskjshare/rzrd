<%@page import="RssEasy.MySql.User.UserList"%>
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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">发布</button>
                <button type="button" transadapter="edit" class="butedit" powerid="432">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="431">删除</button>
                <button type="button" transadapter="butview" class="butview">预览</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w60">序号</th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>类别</th>
                            <th>提交时间</th>
                            <th>发布状态</th>
                            <th>审核状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        
                       
                        
//                        RssList userlist2 = new RssList(pageContext, "user");
//                        userlist2.request();
                        String division_user_id = "9999999999999";

                            
                        //获取是否是分站的联系人或者站长
                        RssList userlist = new RssList(pageContext, "user");
                        //list.pagesize = 8;
                        userlist.request();
                        userlist.select().where("myid=?", UserList.MyID(request) ).get_first_rows();
                       

                        String stationid = "9999999999999";
                        boolean stationExist = false ;
                        
                        
                        boolean iscontactstation = false ;
                        RssList contactstation = new RssList(pageContext, "contactstation");
                        contactstation.request();
                        contactstation.select().where("myid=?", UserList.MyID(request) ).get_page_desc("id");  
                        while (contactstation.for_in_rows()) {
                         stationid = contactstation.get("stationid");
                         iscontactstation = true ;

                         break;
                        }
                      
                        
                        //查找发布信息的用户是否联络人
                        RssList list_contactstation_sub = new RssList(pageContext, "contactstation_sub");
                        list_contactstation_sub.request();
                        list_contactstation_sub.select().where("linkmantelephone="+ userlist.get("telphone")).get_page_desc("id");
                         while (list_contactstation_sub.for_in_rows()) {
                            stationid = list_contactstation_sub.get("stationid");
                            stationExist = true ;
                            division_user_id = userlist.get("myid");

                            break;
                        }

                        //查找发布信息的用户是否站长
                        if ( !stationExist ) {
                            list_contactstation_sub.select().where("mastertelephone="+ userlist.get("telphone")).get_page_desc("id");
                             while (list_contactstation_sub.for_in_rows()) {
                                stationid = list_contactstation_sub.get("stationid");
                                stationExist = true ;
                                division_user_id = userlist.get("myid");

                                break;
                            }
                        }
                            
                            
                            boolean released = false ;
                            String powergroupid =  cookie.Get("powergroupid");
                            boolean isNeedAudit = false ;
                            if ( powergroupid.equals("7")) { //选工委
                                isNeedAudit = true ;
                            }
                            RssList list = new RssList(pageContext, "stationcontent");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            if ( powergroupid.equals("7")) {
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(list.get("classify"), "utf-8") + "%'" ).get_page_desc("shijian");
                            }
                            else {
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(list.get("classify"), "utf-8") + "%' and myid=" + UserList.MyID(request)).get_page_desc("shijian");
                                if ( iscontactstation ) { //如果是主站
                                    list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(list.get("classify"), "utf-8") + "%' and stationid=" + stationid ).get_page_desc("shijian");
                                }
                                else {
                                   list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and classify like '%" + URLDecoder.decode(list.get("classify"), "utf-8") + "%' and myid=" + division_user_id ).get_page_desc("shijian");

                                }
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbylclick();" contacttype="<% out.print(list.get("classify")); %>" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td stationcontent="<% out.print(list.get("classify")); %>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd HH:mm:ss" ></td>
                            <!--<td style="display: none;"><% out.print(list.get("classify")); %></td>-->
                            
                            <%
                            if ( list.get("state").equals("2")){
                            %>
                            <td style="color:green;font-weight:bold;" noticestate="<% 
                                //out.print(list.get("state"));
                                out.print("已发布");
                               
                                %>"></td>
                            <%
                            }else if( list.get("state").equals("1")){
                               
                            %>
                            <td style="color:red;font-weight:bold;" noticestate="<% 
                                out.print("未发布");
                                released = true ;
                            %>"></td>
                            <%
                            };
                            %>
                            
                            
                            <%
                            if ( list.get("audit").equals("1")){
                            %>
                            <td style="color:red;font-weight:bold;" noticestate="<% 
                                //out.print(list.get("state"));
                                out.print("未审核");
                                released = true ;
                                %>"></td>
                            <%
                            }else if( list.get("audit").equals("2")){
                               
                            %>
                            <td style="color:green;font-weight:bold;" noticestate="<% 
                                out.print("已审核");
                                released = false ;
                            %>"></td>
                            <%
                            } else if( list.get("audit").equals("3")){
                            %>
                             <td style="color:green;font-weight:bold;" noticestate="<% 
                                out.print("已审核");
                                released = false ;
                            %>"></td>
                            <% }%>
                           
                            
                            
                            <td>     
                            <%    
                            if ( released  && isNeedAudit ) {                          
                            %>
                             <span class="ys release" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >审核</span> |
                            <% 
                            }
                            %>        
                                
                            <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >编辑</span>    
                            |<span class="ys delete" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >删除</span>
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
                popuplayer.display("/contactstation/my/edit.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 860, height: 640});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/my/delete.jsp?id=" + id + "&TB_iframe=true", '删除', {width: 230, height: 80});
                })
            });
            
            
             $(function(){
                ﻿$(".release").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/contactstation/my/auditview.jsp?id=" + id + "&TB_iframe=true", '审核', {width: 960, height: 600});
                })
            });
        </script>
    </body>
</html>