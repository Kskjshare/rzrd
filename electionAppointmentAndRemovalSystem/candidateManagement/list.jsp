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
                            <th>考生姓名</th>
                            <th>手机号</th>
                            <th>身份证</th>
                            <th>密码</th>
                            <th>考生类别</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  
                            RssList list = new RssList(pageContext, "question_examinee");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            String name = URLDecoder.decode(list.get("name"), "utf-8");
                            String tel = URLDecoder.decode(list.get("tel"), "utf-8");
                            String idCard = URLDecoder.decode(list.get("idCard"), "utf-8");
                            String category = URLDecoder.decode(list.get("category"), "utf-8");
//                            String sql2 = " 1 ";
                            String sql =  "name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%'";
                            
//                            if(!name.isEmpty() && !"0".equals(name)){
//                                String sql2 =" ";
//                                sql += "  name like '%" + name +"%'";
////                                sql2 += "  name like '%" + name +"%'";
//                            }
                            if(!tel.isEmpty() && !"0".equals(tel)){
                                  sql += " and tel like '%" + tel+"%'";
//                                sql2 += " and tel like '%" + tel+"%'";
                            }
                            if(!idCard.isEmpty() && !"0".equals(idCard)){
                                 sql += " and idCard like '%"+ idCard+"%'";
//                                sql2 += " and idCard like '%"+ idCard+"%'";
                            }
                            if(!category.isEmpty() && !"0".equals(category)){
                                sql += " and category like '%" + category +"%'";
//                                sql2 += " and category like '%" + category +"%'";
                            }
//                            System.out.println(sql+"cccccccc"+sql2);
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("tel")); %></td>
                            <td><% out.print(list.get("idCard")); %></td>
                            <td><% out.print(list.get("pwd")); %></td>
                            <td category="<% out.print(list.get("category")); %>"></td>
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