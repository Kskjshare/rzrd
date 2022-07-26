<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
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
//    Collection<String> arry = new ArrayList<String>();
    Map<String, String> map = new HashMap<String, String>();
    RssList senduser = new RssList(pageContext, "userDeviceid");
    RssList duser = new RssList(pageContext, "secondeduser");
    RssList entity = new RssList(pageContext, "suggest");
    RssListView entity1 = new RssListView(pageContext, "sort");
    RssListView list = new RssListView(pageContext, "sort");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    RssList company = new RssList(pageContext, "suggest_company");
    list.request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        entity.remove("myid");
//        entity.remove("xzReviewTime");
        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("resume", 1);
//                entity.keyvalue("degree", 1);
//                entity.keyvalue("handlestate", 3);
//                entity.keyvalue("examination", 2);
//                entity.keyvalue("deal", 1);
                entity.keyvalue("isxzsc", 1);
//                entity.keyvalue("xzReviewTime", entity.get("xzReviewTime"));
//                entity.keyvalue("isdbtshenhe", 1);
                entity.keyvalue("xzscID", UserList.MyID(request));

                entity.update().where("id=?", list.get("id")).submit();

                company.keyvalue("type", 2);
                company.keyvalue("dworxz", 2);
                company.keyvalue("suggestid", list.get("id"));
                company.keyvalue("companyid", UserList.MyID(request));
                company.append().submit();

                entity1.select().where("id=?", list.get("id")).get_first_rows();
                String type = "";
                if (entity1.get("lwstate").equals("1")) {
                    type = "建议";
                    map.put("key", "2");
                } else {
                    type = "议案";
                    map.put("key", "3");
                }
                ;
                //推送人员
                duser.pagesize = 10000000;
                duser.select().where("suggestid=?", entity1.get("id")).get_page_desc("id");
                while (duser.for_in_rows()) {
                    if (!(duser.get("userid").isEmpty())) {
                        //推送的关键,构造一个payload 
                        senduser.pagesize = 10000000;
                        senduser.select().where("state=1 and myid=?", duser.get("userid")).get_page_desc("id");
                        String bt = entity1.get("title");
                        while (senduser.for_in_rows()) {
                            if (!(senduser.get("deviceid").isEmpty())) {
                                jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 乡镇政府办 正式办复！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条办复的" + type + "")).build());
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
                            jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 乡镇政府办 正式办复！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条办复的" + type + "")).build());
                        }
                    }
                }
                lzmessage.keyvalue("realid", list.get("id"));
                lzmessage.keyvalue("classify", 5);
                lzmessage.timestamp();
                lzmessage.append().submit();
                read.keyvalue("messageid", lzmessage.autoid);
                read.keyvalue("objid", entity.get("myid"));
                read.keyvalue("type", 1);
                read.append().submit();
                String[] arr = {"8", "16"};
                for (int idx = 0; idx < arr.length; idx++) {
                    read.keyvalue("messageid", lzmessage.autoid);
                    read.keyvalue("groupid", arr[idx]);
                    read.keyvalue("type", 1);
                    read.append().submit();
                }
                break;
//            case "update":
//                entity.keyvalue("resume", 1);
//                entity.update().where("id=?", list.get("id")).submit();
//                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    list.select().where("id=?", list.get("id")).get_first_rows();
    String[] arry = {"", "", ""};
    if (!entity.get("dfenclosure").isEmpty()) {
        String[] str = entity.get("dfenclosure").split(",");
        for (int idx = 0; idx < str.length; idx++) {
            arry[idx] = str[idx];
        }
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
            .popupwrap{width: 98%}
            .left_op{width: 30px}
            .mui-input-row span{display: none}
            .mui-input-range input[type=range]{background-color: #dce6f5;height: 6px;border: 1px solid #cbcbcb;width: 90%;margin: 0}
            .mui-input-row.mui-input-range{float: left;width: 90%;padding: 0;}
            .tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 36px;}
            .cellbor{width: 100%}
            .fileeform{position: absolute;left: -10000px;}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%}
            .cellbor>tbody>tr>.marginauto>#matter{line-height: 14px;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #baidubjq td{line-height: 17px;background: #dce6f5}
            #baidubjq td ul{width: 798px;margin-top: 5px;border-top: 1px solid #6caddc;border-left: 1px solid #6caddc;border-right: 1px solid #6caddc}
            #baidubjq td div{border-left: 1px solid #6caddc;border-right: 1px solid #6caddc;border-bottom: 1px solid #6caddc;margin-bottom: 5px;width: 778px;padding: 10px;background: #fff}
            .shu{line-height: 15px;text-align: center;}
            .uetd>ul{left: 0}
            .cellbor>tbody>tr .line{line-height: 24px}
            textarea{width: 99%;height: 60px;margin: 5px 0;}
            .red{color: red;}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            #fjfile1{cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform1" class="fileeform"enctype="multipart/form-data" method="post">
            <input type="file" id="file1" ridform="1" accept=".pdf" name="file1" multiple>
        </form>
        <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form id="fileeform3" class="fileeform" ridform="3" enctype="multipart/form-data" method="post">
            <input type="file" id="file3" ridform="3"  name="file3" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
                    <tr>
                        <td colspan="4" class="tabheader">建议信息</td>
                    </tr>
                    <tr>
                        <td class="dce">建议编号：</td>
                        <td class="w261"><% out.print(list.get("realid")); %></td>
                        <td class="dce">层次：</td>
                        <td class="w261" circles="<% list.write("level"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce">届次：</td>
                        <td colspan="3" sessionclassify="<% list.write("sessionid"); %>"></td>
                    </tr>
                    <tr><td class="dce">会议次数</td>
                        <td colspan="3" companytypeeeclassify="<% list.write("meetingnum"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce">类型：</td>
                        <td class="w261" classify="<% out.print(list.get("type")); %>"></td>
                        <td class="dce">提交日期：</td>
                        <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                    </tr>
                    <tr>
                        <td class="dce">建议题目：</td>
                        <td colspan="3"><% list.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce">初审日期：</td>
                        <td class="w261" rssdate="<% list.write("InitialReviewTime"); %>,yyyy-MM-dd HH:mm:ss"></td>
                        <td class="dce">审核状态：</td>
                        <td class="w261" examination="<% out.print(list.get("examination")); %>"></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="tabheader">办复信息</td>
                    </tr>
                    <tr style="display: none;">
                        <td class="dce">主办单位：</td>
                        <td colspan="3"><% out.print(list.get("realcompanyname")); %></td>
                        <!--                        <td class="dce">办理类型：</td>
                                                <td class="w261" registertype="<% out.print(list.get("registertype")); %>"></td>-->
                    </tr>
                    <tr style="display: none;">
                        <td class="dce">办理方式：</td>
                        <td><select class="w206" name="way" dict-select="way" def="<% list.write("way"); %>"></select></td>
                        <td class="dce">办理情况：</td>
                        <td class="w261"><select class="w206" name="degree" dict-select="degreea" def="<% list.write("degree"); %>"></select></td>
                    </tr>
                    <!--                    <tr>
                                            <td class="dce">办复密级：</td>
                                            <td><select class="w206" name="rank" dict-select="rank" def="<% list.write("rank"); %>"></select></td>
                                            <td class="dce">是否落实：</td>
                                            <td class="w261"><select class="w206" name="implement" dict-select="state" def="<% list.write("implement"); %>"></select></td>
                                        </tr>-->
                    <tr>
                        <!--                        <td class="dce">代表意见：</td>
                                                <td><select class="w206" name="representative" dict-select="representative" def="<% list.write("representative"); %>"></select></td>-->
                        <td class="dce">答复日期：<em class="red">*</em></td>
                        <td class="w261" colspan="3"><input type="text" class="w200 Wdate" name="xzReviewTime" rssdate="<% list.write("xzReviewTime"); %>,yyyy-MM-dd"  onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="dce">办复人：</td>
                        <td><input type="text" class="yincang" name="BanFuName" placeholder="非乡镇政府办管理员请输入" value="<% list.write("BanFuName"); %>"></td>
                        <td class="dce">办复人电话：</td>
                        <td class="w261"><input type="text" class="yincang" name="BanFutel" placeholder="请输入电话" value="<% list.write("BanFutel"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce">意见说明：<em class="red">*</em></td>
                        <td colspan="3"><textarea name="comments"><% out.print(list.get("comments")); %></textarea></td>
                    </tr>
                    <tr><td>附件</td><td colspan="5">
                            <div><span id="fjfile1" rid="1"><% out.print(arry[0].isEmpty() ? "点击选择文件" : arry[0]); %></span><input type="hidden" id="enclosure1" value="<% out.print(arry[0]); %>" ></div>
                            <div style="display: none;"><span id="fjfile2" rid="2"><% out.print(arry[1].isEmpty() ? "点击选择文件" : arry[1]); %></span><input type="hidden" id="enclosure2" value="<% out.print(arry[1]); %>" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3"><% out.print(arry[2].isEmpty() ? "点击选择文件" : arry[2]); %></span><input type="hidden" id="enclosure3" value="<% out.print(arry[2]); %>" ></div>
                        </td></tr>
                    <tr>
                        <td class="dce">办复报告：<em class="red">*</em></td>
                        <td colspan="3">[操作提示]为规范报告格式，录入完办复报告后，请务必点击排版办复报告。</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="marginauto"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="resumeinfo" class="w750" type="text/plain"><% entity.write("resumeinfo");%></script></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">提交</button>
                <input name="dfenclosure" type="hidden">
                <!--<input name="xzReviewTime" type="hidden">-->
                <input name="myid" type="hidden" value="<% out.print(entity.get("myid"));%>">
            </div>
        </form>
        <!--<script src="/data/bill.js" type="text/javascript"></script>-->
        <script src="../../data/session.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script src="../../data/dictdata.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                            $(".footer>button").click(function () {
                                var myDate = new Date();
                                var s = myDate.getHours(); //获取当前小时数(0-23)
                                var f = myDate.getMinutes(); //获取当前分钟数(0-59)
                                var m = myDate.getSeconds(); //获取当前秒数(0-59)
//                                alert(s+"--"+f+"--"+m)
                                var timestamp = Date.parse(new Date());
//                                console.log(timestamp / 1000);
//                                $('[name=ResponseTime]').val(timestamp / 1000);
//                                if ($("[name='xzReviewTime']").val() != "" && $("[name='xzReviewTime']").val() != undefined) {
//                                    var timestamp = new Date($("[name='xzReviewTime']").val() + " " + s + ":" + f + ":" + m);
//                                    $("[name='xzReviewTime']").val(timestamp / 1000);
//                                }
                                console.log(timestamp / 1000);
                                $('[name=xzReviewTime]').val(timestamp / 1000);

                                var enc = $("#enclosure1").val() + "," + $("#enclosure2").val() + "," + $("#enclosure3").val();
                                $("input[name='dfenclosure']").val(enc);

                                if ($("[name='xzReviewTime']").val() == undefined || $("[name='xzReviewTime']").val() == "") {
                                    alert("请填写答复日期");
                                    $("[name='xzReviewTime']").focus();
                                    return false;
                                }
                                if ($("[name='comments']").val() == undefined || $("[name='comments']").val() == "") {
                                    alert("请填写答复说明");
                                    $("[name='comments']").focus();
                                    return false;
                                }

                                if ($("[name='resumeinfo']").val() == undefined || $("[name='resumeinfo']").val() == "") {
                                    alert("请填写答复报告");
                                    $("[name='resumeinfo']").focus();
                                    return false;
                                }
                            })
                            $(".cellbor").click(function () {
                                $("#dblist").hide();
                            })
                            //上传附件
                            $("span[rid]").click(function () {
                                var rid = $(this).attr("rid")
                                $("#file" + rid).click();
                            })
                            $(".fileeform>input").change(function () {
                                var ridform = $(this).attr("ridform");
                                $(this).parent().ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        $("#fjfile" + ridform).text(data.url)
                                        $("#enclosure" + ridform).val(data.url);
                                        alert("上传成功");
                                    }});
                                return false;
                            })
        </script>
    </body>
</html>
