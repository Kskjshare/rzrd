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
            
            case "confirm": //主任会议同意成立调查委员会    
                if ( entity2.get("agree").equals("2") ) {//不同意
                   // out.print("<script>alert('confirm 2 主任会议不同意成立调查委员会')</script>");
                    entity.keyvalue("state", 3); 
                    entity.keyvalue("agree", entity2.get("agree")); 
                    entity.update().where("id=?", req.get("id")).submit();          
                }
                else {
                   // out.print("<script>alert('confirm 1主任会议同意成立调查委员会')</script>");   
                    if ( entity.get("initiator").equals( "3") )
                    {
                    // out.print( "submit");
                    //提交主任会议，更新状态
                    entity.keyvalue("state", 2);     // 2     
                    entity.keyvalue("agree", entity2.get("agree")); 
                    entity.keyvalue("enclosure1",entity2.get("enclosure1"));
                    entity.keyvalue("enclosurename1",entity2.get("enclosurename1"));  


                    entity.keyvalue("committeeshijian",entity2.get("committeeshijian"));
                    entity.keyvalue("committeemeetingnum",entity2.get("committeemeetingnum"));  
                    entity.update().where("id=?", req.get("id")).submit();
                    
                    }
                    else {
                    entity.keyvalue("state",9 );       
                    entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                    entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));   
                    entity.update().where("id=?", req.get("id")).submit();  
                    }
                }
                break;
            case "committeeagree":
                entity.keyvalue("state", 4 );
                entity.keyvalue("committeeagree", 1 );   
                entity.update().where("id=?", req.get("id")).submit();                      
                break;
            case "committeedisagree":
                entity.keyvalue("state", 5 );
                entity.keyvalue("committeeagree", 2 );   
                entity.update().where("id=?", req.get("id")).submit();     
                break;    
            case "directormeetingagree": //主任会议同意成立调查委员会
                //out.print("<script>alert('主任会议同意成立调查委员会')</script>");
                if ( entity.get("initiator").equals( "3") )
                {
                // out.print( "submit");
                //提交主任会议，更新状态
                entity.keyvalue("state", 2);     // 2      
                entity.keyvalue("enclosure1",entity2.get("enclosure1"));
                entity.keyvalue("enclosurename1",entity2.get("enclosurename1"));  
                
               
                entity.keyvalue("committeeshijian",entity2.get("committeeshijian"));
                entity.keyvalue("committeemeetingnum",entity2.get("committeemeetingnum"));  
                entity.update().where("id=?", req.get("id")).submit();                   
                }
                else {
                 // out.print( "committeAuditFinish"); 
                entity.keyvalue("state",9 );       
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));   
                entity.update().where("id=?", req.get("id")).submit();  
                }
               
                break;
            case "directormeetingdisagree"://主任会议不同意成立调查委员会
               // out.print("<script>alert('主任会议不同意成立调查委员会')</script>");
                entity.keyvalue("state", 3); 
                entity.update().where("id=?", req.get("id")).submit();          
                break;   
          
         
            case "committeAuditFinish"://提交常委会审议意见
                //  out.print("<script>alert('committeAuditFinish')</script>");
                entity.keyvalue("state",4 );   
              
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));     
               
                entity.update().where("id=?", req.get("id")).submit();  
               
               
                break;    
          
            case "submit":   
                // out.print("<script>alert('submit')</script>");
                //提交主任会议，更新状态
                entity.keyvalue("state", 2);     // 2      
               
                entity.update().where("id=?", req.get("id")).submit();     
                //out.print("<script>alert('submit')</script>");
                break;
            case "auditpass":
               //   out.print("<script>alert('auditpass')</script>");
                //主任会议审核通过
                entity.keyvalue("state", 3);       //  3       
                entity.update().where("id=?", req.get("id")).submit();
                //out.print("<script>alert('auditpass')</script>");
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
                  <!--      <td class="w100 dce">类别</td>
                        <td colspan="3"><% entity.write("lwstate"); %></td> -->
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

                    
                <%
                if ( entity.get("initiator").equals("3") ) {      
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
<!--                <td class="w100 dce">类别</td>
                <td colspan="3"><% entity.write("lwstate"); %></td> -->
                </tr>
                <%
                }
                %>
                    
                <tr>
                    <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                    <td colspan="3" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>

                      <td class="w100 dce" >当前进度</td>
                    <td>
                    <% 
                    if ( entity.get("state").equals("1") ) {
                        if ( entity.get("initiator").equals("3") ) {
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                        }else {
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >待议常委会审议</b>" ); 
                        }
                    }
                    else if ( entity.get("state").equals("2") )
                    out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议中</b>" ); 
                    else if ( entity.get("state").equals("3") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >方案实施中</b>" );
                    else if ( entity.get("state").equals("4") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >准备专项报告中</b>" );
                    else if ( entity.get("state").equals("5") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                    else if ( entity.get("state").equals("6") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >意见征求已通过</b>" );                       
                    %>
                    </td>
                  </tr>
                    
                  
                    
                <%
                if ( entity.get("initiator").equals("3") ){
                %>      
                <tr>
                    <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会时间</td>
                    <td rssdate="<% entity.write("directorshijian"); %>,yyyy-MM-dd" colspan="3"></td>


                    <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">会议届次</td>
                    <td><% entity.write("directormeetingnum"); %></td>
                    </td>

                </tr>

                <% 
                }
                %>
                          

                <%
                if ( entity.get("initiator").equals("3") ){
                    if ( entity.get("state").equals("1") ) {
                %>  
                 <tr class="committeemeeting">                     
                  <td class="dce w120" style="font-size:15px;font-family: 微软雅黑" >常委会会议时间<em class="red">*</em>
                  </td>

                  <td colspan="3" style="font-size:15px">
                    <input type="text" class="w200 Wdate" name="committeeshijian"  rssdate="<% out.print(entity.get("committeeshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                  </td>


                  <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会会议届次<em class="red">*</em></td>
                  <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" maxlength="100" type="text" class="w98" name="committeemeetingnum" value="<% entity.write("committeemeetingnum"); %>" /><label class="labtitle"></label></td>
                   </tr>
                    <%
                    }else{
                    %>     
                   <tr>
                      <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">常委会议时间</td>
                      <td rssdate="<% entity.write("committeeshijian"); %>,yyyy-MM-dd" colspan="2"></td>


                      <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">常委会议届次</td>
                      <td><% entity.write("committeemeetingnum"); %></td>
                      </td>
                   </tr>
                   <% 
                   }
                }
                %>
                    
                    
                  
                    
                 
                        


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
                
                
                
                
                   
            <% if ( state == 1 && !entity.get("initiator").equals("3")) {//常委会审议
            %>
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会审议意见</td>
            <td colspan="5">
                <div>
                <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="enclosure2" id="enclosure2" value="<% entity.write("enclosure2"); %>" >
                <input type="hidden" name="enclosurename2" id="enclosurename2" value="<% entity.write("enclosurename2"); %>" >
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                <input type="hidden" name="initiator" value="<% entity.write("initiator"); %>">
                </div>
            </td>
            <%
            }
            %>
                    
           
            
            
        <% 
        if (state == 1 && !entity.get("initiator").equals("3")) {
        %>  
        <tr>
            <td  class="dce">常委会决定</td>
            <td colspan="5" >
                <label><input type="radio" value="1" name="committeeagree" checked="cheched" >同意</label>
                <label style="margin-left:8%;"><input type="radio" value="2" name="committeeagree">不同意</label>                
            </td>
        </tr>
        <% 
        }if (state == 2 && entity.get("initiator").equals("3")) {
        %> 
        <tr>
            <td  class="dce">常委会决定</td>
            <td colspan="5" >
                <label><input type="radio" value="1" name="committeeagree" checked="cheched" >同意</label>
                <label style="margin-left:8%;"><input type="radio" value="2" name="committeeagree">不同意</label>                
            </td>
        </tr>
        <% 
        }
        %> 
            
            
            
                
            <% if (  entity.get("initiator").equals("3")) {
            %> 
            <% if (state == 1 ) {
            %> 
            
            <tr>
                <td  class="dce">主任会议决定</td>
                <td colspan="5" id="evaluation">
                    <label><input type="radio" value="1" name="agree" checked="cheched" >同意</label>
                    <label style="margin-left:8%;"><input type="radio" value="2" name="agree">不同意</label>                
                </td>
            </tr>
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会审议意见</td>
            <td colspan="5">
                <div>
                <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="enclosure1" id="enclosure1" value="<% entity.write("enclosure1"); %>" >
                <input type="hidden" name="enclosurename1" id="enclosurename1" value="<% entity.write("enclosurename1"); %>" >
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>
            <% 
            }else{
            %> 
            
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
            <td colspan="5" style="font-weight:bold;">                 
            <%  entity.write("enclosurename1"); %><a href="/upfile/<% out.print( arry[ index ] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float: right;margin-right: 10%;">点击查看</a>
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
                     
            
             <%
            }
            %>
            
            
            
            <%
            }
            %>
            
    
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                    if ( entity.get("state").equals( "1") ) {
                        if ( entity.get("initiator").equals( "3") )
                        {
                           // out.print( "submit");
                            out.print( "confirm");
                        }
                        else {
                          out.print( "committeeagree"); 
                        }
                        
                        
                        
                        
                         
                    }
                    else if ( entity.get("state").equals( "2")) {
                         out.print("committeAuditFinish");
                    }
                    else if ( entity.get("state").equals( "3")){
                         out.print( "report");
                    }
                 
                %>" />
                <button id= "adutibtn" type="submit"><% 
                     if ( entity.get("state").equals( "1") ) {
                          out.print( "同意");
                    }
                    else if ( entity.get("state").equals( "2")) {
                         out.print("审议通过");
                    }
                    else if ( entity.get("state").equals( "3")){
                         out.print( "确认交送");
                    }
                    else if ( entity.get("state").equals( "4")){
                         out.print( "征求意见"); //相关委室征求意见
                    }
              
                %></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
                <input type="hidden" id="agreechek" value="<% entity.write("agree"); %>">
               
                <input name="initiator" type="hidden" value="<% entity.write("initiator"); %>">
              
               
             
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
            var $tt = $("#state").val();
           
            var $initiator = $("#initiator").val();
           
            
            $('input[name="agree"]').click(function () {
                
                if ($(this).val() == 1){
                    $("#adutibtn").text("同意提交常委会");                
                    //$("input[name='action']").val("directormeetingagree");
                     
                    $("#agreechek").val("1");
                    if ($tt == 1 ) { //提交主任会
                      $(".committeemeeting").show();   
                    }
                } else{                   
                   $("#adutibtn").text("不同意");                               
                  // $("input[name='action']").val("directormeetingdisagree");
                   
                    $("#agreechek").val("2");
                    if ($tt == 1 ) { //提交主任会
                      $(".committeemeeting").hide();   
                    }
                }
            });
            
            
            //常委会审议       
            $('input[name="committeeagree"]').click(function () {
                //alert( $(this).val() );
                if ($(this).val() == 1 || $(this).val() == 0){
                    $("#adutibtn").text("同意");                               
                    $("input[name='action']").val("committeeagree");     
                    $("input[name='committeeagree']").value("1");         
                } else{                   
                  $("#adutibtn").text("不同意");                                                 
                  $("input[name='action']").val("committeedisagree");
                  $("input[name='committeeagree']").value("2");    
                }
            });
            
        
 
            
            
          
            
            $(".footer>button").click(function () {   
                var $tt = $("#state").val();
 
                
                if ($tt == 3 ) { //完成调研视察报告，提交专项报告单位才判断
                    if ($("[name='enclosure1']").val() == undefined || $("[name='enclosure1']").val() == "") {
                        alert("请添加报告文件");
                        $("[name='enclosure1']").focus();
                        return false;
                    }
                } 
                var $agree = $("#agreechek").val();   
                var $initiator1 = $("[name='initiator']").val() ;
              
                if( $tt ==  1 ){                   

                    if ( ( $agree == 1 || $agree == 0 ) && $initiator1 == 3 ) {
                      
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
                    //$("input[name='enclosure1']").val(data.url);
                    //$("input[name='enclosurename1']").val(filename);
                    var $initiator = $('input[name="initiator"]').val();             
                    if ( $tt == 1 ) {  //常委会审议议案
                        
                        if ( $initiator == 6 ) {
                            $("input[name='enclosure1']").val(data.url);
                            $("input[name='enclosurename1']").val(filename);
                        }
                        else {
                              $("input[name='enclosure2']").val(data.url);
                            $("input[name='enclosurename2']").val(filename);
                        }
                       //alert($initiator)
                       
                        //alert(filename)
                       
                    }
                    else if ( $tt == 2 ) {
                        $("input[name='enclosure2']").val(data.url);
                        $("input[name='enclosurename2']").val(filename);
                        
                    }
                    else if ( $tt == 8 ) {  //人大常委会审议会议文件
                        $("input[name='enclosure4']").val(data.url);
                        $("input[name='enclosurename4']").val(filename);
                    }
                
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
             RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
         });

        </script>
    </body>
</html>
