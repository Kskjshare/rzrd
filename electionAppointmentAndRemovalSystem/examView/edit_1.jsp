<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
//    RssList listone = new RssList(pageContext, "question_examinee"); 
//    RssList list2 = new RssList(pageContext, "exaninee_and_exam");
//    listone.request();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey"><button class="quicksearch">查询</button>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr id="examtr" shijuanid="<% out.print(req.get("examid")); %>" >
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>姓名</th>
                            <th>身份证号</th>
                            <th>手机号</th>
                            <th>考生类别</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                 
//                            CookieHelper cookie = new CookieHelper(request, response);
                            RssList list = new RssList(pageContext, "question_examinee");
                            list.request();
                            list.pagesize=30;
                            int a = 1;
//                            String sql =  "examid =" + list.get("examid");
                             String sql = " name like '%" + list.get("name") + "%'";
//                            list.select().where(sql).get_page_desc("id");
                            list.select().where(sql).get_page_desc("id");

                            
                            while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>"/></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("idCard")); %></td>
                            <td><% out.print(list.get("tel")); %></td>
                            <td><% out.print(list.get("category")); %></td>
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
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </div>
    </form>
    <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
    <%@include  file="/inc/js.html" %>
    <script src="controller.js"></script>
     
    <script type="text/javascript">
        $('.footer>button').click(function () {
            var e = "";
            var shijuanid = "";
            $("input[name='id']:checked").each(function () {
                e+=$(this).attr("value")+"/./";
            })
                shijuanid=$("#examtr").attr("shijuanid");
            console.log(shijuanid,"oooo++++++++++++++++++");
            if (e.length == 0) {
                alert("请选择");
                return false;
            }
           
            var str = "/electionAppointmentAndRemovalSystem/examView/examnee.jsp?kaoshengid=" + e +"&examid="+shijuanid;
            console.log(str,"000000000000000");
            var urla = encodeURI(str)
            parent.quicksearch(urla)
            popuplayer.close();
//            RssWin.winsendmsg(e);
//            window.close();
        });
    </script>
</body>
</html>