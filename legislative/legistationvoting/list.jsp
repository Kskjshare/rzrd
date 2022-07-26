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
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <!--<button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <!--<button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>法规名称</th>
                            <th>类别</th>
                            <th>起草部门</th>
                            <th>起草日期</th>
                            <th>一审时间</th>
                            <th>二审时间</th>
                            <th>三审时间</th>
                            <th>提请省人大常委会时间</th>
                            <th>省人大常委会批复时间</th>

                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // 会议表决  --state = 4 ;
                               // 省人大常委会报批  --state = 5;
                            RssList list = new RssList(pageContext, "legislativeprocess");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            int isVoting = 0 ;
                            int isSumbitcommittee = 0 ;
                            //99表示终止审议状态
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and state=4 or state=5 or state=6 or state=99").get_page_desc("id");
                            while (list.for_in_rows()) {  
                                isVoting = 0 ;
                                isSumbitcommittee = 0 ;
                                if ( list.get("state").equals("4") ) {
                                    isVoting = 1 ;
                                }
                                if ( list.get("state").equals("5") ) {
                                    isSumbitcommittee = 1 ;
                                }
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("classificationname")); %></td>
                            <td><% out.print(list.get("department")); %></td>                           
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("firstAduitTime")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("secondAuditTime")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("thirdAuditTime")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("thirdAuditTime")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("thirdAuditTime")); %>,yyyy-MM-dd" ></td>

                            
                            <td>                       
                            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看</span> |
                            <span class="ys edit" id="<% out.print(list.get("id")); %>" style="color:green;font-weight: bold" >修改</span> 
                            
                            <% 
                            if ( isVoting == 1 ) {
                            %>   
                            | <span class="ys vote" id="<% out.print(list.get("id")); %>" style="color:red;font-weight: bold" >会议表决</span> 
                            <% 
                            }
                            %>
                           
                            
                            <% 
                            if ( isSumbitcommittee == 1 ) {
                            %>   
                            | <span class="ys submitcommittee" id="<% out.print(list.get("id")); %>" style="color:red;font-weight: bold" >提请省人大常委会</span> 
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

        <script src="./controller.js">
        </script>

        <script>
            
              $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/legislative/legistationvoting/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 440});
                })
            });
             $(function(){
                ﻿$(".vote").click(function(){
                    let id = $(this).attr("id");              
                    popuplayer.display("/legislative/legistationvoting/auditview.jsp?id=" + id + "&TB_iframe=true", '会议表决', {width: 860, height: 460});


                })
            });
            
             $(function(){
                ﻿$(".submitcommittee").click(function(){
                    let id = $(this).attr("id");                 
                    popuplayer.display("/legislative/legistationvoting/auditview2.jsp?id=" + id + "&TB_iframe=true", '提请省人大常委会', {width: 860, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/legislative/legistationvoting/edit.jsp?id=" + id + "&TB_iframe=true", '修改', {width: 860, height: 580});
                })
            });

        </script>

    </body>
</html>