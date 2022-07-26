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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd" powerid="126">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="127">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="128">删除</button>
                <button type="button" transadapter="butview" class="butview" powerid="129">查看</button>
                <!--<button type="button" transadapter="join" class="butview">添加工作人员</button>-->
                <button type="button" transadapter="apd" select="false" class="butreports" powerid="130">导入</button>
                <button type="button" transadapter="export" class="butreports" powerid="107">导出</button>
                <!--<button type="button" transadapter="butreports" class="butreports">报表</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input  name="all" type="checkbox"></th>
                            <th class="w30">序号</th>
                            <th>单位名称</th>
                            <th>单位类别</th>
                            <th>单位地址</th>
                            <th>单位邮编</th>
                            <th>联系人</th>
                            <th>联系电话</th>
                            <th>单位编号</th>
                            <th style="display: none;">登录名</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            list.request();
                            int a = 1 ;
                            list.pagesize=30;
                            if (!list.get("curpage").isEmpty()) {
                              int cpage = 1;
                              int csixe = list.get("pagesize").isEmpty()?10:Integer.valueOf(list.get("pagesize"));
                              cpage=Integer.valueOf(list.get("curpage"))-1;
                              a =cpage*csixe+1;
                                }
                            
                            list.select().where("account like '%"+URLDecoder.decode(list.get("account"), "utf-8")+"%' and danweiCode like '%"+URLDecoder.decode(list.get("danweiCode"), "utf-8")+"%' and comtype like '%"+URLDecoder.decode(list.get("comtype"), "utf-8")+"%' and company like '%"+URLDecoder.decode(list.get("company"), "utf-8")+"%' and person like '%"+URLDecoder.decode(list.get("person"), "utf-8")+"%' and linkman like '%"+URLDecoder.decode(list.get("linkman"), "utf-8")+"%' and companysort like '%"+URLDecoder.decode(list.get("companysort"), "utf-8")+"%' and sessionid like '%"+URLDecoder.decode(list.get("sessionid"), "utf-8")+"%'and loginNameDw like '%"+URLDecoder.decode(list.get("loginNameDw"), "utf-8")+"%' and worktel like '%"+URLDecoder.decode(list.get("worktel"), "utf-8")+"%' and state=6").get_page_desc("myid");
//                            list.select().where("id like '%"+list.get("id")+"%'").get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dblclick();" idd="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("company")); %></td>
                            <td companytypeclassify="<% out.print(list.get("comtype")); %>"></td>
                            <td><% out.print(list.get("workaddress")); %></td>
                            <td><% out.print(list.get("postcode")); %></td>
                            <td><% out.print(list.get("linkman")); %></td>
                            <td><% out.print(list.get("worktel")); %></td>
                            <td><% out.print(list.get("danweiCode")); %></td>
                            <td style="display: none;"><% out.print(list.get("loginNameDw")); %></td>
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
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="controller.js"></script>
        <script src="../data/companytype.js" type="text/javascript"></script>
        <script>


                            // your click process code here


        </script>
    </body>
</html>