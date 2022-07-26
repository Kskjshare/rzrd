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
    RssList entity = new RssList(pageContext, "supervision_enforcement"); // supervision_topic
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "user_delegation");
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
    
    
    RssList entity2 = new RssList(pageContext, "supervision_enforcement"); // supervision_topic
    entity2.request();
    
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "update":
                //out.print("<script>alert('update')</script>");
                entity.keyvalue("state",8 );
              
                entity.keyvalue("organizationid",entity2.get("organizationid"));
                entity.keyvalue("assignenclosure",entity2.get("assignenclosure"));
                entity.keyvalue("assignenclosurename",entity2.get("assignenclosurename"));
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
              
                <table class="wp100 cellbor">
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">执法检查</td></tr>              

   
   
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">审议意见<em class="red">*</em></td>
                        <td colspan="5">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择审议意见</span>
                                <input type="hidden" name="assignenclosure" id="assignenclosure" value="<% entity2.write("assignenclosure"); %>" >
                                <input type="hidden" name="assignenclosurename" id="assignenclosurename" value="<% entity2.write("assignenclosurename"); %>" >
                            </div>
                        </td>                   
                    </tr>
                    
                    
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
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
  
            
            $(".footer>button").click(function () {
               
            
                if ($("[name='assignenclosure']").val() == undefined || $("[name='assignenclosure']").val() == "") {
                    alert("请添加审议意见");
                    $("[name='assignenclosure']").focus();
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
                        $("input[name='assignenclosure']").val(data.url);
                        $("input[name='assignenclosurename']").val(filename);
                        //alert("上传成功");
                        }else{
                        $("#fjfile").text("点击选择文件")
                        $("input[name='assignenclosure']").val(data.url);
                        $("input[name='assignenclosurename']").val(filename);
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
