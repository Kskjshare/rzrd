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
                <table class="wp100 cellbor">
<!--                    <tr><td>来文编号</td><td><input class="w200" name="lwid"></td></tr>
                    <tr><td>建议编号</td><td><input class="w200" name="realid"></td></tr>
                    <tr><td>建议题目</td><td><input class="w200" name="title"</td></tr>
                    <tr><td>立案形式</td><td><select class="w206" name="matter" dict-select="methoded"><option></option></select></td></tr>
                    <tr><td>审查分类</td><td><select class="w206" name="reviewclass" dict-select="reviewclass"><option></option></select></td></tr>
                    <tr><td>办理方式</td><td><select class="w206" name="methoded" dict-select="methoded"><option></option></select></td></tr>
                    <tr><td>领衔代表</td><td><input class="w200" name="realname"></td></tr>-->
<tr>
                        <td style="text-align: center;font-size:16px;font-weight: bold;letter-spacing:2px;">标题</td>
                        <td>
                            <input style="width:98%;line-height:24px;margin-top:-7px;font-size: 15px;" class="w200" name="title">
                        </td>
                    </tr>
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
                parent.quicksearch("/secsuggest/list.jsp?lwid="+formfun("lwid")+"&realid="+formfun("realid")+"&title="+formfun("title")+"&matter="+formfun("matter")+"&reviewclass="+formfun("reviewclass")+"&methoded="+formfun("methoded")+"&realname="+formfun("realname"))
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
