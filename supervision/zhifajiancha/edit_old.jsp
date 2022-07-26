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
    RssList entity = new RssList(pageContext, "supervision_inspection");
    RssListView user_delegation = new RssListView(pageContext, "user_delegation");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid", "objid");
                entity.update().where("id=?", entity.get("relationid")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("relationid")).get_first_rows();
    if (!entity.get("userroleid").equals("")) {//单位名称以逗号间隔
        StringBuilder company_name = new StringBuilder();

        user_delegation.select("company").where("myid in (" + entity.get("userroleid") + ")").get_page_desc("myid");
        while (user_delegation.for_in_rows()) {
            company_name.append(user_delegation.get("company")).append(",");
        }
        req.keyvalue("userrolecompany", company_name.deleteCharAt(company_name.length() - 1));
    }
    if (!entity.get("organizationid").equals("")) {
        StringBuilder subcompany_name = new StringBuilder();
        user_delegation.select("company").where("myid in (" + entity.get("organizationid") + ")").get_page_desc("myid");
        while (user_delegation.for_in_rows()) {
            subcompany_name.append(user_delegation.get("company")).append(",");
        }
        req.keyvalue("orgcompany", subcompany_name.deleteCharAt(subcompany_name.length() - 1));
    }
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
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
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
                        <td colspan="4" class="institle dce">添加执法检查计划</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">标题：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">检查组人员：<em class="red">*</em></td>
                        <td><input type="text" maxlength="180" class="w254" name="membername" value="<% entity.write("membername"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">专委会<em class="red">*</em></td>
                        <td colspan="2" id="userrolesel">
                            <input class="b95" readonly="readonly" value="<% req.write("userrolecompany"); %>"/>
                            <input type="hidden" name="userroleid" id="userroleid" value="<% entity.write("userroleid"); %>"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">主办单位<em class="red">*</em></td>
                        <td colspan="2" id="organizationsel">
                            <input class="b95" readonly="readonly" value="<% req.write("orgcompany"); %>"/>
                            <input type="hidden" name="organizationid" id="organizationid" value="<% entity.write("organizationid"); %>"/>
                        </td>
                    </tr>

                    <tr>
                        <td class="dce w100 ">附件：</td>
                        <td colspan="3">
                            <span id="fjfile"><% out.print(entity.get("enclosurename").isEmpty() ? "点击选择文件" : entity.get("enclosurename")); %></span>
                            <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                            <input type="hidden" name="enclosurename" value="<% entity.write("enclosurename"); %>" >
                        </td>
                    </tr>

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "发送" : "修改");%></button>
                <input type="hidden" name="objid" >
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                }

                if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
                    var timestamp = new Date($("[name='meetingshijian']").val());
                    $("[name='meetingshijian']").val(timestamp / 1000);
                }
            })


            $("#fjfile").click(function () {
                $("#filee").click();
            })
            $("#filee").change(function () {
                var str = $(this).val(); //开始获取文件名
                var filename = str.substring(str.lastIndexOf("\\") + 1);
                $("#fileeform").ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#fjfile").text(filename)
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                        alert("上传成功");
                    }});
                return false;
            })
            $("#userrolesel>input").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                    $.each(dict, function (k, v) {
                        userrolename.push(v.myname)
                        userroleval.push(v.myid)
                    })
                    userrolenamesp = userrolename.join(",");
                    userrolevalsp = userroleval.join(",");
                    $("#userrolesel").find("input:first").val(userrolenamesp)
                    $("#userroleid").val(userrolevalsp)
                }
                RssWin.open("/supervision/zhifajiancha/selectuserrole.jsp", 700, 650);
            });
            $("#organizationsel>input").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                    $.each(dict, function (k, v) {
                        userrolename.push(v.myname)
                        userroleval.push(v.myid)
                    })
                    userrolenamesp = userrolename.join(",");
                    userrolevalsp = userroleval.join(",");
                    $("#organizationsel").find("input:first").val(userrolenamesp)
                    $("#organizationid").val(userrolevalsp)
                }
                RssWin.open("/supervision/zhifajiancha/selectuserrole.jsp", 700, 650);
            });

        </script>
    </body>
</html>
