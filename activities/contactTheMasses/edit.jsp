<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%--<%@page import="cn.jpush.api.JPushClient"%>--%>
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
    //推送接口
//    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
//    RssList senduser = new RssList(pageContext, "userDeviceid");
    Map<String, String> map = new HashMap<String, String>();
    map.put("key", "1");
    RssList entity2 = new RssList(pageContext, "activities");
    RssList user = new RssList(pageContext, "activities_userlist");
    CookieHelper cookie = new CookieHelper(request, response);
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();
    entity2.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity2.timestamp();
                entity2.remove("userid");

                //处理编号 开始
                String a = "L";
                Calendar calendar = Calendar.getInstance();
                int year = calendar.get(Calendar.YEAR);
                RssList sequence = new RssList(pageContext, "sort_sequence");
                sequence.select().where("seq_name=" + year).get_first_rows();
                a += year;
                a += sequence.get("lvzhi_val");
                entity2.keyvalue("realid", a);
                sequence.keyvalue("lvzhi_val", Integer.valueOf(sequence.get("lvzhi_val")) + 1);
                sequence.update().where("seq_name=" + year).submit();
                //处理编号 结束

                entity2.append().submit();
                break;
            case "update":
                entity2.remove("userid");
                entity2.update().where("id=" + entity2.get("id")).submit();
                user.delete().where("activitiesid=" + entity2.get("id") + "").submit();
                break;
        }
        String str = entity2.get("userid");
        String[] arry = str.split(",");
        for (int i = 0; i < arry.length; i++) {
            user.timestamp();
            user.keyvalue("activitiesid", entity2.autoid);
            user.keyvalue("userid", arry[i]);
            user.keyvalue("myid", entity2.get("myid"));
            user.append().submit();

//            senduser.pagesize = 10000000;
//            senduser.select().where("state=1 and myid=?", arry[i]).get_page_desc("id");
//            while (senduser.for_in_rows()) {
//                if (!(senduser.get("deviceid").isEmpty())) {
//                    jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的活动！", "活动通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条活动。")).build());
//                }
//            }
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
        <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .cellbor{border: 0}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: 0;line-height: 34px;position: relative;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #fileeform{position: absolute;left: -10000px;}
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
                        <td class="dce w100 ">标题：</td>
                        <td><input type="text" maxlength="80" class="w250" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <!--                    <tr>
                                            <td class="dce w100 ">活动类型：</td>
                                            <td>
                                                <input type="text" class="w250" name="classify" value="<% entity.write("classify"); %>" />
                                            </td>
                                        </tr>-->
<!--                    <tr>
                        <td class="dce w100 ">组织部门：</td>
                        <td><input type="text" maxlength="80" class="w250" name="department" value="<% entity.write("department"); %>" /></td>
                    </tr>
-->
                    <tr>
                        <td class="dce w100 ">活动时间：</td>
                        <td><input type="text" class="w200 Wdate" name="beginshijian"  rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
<!--                    <tr>
                        <td class="dce w100 ">结束时间：</td>
                        <td><input type="text" class="w200 Wdate" name="finishshijian"  rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
-->
<!--                    <tr>
                        <td class="dce w100 ">活动地址:</td>
                        <td><input type="text" maxlength="80" class="w250" name="place" value="<% entity.write("place"); %>" /></td>
                    </tr>
-->
<!--                    <tr>
                        <td class="dce w100 ">邀请参与代表</td>
                        <td id="seluserlist"><em selectuser>点击选择代表</em>
                            <%/*
                                RssListView entity4 = new RssListView(pageContext, "activities_realname");
                                if (!entity.get("id").isEmpty()) {
                                    entity4.select().where("activitiesid=" + entity.get("id")).query();
                                    while (entity4.for_in_rows()) {*/
                            %>
                            <em myid='<%// out.print(entity4.get("userid"));%>'><%// out.print(entity4.get("realname"));%><i>×</i></em>
                            <%
                              //      }
                               // }
                                
                            %>
                        </td>
-->
                    </tr>
                    <tr>
                        <td class="dce w100 left"><span>活动安排：</span></td>
                        <td ><textarea class="w250" name="note"><% entity.write("note"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">上传附件：</td>
                        <td colspan="3">
                            <span id="fjfile"><% out.print(entity.get("enclosurename").isEmpty() ? "点击选择文件" : entity.get("enclosurename")); %></span>
                            <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                            <input type="hidden" name="enclosurename" value="<% entity.write("enclosurename"); %>" >
                        </td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" id="rid" name="userid" value="">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "确定" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            <% RssListView user1 = new RssListView(pageContext, "user_delegation");
                user1.request();
                if (entity.get("id").isEmpty()) {
                    user1.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                } else {
                    user1.select().where("myid=" + entity.get("myid")).get_first_rows();
                }
            %>
                
                
                
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
                
                
               
                            $('[selectuser]').click(function () {
                                var t = $(this).parent();
                                RssWin.onwinreceivemsg = function (dict) {
                                    console.log(dict);
                                    $.each(dict, function (k, v) {
                                        if ($("em[myid='" + v.myid + "']").length == "0") {
                                            t.append("<em myid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                                        }
                                    })
                                    $("#seluserlist i").off("click").click(function () {
                                        $(this).parent().remove();
                                    })
                                }
                                RssWin.open("/activities/selectuser_2.jsp?mission=<%=cookie.Get("myid")%>", 500, 700);
                                var coo =<%=cookie.Get("powergroupid")%>;
                                if (coo == "22") {
                                    RssWin.open("/activities/selectuser_2.jsp?mission=<%=cookie.Get("myid")%>", 500, 700);
                                } else {
                                    RssWin.open("/activities/selectuser_2.jsp?mission=<%=user1.get("mission")%>", 500, 700);
                                }
                            });
                            $("#seluserlist i").off("click").click(function () {
                                $(this).parent().remove();
                            })
                            $(".footer button").click(function () {
                                var arry = [];
                                $("#seluserlist>em[myid]").each(function () {
                                    arry.push($(this).attr("myid"))
                                })
                                var str = arry.join(",");
                                $("#rid").val(str);

                                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                                    alert("请填写活动标题");
                                    $("[name='title']").focus();
                                    return false;
                                }
//                                if ($("[name='department']").val() == undefined || $("[name='department']").val() == "") {
//                                    alert("请填写组织部门");
//                                    $("[name='department']").focus();
//                                    return false;
//                                }
                                if ($("[name='beginshijian']").val() == undefined || $("[name='beginshijian']").val() == "") {
                                    alert("请填写活动日期");
                                    $("[name='beginshijian']").focus();
                                    return false;
                                }
//                                if ($("[name='finishshijian']").val() == undefined || $("[name='finishshijian']").val() == "") {
//                                    alert("请填写结束日期");
//                                    $("[name='finishshijian']").focus();
//                                    return false;
//                                }
//                                if ($("[name='beginshijian']").val() == undefined || $("[name='beginshijian']").val() == "") {
//                                    alert("请填写开始日期");
//                                    $("[name='beginshijian']").focus();
//                                    return false;
//                                }
//                                if ($("[name='place']").val() == undefined || $("[name='place']").val() == "") {
//                                    alert("请填写活动地址");
//                                    $("[name='place']").focus();
//                                    return false;
//                                }
//                                if ($("#seluserlist em").length == 1) {
//                                    alert("请选择代表");
//                                    return false;
//                                }
                                $(".Wdate").each(function () {
                                    if ($(this).val() != undefined && $(this).val() != "") {
                                        var timestamp = new Date($(this).val() + " 23:59:59");
                                        $(this).val(timestamp / 1000);
                                    }
                                })
                            })
        </script>
    </body>
</html>
