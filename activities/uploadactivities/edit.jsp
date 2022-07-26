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
    
    Map<String, String> map = new HashMap<String, String>();
    map.put("key", "1");
    RssList entity2 = new RssList(pageContext, "activities");
    RssList activities_userlist = new RssList(pageContext, "activities_userlist");
    RssListView entity = new RssListView(pageContext, "activities");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    entity2.request();
    
    
    //新建的通知表
//     RssList notify_messages = new RssList(pageContext, "notify_messages");
//     RssList activities_readstate = new RssList(pageContext, "activities_readstate");
    
//    RssList read = new RssList(pageContext, "lzmessage_read");
//    RssList lzmessage = new RssList(pageContext, "lzmessage");
//    RssList entity_newinformation = new RssList(pageContext, "newinformation");
//    RssListView newinformation = new RssListView(pageContext, "newinformation");

    
//     RssList activity_department = new RssList(pageContext, "activity_department");
//     activity_department.request();
//     activity_department.select().where("myid=" + entity2.get("department")).get_first_rows();
     
    //获取用户名字
    RssList userlist = new RssList(pageContext, "user");
    userlist.request();
    userlist.select().where("myid=" + UserList.MyID(request) ).get_first_rows();
    
    //String  isdelegate = userlist.get("isdelegate");
    int isdelegate = Integer.parseInt( userlist.get("isdelegate") );
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
             case "append1":
                 break;
            case "append":

                if ( isdelegate == 1 ) { //是代表才可以添加
                entity2.timestamp();               
                entity2.keyvalue("realname",userlist.get("realname"));
                
                entity2.keyvalue("private",1 );
                entity2.keyvalue("enroll", 3 );
                entity2.keyvalue("myid", UserList.MyID(request) );           
                entity2.append().submit();
                }
                else {
                            out.print("<script>alert('您没有权限！');</script>");

                }
                
               
                break;
            case "update":
                entity2.remove("userid");
                entity2.remove("username");

                entity2.update().where("id=" + entity2.get("id")).submit();
                activities_userlist.delete().where("activitiesid=" + entity2.get("id") + "").submit();
                break;
        }
        
    if ( isdelegate == 1 ) { //是代表才可以添加    
        String str = entity2.get("userid");
        //下面两句把发起者的myid连接在参与者的后面
        str += ",";
        str += UserList.MyID(request);
        
        String[] arry = str.split(",");
        
        
        String str_name = entity2.get("username");
        
        //下面两句把发起者的名字连接在参与者的后面
        str_name += ",";
        str_name += userlist.get("realname");
        
        
        //更新数据，把myid和username重新写入
        entity2.remove("userid");
        entity2.remove("username"); 
        entity2.keyvalue("username", str_name );
        entity2.keyvalue("userid", str );
        entity2.update().where("id=" + entity2.autoid + "" ).submit();
          
        
        String[] arry_name = str_name.split(",");
        for (int i = 0; i < arry.length; i++) {
            if (!arry[i].isEmpty()) {
                activities_userlist.timestamp();
                activities_userlist.keyvalue("activitiesid", entity2.autoid);
                activities_userlist.keyvalue("userid", arry[i]);
                activities_userlist.keyvalue("myid", entity2.get("myid"));
//                user.keyvalue("enroll", 2 ); //这理导致报internal error 暂时注释掉
                activities_userlist.keyvalue("realname",userlist.get("realname"));

                //写报名名字
                activities_userlist.keyvalue("enrollname", arry_name[i] );
                //user.keyvalue("enroll", enroll );
                activities_userlist.keyvalue("jointype", 2 );
                activities_userlist.keyvalue("attendancetype", 2 );
                activities_userlist.keyvalue("enroll", 3 );


                activities_userlist.append().submit();
                       
               
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
            
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
            #abc{display:none;}
            .bulletin{display: none;}
            
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        <form id="abc" enctype="multipart/form-data" method="post">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form> 
        
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                     <%
                        RssListView user2 = new RssListView(pageContext, "user_delegation");
                        user2.request();
                        user2.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                   
                     <tr>
                        <td class="dce" style="width:110px;">履职标题</td>
                        <td><input type="text" maxlength="80" class="w250" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    
                     <tr>
                        <td class="dce" style="width:110px;">履职主题</td>
                        <td><select class="w250" name="classify" dict-select="activitiestypeclassify" def="<% entity.write("classify"); %>"></select></td>
                    </tr>
                    
                    <tr>
                        <td class="dce" style="width:120px;">履职地点</td>
                        <td><input type="text" maxlength="80" class="w250" name="place" value="<% entity.write("place"); %>" /></td>
                    </tr>
                  
                  
                   
                    <tr class="dce beginshijian">
                        <td class="dce startimeCaption" style="width:110px;">履职时间</td>
                        <td><input type="text" class="w200 Wdate" name="beginshijian"  rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    
                    <tr class="dce finishshijian" style="display:none" >
                        <td class="dce endtimeCaption" style="width:110px; ">结束时间</td>
                        <td><input type="text" class="w200 Wdate" name="finishshijian"  rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    
                   
                    
                    
                    <tr>
                       <td class="dce w100 ">履职附件</td>
                        <td colspan="3">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">
                                    <%
                                    if (entity.get("enclosure") == "") {
                                    %>
                                    点击选择方案文件
                                    <%
                                    }else{
                                    %>
                                    <% entity.write("enclosurename"); %>
                                    <%
                                    };
                                    %>
                                </span>
                                <input type="hidden" name="enclosure" id="enclosure" value="<% entity.write("enclosure"); %>" >
                                <input type="hidden" name="enclosurename" id="enclosurename" value="<% entity.write("enclosurename"); %>" >
                            </div>
                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden"id="enclosure3" ></div>
                        </td>
                     </tr>
                    
                    
                    
                    
                    <tr class="canyu">
                        <td class="dce" style="width:110px;">履职代表</td>
                        <td id="selsend"><em selectuser>履职代表</em>
                          
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
                        <td class="dce  left" style="width:110px;"><span>履职内容</span></td>
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
            var enrollname ="";
            var userid = "" ;
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
                                userid += ",";       
                            }
                            enrollname += v.realname ;
                            userid += v.myid ;
                            cnt ++ ;
                            
                            
                            //enrollname += ",";   
                            //userid += ",";   

                            //t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
                        }
                        $("#enrollname").val( enrollname);   
                        $("#rid").val( userid);   

                    })
                    
//                    if ( cnt > 0 ) {
//                        enrollname += "," ;
//                        enrollname += userlist.get("realname");
//                        
//                        userid += "," ;
//                        userid += UserList.MyID(request);
//                    }
//                    else {
//                        userid = UserList.MyID(request);
//                    }
//                    $("#enrollname").val( enrollname);   
//                    $("#rid").val( userid);                    
                                    

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
                                //alert(enrollname)
                                //alert( userid )
                                var str = arry.join(",");
                                //$("#rid").val(str);
                               // $("#enrollname").val( enrollname );
                               // $("#rid").val( userid );

                                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                                    alert("请填写履职标题");
                                    $("[name='title']").focus();
                                    return false;
                                }
 
                            
        
                                
                                //履职时间
                                if ($("[name='beginshijian']").val() != undefined && $("[name='beginshijian']").val() != "") {
                                    var timestamp = new Date($("[name='beginshijian']").val());
                                    $("[name='beginshijian']").val( timestamp / 1000 );
                                    $("[name='finishshijian']").val( timestamp / 1000 );
                                }
                                else {
                                    alert("请添履职时间");
                                    $("[name='beginshijian']").focus();
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
                                    alert("请填写履职内容");
                                    $("[name='note']").focus();
                                    return false;
                                }
                                
//                                var aa = 0;
//                                $(".Wdate").each(function () {
//                                    if ($(this).val() != undefined && $(this).val() != "") {
//                                        aa++;
//                                        var timestamp = "";
//                                        if (aa == 2) {
//                                            timestamp = new Date($(this).val() + " 00:00:00");
//                                             //timestamp = new Date($(this).val() );
//                                        } else {
//                                            
//                                            timestamp = new Date($(this).val() + " 23:59:59");
//                                            //timestamp = new Date($(this).val() );
//                                        }
//                                        $(this).val(timestamp / 1000);
//                                    }
//                                })
                                //zyx end
                           
                            })      
                            
                            
                            
                            
            $("#fjfile").click(function () {
                $("#filee").click();
            })
            $("#icofile").click(function () {
                $("#fileico").click();
            }) 
            $('#pbut').click(function () {
                $("#submit").click();
            })
            $("#selbut").click(function () {
                $("#file").click();
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
                       // let text = "上传成功";
                       // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    }});
                return false;
            })            
                                                  
        </script>
    </body>
</html>
