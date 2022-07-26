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
    RssList entity = new RssList(pageContext, "logistics");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id", "shijian");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
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
                        <td class="tr">发布人ID</td>
                        <td><input type="text" class="issuer" maxlength="10" name="myid" value="<% entity.write("myid"); %>"><label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label></td>
                    </tr>
                    <tr>
                        <td class="tr">起点</td>
                        <td><input type="text" name="zero" value="<% entity.write("zero"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">终点</td>
                        <td><input type="text" name="end" value="<% entity.write("end"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">煤炭吨数</td>
                        <td><input class="numberinput" type="text" name="coalnumber" value="<% entity.write("coalnumber"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">煤炭价格</td>
                        <td><input class="numberinput" type="text" name="coalprice" value="<% entity.write("coalprice"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">装车费</td>
                        <td><input class="numberinput" type="text" name="shipmentprice" value="<% entity.write("shipmentprice"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">卸车费</td>
                        <td><input class="numberinput" type="text" name="unloadingprice" value="<% entity.write("unloadingprice"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">运费</td>
                        <td><input class="numberinput" type="text" name="shippingcost" value="<% entity.write("shippingcost"); %>"></td>
                    </tr>
                    <tr>
                        <td class="tr">车辆数</td>
                        <td><input class="numberinput" type="text" name="carnumber" value="<% entity.write("carnumber"); %>"></td>
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
                if (isNaN($(".issuer").val())) {
                    alert("发布人id必须是数字");
                    return false;
                }
            });
            $(".numberinput").bind("input propertychange", function () {
                if (isNaN($(this).val())) {
                    $(this).val($(this).val().substring(0, $(this).val().length - 1));
                }
            })
            $(".popupwrap").submit(function () {
                var i = 0;
                $("popupwrap td input").each(function () {
                    if ($(this).val() == "") {
                        i++
                    }
                })
                if(i!=0){
                    alert("请完善物流信息！");
                    return false;
                }
                if(isNaN($(".numberinput").val())){
                    alert("除了起点和终点意外其他的！");
                    return false;
                }
            })
        </script>
    </body>
</html>
