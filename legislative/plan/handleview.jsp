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
     
    RssList entity = new RssList(pageContext, "legislativeplan");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
   
    RssList entity1 = new RssList(pageContext, "year_classify");
    RssList legislation_classify = new RssList(pageContext, "legislation_classify");

   
  
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                //entity.keymyid(cookie.Get("myid"));
                entity.timestamp();

                entity.append().submit();
       
                break;
            case "update":
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
                 
                    <tr>                    
                        <td colspan="5" id="handleOpt_id1">
                        <label style="margin-left:10%" ><input type="radio" value="1" name="state" >条件比较成熟，拟五年内提请审议的法规项目</label>
                        <!--<label style="margin-left:7%;display: none"><input type="radio" value="2" name="state"checked="cheched" ></label>-->

                        <!--<label style="margin-left:7%;display: none"><input type="radio" value="2" name="leaderpreview"  >需要抓紧工作、条件成熟时提请审议的法规项目</label>-->                        
                        </td>
                     </tr>  
                     
                    <tr>  
                    <td colspan="5">
                    </tr>  
                    
                    <tr> 
                        <td colspan="5" id="handleOpt_id2">
                        <label style="margin-left:10%" ><input type="radio" value="2" name="state" >需要抓紧工作、条件成熟时提请审议的法规项目</label>
                        <!--<label style="margin-left:7%;display: none"><input type="radio" value="2" name="state"checked="cheched" ></label>-->
                        </td>
                    </tr>  
                    
               
                    
                    <tr>  
                        <td colspan="5" id="handleOpt_id3">
                        <label style="margin-left:10%" ><input type="radio" value="3" name="state" >条件尚不完全具备、需要继续研究论证的法规项目</label>
                        <!--<label style="margin-left:7%;display: none"><input type="radio" value="2" name="state"checked="cheched" ></label>-->
                        </td>
                    </tr>  
                    
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "提交");%></button>            
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
              
               
            })   
            
            
        </script>
    </body>
</html>
