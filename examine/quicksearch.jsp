<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <%
                        CookieHelper cookie = new CookieHelper(request, response);
                        if (!(cookie.Get("powergroupid").equals("5"))) {
                    %>
                    <tr><td>有效届次</td><td><select class="w206" name="sessionid" dict-select="sessionclassify"><option></option></select></td></tr>
                    <tr><td>会议次数</td><td><select class="w206" name="meetingnum" dict-select="companytypeeeclassify"><option></option></select></td></tr>
                    <tr><td>建议标题</td><td><input class="w200" name="title"></td></tr>
                            <%
                                }
                            %>
                    <!--                                        <tr><td>立案形式</td><td><select class="w206" name="matter" dict-select="methoded"><option></option></select></td></tr>
                                                            <tr><td>审查分类</td><td><select class="w206" name="reviewclass" dict-select="reviewclass"><option></option></select></td></tr>
                                                            <tr><td>办理方式</td><td><select class="w206" name="methoded" dict-select="methoded"><option></option></select></td></tr>-->
                    <tr><td>代表姓名</td><td><input class="w200" name="realname"></td></tr>
                    <tr style="display:none"><td>审查</td><td><input class="w200" name="examination" value="<% out.print(req.get("examination")); %>"></td></tr>
                    <tr style="display:none"><td>初审状态</td><td><input class="w200" name="iscs" value="<% out.print(req.get("iscs")); %>"></td></tr>
                    <tr style="display:none"><td>乡镇政府办审查状态</td><td><input class="w200" name="isxzsc" value="<% out.print(req.get("isxzsc"));%>"></td></tr>
                    <tr style="display:none"><td>建议议案</td><td><input class="w200" name="lwstate" value="<% out.print(req.get("lwstate"));%>"></td></tr>
                    <tr style="display:none"><td>是否通过代表团审查</td><td><input class="w200" name="isdbtshenhe" value="<% out.print(req.get("isdbtshenhe"));%>"></td></tr>
                </table>
            </div>
            <div class="footer">
                <button type="button" query>查询</button>
                <button type="button" reset>重置</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

            $(".footer>[query]").click(function () {
                var str = "/examine/list.jsp?lwid=" + formfun("lwid") + "&allname=" + formfun("allname") + "&title=" + formfun("title") + "&realcompanyname=" + formfun("realcompanyname") + "&telphone=" + formfun("telphone") + "&sessionid=" + formfun("sessionid") + "&realname=" + formfun("realname") + "&year=" + formfun("year") + "&meetingnum=" + formfun("meetingnum") + "&iscs=" + formfun("iscs") + "&lwstate=" + formfun("lwstate") + "&isxzsc=" + formfun("isxzsc") + "&examination=" + formfun("examination")+ "&isdbtshenhe=" + formfun("isdbtshenhe");
                var urla = encodeURI(str)
                parent.quicksearch(urla)
                popuplayer.close();
            })
            $(".footer>[reset]").click(function () {
                $("[name]").val("");
            })
            $(".footer>[cancel]").click(function () {
                popuplayer.close();
            })
            function formfun(name) {
                var val = $("[name='" + name + "']").val() == undefined ? "" : $("[name='" + name + "']").val()
                return val;
            }
        </script>
    </body>
</html>
