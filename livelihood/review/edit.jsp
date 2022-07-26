<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
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
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    //创建推送的人员范围
//    Collection<String> arry = new ArrayList<String>();
    RssList senduser = new RssList(pageContext, "userDeviceid");
    Map<String,String> map=new HashMap<String,String>();
    map.put("key", "9");
    RssListView entity = new RssListView(pageContext, "lecture");
    RssListView entity3 = new RssListView(pageContext, "lecture");
    RssList entity2 = new RssList(pageContext, "lecture");
    RssList read = new RssList(pageContext, "lectureobj");
    entity.request();
    entity2.request();
//    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity2.remove("objid").remove("action");
                entity2.timestamp();
                entity2.append().submit();
                if (!entity.get("objid").equals(",")) {
                    String[] bb = entity.get("objid").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            read.keyvalue("lectureid", entity2.autoid);
                            read.keyvalue("objid", bb[i]);
                            read.append().submit();
                            senduser.pagesize = 10000000;
                            senduser.select().where("myid=" + bb[i] + " and state=1").get_page_desc("id");
                            while (senduser.for_in_rows()) {
                                if (!(senduser.get("deviceid").isEmpty())) {
                                jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的专题讲座！","专题讲座",map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条专题讲座")).build());
                                }
                            }
                        }
                    }
                }
                break;
            case "update":
                entity2.remove("id").remove("myid").remove("objid");
                entity2.update().where("id=?", entity.get("id")).submit();
                read.delete().where("lectureid=?", entity.get("id")).submit();
                if (!entity.get("objid").equals(",")) {
                    String[] bb = entity.get("objid").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            read.keyvalue("lectureid", entity.get("id"));
                            read.keyvalue("objid", bb[i]);
                            read.append().submit();
                            senduser.pagesize = 10000000;
                            senduser.select().where("myid=" + bb[i] + " and state=1").get_page_desc("id");
                            while (senduser.for_in_rows()) {
                                if (!(senduser.get("deviceid").isEmpty())) {
                                jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的专题讲座！","专题讲座",map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条专题讲座")).build());
                                }
                            }
                        }
                    }
                }
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
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 soild thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/

            #matter{line-height: 12px;}
            .w630{width:99%;}
            .b95{width:99%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileeform2{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept=".pdf" name="file" multiple>
        </form>    
        <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">信息处理</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w630" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">专家名：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w200" name="zjname" value="<% entity.write("zjname"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件：</td>
                        <td><span id="fjfile"><% out.print(entity.get("enclosure").isEmpty() ? "点击选择文件" : entity.get("enclosure")); %></span><input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" ></td>
                        <td class="dce w100 ">开始时间：</td>
                        <td><input type="text" class="w200 Wdate" name="joinshijian"  rssdate="<% out.print(entity.get("joinshijian")); %>,yyyy-MM-dd HH:mm:ss"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">上传视频：</td>
                        <td colspan="3"><span id="fjfile2" rid="2"><% out.print(entity.get("videosrc").isEmpty() ? "点击选择文件" :entity.get("videosrc")); %></span><input type="hidden" name="videosrc" value="<% out.print(entity.get("videosrc")); %>" ></td>
                    <tr>
                        <td class="dce w100 ">形式：</td>
                        <td><select class="w206" name="classify" dict-select="lectureclassify" def="<% entity.write("classify"); %>"></select></td>
                        <td class="dce w100 ">分类：</td>
                        <td><select class="w206" name="type" dict-select="lecturetype" def="<% entity.write("type"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">指定范围：</td>
                        <td id="selsend" colspan="3"><em selectuser>点击选择人员</em>
                            <%
                                entity3.select().where("id=?", entity.get("id")).query();
                                while (entity3.for_in_rows()) {
                            %>
                            <em myid='<% out.print(entity3.get("objid"));%>'><% out.print(entity3.get("objstate").equals("2") || entity3.get("objstate").equals("5") ? entity3.get("objrealname") : entity3.get("objallname"));%><i>×</i></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">外部链接：</td>
                        <td colspan="3"><input type="text" class="b95" name="links" value="<% entity.write("links"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
                <input type="hidden" name="objid" >
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

                            $(".footer button").click(function () {
                                if ($("[name='joinshijian']").val() != undefined && $("[name='joinshijian']").val() != "") {
                                    var timestamp = new Date($("[name='joinshijian']").val());
                                    $("[name='joinshijian']").val(timestamp / 1000);
                                }
                                var arry = [], str = "";
                                arry.push($("[name='myid']").val());
                                $("#selsend").find("em[myid]").each(function () {
                                    if (arry.indexOf($(this).attr("myid")) == "-1") {
                                        arry.push($(this).attr("myid"));
                                    } else {
                                    }
                                })
                                str = arry.join(",");
                                $("input[name='objid']").val(str)
                            })
                            $("#fjfile").click(function () {
                                $("#filee").click();
                            })
                            $("#fjfile2").click(function () {
                                $("#file2").click();
                            })
                            $("#filee").change(function () {
                                $("#fileeform").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        $("#fjfile").text(data.url)
                                        $("input[name='enclosure']").val(data.url);
                                        alert("上传成功");
                                    }});
                                return false;
                            })
                            $("#file2").change(function () {
                                $("#fileeform2").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        $("#fjfile2").text(data.url)
                                        $("input[name='videosrc']").val(data.url);
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
                                            t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
                                        }
                                    })
                                    $("#selsend i").off("click").click(function () {
                                        $(this).parent().remove();
                                    })
                                }
                                RssWin.open("/selectwin/selectall.jsp", 600, 500);
                            });


        </script>
    </body>
</html>
