<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />

<!--        <style>
/*            .liang input:focus{
                border: 1px red solid;
            }*/
            #liang:focus{
                background-color: red;
            }
        </style>-->
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <span>无操作权限</span>
            </div>
            <div class="footer">
                <button type="button" query>确定</button>
                <!--<button type="button" reset>重置</button>-->
                <!--<button type="button" cancel>取消</button>-->
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>

        <script>
                    $(".footer>[query]").click(function () {
//                        var str = "gateway.jsp"
//                        parent.quicksearch(str)//调用父窗口的方法
//                        window.location.href = "gateway.jsp";
                        popuplayer.close();//窗口关闭
                    })
        </script>
    </body>
</html>
