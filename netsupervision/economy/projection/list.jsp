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
            /*            #blockul{height: 100%; overflow: auto;}
                        #blockul>li{display: inline-block;width: 290px;height: 400px;background: #dce6f5;border: #eee solid thin;margin: 5px;vertical-align: top;}
                        #blockul>.sel{border: #6caddc solid thin;}
                        #blockul>li>img{margin: 5px auto;max-width: 150px;max-height: 170px;display: block;}
                        #blockul>li>h1{text-align: center;margin: 0 auto;font-size: 16px;width: 256px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;line-height: 34px;font-weight: 600;}
                        #blockul>li>p{font-size: 14px;width: 256px;margin: 0 auto;color: #186aa3;}
                        #blockul>li>p{position: relative; line-height: 20px; max-height: 170px;overflow: hidden;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 8;}
                        .disnone{display: none}*/
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <!--        <div class="toolbar">
                    <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                    <button type="button" transadapter="edit" class="butedit">编辑</button>
                    <button type="button" transadapter="delete" class="butdelect">删除</button>
                    <button type="button" transadapter="butview" class="butview">查看</button>
                    <input type="hidden" id="transadapter" find="[name='id']:checked" />
                </div>-->
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" >增加</button>
                <!--<button type="button" transadapter="edit" class="butedit" powerid="202">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect" >删除</button>
                <button type="button" transadapter="butview" class="butview" >查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>重点项目名称</th>
                            <th>项目进度</th>    
                            <th>设计单位</th>
                            <th>建设单位</th>
                            <th>施工单位</th>
                            <th>勘察单位</th>
                            <th>监理单位</th>
                            <th>审批日期</th>                    
                            <th>施工日期</th>
                            <th>竣工日期</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "neteconomy_project");
                            CookieHelper cookie = new CookieHelper(request, response);
                            list.request();
//                            String parentid = cookie.Get("parentid");
//                            String myid = cookie.Get("myid");
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbFlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("name"));%></td>
                            <td><% out.print(list.get("state"));%></td>
                            <td><% out.print(list.get("designunit"));%></td>
                            <td><% out.print(list.get("constructionunit"));%></td>
                            <td><% out.print(list.get("implementunit"));%></td>
                            <td><% out.print(list.get("state"));%></td>
                            <td><% out.print(list.get("exploreunit"));%></td>
                            <td><% out.print(list.get("superviseunit"));%></td>
                            <td rssdate="<% out.print(list.get("auditshijian")); %>,yyyy-MM-dd" ></td>   
                            <td rssdate="<% out.print(list.get("implementshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("completedshijian")); %>,yyyy-MM-dd" ></td>
                            <!--<td><%out.print(list.get("enclosure"));%></td>-->
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