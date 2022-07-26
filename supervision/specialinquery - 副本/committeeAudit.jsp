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
      
         
            case "submittocommittee"://
                //out.print("<script>alert('committeAuditFinish')</script>");
                entity.keyvalue("state",15 );   
              
                //entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                //entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));     
               
                entity.update().where("id=?", req.get("id")).submit();  
               
               
                break;    
         
          
        }
        
        
        
        //送交成功以后，如果多个单位
        if ( isSongjiaoSuccess == 1 ) {
            String str = entity2.get("userroleid");
            String[] arry = str.split(",");
//            if ( arry.length > 1 ) 
            {
                RssList roleEntity = new RssList(pageContext, "supervision_userrole_specialwork");
                roleEntity.request();
                for (int i = 0; i < arry.length; i++ ) {
                  if ( !arry[i].isEmpty() ) {
                    roleEntity.remove("id");
                    
                    
                    //time
                    roleEntity.keyvalue("directorshijian", entity.get("directorshijian") ); 
                    roleEntity.keyvalue("directormeetingnum", entity.get("directormeetingnum") ); 
                    
                    roleEntity.keyvalue("iid", entity2.get("id") );
                    //roleEntity.keyvalue("userroleid", entity.get("myid") );   
                    roleEntity.keyvalue("relationid", entity.get("myid") ); 
                     
                    //roleEntity.keyvalue("myid", arry[i] );   
                    
                    roleEntity.keyvalue("userroleid", arry[i] );
                     roleEntity.keyvalue("myid",  arry[i] );
                    //roleEntity.keyvalue("state", entity.get("state") ); 
                    roleEntity.keyvalue("state", 4 ); 
                    roleEntity.keyvalue("title",entity.get("title"));
                    roleEntity.keyvalue("notice",entity.get("notice"));
                    
                    roleEntity.keyvalue("shijian",entity.get("shijian"));
                    roleEntity.keyvalue("reviewclass",entity.get("reviewclass"));
                    roleEntity.keyvalue("initiator",entity.get("initiator"));
                    roleEntity.keyvalue("typeid",entity.get("typeid"));
                    roleEntity.keyvalue("lwstate",entity.get("lwstate"));
                    //实施方案
                    roleEntity.keyvalue("enclosure",entity.get("enclosure"));
                    roleEntity.keyvalue("enclosurename",entity.get("enclosurename"));  
                    //视察调研报告
                    roleEntity.keyvalue("enclosure1",entity2.get("enclosure1"));
                    roleEntity.keyvalue("enclosurename1",entity2.get("enclosurename1"));   
                    
                  
                    roleEntity.append().submit();

                  }
                }
            }
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
                  
                        out.print( "<b style='color:DarkOrange;font-size:14px;' >专题询问会中</b>" ); 
                                
                    %>
                    </td>
                  </tr>
                    
                  
           
                          

                <tr class="committeemeeting">                     
                 <td class="dce w120" style="font-size:15px;font-family: 微软雅黑" >常委会会议时间<em class="red">*</em>
                 </td>

                 <td colspan="3" style="font-size:15px">
                   <input type="text" class="w200 Wdate" name="committeeshijian"  rssdate="<% out.print(entity.get("committeeshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                 </td>


                 <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会会议届次</td>
                 <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="committeemeetingnum" value="<% entity.write("committeemeetingnum"); %>" /><label class="labtitle"></label></td>
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
                        


                
                
                
 

       
<!--            
            <tr>
                <td  class="dce">常委会决定</td>
                <td colspan="5" id="evaluation">
                    <label><input type="radio" value="1" name="agree" checked="cheched" >同意</label>
                    <label style="margin-left:8%;"><input type="radio" value="2" name="agree">不同意</label>                
                </td>
            </tr>
            -->
        
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                   
                    out.print("submittocommittee");
                    
                 
                %>" />
                <button id= "adutibtn" type="submit"><% 
                   
                    out.print( "确认");
                   
              
                %></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
                <input type="hidden" id="agreechek" value="<% entity2.write("agree"); %>">
             
             
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
            var $tt = $("#state").val();
         
            
//            $('input[name="agree"]').click(function () {
//                
//                if ($(this).val() == 1){
//                    $("#adutibtn").text("同意提交常委会");                
//                    //$("input[name='action']").val("directormeetingagree");
//                     
//                    $("#agreechek").val("1");
//                    if ($tt == 1 ) { //提交主任会
//                      $(".committeemeeting").show();   
//                    }
//                } else{                   
//                   $("#adutibtn").text("不同意");                               
//                  // $("input[name='action']").val("directormeetingdisagree");
//                   
//                    $("#agreechek").val("2");
//                    if ($tt == 1 ) { //提交主任会
//                      $(".committeemeeting").hide();   
//                    }
//                }
//            });
            
//            
//            //常委会审议       
//            $('input[name="agree"]').click(function () {
//                //alert( $(this).val() );
//                if ($(this).val() == 1 || $(this).val() == 0){
//                    $("#adutibtn").text("同意");                               
//                    $("input[name='action']").val("directoragree");     
//                    $("input[name='agree']").value("1");         
//                } else{                   
//                  $("#adutibtn").text("不同意");                                                 
//                  $("input[name='action']").val("directordisagree");
//                  $("input[name='agree']").value("2");    
//                }
//            });
//            
//        
// 
            
            
          
            
            $(".footer>button").click(function () {   
                       
                if( $tt ==  1 ){                   
                    var $agree = $("#agreechek").val();      
                    //$initiator
                    if ( ( $agree == 1 || $agree == 0 ) && $initiator == 3 ) {
                      
                    if ($("[name='committeeshijian']").val() != undefined && $("[name='committeeshijian']").val() != "") {
                        var timestamp = new Date($("[name='committeeshijian']").val());
                        $("[name='committeeshijian']").val(timestamp / 1000);
                    }
                    else {
                          alert("请添加常委会会议时间");
                          $("[name='committeeshijian']").focus();
                           return false;
                    }                  
                }
                    
              }
                
            })   
            
     
        </script>
    </body>
</html>
