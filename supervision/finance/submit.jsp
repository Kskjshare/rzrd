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
    
    String title = "听取国民经济和社会发展计划、财政预算执行及审计工作流程";
    
    String str_item1 = "报告草案";
    String str_item2 = "计划依据";
     String str_item3 = "计划目标";
    String str_item4 = "项目明细";
    String str_item5 = "其他需要说明的情况";
    String str_item6 = "其他资料";
  
    String str_item7 = "";
    String str_item8 = "";
    
    
    
   
    
    int state = 0 ;
    int isSongjiaoSuccess = 0 ;
    
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            
            case "confirm": //主任会议同意成立调查委员会    
                if ( entity2.get("agree").equals("2") ) {//不同意
                    out.print("<script>alert('confirm 2 主任会议不同意成立调查委员会')</script>");
                    entity.keyvalue("state", 3); 
                    entity.keyvalue("agree", entity2.get("agree")); 
                    entity.update().where("id=?", req.get("id")).submit();          
                }
                else {
                    out.print("<script>alert('confirm 1主任会议同意成立调查委员会')</script>");   
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
                 out.print("<script>alert('committeeagree')</script>");
                 
                entity.keyvalue("state", 4 );
                entity.keyvalue("committeeagree", 1 );   
                //entity.update().where("id=?", req.get("id")).submit();                      
                break;
            case "committeedisagree":
                 out.print("<script>alert('committeedisagree')</script>");
                entity.keyvalue("state", 5 );
                entity.keyvalue("committeeagree", 2 );   
                //entity.update().where("id=?", req.get("id")).submit();     
                break;  
            case "directoragree":
                entity.keyvalue("state", 4 );
                entity.keyvalue("agree", 1 );   
                if ( !entity2.get("enclosure1").isEmpty() ) {
                    entity.keyvalue("enclosure1",entity2.get("enclosure1"));
                    entity.keyvalue("enclosurename1",entity2.get("enclosurename1"));  
                }
                
                if ( !entity2.get("enclosure").isEmpty() ) {
                    entity.keyvalue("enclosure",entity2.get("enclosure"));
                    entity.keyvalue("enclosurename",entity2.get("enclosurename"));  
                }
                
                entity.update().where("id=?", req.get("id")).submit();          
                break;
            case "directordisagree":
                entity.keyvalue("state", 5 );
                entity.keyvalue("agree", 2 );   
                
                if ( !entity2.get("enclosure1").isEmpty() ) {
                    entity.keyvalue("enclosure1",entity2.get("enclosure1"));
                    entity.keyvalue("enclosurename1",entity2.get("enclosurename1"));  
                }
                
                entity.update().where("id=?", req.get("id")).submit();      
                
                break;    
            case "directormeetingagree": //主任会议同意成立调查委员会
                out.print("<script>alert('主任会议同意成立调查委员会')</script>");
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
                out.print("<script>alert('主任会议不同意成立调查委员会')</script>");
                entity.keyvalue("state", 3); 
                entity.update().where("id=?", req.get("id")).submit();          
                break;   
          
         
            case "committeAuditFinish"://提交常委会审议意见
                 // out.print("<script>alert('committeAuditFinish')</script>");
                entity.keyvalue("state",4 );   
              
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));     
               
                entity.update().where("id=?", req.get("id")).submit();  
               
               
                break;    
          
            case "submit":   
                 //out.print("<script>alert('submit')</script>");
     
                entity.keyvalue("state", 2); 
               
                entity.keyvalue("finance_enclosure1",entity2.get("finance_enclosure1"));
                entity.keyvalue("finance_enclosurename1",entity2.get("finance_enclosurename1"));  
                entity.keyvalue("finance_enclosure2",entity2.get("finance_enclosure2"));
                entity.keyvalue("finance_enclosurename2",entity2.get("finance_enclosurename2")); 
                entity.keyvalue("finance_enclosure3",entity2.get("finance_enclosure3"));
                entity.keyvalue("finance_enclosurename3",entity2.get("finance_enclosurename3")); 
                entity.keyvalue("finance_enclosure4",entity2.get("finance_enclosure4"));
                entity.keyvalue("finance_enclosurename4",entity2.get("finance_enclosurename4")); 
                entity.keyvalue("finance_enclosure5",entity2.get("finance_enclosure5"));
                entity.keyvalue("finance_enclosurename5",entity2.get("finance_enclosurename5")); 
                entity.keyvalue("finance_enclosure6",entity2.get("finance_enclosure6"));
                entity.keyvalue("finance_enclosurename6",entity2.get("finance_enclosurename6")); 
                entity.keyvalue("finance_enclosure7",entity2.get("finance_enclosure7"));
                entity.keyvalue("finance_enclosurename7",entity2.get("finance_enclosurename7")); 
                entity.keyvalue("finance_enclosure8",entity2.get("finance_enclosure8"));
                entity.keyvalue("finance_enclosurename8",entity2.get("finance_enclosurename8")); 
                
                
                entity.update().where("id=?", req.get("id")).submit();     
                //out.print("<script>alert('submit')</script>");
                break;
            case "auditpass":
                   //out.print("<script>alert('auditpass')</script>");
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
   


    RssListView user = new RssListView(pageContext, "user_delegation");
    user.request();
    user.select().where("myid=" + entity.get("initiator")).get_first_rows();
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
            
            #fileeform1{position: absolute;left: -10000px;}
            #fileeform2{position: absolute;left: -10000px;}
            #fileeform3{position: absolute;left: -10000px;}
            #fileeform4{position: absolute;left: -10000px;}
            #fileeform5{position: absolute;left: -10000px;}
            #fileeform6{position: absolute;left: -10000px;}
            #fileeform7{position: absolute;left: -10000px;}
            #fileeform8{position: absolute;left: -10000px;}     
             
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #selcompanysend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        
        
        <form id="fileeform1" enctype="multipart/form-data" method="post">
            <input type="file" id="filee1" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform2" enctype="multipart/form-data" method="post">
            <input type="file" id="filee2" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform3" enctype="multipart/form-data" method="post">
            <input type="file" id="filee3" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform4" enctype="multipart/form-data" method="post">
            <input type="file" id="filee4" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform5" enctype="multipart/form-data" method="post">
            <input type="file" id="filee5" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform6" enctype="multipart/form-data" method="post">
            <input type="file" id="filee6" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform7" enctype="multipart/form-data" method="post">
            <input type="file" id="filee7" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform8" enctype="multipart/form-data" method="post">
            <input type="file" id="filee8" accept="." name="file" multiple>
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
                        <td class="w120 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
<!--                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>           -->
                                          
                    <tr>
                        <td class="w120 dce" >发起者</td>
                        <td colspan="5"><% 
                           out.print(user.get("realname"));
                        %>
                        </td>
                    </tr>
                   

                    
                <tr>
                    <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                    <td colspan="3" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>

                      <td class="w120 dce" >当前进度</td>
                    <td>
                    <% 
                    if ( entity.get("state").equals("1") ) {
                       
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >通知已发</b>" ); 
                       
                    }
                    else if ( entity.get("state").equals("2") )
                    out.print( "<b style='color:DarkOrange;font-size:14px;' >调研结束</b>" ); 
                    else if ( entity.get("state").equals("3") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议中</b>" );
                    else if ( entity.get("state").equals("4") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >准备专项报告中</b>" );
                    else if ( entity.get("state").equals("5") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                    else if ( entity.get("state").equals("6") )
                    out.print( "<b style='color:CadetBlue;font-size:14px;' >意见征求已通过</b>" );                       
                    %>
                    </td>
                  </tr>
                                 
                    
            <tr>
            <td class="dce " style="width:160px;font-size:15px;font-family: 微软雅黑">通知文件</td>
            <!--
            <td colspan="2">
               <div>
                   <span id="fjfilechangeFile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击更改方案</span>
                   <input type="hidden" name="enclosure" id="enclosure" value="<% entity2.write("enclosure"); %>" >
                   <input type="hidden" name="enclosurename" id="enclosurename" value="<% entity2.write("enclosurename"); %>" >
                   <input type="hidden" id="state" value="<% entity.write("state"); %>">
               </div>
            </td>
            -->
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
            <td  class="dce">被调研单位</td>
            <td colspan="5" id="evaluation">
                <label><input type="radio" value="1" name="investigationDepartment" checked="cheched" >发改委</label>
                <label style="margin-left:5%;"><input type="radio" value="2" name="investigationDepartment">统计局</label> 
                <label style="margin-left:5%;"><input type="radio" value="3" name="investigationDepartment">财政局</label>  
                <label style="margin-left:5%;"><input type="radio" value="4" name="investigationDepartment">审计局</label>  
                <label style="margin-left:5%;"><input type="radio" value="5" name="investigationDepartment">税务部门</label>  
                <label style="margin-left:5%;"><input type="radio" value="6" name="investigationDepartment">有关部门和单位</label>                    
            </td>
            </tr>
            -->
            
            <tr>
            <td class="dce" >被调研单位<em class="red">*</em></td>
            <td id="selcompanysend" colspan="5"><em selectcompanyuser>点击添加单位</em>                
            </td>                 
            </tr>    
 
            
            
            
            <tr> 
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item1);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile1" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure1" id="finance_enclosure1" value="<% entity2.write("finance_enclosure1"); %>" >
                <input type="hidden" name="finance_enclosurename1" id="finance_enclosurename1" value="<% entity2.write("finance_enclosurename1"); %>" >
                
                </div>
            </td>
            </tr>
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item2);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile2" rid="2" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure2" id="finance_enclosure2" value="<% entity2.write("finance_enclosure2"); %>" >
                <input type="hidden" name="finance_enclosurename2" id="finance_enclosurename2" value="<% entity2.write("finance_enclosurename2"); %>" >
               
                </div>
            </td>
            </tr>
            
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item3);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile3" rid="3" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure3" id="finance_enclosure3" value="<% entity2.write("finance_enclosure3"); %>" >
                <input type="hidden" name="finance_enclosurename3" id="finance_enclosurename3" value="<% entity2.write("finance_enclosurename3"); %>" >               
                </div>
            </td>
            </tr>
            
            
            <tr> 
            <td class="dce w220" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item4);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile4" rid="4" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure4" id="finance_enclosure4" value="<% entity2.write("finance_enclosure4"); %>" >
                <input type="hidden" name="finance_enclosurename4" id="finance_enclosurename4" value="<% entity2.write("finance_enclosurename4"); %>" >
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>
            
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item5);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile5" rid="5" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure5" id="finance_enclosure5" value="<% entity2.write("finance_enclosure5"); %>" >
                <input type="hidden" name="finance_enclosurename5" id="finance_enclosurename5" value="<% entity2.write("finance_enclosurename5"); %>" >               
                </div>
            </td>
            </tr>
            
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item6);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile6" rid="6" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure6" id="finance_enclosure6" value="<% entity2.write("finance_enclosure6"); %>" >
                <input type="hidden" name="finance_enclosurename6" id="finance_enclosurename6" value="<% entity2.write("finance_enclosurename6"); %>" >
               
                </div>
            </td>
            </tr>
            
            
<!--            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item7);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile7" rid="7" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure7" id="finance_enclosure7" value="<% entity2.write("finance_enclosure7"); %>" >
                <input type="hidden" name="finance_enclosurename7" id="finance_enclosurename7" value="<% entity2.write("finance_enclosurename7"); %>" >
               
                </div>
            </td>
            </tr>
            
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑"><%out.print(str_item8);%></td>
            <td colspan="5">
                <div>
                <span id="fjfile8" rid="8" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="finance_enclosure8" id="finance_enclosure8" value="<% entity2.write("finance_enclosure8"); %>" >
                <input type="hidden" name="finance_enclosurename8" id="finance_enclosurename8" value="<% entity2.write("finance_enclosurename8"); %>" >
               
                </div>
            </td>
            </tr>-->
            
            
                
   
            
            <tr> 
            <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会审议意见</td>
            <td colspan="5">
                <div>
                <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="enclosure1" id="enclosure1" value="<% entity2.write("enclosure1"); %>" >
                <input type="hidden" name="enclosurename1" id="enclosurename1" value="<% entity2.write("enclosurename1"); %>" >
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
            </td>
            </tr>
          
    
       
                
                </table>
            </div>
            <div class="footer">
                
                 <input type="hidden" name="action" value="<% 
                    if ( entity.get("state").equals( "1") ) { 
                        out.print( "submit"); 
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
                          out.print( "提交");
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
                <input type="hidden" id="agreechek" value="<% entity2.write("investigationDepartment"); %>">      
                <input type="hidden" id="company" name="company" value="">
             
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>          
            var $tt = $("#state").val();
            var $initiator = $("#initiator").val();
                   
            $('input[name="investigationDepartment"]').click(function () {
                alert( $(this).val() );
                if ($(this).val() == 1 || $(this).val() == 0){
                    $("#adutibtn").text("同意");                               
                    $("input[name='action']").val("directoragree");     
                    $("input[name='investigationDepartment']").value("1");         
                } else{                   
                  $("#adutibtn").text("不同意");                                                 
                  $("input[name='action']").val("directordisagree");
                  $("input[name='investigationDepartment']").value("2");    
                }
            });
            
        
 
            
            
          
            
            $(".footer>button").click(function () {   
               // var $tt = $("#state").val();
                //console.log($tt);
                
                if ($tt == 3 ) { //完成调研视察报告，提交专项报告单位才判断
                    if ($("[name='enclosure1']").val() == undefined || $("[name='enclosure1']").val() == "") {
                        alert("请添加报告文件");
                        $("[name='enclosure1']").focus();
                        return false;
                    }
                } 
              
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
        $("#fjfile1").click(function () {
            $("#filee1").click();
        })
        $("#fjfile2").click(function () {
            $("#filee2").click();
        })
        $("#fjfile3").click(function () {
            $("#filee3").click();
        })
        $("#fjfile4").click(function () {
            $("#filee4").click();
        })
        $("#fjfile5").click(function () {
            $("#filee5").click();
        })
        $("#fjfile6").click(function () {
            $("#filee6").click();
        })
        $("#fjfile7").click(function () {
            $("#filee7").click();
        })
        $("#fjfile8").click(function () {
            $("#filee8").click();
        })
        
        
        $("#fjfilechangeFile").click(function () {
            $("#fileechangeFile").click();    
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
                    $("input[name='enclosure1']").val(data.url);
                    $("input[name='enclosurename1']").val(filename);              
                   
                
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
        
        
        
          $("#filee1").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform1").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile1").text(filename)
                    $("input[name='finance_enclosure1']").val(data.url);
                    $("input[name='finance_enclosurename1']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile1").text("点击选择文件")
                    $("input[name='finance_enclosure1']").val(data.url);
                    $("input[name='finance_enclosurename1']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        
        $("#filee2").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform2").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile2").text(filename)
                    $("input[name='finance_enclosure2']").val(data.url);
                    $("input[name='finance_enclosurename2']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile2").text("点击选择文件")
                    $("input[name='finance_enclosure2']").val(data.url);
                    $("input[name='finance_enclosurename2']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        $("#filee3").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform3").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile3").text(filename)
                    $("input[name='finance_enclosure3']").val(data.url);
                    $("input[name='finance_enclosurename3']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile3").text("点击选择文件")
                    $("input[name='finance_enclosure3']").val(data.url);
                    $("input[name='finance_enclosurename3']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        $("#filee4").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform4").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile4").text(filename)
                    $("input[name='finance_enclosure4']").val(data.url);
                    $("input[name='finance_enclosurename4']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile4").text("点击选择文件")
                    $("input[name='finance_enclosure4']").val(data.url);
                    $("input[name='finance_enclosurename4']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        $("#filee5").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform5").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile5").text(filename)
                    $("input[name='finance_enclosure5']").val(data.url);
                    $("input[name='finance_enclosurename5']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile5").text("点击选择文件")
                    $("input[name='finance_enclosure5']").val(data.url);
                    $("input[name='finance_enclosurename5']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        $("#filee6").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform6").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile6").text(filename)
                    $("input[name='finance_enclosure6']").val(data.url);
                    $("input[name='finance_enclosurename6']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile6").text("点击选择文件")
                    $("input[name='finance_enclosure6']").val(data.url);
                    $("input[name='finance_enclosurename6']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        
        $("#filee7").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform7").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile7").text(filename)
                    $("input[name='finance_enclosure7']").val(data.url);
                    $("input[name='finance_enclosurename7']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile7").text("点击选择文件")
                    $("input[name='finance_enclosure7']").val(data.url);
                    $("input[name='finance_enclosurename7']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        $("#filee8").change(function () {
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeform8").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
               
                    $("#fjfile8").text(filename)
                    $("input[name='finance_enclosure8']").val(data.url);
                    $("input[name='finance_enclosurename8']").val(filename);              
                   
                
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfile8").text("点击选择文件")
                    $("input[name='finance_enclosure8']").val(data.url);
                    $("input[name='finance_enclosurename8']").val(filename);
                    alert("未上传")
                }
   
                }});
            return false;
        })
        
        
        
     $("#fileechangeFile").change(function () {        
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeformchangeFile").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
                
                    $("#fjfilechangeFile").text(filename)
                    $("input[name='enclosure']").val(data.url);
                    $("input[name='enclosurename']").val(filename);
                   
                    
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfilechangeFile").text("点击选择文件")
                    $("input[name='enclosure']").val(data.url);
                    $("input[name='enclosurename']").val(filename);
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
             RssWin.open("/supervision/finance/selectfinancerole.jsp", 700, 320);
//              RssWin.open("/supervision/finance/选择单位.jsp", 700, 320);
             
        });
              
        
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
