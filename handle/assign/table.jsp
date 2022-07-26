<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>


<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "sort");
    CookieHelper cookie = new CookieHelper(request, response);
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
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .toolbar>.disnone{display: none}
            tbody tr:hover{background-color: gainsboro;}
            .res{float: right;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
<!--                <button type="button" transadapter="append" class="butedit <% out.print(list.get("deal").equals("0") ? "" : "disnone");%>">交办</button>-->
<!--                <button  type="button" transadapter="append" class="butedit <% out.print(list.get("deal").equals("0") ? "disnone" : "");%>">重新交办</button>-->
<!--                <button type="button" transadapter="see" class="butview">查看</button>-->
                <button type="button" class="res">返回上一级</button>
                <!--<button type="button" transadapter="append" select="false" class="butreports">报表</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            
                            <!--
                            <th class="w60"><%
                                String a;
                                if (list.get("type").equals("1")) {
                                    a = "编号";
                                } else {
                                    a = "编号";
                                }
                                out.print(a); %></th>
                            -->
                            <th class="w80">题目</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">类型</th>
                            <!--<th class="w60">是否会上</th>-->
                            <th class="w60">提交日期</th>
                            <!--<th class="w60">办理类型</th>-->
                            <th class="w60">交办状态</th>
	           <th class="w60">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            list.request();
                            int b = 1;
                            list.pagesize = 30;
                            String sql = "";
                            if (cookie.Get("powergroupid").equals("23")) {//市级 督察局
                               // sql += " and isxzsc=0 and level=1";
                                 sql += " and isxzsc=0";
                            } else if (cookie.Get("powergroupid").equals("25")) {//乡镇 政府办
                                sql += " and (isxzsc=1 or level=0)";
                            }
                            
                            
                        String meetingTime="0";
                            try {
                            String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
                            Properties properties = new Properties();
                            InputStream is = new FileInputStream(propertiesFileName);
                            properties.load(is);
                            is.close();
                            meetingTime = properties.get("meetingtime").toString();
                        } catch (Exception e) {
                         e.printStackTrace();
                        }
                        
                        
                        if ( meetingTime.equals("1")){
                            sql += " and ismeet=1";
                          
                         }
                        else {
                            sql += " and ismeet=0";
                         }
                            
                        
                        //removed by ding 20200510
                        //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and handlestate like '%" + URLDecoder.decode(list.get("handlestate"), "utf-8") + "%' and examination like '%" + URLDecoder.decode(list.get("examination"), "utf-8") + "%' and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8") + "%' and registertype like '%" + URLDecoder.decode(list.get("registertype"), "utf-8") + "%' and handle like '%" + URLDecoder.decode(list.get("handle"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(list.get("realid"), "utf-8") + "%' and type like '%" + URLDecoder.decode(list.get("type"), "utf-8") + "%' and deal like '%" + URLDecoder.decode(list.get("deal"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(list.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(list.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(list.get("year"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(list.get("meetingnum"), "utf-8") + "%'  and draft=2" + sql).get_page_desc("realid");
   
                            
                        list.select().where("handlestate like '%" + URLDecoder.decode(list.get("handlestate"), "utf-8") + "%' and examination like '%" + URLDecoder.decode(list.get("examination"), "utf-8") + "%' and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8")  + "%' and handle like '%" + URLDecoder.decode(list.get("handle"), "utf-8") + "%' and type like '%" + URLDecoder.decode(list.get("type"), "utf-8") + "%' and deal like '%" + URLDecoder.decode(list.get("deal"), "utf-8")   + "%'  and draft=2").get_page_desc("realid");
                        while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbjlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(b); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--
                            <td><% out.print(list.get("realid")); %></td>
                            -->
                            <td class="tl"><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td lwstate="<% out.print(list.get("type")); %>"></td>
                            <!--<td judgment="<% out.print(list.get("meet")); %>"></td>-->
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                            <!--<td handle="<% out.print(list.get("handle")); %>"></td>-->
                            <td deal="<% out.print(list.get("deal")); %>"></td>
		
	            <td>
	            <% 
		if ( list.get("deal").equals("1") || (  list.get("handlestate").equals("2") ) ) {
	           %>
		<span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span> 
	         <% 
	             } else {
	           %>
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span> | 
                            <span class="ys jiaoban" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;" >交办</span> 
	            <% 
	             }
	           %>
                            </td>




                           <!--<td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>-->
                    <input type="hidden" value="<% out.print(list.get("type")); %>">
                    </tr>
                    <%
                            b++;
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
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
                            $(".res").click(function () {
                                history.go(-1);
                            });
	//操作栏响应函数
 	$(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".jiaoban").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/handle/deal.jsp?id=" + id + "&TB_iframe=true", '交办', {width: 830, height: 560});
                })
            });

        </script>
    </body>
</html>
