<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <table class="wp100 formor">
                    <tr><td>编号：</td><td><input class="w200" name="code"></td></tr>
                    <tr><td>姓名：</td><td><input class="w200" name="realname"></td></tr>
                    <tr><td>性别：</td><td><select class="w206" name="sex" dict-select="sex"><option></option></select></tr>
                    <tr><td>民族：</td><td><input class="w200" name="nationid"></tr>
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
                parent.quicksearch("/query/delegate/list.jsp?code="+formfun("code")+"&realname="+formfun("realname")+"&sex="+formfun("sex")+"&nationid="+formfun("nationid"))
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
