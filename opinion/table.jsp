<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookies = new CookieHelper(request, response);
    RssListView list = new RssListView(pageContext, "sort");
    String wheres = " myid like '" + cookies.Get("myid") + "'";
    list.request();
    
 
    //增加闭会 开会 条件过滤 
   String meetingTime="0";
   int isMeeting = 0 ;
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
    if ( meetingTime.equals("1")) {
        isMeeting =  1;
    }

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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <%
                    if (!((req.get("consultation").equals("1") && req.get("resume").equals("1"))||req.get("consultation").equals("0") && req.get("resume").equals("0"))) {
                %>
                <button type="button" transadapter="append" class="butedit" >填写意见</button>
                <%
                    }
                %>
                <!--
                <button type="button" transadapter="see" class="butview">排序</button>
                -->
                
                 <button type="button" transadapter="sort"  select="false" class="sort">排序</button>
                
                <button type="button" class="res">返回上一级</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                             
                            <th class="w30">选择</th>
                           
                            <!--<th class="w60">编号</th>-->
                            
                            <th class="w100">标题</th>
                            <th class="w60">领衔代表</th>
                            <th class="w60">类型</th>
                            <th class="w60">要求结办日期</th>
                            <th class="w60">主办单位</th>
                            <!--<th class="w80">办理类型</th>-->
                            <th class="w60">人数</th>
                            <th class="w60">状态</th>
                            <th class="w60">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int a = 1;
                            list.pagesize = 30;
                            if (cookies.Get("powergroupid").equals("5")) {
                                
                                if (isMeeting == 1)
                                list.select().where("resume like '%" + list.get("resume") + "%' and lwstate like '%" + list.get("lwstate") + "%' and draft=2 and title like '%" + 
                                        list.get("title") + "%' and consultation like '%" + list.get("consultation") + "%' and " + "ismeet=1 and  " + wheres).get_page_desc("id");
                                else
                                    list.select().where("resume like '%" + list.get("resume") + "%' and lwstate like '%" + list.get("lwstate") + "%' and draft=2 and title like '%" + 
                                        list.get("title") + "%' and consultation like '%" + list.get("consultation") + "%' and " + "ismeet=0 and  " + wheres).get_page_desc("id");
                            } else {
                                if (isMeeting == 1)
                                list.select().where("resume like '%" + list.get("resume") + "%' and lwstate like '%" + list.get("lwstate") + "%' and draft=2  and ismeet=1 and title like '%" + list.get("title") 
                                        + "%' and consultation like '%" + list.get("consultation") + "%'").get_page_desc("id");
                                else
                                      list.select().where("resume like '%" + list.get("resume") + "%' and lwstate like '%" + list.get("lwstate") + "%' and draft=2 and ismeet=0 and title like '%" + list.get("title") 
                                        + "%' and consultation like '%" + list.get("consultation") + "%'").get_page_desc("id");
                            }
                            
//                           list.select().where("lwstate like '%" + list.get("lwstate") + "%' and draft=2  and resume=1 and title like '%" + list.get("title") 
//                                        + "%' and consultation like '%" + list.get("consultation") + "%'").get_page_desc("id");  

                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbcdlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                              
                            <td><input type="radio" name="id" value="<% out.print(list.get("id")); %>" /></td>
                          
                            <!--<td><% // out.print(list.get("realid")); %></td>-->
                            
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td lwstate="<% 
                                if ( list.get("lwstate").equals("1") ){
                                    out.print( "建议"); 
                                }
                                else if ( list.get("lwstate").equals("2") ) {
                                     out.print( "议案"); 
                                }
                                else if ( list.get("lwstate").equals("3") ) {
                                     out.print( "批评"); 
                                }
                                else if ( list.get("lwstate").equals("4") ) {
                                     out.print( "意见"); 
                                }
                                else if ( list.get("lwstate").equals("5") ) {
                                     out.print( "质询"); 
                                }
                            %>"></td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                            <td><%
                                RssListView company = new RssListView(pageContext, "company_sug");
                                company.select().where("id=?", list.get("id")).get_page_desc("id");
                                while (company.for_in_rows()) {
                                    out.print("<p>" + company.get("allname") + "</p>");
                                }
                                %></td>
                            <!--<td handle="<% out.print(list.get("handle")); %>"></td>-->
                            <td font-size="20px"><% out.print(list.get("numpeople")); %></td>
                            
                            
                            
                                <% //examination:    审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查
                                    //draft:起草1草稿2已提交    待初审    待交办         待复审
                                    //deal:是否已交办 //iscs初审状态（0否 1是)//isxzsc：乡镇政府办审查状态(0否 1是）
                                    //handlestate:（确定办理单位）建议议案办理状态1:未确定,2待确定,3已确定,4申退中//resume:是否办复(0否 1是）
                                    String handle = "";
                                    
                                    //added by ding
                                    int btnAuditShow = 1 ; // 审查按钮
                                    int isDone = 0 ;//是否已经办理结束
                                  
                                    if (list.get("examination").equals("1")) {
                                        handle = "<td class='handle no' style='color:red;font-weight:bold;'>未审查</td>";//待初审21
                                       
                                    }
                                   
                                    if (list.get("examination").equals("2")) {
                                        handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待交办</td>";//待交办41
                                        btnAuditShow = 0 ;
                                        if ( list.get("handlestate").equals("2") || list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                            handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                         if ( list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                          btnAuditShow = 1;
                                         }
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        //修改闭会乡镇代表流程，提示状态
                                        //handle = "<td class='handle no' style='color:Green'>乡镇政府办已答复</td>";//141
                                        handle = "<td class='handle no' style='color:DarkOrange;font-weight:bold;'>待交办</td>";//141
                                        btnAuditShow = 0 ;
                                        if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                            handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                         if ( list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                          btnAuditShow = 1;
                                         }
                                    }
                                    
                                  if (list.get("handlestate").equals("3")) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待交办</td>";//51
                                        btnAuditShow = 0 ;
                                        if ( list.get("deal").equals("1") ) {
                                            handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待办复</td>";//51
                                        }
                                    }
                                    if (list.get("handlestate").equals("4")) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>已驳回</td>";//51
                                        btnAuditShow = 0 ;
                                    }
                                    
                                    
                                    if ( list.get("handlestate").equals("3") ) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待办复</td>";//51
                                        if ( list.get("deal").equals("0") ) {
                                             handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待交办</td>";//51
                                        }
                                        btnAuditShow = 0 ;
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        //handle = "<td class='handle no' style='color:Olive'>已办复</td>";//151
                                         handle = "<td class='handle no' style='color:green;font-weight:bold;'>已办复</td>";//151
                                        btnAuditShow = 0 ;
                                        isDone =  1;
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "<td class='handle no' style='color:CadetBlue;font-weight:bold;'>已置回</td>";//121
                                        btnAuditShow = 0 ;
                                    }
                                    out.print(handle);
                                %>
                            
                            
                            
                            <td style="color:blue;">
                            <%
                            if (list.get("consultation").equals("0") && (isDone == 1 ) ){ //未评价
                            %>
                            <span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看内容</span> | 
                            <span class="ys comment" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">评价</span> 
                             | <span class="ys result" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">评价结果</span> 
                            <%
                            }else{
                            %>
                            <span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看内容</span> |                          
                            <span class="ys result" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">评价结果</span> 
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
        <script src="controller.js"></script>
        <script>
                            $(".res").click(function () {
                                history.go(-1);
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
                popuplayer.display("/opinion/append.jsp?id=" + id , '评价', {width: 730, height: 430});
                })
            });
            
            
             $(function(){
                ﻿$(".result").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/opinion/evaluation/list_3.jsp?id=" + id , '评价结果', {width: 500, height: 480});
                })
            });
            
            
             $(function(){
                ﻿$(".sort").click(function(){
                   // let id = $(this).attr("id");
                popuplayer.display("/opinion/sort.jsp" , '排序', {width: 550, height: 100});
                })
            });
//            zyx 修改弹窗大小
            
        </script>
    </body>
</html>
