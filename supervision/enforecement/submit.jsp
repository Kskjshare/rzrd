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
    RssList entity = new RssList(pageContext, "supervision_enforcement");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList entity2 = new RssList(pageContext, "supervision_enforcement");
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
                
               if ( !entity2.get("enclosure").isEmpty() ) {
                //更改方案
                entity.keyvalue("enclosure", entity2.get("enclosure"));
                entity.keyvalue("enclosurename", entity2.get("enclosurename"));  
               }
                entity.keyvalue("Reportenclosure", entity2.get("Reportenclosure"));
                entity.keyvalue("Reportenclosurename", entity2.get("Reportenclosurename"));
                entity.keyvalue("assignenclosure", entity2.get("assignenclosure"));
                entity.keyvalue("assignenclosurename", entity2.get("assignenclosurename"));
                entity.update().where("id=?", req.get("id")).submit();           

                //out.print("<script>alert('submit')</script>");
                break;
            case "auditpass":
                //主任会议审核通过
                entity.keyvalue("state", 3);       //  3       
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

                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 13 ); 
                userrole.keyvalue("taskDone", 1 );  
                userrole.keyvalue("enclosure7",entity2.get("enclosure7"));
                userrole.keyvalue("enclosurename7",entity2.get("enclosurename7"));   
                //userrole.update().submit();  
                userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                break;
            case "reinquerylast2": 
                //out.print("<script>alert('reinquerylast2 1')</script>");
                entity.keyvalue("state", 10 );  
                if ( !entity2.get("enclosure6").isEmpty() ) {
                entity.keyvalue("enclosure6",entity2.get("enclosure6"));
                entity.keyvalue("enclosurename6",entity2.get("enclosurename6"));
                }
                entity.update().where("id=?", req.get("id")).submit();  

                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 10 );  
                if ( !entity2.get("enclosure6").isEmpty() ) {
                userrole.keyvalue("enclosure6",entity2.get("enclosure6"));
                userrole.keyvalue("enclosurename6",entity2.get("enclosurename6"));   
                }
                //userrole.update().submit(); 
                userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
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

                    userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    userrole.remove("id");
                    userrole.keyvalue("state", entity2.get("state") );  
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        userrole.keyvalue("enclosure6",entity2.get("enclosure6"));
                        userrole.keyvalue("enclosurename6",entity2.get("enclosurename6"));   
                    }
                    //userrole.update().submit(); 
                    userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                }
                else  if ( entity2.get("state").equals("12")){
                    
                    entity.keyvalue("state", entity2.get("state") );
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        entity.keyvalue("enclosure6",entity2.get("enclosure6"));
                        entity.keyvalue("enclosurename6",entity2.get("enclosurename6"));  
                    }
                    entity.update().where("id=?", req.get("id")).submit();  

                    userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    userrole.remove("id");
                    userrole.keyvalue("state", entity2.get("state") );  
                    if ( !entity2.get("enclosure6").isEmpty() ) {
                        userrole.keyvalue("enclosure6",entity2.get("enclosure6"));
                        userrole.keyvalue("enclosurename6",entity2.get("enclosurename6"));   
                    }
                    //userrole.update().submit(); 
                    userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
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
               
                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 8 );  
                //userrole.update().submit();  
                userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                break;
                
            case "committeAuditFinish"://提交常委会审议意见
                entity.keyvalue("state",9 );  
                
                entity.keyvalue("enclosure4",entity2.get("enclosure4"));
                entity.keyvalue("enclosurename4",entity2.get("enclosurename4"));   
                entity.update().where("id=?", req.get("id")).submit();  
               
                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.remove("id");
                userrole.keyvalue("state", 9 );  
                userrole.keyvalue("enclosure4",entity2.get("enclosure4"));
                userrole.keyvalue("enclosurename4",entity2.get("enclosurename4"));   
                //userrole.update().submit(); 
                userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                break;
            case "inquery": //征求意见      
                entity.keyvalue("state", 5 );        
                entity.keyvalue("enclosure2",entity2.get("enclosure2"));
                entity.keyvalue("enclosurename2",entity2.get("enclosurename2"));   
                
                //设置一个预置值，为了处理意见反馈流程
                //entity.keyvalue("enclosuretemp",entity.get("enclosure2"));//随便设置一个空值
                
                entity.update().where("id=?", req.get("id")).submit();  
                
                
                //RssList userrole = new RssList(pageContext, "supervision_userrole_specialwork");
                //userrole.request();
   
                
                
                userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                userrole.keyvalue("state", 5 );   
                //专项工作报告
                userrole.keyvalue("enclosure2",entity2.get("enclosure2"));
                userrole.keyvalue("enclosurename2",entity2.get("enclosurename2"));   
                userrole.remove("id");
                //设置一个预置值，为了处理意见反馈流程
//                userrole.keyvalue("enclosuretemp",entity2.get("enclosure2"));//随便设置一个空值
                    
                //userrole.update().submit();  
                userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                break;
            case "feedback":
             
                //如果不同意，则需要把临时编制置空，方便处理流程
                //userrole.keyvalue("enclosuretemp",entity2.get("enclosure5"));//随便设置一个空值
               
                
                entity.update().where("id=?", req.get("id")).submit();
                 
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
                    
                    userrole.keyvalue("state", 7 );   
                    userrole.keyvalue("enclosure3",entity2.get("enclosure3"));
                    userrole.keyvalue("enclosurename3",entity2.get("enclosurename3"));   
                    userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    //userrole.update().submit();  
                     userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
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
                    userrole.keyvalue("state", 6 );  
                    userrole.update().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).submit();
                   
                    //userrole.select().where("iid=" + req.get("id") + " and myid=" + UserList.MyID(request)).get_first_rows();
                    //userrole.update().submit();  
                }
                
               
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
            #fileeformReport{position: absolute;left: -10000px;}
            #fileeformOpinion{position: absolute;left: -10000px;}
            
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>         
        </form>
        
        <form id="fileeformReport" enctype="multipart/form-data" method="post">
            <input type="file" id="fileeReport" accept="." name="file" multiple>      
        </form>
         <form id="fileeformOpinion" enctype="multipart/form-data" method="post">
            <input type="file" id="fileeOpinion" accept="." name="file" multiple>      
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
                        <td class="w100 dce" style="font-size:14px;">标题</td>
                        <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>
                 
                      
                    <tr>
                        <td class="w100 dce" >发起单位</td>
                        <td colspan="2"><% out.print(entity.get("initiator")); %></td>
                        <td class="w100 dce" >当前进度</td>
                        <td>
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
                        <td class="w100 dce">主题</td>
                        <td colspan="2"><% entity.write("reviewclass"); %></td>
                        <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发布时间</td>
                        <td colspan="2" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                          
                    <tr>
                        <td class="w120 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">主任会议时间</td>
                        <td rssdate="<% entity.write("meetingshijian"); %>,yyyy-MM-dd" colspan="2"></td>
                      
                        
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">主任会议届次</td>
                        <td><% entity.write("directormeetingnum"); %></td>
                        </td>

                    </tr>
                 
                <tr>
                    <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">执法检查方案</td>
  <!--
                    <td colspan="2">
                        <div>
                            <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击更改方案</span>
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
                
                
                
                
        
        <tr>
        <td class="w120 dce">执法检查报告<em class="red">*</em></td>
        <td colspan="5">
        <div>
            <span id="fjfileReport" rid="2" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
            <input type="hidden" name="Reportenclosure" id="Reportenclosure" value="<% entity2.write("Reportenclosure"); %>" >
            <input type="hidden" name="Reportenclosurename" id="Reportenclosurename" value="<% entity2.write("Reportenclosurename"); %>" >
            <input type="hidden" id="state" value="<% entity.write("state"); %>">
        </div>
        </td>
        </tr>
            
            <tr>
             <td class="w120 dce">交办意见<em class="red">*</em></td>
            <td colspan="5">
            <div>
                <span id="fjfileOpinion" rid="3" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                <input type="hidden" name="assignenclosure" id="assignenclosure" value="<% entity2.write("assignenclosure"); %>" >
                <input type="hidden" name="assignenclosurename" id="assignenclosurename" value="<% entity2.write("assignenclosurename"); %>" >
                <input type="hidden" id="state" value="<% entity.write("state"); %>">
            </div>
            </td>
                
            </tr>


                
                
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
                         out.print( "确认提交");
                    }
                    else if ( entity.get("state").equals( "2")) {
                         out.print("确认交办");
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
                //alert($tt);
                console.log($tt);
                if ($tt == 1 ) { //完成执法检查报告，提交专项报告单位才判断
//                    if ($("[name='enclosure']").val() == undefined || $("[name='enclosure']").val() == "") {
//                        alert("请添加文件");
//                        $("[name='enclosure']").focus();
//                        return false;
//                    }
                    
                    if ($("[name='Reportenclosure']").val() == undefined || $("[name='Reportenclosure']").val() == "") {
                        alert("请添加执法检查报告文件");
                        $("[name='Reportenclosure']").focus();
                        return false;
                    }
                    
                    if ($("[name='assignenclosure']").val() == undefined || $("[name='assignenclosure']").val() == "") {
                        alert("请添加交办意见文件");
                        $("[name='assignenclosure']").focus();
                        return false;
                    }
                }
   
            })                           
   
//        var $state = $("#state").val(); 
//        if ( $state == 5 ) {
//            $('.footer button:last').click(function () {
//            $('[name=state]').val( 6 );//同意        
//            });
//            $('.footer button:first').click(function () {
//                if ($("[name='enclosure3']").val() == undefined || $("[name='enclosure3']").val() == "") {
//                      alert("请添加反馈意见文件");
//                      $("[name='enclosure3']").focus();
//                      return false;
//                } 
//                $('[name=state]').val( 7 );
//            });
//        }
//        
   
        
       
        $("#fjfile").click(function () {
            $("#filee").click();
            //alert(" click ");
        })

        $("#fjfileReport").click(function () {
            $("#fileeReport").click();
            //alert(" click1 ");
        })

         $("#fjfileOpinion").click(function () {
            $("#fileeOpinion").click();
            //alert(" click2 ");
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
                  
                    
                    alert("上传成功");
                    }
                    else{
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
        

        $("#fileeReport").change(function () {      
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeformReport").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
                
                    $("#fjfileReport").text(filename)
                    $("input[name='Reportenclosure']").val(data.url);
                    $("input[name='Reportenclosurename']").val(filename);
                   
                    
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfileReport").text("点击选择文件")
                    $("input[name='Reportenclosure']").val(data.url);
                    $("input[name='Reportenclosurename']").val(filename);
                    alert("未上传")
                }
                   // let text = "上传成功";
                   // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                }});
            return false;
        })
        
         $("#fileeOpinion").change(function () {        
            var str = $(this).val(); //开始获取文件名
            var filename = str.substring(str.lastIndexOf("\\") + 1);
            $("#fileeformOpinion").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
            if(data.url !== null && "" !== data.url){
                
                    $("#fjfileOpinion").text(filename)
                    $("input[name='assignenclosure']").val(data.url);
                    $("input[name='assignenclosurename']").val(filename);
                   
                    
                    //alert("上传成功");
                    }
                    else{
                    $("#fjfileOpinion").text("点击选择文件")
                    $("input[name='assignenclosure']").val(data.url);
                    $("input[name='assignenclosurename']").val(filename);
                    alert("未上传")
                }
                   // let text = "上传成功";
                   // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                }});
            return false;
        })

        
//        $("#fileico").change(function () {
//            $("#fileicoform").ajaxSubmit({
//                url: "/widget/upload.jsp?",
//                type: "post",
//                dataType: "json",
//                async: false,
//                success: function (data) {
//                    $("#icofile").text(data.url)
//                    $("input[name='ico']").val(data.url);
//                    alert("上传成功");
//                }});
//            return false;
//        })
        
   
  
              
        
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
