<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
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

<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    //推送接口
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    
    RssList senduser = new RssList(pageContext, "userDeviceid");
    Map<String, String> map = new HashMap<String, String>();
    map.put("key", "1");
    RssList entity2 = new RssList(pageContext, "activities");
    RssList user = new RssList(pageContext, "activities_userlist");
    RssListView entity = new RssListView(pageContext, "activities");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    entity2.request();
    
    
    //新建的通知表
     RssList notify_messages = new RssList(pageContext, "notify_messages");
//     RssList activities_readstate = new RssList(pageContext, "activities_readstate");
    
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    RssList entity3 = new RssList(pageContext, "newinformation");
//    RssListView newinformation = new RssListView(pageContext, "newinformation");

    
//     RssList activity_department = new RssList(pageContext, "activity_department");
//     activity_department.request();
//     activity_department.select().where("myid=" + entity2.get("department")).get_first_rows();
     
    //获取用户名字
    RssList userlist = new RssList(pageContext, "user");
    userlist.request();
    userlist.select().where("myid=" + UserList.MyID(request) ).get_first_rows();

    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                
                //加到通知列表
                entity3.remove("username");
                entity2.remove("username");
                entity.remove("username");


                
                if ( entity2.get("notice").isEmpty()  )
                entity3.keyvalue("title", entity2.get("title") );
                else
                entity3.keyvalue("title", entity2.get("notice") );
                
                entity3.keyvalue("matter", entity2.get("note") );   
                entity3.keyvalue("infotype",  1 );
                entity3.keyvalue("realname",userlist.get("realname"));

                entity3.keyvalue("myid", UserList.MyID(request));
                entity3.timestamp();
                entity3.append().submit();
                
                lzmessage.keyvalue("realid", entity3.autoid);
                //lzmessage.keyvalue("classify", entity2.get("infotype"));
                lzmessage.keyvalue("classify", 1);
                lzmessage.keyvalue("myid", UserList.MyID(request));
                lzmessage.timestamp();
                lzmessage.append().submit();              
                if (!entity2.get("userid").equals(",")) {
                    String[] bb = entity.get("objid").split(",");
                     for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            read.keyvalue("messageid", lzmessage.autoid);
                            read.keyvalue("objid", bb[i]);
                            read.keyvalue("type", 1);
                            read.append().submit();
                        }
                    }
                  }
                //加到通知列表 结束
                
                
                
                
                entity2.timestamp();
//                entity2.remove("userid");
                //处理单位名称，不是好的方案
                entity2.remove("department");
                if ( entity2.get("department").equals("1")) {
                    entity2.keyvalue("department","办公室");
                }
                else if ( entity2.get("department").equals("2")) {
                    entity2.keyvalue("department","法制工作委员会");
                }
                else if ( entity2.get("department").equals("3")) {
                    entity2.keyvalue("department","财政经济工作委员会");
                }
                else if ( entity2.get("department").equals("4")) {
                    entity2.keyvalue("department","农村工作委员会");
                }
                else if ( entity2.get("department").equals("5")) {
                    entity2.keyvalue("department","教育科学文化卫生工作委员会");
                }
                else if ( entity2.get("department").equals("6")) {
                    entity2.keyvalue("department","选举任免代表联络工作委员会");
                }
                else if ( entity2.get("department").equals("7")) {
                    entity2.keyvalue("department","信访办公室");
                }
                else if ( entity2.get("department").equals("8")) {
                    entity2.keyvalue("department","调研室");
                }
                else if ( entity2.get("department").equals("9")) {
                    entity2.keyvalue("department","环境与资源保护工作委员会");
                }
                else if ( entity2.get("department").equals("10")) {
                    entity2.keyvalue("department","代表联络科");
                }
                else if ( entity2.get("department").equals("11")) {
                    entity2.keyvalue("department","法制委员会");
                }
                else if ( entity2.get("department").equals("12")) {
                    entity2.keyvalue("department","财政经济预算委员会");
                }
                 else if ( entity2.get("department").equals("13")) {
                    entity2.keyvalue("department","社会建设委员会");
                }
                entity2.keyvalue("realname",userlist.get("realname"));

                entity2.append().submit();
                break;
            case "update":
                entity2.remove("userid");
                entity2.remove("username");

                entity2.update().where("id=" + entity2.get("id")).submit();
                user.delete().where("activitiesid=" + entity2.get("id") + "").submit();
                break;
        }
        
        
        int enroll = 1 ; //自愿报名
        String str = entity2.get("userid");
        String[] arry = str.split(",");
        
        String str_name = entity2.get("username");
        String[] arry_name = str_name.split(",");
        for (int i = 0; i < arry.length; i++) {
            if (!arry[i].isEmpty()) {
                enroll = 2 ;
                user.timestamp();
                user.keyvalue("activitiesid", entity2.autoid);
                user.keyvalue("userid", arry[i]);
                user.keyvalue("myid", entity2.get("myid"));
//                user.keyvalue("enroll", 2 ); //这理导致报internal error 暂时注释掉
                user.keyvalue("realname",userlist.get("realname"));

                //写报名名字
                user.keyvalue("enrollname", arry_name[i] );
                user.keyvalue("enroll", enroll );
                user.keyvalue("jointype", 2 );


                user.append().submit();
                
                //把活动添加到新建通知表
                notify_messages.timestamp();
                notify_messages.keyvalue("title", entity.get("title"));
                
                if ( entity.get("notice").isEmpty() )
                    notify_messages.keyvalue("matter", entity.get("note"));
 
                else
                   notify_messages.keyvalue("matter", entity.get("notice"));

                notify_messages.keyvalue("myid", entity2.get("myid"));
                notify_messages.keyvalue("relationid", entity2.autoid);
                notify_messages.keyvalue("infotype",  16 );
                notify_messages.keyvalue("userid", arry[i] );
                notify_messages.keyvalue("enroll", 1 );
                notify_messages.append().submit();
                
                
                
                
                senduser.pagesize = 10000000;
                senduser.select().where("myid=" + arry[i] + " and state=1").get_page_desc("id");
                while (senduser.for_in_rows()) {
                    if (!(senduser.get("deviceid").isEmpty())) {
                        jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的活动！", "活动通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条活动")).build());
                    }
                }
            }
        }
        
        if ( enroll == 1 ) {
            //如果是自愿报名把活动添加到新建通知表（给履职我的活动）
            notify_messages.timestamp();
            notify_messages.keyvalue("title", entity.get("title"));
            notify_messages.keyvalue("matter", entity2.get("matter"));
            notify_messages.keyvalue("myid", entity2.get("myid"));
            notify_messages.keyvalue("relationid", entity2.autoid);
            notify_messages.keyvalue("infotype",  16 );          
            notify_messages.keyvalue("enroll", 1 );
            notify_messages.keyvalue("endshijian", entity2.get("endshijian"));

            notify_messages.append().submit();
            
            //专门给通知用(这里把newinformation关联的id记录加进来。如果不注释，那么会重复添加）
//            notify_messages.timestamp();
//            notify_messages.keyvalue("title", entity.get("title"));
//            notify_messages.keyvalue("matter", entity2.get("matter"));
//            notify_messages.keyvalue("myid", entity2.get("myid"));
//            notify_messages.keyvalue("relationid", entity3.autoid);
//            notify_messages.keyvalue("infotype",  1 );          
//            notify_messages.keyvalue("enroll", 1 );
//            notify_messages.keyvalue("endshijian", entity2.get("endshijian"));
//
//            notify_messages.append().submit();
            
      
            
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
            .cellbor select{width: 256px;height: 32px;font-size:15px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor input{height: 24px; width: 89%; border: #d0d0d0 solid thin;}
            .cellbor select{ width: 91.2%; }
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                     <%
                        RssListView user2 = new RssListView(pageContext, "user_delegation");
                        user2.request();
                        user2.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                    <tr>
                        <td class="dce" style="width:110px;">报名类型</td>
                        <td >
                           <input id="ziyuan" style="width:55px;height:16px;" name="enroll"  type="radio" value="1">自愿报名
                           <input id="qiangzhi" style="width:55px;height:16px;"  name="enroll"  type="radio" value="2" checked="checked">指定报名
                        </td>
                    </tr>
                    <tr class="baoming">
                        <td class="dce w100 ">报名人数</td>
                        <td><input  type="number"  class="w250" name="maxperson" value="<% entity.write("maxperson"); %>" /></td>
                    </tr>
                    
                     <tr>
                        <td class="dce" style="width:110px;">活动类型</td>
                        <td><select class="w250" name="classify" dict-select="activitiestypeclassify" def="<% entity.write("classify"); %>"></select></td>
                    </tr>
                    
                      <tr>
                        <td class="dce" style="width:110px;">组织部门</td>
                        <!--<td><input type="text" maxlength="80" class="w250" name="department" value="<% user2.write("realname"); %>" /></td>-->
                        <td><select class="w250" name="department" dict-select="activitiesdepartment" def="<% entity.write("department"); %>"></select></td>
                    </tr>
                    
                    <tr>
                        <td class="dce" style="width:110px;">活动标题</td>
                        <td><input type="text" maxlength="80" class="w250" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    
<!--                    <tr>
                        <td class="dce w100 ">通知内容</td>
                        <td><input type="text" maxlength="80" class="w250" name="notice" value="<% entity.write("notice"); %>" /></td>
                    </tr>-->
                   
                  
<!--                    <tr class="jiezhi">
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td><input type="text" class="w200 Wdate" name="endshijian"  rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>-->
                    <tr>
                        <td class="dce" style="width:110px;">开始时间</td>
                        <td><input type="text" class="w200 Wdate" name="beginshijian"  rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="dce" style="width:110px;">结束时间</td>
                        <td><input type="text" class="w200 Wdate" name="finishshijian"  rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
<!--                    <tr>
                        <td class="dce" style="width:110px;">活动地点</td>
                        <td><input type="text" maxlength="80" class="w250" name="place" value="<% entity.write("place"); %>" /></td>
                    </tr>-->
                    <tr class="canyu">
                        <td class="dce" style="width:110px;">添加参与人</td>
                        <td id="selsend"><em selectuser>点击选择参与人</em>
                          
                        </td>
                           <% RssListView user1 = new RssListView(pageContext, "user_delegation");
                            user1.request();
                            if (entity.get("id").isEmpty()) {
                                user1.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                            } else {
                                user1.select().where("myid=" + entity.get("myid")).get_first_rows();
                            }
                        %>
                    </tr>
                    <tr>
                        <td class="dce  left"style="width:110px;"><span>活动安排</span></td>
                        <td ><textarea class="w250" name="note"><% entity.write("note"); %></textarea></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" id="rid" name="userid" value="">
                <input type="hidden" id="enrollname" name="username" value="<% entity.write("username"); %>">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "确定" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <script>
                    $(".jiezhi").hide();
                    $(".baoming").hide();   
             $('input[name="enroll"]').click(function () {
                if ($(this).val() == 1) {
                    $(".jiezhi").show();
                    $(".baoming").show();
                    $(".canyu").hide();
                } else if ($(this).val() == 2){
                    $(".jiezhi").hide();
                    $(".baoming").hide();
                    $(".canyu").show();
                } 
            });
            
            
            var enrollname ="";
            $('[selectuser]').click(function () {
                                var t = $(this).parent();
                                RssWin.onwinreceivemsg = function (dict) {
//                                    console.log(dict);
                                    var cnt = 0 ;
                                    $.each(dict, function (k, v) {
                                        if ($("em[myid='" + v.myid + "']").length == "0") {
                                            t.append("<em myid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                                            if ( cnt > 0 ) {
                                             enrollname += ",";   
                                            }
                                             enrollname += v.realname;
                                             
                                             
//                                           t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
                                        }
                                        $("#enrollname").val( enrollname);                                    

                                    })
                                    $("#selsend i").off("click").click(function () {
                                        $(this).parent().remove();
                                    })
                                }
                                var coo =<%=cookie.Get("powergroupid")%>;
                                if (coo == "22") {
                                    RssWin.open("/activities/selectuser_2.jsp?mission=<%=cookie.Get("myid")%>", 570, 650);
                                } else {
                                    RssWin.open("/activities/selectuser_2.jsp?mission=<%=user1.get("mission")%>", 570, 650);
                                }
                            });
//                            $("#selsend i").off("click").click(function () {
//                                $(this).parent().remove();
//                            })
                            
                            $("#selsend i").off("click").click(function () {
                                $(this).parent().remove();
                            })
                            $(".footer button").click(function () {
                                var arry = [];
                                var arry_name = [];
                                $("#selsend>em[myid]").each(function () {
                                    arry.push($(this).attr("myid"))
                                    arry_name.push($(this).attr("realname"))
                                    
                                })
                                
                                var str = arry.join(",");
                                $("#rid").val(str);
                                $("#enrollname").val(enrollname);


                                
//                                $("input[name='userid']").val(str)
                                if($("input[name='enroll']:checked").val() == "1" ){
                                if ($("[name='maxperson']").val() == undefined || $("[name='maxperson']").val() == "") {
                                    alert("请填写报名人数");
                                    $("[name='maxperson']").focus();
                                    return false;
                                }
                                }
                                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                                    alert("请填写活动标题");
                                    $("[name='title']").focus();
                                    return false;
                                }
                                if ($("[name='department']").val() == undefined || $("[name='department']").val() == "") {
                                    alert("请填写组织部门");
                                    $("[name='department']").focus();
                                    return false;
                                }
//                            if($("input[name='enroll']:checked").val() == "1" ){
//                                if ($("[name='endshijian']").val() == undefined || $("[name='endshijian']").val() == "") {
//                                    alert("请填写报名截止日期");
//                                    $("[name='endshijian']").focus();
//                                    return false;
//                                }
//                                }
//                                if ($("[name='beginshijian']").val() == undefined || $("[name='beginshijian']").val() == "") {
//                                    alert("请填写开始日期");
//                                    $("[name='beginshijian']").focus();
//                                    return false;
//                                }
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
                                //zyx  
                                if($("input[name='enroll']:checked").val() == "2" ){
                                if ($("#selsend em").length == 1) {
                                    alert("请选择参与人");
                                    return false;
                                }
                            }
                                if ($("[name='note']").val() == undefined || $("[name='note']").val() == "") {
                                    alert("请填写活动安排");
                                    $("[name='note']").focus();
                                    return false;
                                }
                                  var aa = 0;
                                $(".Wdate").each(function () {
                                    if ($(this).val() != undefined && $(this).val() != "") {
                                        aa++;
                                        var timestamp = "";
                                        if (aa == 2) {
                                            timestamp = new Date($(this).val() + " 00:00:00");
                                             //timestamp = new Date($(this).val() );
                                        } else {
                                            timestamp = new Date($(this).val() + " 23:59:59");
                                            //timestamp = new Date($(this).val() );
                                        }
                                        $(this).val(timestamp / 1000);
                                    }
                                })
                                //zyx end
                               
//                                if ($("[name='place']").val() == undefined || $("[name='place']").val() == "") {
//                                    alert("请填写开始日期");
//                                    $("[name='place']").focus();
//                                    return false;
//                                }
                           
                            })      
                                                  
        </script>
    </body>
</html>
