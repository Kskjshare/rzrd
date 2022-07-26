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
    RssList entity = new RssList(pageContext, "supervision_inspection"); // supervision_topic
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "user_delegation");
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
    
    
    RssList entity2 = new RssList(pageContext, "supervision_inspection"); // supervision_topic
    entity2.request();
    
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "update":
                //out.print("<script>alert('update')</script>");
                entity.keyvalue("state",5 );
                entity.keyvalue("assignenclosurename",entity2.get("assignenclosurename"));
                entity.keyvalue("assignenclosure",entity2.get("assignenclosure"));
                entity.keyvalue("Reportenclosure",entity2.get("Reportenclosure"));
                entity.keyvalue("Reportenclosurename",entity2.get("Reportenclosurename"));
                entity.keyvalue("meetingshijian1",entity2.get("meetingshijian1"));
                entity.keyvalue("directormeetingnum1",entity2.get("directormeetingnum1"));
                
                entity.update().where("id=?", req.get("id")).submit();
                
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entity.select().where("id=?", entity.get("relationid")).get_first_rows();
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
            #fileeformOpinion{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
           
            #selpreviewsend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        
         <form id="fileeformOpinion" enctype="multipart/form-data" method="post">
            <input type="file" id="fileeOpinion" accept="." name="file" multiple>      
        </form>
        
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <!--<h1 style="margin-top:3px;margin-bottom:10px;font-size:22px;font-family: 微软雅黑;text-align: center; ">视察调研</h1>-->
                <table class="wp100 cellbor">
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">调研</td></tr>              
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">调研报告<em class="red">*</em></td>
                        <td colspan="5">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" name="Reportenclosure" id="enclosure" value="<% entity2.write("Reportenclosure"); %>" >
                                <input type="hidden" name="Reportenclosurename" id="enclosurename" value="<% entity2.write("Reportenclosurename"); %>" >
                            </div>
<!--                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden"id="enclosure3" ></div>-->
                        </td>                   
                    </tr>
                    
   
                     <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">交办意见<em class="red">*</em></td>
                        <td colspan="5">
                            <div>
                                <span id="fjfileOpinion" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" name="assignenclosure" id="enclosure" value="<% entity2.write("assignenclosure"); %>" >
                                <input type="hidden" name="assignenclosurename" id="enclosurename" value="<% entity2.write("assignenclosurename"); %>" >
                            </div>
<!--                            <div style="display: none;"><span id="fjfileOpinion" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfileOpinion" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden"id="enclosure3" ></div>-->
                        </td>                   
                    </tr>
   
                   
                    <tr>                     
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑" >主任会议时间<em class="red">*</em>
                      </td>
                      
                      <td colspan="2" style="font-size:16px">
                        <input type="text" class="w200 Wdate" name="meetingshijian1"  rssdate="<% out.print(entity.get("meetingshijian1")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                      </td>
                      
                    
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">主任会议届次<em class="red">*</em></td>
                      <td colspan="2"><input style="font-size:16px;font-family: 微软雅黑;width:200px;" type="text" maxlength="100" class="w98" name="directormeetingnum1" value="<% entity.write("directormeetingnum1"); %>" /><label class="labtitle"></label></td>

                    </tr>
                  
       
                    

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print("update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "确定" : "提交");%></button>
                <!--<input type="hidden" name="objid" >-->
                <input type="hidden" id="rid" name="objid" value="">
                <input type="hidden" id="committeerid" name="committeeobjid" value="<% entity2.write("committeeobjid"); %>">
                <input type="hidden" id="parttimecommitid" name="parttimemember" value="<% entity2.write("parttimemember"); %>">
                <input type="hidden" id="expertmemberid" name="expertmemberid" value="<% entity2.write("expertmemberid"); %>">
                <input type="hidden" id="company" name="company" value="<% entity2.write("company"); %>">
                
                <input type="hidden" id="previewleadername" name="previewleadername" value="<% entity2.write("previewleadername"); %>">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
  
            
            $(".footer>button").click(function () {
               
                
              
                if ($("[name='Reportenclosure']").val() == undefined || $("[name='Reportenclosure']").val() == "") {
                    alert("请添加调研报告");
                    $("[name='Reportenclosure']").focus();
                    return false;
                }
                if ($("[name='assignenclosure']").val() == undefined || $("[name='assignenclosure']").val() == "") {
                    alert("请添加交办意见");
                    $("[name='assignenclosure']").focus();
                    return false;
                }
               if ($("[name='meetingshijian1']").val() == undefined || $("[name='meetingshijian1']").val() == "") {
                    alert("请填写主任会议时间");
                    $("[name='meetingshijian1']").focus();
                    
                    //
                    $("[name='inspecttime']").val("");
                    return false;
                }

             if ($("[name='directormeetingnum1']").val() == undefined || $("[name='directormeetingnum1']").val() == "") {
                    alert("请填写主任会议届次");
                    $("[name='directormeetingnum1']").focus();
                    return false;
            }
    
               
                
                if ($("[name='meetingshijian1']").val() != undefined && $("[name='meetingshijian1']").val() != "") {
                    var timestamp = new Date($("[name='meetingshijian1']").val());
                    $("[name='meetingshijian1']").val(timestamp / 1000);
                }

   
            
            })  
           
    
            $("#fileeOpinion").change(function () {        
                 var str = $(this).val(); //开始获取文件名
                 var filename = str.substring(str.lastIndexOf("\\") + 1);
                 $("#fileeformOpinion").ajaxSubmit({
                     url: "/widget/upload.jsp?",
                     type: "post",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                 if(data.url !== null && "" !== data.url){

                         $("#fjfileOpinion").text(filename)
                         $("input[name='assignenclosure']").val(data.url);
                         $("input[name='assignenclosurename']").val(filename);


                         //alert("上传成功");
                         }
                         else{
                         $("#fjfileOpinion").text("点击选择文件")
                         $("input[name='assignenclosure']").val(data.url);
                         $("input[name='assignenclosurename']").val(filename);
                         alert("未上传")
                     }
                        // let text = "上传成功";
                        // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                     }});
                 return false;
             })
             
             
             
           $("#fjfileOpinion").click(function () {
            $("#fileeOpinion").click();
            //alert(" click2 ");
           })
           
        $("#fjfile").click(function () {
            $("#filee").click();
            //alert(" click ");
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
                        $("input[name='Reportenclosure']").val(data.url);
                        $("input[name='Reportenclosurename']").val(filename);
                        //alert("上传成功");
                        }else{
                        $("#fjfile").text("点击选择文件")
                        $("input[name='Reportenclosure']").val(data.url);
                        $("input[name='Reportenclosurename']").val(filename);
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
