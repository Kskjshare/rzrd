<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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
            .cellbor{width: 800px;}
            .red3{color:#c03e20}
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 20px;text-align: center;}
            .dce{background: #dce6f5;}
            .cellbor>tbody>tr>.indent{text-indent: 10px;text-align: left}
            #divide{height: 10px;}
            .cellbor i{ color: #a79012;font-style: normal}
            .cellbor tr i:nth-child(2){margin-left: 5px;}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop">
                <tr>
                    <td colspan="5" class="tabheader">网上联络站留言处理情况</td>
                </tr>
                <tr class="dce">
                    <td>分类</td>
                    <td>项目</td>
                    <td>说明</td>
                    <td>件数</td>
                    <td>操作</td>
                </tr>
                <%
                    CookieHelper cookie = new CookieHelper(request, response);
                    RssList list = new RssList(pageContext, "leaveword");
                    list.pagesize = 10000000;
                    
                    if ( cookie.Get("powergroupid").equals("5") ) {
                         list.select().where("adminstate=0 and objid=" + UserList.MyID(request) ).get_page_desc("id");
                    }else {
                        list.select().where("adminstate=0").get_page_desc("id");

                    }
                    int a = 0, b = 0, c = 0, d = 0, e = 0, aa = 0, bb = 0, cc = 0, dd = 0, ee = 0;
                    while (list.for_in_rows()) {
                        if (list.get("state").equals("0")) {
                            a++;
                            if (list.get("objstate").equals("0")&&list.get("returnuser").equals("0")) {
                                d++;
                            }
                        }
                        if (list.get("state").equals("1")) {
                            aa++;
                            if (list.get("objstate").equals("1") && list.get("handover").equals("0")) {
                                dd++;
                            }
                        }
                    }
                %>
                <tr>
                    <td rowspan="3">处理情况</td>
                </tr>
                <tr>
                    <td>网上公众留言</td>
                    <td align="left" class="indent">代表和公众之间的交流咨询</td>
                    <td class="red3"><% out.print(d);%></td>
                    <td style="font-weight:bold;"><a href="list.jsp">查看</a></td>
                </tr>
                <tr>
                    <td>代表处理留言</td>
                    <td align="left" class="indent">代表和公众之间的交流咨询处理</td>
                    <td class="red3"><% out.print(dd);%></td>
                    <td style="font-weight:bold;"><a href="list_1.jsp">查看</a></td>
                </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
//            $('#yian').click(function () {
//                parent.quicksearch("/bill/list.jsp?type=2")
//            })
        </script>
    </body>
</html>