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
    RssList entity = new RssList(pageContext, "supervision_specialwork");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_specialwork");
    entity2.request();
   
    
    RssList userrole = new RssList(pageContext, "supervision_userrole_specialwork");
    userrole.request();
    
    int state = 0 ;
    int isSongjiaoSuccess = 0 ;
    
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
   
     if (!entity.get("action").isEmpty()) {
      
        switch (entity.get("action")) {
            case "submit":     
                        
                //提交主任会议，更新状态
                entity.keyvalue("state", 2);     // 2                        
                entity.update().where("id=?", req.get("id")).submit();           

                //out.print("<script>alert('submit')</script>");
                break;
            case "auditpass":
                //主任会议审核通过
                entity.keyvalue("state", 3);       //  3       
              
                
                if ( !entity2.get("enclosure").isEmpty() ){             
                entity.keyvalue("enclosure",entity2.get("enclosure"));
                entity.keyvalue("enclosurename",entity2.get("enclosurename"));   
                }
               entity.update().where("id=?", req.get("id")).submit();
                //out.print("<script>alert('auditpass')</script>");
                break;
            case "report": //送交
                            
                //entity.update().where("id=?", req.get("id")).submit();
                //out.print("<script>alert('report')</script>");
                
                //新增一条记录，把原来的记录值赋值到新纪录。 然后删除之前的记录
//                entity2.remove("id");
//                entity2.keyvalue("state", 4 ); 
//                entity2.keyvalue("title",entity.get("title"));
//                entity2.keyvalue("notice",entity.get("notice"));
//                entity2.keyvalue("myid",entity.get("myid"));
//                entity2.keyvalue("shijian",entity.get("shijian"));
//                entity2.keyvalue("reviewclass",entity.get("reviewclass"));
//                entity2.keyvalue("initiator",entity.get("initiator"));
//                entity2.keyvalue("typeid",entity.get("typeid"));
//                entity2.keyvalue("lwstate",entity.get("lwstate"));
//                entity2.keyvalue("enclosure",entity.get("enclosure"));
//                entity2.keyvalue("enclosurename",entity.get("enclosurename"));
//                               
//                entity2.append().submit();
//                entity.delete().where("id=?", req.get("id")).submit();
                
                 entity.keyvalue("state",4);
                 entity.keyvalue("enclosure1",entity2.get("enclosure1"));
                 entity.keyvalue("enclosurename1",entity2.get("enclosurename1"));   
                 entity.update().where("id=?", req.get("id")).submit();
                
                
                
                isSongjiaoSuccess =  1 ;
                
               
                break;
            case "sendreportcommittee": 
                entity.keyvalue("taskDone", 1 );  
                entity.keyvalue("state", 13 );  
                entity.keyvalue("enclosure7",entity2.get("enclosure7"));
                entity.keyvalue("enclosurename7",entity2.get("enclosurename7"));   
                entity.update().where("id=?", req.get("id")).submit();  

                userrole.select().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 13 ); 
                userrole.keyvalue("taskDone", 1 );  
                userrole.keyvalue("enclosure7",entity2.get("enclosure7"));
                userrole.keyvalue("enclosurename7",entity2.get("enclosurename7"));   
                //userrole.update().submit();  
                userrole.update().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).submit();
                break;
            case "reinquerylast2": 
                //out.print("<script>alert('reinquerylast2 1')</script>");
                entity.keyvalue("state", 10 );  
                if ( !entity2.get("enclosure6").isEmpty() ) {
                entity.keyvalue("enclosure6",entity2.get("enclosure6"));
                entity.keyvalue("enclosurename6",entity2.get("enclosurename6"));
                }
                entity.update().where("id=?", req.get("id")).submit();  

                userrole.select().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 10 );  
                if ( !entity2.get("enclosure6").isEmpty() ) {
                userrole.keyvalue("enclosure6",entity2.get("enclosure6"));
                userrole.keyvalue("enclosurename6",entity2.get("enclosurename6"));   
                }
                //userrole.update().submit(); 
                userrole.update().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).submit();
                break;
            case "reinquerylast": 
       
                if ( entity2.get("state").equals("11")){
                    //out.print("<script>alert('entity2 1')</script>");
                    entity.keyvalue("state", entity2.get("state") );
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        entity.keyvalue("enclosure6",entity2.get("enclosure6"));
                        entity.keyvalue("enclosurename6",entity2.get("enclosurename6"));  
                    }
                    entity.update().where("id=?", req.get("id")).submit();  

                    userrole.select().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).get_first_rows();
                    userrole.remove("id");
                    userrole.keyvalue("state", entity2.get("state") );  
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        userrole.keyvalue("enclosure6",entity2.get("enclosure6"));
                        userrole.keyvalue("enclosurename6",entity2.get("enclosurename6"));   
                    }
                    //userrole.update().submit();   
                    userrole.update().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).submit();
                }
                else  if ( entity2.get("state").equals("12")){
                    
                    entity.keyvalue("state", entity2.get("state") );
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        entity.keyvalue("enclosure6",entity2.get("enclosure6"));
                        entity.keyvalue("enclosurename6",entity2.get("enclosurename6"));  
                    }
                    entity.update().where("id=?", req.get("id")).submit();  

                    userrole.select().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).get_first_rows();
                    userrole.remove("id");
                    userrole.keyvalue("state", entity2.get("state") );  
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        userrole.keyvalue("enclosure6",entity2.get("enclosure6"));
                        userrole.keyvalue("enclosurename6",entity2.get("enclosurename6"));   
                    }
                    userrole.update().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).submit();
                   // userrole.update().submit(); 
                }
                
               
                
                break;    
            case "reinquery2": 
               
                entity.keyvalue("state", 10 );  
                entity.keyvalue("enclosure5",entity2.get("enclosure5"));
                entity.keyvalue("enclosurename5",entity2.get("enclosurename5"));   
                entity.update().where("id=?", req.get("id")).submit();  

                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 10 );  
                userrole.keyvalue("enclosure5",entity2.get("enclosure5"));
                userrole.keyvalue("enclosurename5",entity2.get("enclosurename5"));   
                //userrole.update().submit();  
                userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                break;
            case "reinquery": //再征求意见    
                //out.print("<script>alert('reinquery')</script>");                
                if ( !entity.get("enclosure2").isEmpty() ) {
                    if ( entity2.get("enclosure2").isEmpty() ) {
                        out.print("<script>alert('请选择根据反馈意见修改后的专项报告')</script>");
                     }
                    else {
                     entity.keyvalue("state", 5 );   
                    entity.update().where("id=?", req.get("id")).submit(); 
                   

                    userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    userrole.keyvalue("state", 5 );   
                    //专项工作报告
                    if ( !entity2.get("enclosure2").isEmpty() ) 
                    {
                        userrole.keyvalue("enclosure2",entity2.get("enclosure2"));
                        userrole.keyvalue("enclosurename2",entity2.get("enclosurename2"));  
                    }
                    
                    userrole.remove("id");
                    //userrole.update().submit();
                    userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                    }
                }
                else {                
                    entity.keyvalue("state", 5 );   
                    entity.update().where("id=?", req.get("id")).submit(); 
                    

                    userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    userrole.keyvalue("state", 5 );   
                    //专项工作报告
                    if ( !entity2.get("enclosure2").isEmpty() ) 
                    {
                        userrole.keyvalue("enclosure2",entity2.get("enclosure2"));
                        userrole.keyvalue("enclosurename2",entity2.get("enclosurename2"));  
                    }
                    userrole.remove("state");
                    userrole.remove("id");
                    //userrole.update().submit();
                    userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                 }
  
 ;  
                break;
            case "submitcommitteAudit": //提交常委会审议
                entity.keyvalue("state", 8 );  
                entity.keyvalue("committeshijian",entity2.get("committeshijian"));
                entity.keyvalue("committemeetingnum",entity2.get("committemeetingnum"));   
                entity.update().where("id=?", req.get("id")).submit();  
               
                userrole.select().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 8 );  
                //userrole.update().submit(); 
                userrole.update().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).submit();
                break;
                
            case "committeAuditFinish"://提交常委会审议意见
                entity.keyvalue("state",9 );  
                
                entity.keyvalue("enclosure4",entity2.get("enclosure4"));
                entity.keyvalue("enclosurename4",entity2.get("enclosurename4"));   
                entity.update().where("id=?", req.get("id")).submit();  
               
                userrole.select().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 9 );  
                userrole.keyvalue("enclosure4",entity2.get("enclosure4"));
                userrole.keyvalue("enclosurename4",entity2.get("enclosurename4"));   
                //userrole.update().submit();  
                userrole.update().where("iid=" + req.get("id") + " and relationid=" + UserList.MyID(request)).submit();
                break;
            case "inquery": //征求意见      承办单位把专题报告送委实征求意见（图中8-->9)
                entity.keyvalue("state", 5 );        
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));   
                
                entity.update().where("id=?", req.get("id")).submit();  
                
                
                //RssList userrole = new RssList(pageContext, "supervision_userrole_specialwork");
                //userrole.request();
   
                
                
                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.keyvalue("state", 5 );   
                //专项工作报告
                userrole.keyvalue("enclosure2",entity2.get("enclosure2"));
                userrole.keyvalue("enclosurename2",entity2.get("enclosurename2"));   
                userrole.remove("id");
                     
//                userrole.update().submit();  

                userrole.update().where("iid=" + req.get("id") + " and userroleid="+ UserList.MyID(request)  ).submit();

                break;
            case "feedback":
             //out.print("<script>alert('feedback')</script>");           
                //如果不同意，则需要把临时编制置空，方便处理流程
                //userrole.keyvalue("enclosuretemp",entity2.get("enclosure5"));//随便设置一个空值
               
                
               // entity.update().where("id=?", req.get("id")).submit();
                 
                if ( entity2.get("state").equals("7") ) { //有反馈意见，则把状态改为5，可以再次征求意见
                   // out.print("<script>alert('审核通过7')</script>");
                    entity.keyvalue("state", 7 ); 
                    
                    if ( entity2.get("enclosure3").isEmpty() ) {
                        out.print("<script>alert('请选择反馈意见文件')</script>");
                    }
                    else {
                    entity.keyvalue("enclosure3",entity2.get("enclosure3"));
                    entity.keyvalue("enclosurename3",entity2.get("enclosurename3"));   
                    
                    entity.update().where("id=?", req.get("id")).submit();
                    
                    //userrole.keyvalue("state", 7 );   
                    //userrole.keyvalue("enclosure3",entity2.get("enclosure3"));
                    //userrole.keyvalue("enclosurename3",entity2.get("enclosurename3"));   
                    //userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    //userrole.update().submit();  
                    
                    
                    RssList userrole1 = new RssList(pageContext, "supervision_userrole_specialwork");
                    userrole1.request();
                    userrole1.select().where("iid=" + req.get("id") ).get_page_desc("id");    
                    while (userrole1.for_in_rows()) {    
                       //  out.print("<script>alert('aaaaaaaa')</script>");
                        userrole1.remove("id");
                        userrole1.keyvalue("state", 7 );  
                        userrole1.keyvalue("enclosure3",entity2.get("enclosure3"));
                        userrole1.keyvalue("enclosurename3",entity2.get("enclosurename3"));
                        userrole1.update().where("iid=" + req.get("id")).submit();          
                    }
                    
                    
                    
                    }
               }
                else {
                    if ( !entity2.get("enclosure3").isEmpty() ) {                 
                    entity.keyvalue("enclosure3",entity2.get("enclosure3"));
                    entity.keyvalue("enclosurename3",entity2.get("enclosurename3"));  
                     }
                    
                    entity.keyvalue("state", 6 ); 
                    entity.update().where("id=?", req.get("id")).submit();  
                    
                    if ( !entity2.get("enclosure3").isEmpty() ) {        
                    userrole.keyvalue("enclosure3",entity2.get("enclosure3"));
                    userrole.keyvalue("enclosurename3",entity2.get("enclosurename3"));   
                    }
                    
                  
                    //userrole.keyvalue("state", 6 );   
                    //userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    //userrole.update().submit();  
                    
                    RssList userrole1 = new RssList(pageContext, "supervision_userrole_specialwork");
                    userrole1.request();
                   // userrole1.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_page_desc("id"); 
                    userrole1.select().where("iid=" + req.get("id") ).get_page_desc("id");    
                    while (userrole1.for_in_rows()) {    
                       //  out.print("<script>alert('aaaaaaaa')</script>");
                         userrole1.remove("id");
                        userrole1.keyvalue("state", 6 );   
                        userrole1.update().where("iid=" + req.get("id")).submit();          
                    }
                }
                
               
                break;
        }
        
        
        
        //送交成功以后，如果多个单位
        if ( isSongjiaoSuccess == 1 ) {
            String str = entity2.get("userroleid");
            String[] arry = str.split(",");
            
//            //应该把送交单位写到原始记录
//            entity.keyvalue("userroleid",str );
//            entity.update().where("id=?", req.get("id")).submit();   
//            //应该把送交单位写到原始记录
            
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
                   <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">听取和审议专项工作报告</td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>
                 
                      
                    <tr>
                        <td class="w100 dce" >发起单位</td>
                        <td colspan="3"><% out.print(entity.get("initiator")); %></td>
                        <td class="w100 dce" >当前进度</td>
                        <td colspan="3">
                        <% 
                        if ( entity.get("state").equals("1") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                        else if ( entity.get("state").equals("2") )
                        out.print( "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>" ); 
                        else if ( entity.get("state").equals("3") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >方案实施中</b>" );
                        else if ( entity.get("state").equals("4") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >准备专项报告中</b>" );
                        else if ( entity.get("state").equals("5") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                        else if ( entity.get("state").equals("6") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >意见征求已通过</b>" );
                        else if ( entity.get("state").equals("7") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >意见已反馈</b>" );
                        else if ( entity.get("state").equals("8") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议中</b>" );
                        else if ( entity.get("state").equals("9") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见</b>" );
                        else if ( entity.get("state").equals("10") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                        else if ( entity.get("state").equals("11") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见已通过</b>" );
                        else if ( entity.get("state").equals("12") )
                        out.print( "<b style='color:CadetBlue;font-size:14px;' >已反馈意见</b>" );
                        %>
                        </td>
                      
                        
                    </tr>
                    <tr>
                        <td  class="w100 dce">类别</td>
                        <td colspan="3"><% entity.write("reviewclass"); %></td>
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                        <td colspan="3" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                          
                    <tr>
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会时间</td>
                        <td rssdate="<% entity.write("directorshijian"); %>,yyyy-MM-dd" colspan="3"></td>
                      
                        
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">会议届次</td>
                        <td><% entity.write("directormeetingnum"); %></td>
                        </td>

                    </tr>
                    
                    <%
                    if ( state >= 8 ) {
                    %>
                     <tr>
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">常委会议时间</td>
                        <td rssdate="<% entity.write("committeshijian"); %>,yyyy-MM-dd" colspan="3"></td>
                      
                        
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">常委会议届次</td>
                        <td><% entity.write("committemeetingnum"); %></td>
                        </td>

                    </tr>
                    <%
                    }
                    %>
                  
              
<!--                    
                <tr>
                 <td class="w100 dce">实施方案</td>
                 <td >
                     <%
                         String[] arry = {"", "", ""};
                         if (!entity.get("enclosure").isEmpty()) {
                             String[] str1 = entity.get("enclosure").split(",");
                             for (int idx = 0; idx < str1.length; idx++) {
                                 arry[idx] = str1[idx];
                     %>
                     <%  entity.write("enclosurename"); %><td><a href="/upfile/<% out.print( arry[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px">点击查看</a>
                     </td>
                     <%
                       }
                     }
                     %>
                </tr>-->
                
                <tr>
                    <% if ( state == 2 ) {//提交主任会议
                    %>
                    <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">实施方案<em class="red">*</em></td>
                    <%
                    }else{
                    %>
                    <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">实施方案</td>
                    <%
                    }
                    %>
                   
                    
                    <% if ( state == 999 ) {// 提交主任会议 原来是2，为了屏蔽改为 999
                    %>
                    <td colspan="2">
                        <div>
                            <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击更改方案</span>
                            <input type="hidden" name="enclosure" id="enclosure1" value="<% entity2.write("enclosure"); %>" >
                            <input type="hidden" name="enclosurename" id="enclosurename1" value="<% entity2.write("enclosurename"); %>" >
                            <input type="hidden" id="state" value="<% entity.write("state"); %>">
                        </div>
                    </td>
                    <%
                    }
                    %>
                    
                    <td style="font-weight:bold;" colspan="5">
                     <%
                         String[] arry0 = {"", "", ""};
                         if (!entity.get("enclosure").isEmpty()) {
                             String[] str1 = entity.get("enclosure").split(",");
                             for (int idx = 0; idx < str1.length; idx++) {
                                 arry0[idx] = str1[idx];
                     %>
                     <%  entity.write("enclosurename"); %><a href="/upfile/<% out.print( arry0[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;float:right;margin-right:10%;">点击查看</a>
                     </td>
                     <%
                       }
                     }
                     %>
                </tr>
                
                
                
                
                
                 
                
                <%
                if ( state >= 4 ) { //专项报告准备中，提交委室征求意见
                %>
                 <tr>
                     <td class="w120 dce">视察调研报告</td>
                     <td style="font-weight:bold;" colspan="5">
                         <%
                             String[] arry1 = {"", "", ""};
                             if (!entity.get("enclosure1").isEmpty()) {
                                 String[] str1 = entity.get("enclosure1").split(",");
                                 for (int idx = 0; idx < str1.length; idx++) {
                                     arry1[idx] = str1[idx];
                         %>
                         <%  entity.write("enclosurename1"); %><a href="/upfile/<% out.print( arry1[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;float:right;margin-right:10%;">点击查看</a></td>
                         <%
                                 }
                             }
                         %>
                     </td>
                 </tr>
                <%
                }
                %>
             
                <%
                if ( state >= 5 && state != 7 ) { //反馈意见中  state != 7 如果不是反馈修改意见
                %>
                 <tr>
                     <td class="w120 dce">专项工作报告</td>
                     <td style="font-weight:bold;" colspan="5">
                         <%
                             String[] arry2 = {"", "", ""};
                             if (!entity.get("enclosure2").isEmpty()) {
                                 String[] str1 = entity.get("enclosure2").split(",");
                                 for (int idx = 0; idx < str1.length; idx++) {
                                     arry2[idx] = str1[idx];
                         %>
                         <%  entity.write("enclosurename2"); %><a href="/upfile/<% out.print(arry2[idx]);%>" style="cursor: pointer;color:blue;font-weight: bold;float:right;margin-right:10%;">点击查看</a></td>
                         <%
                                 }
                             }
                         %>
                     </td>
                 </tr>
                <%
                }
                %>
                
  
                
                
                    
                <%
                if ( state == 3 ) { //视察调研报告完成后，提交专项报告单位
                %>
                <tr>
                    <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">视察调研报告<em class="red">*</em></td>
                    <td colspan="5">
                        <div>
                            <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                            <input type="hidden" name="enclosure1" id="enclosure1" value="<% entity2.write("enclosure1"); %>" >
                            <input type="hidden" name="enclosurename1" id="enclosurename1" value="<% entity2.write("enclosurename1"); %>" >
                            <input type="hidden" id="state" value="<% entity.write("state"); %>">
                        </div>
<!--                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                            <input type="hidden" id="enclosure2" ></div>
                        <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                            <input type="hidden"id="enclosure3" ></div>-->
                    </td>
                </tr>
                <%
                } 
                else if ( state == 4 || state == 7 ){
                %>
                <tr>
                    <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">专项报告<em class="red">*</em></td>
                    <td colspan="5">
                        <div>
                            <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择专项报告文件</span>
                            <input type="hidden" name="enclosure2" id="enclosure2" value="<% entity2.write("enclosure2"); %>" >
                            <input type="hidden" name="enclosurename2" id="enclosurename2" value="<% entity2.write("enclosurename2"); %>" >
                            <input type="hidden" id="state" value="<% entity.write("state"); %>">
                        </div>
                  </td>
                </tr>
                <%
                }
                else if ( state == 5 ){
                %>
                 <tr>
                    <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">反馈意见</td>
                    <td colspan="5">
                        <div>
                            <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择反馈意见文件</span>
                            <input type="hidden" name="enclosure3" id="enclosure3" value="<% entity2.write("enclosure3"); %>" >
                            <input type="hidden" name="enclosurename3" id="enclosurename3" value="<% entity2.write("enclosurename3"); %>" >
                            <input type="hidden" id="state" value="<% entity.write("state"); %>">
                        </div>
                  </td>
                </tr>
                <%
                }
                %>
                
                
                
                
                          
                <%
                if ( state >= 7  && !entity.get("enclosure3").isEmpty() ) { //反馈的意见
                %>
                 <tr>
                     <td class="w120 dce">反馈意见</td>
                     <td style="font-weight:bold;" colspan="5">
                         <%
                             String[] arry2 = {"", "", ""};
                             if ( !entity.get("enclosure3").isEmpty() ) {
                                 String[] str1 = entity.get("enclosure3").split(",");
                                 for (int idx = 0; idx < str1.length; idx++) {
                                     arry2[idx] = str1[idx];
                         %>
                         <%  entity.write("enclosurename3"); %><a href="/upfile/<% out.print(arry2[idx]);%>" style="cursor: pointer;color:blue;font-weight: bold;;float:right;margin-right:10%;">点击查看</a></td>
                         <%
                                 }
                             }
                         %>
                     </td>
                 </tr>
                <%
                }
                %>
                
            <%
             if ( state == 6  ) { //没有意见
            %>
              <tr>
                  <td class="w120 dce">反馈意见</td>
                  <td colspan="5">

                      <%  out.print("对于报告没有任何意见"); %>

                  </td>
              </tr>
              
              
            <tr>                     
                 <td class="dce w100" style="font-size:15px;font-family: 微软雅黑" >常委会时间<em class="red">*</em>
                 </td>

                 <td colspan="3" style="font-size:15px">
                   <input type="text" class="w200 Wdate" name="committeshijian"  rssdate="<% out.print(entity2.get("committeshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                   <input type="hidden" id="state" value="<% entity.write("state"); %>">
                 </td>


                 <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">常委会届次<em class="red">*</em></td>
                 <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="committemeetingnum" value="<% entity2.write("committemeetingnum"); %>" /><label class="labtitle"></label></td>  
               </tr> 
              
              
             <%
             }
             %>   
                
             
            <%
            if ( state == 8  ) { //常委会完成，提交审议意见
            %>   
            <tr>
            <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">常委会审议意见<em class="red">*</em></td>
               <td colspan="5">
                <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择审议意见文件</span>
                    <input type="hidden" name="enclosure4" id="enclosure4" value="<% entity2.write("enclosure4"); %>" >
                    <input type="hidden" name="enclosurename4" id="enclosurename4" value="<% entity2.write("enclosurename4"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
              </td>
            </tr>
            <%
            }else if ( state >= 9 ) {
            %>    
            
            <tr>
            <td class="w120 dce">常委会审议意见</td>
            <td style="font-weight:bold;" colspan="5">
                <%
                    String[] arry2 = {"", "", ""};
                    if ( !entity.get("enclosurename4").isEmpty() ) {
                        String[] str1 = entity.get("enclosurename4").split(",");
                        for (int idx = 0; idx < str1.length; idx++) {
                            arry2[idx] = str1[idx];
                %>
                <%  entity.write("enclosurename4"); %><a href="/upfile/<% out.print(arry2[idx]);%>" style="cursor: pointer;color:blue;font-weight: bold;float:right;margin-right:10%;">点击查看</a></td>
                <%
                        }
                    }
                %>
            </td>      
            </tr>
            
            <!-----------------  最终专项报告 ------------------>
           <%
            if ( state == 9 ) { 
            %>
            <tr>
            <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">最终专项报告<em class="red">*</em></td>
               <td colspan="5">
                <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择最终专项报告文件</span>
                    <input type="hidden" name="enclosure5" id="enclosure5" value="<% entity2.write("enclosure5"); %>" >
                    <input type="hidden" name="enclosurename5" id="enclosurename5" value="<% entity2.write("enclosurename5"); %>" >
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
                
                
                <%
                if ( state == 3 ) { //视察调研报告完成后，提交专项报告单位
                %>
                <tr>
                    <td class="dce w100 " style="color:blue;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;" >送交单位<em class="red">*</em></td>
                    <td  colspan="5" id="userrolesel">
                        <input style="width:99%;" readonly="readonly" value="<% req.write("userroleid"); %>"/>
                        <input type="hidden" name="userroleid" id="userroleid" value="<% entity.write("userroleid"); %>"/>
                    </td>
                </tr>
                <%
                }
                %>
        

                
                
                
            <%
           if ( state >= 10  ) {
            %>    
            
<!--            <tr>
            <td class="w120 dce">最终专项报告</td>
            <td >
            <%
                String[] arry5 = {"", "", ""};
                if ( !entity.get("enclosurename5").isEmpty() ) {
                    String[] str1 = entity.get("enclosurename5").split(",");
                    for (int idx = 0; idx < str1.length; idx++) {
                        arry5[idx] = str1[idx];
            %>
            <%  entity.write("enclosurename5"); %><td><a href="/upfile/<% out.print( arry5[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a></td>
            <%
                }
            }
            %>
            </td>      
            </tr>    -->
            
            
            <!----- 征求意见--->
            <% if ( state == 10 ) {
             %>
             
           
            <tr>
            <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">意见文件<em class="red">*</em></td>
               <td colspan="5">
                <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                    <input type="hidden" name="enclosure6" id="enclosure6" value="<% entity2.write("enclosure6"); %>" >
                    <input type="hidden" name="enclosurename6" id="enclosurename6" value="<% entity2.write("enclosurename6"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
              </td>
            </tr>
             
            <% 
            } else if ( state == 11 ) {
            %>
           <tr>
                  <td class="w120 dce">反馈意见</td>
                  <td colspan="5">

                      <%  out.print("对于报告没有任何意见"); %>

                  </td>
              </tr>
             <tr>
            <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">书面报告<em class="red">*</em></td>
               <td colspan="5">
                <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                    <input type="hidden" name="enclosure7" id="enclosure7" value="<% entity2.write("enclosure7"); %>" >
                    <input type="hidden" name="enclosurename7" id="enclosurename7" value="<% entity2.write("enclosurename7"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
              </td>
            </tr>
              
            <%
            }else if ( state == 12 ) {
            %>
            
<!--            <tr>
            <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">征求意见<em class="red">*</em></td>
               <td colspan="5">
                <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                    <input type="hidden" name="enclosure6" id="enclosure6" value="<% entity2.write("enclosure6"); %>" >
                    <input type="hidden" name="enclosurename6" id="enclosurename6" value="<% entity2.write("enclosurename6"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
              </td>
            </tr>-->
            
            <tr>
            <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">报告文件<em class="red">*</em></td>
               <td colspan="5">
                <div>
                    <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                    <input type="hidden" name="enclosurename5" id="enclosure6" value="<% entity2.write("enclosurename5"); %>" >
                    <input type="hidden" name="enclosurename5" id="enclosurename6" value="<% entity2.write("enclosurename5"); %>" >
                    <input type="hidden" id="state" value="<% entity.write("state"); %>">
                </div>
              </td>
            </tr>
            
            
           <% 
            }else{
           %>
          
           
           
            <tr>
            <td class="w120 dce">最终专项报告</td>
            <td style="font-weight:bold;" colspan="5">
            <%
                String[] temp = {"", "", ""};
                if ( !entity.get("enclosurename5").isEmpty() ) {
                    String[] str1 = entity.get("enclosurename5").split(",");
                    for (int idx = 0; idx < str1.length; idx++) {
                        temp[idx] = str1[idx];
            %>
            <%  entity.write("enclosurename5"); %><a href="/upfile/<% out.print( temp[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;float:right;margin-right:10%;">点击查看</a></td>
            <%
                }
            }
            %>
            </td>      
            </tr>    
           
           
           
           
           <tr>
            <td class="w120 dce">反馈意见</td>
            <td style="font-weight:bold;" colspan="5">
            <%
                String[] arry6 = {"", "", ""};
                if ( !entity.get("enclosurename6").isEmpty() ) {
                    String[] str1 = entity.get("enclosurename6").split(",");
                    for (int idx = 0; idx < str1.length; idx++) {
                        arry6[idx] = str1[idx];
            %>
            <%  entity.write("enclosurename6"); %><a href="/upfile/<% out.print( arry6[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;float:right;margin-right:10%;">点击查看</a></td>
            <%
                }
            }
            %>
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
                
                <%
                if ( entity.get("state").equals("5")  ) { //征求意见中
                %>   
               
                <input type="hidden" name="action" value="<% out.print("feedback");%>" />
                <button style="float:left;" type="submit"  ><% out.print("反馈意见");%></button>
                <button type="submit"><% out.print("同意通过");%></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
                <% 
               }else if ( entity.get("state").equals("10") ) { //征求意见中
               %>  
               
                <input type="hidden" name="action" value="<% out.print("reinquerylast");%>" />
                <button style="float:left;" type="submit"  ><% out.print("反馈意见");%></button>
                <button type="submit"><% out.print("同意通过");%></button>
                <input name="state" type="hidden" value="<% entity.write("state"); %>">
               
                <%
                }else {//以下是非征求意见状态
                %>   
                
                 <input type="hidden" name="action" value="<% 
                    if ( entity.get("state").equals( "1") ) {
                         out.print( "submit");
                    }
                    else if ( entity.get("state").equals( "2")) {
                         out.print("auditpass");
                    }
                    else if ( entity.get("state").equals( "3")){
                         out.print( "report");
                    }
                    else if ( entity.get("state").equals( "4")){
                         out.print( "inquery");  //征求意见
                    }
                    else if ( entity.get("state").equals( "5")){
                         out.print( "feedback");  //反馈意见
                    }
                    else if ( entity.get("state").equals( "6")){
                        if ( UserList.MyID(request).equals( entity.get("myid") ) ) {
                            
                            out.print( "submitcommitteAudit"); 
                        }
                        else {
                         out.print( "view");  
                        }
                    }
                    else if ( entity.get("state").equals( "7")){
                         out.print( "reinquery");  //反馈意见后，再征求意见
                    }
                    
                    else if ( entity.get("state").equals( "8")){
                         out.print( "committeAuditFinish");  //常委会审议完成
                    }
                    
                    else if ( entity.get("state").equals( "9")){
                         out.print( "reinquery2");  //
                    }
                    else if ( entity.get("state").equals( "10")  ) {
                         out.print( "reinquerylast");  //检察院等根据常委会审议意见后形成报告后，向委室征求意见
                    }
                    else if ( entity.get("state").equals( "11")  ) {
                         out.print( "sendreportcommittee");  //向人大常委会出具书面报告
                    }
                    else if ( entity.get("state").equals("12") ) {
                         out.print( "reinquerylast2");  //2次向委室征求意见
                    }

                   
                   
                %>" />
                <button type="submit"><% 
                     if ( entity.get("state").equals( "1") ) {
                         out.print( "确认");
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
                    else if ( entity.get("state").equals( "5")){
                         out.print( "反馈意见"); //相关委室征求意见
                    }
                    else if ( entity.get("state").equals( "6")){
                        if ( UserList.MyID(request).equals( entity.get("myid") ) ) {
                            //如果是发起者，那么需要显示提交常委会审议
                            out.print( "提交常委会审议"); 
                        }
                        else {
                         out.print( "确定"); 
                        }
                    }
                    else if ( entity.get("state").equals( "7")){
                         out.print( "征求意见"); //相关委室征求意见
                    }
                    else if ( entity.get("state").equals( "8")){
                         out.print( "提交审议意见"); //人大常委会向相关委室征求意见
                    }
                    else if ( entity.get("state").equals( "9")){
                         out.print( "提交常委会意见报告"); //人大常委会向相关委室征求意见
                    }
                    else if ( entity.get("state").equals( "10") ){
                         out.print( "反馈意见");       
                    }
                    else if ( entity.get("state").equals( "11") ){
                         out.print( "出书面报告");       
                    }
                    else if ( entity.get("state").equals("12") ){
                         out.print( "征求意见");       
                    }
                     

                    
                %></button>
                
                <%
                }//以下是非征求意见状态结束标志
                %>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {   
                var $tt = $("#state").val();
                console.log($tt);
                if ($tt == 3 ) { //完成调研视察报告，提交专项报告单位才判断
                    if ($("[name='enclosure1']").val() == undefined || $("[name='enclosure1']").val() == "") {
                        alert("请添加报告文件");
                        $("[name='enclosure1']").focus();
                        return false;
                    }
                }
                else if ($tt == 4 ) {
                     //console.log($tt);
                    if ($("[name='enclosure2']").val() == undefined || $("[name='enclosure2']").val() == "") {
                      alert("请添加专项工作报告文件");
                      $("[name='enclosure2']").focus();
                      return false;
                    } 
                }
                
                else if ($tt == 6 ) {
                    //if ( $("[name='state']").val() == "") {
                        if ($("[name='committeshijian']").val() == undefined || $("[name='committeshijian']").val() == "") {
                           alert("请填写常委会议审议日期");
                           $("[name='committeshijian']").focus();
                           return false;
                        }
                   // }
                    if ($("[name='committeshijian']").val() != undefined && $("[name='committeshijian']").val() != "") {
                    var timestamp = new Date($("[name='committeshijian']").val());
                    $("[name='committeshijian']").val(timestamp / 1000);
                    }
                }

                
                else if ($tt == 8 ) {
                      if ($("[name='enclosure4']").val() == undefined || $("[name='enclosure4']").val() == "") {
                        alert("请添加常委会审议意见文件");
                        $("[name='enclosure4']").focus();
                        return false;
                      } 
                  }

                   else if ($tt == 9 ) {
                      if ($("[name='enclosure5']").val() == undefined || $("[name='enclosure5']").val() == "") {
                        alert("请添加专项工作报告文件");
                        $("[name='enclosure5']").focus();
                        return false;
                      } 
                  }
                
                 else if ($tt == 11 ) {
                      if ($("[name='enclosure7']").val() == undefined || $("[name='enclosure7']").val() == "") {
                        alert("请添加报告文件");
                        $("[name='enclosure7']").focus();
                        return false;
                      } 
                  }
       
            })                           
   
        var $state = $("#state").val(); 
        if ( $state == 5 ) {
            $('.footer button:last').click(function () {
            $('[name=state]').val( 6 );//同意        
            });
            $('.footer button:first').click(function () {
                
                //注释掉反馈意见2021.6.8
                
//                if ($("[name='enclosure3']").val() == undefined || $("[name='enclosure3']").val() == "") {
//                      alert("请添加反馈意见文件");
//                      $("[name='enclosure3']").focus();
//                      return false;
//                } 
                $('[name=state]').val( 7 );
            });
        }
        
         if ( $state == 10 ) { //最后一次征求见
            $('.footer button:last').click(function () {
            $('[name=state]').val( 11 );//同意                
            });
            $('.footer button:first').click(function () {
                
                  //注释掉反馈意见 2021.6.8
//                if ($("[name='enclosure6']").val() == undefined || $("[name='enclosure6']").val() == "") {
//                      alert("请添加反馈意见文件");
//                      $("[name='enclosure6']").focus();
//                      return false;
//                } 
                $('[name=state]').val( 12 );
            });
        }
        
        
       
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
                    
                    if ( $state == 4 || $state == 7 ) {  //征求意见
                        $("input[name='enclosure2']").val(data.url);
                        $("input[name='enclosurename2']").val(filename);
                    }
                    else if ($state == 2 ) {  
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                    }
                    else if ( $state == 5 ) {//反馈意见
                        $("input[name='enclosure3']").val(data.url);
                        $("input[name='enclosurename3']").val(filename);
                        
                    }
                    else if ( $state == 8 ) {  //人大常委会审议会议文件
                        $("input[name='enclosure4']").val(data.url);
                        $("input[name='enclosurename4']").val(filename);
                    }
                    else if ( $state == 9 ) { //最终专项报告           
                        $("input[name='enclosure5']").val(data.url);
                        $("input[name='enclosurename5']").val(filename);
                    }
                    else if ( $state == 10 || $state == 12 ) { //最后一次征求意见
                        $("input[name='enclosure6']").val(data.url);
                        $("input[name='enclosurename6']").val(filename); 
                    }
                    else if ( $state == 11  ) { //向常委会出具书面报告
                        $("input[name='enclosure7']").val(data.url);
                        $("input[name='enclosurename7']").val(filename); 
                    }
                    else {
                        $("input[name='enclosure1']").val(data.url);
                        $("input[name='enclosurename1']").val(filename);
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
                                RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 350);
                            });

        </script>
    </body>
</html>
