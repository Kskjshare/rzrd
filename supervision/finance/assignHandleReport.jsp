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
    
    String title = "专题询问";
   
    
    int state = 0 ;
    int isSongjiaoSuccess = 0 ;
    
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
        
            case "submit":                
                entity.keyvalue("state",11 );   
                entity.keyvalue("reportenclosure",entity2.get("reportenclosure"));
                entity.keyvalue("reportenclosurename",entity2.get("reportenclosurename"));    
              
                entity.update().where("id=?", req.get("id")).submit();  
                //entity.keyvalue("taskDone", 1 );  
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
                <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader"><%out.print(title);%></td></tr>
 
<!--                <tr>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">调查报告</td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry0 = {"", "", ""};
                     if (!entity.get("reportenclosure").isEmpty()) {
                         String[] str1 = entity.get("reportenclosure").split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry0[idx] = str1[idx];
                 %>
                 <%  entity.write("reportenclosurename"); %><a href="/upfile/<% out.print( arry0[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
                </tr>
                
               
                <td  class="dce">常委</td>
                <td colspan="5" >
                <label><input type="radio" value="1" name="committeeopinion" checked="cheched" >决议</label>
                <label style="margin-left:8%;"><input type="radio" value="2" name="committeeopinion">决定</label>                                       
                </td>
                </tr>   -->
                
               
                <tr class="decision">                
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">办理情况报告<em class="red">*</em></td>              
                <td colspan="5">
                    <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                    <input type="hidden" name="reportenclosure" id="reportenclosure" value="<% entity2.write("reportenclosure"); %>" >
                    <input type="hidden" name="reportenclosurename" id="reportenclosurename" value="<% entity2.write("reportenclosurename"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">

                    </div>
                </td>
                </tr>         

<!--                <tr>
                    <td class="dce w100 " style="color:blue;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;" >办理单位<em class="red">*</em></td>
                    <td  colspan="5" id="userrolesel">
                        <input style="width:99%;" readonly="readonly" value="<% req.write("userroleid"); %>"/>
                        <input type="hidden" name="userroleid" id="userroleid" value="<% entity2.write("userroleid"); %>"/>
                    </td>
                </tr>-->
    
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                    out.print("submit");                
                %>" />
                <button id= "adutibtn" type="submit"><%                     
                    out.print( "确认提交");
                %></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
 
     
        $('input[name="committeeopinion"]').click(function () {
            $("input[name='committeeopinion']").value($(this).val());  
            if ( $(this).val() ==  1 ) {
                
                $("#decision").text("决议文件");        
            }
            else {
                $("#decision").text("决定文件");        
            }
        }); 
 
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
                    $("input[name='reportenclosure']").val(data.url);
                    $("input[name='reportenclosurename']").val(filename);
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='reportenclosure']").val(data.url);
                    $("input[name='reportenclosurename']").val(filename);
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
        
        
        
        $("#userrolesel>input").click(function () {
            RssWin.onwinreceivemsg = function (dict) {
                var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";

                $.each(dict, function (k, v) {
                    userrolename.push(v.myname)   
                    userroleval.push(v.myid)

                   // userroleval.push(v.fjfile)
                })
                userrolenamesp = userrolename.join(",");
                userrolevalsp = userroleval.join(",");
                $("#userrolesel").find("input:first").val(userrolenamesp)

                $("#userroleid").val(userrolevalsp)
            }
            RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 350);
         });
        
        
         $(".footer>button").click(function () {   
          
            if ($("[name='reportenclosure']").val() == undefined || $("[name='reportenclosure']").val() == "") {
                alert("请添加办理情况报告文件");
                $("[name='enclosure2']").focus();
                return false;
            }
             
            })
 
        </script>
    </body>
</html>
