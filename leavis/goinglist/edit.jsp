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
            case "append":
//                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid");
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

        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">来信登记</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访主题<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访件编号<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="b95" name="petition" value="<% entity.write("petition"); %>" /></td>
                        <td class="dce w100 ">性别</td>
                        <td><select class="w250 classify" name="sex" dict-select="sex" def="<% entity.write("sex"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">姓名<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="b95" name="petitioner" value="<% entity.write("petitioner"); %>" /></td>
                        <td class="dce w100 ">身份证号</td>
                        <td><input type="text" maxlength="80" class="b95" name="idcard" value="<% entity.write("idcard"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">涉及人数<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="b95" name="numpeinv" value="<% entity.write("numpeinv"); %>" /></td>
                        <td class="dce w100 ">住址<em class="red">*</em></td>
                        <td><input type="text" maxlength="80" class="b95" name="addr" value="<% entity.write("addr"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">受信人</td>
                        <td><input type="text" maxlength="80" class="b95" name="idcard" value="<% entity.write("idcard"); %>" /></td>
                        <td class="dce w100 ">来信日期</td>
                        <td><input type="text" class="w200 Wdate" name="datapetition"  rssdate="<% out.print(entity.get("datapetition")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>
                    <tr style="display: none;">
                        <td class="dce w100 ">信访形式<em class="red">*</em></td>
                        <td><select class="w250 classify" name="petitionclassify" dict-select="petitionclassify" def="1"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访原因<em class="red">*</em></td>
                        <td><select class="w250" name="reapetition" dict-select="reapetitionclassify" def="<% entity.write("reapetition"); %>"></select></td>
                        <td class="dce w100 ">问题属地</td>
                        <td><input type="text" maxlength="80" class="b95" name="problemter" value="<% entity.write("problemter"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
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
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                }
                if ($("[name='petition']").val() == undefined || $("[name='petition']").val() == "") {
                    alert("请填写信访编号");
                    $("[name='petition']").focus();
                    return false;
                }
                if ($("[name='numpeinv']").val() == undefined || $("[name='numpeinv']").val() == "") {
                    alert("请填写涉及人数");
                    $("[name='numpeinv']").focus();
                    return false;
                }
                if ($("[name='petitioner']").val() == undefined || $("[name='petitioner']").val() == "") {
                    alert("请填写姓名");
                    $("[name='petitioner']").focus();
                    return false;
                }
                if ($("[name='addr']").val() == undefined || $("[name='addr']").val() == "") {
                    alert("请填写住址");
                    $("[name='addr']").focus();
                    return false;
                }
                if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
                    alert("请填写概况信息");
                    $("[name='matter']").focus();
                    return false;
                }
                if ($("[name='reapetition']").val() == undefined || $("[name='reapetition']").val() == "") {
                    alert("请填写信访原因");
                    $("[name='reapetition']").focus();
                    return false;
                }

                if ($("[name='datapetition']").val() != undefined && $("[name='datapetition']").val() != "") {
                    var timestamp = new Date($("[name='datapetition']").val());
                    $("[name='datapetition']").val(timestamp / 1000);
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
                        $("#fjfile").text(filename)
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                        alert("上传成功");
                    }});
                return false;
            })

        </script>
    </body>
</html>
