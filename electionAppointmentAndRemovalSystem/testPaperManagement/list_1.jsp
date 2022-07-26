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
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>题目</th>
                            <th>答案</th>
                            <th>考题类别</th>
                            <th>考题类型</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "question_bank");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            String title = URLDecoder.decode(list.get("title"), "utf-8");
                            String type = list.get("type");
                            String questiontype =list.get("questiontype");
//                            String  where = "";
//                             String sql = "";
                            String sql = "title like '%" + title + "%'";
                            if(!type.isEmpty() && !questiontype.isEmpty() ){
//                               
                                sql += " and type =" +type +" and questiontype = " + questiontype;
                            }
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% 
                                String[] answers = list.get("answer").split(".-f/,");
                                String answer = "";
                                for(String s : answers){
                                    answer += s.charAt(0)+" ";
                                }
                                    out.print(answer);
                                %></td>
                            <!--<td><% out.print(list.get("myid")); %></td>-->
<!--                            <td>
                                <%
//                                    RssList user = new RssList(pageContext, "user");
//                                    user.select().where("myid=?", list.get("myid")).get_first_rows();
//                                    out.print(user.get("realname").isEmpty() ? "无" : user.get("realname"));
                                %>
                            </td>-->
                            <!--<td><% out.print(list.get("shijian")); %></td>-->
                            <!--<td rssdate="<% // out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td> 显示格式化后的时间 -->
                            <td questionCategory1="<% out.print(list.get("type")); %>"></td>
                            <td><% out.print("1".equals( list.get("questiontype")) ? "<em style='color : #32CD32;'>单选</em>" : ("2".equals( list.get("questiontype")) ? "<em style='color : #1E90FF;'>多选</em>" : "<em style='color : #EEB422;'>判断</em>") ); %></td>
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

        </script>

    </body>
</html>