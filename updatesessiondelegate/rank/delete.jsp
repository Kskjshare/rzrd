<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>


<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.DAL.Pagination"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "rank_sort");
    entity.request();
   
    
    if (req.get("action").equals("delete")) {
        entity.delete().where("id in(" + req.get("id") + ")").submit();
        
        
        //重新导入新数据        
        int[] suggestArray = new int[]{ 0 }; //建议议案
        int[] meetingArray = new int[]{ 0 }; //出席人代会
        int[] othermeetingArray = new int[]{ 0 }; //参加其他会议
        int[] studyArray = new int[]{ 0 }; //学习培训
        int[] inspectionArray = new int[]{ 0 }; //视察
        int[] investigationArray = new int[]{ 0 }; //调研
        int[] enforecementArray = new int[]{ 0 }; //执法检查
        int[] activityArray = new int[]{ 0 }; //视察 + 调研 + 执法检查
        int[] specialsurveyArray = new int[]{ 0 }; //开展专题调研
        int[] recievevotersArray = new int[]{ 0 }; //接待选民
        int[] resolvedisputeArray = new int[]{ 0 }; //化解矛盾纠纷
        int[] helpweakArray = new int[]{ 0 }; //扶弱济贫
        int[] goodthingArray = new int[]{ 0 }; //好人好事
        int[] charityArray = new int[]{ 0 }; //慈善     
        int[] reportvoterArray = new int[]{ 0 }; //向选民述职         
        int[] otherArray = new int[]{ 0 }; //其他  
        int[] numArray = new int[]{ 0 }; //履职总数  
        int[] totalScoreArray = new int[]{ 0 };
        
          
        int myTotalScore = 0 ;
        int totalMixActivities = 0 ;
        RssListView list = new RssListView(pageContext, "user_delegation");
        list.request();
        int a = 1;
        list.pagesize=400;
        list.select().where("code like '%" + URLDecoder.decode(list.get("code"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and isdelegate=1 and state=2").get_page_desc("myid");

        int totalSuggestScore = 0 ;
        int totalScore = 0 ;
        int totalsuggests = 0 ;
          totalMixActivities = 0 ;
        int num = 0;
        int[] score = new int[]{ 6 , 2 , 2, 2, 2 ,2 ,2 ,2 ,2 };
        String uuuids = "";
        int[] calculatescoreflag = new int[]{ 0 , 0 , 0, 0, 0 ,0 ,0 ,0 ,0, 0 , 0, 0, 0 ,0 ,0 ,0 ,0 };
        String[] ta = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
        int[] taScore = new int[]{ 0 , 0 , 0 , 0, 0 , 0 ,0 , 0  , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 };
      
     
            
      //1出席人代会  2参加其他会议 3 参加学习培训 4 提出议案，建议、批评和意见（附议人一条1分,最高分4分）  5 开展专题调研  6参加视察、调研及执法检查 9 接待选民 10 化解矛盾纠纷 11 扶弱济困 12 办好事、实事
      //13 参加公益慈善事业 14 向选民述职 15 其他
      int[] baseScore = new int[]{  0, 15, 3 , 3, 6, 4 ,        6 , 6 , 6 ,       4 , 5 ,5  ,5,     5, 5, 5};
      int[] extraScore = new int[]{ 0, 0,  1 , 1, 2, 1 ,        1 , 1 ,1 ,        2 , 1 ,1  ,1,     1, 1, 0};
      int[] maxScore = new int[]{   0, 15, 5 , 5, 10, 6 ,       10 , 10 ,10 ,     12 ,8 ,8 ,8,      8, 8, 5 };          
    
        int index = 0 ;
        //领衔建议议案
        RssListView list3 = new RssListView(pageContext, "sort");
        //附议建议议案
        RssListView secondlist = new RssListView(pageContext, "second_suggest");
        
        
        int socre = 0 ;
        int suggestBaseScore = 6 ;
        int suggestExtraScore = 2 ;
        while (list.for_in_rows()) {
            
            //领衔建议议案
            list3.query("SELECT lwstate,COUNT(*) AS num FROM sort_list_view WHERE myid=" + list.get("myid") + " and draft=2 GROUP BY lwstate"); 
            
            while (list3.for_in_rows()) {
                suggestArray[ index ] += Integer.valueOf( list3.get("num") );
                totalSuggestScore += suggestBaseScore ; 
                numArray [ index ] += Integer.valueOf( list3.get("num") );
            }
            
            //附议建议议案
            int fuyi_score = 0 ;
            secondlist.select().where("userid=" + list.get("myid")).query();
            while (secondlist.for_in_rows()) {
                suggestArray[ index ] ++ ;
                numArray [ index ] ++ ; 
                totalSuggestScore += suggestExtraScore ;  
                fuyi_score ++ ;
            }
            
            if ( fuyi_score > 4 ) {
                fuyi_score = 4 ;
            }
            totalSuggestScore += fuyi_score ;
            
            
            if ( totalSuggestScore > 10 ) { //最高10分
                totalScoreArray [ index ] = 10 ;
            }
            
            //读取履职活动
            RssListView list4 = new RssListView( pageContext, "activities_userlist" );
            list4.query("SELECT classify,COUNT(*) AS num FROM activities_userlist_list_view WHERE userid=" + list.get("myid") + " and attendancetype=2 GROUP BY classify");    
            while (list4.for_in_rows()) {                     
                String classify = list4.get("classify");             
                String aa[] = classify.split(",");
                int z = Integer.parseInt( aa [ 0 ] );               
                ta[z] = list4.get("num");               
                num += Integer.valueOf( list4.get("num") ); 
                
                numArray[ index ] += Integer.valueOf( list4.get("num") ); 
               
                calculatescoreflag[z] = 1 ; //已经有过积分了
                if ( z >=6 && z <= 8 ) {
                    //处理视察调研执法检查
                    //totalMixActivities += Integer.parseInt(ta[ z ] );
                    activityArray[ index ] += Integer.parseInt(ta[ z ] );
                }else {                                    
                    for ( int i = 0 ;i < Integer.parseInt( ta[ z ] ) ; i ++ ){
                        taScore[ z ] += baseScore [ z ] ;                     
                        if ( i > 0 ) {
                            taScore[ z ] += extraScore [ z ] ;                       
                        }
                        if ( taScore[ z ] >= maxScore[ z ] ){
                            taScore[ z ] = maxScore[ z ];
                            break;
                        }
                        
                    }                                   
                    totalScore += taScore [ z ] ;
                    taScore [ z ]  = 0 ;   
                }
            }          
            index ++ ;
        }
        
        
        
        RssListView list1 = new RssListView(pageContext, "user_delegation");
        list1.request();
        int a1 = 1;
        int mindex = 0 ;
        list1.pagesize=400;
        list1.select().where("code like '%" + URLDecoder.decode(list.get("code"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and isdelegate=1 and state=2").get_page_desc("myid");
        while (list1.for_in_rows()) {
        
            RssList rslt = new RssList( pageContext,"rank_sort" );
            rslt.keyvalue("myid",list.get("myid"));
            rslt.keyvalue("realname",list.get("realname"));
            rslt.keyvalue("delegationname",list.get("delegationname"));
            
//            rslt.keyvalue("inspection",ta[ 6 ]);
//            rslt.keyvalue("investigation",ta[ 7 ]);
//            rslt.keyvalue("enforcement", ta[ 8 ]); 
  
//            rslt.keyvalue("meeting", meetingArray[ mindex ] );
//            rslt.keyvalue("othermeeting",othermeetingArray[ mindex ] );
//            rslt.keyvalue("study",studyArray[ mindex ]);  
//            rslt.keyvalue("suggest",suggestArray[ mindex ] );
//            rslt.keyvalue("specialsurvey", specialsurveyArray[ mindex ]  );
//            rslt.keyvalue("totalMixActivities", activityArray[ mindex ] );
//            rslt.keyvalue("recievevoters", recievevotersArray[ mindex ]  );
//            rslt.keyvalue("reslovedispute", resolvedisputeArray[ mindex ]  );
//            rslt.keyvalue("helpweak", helpweakArray[ mindex ]  );
//            rslt.keyvalue("goodthing", goodthingArray[ mindex ]  );
//            rslt.keyvalue("charity", charityArray[ mindex ]  );
//            rslt.keyvalue("reportvoter", reportvoterArray[ mindex ]  );
//            rslt.keyvalue("other", otherArray[ mindex ]  );
//
//            rslt.keyvalue("num",numArray[ mindex ]);
//            rslt.keyvalue("totalScore",totalScoreArray[ mindex ]);
//            rslt.keyvalue("state",1 );
//            rslt.append().submit();
//            mindex ++ ;
//            if(rslt.select().where("myid=?",list.get("myid")).get_first_rows()){
//
//                rslt.remove("inspection");
//                rslt.keyvalue("inspection", ta[ 6 ] );
//                rslt.remove("investigation");
//                rslt.keyvalue("investigation", ta[ 7 ] );
//                rslt.remove("enforcement");
//                rslt.keyvalue("enforcement", ta[ 8 ] );
//                 
//                
//          
//                rslt.remove("meeting");
//                rslt.keyvalue("meeting", ta[ 1 ] );
//                
//                rslt.remove("othermeeting");
//                rslt.keyvalue("othermeeting",ta[ 2 ] );
//                
//                rslt.remove("study");
//                rslt.keyvalue("study",ta[ 3 ]);
//                
//                rslt.remove("suggest");
//                rslt.keyvalue("suggest", totalsuggests );
//                
//                rslt.remove("specialsurvey");
//                rslt.keyvalue("specialsurvey", ta[ 5 ]  );
//                
//                rslt.remove("totalMixActivities");          
//                rslt.keyvalue("totalMixActivities", totalMixActivities  );
//                
//                rslt.remove("recievevoters");
//                rslt.keyvalue("recievevoters", ta[ 9 ]  );
//                
//                rslt.remove("reslovedispute");
//                rslt.keyvalue("reslovedispute", ta[ 10 ]  );
//                
//                rslt.remove("helpweak");
//                rslt.keyvalue("helpweak", ta[ 11 ]  );
//                
//                rslt.remove("goodthing");
//                rslt.keyvalue("goodthing", ta[ 12 ]  );
//                
//                rslt.remove("charity");
//                rslt.keyvalue("charity", ta[ 13 ]  );
//                
//                rslt.remove("reportvoter");
//                rslt.keyvalue("reportvoter", ta[ 14 ]  );
//                
//                rslt.remove("other");
//                rslt.keyvalue("other", ta[ 15 ]  );
//
//
//
//                rslt.remove("num");
//                rslt.keyvalue("num",num);
//                
//                rslt.remove("totalScore");
//                rslt.keyvalue("totalScore",totalScore);
//                rslt.update().where("myid=?",list.get("myid")).submit();
//            }else{
//            rslt.append().submit();
//            }
            
            
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
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                删除后不可恢复，请谨慎操作？
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
