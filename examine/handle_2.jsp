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
                    <td colspan="5" class="tabheader">议案建议审查处理情况</td>
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
                    String rwhere = "";
                    String view = "";
                    if (cookie.Get("powergroupid").equals("16")) {
                        rwhere = "draft=2";
                        view = "sort";
                    } else {
                        if (cookie.Get("powergroupid").equals("25")) {
                            rwhere = "draft=2 and fsrID=" + UserList.MyID(request);
                            view = "scr_suggest";
                        }else{
                            rwhere = "draft=2 and userid=" + UserList.MyID(request);
                            view = "scr_suggest";
                        }

                    }
                    RssListView list = new RssListView(pageContext, view);
                    list.pagesize = 10000000;
                    list.select().where(rwhere).get_page_desc("id");
                    int a = 0, b = 0, c = 0, d = 0, e = 0, aa = 0, bb = 0, cc = 0, dd = 0, ee = 0;
                    while (list.for_in_rows()) {
                        if (list.get("lwstate").equals("1")) {
                            a++;
                            if (list.get("examination").equals("1")) {
                                d++;
                            }
                            if (list.get("isxzsc").equals("1")) {
                                b++;
                            }
                            if (list.get("examination").equals("3")) {
                                c++;
                            }
                            if (list.get("iscs").equals("1")&&list.get("examination").equals("5")&&list.get("isxzsc").equals("0")) {
                                e++;
                            }
                        }
                        if (list.get("lwstate").equals("2")) {
                            aa++;
                            if (list.get("examination").equals("1")) {
                                dd++;
                            }
                            if (list.get("isxzsc").equals("1")) {
                                bb++;
                            }
                            if (list.get("examination").equals("3")) {
                                cc++;
                            }
                            if (list.get("iscs").equals("1")&&list.get("examination").equals("5")&&list.get("isxzsc").equals("0")) {
                                ee++;
                            }
                        }
                    }
                %>
                <tr>
                    <td rowspan="3">建议</td>
                    <!--<td>未审查</td>-->
<!--                    <td align="left" class="indent">审查组没有审查处理的建议</td>
                    <td class="red3"><% out.print(d);%></td>
                    <td><a href="list.jsp?lwstate=1&examination=1&isdbtshenhe=2">查看</a></td>-->
                </tr>
                <tr>
                    <td>初审确定</td>
                    <td align="left" class="indent">初审组已初步审查处理完毕的建议</td>
                    <td class="red3"><% out.print(e);%></td>
                    <td><a href="list.jsp?lwstate=1&iscs=1&isdbtshenhe=1&examination=5&isxzsc=0">查看</a></td>
                </tr>
                <tr>
                    <td>终审确定</td>
                    <td align="left" class="indent">终审组已最终审查处理完毕的建议</td>
                    <td class="red3"><% out.print(b);%></td>
                    <td><a href="list.jsp?lwstate=1&isxzsc=1&examination=5&isdbtshenhe=1">查看</a></td>
                </tr>
                <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="3">议案</td>
                    <!--<td>未审查</td>-->
<!--                    <td align="left" class="indent">审查组没有审查处理的议案</td>
                    <td class="red3"><% out.print(dd);%></td>
                    <td><a href="list.jsp?lwstate=2&examination=1&isdbtshenhe=1">查看</a></td>-->
                </tr>
                <tr>
                    <td>初审确定</td>
                    <td align="left" class="indent">初审组已初步审查处理完毕的议案</td>
                    <td class="red3"><% out.print(ee);%></td>
                    <td><a href="list.jsp?lwstate=2&iscs=1&isdbtshenhe=1&examination=5&isxzsc=0">查看</a></td>
                </tr>
                <tr>
                    <td>终审确定</td>
                    <td align="left" class="indent">终审组已最终审查处理完毕的议案</td>
                    <td class="red3"><% out.print(bb);%></td>
                    <td><a href="list.jsp?lwstate=2&isxzsc=1&examination=5&isdbtshenhe=1">查看</a></td>
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