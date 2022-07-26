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
                    <tr><td>单位编号：</td><td><input class="w200" name="code"></td></tr>
                    <tr><td>单位类别：</td><td><select class="w206" name="comtype" dict-select="companytypeclassify"><option></option></select></tr>
                    <tr><td>单位全称：</td><td><input class="w200" name="allname"</td></tr>
                    <tr><td>负责人：</td><td><input class="w200" name="person"></td></tr>
                    <tr><td>归口系统：</td><td><select class="w206" name="returnxt" dict-select="returnxt"><option></option></select></td></tr>
                    <tr><td>单位排序：</td><td><input class="w200" name="companysort"</td></tr>
                    <tr><td>有效届次：</td><td><select class="w206" name="sessionid" dict-select="sessionclassify"><option></option></select></td></tr>
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
        <script src="/data/session.js"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script>
            $(".footer>[query]").click(function () {
                parent.quicksearch("/query/company/list.jsp?code="+formfun("code")+"&comtype="+formfun("comtype")+"&allname="+formfun("allname")+"&person="+formfun("person")+"&returnxt="+formfun("returnxt")+"&companysort="+formfun("companysort")+"&sessionid="+formfun("sessionid"))
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
