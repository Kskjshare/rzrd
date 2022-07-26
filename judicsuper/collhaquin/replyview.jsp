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
<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "judicsup");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    
    RssList entity2 = new RssList(pageContext, "judicsup");
    entity2.request();
    
    RssList clue_reply = new RssList(pageContext, "clue_reply");
    clue_reply.request();
     
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "update":
//                entity.remove("relationid");
                entity.update().where("id=?", entity.get("id")).submit();
                
                clue_reply.select().where("id=?", clue_reply.get("id")).get_first_rows();
                clue_reply.keyvalue("id", clue_reply.autoid );
                clue_reply.keyvalue("typeid", 1);
                clue_reply.keyvalue("title", entity.get("title") );
                clue_reply.keyvalue("relationid", entity.get("id") );
                clue_reply.timestamp();
                
                clue_reply.keyvalue("zhengjienclosure", entity2.get("zhengjienclosure") );
                clue_reply.keyvalue("zhengjienclosurename", entity2.get("zhengjienclosurename") );
               
                clue_reply.keyvalue("myid", UserList.MyID(request) );//方案制定者
                clue_reply.append().submit();
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
            .dce{background: #dce6f5;text-indent: 0px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            /*#matter{line-height: 12px;}*/
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
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <!--<td style="font-size:20px;font-family: 微软雅黑" colspan="4" id="tabheader">办理回复</td>-->
                    </tr>
                    <tr>
                        <td class="dce w150 ">征集线索</td>
                        <td colspan="3"> <textarea style="height:60px;width:99%;margin:3px 0px 3px 0px;" type="text" name="zhengjiyijian"></textarea></td>
                    </tr>
                    
                    
                    <tr>
                    <td class="dce w100 ">征集文件</td>
                    <td colspan="3">
                        <span  id="fjfile" style="color:blue;font-weight:bold;" ><strong>点击选择报告文件</strong></span>
                        <input  type="hidden" name="zhengjienclosure" value="<% entity2.write("zhengjienclosure"); %>">
                        <input type="hidden" name="zhengjienclosurename" value="<% entity2.write("zhengjienclosurename"); %>" >
                    </td>
                    </tr>
             
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print("update"); %>" />
                <button type="submit"><% out.print("提交");%></button>            
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
               
              if ($("[name='zhengjiyijian']").val() == undefined || $("[name='zhengjiyijian']").val() == "") {
                    alert("请填写线索");
                    $("[name='title']").focus();
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
            if(data.url !== null && "" !== data.url){
                $("#fjfile").text(filename)
                    $("input[name='zhengjienclosure']").val(data.url);
                    $("input[name='zhengjienclosurename']").val(filename);
                    alert("上传成功");
                    }else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='zhengjienclosure']").val(data.url);
                    $("input[name='zhengjienclosurename']").val(filename);
                    alert("未上传")
                }
                   // let text = "上传成功";
                   // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
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


        </script>
    </body>
</html>
