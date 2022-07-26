<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    String parentid = cookie.Get("parentid");
    String state = cookie.Get("state");
    String powergroupid = cookie.Get("powergroupid");
    String rid = "";
    String view = "sort";

    //if (powergroupid.equals("16")) { //added by ding
    //    view = "sort";
    //} else 
    	{
        view = "company_sug";
        if (state.equals("5")) {
            rid = " and companyid=" + parentid;
        } else {
            rid = " and companyid=" + UserList.MyID(request);
    
        }
        
        
        //added by ding
        //rid = "";
        //view = "sort";
    }
    RssListView list = new RssListView(pageContext, view);
    list.request();
    list.pagesize = 30;
    list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") 
//            + "%' and realid like '%" + URLDecoder.decode(list.get("realid"), "utf-8") 
//            + "%' and registertype like '%" + URLDecoder.decode(list.get("registertype"), "utf-8") 
            + "%' and handlestate like '%" + URLDecoder.decode(list.get("handlestate"), "utf-8") 
            + "%' and examination like '%" + URLDecoder.decode(list.get("examination"), "utf-8") 
            + "%' and draft like '%" + URLDecoder.decode(list.get("draft"), "utf-8") 
            + "%' and type like '%" + URLDecoder.decode(list.get("type"), "utf-8") 
            + "%' and degree like '%" +URLDecoder.decode(list.get("degree"), "utf-8") 
            + "%'and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8") 
//            + "%' and allname like '%" + URLDecoder.decode(list.get("allname"), "utf-8") 
//            + "%' and sessionid like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") 
//            + "%' and telphone like '%" +URLDecoder.decode(list.get("telphone"), "utf-8") 
//            + "%' and year like '%" + URLDecoder.decode(list.get("year"), "utf-8") 
            + "%'  and deal like '%" + URLDecoder.decode(list.get("deal"), "utf-8")
            +"%' and meetingnum like '%" + URLDecoder.decode(list.get("meetingnum"), "utf-8") 
            + "%' and resume like '%" + URLDecoder.decode(list.get("resume"), "utf-8") 
            + "%'" + rid).get_page_desc("id");




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
            tbody tr:hover{background-color: gainsboro;}
            .res{float: right;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <%              
                    if (!(req.get("resume").equals("1"))) {
                %>
<!--                <button type="button" transadapter="resume" class="butedit">办理回复</button>
                <button  type="button" transadapter="resumedelete" class="butreturn">驳回转办</button>-->
                <%
                    }
                %>
<!--                <button  type="button" transadapter="see" class="butview">查看</button>-->

                <button type="button" class="res">返回上一级</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                               <!--
                            <th class="w30"><input name="all" type="checkbox"></th>
                         
                            <th class="w60">
                                <%                               
                                String a;
                                if (list.get("type").equals("1")) {//建议
                                    a = "编号";
                                } else {
                                    a = "编号";
                                }
                                out.print(a); 
                                %>
                            </th>
                            -->
                            <th class="w80">类型</th>
                            <th class="w80">标题</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">代表团</th>
                            <th class="w60">主办单位</th>
                            <th class="w60">状态</th>
                            <!--<th class="w80">办理类型</th>-->
                            <!--th class="w60">具体答复日期</th-->
                            <!--th class="w60">要求结办日期</th-->
	           <th class="w120">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int b = 1;
                            while (list.for_in_rows()) {
                                
                           // String realcompanyid = list.get("realcompanyid");
                           // if ( !realcompanyid.contains( cookie.Get("myid") )) {
                            //if ( !list.get("companyid").contains(  UserList.MyID(request) )) {

                           
//                                continue;
                           // }
                        %>
                        <tr ondblclick="ck_dbAbilclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(b); %></td>
                             <!--
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                           
                            <td><% out.print(list.get("realid")); %></td>
                            -->
                            
                             <td>
                                 <% 
                                if (list.get("type").equals("1")) {//建议
                                    out.print( "建议" ); 
                                    
                                } else if (list.get("type").equals("2")){
                                    out.print( "议案" ); 
                                }else if (list.get("type").equals("3")){
                                    out.print( "批评" ); 
                                }else if (list.get("type").equals("4")){
                                    out.print( "意见" ); 
                                }else if (list.get("type").equals("5")){
                                    out.print( "质询" ); 
                                }
                                 %>
                             </td>
                             
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <%
                                if (cookie.Get("powergroupid").equals("16")) {
                            %>
                            <td><% out.print(list.get("allname")); %></td>
                            <%
                            } else {
                            %>
                            <td><% out.print(list.get("delegationname")); %></td>
                            <%
                                }
                            %>

<!--<td rssdate="<% list.write("stop"); %>,yyyy-MM-dd  HH:mm:ss"></td>-->
                            <td><%
                                RssListView company = new RssListView(pageContext, "suggest_company");
                                company.select().where("type=2 and suggestid=" + list.get("id")).query();
                                String str = "";
                                while (company.for_in_rows()) {
                                    str += "<p>" + company.get("allname") + "</p>";
                                }
                                out.print(str);
                                %></td>
                            <td resume="<% out.print(list.get("resume")); %>"></td>

                            <!--<td handle="<% out.print(list.get("handle")); %>"></td>-->
                            <!--td rssdate="<% list.write("ResponseTime"); %>,yyyy-MM-dd  HH:mm:ss"></td-->
                            <!--td rssdate="<% list.write("stop"); %>,yyyy-MM-dd  HH:mm:ss"></td-->
                            <!--<td popup="popup" href="/upfile/<% out.print(list.get("ico")); %>"><% out.print(list.get("ico")); %></td>-->
                    <input type="hidden" value="<% out.print(list.get("type")); %>">
		

	<td> 
  <%
    	if (!(req.get("resume").equals("1"))) {
   %>
  	<span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;" >查看内容</span> |  
 	<span class="ys reply" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;" >办理回复</span>   | 
	<span class="ys reject" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;" >驳回转办</span>  
<%
	}
	else{
   %>
	<span class="ys view" id= "<% out.print(list.get("id")); %>"  style="color:blue;font-weight:bold;" >查看内容</span> 
<%
	}
  %>
 	</td> 


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
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
                            $(".res").click(function () {
                                history.go(-1);
                            });

	$(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                   popuplayer.display("/handle/query.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
                })
            });
	
	$(function(){
                ﻿$(".reply").click(function(){
                    let id = $(this).attr("id");
                   popuplayer.display("/handle/resume/resumeedit.jsp?id=" + id + "&TB_iframe=true", '办理回复', {width: 830, height: 560});
                })
            });

$(function(){
                ﻿$(".reject").click(function(){
                    let id = $(this).attr("id");
                   popuplayer.display("/handle/resume/delete.jsp?id=" + id + "&TB_iframe=true", '驳回转办', {width: 410, height: 100});
                })
            });



        </script>
    </body>
</html>
