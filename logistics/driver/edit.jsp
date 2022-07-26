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
    RssList entity = new RssList(pageContext, "driver");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("myid",UserList.MyID(request));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("shijian");
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr class="thismyid">
                        <td class="tr">创建人id</td>
                        <td><input type="text" name="myid" value="<% entity.write("myid"); %>"><label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label></td>
                    </tr>
                    <tr>
                        <td class="tr">司机姓名</td>
                        <td><input type="text" name="drivername" value="<% entity.write("drivername"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">司机电话</td>
                        <td><input type="text" name="tel" value="<% entity.write("tel"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">支付宝账号</td>
                        <td><input type="text" name="alipay" value="<% entity.write("alipay"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">货车类型</td>
                        <td><select  name="freightcartype" dict-select="cartype" def="<% entity.write("freightcartype"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr">车牌号</td>
                        <td><input class="carnumber" type="text" name="carnumber" value="<% entity.write("carnumber"); %>"></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/goods.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/js/upload.js" type="text/javascript"></script>
        <script src="ico.js" type="text/javascript"></script>
        <script>
            $(".popupwrap").submit(function () {
                var i = 0;
                $(".popupwrap td input").each(function () {
                    if ($(this).val() == "") {
                        i++;
                    }
                })
                if (i != 0) {
                    alert("请完善司机信息！");
                    return false;
                }
                if (!$(".carnumber").val().match(/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/)) {
                    alert("请填写正确的车牌号！")
                    return false
                }
            })
        </script>
    </body>
</html>
