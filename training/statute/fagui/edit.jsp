<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Options"%>
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
    RssList senduser = new RssList(pageContext, "userDeviceid");
    Map<String, String> map = new HashMap<String, String>();
    map.put("key", "8");
    RssListView entity = new RssListView(pageContext, "statute");
    RssListView entity3 = new RssListView(pageContext, "statute");
    RssList entity2 = new RssList(pageContext, "statute");
    RssList read = new RssList(pageContext, "statuteobj");
    entity.request();
    entity2.request();
//    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity2.remove("objid").remove("action");
                entity2.timestamp();
                entity2.keyvalue("classify", 3 );

                entity2.append().submit();
                if (!entity.get("objid").equals(",")) {
                    String[] bb = entity.get("objid").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            read.keyvalue("courid", entity2.autoid);
                            read.keyvalue("objid", bb[i]);
                            read.append().submit();
                            senduser.pagesize = 10000000;
                            senduser.select().where("myid=" + bb[i] + " and state=1").get_page_desc("id");
                            while (senduser.for_in_rows()) {
                                if (!(senduser.get("deviceid").isEmpty())) {
                                    jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的学习课件！", "学习课件", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条学习课件")).build());
                                }
                            }
                        }
                    }
                }
                break;
            case "update":
                entity2.remove("id,myid");
                entity2.remove("objid");
                read.delete().where("id=?", entity.get("id")).submit();
                if (!entity.get("objid").equals(",")) {
                    String[] bb = entity.get("objid").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            read.keyvalue("courid", entity2.autoid);
                            read.keyvalue("objid", bb[i]);
                            read.append().submit();
                            senduser.pagesize = 10000000;
                            senduser.select().where("myid=" + bb[i] + " and state=1").get_page_desc("id");
                            while (senduser.for_in_rows()) {
                                if (!(senduser.get("deviceid").isEmpty())) {
                                    jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的学习课件！", "学习课件", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条学习课件")).build());
                                }
                            }
                        }
                    }
                }
                entity2.update().where("id=?", entity.get("id")).submit();
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
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5;}
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
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
<!--                    <tr>
                        <td colspan="4" class="institle dce">信息处理</td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w630" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件</td>
                        <td>
                            <span id="fjfile">
                              
                                <%
                                    if (entity.get("enclosure") == "") {
                                    %>
                                    点击选择文件
                                    <%
                                    }else{
                                    %>
                                    <% entity.write("enclosurename"); %>
                                    <%
                                    };
                                    %>
                            </span>
                            <input type="hidden" name="enclosurename" value="<% entity.write("enclosurename"); %>" >

                            <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >

                        </td>

                        <!--
                        <td class="dce w100 ">参加时间</td>
                        <td><input type="text" class="w200 Wdate" name="joinshijian"  rssdate="<% out.print(entity.get("joinshijian")); %>,yyyy-MM-dd HH:mm:ss"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"></td>
                        -->
                        </tr>
                    <tr>
                        <td class="dce w100 ">上传视频</td>
                        <td colspan="3"><span id="fjfile2" rid="2"><% out.print(entity.get("videosrc").isEmpty() ? "点击选择视频" : entity.get("videosrc")); %></span><input type="hidden" name="videosrc" value="<% out.print(entity.get("videosrc")); %>" ></td>
                    </tr>
                    
                    <tr>
                        <td class="dce w100 ">参加时间</td>
                        <td><input type="text" class="b95" name="joinshijian"  rssdate="<% out.print(entity.get("joinshijian")); %>,yyyy-MM-dd HH:mm:ss"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"></td> 
                    </tr>
                    <tr>
                        <td class="dce w100 ">指定范围</td>
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
                        <td class="dce w100 ">外部链接</td>
                        <td colspan="3"><input type="text" class="b95" name="links" value="<% entity.write("links"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    
                    <tr> 
                        <td class="marginauto uetd" colspan="4" style="width:100%;"> <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
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
        <!-- <div class="progress" id="progressHide">
             <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" id="progressBar">
                 <span class="sr-only">40% 完成</span>
             </div>
         </div> -->
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

            $(".footer button").click(function () {
                
                
                 if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                } 
                
                
                if ($("[name='joinshijian']").val() != undefined && $("[name='joinshijian']").val() != "") {
                    var timestamp = new Date($("[name='joinshijian']").val());
                    $("[name='joinshijian']").val(timestamp / 1000);
                }
                else {
                     alert("请填写参加时间");
                   $("[name='joinshijian']").focus();
                   
                   //
                    $("[name='joinshijian']").val("");
                   return false;
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
                var str = $(this).val(); //开始获取文件名
                var filename = str.substring(str.lastIndexOf("\\") + 1);
                
                $("#fileeform").ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        //$("#fjfile").text(data.url)      
                        
                        $("input[name='enclosure']").val( data.url );
                        $("input[name='enclosurename']").val( filename );
                        $("#fjfile").text( filename )  ;   
                        alert("上传成功");
                    }});
                return false;
            })
            $("#file2").change(function () {
                var xhr = $("#fileeform2").ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#fjfile2").text(data.url)
                        $("input[name='videosrc']").val(data.url);
                        alert("上传成功");
                    },
//                                    xhr: function () {
//                                        var xhr = $.ajaxSettings.xhr();
//                                        if (onprogress && xhr.upload) {
//                                            xhr.upload.addEventListener("progress", onprogress, false);
//                                            return xhr;
//                                        }
//                                    }
                                });
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
//                            function onprogress(evt) {
//                                var loaded = evt.loaded;
//                                var tot = evt.total;
//                                var per = Math.floor(100 * loaded / tot);  //已经上传的百分比
//                                var son = document.getElementById('progressBar');
//                                son.innerHTML = per + "%";
//                                son.style.width = per + "%";
//                            }


        </script>
    </body>
</html>
