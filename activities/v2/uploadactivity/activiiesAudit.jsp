<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Options"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*,java.text.*"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssList entity = new RssList(pageContext, "activities"); //activities_upload
    entity.request();
  
    entity.select().where("id=?",req.get("id") ).get_first_rows();
   
    
    //履职排名表
     RssList ranktable = new RssList(pageContext, "activities_rank");
     ranktable.request();
     ranktable.select().where("realname like '%" + URLDecoder.decode(ranktable.get("realname"), "utf-8") + "%'").get_page_desc("id");

 
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity2.timestamp();
//                entity2.remove("userid");
                
                //插入履职排行榜
                if ( entity.get( "evaluateResult").equals("2") ) {
                    
                     
                //审核通过,更新 privateaudit //2021/9/29     
                entity.remove("evaluateResult");
                //entity.remove("auditstate");
                //entity.keyvalue("auditstate",1 );
                entity.remove("privateaudit");
                entity.keyvalue("privateaudit",1 );

                
                entity.update().where("id=" + req.get("id") ).submit();
                      
                out.print("<script>alert('审核通过')</script>");
                }
                else {

     
                    entity.remove("evaluateResult");
                    //entity.remove("auditstate");
                    //entity.keyvalue("auditstate", 2 );
                    
                    entity.remove("privateaudit");
                    entity.keyvalue("privateaudit",2 );
                    entity.update().where("id=" + req.get("id") ).submit();
                    out.print("<script>alert('审核不通过')</script>");
              
                }
                
                 
              
                break;
            case "update":
//                entity2.remove("userid");
//                entity2.update().where("id=" + entity2.get("id")).submit();
//                user.delete().where("activitiesid=" + entity2.get("id") + "").submit();
                 // out.print("<script>alert('更新')</script>");
              
                break;
        }
        
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
//    entity.select().where("id=?",entity.get("id") ).get_first_rows();
  
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
            .cellbor{border: 1}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: 1;line-height: 34px;position: relative;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            .w250{width: 94%;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                         <td><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">类型</td>                       
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                 
                    <tr>
                        <td class="dce w100 ">发起时间</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                   
                     <tr>
                        <td class="dce w100 ">履职时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                      <tr>
                        <td class="dce w100 ">参与代表</td>
                        <td id="unseluserlist">
                            <%
 
                                RssList list_user = new RssList(pageContext, "user");
                                
                                String uids = entity.get("userid");
                                if ( !uids.isEmpty() ) {
                                String datasplit [] = uids.split(",");
                                String realname = "";
                                for ( int i = 0 ; i < datasplit.length ; i ++ ) {                                 
                                    list_user.remove( );
                                    list_user.select().where("myid=" + datasplit[i] ).get_first_rows(); 
                                    realname += list_user.get("realname") + "  ";
                                }    
                                out.print(realname);
                                }
                                else {
                                    String realname = "";
                                    list_user.select().where("myid=" + entity.get("myid") ).get_first_rows(); 
                                    realname += list_user.get("realname") + "  ";
                                   out.print(realname);

                                }
                            %>

                        </td>
                    </tr>
                   
                     <tr>
                        <td class="dce w100 ">附件</td>
                        <td>
                            <%
                                String[] arry1 = {"", "", ""};
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity.get("enclosure").split(",");
                                    String[] str2 = entity.get("enclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                                        arry2[idx] = str2[idx];
                            %>
                            
                            <input readonly="true" class="xz"  style="border:none" value="<% out.print(arry2[idx]); %>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;font-weight: bold;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    <tr>
                    
                 
                 
                   <tr>
                        <td class="dce w100 ">审核状态</td>
                      
                        <td><%
                                if ( entity.get("privateaudit").equals("1") ) {
                                    out.print("<b style='color:green;font-size:14px;' >已审核通过</b>") ;
                                }
                                else if ( entity.get("privateaudit").equals("2") ) {                                
                                    out.print("<b style='color:red;font-size:14px;' >审核未通过</b>") ;
                                }
                                else {                           
                                  out.print("<b style='color:orange;font-size:14px;' >未审核</b>") ;
                                }
                                %></td>                           
                             
                             <td>                 
                    </tr>
                    
                    <tr>
                        <td class="dce w100"><span>活动内容</span></td>
                        <td><div class="textareadiv"><% entity.write("matter"); %></div></td>
                    </tr>
                    
                    
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
         
             
            
            <div class="footer">
                <%
                //if ( userlist.get("attendancetype").equals("2") ) {
                %>   
               
                <input type="hidden" name="action" value="<% out.print("append");%>" />
                <button style="float:left;" type="submit"  ><% out.print("审核不通过");%></button>
                <button type="submit"><% out.print("审核通过");%></button>
                <input name="evaluateResult" type="hidden">
                <%
               //}
                %>   
            </div>
            
            
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                           
            $('.footer button:first').click(function () {
                $('[name=evaluateResult]').val(1);
                //alert("11111111");
            });
            $('.footer button:last').click(function () {
                $('[name=evaluateResult]').val(2);
                 //alert("22222");
            });
                           
        </script>
    </body>
</html>
