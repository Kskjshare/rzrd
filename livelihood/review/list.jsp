<%@page import="RssEasy.Core.CookieHelper"%>
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
            #blockul{height: 100%; overflow: auto;}
            #blockul>li{display: inline-block;width: 290px;height: 400px;background: #dce6f5;border: #eee solid thin;margin: 5px;}
            #blockul>li>img{margin: 5px auto;max-width: 150px;max-height: 170px;display: block;}
            #blockul>li>h1{text-align: center;margin: 0 auto;font-size: 16px;width: 256px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;line-height: 34px;font-weight: 600;}
            #blockul>li>table{;width: 256px;margin: 0 auto;color: #186aa3;font-size: 12px;height: 150px;}
            #blockul>li>table tr>td{min-height: 32px;}
            #blockul>li>table td>div{position: absolute;top: 10px;left: 3px;}
            #blockul>li>table tr>td:first-child{color: #000;position: relative;width: 70px;}
            .disnone{display: none}
            #blockul>.sel{border: #6caddc solid thin;}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" powerid="200">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="202">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="201">删除</button>
                <button type="button" transadapter="butview" class="butview" powerid="203">查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>发布人</th>
                            <th>开始时间</th>
                            <th>发布时间</th>
                            <th>形式</th>
                            <th>分类</th>
                            <th>附件</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "lecture");
                            CookieHelper cookie = new CookieHelper(request, response);
                            list.request();
                            String parentid = cookie.Get("parentid");
                            String myid = cookie.Get("myid");
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and (realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' or allname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%') and (objid=" + myid + " or objid=" + parentid + ")").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbGlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title"));%></td>
                            <td><% out.print(list.get("state").equals("2") || list.get("state").equals("5") ? list.get("realname") : list.get("allname"));%></td>
                            <td rssdate="<% out.print(list.get("joinshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td lectureclassify="<%out.print(list.get("classify"));%>"></td>
                            <td lecturetype="<%out.print(list.get("type"));%>"></td>
                            <td><%out.print(list.get("enclosure"));%></td>
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
                            $("#blockul>li").click(function () {
                                $(this).addClass("sel").siblings().removeClass("sel");
                                $(this).find("input").prop("checked", true);
                            })
        </script>
    </body>
</html>