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
    RssList entity = new RssList(pageContext, "supervision_inspection");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_inspection");
    entity2.request();
   
    
    RssList userrole = new RssList(pageContext, "supervision_userrole_specialwork");
    userrole.request();
    
    int state = 0 ;
    int isSongjiaoSuccess = 0 ;
    
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "submit":     
               
                entity.keyvalue("state",4 );     // 2    
                entity.update().where("id=?", req.get("id")).submit();           

                break;
            case "auditpass":
              
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
                   <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">调研</td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:14px;">标题</td>
                        <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
<!--                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>-->
                 
                      
                    <tr>
                        <td class="w100 dce" >发起单位</td>
                        <td colspan="2"><% out.print(entity.get("initiator")); %></td>
                        <td class="w100 dce" >当前进度</td>
                        <td>
                        <% 
                       
                        if (entity.get("state").equals("5"))
                        out.print( "<b style='color:DarkOrange;font-size:14px;' >调研报告和交办意见主任会审议中</b>" );
                        else
                         out.print( "<b style='color:DarkOrange;font-size:14px;' >调研方案审议中</b>" );
                       
                        %>
                        </td>
                      
                        
                    </tr>
                    <tr>
                        <td class="w100 dce">主题</td>
                        <td colspan="2"><% entity.write("reviewclass"); %></td>
                        <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发布时间</td>
                        <td colspan="2" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                          
                    <tr>
                        <td class="w120 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">主任会议时间</td>
                        <td rssdate="<% entity.write("meetingshijian"); %>,yyyy-MM-dd" colspan="2"></td>
                      
                        
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">主任会议届次</td>
                        <td><% entity.write("directormeetingnum"); %></td>
                        </td>

                    </tr>
                 
                <tr>
                    <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">调研方案</td>
 

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
            
             <%
            if (entity.get("state").equals("5")) {
              
             %>
            <tr>
                <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">调研报告</td>
                 <td colspan="5" style="font-weight:bold;">
                 <%
                     String[] arry1 = {"", "", ""};
                     if (!entity.get("Reportenclosure").isEmpty()) {
                         String[] str1 = entity.get("Reportenclosure").split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry1[idx] = str1[idx];
                 %>
                 <%  entity.write("Reportenclosurename"); %><a href="/upfile/<% out.print( arry1[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float: right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr>
            
            
            <tr>
                    <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">交办意见</td>
 

                 <td colspan="5" style="font-weight:bold;">
                 <%
                     String[] arry2 = {"", "", ""};
                     if (!entity.get("assignenclosure").isEmpty()) {
                         String[] str1 = entity.get("assignenclosure").split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry2[idx] = str1[idx];
                 %>
                 <%  entity.write("assignenclosurename"); %><a href="/upfile/<% out.print( arry2[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float: right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr>
              <%
                   }
               
                 %>  
                
                
   

                
                
                </table>
            </div>
            <div class="footer">
                
             
                
                 <input type="hidden" name="action" value="<% 
 
                    out.print( "submit");
                   
                %>" />
                <button type="submit"><%        
                    out.print( "确定");
                %></button>
                
              
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {   
         
   
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
        
        </script>
    </body>
</html>
