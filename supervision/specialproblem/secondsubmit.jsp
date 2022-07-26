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
    RssList entity = new RssList(pageContext, "supervision_specific_issue");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_specific_issue");
    entity2.request();
   
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    String title = "特定问题调查";
    if ( entity.get("state").equals("1") ){
        title = "审议成立特定问题调查委员会";
    }
    else if ( entity.get("state").equals("2") && entity.get("initiator").equals("3") ) {
         title = "审议成立特定问题调查委员会";
    }
    
    int state = 0 ;
    int isSongjiaoSuccess = 0 ;
    
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {         
            case "committeAuditagree":                 
                entity.keyvalue("state",4 );   
                entity.keyvalue("committeeagree",1);
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));                   
                entity.update().where("id=?", req.get("id")).submit();                 
               
                break;
            case "committeAuditdisagree":                
                entity.keyvalue("state",5 );   
                entity.keyvalue("committeeagree",2);
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));                   
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
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>           
                    <%
                    if ( entity.get("initiator").equals("1") || entity.get("initiator").equals("2"))  {      
                    %>                       
                    <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="3"><% 
                            if ( entity.get("initiator").equals("1") ) {
                                 out.print("人民政府");
                             }
                           
                             else if ( entity.get("initiator").equals("2") ) {
                                 out.print( "主任会议" );
                             }
                            else if ( entity.get("initiator").equals("3") ) {
                                 out.print( "常委会成员联名" );
                             }
                        %>
                        </td>                     
                    </tr>
                     <%
                    }else{
                    %>
                     <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="5"><% 
                            if ( entity.get("initiator").equals("1") ) {
                                 out.print("人民政府");
                             }
                           
                             else if ( entity.get("initiator").equals("2") ) {
                                 out.print( "主任会议" );
                             }
                            else if ( entity.get("initiator").equals("3") ) {
                                 out.print( "常委会成员联名" );
                             }
                        %>
                        </td>
                    </tr>
                     <%
                     };
                     %>

                    
              
                <tr>
                <td class="w120 dce" >常委会联名成员</td>
                <td colspan="5"><% 
                    String[] cocommittees = entity.get("cocommittee").split(",");
                    int objects = 0 ;
                    for ( int i = 0 ; i < cocommittees.length; i ++ ) {
                          if ( objects > 0 ){
                             out.print("     ");
                            out.print(",");
                            out.print("     ");
                          }
                          list.select().where("state=2 and myid="+ cocommittees[i] ).get_first_rows();
                          out.print(list.get("realname"));
                          objects ++ ;

                      }
                    %></td>
                </tr>
               
                    
                <tr>
                    <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;">发起时间</td>
                    <td colspan="3" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>

                      <td class="w120 dce" >当前进度</td>
                    <td>
                    <%
                    out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议中</b>" );  
                    %>
                    </td>
                  </tr>
                    
                  
                    
             
                <tr>
                    <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会时间</td>
                    <td rssdate="<% entity.write("directorshijian"); %>,yyyy-MM-dd" colspan="3"></td>


                    <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑">会议届次</td>
                    <td><% entity.write("directormeetingnum"); %></td>
                    </td>

                </tr>                  

                <tr>
                   <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑">常委会议时间</td>
                   <td colspan="3" rssdate="<% entity.write("committeeshijian"); %>,yyyy-MM-dd" ></td>
                   <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会议届次</td>
                   <td colspan="5"><% entity.write("committeemeetingnum"); %></td>
                   </td>
                </tr>
                
                    
                    
                  
                    
                 
                        


                <tr>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">成立委员会文件</td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry0 = {"", "", ""};
                     if (!entity.get("enclosure").isEmpty()) {
                         String[] str1 = entity.get("enclosure").split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry0[idx] = str1[idx];
                 %>
                 <%  entity.write("enclosurename"); %><a href="/upfile/<% out.print( arry0[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
                </tr>
                
 
                    
        <tr>
            <td  class="dce">常委会决定</td>
            <td colspan="5" >
                <label><input type="radio" value="1" name="committeeagree" checked="cheched" >同意</label>
                <label style="margin-left:8%;"><input type="radio" value="2" name="committeeagree">不同意</label>                
            </td>
        </tr>
      
  


        <%

        String[] arry = {"", "", ""};
        int index = 0 ;
        boolean isEmpty = true ;
        if (!entity.get("enclosure1").isEmpty()) {
            String[] str1 = entity.get("enclosure1").split(",");
            for ( index = 0; index < str1.length; index ++) {
                arry[ index ] = str1[ index ];
                isEmpty = false ;
            }
        }
        if ( !isEmpty ) {
        %>

        <tr> 
        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会审议意见</td>
        <td colspan="2">                 
        <%  entity.write("enclosurename1"); %><td><a href="/upfile/<% out.print( arry[ index ] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px">点击查看</a>
        </td>   
        </tr>     
        <%
        }
        %>

        <tr> 
        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会审议意见</td>
        <td colspan="5">
            <div>
            <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
            <input type="hidden" name="enclosure2" id="enclosure1" value="<% entity.write("enclosure2"); %>" >
            <input type="hidden" name="enclosurename2" id="enclosurename1" value="<% entity.write("enclosurename2"); %>" >
            <input type="hidden" id="state" value="<% entity.write("state"); %>">

            </div>
        </td>
        </tr>         

          
    
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                    out.print("committeAuditagree");                
                %>" />
                <button id= "adutibtn" type="submit"><%                     
                    out.print( "同意");
                %></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
            var $tt = $("#state").val();
          
            //常委会审议       
            $('input[name="committeeagree"]').click(function () {
                //alert( $(this).val() );
                if ( $(this).val() == 1 || $(this).val() == 0 ){
                    $("#adutibtn").text("同意");                               
                    $("input[name='action']").val("committeAuditagree");     
                    $("input[name='committeeagree']").value("1");      
                    //$("#agreechek").val("1");
                } else{                   
                  $("#adutibtn").text("不同意");                                                 
                  $("input[name='action']").val("committeAuditdisagree");
                  $("input[name='committeeagree']").value("2");   
                  //$("#agreechek").val("2");
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
                    $("input[name='enclosure2']").val(data.url);
                    $("input[name='enclosurename2']").val(filename);
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='enclosure1']").val(data.url);
                    $("input[name='enclosurename1']").val(filename);
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
                    alert("上传成功");
                }});
            return false;
        })
 
        </script>
    </body>
</html>
