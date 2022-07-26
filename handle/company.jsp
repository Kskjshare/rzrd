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
            table{width: 800px}
            #section thead tr{background:url(../css/limg/td1px.png);background-size: 100%}
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            td>div{width: 100px;height: 18px;padding: 0;border: #e8eef8 solid thin;border-radius: 8px;overflow: hidden;margin: 0 auto;line-height: 18px;background: #a78f0c;position: relative;}
            td>div>p{width: 100%;height: 100%;background: #fff;display: inline-block;}
            td>div>span{position: absolute;top: 0;color: #a4c2d9;padding: 0;left: 0; display: inline-block; width: 100px; text-align: center;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div>
                <table style="font-size:16px;font-family: 微软雅黑" class="tc cellbor" id="section">
                    <thead>
                        <tr>
                            <!--<th class="" rowspan="2"></th>-->
                            <th class="" rowspan="2">单位编号</th>
                            <th class="" rowspan="2">单位名称</th>
                            <th class="" rowspan="2">整体进度</th>
                            <th class="" colspan="2">承办总数</th>
                            <th class="" colspan="2">建议</th>
                            <th class="" colspan="2">议案</th>
                        </tr>
                        <tr>
                            <th class="">承办数</th>
                            <th class="">未办复</th>
                            <th class="">承办数</th>
                            <th class="">未办复</th>
                            <th class="">承办数</th>
                            <th class="">未办复</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            RssListView company = new RssListView(pageContext, "suggest_company");
                            list.request();
                            int z = 1;
                            list.select().where("state=3").query();
                            while (list.for_in_rows()) {
                                int a = 0, b = 0, aa = 0, bb = 0, aaa = 0, bbb = 0,c=0;
                                company.pagesize = 30;//10000000;
                                company.select().where("companyid=" + list.get("myid")).get_page_desc("suggestid");
                                while (company.for_in_rows()) {
                                    a++;
                                    if (company.get("resume").equals("0")) {
                                        b++;
                                    }
                                    if (company.get("lwstate").equals("1")) {
                                        aa++;
                                        if (company.get("resume").equals("0")) {
                                            bb++;
                                        }
                                    }
                                    if (company.get("lwstate").equals("2")) {
                                        aaa++;
                                        if (company.get("resume").equals("0")) {
                                            bbb++;
                                        }
                                    }
                                }
                                if(a > 0){
                                c=b * 100 / a;
                                }
                        %>
                        <tr>
                            <!--<td class="w30"><% // out.print(z); %></td>-->
                            <td><% out.print(list.get("danweiCode")); %></td>
                            <td class="tl"><% out.print(list.get("company")); %></td>
                            <td process="<% out.print(c);%>"><div><p></p><span></span></div></td>
                            <td><% out.print(a); %></td>
                            <td><% out.print(b); %></td>
                            <td><% out.print(aa); %></td>
                            <td><% out.print(bb); %></td>
                            <td><% out.print(aaa); %></td>
                            <td><% out.print(bbb); %></td>
                        </tr>
                        <%
                                z++;
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
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".cellbor [process]").each(function () {
                $(this).find("span").text($(this).attr("process")+"%")
                $(this).find("p").css("margin-left", $(this).attr("process")+"%")
            })
        </script>
    </body>
</html>
