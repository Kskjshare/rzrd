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
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 200px;}
            .popupwrap>div:first-child{height: 75%;padding: 10px 0;background: #fff;border: #6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
<!--                    <tr><td class="dce">单位编号：</td><td><input class="w200" name="code"></td></tr>
                    <tr><td class="dce">单位类别：</td><td><select class="w206" name="comtype" dict-select="companytypeclassify"><option></option></select></tr>
                    <tr><td class="dce">单位全称：</td><td><input class="w200" name="allname"</td></tr>
                    <tr><td class="dce">负责人：</td><td><input class="w200" name="person"></td></tr>
                    <tr><td class="dce">归口系统：</td><td><select class="w206" name="returnxt" dict-select="returnxt"><option></option></select></td></tr>
                    <tr><td class="dce">单位排序：</td><td><input class="w200" name="companysort"</td></tr>
                    <tr><td class="dce">有效届次：</td><td><select class="w206"  name="sessionid" dict-select="sessionclassify"><option></option></select></td></tr>-->
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
        <script src="/data/session.js"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script>
            $(".footer>[query]").click(function () {
                var str = "/opinion/evaluation/totalEvaluationList.jsp?code="+formfun("code")+"&title=" + formfun("title")+"&comtype="+formfun("comtype")+"&allname="+formfun("allname")+"&person="+formfun("person")+"&returnxt="+formfun("returnxt")+"&companysort="+formfun("companysort")+"&sessionid="+formfun("sessionid")
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
