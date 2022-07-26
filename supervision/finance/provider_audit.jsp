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
    
    
    String path = "finance_enclosure1";
    String name = "finance_enclosurename1";
    String itemtitle = "上半年国民经济和社会发展计划执行情况的报告";
    
    String title = "听取和审议市政府本年度上半年国民经济和社会发展计划执行情况的报告";
    if ( entity.get("investigationDepartment").equals("3")) {
        title = "听取和审议市政府上一年度市本级财政决算和本年度上半年财政预算执行情况的报告";
        itemtitle = "执行情况报告文件";
        path = "finance_enclosure9";
        name = "finance_enclosurename9";
    }
    else if ( entity.get("investigationDepartment").equals("4")) {
        title = "听取和审议市政府本年度市本级预算执行和其他财政收支情况的审计报告";
        itemtitle = "审计报告文件";
        path = "finance_enclosure1";
        name = "finance_enclosurename1";
    }
    else if ( entity.get("investigationDepartment").equals("1")) {
        title = "听取和审议市政府本年度上半年国民经济和社会发展计划执行情况的报告";
        itemtitle = "执行情况报告文件";
        path = "finance_enclosure1";
        name = "finance_enclosurename1";
    }
    
    else {
        
       title = "听取国民经济和社会发展计划、财政预算执行及审计工作流程";
    }
    
   
    
    int state = 0 ;
    String reporttitle = "常委会审议意见";

    String opiniontitle = "征求意见稿";
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
    
    
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
        
            case "submit":     
                entity.keyvalue("state",4 );   
                entity.keyvalue("auditopinionclosure",entity2.get("auditopinionclosure"));
                entity.keyvalue("auditopinionclosurename",entity2.get("auditopinionclosurename"));  
              

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
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(itemtitle);%></td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry1 = {"", "", ""};
                     if (!entity.get( path ).isEmpty()) {
                         String[] str1 = entity.get( path ).split(",");
                         for (int idx1 = 0; idx1 < str1.length; idx1 ++ ) {
                             arry1[ idx1 ] = str1[ idx1 ];
                 %>
                 <%  entity.write( name ); %><a href="/upfile/<% out.print( arry1[ idx1 ] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr> 
           
                

            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(reporttitle);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
             
                <input type="hidden" name="auditopinionclosure" id="summaryenclosure" value="<% entity2.write("auditopinionclosure"); %>" >
                <input type="hidden" name="auditopinionclosurename" id="summaryenclosure" value="<% entity2.write("auditopinionclosurename"); %>" >
               
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>  
 
          
<!--            
            <tr class="directormeeting">                     
                <td class="dce w120" style="font-size:16px;font-family: 微软雅黑" >常委会议时间<em class="red">*</em>
                </td>
                <td colspan="3" style="font-size:15px">
                  <input type="text"  style="width:98%;" class=" Wdate" name="committeeshijian"  rssdate="<% out.print(entity.get("committeeshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                </td>

                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会议届次<em class="red">*</em></td>
                <td colspan="5"><input  style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="committeemeetingnum" value="<% entity.write("committeemeetingnum"); %>" /><label class="labtitle"></label></td>
            </tr>-->
    
       
                
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
                    
                     
                        $("input[name='auditopinionclosure']").val(data.url);
                        $("input[name='auditopinionclosurename']").val(filename);
                        
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='auditopinionclosure']").val(data.url);
                    $("input[name='auditopinionclosurename']").val(filename);
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
           
           
            
//             if ($("[name='auditopinionclosure']").val() == undefined || $("[name='auditopinionclosure']").val() == "") {
//                alert("请添加常委会审议意见");
//                $("[name='auditopinionclosure']").focus();
//                return false;
//            }
         
        
             
            })
 
        </script>
    </body>
</html>
