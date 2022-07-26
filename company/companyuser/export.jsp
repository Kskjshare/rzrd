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
        <style>
            body{background: #dce6f5;}
            .popupwrap>div{margin: 0 auto;padding-top: 10px;}
            .popupwrap label{display: block;line-height: 34px;padding-left: 30px}
            .popupwrap label input{margin: 0 5px;}
            .popupwrap span{display: block;line-height: 34px;padding-left: 30px;border-bottom: #eee solid 2px;cursor: default}
            .popupwrap span input{margin: 0 5px;}
            .popupwrap>div:first-child{height: 89%;;background: #fff;border: #6caddc solid thin;}
        </style>
    </head>
    <body>

        <form method="post" class="popupwrap">  
            <div>
                <span><input type="checkbox" name="all">全选</span>
                <label><input type="checkbox" name="lianxirenCode">编号</label>
                <label><input type="checkbox" name="realname">名称</label>
                <label><input type="checkbox" name="sex">性别</label>
                <label><input type="checkbox" name="nationid">民族</label>
                <label><input type="checkbox" name="eduid">学历</label>
                <label><input type="checkbox" name="degree">学位</label>
                <label><input type="checkbox" name="profession">职业</label>
                <label><input type="checkbox" name="worktitle">职称</label>
                <label><input type="checkbox" name="company">单位</label>
                <label><input type="checkbox" name="email">电子邮箱</label>
                <label><input type="checkbox" name="birthday">出生年月</label>
                <label><input type="checkbox" name="passwordNO">登录密码</label>
                <label><input type="checkbox" name="telphone">手机号码</label>
                <label><input type="checkbox" name="account">登录账号</label>
                <label><input type="checkbox" name="job">职务</label>
                <label><input type="checkbox" name="homeaddress">家庭地址</label>
                <label><input type="checkbox" name="hometel">家庭电话</label>
                <label><input type="checkbox" name="email">家庭邮编</label>
            </div>
            <div class="footer" id="footbut">
                <button type="button" query>导出</button>
                <button type="button" cancel>取消</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            var sea = "", seath = "";
            $("span>input").change(function () {
                if ($(this).is(":checked")) {
                    $("label>input").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $("label>input").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })
            $(".footer>[query]").off("click").click(function () {
                $("label>input").each(function () {
                    if ($(this).is(":checked")) {
                        sea += "," + $(this).attr("name");
                        seath += "," + $(this).parent().text();
                    }
                })
                if (sea == "") {
                    alert("请选择要导出的字段");
                    return false;
                }
//               var arry = sea.split(",");
                var str = "/company/companyuser/userlist.jsp?relation=" + sea + "&relationname=" + seath + "&relationid=<% out.print(req.get("relationid"));%>"
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
