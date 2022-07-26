<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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

<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.JPushClient"%>

<%
    StaffList.IsLogin(request, response);
//    RssList entity = new RssList(pageContext, "evaluation_batch");
    RssList entity = new RssList(pageContext, "permission");
    //RssList standard = new RssList(pageContext, "evaluation_standard");
    //RssListView user_delegation = new RssListView(pageContext, "user_delegation");
    //RssList scores = new RssList(pageContext, "evaluation_score");
    entity.request();
    
    
    //推送接口
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    //创建推送的人员范围
    RssList senduser = new RssList(pageContext, "userDeviceid");
    Map<String, String> map = new HashMap<String, String>();
    
    if (entity.get("action").equals("append")) {
        entity.timestamp();
        entity.keymyid(UserList.MyID(request));
        entity.append().submit();
        
        if (!entity.get("objid").equals(",")) {
            String[] bb = entity.get("objid").split(",");
            //推送
            String type = "通知";
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    //推送人员
                    //duser.select().where("objid=?", bb[i]).get_first_rows();
                    //推送的关键,构造一个payload 
                    senduser.pagesize = 10000000;
                    senduser.select().where("myid=" + bb[i] + " and state=1").get_page_desc("id");
                    while (senduser.for_in_rows()) {
                            if (!(senduser.get("deviceid").isEmpty())) {
                                //jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的测评邀请" + type  "！", "" + type + "通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条" + type + "")).build());
                            jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的测评邀请！", "" + type + "通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条" + type + "")).build());
                            }
                        }

                    }
            }
        }
        //推送结束

        //开始 考核分数表
//        user_delegation.select("myid").where("state=2").query();
//        while (user_delegation.for_in_rows()) {
//            if (!user_delegation.get("myid").isEmpty()) {
//                scores.timestamp();
//                scores.keymyid(user_delegation.get("myid"));
//                scores.keyvalue("batchid", entity.autoid).keyvalue("standardid", entity.get("standardid"));
//                scores.append().submit();
//            }
//
//        }
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
            .w630{width:630px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--
                    <tr>
                        <td colspan="4" id="tabheader">计分标准</td>
                    </tr>
                    -->
                    
                     <tr>
                        <td class="dce w100 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开关</td>                    
                        <td>开启&nbsp;<input style="cursor:pointer;" id="open"  type="radio" name="switch" checked="cheched" value="1"></td>
                        <td>关闭&nbsp;<input style="cursor:pointer;" id="off"  type="radio"  name="switch" value="0"></td>

                    </tr>
                    
                    <tr>
                        <td class="dce w100 ">测评名称</td>
                        <td colspan="2"><input type="text" maxlength="80" class="w300" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>

                    <tr>
                        <td class="dce w100 ">开始时间</td>
                        <td ><input type="text" class="w300 Wdate" id="beginshijian" name="beginshijian"  rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" onFocus="WdatePicker({dateFmt: 'yyyy-MM-dd', startDate: '%y-%M-%d', maxDate: '#F{$dp.$D(\'finishshijian\')}'})" readonly="readonly"></td>
                        <td class="w350 " rowspan="2">测评会在对应的时间自动开始与结束。</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间：</td>
                        <td><input type="text" class="w300 Wdate" id="finishshijian" name="finishshijian"  rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd" onFocus="WdatePicker({dateFmt: 'yyyy-MM-dd', startDate: '%y-%M-%d', minDate: '#F{$dp.$D(\'beginshijian\')}'})" readonly="readonly"></td>
                    </tr>
                    
                    
                     <tr>
                        <td class="dce w100 ">选择评测人</td>                    
                        <td>全部代表&nbsp;<input style="cursor:pointer;" id="full"  type="radio" name="participate" checked="cheched" value="1"></td>
                        <td>部分代表&nbsp;<input style="cursor:pointer;" id="part"  type="radio"  name="participate" value="0"></td>

                    </tr>
<!--                     <tr>
                        <td class="dce">
                            <span style="font-weight: bold;color: blue" class="selectuser" style="cursor:pointer;">添加测评人</span>
                            <em selectuser>添加测评人</em>
                        </td>
                      
                        <td colspan="5">
                            <ul id="blfyr" class="lianmingren">
                                <li>
                                    <em  style='display: inline;width: 50%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px'>姓名</em>
                                    <em style='display: inline;width: 49.5%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>操作</em>
                                </li>
                            </ul></td>
                    </tr>-->

                    <tr class="ceping">
                        <td class="dce w100 ">指定范围<em class="red">*</em></td>
                        <td id="selsend" colspan="3"><em selectuser>点击选择人员</em></td>
                    </tr>
                    

                    <tr>
                        <td colspan="3" class="red" style="text-align:center"><b>注意：发起测评前请确保上一次测评已经结束。</b></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
                <input type="hidden" name="objid" >
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                    $(".ceping").hide();
            $('input[name="participate"]').click(function () {
                if ($(this).val() == 1) {
                    $(".ceping").hide();
                } else if ($(this).val() == 0){
                    $(".ceping").show();
                } 
            });
//默认添加测评人员隐藏，当点击部分人员时，添加测评人员行显示。  zyx
                            $(".footer button").click(function () {
                                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                                    alert("请填写名称");
                                    $("[name='title']").focus();
                                    return false;
                                }

                                if ($("[name='beginshijian']").val() == undefined || $("[name='beginshijian']").val() == "") {
                                    alert("请填写开始日期");
                                    $("[name='beginshijian']").focus();
                                    return false;
                                }
                                if ($("[name='finishshijian']").val() == undefined || $("[name='finishshijian']").val() == "") {
                                    alert("请填写结束日期");
                                    $("[name='finishshijian']").focus();
                                    return false;
                                }
//zyx  当选择部分人员且未选择人员时弹出。
                            if($("input[name='participate']:checked").val() == "0" ){
                                if ($("#selsend em").length == 1) {
                                    alert("请选择指定测评人员");
                                    return false;
                                }
                            }

                                $(".Wdate").each(function () {
                                    if ($(this).val() != undefined && $(this).val() != "") {
                                        //var timestamp = new Date($(this).val());
                                        var timestamp = new Date($(this).val() + " 23:59:59");
                                        $(this).val(timestamp / 1000);
                                    }
                                })
                            });
//zyx 添加人员
                         $('[selectuser]').click(function () {
                                var t = $(this).parent();
                                RssWin.onwinreceivemsg = function (dict) {
                                    console.log(dict);
                                    $.each(dict, function (k, v) {
                                        if ($("em[myid='" + v.myid + "']").length == "0") {
                                            t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
                                        }
                                    })
                                    $("#selsend i").off("click").click(function () {
                                        $(this).parent().remove();
                                    })
                                }
                                RssWin.open("/selectwin/selectall.jsp", 600, 500);
                            });
                            
                            //ding
                             $("#selsend i").off("click").click(function () {
                                $(this).parent().remove();
                            })
                            $(".footer button").click(function () {
                                var arry = [], str = "";
                                $("#selsend").find("em[myid]").each(function () {
                                    arry.push($(this).attr("myid"));
                                })
                                str = arry.join(",");
                                $("input[name='objid']").val(str)
                            })
                            
        </script>
    </body>
</html>
