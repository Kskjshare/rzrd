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
    //推送接口
//    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
//    RssList senduser = new RssList(pageContext, "userDeviceid");
//    Map<String, String> map = new HashMap<String, String>();
//    map.put("key", "1");
//    RssList entity2 = new RssList(pageContext, "activities");
//    RssList user = new RssList(pageContext, "activities_userlist");
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();
    entity.select().where("id=?",req.get("id") ).get_first_rows();
    
    
    RssList entity1 = new RssList(pageContext, "activities");
    entity1.request();
    entity1.select().where("id=?",req.get("id") ).get_first_rows();


    
    
    
    //为了更更新个人记录被审核标志privateaudit //2021/9/29
    RssList activities = new RssList(pageContext, "activities");
    activities.request();
    activities.select().where("id= "+ req.get("id") ).get_first_rows();

    
    

    


     //RssList userlist = new RssList(pageContext, "activities_userlist");
    RssListView userlist = new RssListView(pageContext, "activities_userlist");
    userlist.request();
    if ( cookie.Get("powergroupid").equals("5") ) {
        userlist.select().where("activitiesid= "+ entity.get("id") + " and userid="+ UserList.MyID(request)  ).get_first_rows();
    }
    else {        
        userlist.select().where("activitiesid="+ req.get("id") + " and userid=" + req.get("userid")).get_first_rows();
    }
     
    RssList userActitivityTable = new RssList(pageContext, "activities_userlist");
    userActitivityTable.request();
    userActitivityTable.select().where("activitiesid= "+ req.get("id") + " and userid="+ req.get("userid")   ).get_first_rows();

    //履职排名表
    RssList ranktable = new RssList(pageContext, "activities_rank"); 
    ranktable.request();
//     ranktable.select().where("realname like '%" + URLDecoder.decode(ranktable.get("realname"), "utf-8") + "%'").get_page_desc("id");
 

//处理排序表，如果审核了，直接在排序表增加对应的履职活动数
    RssList rankSort = new RssList(pageContext, "rank_sort");
    rankSort.request();
    rankSort.select().where("myid=?",entity1.get("myid") ).get_first_rows();
    String classify = entity1.get("classify");
    int mTotal = Integer.valueOf(rankSort.get("num")).intValue();
    int mScore = Integer.valueOf(rankSort.get("totalScore")).intValue();
    int meeting = Integer.valueOf(rankSort.get("meeting")).intValue();
    int othermeeting = Integer.valueOf(rankSort.get("othermeeting")).intValue();
    int study = Integer.valueOf(rankSort.get("study")).intValue();
    int suggest = Integer.valueOf(rankSort.get("suggest")).intValue();
    //int specialsurvey = Integer.valueOf(rankSort.get("investigation")).intValue();   
    
    int investigation = Integer.valueOf(rankSort.get("investigation")).intValue();   
    int specialsurvey = Integer.valueOf(rankSort.get("specialsurvey")).intValue();   

    
    int totalMixActivities = Integer.valueOf(rankSort.get("totalMixActivities")).intValue();
    int recievevoters = Integer.valueOf(rankSort.get("recievevoters")).intValue();
    int reslovedispute = Integer.valueOf(rankSort.get("reslovedispute")).intValue();
    int helpweak = Integer.valueOf(rankSort.get("helpweak")).intValue();
    int goodthing = Integer.valueOf(rankSort.get("goodthing")).intValue();
    int charity = Integer.valueOf(rankSort.get("charity")).intValue();
    int reportvoter = Integer.valueOf(rankSort.get("reportvoter")).intValue();
    int other = Integer.valueOf(rankSort.get("other")).intValue();
    
    int[] taScore = new int[]{ 0 , 0 , 0 , 0, 0 , 0 ,0 , 0  , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 };
    //1出席人代会  2参加其他会议 3 参加学习培训 4 提出议案，建议、批评和意见(附议人一条1分,最高分4分)  5 开展专题调研  6参加视察、调研及执法检查 9 接待选民 10 化解矛盾纠纷 11 扶弱济困 12 办好事、实事
    //13 参加公益慈善事业 14 向选民述职 15 其他                                 接待选民             参加公益慈善事业
    int[] baseScore = new int[]{  0, 15, 3 , 3, 6, 4 ,        6 , 6 , 6 ,       4 ,     5 ,5  ,5,     5,            3, 5};
    int[] extraScore = new int[]{ 0, 0,  1 , 1, 2, 1 ,        1 , 1 ,1 ,        2 ,     1 ,1  ,1,     1,            0, 0};
    int[] maxScore = new int[]{   0, 15, 5 , 5, 10, 6 ,       10 , 10 ,10 ,     12 ,    8 ,8 ,8,      8,            5, 5 };                             
    
    int mclassify  = Integer.valueOf( classify ).intValue(); 
    int enroll = Integer.valueOf( entity1.get("enroll") ).intValue() ;
    if ( enroll == 3 ) {
        if ( mclassify >= 6 ) {
            mclassify += 3 ;
        }
    }
    int tmpScore = 0 ;
    
     int temCounter = 0;
     
    if ( classify.equals("1") ){     
        //mclassify = Integer.valueOf( classify ).intValue();
        meeting ++ ;
        mTotal ++ ;
        mScore += baseScore[ mclassify ] ;
        if ( mScore >  maxScore[ mclassify ] ) {
            mScore =  maxScore[ mclassify ] ;
        }

    }
    else if ( classify.equals("2") ){   
       
      temCounter = othermeeting ;
       mTotal ++ ;  
       
            
        othermeeting ++ ;
        tmpScore = 0 ;
        for ( int i = 0 ; i < othermeeting ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;              
    }
    else if ( classify.equals("3") ){   
         temCounter = study ;    
      study ++ ;
      mTotal ++ ;
      
        
        tmpScore = 0 ;
        for ( int i = 0 ; i < study ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;                
    }
    else if ( classify.equals("4") ){       
      suggest ++ ;
      mTotal ++ ;    
    }
    else if ( classify.equals("5") ){      
        temCounter = specialsurvey ;  
        mTotal ++ ;
        
       
        specialsurvey ++ ;
        tmpScore = 0 ;
        for ( int i = 0 ; i < specialsurvey ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        }
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;          
    }
    else if ( classify.equals("6") ){  
        temCounter = totalMixActivities ;   
        totalMixActivities ++ ;
        mTotal ++ ;
        
          
        tmpScore = 0 ;
        for ( int i = 0 ; i < totalMixActivities ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;          
    }
    else if ( classify.equals("7") ){  
     temCounter = recievevoters ;          
        recievevoters ++ ;
        mTotal ++ ;
        
       
        tmpScore = 0 ;
        for ( int i = 0 ; i < recievevoters ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;              
    }
    else if ( classify.equals("8") ){ 
        temCounter = reslovedispute ;      
        reslovedispute ++ ;
        mTotal ++ ;
        
            
        tmpScore = 0 ;
        for ( int i = 0 ; i < reslovedispute ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;    
    }
    else if ( classify.equals("9") ){  
        temCounter = helpweak ;     
        helpweak ++ ;
        mTotal ++ ;
       
              
        tmpScore = 0 ;
        for ( int i = 0 ; i < helpweak ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;        
    }
     else if ( classify.equals("10") ){     
      temCounter = goodthing ;       
        goodthing ++ ;
        mTotal ++ ;      
          
        tmpScore = 0 ;
        for ( int i = 0 ; i < goodthing ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;      
        
    }
     else if ( classify.equals("11") ){ 
        temCounter = charity ;           
        charity ++ ;
        mTotal ++ ;   
       
        tmpScore = 0 ;
        for ( int i = 0 ; i < charity ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;      
    }
    else if ( classify.equals("12") ){ 
        temCounter = reportvoter ;        
        reportvoter ++ ;
        mTotal ++ ; 
         
        tmpScore = 0 ;
        for ( int i = 0 ; i < reportvoter ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;       
    }
    else if ( classify.equals("13") ){  
        temCounter = other ;           
        other ++ ;
        mTotal ++ ;  
        
       
        tmpScore = 0 ;
        for ( int i = 0 ; i < other ; i  ++ ) {
            if ( temCounter ==  0 )
            tmpScore += baseScore[ mclassify ] ;
            else
             tmpScore += extraScore[ mclassify ] ; 
            temCounter ++ ;
        } 
        
        if ( tmpScore >  maxScore[ mclassify ] ) {
            tmpScore =  maxScore[ mclassify ] ;
        }
        mScore +=  tmpScore;         
    }
    else if ( classify.equals("14") ){               
    }
    else if ( classify.equals("15") ){               
    }
           

    

    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity2.timestamp();
//                entity2.remove("userid");
                
                //插入履职排行榜
                if ( entity.get( "evaluateResult").equals("2") ) {
                    
                    
                //更新排序表履职个数
                rankSort.remove("evaluateResult");
                rankSort.remove("userid");
                
                rankSort.keyvalue("meeting",meeting );
                rankSort.keyvalue("othermeeting",othermeeting );
                rankSort.keyvalue("study",study );     
                rankSort.keyvalue("suggest",suggest );
                rankSort.keyvalue("investigation",investigation );
                
                rankSort.keyvalue("specialsurvey",specialsurvey );

                rankSort.keyvalue("totalMixActivities",totalMixActivities ); 
                rankSort.keyvalue("recievevoters",recievevoters );
                rankSort.keyvalue("reslovedispute",reslovedispute );
                rankSort.keyvalue("helpweak",helpweak );
                rankSort.keyvalue("goodthing",goodthing );
                rankSort.keyvalue("charity",charity );
                rankSort.keyvalue("reportvoter",reportvoter );
                rankSort.keyvalue("other",other );
                rankSort.keyvalue("num",mTotal );
                rankSort.keyvalue("totalScore",mScore );

                

                rankSort.update().where("myid=" + entity1.get("myid")  ).submit();

                
                 //手机端记录被选工委审核标志
                 //RssList entityTemp = new RssList(pageContext, "activities");
                 //entityTemp.request();
                 //entityTemp.select().where("id=?",req.get("id") ).get_first_rows();
                 //entityTemp.keyvalue("privateaudit", 1 );
                 //entityTemp.update().where("id=" + req.get("id") ).submit();
                 

              
                ranktable.timestamp();
                ranktable.keymyid(UserList.MyID(request));               
                
                ranktable.keyvalue("realname",userlist.get("realname"));
               // ranktable.keyvalue("userid",req.get("id")); // userlist.get("userid")
                ranktable.keyvalue("userid", userlist.get("userid")); // userlist.get("userid")
                ranktable.keyvalue("activitiesid",entity.get("id") ); // userlist.get("activitiesid")
                
                ranktable.remove("id");
                ranktable.keyvalue("id",ranktable.totalrows + 1);
                
               
                ranktable.keyvalue("classify",userlist.get("classify"));
                ranktable.keyvalue("lwstate","0");
                //ranktable.append().submit();
                //用户履职表状态该更改
                long systemTime = System.currentTimeMillis();  
                userActitivityTable.remove("id");
                //userActitivityTable.keyvalue("id",userlist.autoid);
                userActitivityTable.keyvalue("auditshijian",systemTime/1000);
                userActitivityTable.remove("auditState");
                //userActitivityTable.keyvalue("userid",req.get("id"));
                userActitivityTable.keyvalue("userid", userlist.get("userid"));
                userActitivityTable.keyvalue("auditState",2);
                
                userActitivityTable.keyvalue("evaluateResult", 2 );
                
                 userActitivityTable.keyvalue("attendancetype",2);
                
                //userActitivityTable.update().where("userid=" + req.get("id")).submit();           
                userActitivityTable.update().where("activitiesid=" + req.get("id") + " and userid="+ req.get("userid")  ).submit();
                
                
                //审核通过,更新 privateaudit //2021/9/29               
                activities.remove("evaluateResult");
                activities.keyvalue("privateaudit",1 );
                activities.update().where("id=" + req.get("id") ).submit();
                out.print("<script>alert('审核通过')</script>");
                }
                else {
//                ranktable.timestamp();
//                ranktable.keymyid(UserList.MyID(request));               
//                
//                ranktable.keyvalue("realname",userlist.get("realname"));
//                //ranktable.keyvalue("userid",req.get("id")); // userlist.get("userid")
//                ranktable.keyvalue("userid",userlist.get("userid"));// userlist.get("userid")
//                ranktable.keyvalue("activitiesid",entity.get("id") ); // userlist.get("activitiesid")
//
//                ranktable.remove("id");
//                ranktable.keyvalue("id",ranktable.totalrows + 1);
//
//                ranktable.keyvalue("classify",userlist.get("classify"));
//                ranktable.keyvalue("lwstate","0");
//                ranktable.append().submit();
                
                
                //用户履职表状态该更改
                long systemTime = System.currentTimeMillis();  
                userActitivityTable.remove("id");
                //userActitivityTable.keyvalue("id",userlist.autoid);
                userActitivityTable.keyvalue("auditshijian",systemTime/1000);
                userActitivityTable.remove("auditState");
                //userActitivityTable.keyvalue("userid",req.get("id"));
                userActitivityTable.keyvalue("userid", userlist.get("userid"));
                userActitivityTable.keyvalue("auditState", 3 );
                userActitivityTable.keyvalue("evaluateResult", 1);
                //userActitivityTable.update().where("userid=" + req.get("id")).submit();
                userActitivityTable.update().where("activitiesid=" + req.get("id") + " and userid="+ req.get("userid")  ).submit();
                
                //审核不通过,更新 privateaudit //2021/9/29
                activities.remove("evaluateResult");
                activities.keyvalue("privateaudit",2 );
                activities.update().where("id=" + req.get("id") ).submit();
  
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
        
        //removed by ding 
//        String str = entity2.get("userid");
//        String[] arry = str.split(",");
//        for (int i = 0; i < arry.length; i++) {
//            user.timestamp();
//            user.keyvalue("activitiesid", entity2.autoid);
//            user.keyvalue("userid", arry[i]);
//            user.keyvalue("myid", entity2.get("myid"));
//            user.append().submit();
//
//            senduser.pagesize = 10000000;
//            senduser.select().where("state=1 and myid=?", arry[i]).get_page_desc("id");
//            while (senduser.for_in_rows()) {
//                if (!(senduser.get("deviceid").isEmpty())) {
//                    jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条新的活动！", "活动通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条活动。")).build());
//                }
//            }
//        }
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
                         <td><% entity1.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动类型</td>                       
                        <td activitiestypeclassify="<% entity1.write("classify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td><% entity1.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td><% entity1.write("department"); %></td>
                    </tr>
                    
                    <%
                    if (entity1.get("enroll").equals("1") ){
                    %>
                    <tr>
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td rssdate="<% out.print(entity1.get("endshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <%
                    }
                    %>
                    
                    <tr>  
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity1.get("beginshijian")); %>,yyyy-MM-dd" ></td>                      
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间</td>                   
                        <td rssdate="<% out.print(entity1.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                   
                   
                    
                    
                     <tr>
                        <td class="dce w100 ">活动状态</td>
                        <td>
                        <% 
                            
                           
                            //entity.write("place"); 
                           
                            long systemTime1 = System.currentTimeMillis();                                  
                            long beginshijian1 = Long.parseLong( entity1.get("beginshijian") );
                            long finishshijian1 = Long.parseLong( entity1.get("finishshijian") );
                            
                            Date nowTime = new Date(System.currentTimeMillis());
                            SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            String retStrFormatNowDate = sdFormatter.format(nowTime);
                            
                            String datasplit [] = retStrFormatNowDate.split("-");                 
                            int sysYear = Integer.valueOf( datasplit[0]).intValue();
                            int sysMonth = Integer.valueOf( datasplit[1]).intValue();
                            int sysDay = Integer.valueOf( datasplit[2]).intValue();
                           
                            nowTime = new Date(Long.parseLong( entity1.get("beginshijian") )*1000);
                            sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            retStrFormatNowDate = sdFormatter.format(nowTime);
                            String datasplit1 [] = retStrFormatNowDate.split("-");          
                            int beginYear = Integer.valueOf( datasplit1[0]).intValue();
                            int beginMonth = Integer.valueOf( datasplit1[1]).intValue();
                            int beginDay = Integer.valueOf( datasplit1[2]).intValue();
                            
                            nowTime = new Date(Long.parseLong( entity1.get("finishshijian") )*1000);
                            sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            retStrFormatNowDate = sdFormatter.format(nowTime);
                            String datasplit2 [] = retStrFormatNowDate.split("-");          
                            int finishYear = Integer.valueOf( datasplit2[0]).intValue();
                            int finishMonth = Integer.valueOf( datasplit2[1]).intValue();
                            int finishDay = Integer.valueOf( datasplit2[2]).intValue();

                            if ( sysYear ==  beginYear && sysYear ==  finishYear ) {
                                 if ( sysMonth ==  beginMonth && sysMonth ==  finishMonth ) {
                                     if ( sysDay >= beginDay && sysDay <= finishDay  ) {
                                         out.print("活动中");
                                     }
                                     else if (  sysDay < beginDay ) {
                                          out.print("活动未开始");
                                     }
                                     else if (  sysDay > finishDay ) {
                                          out.print("活动已结束");
                                     }
                                 }
                                 else if ( sysMonth >  finishMonth ) {
                                      out.print("活动已结束");
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      out.print("活动未开始");
                                
                                }
                            }
                            else if ( sysYear  >  finishYear ) {
                                out.print("活动已结束");
                            }


                        %>
                        </td>
                    </tr>
                    
                    
                     <tr>
                        <td class="dce w100 ">代表</td>
                        <td id="seluserlist">
                        <% if ( entity1.get("userid").isEmpty( ) ){  
                        %>   
                         <% out.print("无");%>  
                        <% 
                        }else {
                        %>
                        
                        <%
                          String participants = "";
                          String uids[] = entity1.get("userid").split(","); 
                          RssList user = new RssList(pageContext, "user");
                          user.request();
                          for ( int i = 0 ; i < uids.length ; i ++ ) {
                            user.remove();
                            user.select().where("myid= "+ uids[i] ).get_first_rows();  
                            participants += user.get("realname");
                            participants += " ";
                          }
                        %>
                        <% out.print(participants);%>
                        
                        <%
                        }
                        %>
                     
                        </td>
                    </tr>
 
               
                    <tr>
                        <td class="dce w100 ">审核状态</td>
                        <td>
                        <% 
                            if ( userlist.get("attendancetype").equals("1") ) {
                                out.print( "<em style='color:green;font-weight:bold;'>已审核</em>" ); 
                            }
                            else {
                                out.print( "<em style='color:red;font-weight:bold;'>未审核</em>" );
                            }
                        %>
                        </td>
                    </tr>
                   
                   
                    <!--
                    <tr>
                        <td class="dce w100 left"><span>活动安排</span></td>
                        <td ><% entity.write("note"); %></td>
                    </tr>
                    -->
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
