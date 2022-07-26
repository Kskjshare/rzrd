<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
           tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" powerid="108">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="109">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="110">删除</button>
                <button type="button" transadapter="butview" class="butview" powerid="111">查看</button>
                <button type="button" transadapter="apd" select="false" class="butreports" powerid="154">导入</button>
                <button type="button" transadapter="export" class="butreports" powerid="112">导出</button>
                <!--<button type="button" transadapter="butreports" class="butreports">报表</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w30">序号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>单位名称</th>
                            <th>出生年月</th>
                            <th>职务</th>
                            <th style="display: none;">登录账号</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "company_user");
                            list.request();
                            int a = 1 ;
                            list.pagesize=30;
                            if (!list.get("curpage").isEmpty()) {
                              int cpage = 1;
                              int csixe = list.get("pagesize").isEmpty()?10:Integer.valueOf(list.get("pagesize"));
                              cpage=Integer.valueOf(list.get("curpage"))-1;
                              a =cpage*csixe+1;
                                }
                            CookieHelper cookie = new CookieHelper(request, response);
                            String powerid = cookie.Get("powergroupid");
                            String sql = "lianxirenCode like '%"+URLDecoder.decode(list.get("lianxirenCode"), "utf-8")+"%'and realname like '%"+URLDecoder.decode(list.get("realname"), "utf-8")+"%'and account like '%"+URLDecoder.decode(list.get("account"), "utf-8")+"%' and telphone like '%"+URLDecoder.decode(list.get("telphone"), "utf-8")+"%'and sex like '%"+URLDecoder.decode(list.get("sex"), "utf-8")+"%' and state=5";
                            if (!list.get("companyallname").isEmpty()) {
                                   sql += " and companyallname like '%"+URLDecoder.decode(list.get("companyallname"), "utf-8")+"%'" ;
                                }
                            if (!powerid.equals("16")) {
                                   sql += " and parentid="+UserList.MyID(request);
                            }
                            list.select().where(sql).get_page_desc("myid");
                            while (list.for_in_rows()) {
                        %>
                        <tr  ondblclick="ck_rydblclick();" idd="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td sex="<% out.print(list.get("sex")); %>"></td>
                            <td><% out.print(list.get("companyallname"));%></td>
                            <td rssdate="<% out.print(list.get("birthday")); %>,yyyy-MM"></td>
                            <td><% out.print(list.get("job")); %></td>
                            <td style="display: none;"><% out.print(list.get("account")); %></td>
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
//            $("button[transadapter='export']").click(function() {
//                alert("!11")
//    location.href="userlist.jsp";
//})l
        </script>
    </body>
</html>