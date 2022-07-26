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
                    <%
                        CookieHelper cookie = new CookieHelper(request, response);
                        if (!(cookie.Get("powergroupid").equals("5"))) {
                    %>
                    
                    <tr>
                        <td>考生姓名：<em class="red">*</em></td>
                        <td  id="liang"><input style="width:98%;border: none;" class="w200" name="name"></td>
                    </tr>
                    <tr>
                        <td>手机号：</td>
                         <td  id="liang"><input style="width:98%;border: none;" class="w200" name="del"></td>
                    </tr>
                    <tr>
                        <td>身份证：<em class="red">*</em></td>
                         <td  id="liang"><input style="width:98%;border: none;" class="w200" name="idCard"></td>
                    </tr>
                    <tr>
                        <td>考生类别：</td>
                        <td><select style="width:100%;border: none;" class="w260" name="category" dict-select="category"></select>
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
                if ($("[name='name']").val() == undefined || $("[name='name']").val() == "") {
                    alert("请填写考生姓名");
                    $("[name='name']").focus();
                    return false;
                }
                if ($("[name='idCard']").val() == undefined || $("[name='idCard']").val() == "") {
                    alert("请填写考生身份证");
                    $("[name='idCard']").focus();
                    return false;
                }
                var str = "/electionAppointmentAndRemovalSystem/candidateManagement/list.jsp?name=" + formfun("name") + "&del=" + formfun("del") + "&idCard=" + formfun("idCard")+ "&category=" + formfun("category");
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
