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
                entity.keyvalue("state",7 );
              
                entity.keyvalue("organizationid",entity2.get("organizationid"));
                
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
                <!--<h1 style="margin-top:3px;margin-bottom:10px;font-size:22px;font-family: 微软雅黑;text-align: center; ">视察</h1>-->
                <table class="wp100 cellbor">
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">视察</td></tr>              
<!--                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">视察<em class="red">*</em></td>
                        <td colspan="2">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">
                                    <%
                                    if (entity.get("enclosure") == "") {
                                    %>
                                    点击选择方案文件
                                    <%
                                    }else{
                                    %>
                                    <% entity.write("enclosurename"); %>
                                    <%
                                    };
                                    %>
                                </span>
                                <input type="hidden" name="enclosure" id="enclosure" value="<% entity.write("enclosure"); %>" >
                                <input type="hidden" name="enclosurename" id="enclosurename" value="<% entity.write("enclosurename"); %>" >
                            </div>
                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden"id="enclosure3" ></div>
                        </td>                   
                    </tr>-->
                    
   
   
                   
              
                
                    <!--<tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">主办单位</td></tr>-->
                    <tr>
                    <td class="dce" >单位名称<em class="red">*</em></td>
                    <td id="selcompanysend" colspan="2"><em selectcompanyuser>点击添加单位</em>    
                    
                    </td>                 
                    </tr>    
                    

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print("update"); %>" />
                <button type="submit"><% out.print( "交办");%></button>
               
                <input type="hidden" id="company" name="organizationid" value="<% entity2.write("organizationid"); %>">
                <input type="hidden" id="organizationName" name="organizationName" value="<% entity.write("organizationName"); %>">

                
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
  
            
            $(".footer>button").click(function () {
               
            


            
            //添加单位
            var arrycompany = [];    
            var arrycompany_name = [];              

            $("#selcompanysend>em[companyid]").each(function () {
                arrycompany.push($(this).attr("companyid"))    
                arrycompany_name.push($(this).attr("myname"))        

            })
            var strcompany = arrycompany.join(",");
            var strcompany_name = arrycompany_name.join(",");

            $("#company").val( strcompany );
            $("#organizationName").val( strcompany_name );

                
            
            
            
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
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                        //alert("上传成功");
                        }else{
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
//                        t.append("<em companyid='" + v.myid + "'>" + v.myname + "<i>×</i></em>")
                        t.append("<em companyid='" + v.myid + "' + myname='" + v.myname + "'>" + v.myname + "<i>×</i></em>")

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
