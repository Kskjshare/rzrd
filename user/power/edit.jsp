<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "son_account_power");
    RssList sonaccount = new RssList(pageContext, "son_account_power");
    entity.request().remove("id", "parentid");
    if (!entity.get("action").isEmpty()) {
        if (entity.get("offsetid").isEmpty()) {
            throw new Exception("权限标识不能为空！");
        }
        switch (entity.get("action")) {
            case "append":
//                entity.keyvalue("marker", entity.getmarkerbyid(entity.get("parentid")) + HttpExtend.getPinYin(entity.get("name")));
                entity.keyvalue("userid", UserList.MyID(request));
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        StaffList.CreateJson(pageContext);
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    out.print("<script>var inputval='" + entity.get("Jurisdictionid") + "';</script>");
    sonaccount.pagesize = 1;
    sonaccount.select("offsetid").get_page_desc("id");
    while (sonaccount.for_in_rows()) {
        out.print("<script>var maxoffsetid=" + sonaccount.get("offsetid") + "</script>");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" class="popupwrap">
            <table class="wp100 vtop">
                <tbody>
                    <tr>
                        <td>
                            <table class="wp100 cellbor">
                                <tr>
                                    <td class="tr w80">名称：</td>
                                    <td>
                                        <input type="text" id="name" name="name" class="w100" value="<% entity.write("name"); %>" maxlength="50" /><label for="name"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tr">权限标识：</td>
                                    <td>
                                        <input type="text" id="offsetid" allowinput="number" name="offsetid" class="w60" value="<% entity.write("offsetid"); %>" maxlength="50" /><label for="offsetid"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tr">权限：</td>
                                    <td id="sonpower">
                                        <!--<input type="text" id="offsetid" allowinput="number" name="offsetid" class="w60" value="" maxlength="50" /><label for="offsetid"></label>-->
                                        <label><input type="checkbox" name="Jurisdictionid" value="0">商品管理</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="1">订单管理</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="2">竞拍</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="3">交易明细</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="4">物流管理</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="5">发布公告</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="a">发布物流</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="b">绑定银行卡</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="c">店铺介绍</label>
                                        <label><input type="checkbox" name="Jurisdictionid" value="d">钱包</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                                        <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改"); %></button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <!--<script src="/data/staff.js"></script>-->
        <%@include  file="/inc/js.html" %>
        <%
            entity.outinfo();
        %>
        <script type="text/javascript">
            $(window).ready(function ()
            {
                $("[name=parentid]").val([<% out.print(entity.get("entity"));%>]);
            });
            inputval = inputval.split(",");
            $("#sonpower input").attr("checked", false);
            $("#sonpower input").each(function () {
                var thisval = $(this).val();
                var thisinput = $(this);
                $.each(inputval, function (k, v) {
                    if (thisval == v) {
                        thisinput.prop("checked", true);
                    }
                })
            })
            $(".popupwrap").submit(function () {
                if ($("#name").val() == "") {
                    alert("请填写姓名！");
                    return false;
                }
                if ($ | ("#offsetid").val() == "") {
                    alert("请填写标识！");
                    return false;
                }
                var i = 0;
                $("#sonpower input").each(function () {
                    if ($(this).is(":checked")) {
                        i++;
                    }
                })
                if (i == 0) {
                    alert("请选择权限");
                    return false;
                }
            })
            maxoffsetid = parseInt(maxoffsetid);
            if (inputval[0].length == 0) {
                $("#offsetid").val(maxoffsetid + 1);
                $("#offsetid").attr("readonly", "readonly");
            } else {
                $("#offsetid").attr("readonly", "readonly");
            }
        </script>
    </body>
</html>
