<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
         <style>
            body{background: #dce6f5;}
            .dce{text-align: right;padding-right: 10px;}
            .cellbor td{padding: 0 6px}
            .cellbor{border:0;}
            .cellbor>tbody>tr>td{line-height: 34px;border: 0}
            .cellbor{width: 100%}
            .cellbor input{height: 30px;border: #d0d0d0 solid thin;width: 240px;}
            .cellbor select{height: 28px;border: #d0d0d0 solid thin;width: 205px;}
            .popupwrap>div:first-child{height: 58%;padding: 10px 0;background: #fff;border: #6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--<tr><td class="dce">代表证号：</td><td><input name="code"></td></tr>-->
                    <tr><td class="dce">姓名：</td><td ><input  style="width:90%" name="realname"></td></tr>
                    <!--<tr><td class="dce">代表团：</td><td><input name="delegationname"></td></tr>-->
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
//                var str = "/lvzhilist/searchlist.jsp?realname="+formfun("realname")+"&code="+formfun("code")
                var str = "/lvzhilist/searchlist.jsp?realname="+formfun("realname")

                  var urla =encodeURI(str)
                parent.quicksearch(urla)
//                parent.quicksearch("/notice/list.jsp?title="+formfun("title")+"&infotype="+formfun("infotype")+"&state="+formfun("state")+"&realname="+formfun("realname"))
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
