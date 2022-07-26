<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
//    RssList list = new RssList(pageContext, "contactstationcityrepresentative");
//    list.request();
//    CookieHelper cookie = new CookieHelper(request, response);
//    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
//    list.request();


    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    String mission = req.get("myid");
    String name = req.get("name");
    String allname = req.get("allname");

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
            tbody tr:hover{background-color: gainsboro;}
            .res{float: right;}
            span[evaluationscorestate="0"]{color: red}
            span[evaluationscorestate="1"]{color: #b0b0b0}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <!--<button type="button" transadapter="append" select="false" class="quicksearch">新增</button>-->
                <!--<button type="button" transadapter="delete" select="false" class="butdelect">删除</button>-->
                <button type="button" class="res">返回上一级</button>
                <!--<input type="hidden" id="transadapter" find="[name='id']:checked" />-->
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <%
//                        String usertype = "0";
//                        if (cookie.Get("powergroupid").equals("5")) {
//                            usertype = "1";
//                        } else if (cookie.Get("powergroupid").equals("32")) {
//                            usertype = "2";
//                        } else if (cookie.Get("powergroupid").equals("22")) {
//                            usertype = "3";
//                        } else if (cookie.Get("powergroupid").equals("33")) {
//                            usertype = "4";
//                        }
                    %>
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <!--<th class="w30"><input name="all"  type="checkbox"></th>-->
                            <th>姓名</th>
                            <th>电话</th>
                            <th>入驻的联络站</th>
                            <th>所属代表团</th>
                            
                            
                            <!--<th>操作</th>-->
                            <!--<th>考核状态（代表 | 小组 | 街道 | 部门）</th>-->
                            <!--<th>操作</th>-->
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            int a = 1;

//                            //查询条件开始
//                            String sql = "1=1";
//                            sql += " and batchid=" + req.get("batchid");
//                            sql += " and realname like '%" + URLDecoder.decode(req.get("name1"), "utf-8") + "%'";
////                            sql += " and groupname like '%" + URLDecoder.decode(req.get("name2"), "utf-8") + "%'";
//                            sql += " and allname like '%" + URLDecoder.decode(req.get("name3"), "utf-8") + "%'";
//                            sql += " and scorestate1 like '%" + URLDecoder.decode(req.get("state1"), "utf-8") + "%'";
//                            sql += " and scorestate2 like '%" + URLDecoder.decode(req.get("state2"), "utf-8") + "%'";
//                            sql += " and scorestate3 like '%" + URLDecoder.decode(req.get("state3"), "utf-8") + "%'";
//                            sql += " and scorestate4 like '%" + URLDecoder.decode(req.get("state4"), "utf-8") + "%'";
//                            switch (usertype) {
//                                case "0":
//                                    sql += "";
//                                    break;
//                                case "2":
//                                    sql += " and groupid=" + UserList.MyID(request);
//                                    break;
//                                case "3":
//                                    sql += " and mission=" + UserList.MyID(request);
//                                    break;
//                                case "4":
//                                    sql += "";
//                                    break;
//                                default:
//                                    break;
//                            }
//                            String sql = "1=1";
//                            sql += " and ";
//                            list.select().where(sql).get_page_desc("id");
//                            list.select().where(" contactstationid=" + list.get("cid")).get_page_asc("id");
                            
                            
                            //list.select().where("mission=" + mission ).get_page_asc("id");
                            String sql = "account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and delegationname like '%" + URLDecoder.decode(list.get("delegationname"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and sex like '%" + URLDecoder.decode(list.get("sex"), "utf-8") + "%' and nationid like '%" + URLDecoder.decode(list.get("nationid"), "utf-8") + "%' and birthday like '%" + URLDecoder.decode(list.get("birthday"), "utf-8") + "%' and sessionlist like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and isdelegate=1 and " + "mission=" + mission;
                   
                            list.select().where(sql).get_page_desc("myid");
                         
                            
                            while (list.for_in_rows()) {
                                
                                    RssList listdivision = new RssList (pageContext, "station_sub_id");     
                                    listdivision.request();
                                    listdivision.select().where("myid="+ list.get("divisionid")).get_first_rows();

                                %>
                                <tr idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                                    <td class="w30"><% out.print(a); %></td>
                                    <!--<td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>-->
                                    <td><% list.write("realname"); %></td>
                                    <td><% list.write("telphone"); %></td>
                                    <!--<td><% out.print(name); %></td>-->
                                    <!--<td><% out.print( list.get( "divisionname" ) ); %></td>-->
                                    <td><% out.print( listdivision.get( "name" ) ); %></td>

                                    <td><% out.print(allname); %></td>
<!--                                    <td>
                                    <span class="ys change" id="<% out.print(list.get("myid")); %>" mission="<% out.print(list.get("mission")); %>" style="color:blue;font-weight: bold" >更改入驻站点</span>
                                    </td>-->
                                    
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
        <script>
            $(".res").click(function () {
//                history.go(-1);
                window.location.href = "/contactstation/list.jsp";
            });
            var cid = <%req.write("myid");%>
        </script>
        <!--<script src="controller_1.js"></script>-->
        <script>
            
            $(function(){
                ﻿$(".change").click(function(){
                    let id = $(this).attr("id");
                    let mission =  $(this).attr("mission");
                    popuplayer.display("/contactstation/representative/edit.jsp?id=" + id  + "&mission=" + mission + "&TB_iframe=true", '更改入驻站点', {width: 560, height: 240});
                })
            });
            
            transadapter["scorequicksearch"] = function (t)
            {

                popuplayer.display("/activities/evaluation/scorequicksearch.jsp?batchid="+batchid, '查询', {width: 450, height:350});
            }

            transadapter["delete"] = function (t)
            {
                var tid = [], rid = "";
                $("[name='id']").each(function () {
                    if ($(this).is(":checked")) {
                        tid.push($(this).attr("value"));
                    }
                });
                if (tid.length < 1) {
                    window.popuplayer ? popuplayer.showError("请选择") : alert("请选择");
                    return false;
                }
                rid = tid.join(",");
                popuplayer.display("/contactstation/del.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
            }

            ﻿transadapter["append"] = function (t)
            {
                popuplayer.display("/contactstation/append.jsp?cid=<% list.write("cid"); %>", '新增入驻代表', {width: 600, height: 400});
            }
        </script>

    </body>
</html>