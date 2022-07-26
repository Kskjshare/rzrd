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
    RssList entity = new RssList(pageContext, "backups");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
//                entity.remove("title");
//                entity.get("title");
//                entity.clear("title");
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid","objid");
                entity.update().where("id=?", entity.get("relationid")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("relationid")).get_first_rows();
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
            .dce{background: #dce6f5;text-align: left}
            .cellbor td:nth-child(2n+1){padding: 0 6px}
            /* .cellbor td:last-child{ color: red; } */
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 25px;}
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
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>

        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">发文文号：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="titleNumber" value="<% entity.write("titleNumber"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">批报标题：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>

                    <tr>
                        <td class="dce w100 ">批报时间：</td>
                        <td ><input type="text" class="w200 Wdate" name="reportingData"  rssdate="<% out.print(entity.get("reportingData")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr> 
                    <tr>
                        <td class="dce w100 ">提请报告：</td>
                        <td><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
                     <tr>
                        <td class="dce w100 ">提出审议结果报告:</td>
                        <td><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter2" name="matter2" class="w750" type="text/plain"><% entity.write("matter2"); %></script></td>
                     </tr>
                     <tr>
                        <td class="dce w100 ">地方性法规文件及说明:</td>
                        <td><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter3" name="matter3" class="w750" type="text/plain"><% entity.write("matter3"); %></script></td>
                     </tr>
                     <tr>
                        <td class="dce w100 ">主送机关：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="office" value="<% entity.write("office"); %>" /></td>
                    </tr>
                      <tr>
                        <td class="dce w100 ">省人大审批意见：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="suggestion" value="<% entity.write("suggestion"); %>" /></td>
                      </tr>
                      <tr>
                        <td class="dce w100 ">省批文件</td>
                        <td colspan="3">
                            <span id="fjfile"><% out.print(entity.get("enclosure").isEmpty() ? "点击选择文件" : entity.get("enclosure")); %></span>
                            <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                        </td>
                      </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
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
                                
                                if ($("[name='reportingData']").val() != undefined && $("[name='reportingData']").val() != "") {
                                    var timestamp = new Date($("[name='reportingData']").val());
                                    $("[name='reportingData']").val(timestamp / 1000);
                                }
                            })
          
                            $("#fjfile").click(function () {
                                $("#filee").click();
                            })
                            $("#icofile").click(function () {
                                $("#fileico").click();
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
                            $("#fileico").change(function () {
                                $("#fileicoform").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        $("#icofile").text(data.url)
                                        $("input[name='ico']").val(data.url);
                                        alert("上传成功");
                                    }});
                                return false;
                            })
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
