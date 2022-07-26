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
                <table class="wp100 cellbor" style="text-align:center;">
                    <!--                    <tr><td>来文编号</td><td><input class="w200" name="lwid"></td></tr>-->
                    <%
                        CookieHelper cookie = new CookieHelper(request, response);
                        if (!(cookie.Get("powergroupid").equals("5"))) {
                    %>
                    
                    <tr>
                        <td>标题</td>
                        <td  id="liang"><input style="width:98%;border: none;" class="w200" name="title"></td>
                    </tr>
                    <tr>
                        <td>考题类别</td>
                        <td><select style="width:100%;border: none;" class="w260" name="type" dict-select="questionCategory1"></select>
                    </tr>
                    <tr>
                        <td>考题类型</td>
                        <!--<td><select class="w260" name="year" dict-select="questionType" def="<%// entity.write("year"); %>"></select>-->
                        <td><select style="width:100%;border: none;" class="w260" name="questiontype" dict-select="questionType1"></select>
                    </tr>
                            <%
                                }
                            %>

                </table>
            </div>
            <div class="footer">
                <button type="button" query>查询</button>
                <button type="button" reset>重置</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            var date = new Date;
            var year = date.getFullYear();
            var mydate = year.toString();
            $(".footer>[query]").click(function () {
                var str = "/electionAppointmentAndRemovalSystem/questionBankManagement/list.jsp?title=" + formfun("title") + "&type=" + formfun("type") + "&questiontype=" + formfun("questiontype");
                parent.quicksearch(str)//调用父窗口的方法
                popuplayer.close();//窗口关闭
            })
            $(".footer>[reset]").click(function () {
                $("[name]").val("");//重置
            })
            $(".footer>[cancel]").click(function () {
                popuplayer.close();
            })
            //获取input标签的值
            function formfun(name) {
                
                var val = $("[name='" + name + "']").val() == undefined ? "" : $("[name='" + name + "']").val()
//                alert(val);
                return val;
            }
        </script>
    </body>
</html>
