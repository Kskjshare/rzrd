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
    RssList entity = new RssList(pageContext, "supervision_special_inquery"); // supervision_topic
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "user_delegation");
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
    
    
    RssList entity2 = new RssList(pageContext, "supervision_special_inquery"); // supervision_topic
    entity2.request();
    
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
           
            case "submit":                
                entity.keyvalue("state",16 );   
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));    
                
                //entity.keyvalue("userroleid",entity2.get("userroleid"));    
                //entity.keyvalue("userroleid",entity2.get("userroleid"));
                entity.keyvalue("company",entity2.get("company"));   
                 
                entity.update().where("id=?", req.get("id")).submit();  
                //entity.keyvalue("taskDone", 1 );  
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
            #fileicoform{position: absolute;left: -10000px;}
          
            #selcompanysend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
  
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
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">专题询问</td></tr>              
                   
                   
                <tr class="decision">                
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会审议意见</td>              
                <td colspan="5">
                    <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                    <input type="hidden" name="enclosure2" id="enclosure2" value="<% entity2.write("enclosure2"); %>" >
                    <input type="hidden" name="enclosurename2" id="enclosurename2" value="<% entity2.write("enclosurename2"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">

                    </div>
                </td>
                </tr>         
                    
   
                
                   
                    <tr>
                    <td class="dce" >单位名称<em class="red">*</em></td>
                    <td id="selcompanysend" colspan="5"><em selectcompanyuser>点击添加单位</em>    
                    
                    </td>                 
                    </tr>    
                    

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% 
                    out.print("submit");                
                %>" />
                <button id= "adutibtn" type="submit"><%                     
                    out.print( "确认交办");
                %></button>
                   
                <input type="hidden" id="company" name="company" value="<% entity2.write("company"); %>">
                
              
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
  
            
            $(".footer>button").click(function () {                              
//                if ($("[name='enclosure2']").val() == undefined || $("[name='enclosure2']").val() == "") {
//                    alert("请添加方案文件");
//                    $("[name='enclosure2']").focus();
//                    return false;
//                }               

            if ($("#selcompanysend em").length == 1) {
                    alert("请添加被检查单位");
                    $("[name='companyid']").focus();
                    return false;
                }  
               
 
            //添加单位
            var arrycompany = [];              
            $("#selcompanysend>em[companyid]").each(function () {
                arrycompany.push($(this).attr("companyid"))        
            })
            var strcompany = arrycompany.join(",");
            $("#company").val( strcompany );
                
            
            
            
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
                        $("input[name='enclosure2']").val(data.url);
                        $("input[name='enclosurename2']").val(filename);
                        //alert("上传成功");
                        }else{
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
                        //alert("上传成功");
                    }});
                return false;
            })


          //单位
          $('[selectcompanyuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[companyid='" + v.myid + "']").length == "0") {
                        t.append("<em companyid='" + v.myid + "'>" + v.myname + "<i>×</i></em>")
                    }
                })
                $("#selcompanysend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
        });
  
        </script>
    </body>
</html>
