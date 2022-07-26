<%-- 
    Document   : password
    Created on : 2018-7-26, 14:52:14
    Author     : Administrator
--%>

<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    RssList entity = new RssList(pageContext, "user");
    RssList entity2 = new RssList(pageContext, "user");
    entity2.request();
    entity.request();
    if (!entity2.get("account").isEmpty()) {
        String acc = entity2.get("account");
//        String psd = Encrypt.Md532(entity2.get("account") + entity2.get("oldpsw"));
        String psd = entity2.get("oldpsw");
        if (entity2.select().where("account='" + acc + "' and passwordNO='" + psd + "'").get_first_rows()) {
            entity.keyvalue("passwordNO", entity.get("newpsw"));
            entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("newpsw")));
            entity.remove("account").remove("oldpsw").remove("newpsw");
            long time =new Date().getTime()/1000;
            entity.keyvalue("pwdshijian",time+7776000);
            entity.update().where("myid=?", entity2.get("myid")).submit();
            out.print("<script> alert('修改成功！');</script>");
            out.print("<script>location.href = '/login.jsp';</script>");
        } else {
            out.print("<script> alert('登录名或密码输入错误！');</script>");
        }
    }


%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>修改个人密码</title>
        <link href="css/resetold.css" rel="stylesheet" type="text/css" />
        <style>
            form>table{margin: 30px auto;width: 540px;}
            form>table tr>td:first-child{text-align: end;}
            form>table tr>td input{width: 190px;border: #eee solid 2px;height: 32px;}
            form>table tr>td span{color: red;font-size: 12px;display: none;}
            form{}
            form td>button{background: rgb(101, 113, 128);color:#fff; padding: 5px 12px; margin: 0 5px;font-size: 14px;}
            #right{text-align: right;}
            p{margin: 10px auto;width: 540px;}
            p>span{display: inline-block;width: 30px;color: red;}
        </style>
    </head>
    <body>

        <form method="post">  
            <table>
                <tr><td>登录名：</td><td class="w200"><input name="account"></td><td class="w200"></td></tr>
                <tr><td>旧密码：</td><td class="w200"><input name="oldpsw"></td><td class="w200"></td></tr>
                <tr><td>新密码：</td><td class="w200"><input type="password" name="newpsw"></td><td class="w200"><span>密码为8-16个字符且至少包含1个大写字母,小写字母及数字！</span></td></tr>
                <tr><td>再次输入密码：</td><td class="w200"><input type="password" id="againpsw"></td><td class="w200"><span>两次密码格输入不一致</span></td></tr>
                <tr><td></td><td class="w200" id="right"><button type="submit">确认</button><button type="button" id="return">返回</button></td><td></td></tr>
            </table>
            <p><span>注：</span>(1)新账号首次登陆需修改密码</p>
            <!--<p><span></span>(2)账号每隔三个月需修改一次密码</p>-->
            <p><span></span>(2)密码为8-16个字符且至少包含1个大写字母,小写字母及数字</p>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $("[name='newpsw']").blur(function () {
                if (!$("[name='newpsw']").val().match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/)) {
                    $(this).parents("tr").find("span").show();
                } else {
                    $(this).parents("tr").find("span").hide();
                }
            })
            $("#againpsw").blur(function () {
                console.log($("[name='newpsw']").val() == $("#againpsw").val())
                if ($("[name='newpsw']").val() != $("#againpsw").val()) {
                    $(this).parents("tr").find("span").show();
                    return false;
                } else {
                    $(this).parents("tr").find("span").hide();
                }
            })
            $("[type='submit']").click(function () {
                var pd = "1"
                $("input").each(function () {
                    if ($(this).val() == "") {
                        pd = "2";
                    }
                })
                $("td>span").each(function () {
                    if ($(this).css("display") != "none") {
                        alert();
                        pd = "2";
                    }
                })
                if (pd == "2") {
                    return false;
                }
            })
            $("#return").click(function () {
                history.go(-1);
            })
        </script>
    </body>
</html>
