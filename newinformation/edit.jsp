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
    //推送接口
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    //创建推送的人员范围
    RssList senduser = new RssList(pageContext, "userDeviceid");
    Map<String, String> map = new HashMap<String, String>();
    RssListView duser = new RssListView(pageContext, "lzmessage_newsuser");
    RssList entity2 = new RssList(pageContext, "newinformation");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
//    RssListView entity = new RssListView(pageContext, "newinformation");
    RssList entity = new RssList(pageContext, "newinformation");

    
    RssList notify_messages = new RssList(pageContext, "notify_messages");

    
    entity.request();
    entity2.request();
    if (!entity2.get("action").isEmpty()) {
        switch (entity2.get("action")) {
            case "append":
                entity2.remove("objid");
                entity2.timestamp();
                entity2.keyvalue("objids", entity.get("objid") );   

                entity2.append().submit();

                lzmessage.keyvalue("realid", entity2.autoid);
                lzmessage.keyvalue("classify", entity2.get("infotype"));
                lzmessage.keyvalue("myid", UserList.MyID(request));
                lzmessage.timestamp();
                lzmessage.append().submit();
                
                notify_messages.keyvalue("relationid", entity2.autoid);
                notify_messages.keyvalue("infotype", entity2.get("infotype"));
                notify_messages.keyvalue("myid", UserList.MyID(request));
                
                notify_messages.keyvalue("userid", entity.get("objid") );   
                
                notify_messages.timestamp();
                notify_messages.append().submit();
                
                if (!entity.get("objid").equals(",")) {
                    String[] bb = entity.get("objid").split(",");
                    String type = "";
                    if (entity2.get("infotype").equals("1")) {
                        type = "通知";
                        map.put("key", "4");
                    } else if (entity2.get("infotype").equals("2")) {
                        type = "公告";
                        map.put("key", "5");
                    } else if (entity2.get("infotype").equals("3")) {
                        type = "要闻";
                        map.put("key", "6");
                    } else {
                        type = "法律法规";
                        map.put("key", "7");
                    }
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            read.keyvalue("messageid", lzmessage.autoid);
                            read.keyvalue("objid", bb[i]);
                            read.keyvalue("type", 1);
                            read.append().submit();
                                //推送人员
                            //duser.select().where("objid=?", bb[i]).get_first_rows();
                            //推送的关键,构造一个payload 
                            senduser.pagesize = 10000000;
                            senduser.select().where("myid=" + bb[i] + " and state=1").get_page_desc("id");
                            while (senduser.for_in_rows()) {
                                if (!(senduser.get("deviceid").isEmpty())) {
                                    jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的" + type + "！", "" + type + "通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条" + type + "")).build());
                                }
                            }
                        }
                    }
                }
                break;
            case "update":
                entity2.remove("id,myid");
                entity2.remove("objid");
                entity2.update().where("id=?", entity2.get("id")).submit();
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
            <input type="file" id="filee" accept=".pdf" name="file" multiple>
        </form>
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--  
                    <tr>
                        <td colspan="4" class="institle dce">信息处理</td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce w100 ">标题：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件：</td>
                        <td colspan="3" style="color:blue;font-weight: bold;">
                            <span id="fjfile">
                                <% out.print(entity.get("enclosure").isEmpty() ? "点击选择文件" : entity.get("enclosurename")); %>
                            </span>
                                <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                                <input type="hidden" name="enclosurename" value="<% entity.write("enclosurename"); %>" >
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">缩略图：</td>
                        <td colspan="3 " style="color:blue;font-weight: bold;">
                            <span  id="icofile" >
                                <% out.print(entity.get("ico").isEmpty() ? "点击选择图片" : entity.get("iconame")); %>
                            </span>
                                <input type="hidden" name="ico" value="<% entity.write("ico"); %>" >
                                <input type="hidden" name="iconame" value="<% entity.write("iconame"); %>" >
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">分类：</td>
                        <td><select class="w250" name="infotype" dict-select="infotype" def="<% entity.write("infotype"); %>"></select></td>
                        <td class="dce w100 ">录入日期：<em class="red">*</em></td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ><input type="text" class="w200 Wdate" name="shijian"  rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                        <!--  <td class="dce w100 ">消息类型：</td>
                        <td><select class="w200" name="infotype" dict-select="infotype" def="<% entity.write("infotype"); %>" /></select></td> -->
                    </tr>
                    <tr>
                        <td class="dce w100 ">指定范围：<em class="red">*</em></td>
                        <td id="selsend" colspan="3"><em selectuser>点击选择人员</em></td>
                    </tr>
                    
                    <!--
                    <tr>
                        <td class="dce w100 ">外部链接：</td>
                        <td colspan="3"><input type="text" class="b95" name="links" value="<% entity.write("links"); %>" /></td>
                    </tr>
                    -->
                    
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:500" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> </td>
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
                                if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
                                    alert("请填写内容");
                                    $("[name='matter']").focus();
                                    return false;
                                }
//                                alert($("#selsend em").length)
                                if ($("#selsend em").length == 1) {
                                    alert("请选择指定推送人员");
                                    return false;
                                }
                            })

                            $("#fjfile").click(function () {
                                $("#filee").click();
                            })
                            $("#icofile").click(function () {
                                $("#fileico").click();
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
                                    if (data.url !== null && "" !== data.url) {
                                        $("#fjfile").text(filename)
                                        $("input[name='enclosure']").val(data.url);
                                        $("input[name='enclosurename']").val(filename);
                                        alert("上传成功");
                                        } else {
                                        $("#fjfile").text("点击选择文件");
                                         alert("未上传");
                                        }
                                    }});
                                return false;
                            })
                            $("#fileico").change(function () {
                                var str = $(this).val(); //开始获取图片名
                                var filename = str.substring(str.lastIndexOf("\\") + 1);
                                $("#fileicoform").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                    if (data.url !== null && "" !== data.url) {
                                        $("#icofile").text(filename)
                                        $("input[name='ico']").val(data.url);
                                        $("input[name='iconame']").val(filename);
                                        alert("上传成功");
                                    } else {
                                       $("#icofile").text("点击选择图片") 
                                        alert("未上传");
                                    }
                                    }});
                                return false;
                            })
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
