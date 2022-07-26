<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
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
        <title>汝州市人大代表履职服务平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            /*.cellbor tbody>.sel>td{background: #dce6f5}*/
            /*.cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            .noscore{color: #6caddc;cursor: pointer;}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey"> 
                <button type="submit" select="false" class="quicksearch" powerid="182">查询</button>
                <button type="button" transadapter="append" class="butadd" powerid="181">打分</button>
                <button type="button"  transadapter="list" select="false" >履职列表</button>
                <!--                <button type="button" transadapter="append" select="false" class="butadd" powerid="">增加</button>
                                <button type="button" transadapter="edit" class="butedit"powerid="">编辑</button>
                                <button type="button" transadapter="delete" class="butdelect" powerid="">删除</button>
                                <button type="button" transadapter="apd" select="false" class="butreports" powerid="">导入</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <!--
                            <th class="w30"><input name="all"  type="checkbox"></th>
                                                      <th class="w30">序号</th>
                                                        <th>姓名</th>
                            <th class="w30" rowspan="2"></th>
                            -->
                            <th rowspan="2">序号</th>
                            <th rowspan="2">代表姓名</th>
                            <th colspan="3">测评情况</th>
                            <th rowspan="2">备注</th>
                            <th rowspan="2">年份</th>
                            <!--<th>代表证号</th>-->
                            <!--<th>职务</th>-->
                            <th rowspan="2">代表团</th>
                            <!--                            <th>手机号码</th>
                                                        <th>分数</th>-->
                             <th rowspan="2">操作</th>
                        </tr>
                        <tr>
                            <th>满意(80-100)分</th>
                            <th>基本满意(60-79分)</th>
                            <th>不满意(59分以下)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            CookieHelper cookie = new CookieHelper(request, response);
//                            RssList entity=new RssList(pageContext, "user");
//                            entity.select().where("myid=",cookie.Get("myid")).get_first_rows();
                            RssListView list = new RssListView(pageContext, "delegation_score");
                            list.request();
                            String powerid = cookie.Get("powergroupid");
                            int a = 1;
                            list.pagesize = 30;
                            if (!list.get("curpage").isEmpty()) {
                                int cpage = 1;
                                int csixe = list.get("pagesize").isEmpty() ? 10 : Integer.valueOf(list.get("pagesize"));
                                cpage = Integer.valueOf(list.get("curpage")) - 1;
                                a = cpage * csixe + 1;
                            }
                            String sql = "(code like '%" + URLDecoder.decode(list.get("searchkey"), "utf-8") + "%' or realname like '%" + URLDecoder.decode(list.get("searchkey"), "utf-8") + "%' or year like '%" + URLDecoder.decode(list.get("searchkey"), "utf-8") + "%') and state=2";
//                             mission like '"+entity.get("mission")+"'
                            if (powerid.equals("16") || powerid.equals("8")) {
                                sql = "(code like '%" + URLDecoder.decode(list.get("searchkey"), "utf-8") + "%' or realname like '%" + URLDecoder.decode(list.get("searchkey"), "utf-8") + "%' or year like '%" + URLDecoder.decode(list.get("searchkey"), "utf-8") + "%') and state=2";
                            }

                            list.select().where(sql).get_page_desc("myid");
//                            out.print(list.sql);
                            while (list.for_in_rows()) {

                        %>
                        <tr>
                            <!--
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            -->
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <!--<td><% out.print(list.get("code")); %></td>-->
<!--                            <td class="tdleft"><% out.print(list.get("job")); %></td>-->
                            <%
                                String cc = "", dd = "", gg = "";
                                if (!list.get("delegate_score").isEmpty()) {
                                    String aa = list.get("delegate_score");
                                    int bb = Integer.valueOf(aa);
                                    if (bb >= 80) {
                                        cc = "" + bb + "";
                                    } else if (80 > bb && bb >= 60) {
                                        dd = "" + bb + "";
                                    } else {
                                        gg = "" + bb + "";
                                    }
                                }
                            %>
                            <td><% out.print(cc); %></td>
                            <td><% out.print(dd); %></td>
                            <td><% out.print(gg); %></td>

                            <td><%out.print(list.get("note"));%></td>
                            <td><%out.print(list.get("year"));%></td>
                            <td><%out.print(list.get("dbtname"));%></td>
                            
                             <td>
		            <span class="ys score" id="<% out.print(list.get("id")); %>" style="color:blue;cursor:pointer;">打分</span> |                           
                            <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;cursor:pointer;">查看内容</span>
                     <!--zyx 增加css样式鼠标放上变小手-->       
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

//            ﻿transadapter["append"] = function (t)
//            {
//                if ($("[name='id']:checked").length !== "1") {
//                    if ($("[name='id']:checked").length === "0") {
//                        alert("请选择一条操作");
//                    } else {
//                        alert("每次只能选择一条");
//                    }
//                    return false;
//                }
//                var opinionid = $("[name='id']:checked").val();
//                popuplayer.display("/evaluation/delegation/append_1.jsp?id=" + opinionid + "&TB_iframe=true", '打分', {width: 450, height:150});
//            }
            transadapter["list"] = function (t)
            {
                location.href = "/lvzhilist/list.jsp";
            }
            
            
              $(function(){
                ﻿$(".score").click(function(){
                    let id = $(this).attr("id");
                   popuplayer.display("/evaluation/delegation/append_1.jsp?id=" + id + "&TB_iframe=true", '评分', {width: 630, height: 200});
                })
            });
            
              $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                   popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 500});
                })
            });
           
        </script>
    </body>
</html>