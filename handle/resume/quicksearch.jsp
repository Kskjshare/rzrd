<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
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
                    <tr><td>有效届次</td><td><select class="w206" name="sessionid" dict-select="sessionclassify"><option></option></select></td></tr>
                    <tr><td>会议次数</td><td><select class="w206" name="meetingnum" dict-select="companytypeeeclassify"><option></option></select></td></tr>
                    <tr><td>联系方式</td><td><input class="w200" name="telphone"></td></tr>
                    <tr><td>代表团</td><td><input class="w200" name="allname"></td></tr>
                    <tr><td>主办单位</td><td><input class="w200" name="realcompanyname"></td></tr>
                    <tr><td>建议标题</td><td><input class="w200" name="title"></td></tr>
                    <tr><td>年份</td><td><input class="w200" name="year" ></td></tr>
                    <!--                                        <tr><td>立案形式</td><td><select class="w206" name="matter" dict-select="methoded"><option></option></select></td></tr>
                                                            <tr><td>审查分类</td><td><select class="w206" name="reviewclass" dict-select="reviewclass"><option></option></select></td></tr>
                                                            <tr><td>办理方式</td><td><select class="w206" name="methoded" dict-select="methoded"><option></option></select></td></tr>-->
                    <tr><td>代表姓名</td><td><input class="w200" name="realname"></td></tr>
                </table>
            </div>
            <div class="footer">
                <button type="button" query>查询</button>
                <button type="button" reset>重置</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            
            $(".footer>[query]").click(function () {
               var str = "/handle/resume/resumesee.jsp?resume=<% out.print(req.get("resume"));%>&deal=<% out.print(req.get("deal"));%>&realid="+formfun("realid")+"&lwstate=<% out.print(req.get("lwstate"));%>&title="+formfun("title")+"&registertype="+formfun("registertype")+"&handle="+formfun("handle")+ "&allname=" + formfun("allname") + "&realcompanyname=" + formfun("realcompanyname") + "&telphone=" + formfun("telphone") + "&sessionid=" + formfun("sessionid") + "&realname=" + formfun("realname") + "&year=" + formfun("year"+ "&meetingnum=" + formfun("meetingnum"));
                  var urla =encodeURI(str)
                parent.quicksearch(urla)
                popuplayer.close();
            })
            $(".footer>[reset]").click(function () {
                $("[name]").val("");
            })
            $(".footer>[cancel]").click(function () {
                popuplayer.close();
            })
            function formfun(name){
                var val = $("[name='"+name+"']").val() == undefined ? "" : $("[name='"+name+"']").val()
                return val;
            }
        </script>
    </body>
</html>
