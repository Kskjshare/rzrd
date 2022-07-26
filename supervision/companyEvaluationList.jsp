<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "user_delegation");
    //RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    

    
    RssList inqueryEntity = new RssList(pageContext, "supervision_special_inquery");
    inqueryEntity.request();
    //inqueryEntity.select().where("id=?", req.get("id")).get_first_rows();
    //inqueryEntity.select().where("id=?",req.get("id") ).get_page_desc("id");
    inqueryEntity.select().where("id=?", req.get("id")).get_first_rows();
    String company = inqueryEntity.get("company");
    String[] companies = company.split(",");
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
                <!--<button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>-->
<!--                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <!--<button type="button" transadapter="file" class="butdfile">归档</button>-->

                <!--<button type="button" transadapter="butview" class="butview">查看</button>-->
                <!--<input type="hidden" id="transadapter" find="[name='id']:checked" />-->
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <!--<th class="w30"><input name="all"  type="checkbox"></th>-->
                            <th>单位名称</th>
                            <th>状态</th>                        
                            <th>操作</th>  
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                                  
                            RssList list = new RssList(pageContext, "supervision_company_evaluation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;                         
                            //list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'and state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and myid="+UserList.MyID(request)).get_page_desc("id");
                            //list.select().where("state like '%" + URLDecoder.decode(list.get("state"), "utf-8") + "%'  and typeid="+ req.get("typeid") ).get_page_desc("id");
                            //list.select().where("id=?", list.get("id")).get_first_rows();
                            //list.select().where("typeid="+ req.get("typeid") ).get_page_desc("id");
                           // while (list.for_in_rows()) {    
                            //while ( inqueryEntity.for_in_rows()) {
                            int ncompanies = companies.length ;
                            int index = 0 ;
                            RssList listuser = new RssList(pageContext, "user");
                            while( ncompanies > 0 ) {
                              boolean isEvaluateDone = false ;
                              //list.remove();
                              //list.select().where("id=" + req.get("id") + " and myid=" +  UserList.MyID(request) ).get_first_rows( );
                              String state = "未评测";
                              String companyId = companies[ index ];
                              String companyName = "未知";
                              if ( companyId.isEmpty() ) {
                                  continue;
                              }
                              
                              list.remove();
                              list.select().where("evaluationid=" + req.get("id") + " and myid=" +  UserList.MyID(request) + " and companyid="+ companyId ).get_first_rows( );
                              
                            
                              listuser.request();
                              listuser.select().where("myid=" +  companyId ).get_first_rows( );
                              companyName = listuser.get("company");
                           
                              
                              
                              index ++ ;
                              if ( list.get("companyid").equals(companyId) ) {
                                  state = "已评测";
                                  isEvaluateDone = true ;
                              }
                              
                              

                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>                        
                            <td ><% out.print( companyName );%></td>
                            <td ><% out.print( state );%></td>
                            <td>                         
                            <span class="ys viewDetail" id="<% out.print( inqueryEntity.get("id") ); %>" companyid="<% out.print( companyId  ); %>" style="color:blue;font-weight: bold" >查看满意度</span>  
                            <%
                            if ( !isEvaluateDone ) {
                            %>
                            <span class="ys evaluate" id="<% out.print( inqueryEntity.get("id") ); %>"  companyid="<% out.print( companyId  ); %>"  style="color:blue;font-weight: bold" > | 评测</span>  
                            <%
                            }
                            %>
                            </td>                                           
                        </tr>
                        <%
                                a++;
                                ncompanies --;
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
                ﻿$(".viewDetail").click(function(){
                    let id = $(this).attr("id");
                    let companyid = $(this).attr("companyid");
                    popuplayer.display("/supervision/companyevaluationview.jsp?id=" + id + "&typeid=5"+ "&companyid="+ companyid, '查看满意度', {width: 830, height: 280});
                })
            });
            
            $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                    let companyid = $(this).attr("companyid");
                    popuplayer.display("/supervision/companyevaluation.jsp?id=" + id   + "&typeid=5" + "&companyid="+ companyid , '满意度测评', {width: 830, height: 280});
                })
            });
            
            $(function(){
                ﻿$(".submit").click(function(){
                    let id = $(this).attr("id");
                 popuplayer.display("/supervision/specialinquery/submit.jsp?id=" + id, '提交主任会议审议', {width: 830, height: 460});
                 //popuplayer.display("/supervision/topic/duty/inspectReport.jsp?id=" + id, '主任会议审议', {width: 830, height: 460});
                })
            });
            
            $(function(){
                ﻿$(".assign").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/assignHandleReport.jsp?id=" + id , '提交办理情况报告', {width: 420, height: 180});
                })
            });
              $(function(){
                ﻿$(".report").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/reportview.jsp?id=" + id , '主任会议汇报', {width: 830, height: 460});
                })
            });
            
             $(function(){
                ﻿$(".edit").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/edit.jsp?id=" + id , '编辑', {width: 830, height: 560});
                })
            });
             $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/delete_1.jsp?id=" + id , '删除', {width: 330, height: 80});
                })
            });
            
             $(function(){
                ﻿$(".preview").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/supervision/specialinquery/preview.jsp?id=" + id , '审阅', {width: 830, height: 320});
                })
            });
        </script>
    </body>
</html>