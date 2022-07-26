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
    RssList entity = new RssList(pageContext, "supervision_finance");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_finance");
    entity2.request();
   
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    String title = "听取国民经济和社会发展计划、财政预算执行及审计工作流程";
    int state = 0 ;
    String reporttitle = "初步审查报告";

    String opiniontitle = "征求意见稿";
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
    
    
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
        
            case "submit":     
                entity.keyvalue("state",3 );   
                entity.keyvalue("auditreportenclosure",entity2.get("auditreportenclosure"));
                entity.keyvalue("auditreportenclosurename",entity2.get("auditreportenclosurename"));  
                entity.keyvalue("opinionenclosure",entity2.get("opinionenclosure"));
                entity.keyvalue("opinionenclosurename",entity2.get("opinionenclosurename"));  


                entity.keyvalue("committeeshijian",entity2.get("committeeshijian"));
                entity.keyvalue("committeemeetingnum",entity2.get("committeemeetingnum")); 

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
            #fileeform1{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform1" enctype="multipart/form-data" method="post">
            <input type="file" id="filee1" accept="." name="file" multiple>
        </form>
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>     
                <table class="wp100 cellbor">
                <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader"><%out.print( title );%></td></tr>
 

            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(reporttitle);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
             
                <input type="hidden" name="auditreportenclosure" id="summaryenclosure" value="<% entity2.write("auditreportenclosure"); %>" >
                <input type="hidden" name="auditreportenclosurename" id="summaryenclosure" value="<% entity2.write("auditreportenclosurename"); %>" >
               
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>  
            
<!--            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(opiniontitle);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile1" rid="2" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
               
                <input type="hidden" name="opinionenclosure" id="opinionenclosure" value="<% entity2.write("opinionenclosure"); %>" >
                <input type="hidden" name="opinionenclosurename" id="opinionenclosurename" value="<% entity2.write("opinionenclosurename"); %>" >             
                
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>         -->

          
            
            <tr class="directormeeting">                     
                <td class="dce w120" style="font-size:16px;font-family: 微软雅黑" >常委会议时间<em class="red">*</em>
                </td>
                <td colspan="3" style="font-size:15px">
                  <input type="text"  style="width:98%;" class=" Wdate" name="committeeshijian"  rssdate="<% out.print(entity.get("committeeshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                </td>

                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会议届次<em class="red">*</em></td>
                <td colspan="5"><input  style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="committeemeetingnum" value="<% entity.write("committeemeetingnum"); %>" /><label class="labtitle"></label></td>
            </tr>
    
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                    out.print("submit");                
                %>" />
                <button id= "adutibtn" type="submit"><%                     
                    out.print( "提交");
                %></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
            var $state = $("#state").val();
            
            $('input[name="provider"]').click(function () {
                
                if ( $(this).val() == 1 || $(this).val() == 0 ){
                    //$("#adutibtn").text("同意");                               
                   // $("input[name='action']").val("committeAuditagree");     
                    $("input[name='provider']").val("1");      
//                    $("#provider").value("1");
                } else{                   
                  //$("#adutibtn").text("不同意");                                                 
                  //$("input[name='action']").val("committeAuditdisagree");
                  $("input[name='provider']").value("2");   
//                  $("#provider").value("2");
                }
                $("input[name='provider']").value($(this).val());   
                
            });
        
        $("#fjfile").click(function () {
            $("#filee").click();
        })
        
        $("#fjfile1").click(function () {
            $("#filee1").click();
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
                    
                     
                        $("input[name='auditreportenclosure']").val(data.url);
                        $("input[name='auditreportenclosurename']").val(filename);
                        
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='auditreportenclosure']").val(data.url);
                    $("input[name='auditreportenclosurename']").val(filename);
                    alert("未上传")
                }
                }});
            return false;
        })
        
        $("#filee1").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform1").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile1").text(filename)
                    
                     
                            $("input[name='opinionenclosure']").val(data.url);
                            $("input[name='opinionenclosurename']").val(filename);
                       
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile1").text("点击选择文件")
                    $("input[name='opinionenclosure']").val(data.url);
                    $("input[name='opinionenclosurename']").val(filename);
                    alert("未上传")
                }
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
        
        
         $(".footer>button").click(function () {   
               // var $tt = $("#state").val();
                //console.log($tt);
//            if ($("[name='providername']").val() == undefined || $("[name='providername']").val() == "") {
//                alert("请填写提供材料者名称");
//                $("[name='providername']").focus();
//                return false;
//            }
           
           
            
             if ($("[name='auditreportenclosure']").val() == undefined || $("[name='auditreportenclosure']").val() == "") {
                alert("请添加初审报告");
                $("[name='auditreportenclosure']").focus();
                return false;
            }
//            if ($("[name='opinionenclosure']").val() == undefined || $("[name='opinionenclosure']").val() == "") {
//                alert("请添加征求意见稿");
//                $("[name='opinionenclosure']").focus();
//                return false;
//            }
          
           
          
            
            
                
            if ($("[name='committeeshijian']").val() != undefined && $("[name='committeeshijian']").val() != "") {
                var timestamp = new Date($("[name='committeeshijian']").val());
                $("[name='committeeshijian']").val(timestamp / 1000);
            }
            else {
                alert("请添加常委会议时间");
                $("[name='committeeshijian']").focus();
                return false;
            } 
            
              if ($("[name='committeemeetingnum']").val() != undefined && $("[name='committeemeetingnum']").val() != "") {
                var timestamp = new Date($("[name='committeemeetingnum']").val());
                $("[name='committeemeetingnum']").val(timestamp / 1000);
            }
            else {
                alert("请添加常委会议界次");
                $("[name='committeemeetingnum']").focus();
                return false;
            } 
             
            })
 
        </script>
    </body>
</html>
