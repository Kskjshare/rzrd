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
    RssList entity = new RssList(pageContext, "supervision_special_inquery");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_special_inquery");
    entity2.request();
   
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    String title = "专题询问";
   
    
    int state = 0 ;
    int isSongjiaoSuccess = 0 ;
    
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {   
            case "directormeetingdisagree"://主任会议审议方案不通过       
                entity.keyvalue("state", 4 ); 
                entity.update().where("id=?", req.get("id")).submit();          
                break;   
          
            case "directormeetingagree"://主任会议审议方案通过
                entity.keyvalue("directorshijian", entity2.get("directorshijian") ); 
                entity.keyvalue("directormeetingnum", entity2.get("directormeetingnum") ); 
              
                entity.keyvalue("state", 3 ); 
                entity.update().where("id=?", req.get("id")).submit();          
                break;   
          
            case "committeAuditFinish"://提交常委会审议意见
                //out.print("<script>alert('committeAuditFinish')</script>");
                entity.keyvalue("state",4 );   
              
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));     
               
                entity.update().where("id=?", req.get("id")).submit();  
               
               
                break;    
          
            case "submit":   
                 //out.print("<script>alert('submit')</script>");
                //提交主任会议，更新状态
                entity.keyvalue("state", 2);     // 2      
               
                entity.update().where("id=?", req.get("id")).submit();     
                //out.print("<script>alert('submit')</script>");
                break;
            case "auditpass":
                   //out.print("<script>alert('auditpass')</script>");
                //主任会议审核通过
                entity.keyvalue("state", 3);       //  3       
                entity.update().where("id=?", req.get("id")).submit();
                //out.print("<script>alert('auditpass')</script>");
                break;
   
        }
        
        
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
   


    RssListView user = new RssListView(pageContext, "user_delegation");
    user.request();
    //user.select().where("myid=" + entity.get("initiator")).get_first_rows();
    user.select().where("myid=" + UserList.MyID(request)).get_first_rows();

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
            
             #fileeformchangeFile{position: absolute;left: -10000px;}
            
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        
         <form id="fileeformchangeFile" enctype="multipart/form-data" method="post">
            <input type="file" id="fileechangeFile" accept="." name="file" multiple>
        </form>
        
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>     
                <table class="wp100 cellbor">
                   <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader"><%out.print(title);%></td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>                                          
                    <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="5"><% 
                           out.print(user.get("realname"));
                        %>
                        </td>
                    </tr>
                   

                    
                <tr>
                    <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                    <td colspan="3" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>

                      <td class="w100 dce" >当前进度</td>
                    <td>
                    <% 
                    
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                           
                    %>
                    </td>
                  </tr>
                    

                                  
                <tr class="directormeeting">                     
                 <td class="dce" style="font-size:15px;font-family: 微软雅黑" >主任会议时间<em class="red">*</em>
                 </td>
                 <td colspan="3" style="font-size:15px">
                   <input type="text"  style="width:98%;" class=" Wdate" name="directorshijian"  rssdate="<% out.print(entity2.get("directorshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                 </td>

                 <td class="dce" style="font-size:15px;font-family: 微软雅黑">主任会议届次</td>
                 <td colspan="5"><input  style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="directormeetingnum" value="<% entity2.write("directormeetingnum"); %>" /><label class="labtitle"></label></td>
               </tr>
                   
                <tr>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">专题询问方案</td>              
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
                <td  class="dce">主任会议决定</td>
                <td colspan="5" id="evaluation">
                    <label><input type="radio" value="1" name="agree" checked="cheched" >审议通过</label>
                    <label style="margin-left:8%;"><input type="radio" value="2" name="agree">审议不通过</label>                
                </td>
            </tr>
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会审议意见</td>
            <td colspan="5">
                <div>
                <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="enclosure1" id="enclosure1" value="<% entity2.write("enclosure1"); %>" >
                <input type="hidden" name="enclosurename1" id="enclosurename1" value="<% entity2.write("enclosurename1"); %>" >
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>
           
         
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                
                        out.print( "directormeetingagree"); 
                   
                 
                %>" />
                <button id= "adutibtn" type="submit"><% 
                   
                         out.print("审议通过");
                   
              
                %></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
                <input type="hidden" id="agreechek" value="<% entity2.write("agree"); %>">
             
             
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
            var $tt = $("#state").val();
            var $initiator = $("#initiator").val();
            
            $('input[name="agree"]').click(function () {
                //alert($(this).val() );
                if ( $(this).val() == 1 ){
                    $("#adutibtn").text("审议通过");                
                    $("input[name='action']").val("directormeetingagree");
                     
                    //$("#agreechek").val("1");
                   
                } else{                   
                   $("#adutibtn").text("审议不通过");                               
                   $("input[name='action']").val("directormeetingdisagree");
                   
                   // $("#agreechek").val("2");
                   
                }
            });
            
    
            
            $(".footer>button").click(function () {   
                
//                if ($("[name='directormeetingnum']").val() == undefined || $("[name='directormeetingnum']").val() == "") {
//                 
//                     alert("请添加主任会议届次");
//                     $("[name='directormeetingnum']").focus();
//                     return false;
//                }                
                      
                if ($("[name='directorshijian']").val() != undefined && $("[name='directorshijian']").val() != "") {
                    var timestamp = new Date($("[name='directorshijian']").val());
                    $("[name='directorshijian']").val(timestamp / 1000);
                }
                else {
                      alert("请添加主任会议时间");
                      $("[name='committeeshijian']").focus();
                       return false;
                }                  
             
                 
            })   
            
            
           
   
     
       
        $("#fjfile").click(function () {
            $("#filee").click();
        })
        
        
        $("#fjfilechangeFile").click(function () {
            $("#fileechangeFile").click();    
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
                    $("input[name='enclosure2']").val(data.url);
                    $("input[name='enclosurename2']").val(filename);              
                   
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='enclosure2']").val(data.url);
                    $("input[name='enclosurename2']").val(filename);
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
