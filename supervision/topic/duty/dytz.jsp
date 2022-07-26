<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.RssTable"%>
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
    RssList entity = new RssList(pageContext, "supervision_topic_process");
    RssList report = new RssList(pageContext, "supervision_topic_process_report");
    RssListView user_delegation = new RssListView(pageContext, "user_delegation");
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();

    if (!entity.get("action").isEmpty()) {
        long processid = 0;
        long processid2 = 0;
        entity.remove("userroleid");
        entity.keymyid(cookie.Get("myid"));
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.keyvalue("state", "2");
                entity.append().submit();
                switch (req.get("typeid")) {
                    case "1":
                        entity.keyvalue("typeid", "2").keyvalue("state", "1");
                        entity.append().submit();
                        processid = entity.autoid;
                        break;
                    case "6":
                        entity.keyvalue("typeid", "7").keyvalue("state", "1");
                        entity.append().submit();
                        processid = entity.autoid;
                        entity.keyvalue("typeid", "8").keyvalue("state", "0");
                        entity.append().submit();
                        processid2 = entity.autoid;
                        break;
                    default:
                        break;
                }
                break;
            case "update":
                entity.remove("id");
                entity.keyvalue("state", "2");
                entity.update().where("id=?", entity.get("id")).submit();
                entity.select("topicid").where("id=?", entity.get("id")).get_first_rows();
                String topicid=entity.get("topicid");
                entity.select("id").where("topicid="+topicid+" and typeid=7").get_first_rows();
                processid = Long.parseLong(entity.get("id"));
                entity.select("id").where("topicid="+topicid+" and typeid=8").get_first_rows();
                processid2 = Long.parseLong(entity.get("id"));
//                report.delete().where("processid=" + entity.get("id") + "").submit();
                break;
        }

        String str = entity.get("userroleid");
        String[] arry = str.split(",");
        if (!entity.get("userroleid").equals("")) {
            for (int i = 0; i < arry.length; i++) {
                report.keyvalue("processid", processid);
                report.keyvalue("topicid", entity.get("topicid"));
                report.keyvalue("myid", entity.get("myid"));
                report.keyvalue("state", "1");
                report.keyvalue("userroleid", arry[i]);
                report.timestamp();
                report.append().submit();
            }
            if (req.get("typeid").equals("6")) {//添加审议意见时，同时要向第7、8步添加report，其中第8步reportstate=0，待第7步完成时，对应的第8步state变为1
                for (int i = 0; i < arry.length; i++) {
                    report.keyvalue("processid", processid2);
                    report.keyvalue("topicid", entity.get("topicid"));
                    report.keyvalue("myid", entity.get("myid"));
                    report.keyvalue("state", "0");
                    report.keyvalue("userroleid", arry[i]);
                    report.timestamp();
                    report.append().submit();
                }
            }
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("topicid=? and typeid=?", entity.get("topicid"), entity.get("typeid")).get_first_rows();

    if (!entity.get("userroleid").equals("")) {//单位名称以逗号间隔
        StringBuilder company_name = new StringBuilder();

        user_delegation.select("company").where("myid in (" + entity.get("userroleid") + ")").get_page_desc("myid");
        while (user_delegation.for_in_rows()) {
            company_name.append(user_delegation.get("company")).append(",");
        }
        req.keyvalue("company", company_name.deleteCharAt(company_name.length() - 1));
    }
    if (!entity.get("subuserroleid").equals("")) {
        StringBuilder subcompany_name = new StringBuilder();
        user_delegation.select("company").where("myid in (" + entity.get("subuserroleid") + ")").get_page_desc("myid");
        while (user_delegation.for_in_rows()) {
            subcompany_name.append(user_delegation.get("company")).append(",");
        }
        req.keyvalue("subcompany", subcompany_name.deleteCharAt(subcompany_name.length() - 1));
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
            <input type="hidden" name="id" value="<%entity.write("id");%>"/>
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce" supervisiontopicduty="<%out.print(entity.get("typeid"));%>"></td>
                    </tr>

                    <tr>
                        <td class="dce w150 ">相关说明：<em class="red">*</em></td>
                        <td colspan="3"><textarea type="text" class="b95 h100" name="matter"><% entity.write("matter"); %></textarea></td>
                    </tr>
                    <%
                        if (entity.get("typeid").equals("1") || entity.get("typeid").equals("6")) {
                    %>

                    <tr>
                        <td class="dce w100 ">选择主送单位<em class="red">*</em></td>
                        <td colspan="2" id="userrolesel">
                            <input class="w600" readonly="readonly" value="<% req.write("company"); %>"/>
                            <input type="hidden" name="userroleid" id="userroleid" value="<% entity.write("userroleid"); %>"/>
                        </td>
                    </tr>
<!--                    <tr>
                        <td class="dce w100 ">选择抄送单位</td>
                        <td colspan="2" id="userrolese2">
                            <input class="w200" readonly="readonly" value="<% req.write("subcompany"); %>">
                            <input type="hidden" name="subuserroleid" id="subuserroleid" value="<% entity.write("userroleid"); %>"/>
                        </td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">限办时间：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="deadline"  rssdate="<% out.print(entity.get("deadline")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                    <%}%>
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
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "保存");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                            $(".footer>button").click(function () {
                                if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
                                    alert("请填写说明");
                                    $("[name='matter']").focus();
                                    return false;
                                }
                                if ($("[name='userroleid']").val() == "") {
                                    alert("请选择主办单位");
                                    $("[name='userroleid']").focus();
                                    return false;
                                }
                                if ($("[name='deadline']").val() == "") {
                                    alert("请选择限办时间");
                                    $("[name='deadline']").focus();
                                    return false;
                                }
                                if ($("[name='deadline']").val() != undefined && $("[name='deadline']").val() != "") {
                                    var timestamp = new Date($("[name='deadline']").val());
                                    $("[name='deadline']").val(timestamp / 1000);
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
                                if(data.url !== null && "" !== data.url){
                                        $("#fjfile").text(filename)
                                        $("input[name='enclosure']").val(data.url);
                                        $("input[name='enclosurename']").val(filename);
                                        alert("上传成功");
                                        }else{
                                        $("#fjfile").text("点击选择文件")
                                        $("input[name='enclosure']").val(data.url);
                                        $("input[name='enclosurename']").val(filename);
                                        alert("未上传")
                                        }
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
                                RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
                            });

                            $("#userrolese2>input").click(function () {
                                RssWin.onwinreceivemsg = function (dict) {
                                    var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                                    $.each(dict, function (k, v) {
                                        userrolename.push(v.myname)
                                        userroleval.push(v.myid)
                                    })
                                    userrolenamesp = userrolename.join(",");
                                    userrolevalsp = userroleval.join(",");
                                    $("#userrolese2").find("input:first").val(userrolenamesp)
                                    $("#subuserroleid").val(userrolevalsp)
                                }
                                RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
                            });
        </script>
    </body>
</html>
