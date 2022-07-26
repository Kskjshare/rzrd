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
    RssList entity = new RssList(pageContext, "petition");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "update":
                entity.remove("relationid");
//                entity.timestamp();
                entity.timestamp("procestime");
                entity.update().where("id=?", entity.get("id")).submit();
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
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b99{width:99%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}#headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
            .inform{display: none;}
            
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>

        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
<!--                    <tr>
                        <td colspan="4" class="institle dce">办理方式</td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">办理方式<em class="red">*</em></td>
                        <td><select class="b99 classify" name="handle" dict-select="petitionhandleclassify" def="<% entity.write("handle"); %>"></select></td>
                    </tr>
                    <tr class="inform">
                        <td class="dce w100 ">告知类型<em class="red">*</em></td>
                        <td><select class="w250" name="inform" dict-select="petitioninformclassify" def="<% entity.write("inform"); %>"></select></td>
                    </tr>
                    <tr style="display:none;">
                        <td class="dce w100 ">经办人<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="b95" name="agent" value="<% out.print(UserList.RealName(request));%>" /></td>
                    </tr>
                    <tr class="gtdepar">
                        <td class="dce w100 ">去向部门<em class="red">*</em></td>
                        <td><select class="b99" name="gtdepar" dict-select="petitiongtdeparclassify" def="<% entity.write("gtdepar"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">备注</td>
                        <td><input type="text" maxlength="80" class="b99" name="remarks" value="<% entity.write("remarks"); %>" /></td>
                    </tr>


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
                
//                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
//                    alert("请填写标题");
//                    $("[name='title']").focus();
//                    return false;
//                }
//
//                if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
//                    var timestamp = new Date($("[name='meetingshijian']").val());
//                    $("[name='meetingshijian']").val(timestamp / 1000);
//                }
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
                        $("#fjfile").text(filename)
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                        alert("上传成功");
                    }});
                return false;
            })
//                    $(".offpu").hide()
//                    $(".inform").hide()
            $(".classify").bind("change",function(){
                if($(this).val() == 3){
                    $(".inform").show()
                }else{
                    $(".inform").hide()
                }
            })
            $(".classify").bind("change",function(){
                if($(this).val() == 4 || $(this).val() == 3){
                    $(".gtdepar").hide()
                }else{
                    $(".gtdepar").show()
                }
            })

        </script>
    </body>
</html>
