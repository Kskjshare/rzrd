<%@page import="java.util.Map"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="org.json.JSONObject"%>
<%@page import="cn.jpush.api.JPushConfig"%>
<%@page import="org.jsoup.Connection.Request"%>
<%@page import="javafx.concurrent.Task"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="cn.jpush.api.push.model.notification.AndroidNotification"%>
<%@page import="cn.jpush.api.push.model.notification.IosNotification"%>
<%@page import="cn.jpush.api.push.model.audience.AudienceTarget"%>
<%@page import="cn.jpush.api.push.PushResult"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="RssEasy.MySql.Order.OrderDivideList"%>
<%@page import="java.util.Arrays"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.HashMap"%>
<%@page import="RssEasy.MySql.Order.OrderList"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="RssEasy.CreditCard.MailBill.MailBillExtend"%>
<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.security.cert.CertificateException"%>
<%@page import="java.security.cert.X509Certificate"%>
<%@page import="javax.net.ssl.X509TrustManager"%>
<%@page import="javax.net.ssl.SSLContext"%>
<%@page import="javax.net.ssl.HostnameVerifier"%>
<%@page import="javax.net.ssl.SSLSession"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<%@page import="org.jsoup.helper.HttpConnection"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.CreditCard.CreditCardBillList"%>
<%@page import="java.lang.reflect.Field"%>
<%@page import="RssEasy.CreditCard.Bill.RssCreditBillDetail"%>
<%@page import="RssEasy.Core.DictionaryExtend"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="RssEasy.MySql.CreditCard.PopMailList"%>
<%@page import="RssEasy.Core.RssTable"%>
<%@page import="RssEasy.Core.MailExtend"%>
<%@page import="RssEasy.MySql.RssCodeList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="RssEasy.DAL.MySqlHelper"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.MySql.Fund.RechargeList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
//    //推送的关键,构造一个payload 
//    Collection<String> list = new ArrayList<String>();
//    list.add("13065ffa4e521b4d79b");
//    Map<String,String> map=new HashMap<String,String>();
//    map.put("key", "7");
//    String type = "建议", bt = "aa";
//    String ALERT="您有一条" + type + "已被 兰海刚 审查！《" + bt + "》";
//    String TITLE="审查";
//    String MSG_CONTENT="这是自定义消息";
////    jpushClient.sendPush(
////            PushPayload.newBuilder()
////                    .setPlatform(Platform.all())  
////                    .setAudience(Audience.registrationId(list))
//////                    .setNotification(Notification.alert("您有一条" + type + "已被 乡镇政府办 审查！《" + bt + "》"))
////                     .setNotification(Notification.android(ALERT, TITLE, map))
////                    .build()
////    );
//jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(list)).setNotification(Notification.android("您有一条" + type + "已被 代表团 审查！《" + bt + "》","vhh",map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).build());
//1、填写完整的包名和 Activity，具体格式为：
//
//intent:#Intent;component=com.jiguang.push/com.example.jpushdemo.SettingActivity;end
//        
//        intent:#Intent;component=com.rsseasy.lvzhi/index.html;end
//    Task task = Site.me()
//            .setTimeOut(5000)
//            .addHeader("Authorization", "Basic " + Authorization)
//            .addHeader("Content-Type", "application/json")
//            .setCharset("utf-8")
//            .toTask();
//    Request request1 = new Request();
//    request.setUrl(JPushConfig.CID_URL);
//    request.setMethod(HttpConstant.Method.GET);
//    List<String> cidList;
//    try {
//        Page page = DOWNLOADER.download(request, task);
//        if (page.getStatusCode() == 200) {
//            JSONObject jsonObject = JSON.parseObject(page.getRawText());
//            cidList = JSON.parseArray(jsonObject.getString("cidlist"), String.class);
//        } else {
//            throw new IllegalArgumentException("cid 获取接口请求失败 失败原因" + page.getRawText());
//        }
//    } catch (Exception e) {
//        return null;
//    }
%>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #editor{font-size: 20px;}
        </style>
    </head>
    <body>
        <!--        <form method="post" class="popupwrap">
                    <div class="infowrap">
                        aa
                    </div>
                </form>-->
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

        <!-- Create the editor container -->
        <div id="editor">
            <p>Hello World!</p>
            <p>Some initial <strong>bold</strong> text</p>
            <p><br></p>
        </div>

        <!-- Include the Quill library -->
        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

        <!-- Initialize Quill editor -->
        <script>
            var quill = new Quill('#editor', {
                theme: 'snow'
            });
        </script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
<script>
//    new Ajax("Deviceid").keyvalue({"myid":11185,"deviceid":"5755"}).getJson(function (json) {
////        var rsscode = json['deviceid'];
//        var html = "";
//        $.each(json, function (k, v) {
//            html = "<p>" + v.deviceid + "</p>"
//            $(".infowrap").append(html);
//        })
//        alert(json)
//    })
</script>

