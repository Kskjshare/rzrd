<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
    RssList entity = new RssList(pageContext, "disclosure_regulations");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();//添加当前时间到数据库
                entity.append().submit();
                break;
            case "update":
                entity.remove("legislativeId");
                entity.update().where("id=?", entity.get("legislativeId")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();//刷新查询页
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("legislativeId")).get_first_rows();

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
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}#headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }


        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        <% RssListView user = new RssListView(pageContext, "user_delegation");
            user.request();
            if (entity.get("id").isEmpty()) {
                user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
            } else {
                user.select().where("myid=" + entity.get("myid")).get_first_rows();
            }
        %>
        <% RssListView user1 = new RssListView(pageContext, "user_delegation");
            user1.request();
            if (entity.get("id").isEmpty()) {
                user1.select().where("myid=" + cookie.Get("myid")).get_first_rows();
            } else {
                user1.select().where("myid=" + entity.get("myid")).get_first_rows();
            }
        %>

        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">添加公开条例</td>
                    </tr>
                    <tr>
                        <td class="dce w200 ">标题：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <!--                    <tr>
                                            <td class="dce w200 ">提出人：<em class="red">*</em></td>
                                            <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                                        </tr>-->

                    <tr>
                        <td class="dce w200 ">通过时间：<em class="red">*</em></td>
                        <!--<td <% out.print(entity.get("id").isEmpty() ? "id='adminsel'" : "");%> >-->
                        <td><input type="text" class="w200 Wdate" name="passtime"  value='<% entity.write("passtime"); %>' onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                <!--//         <td rssdate="<% out.print(entity.get("passtime")); %>,yyyy-MM-dd" ><input type="text" class="w200 Wdate" name="passtime"  rssdate="<% out.print(entity.get("passtime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>-->
                    </tr>

                    <tr>
                        <td class="dce w200 ">批准时间：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="approvethetime"  value='<% entity.write("approvethetime"); %>' onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                                                <!--<td rssdate="<% out.print(entity.get("approvethetime")); %>,yyyy-MM-dd" ><input type="text" class="w200 Wdate" name="approvethetime"  rssdate="<% out.print(entity.get("approvethetime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>-->

                    </tr>
                    <tr>
                        <td class="dce w200 ">公布时间：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="announcementtime"  value='<% entity.write("announcementtime"); %>' onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                                                <!--<td rssdate="<% out.print(entity.get("announcementtime")); %>,yyyy-MM-dd" ><input type="text" class="w200 Wdate" name="announcementtime"  rssdate="<% out.print(entity.get("announcementtime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>-->

                    </tr>
                    <tr>
                        <td class="dce w200 ">实施时间：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="implementationtime"  value='<% entity.write("implementationtime"); %>' onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                        <!--//                         <td rssdate="<% out.print(entity.get("implementationtime")); %>,yyyy-MM-dd" ><input type="text" class="w200 Wdate" name="implementationtime"  rssdate="<% out.print(entity.get("implementationtime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>-->

                    </tr>
                    <tr>
                        <td class="dce w100 ">条例内容</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
<!--                    <tr>
                        <td class="dce w200 ">上传附件：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="enclosure" value="<% entity.write("enclosure"); %>" /></td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">上传附件：</td>
                        <td colspan="3">
                            <span id="fjfile"><% out.print(entity.get("enclosurename").isEmpty() ? "点击选择文件" : entity.get("enclosurename")); %></span>
                            <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                            <input type="hidden" name="enclosurename" value="<% entity.write("enclosurename"); %>" >
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w200 ">备注信息：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="remarks" value="<% entity.write("remarks"); %>" /></td>
                    </tr>
                    
                    <tr style="display:none">
                        <td class="dce w200 ">登录人id：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="myid" value="<% entity.write("myid"); %>"></td>
                    </tr>

                    <!--                      <tr>
                                           <td class="dce w100 ">信访件编号：<em class="red">*</em></td>
                                           <td><input type="text" maxlength="80" class="b95" name="petition" value="<% entity.write("petition"); %>" /></td>
                                           <td class="dce w100 ">性别：</td>
                                           <td><select class="w250 classify" name="sex" dict-select="sex" def="<% entity.write("sex"); %>"></select></td>
                                       </tr>
                                       <tr>
                                           <td class="dce w100 ">姓名：<em class="red">*</em></td>
                                           <td><input type="text" maxlength="80" class="b95" name="petitioner" value="<% entity.write("petitioner"); %>" /></td>
                                           <td class="dce w100 ">身份证号：</td>
                                           <td><input type="text" maxlength="80" class="b95" name="idcard" value="<% entity.write("idcard"); %>" /></td>
                                       </tr>
                                       <tr>
                                           <td class="dce w100 ">涉及人数：<em class="red">*</em></td>
                                           <td><input type="text" maxlength="80" class="b95" name="numpeinv" value="<% entity.write("numpeinv"); %>" /></td>
                                           <td class="dce w100 ">住址：<em class="red">*</em></td>
                                           <td><input type="text" maxlength="80" class="b95" name="addr" value="<% entity.write("addr"); %>" /></td>
                                       </tr>
                                       <tr>
                                           <td class="dce w100 ">受信人：</td>
                                           <td><input type="text" maxlength="80" class="b95" name="idcard" value="<% entity.write("idcard"); %>" /></td>
                                           <td class="dce w100 ">来信日期：</td>
                                           <td><input type="text" class="w200 Wdate" name="datapetition"  rssdate="<% out.print(entity.get("datapetition")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                                       </tr>
                                       <tr style="display: none;">
                                           <td class="dce w100 ">信访形式：<em class="red">*</em></td>
                                           <td><select class="w250 classify" name="petitionclassify" dict-select="petitionclassify" def="1"></select></td>
                                       </tr>
                                       <tr>
                                           <td class="dce w100 ">信访原因：<em class="red">*</em></td>
                                           <td><select class="w250" name="reapetition" dict-select="reapetitionclassify" def="<% entity.write("reapetition"); %>"></select></td>
                                           <td class="dce w100 ">问题属地：</td>
                                           <td><input type="text" maxlength="80" class="b95" name="problemter" value="<% entity.write("problemter"); %>" /></td>
                                       </tr>
                                       <tr>
                                           <td class="dce w100 ">正文</td>
                                           <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                                       </tr>
                                       <tr>
                                           <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                                       </tr>-->

                </table>

            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
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
                if ($("[name='passtime']").val() == undefined || $("[name='passtime']").val() == "") {
                    alert("请填写通过时间");
                    $("[name='passtime']").focus();
                    return false;
                }
                if ($("[name='approvethetime']").val() == undefined || $("[name='approvethetime']").val() == "") {
                    alert("请填写批准时间");
                    $("[name='approvethetime']").focus();
                    return false;
                }
                if ($("[name='announcementtime']").val() == undefined || $("[name='announcementtime']").val() == "") {
                    alert("请填写公布时间");
                    $("[name='announcementtime']").focus();
                    return false;
                }
                if ($("[name='implementationtime']").val() == undefined || $("[name='implementationtime']").val() == "") {
                    alert("请填写实施时间");
                    $("[name='implementationtime']").focus();
                    return false;
                }
            })


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
                                        if(filename !== null && "" !== filename && data.url !== null && data.url !== ""){
                                            $("#fjfile").text(filename);
                                            $("input[name='enclosure']").val(data.url);
                                            $("input[name='enclosurename']").val(filename);
                                            alert("上传成功");
                                        }else{
                                            $("#fjfile").text("点击选择文件");
//                                            $("input[name='enclosure']").val(data.url);
//                                            $("input[name='enclosurename']").val(filename);
                                            alert("未选择上传文件");
                                        }
                                    }});
                                return false;
                            })


//                            $('.selectuser').click(function () {
//                                var t = $(this).parents("tr").find("ul");
//                                console.log(t)
//                                RssWin.onwinreceivemsg = function (dict) {
//                                    console.log(dict);
//                                    $.each(dict, function (k, v) {
//                                        if ($("em[myid='" + v.myid + "']").length == "0") {
//                                            t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 16%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em><em style='inline block;width: 33%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.telphone + "</em><em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.homeaddress + "</em><em style='display: inline;width: 12%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.code + "</em><em class='red'>删除</em></li>")
//                                            //t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>" + v.realname +"</em><em style='inline block;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.code+"</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.homeaddress+ "</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.telphone+ "</em><em class='red'>删除</em></li>")
//                                            //t.append("<li myid='" + v.myid + "'><em style='margin-left: 10px;'>&nbsp;" + v.realname + "</em><em style='margin-left: 85px;'>&nbsp;"+v.code+"</em><em style='margin-left: 200px;'>&nbsp;"+v.homeaddress+"</em><em style='margin-left: 85px;'>&nbsp;"+v.telphone+"</em><em class='red'>删除</em></li>")
//                                            // t.append("<li style='border: 1px #dce6f5 solid;margin-top: 2px;' myid='" + v.myid + "'>" +v.realname +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.code + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.homeaddress +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.telphone +"<em class='red'>删除</em></li>")
//                                        }
//                                    })
//                                    t.find("em").off("click").click(function () {
//                                        $(this).parent().remove();
//                                    })
//                                }
//                                if (Cookie.Get("powergroupid") == "22") {
//                                    RssWin.open("/selectwin/selectuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>", 700, 650);
//                                } else {
//                                    RssWin.open("/selectwin/selectuser.jsp?mission=<% out.print(user1.get("mission"));%>", 700, 650);
//                                }
//                            });
        </script>

        <script>

            if (Cookie.Get("powergroupid") == "16" || Cookie.Get("powergroupid") == "22" || Cookie.Get("powergroupid") == "8" || Cookie.Get("powergroupid") == "15" || Cookie.Get("powergroupid") == "0") {
                $("#adminsel>input").click(function () {
                    RssWin.onwinreceivemsg = function (dict) {
                        console.log(dict);
                        $("#adminsel>input").val(dict.myname)
                        $("#parentname").text(dict.delegationname)
                        $("#scrid").attr("myid", dict.mission)
                        $("#codenum").text(dict.code)
                        $("#postcode").text(dict.postcode)
                        $("#telphone").text(dict.telphone)
                        $("#homeaddress").text(dict.daibiaoDWaddress)
                        $("[name='myid']").val(dict.myid)
                    }
                    RssWin.open("/selectwin/selectoneuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>&mission=<% out.print(user1.get("mission"));%>", 700, 650);
                })
//            }else if(Cookie.Get("powergroupid") == "22"){
//                $("#adminsel>input").click(function () {
//                    RssWin.onwinreceivemsg = function (dict) {
//                        console.log(dict);
//                        $("#adminsel>input").val(dict.myname)
//                        $("#parentname").text(dict.realname)
//                        $("#codenum").text(dict.code)
//                        $("#postcode").text(dict.postcode)
//                        $("#telphone").text(dict.telphone)
//                        $("#homeaddress").text(dict.homeaddress)
//                        $("[name='myid']").val(dict.myid)
//                    }
//                    RssWin.open("/selectwin/selectuser_1.jsp?myidd=<% out.print(cookie.Get("myid"));%>", 700, 650);
//                })
            }
        </script>
    </body>
</html>
