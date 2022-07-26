<%-- 
    Document   : butreview
    Created on : 2021-3-23, 19:33:48
    Author     : Administrator
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
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
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%
 StaffList.IsLogin(request, response);
        RssList entity = new RssList(pageContext, "shenchadengji");
        CookieHelper cookies = new CookieHelper(request, response);
        HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
        entity.request();
        
        
        RssList entity2 = new RssList(pageContext, "shenchadengji"); 
        entity2.request();
        
       
      if(!entity.get("action").isEmpty()){
                  
//            if (entity.get("replyinfo").isEmpty()) {
//                entity.keyvalue("replyinfo", StringExtend.substr(StringExtend.delHtmlTag( entity2.get("replyinfo")), 120));
//                entity.update().where("id=?", entity.get("id")).submit();
//            }
            
            //写回复信息
            RssList entityReply = new RssList(pageContext, "justice_reply"); 
            entityReply.request();
          
            
//            entityReply.select().where("relationid=" + req.get("id") + " and replyid=" + UserList.MyID(request) ).get_first_rows();
           
            
            entityReply.keyvalue("replyid", UserList.MyID(request) );
            entityReply.keyvalue("relationid", req.get("id") );
            entityReply.keyvalue("replyinfo", entity2.get("replyinfo") );
            entityReply.keyvalue("filename", entity.get("replyinfo") );
            
           
           
            entityReply.keyvalue("id",  entityReply.autoid );
            entityReply.append().submit() ;
            
            
            
                  
           PoPupHelper.adapter(out).iframereload();
           PoPupHelper.adapter(out).showSucceed();
            
          }
        entity.select().where("id=?", req.get("id")).get_first_rows();
       
            
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
            tr>td .xzz{width: 70%;height: 99%;border: 0px;}
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 1px 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 99%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin;}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            #smalltab{width: 99%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 2px 10px;}
            .h210{height: 210px}
            .sel{background:#dce6f5; }
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            .disnone{display: none}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .butreturn{border: 1px yellow solid;border-radius: 28%;padding: 3px;font-size: x-small;background-color: darkgray;}
            .scyj em{margin-left: 10%}
            .scsm input{width: 98%;border: 0px;};
            .fsry .selectscr{cursor: pointer}
            .fsry .selectscra{cursor: pointer;}
            .red{
                cursor: pointer;
            }
             #selcompanysend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
          
                    <tr class="yjsm"  >
                        <td  class="w120 dce" colspan="2">
                            修改说明
                        </td>
                        <td colspan="8" class="scsm">
                            <textarea style="height:60px;width:98%;" placeholder="（如果需要修改，请这里说明理由修改的原由）" type="text" name="xiugaiyuanyin"></textarea>
                        </td>
                    </tr>
                
                    
                  <tr class="dce">
                        <td colspan="6" class="marginauto uetd">
                            <!--<ul><li class="sel" style="font-size:16px;font-family: 微软雅黑">内容</li></ul>-->
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="replyinfo" name="replyinfo" class="w750" type="text/plain">
                                <% entity2.write("replyinfo"); %>
                            </script>
                        </td>
                    </tr>    
                     
                </table>
            </div>
           

            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit" class="sub">确定</button> 
            </div>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script>
        
        </script>
        </form>
    </body>
</html>
