<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookies = new CookieHelper(request, response);
    RssListView list = new RssListView(pageContext, "sortuser");
    String wheres = " userid like '" + cookies.Get("myid") + "'";
    list.request();
    
    //ding
//    RssList second_opinion_list = new RssList(pageContext, "second_opinion");
//    second_opinion_list.request();
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
            .cellbor{width: 100%}
            .toolbar>.disnone{display: none}
            tbody tr:hover{background-color: gainsboro;}
            .res{float: right;}
            .a{display: none;}
            span{font-weight:bold;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <!--
                <button type="button" transadapter="append_1" class="butedit" >填写意见</button>
                <button type="button" transadapter="see" class="butview">查看建议</button>
                -->
                <button type="button" class="res">返回上一级</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                            <!--
                            <th class="w30">选择</th>
                            <th class="w60">编号</th>
                            -->
                            
                            <th class="w100">标题</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">类型</th>
                            <th class="w60">要求结办日期</th>
                            <th class="w60">主办单位</th>
                            <!--<th class="w80">办理类型</th>-->
                            <th class="w60">人数</th>
                            <!--<th class="w60">意见</th>-->
                            <th class="w60">状态</th>
                            <th class="w60">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int a = 1;
                            list.pagesize = 30;
                            if (cookies.Get("powergroupid").equals("5")) {
                                list.select().where("resume=1 and " + wheres).get_page_desc("id");
                            } else {
                                list.select().where("resume=1").get_page_desc("id");
                            }

                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcdlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <!--
                            <td><input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td lwstate="<% out.print(list.get("lwstate")); %>"></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                            <td><%
                                RssListView company = new RssListView(pageContext, "company_sug");
                                company.select().where("id=" + list.get("id") + "").get_page_desc("id");
                                while (company.for_in_rows()) {
                                    out.print("<p>" + company.get("account") + "</p>");
                                }
                                %></td>
                            <!--<td handle="<% out.print(list.get("handle")); %>"></td>-->
                            <td><% out.print(list.get("numpeople")); %></td>
                            <!--<td resumetype="<% out.print(list.get("resumetype")); %>"></td>-->
                            
                            <td>
                                <% 
                                    if (list.get("consultation").equals("1") || list.get("resumetype").equals("1") ){
                                        out.print("已评价");
                                    } 
                                    else {
                                        out.print("未评价");
                                    }
                                %>
                            </td>
                             
                             <td style="color:blue;">
                             <%      
                                                    
//                                String condition = " userid like '" + cookies.Get("myid") + "'";                            
//                                second_opinion_list.select().where("proposal=" + list.get("id") + " and myid="+ cookies.Get("myid")+ "").get_page_desc("id");
//                                int count = 0 ;
//                                int showEvaluation = 1 ;
//                                if (second_opinion_list.totalrows == 0 ) {
//                                    showEvaluation =  0 ; 
//                                }
//                                else {
//                                     if ( second_opinion_list.get("evaluationDone").equals("1") ) {
//                                         showEvaluation =  0 ;
//                                     }
//                                }
//                                
//                                if (list.get("resumetype").equals("1")) {
//                                    showEvaluation =  0 ;
//                                }
                             



                            if (list.get("consultation").equals("1") || list.get("resumetype").equals("1") ) {
                            // if (list.get("consultation").equals("1")  ) {
                             %>
                             <span class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span> | 
                             <span class="ys result" id="<% out.print(list.get("id")); %>">评价结果</span> 
                            
                             
                             <% 
                                }else{
                             %>
                              <span class="ys chakan" id="<% out.print(list.get("id")); %>">查看内容</span> | 
                             <span class="ys comment" id="<% out.print(list.get("id")); %>">评价</span> 
                             | <span class="ys result" id="<% out.print(list.get("id")); %>">评价结果</span> 
                             <% 
                                }
                             %>
                             
                             
                            </td>
                            
                    <input type="hidden" value="<% out.print(list.get("type")); %>">
                    </tr>
                    <%
                            a++;
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                <input class="a" name="resume" value="<%out.print(req.get("resume"));%>" />
                <input class="a" name="consultation" value="<%out.print(req.get("consultation"));%>" />
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <script src="controller.js" type="text/javascript"></script>
        <script>
                            $(".res").click(function () {
                                location.href = "/opinion/look.jsp";
                            });
                            
                            
                            
                            
                            
                                         
            $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/butview.jsp?id=" + id, '查看内容', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".comment").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/opinion/append_1.jsp?id=" + id , '评价', {width: 830, height: 560});
                })
            });
            
            
             $(function(){
                ﻿$(".result").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/opinion/evaluation/list_3.jsp?id=" + id , '评价结果', {width: 500, height: 580});
                })
            });
              
                            
        </script>
    </body>
</html>
