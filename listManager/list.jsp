<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
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
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            /*            .cellbor tbody>.sel>td{background: #dce6f5}
                        .cellbor thead,.w30{background:#f0f0f0 }
                        .cellbor tbody tr>td:first-child{display: none}
                        .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
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
                <button style="display: none;" type="button" transadapter="append" select="false" class="supersearch">高级查询</button>
                <!--<button type="button" transadapter="append" select="false" class="butadd">增加</button>-->
                <%                    CookieHelper cookie = new CookieHelper(request, response);
                    if (!(cookie.Get("powergroupid").equals("5"))) {
                %>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>

                <%
                    }
                %>
                <button type="button" transadapter="subedit" class="butedit">提交</button>
                <button type="button" transadapter="see" class="butview">查看</button>
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
                            <th class="w60 nonum">编号</th>
                            <th class="">建议标题</th>
                            <th class="myid">领衔代表</th>
                            <th>建议人数</th>
                            <th class="reviewclass no">审查分类</th>
                            <th class="handle no">办理情况</th>
                            <th class="w80">建议承办单位</th>
                            <th class="w120">时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "sort");
                            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                            list.request();
                            int b = 1;
                            list.pagesize = 30;
                            list.select().where("draft=1").get_page_desc("realid");

                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbabdlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(b); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="nonum"><% out.print(list.get("realid").isEmpty() ? "无" : list.get("realid")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <td class="reviewclass no" companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <td class="handle no">
                                <%
                                    String handle = "";
                                    if (list.get("examination").equals("1")) {
                                        handle = "未审查";
                                    }
                                    if (list.get("iscs").equals("1")) {
                                        handle = "初审核";
                                    }
                                    if (list.get("examination").equals("2")) {
                                        handle = "待交办";
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        handle = "乡镇政府办已审查";
                                    }
                                    if (list.get("handlestate").equals("3")) {
                                        handle = "待办复";
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        handle = "已办复";
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "已置回";
                                    }
                                    out.print(handle);
                                %></td>
                            <td class="realcompanyname no">
                                <%
                                    RssListView company = new RssListView(pageContext, "company_sug");
                                    String companyname = "";
                                    company.select().where("id=" + list.get("id")).query();
                                    while (company.for_in_rows()) {
                                        companyname += company.get("account") + ",";
                                    }
                                    if (!companyname.equals("")) {
                                        companyname = companyname.substring(0, companyname.length() - 1);
                                    }
                                    out.print(companyname);
                                %>
                            </td>
                            <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
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
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/bill.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            <%
                if (list.get("draft").equals("1")) {
            %>
                            $(".nonum").hide();
            <%
                }
            %>
                            $(".res").click(function () {
                                history.go(-1);
                            });
        </script>
    </body>
</html>
