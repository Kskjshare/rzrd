<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "question_examinee");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("name",entity.get("name"));
                entity.keyvalue("tel",entity.get("tel"));
                entity.keyvalue("idCard",entity.get("idCard"));
                entity.keyvalue("pwd",entity.get("pwd"));
                entity.keyvalue("category",entity.get("category"));
                entity.append().submit();
                break;
            case "update":
                entity.keyvalue("name",entity.get("name"));
                entity.keyvalue("tel",entity.get("tel"));
                entity.keyvalue("idCard",entity.get("idCard"));
                entity.keyvalue("pwd",entity.get("pwd"));
                entity.keyvalue("category",entity.get("category"));
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();//刷新查询页
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", req.get("id")).get_first_rows();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}#headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }


        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>

        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    
                    <tr>
                        <td class="dce w100 ">考生类别：<em class="red">*</em></td>
                         <td><select style="width:100%;border: none;" class="w260" name="category" dict-select="category"  def="<% entity.write("category"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考生姓名：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">手机号：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="tel" value="<% entity.write("tel"); %>" /></td>
                    </tr>
                    <tr >
                        <td class="dce w100 ">身份证：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="idCard" value="<% entity.write("idCard"); %>" /></td>
                    </tr>
                    <tr >
                        <td class="dce w100 ">密码：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="pwd" value="<% entity.write("pwd"); %>" /></td>
                    </tr>

                </table>

            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                            $(".footer>button").click(function () {
                                if ($("[name='category']").val() == undefined || $("[name='category']").val() == "") {
                                    alert("请选择类别");
                                    $("[name='category']").focus();
                                    return false;
                                }
                                if ($("[name='name']").val() == undefined || $("[name='name']").val() == "") {
                                    alert("请填写考生姓名");
                                    $("[name='name']").focus();
                                    return false;
                                }
                                if ($("[name='tel']").val() == undefined || $("[name='tel']").val() == "") {
                                    alert("请填写电话号码");
                                    $("[name='tel']").focus();
                                    return false;
                                }
                                if ($("[name='idCard']").val() == undefined || $("[name='idCard']").val() == "") {
                                    alert("请填写证件号");
                                    $("[name='idCard']").focus();
                                    return false;
                                }
                                if ($("[name='pwd']").val() == undefined || $("[name='pwd']").val() == "") {
                                    alert("请填写密码");
                                    $("[name='pwd']").focus();
                                    return false;
                                }
                            })


        </script>
    </body>
</html>
