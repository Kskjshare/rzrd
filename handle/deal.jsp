<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
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
    //推送接口
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    //创建推送的人员范围
    Map<String, String> map = new HashMap<String, String>();
    RssList senduser = new RssList(pageContext, "userDeviceid");
    RssList duser = new RssList(pageContext, "secondeduser");
    RssList entity = new RssList(pageContext, "suggest");
    RssList entity2 = new RssList(pageContext, "suggest");
    RssListView entity1 = new RssListView(pageContext, "sort");
    RssList company = new RssList(pageContext, "suggest_company");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        String[] num = entity.get("id").split(",");
        entity.remove("id");
        
        //ding 闭会测试，流程到最后的承办单位，无法查看议案的问题。 这里强行在交付的时候把deal设置为1.不知道会不会有问题。
            entity.keyvalue("deal", 1);
        for (int idx = 0; idx < num.length; idx++) {
            entity.remove("companyid");
            entity.keyvalue("deal", 1);
            entity.keyvalue("handlestate", 3);
            entity.keyvalue("jbID", UserList.MyID(request));
            entity.update().where("id=?", num[idx]).submit();
            //推送人员
            duser.pagesize = 10000000;
            duser.select().where("suggestid=?", num[idx]).get_page_desc("id");
            entity1.select().where("id=?", num[idx]).get_first_rows();
            String type = "";
            if (entity1.get("lwstate").equals("1")) {
                type = "建议";
                map.put("key", "2");
            } else if ( entity1.get("lwstate").equals("2")) {
                type = "议案";
                map.put("key", "3");
            }
           else if ( entity1.get("lwstate").equals("3")) {
                type = "批评";
                map.put("key", "4");
            }     
          else if ( entity1.get("lwstate").equals("4")) {
                type = "意见";
                map.put("key", "5");
            }
            else if ( entity1.get("lwstate").equals("5")) {
                type = "质询";
                map.put("key", "6");
            }
            while (duser.for_in_rows()) {
                if (!(duser.get("userid").isEmpty())) {
                    senduser.pagesize = 10000000;
                    senduser.select().where("state=1 and myid=?", duser.get("userid")).get_page_desc("id");
                    String bt = entity1.get("title");
                    while (senduser.for_in_rows()) {
                        if (!(senduser.get("deviceid").isEmpty())) {
                            //jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 政府办 正式交办！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条交办的" + type + "")).build());
                            //commented by jackie
                        }
                    }
                }
            }
            if (!(entity1.get("myid").isEmpty())) {
                senduser.pagesize = 10000000;
                senduser.select().where("state=1 and myid=?", entity1.get("myid")).get_page_desc("id");
                String bt = entity1.get("title");
                while (senduser.for_in_rows()) {
                    if (!(senduser.get("deviceid").isEmpty())) {
                        //jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 政府办 正式交办！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条办交办的" + type + "")).build());
                        //commented by jackie
                    }
                }
                lzmessage.keyvalue("realid", num[idx]);
                lzmessage.keyvalue("classify", 9);
                lzmessage.timestamp();
                lzmessage.append().submit();
                String[] arr = entity.get("company").split(",");
                for (int idxx = 0; idxx < arr.length; idxx++) {
                    read.keyvalue("messageid", lzmessage.autoid);
                    read.keyvalue("objid", arr[idxx]);
                    read.keyvalue("type", 1);
                    read.append().submit();
                }
            }
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
            table{padding: 20px 80px; display: block;width: 65%;}
            #process{width: 400px;height: 28px;padding: 0;border: #e8eef8 solid thin;border-radius: 10px;overflow: hidden;margin: 0 auto;line-height: 28px;background: #6caddc;position: relative;}
            #process>p{width: 100%;height: 100%;background: #fff;display: inline-block;}
            #process>span{position: absolute;top: 0;color: #a4c2d9;padding: 0 5px}
            
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100">
                    <tr>
                        <td>正式交办日期：</td>
                        <td><input type="text" class="w200 Wdate" name="start" rssdate="<% out.print(entity.get("start")); %>,yyyy-MM-dd" onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>要求结办日期：</td>
                        <td><input type="text" class="w200 Wdate" name="stop" rssdate="<% out.print(entity.get("stop")); %>,yyyy-MM-dd" onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                </table>
                <div id="process" process="<% out.print(entity.get("process")); %>" ><p></p><span><% out.print(entity.get("process"));%>%</span></div>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="1" />
                <button type="submit">交办</button>
                <input name="AssignedByTime" type="hidden">
                <input name="companyid" type="hidden" value="<%
                    company.select().where("type=2 and suggestid=" + entity.get("id")).query();
                    String str = "";
                    while (company.for_in_rows()) {
                        str += company.get("companyid") + ",";
                    }
                    if (str.length() == 0) {
                        out.print(str);
                    } else {
                        str = str.substring(0, str.length() - 1);
                        out.print(str);
                    }
                       %>">
            </div>
        </form>
        <!--<script src="/data/bill.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script>
            $("#process").find("p").css("margin-left", $("#process").attr("process") + "%")
            $("#process").find("span").css("left", $("#process").attr("process") + "%")
            if ($("#process").attr("process") < 15) {
                $("#process").find("span").css("left", "10px")
            }
            if ($("#process").attr("process") > 80) {
                $("#process").find("span").css("margin-left", "-30px")
                $("#process").find("span").css("color", "#fff")
            }
            $(".footer>button").click(function () {
                var timestamp = Date.parse(new Date());
                console.log(timestamp / 1000);
                $('[name=AssignedByTime]').val(timestamp / 1000);
                console.log($("[name='start']").val() + "+" + $("[name='stop']").val())
                if ($("[name='start']").val() == "" && $("[name='stop']").val() == "") {
                    alert("请完整填写时间")
                    return false;
                } else {
                    var timestamp = new Date($("[name='start']").val());
                    $("[name='start']").val(timestamp / 1000);
                    var timestamp2 = new Date($("[name='stop']").val());
                    $("[name='stop']").val(timestamp2 / 1000);
                }
            })
        </script>
    </body>
</html>
