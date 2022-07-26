<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.ValidateCode"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RssList entity = new RssList(pageContext, "user");
    RssList user = new RssList(pageContext, "user");
    RssList staff = new RssList(pageContext, "staff");
    entity.request().remove("smscode", "id");
    if (!entity.get("action").isEmpty()) {
        if (entity.select().where("account=" + entity.get("account")).get_first_rows()) {
            out.print("<script>var a = {'state':'repeat'}</script>");
            out.print("<script>alert('该手机号已经注册过了！');</script>");
        } else {
            entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("pwd")));
            entity.timestamp();
            entity.append().submit();
            user.keyvalue("parentid="+entity.autoid);
            user.update().where("myid=" + entity.autoid).submit();
//            staff.timestamp();
//            staff.keyvalue("powerlist", "8162499446702080").keyvalue("myid", entity.autoid).keyvalue("type", 2);
//            staff.append().submit();
            out.print("<script>var a = {'state':'ok'}</script>");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>注册</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css"/>
        <link href="/css/layout.css" rel="stylesheet" type="text/css"/>
        <script>
        </script>
    </head>
    <body>
        <div id="account"><h1>煤炭通创建商铺<a href="login.jsp">返货登陆</a></h1></div>
        <ul id="content">
            <li id="select">
                <h2 class="selecttype">请选择注册类型</h2>
                <ul id="accounttype">
                    <li><span>交易中心管理员</span><em>该账号只能在交易中心才能发布商品</em><button type="button" tid="1" class="administrator">立即开店</button></li>
                    <li><span>商铺端商铺</span><em>该账号只能在商铺端才能发布商品</em><button type="button" tid="2" class="merchant">立即开店</button></li>
                </ul>  
            </li>
            <li id="operation">
                <h2 class="selecttype">请填写注册信息</h2>
                <form method="post" onSubmit="return verification()" id="regform">
                    <table>
                        <tr>
                            <td class="tr">电话号 </td>
                            <td><input type="text" class="tel" id="regtelphone" name="account" placeholder="请输入手机号"></td>
                        </tr>
                        <tr>
                            <td class="tr">昵称</td>
                            <td><input type="text" class="nc" name="nickname" placeholder="请输入昵称"></td>
                        </tr>
                        <tr>
                            <td class="tr">真实姓名</td>
                            <td><input type="text" class="zs" name="realname" placeholder="请输入真实姓名"></td>
                        </tr>
                        <tr>
                            <td class="tr">密码</td>
                            <td><input type="password" class="pwd" name="pwd" placeholder="密码8-16位数字字母或字符"></td>
                        </tr>
                        <tr>
                            <td class="tr">确认密码</td>
                            <td><input type="password" class="repwd" placeholder="确认密码"></td>
                        </tr>
                        <tr>
                            <td class="tr">图片验证码</td>
                            <td><input type="text" placeholder="验证码" id="regsmsimgcode" maxlength="6" /><img id="valicode" src="vidatecode.jsp" imgtoken/></td>
                        </tr>
                        <tr>
                            <td class="tr">短信验证码</td>
                            <td><input id="telcode" type="text" name="smscode" placeholder="请输入短信验证码"><button type="button" rsssmsreg="5" imgcode="regsmsimgcode" telphone="regtelphone">获取短信验证码</button></td>
                        </tr>
                    </table>
                    <div>
                        <input type="hidden" name="classifyid" class="classifyid">
                        <input type="hidden" name="action" class="action">
                        <button type="submit">提交</button>
                    </div>
                </form>
            </li>
            <li id="fail">
                <div id="rmengban"></div>
                <div id="warning">
                    <span>创建成功！</span>
                    <p><a href="login.jsp">返回登陆</a></p>
                </div>
            </li>
            <li class="success">
                <span></span>
                <a href="login.jsp"></a>
            </li>
        </ul>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>

        <script src="js/register.js" type="text/javascript"></script>
        <script>
//                    var a = document.getElementsByTagNameNS()
        </script>
    </body>
</html>
