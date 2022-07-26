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
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookie = new CookieHelper(request, response);
    RssList entity = new RssList(pageContext, "supervision_enforcement");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_enforcement");
    entity2.request();
   
    
    RssList userrole = new RssList(pageContext, "supervision_userrole_specialwork");
    userrole.request();
    
    int state = 0 ;
  
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "agree": 
                //out.print("<script>alert('agree')</script>");
                entity.keyvalue("state", 2 );    
                entity.keyvalue("previewopinion", entity2.get("previewopinion") ); 
                entity.keyvalue("needsubmitmeeting", 1 );      
                entity.update().where("id=?", req.get("id")).submit();           
                break;
            case "disagree":  
                //out.print("<script>alert('disagree')</script>");
                entity.keyvalue("state", 5 );    
                entity.keyvalue("previewopinion", entity2.get("previewopinion") ); 
                entity.keyvalue("needsubmitmeeting", 2 );      
                entity.update().where("id=?", req.get("id")).submit();           
                break;

         }
        
    
        
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
   
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
            #fileeformReport{position: absolute;left: -10000px;}
            #fileeformOpinion{position: absolute;left: -10000px;}
            
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>         
        </form>
        
        <form id="fileeformReport" enctype="multipart/form-data" method="post">
            <input type="file" id="fileeReport" accept="." name="file" multiple>      
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
                <table class="wp100 cellbor">
                   <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">执法检查</td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:14px;">标题</td>
                        <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
<!--                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>-->
                 
                      
                    <tr>                      
                        <td class="w100 dce" >当前状态</td>
                        <td colspan="5">
                        <%                         
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待审阅</b>" );
                        %>
                        </td>
                      
                        
                    </tr>
                    <tr>
                        <td class="w100 dce">主题</td>
                        <td colspan="2"><% entity.write("reviewclass"); %></td>
                        <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发布时间</td>
                        <td colspan="2" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                          
<!--                    <tr>
                        <td class="w120 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">主任会议时间</td>
                        <td rssdate="<% entity.write("meetingshijian"); %>,yyyy-MM-dd" colspan="2"></td>
                      
                        
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">主任会议届次</td>
                        <td><% entity.write("directormeetingnum"); %></td>
                        </td>

                    </tr>-->
                 
                <tr>
                    <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">执法检查方案</td>
 
                 <td colspan="5" style="font-weight:bold;">
                 <%
                     String[] arry0 = {"", "", ""};
                     if (!entity.get("enclosure").isEmpty()) {
                         String[] str1 = entity.get("enclosure").split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry0[idx] = str1[idx];
                 %>
                 <%  entity.write("enclosurename"); %><a href="/upfile/<% out.print( arry0[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float: right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr>
                
  
            <tr>
                <td  class="dce">是否提交主任会</td>
                <td colspan="5" id="needpreview">
                <label><input type="radio" value="1" name="needsubmitmeeting" checked="cheched" >同意提交主任会</label>
                <label style="margin-left:7%;"><input type="radio" value="2" name="needsubmitmeeting">不需要提交主任会</label>                        
                </td>
            </tr>
             <tr>
                <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">您的意见</td>
                <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="previewopinion" value="<% entity2.write("previewopinion"); %>" /><label class="labtitle"></label></td>
            </tr>
            
            
                
            </table>
            
            </div>
            <div class="footer">
                 <input type="hidden" name="action" value="<%out.print("agree");%>" />
                <button id= "adutibtn" type="submit"><% out.print( "同意提交主任会议");%></button>                    
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            
             $('input[name="needsubmitmeeting"]').click(function () {
                if ( $(this).val() == 1 || $(this).val() == 0 ){
                    $("#adutibtn").text("同意提交主任会议");                
                    $("input[name='action']").val("agree");
                     
                   
                   // $("input[name='action']").value("agree");
                    $("input[name='needsubmitmeeting']").val("1");
                   
                } else{                   
                   $("#adutibtn").text("不需要提交主任会议");                               
                   $("input[name='action']").val("disagree");
                  
                   //$("input[name='action']").value("disagree");
                   $("input[name='needsubmitmeeting']").val("2");
                    
                }
            });
            
            
            $(".footer>button").click(function () {   
                var $tt = $("#state").val();
         
   
            })                           

   
        
       
        $("#fjfile").click(function () {
            $("#filee").click();
            //alert(" click ");
        })

        $("#fjfileReport").click(function () {
            $("#fileeReport").click();
            //alert(" click1 ");
        })

         $("#fjfileOpinion").click(function () {
            $("#fileeOpinion").click();
            //alert(" click2 ");
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
                    $("input[name='enclosure']").val(data.url);
                    $("input[name='enclosurename']").val(filename);
                  
                    
                    alert("上传成功");
                    }
                    else{
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
        

        $("#fileeReport").change(function () {      
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeformReport").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
                
                    $("#fjfileReport").text(filename)
                    $("input[name='Reportenclosure']").val(data.url);
                    $("input[name='Reportenclosurename']").val(filename);
                   
                    
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfileReport").text("点击选择文件")
                    $("input[name='Reportenclosure']").val(data.url);
                    $("input[name='Reportenclosurename']").val(filename);
                    alert("未上传")
                }
                   // let text = "上传成功";
                   // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                }});
            return false;
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

        
//        $("#fileico").change(function () {
//            $("#fileicoform").ajaxSubmit({
//                url: "/widget/upload.jsp?",
//                type: "post",
//                dataType: "json",
//                async: false,
//                success: function (data) {
//                    $("#icofile").text(data.url)
//                    $("input[name='ico']").val(data.url);
//                    alert("上传成功");
//                }});
//            return false;
//        })
        

        </script>
    </body>
</html>
