<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%
    int myTotalScore = 0 ;
    int totalMixActivities = 0 ;
    StaffList.IsLogin(request, response);
    String tablename="rank_sort";
    //added by ding
    CookieHelper cookie = new CookieHelper(request, response);

       //1参加视察  2开展专题调研 3参加调研 4参加执法检查 5参加学习培训  6提出建议议案等  7出席人代会 8 参加其他会议 
      // 9接待选民 10 化解矛盾纠纷 11 扶弱济困 12 办好事、实事 13 参加公益慈善事业 14向选民述职 15 其他
          
                                                     //建议议案        //化解矛盾纠纷
//      int[] baseScore = new int[]{0, 6, 4 , 6, 6, 2 ,   6 ,     15 , 3 ,4  ,5,      5, 5, 5};
//      int[] extraScore = new int[]{0,  1, 1 , 1, 1, 2 ,  2 ,     0 ,  1 ,2  ,1,      1, 1, 1};
//      int[] maxScore = new int[]{0, 10, 6 , 10, 10, 6 , 10 ,    15 , 5 ,12 ,8,      8, 8, 8};                                
      int[] taScore = new int[]{ 0 , 0 , 0 , 0, 0 , 0 ,0 , 0  , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 };
      
      
        //1出席人代会  2参加其他会议 3 参加学习培训 4 提出议案，建议、批评和意见  5 开展专题调研  6参加视察、调研及执法检查 9 接待选民 10 化解矛盾纠纷 11 扶弱济困 12 办好事、实事
        //13 参加公益慈善事业 14 向选民述职 15 其他
      int[] baseScore = new int[]{  0, 15, 3 , 3, 6, 4 ,        6 ,       4 , 5 ,5  ,5,     5, 5, 5};
      int[] extraScore = new int[]{ 0, 0,  1 , 1, 2, 1 ,        1 ,       2 , 1 ,1  ,1,     1, 1, 0};
      int[] maxScore = new int[]{   0, 15, 5 , 5, 10, 6 ,       10 ,      12 ,8 ,8 ,8,      8, 8, 5 };                                


      
      RssListView list = new RssListView(pageContext, "user_delegation");
      list.request();
      int a = 1;
      
 
      //list.select().where("code like '%" + URLDecoder.decode(list.get("code"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and isdelegate=1 and state=2").get_page_desc("myid");
      list.select().where("isdelegate=1 and state=2").get_page_desc("myid");


      int totalScore = 0 ;
      String pids="";
      while (list.for_in_rows()) {
        pids += list.get("myid");
        pids +="|";
        
          int totalsuggests = 0 ;
          
          
          totalMixActivities = 0 ;
          int num = 0;
          int totalSuggestScore = 0 ;
          int snd_suggest = 0 ;
          int fuyi_yian = 0 ;
          int[] score = new int[]{ 6 , 2 , 2, 2, 2 ,2 ,2 ,2 ,2 };
          String[] ta = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
          RssListView list3 = new RssListView(pageContext, "sort");
          list3.query("SELECT lwstate,COUNT(*) AS num FROM sort_list_view WHERE myid=" + list.get("myid") + " and draft=2 GROUP BY lwstate");
          while (list3.for_in_rows()) {
            String lwstate =  list3.get("lwstate") ;
           
              if ( lwstate.equals("1") ) {
                  ta[7] = list3.get("num");
                  num += Integer.valueOf(list3.get("num"));
                  totalsuggests += Integer.valueOf(list3.get("num"));
              }
              if ( lwstate.equals("2") ) {
                  ta[8] = list3.get("num");
                  num += Integer.valueOf(list3.get("num"));
                  totalsuggests += Integer.valueOf( list3.get("num") );

              }
              if ( lwstate.equals("3") ) {
                  num += Integer.valueOf(list3.get("num"));
                  totalsuggests += Integer.valueOf( list3.get("num") );
              }
              if ( lwstate.equals("4") ) {
                  num += Integer.valueOf(list3.get("num"));
                  totalsuggests += Integer.valueOf(list3.get("num"));              
              }
              if ( lwstate.equals("5")) {
                  num += Integer.valueOf(list3.get("num"));
                  totalsuggests += Integer.valueOf(list3.get("num"));
              }
          }
      
          //begin 计算建议议案得分
          int index = 0 ;
          for ( int i = 0 ; i < num ; i ++ ) {          
              totalSuggestScore += score[ index ]; 
              index = 1 ;
          }
         
          //如果处理联名表     
          int fuyi_score = 0 ;
          RssListView secondlist = new RssListView(pageContext, "second_suggest");
          secondlist.select().where("userid=" + list.get("myid")).query();
          while (secondlist.for_in_rows()) {
          
              if (secondlist.get("lwstate").equals("1")) {
                  snd_suggest ++;
                  num ++;
                  totalsuggests ++ ;
              }
              else if (secondlist.get("lwstate").equals("2")) {
                  fuyi_yian ++ ;
                  num ++ ;
                  totalsuggests ++ ;
              }
               else if (secondlist.get("lwstate").equals("3")) {               
                  num ++ ;
                  totalsuggests ++ ;
              }
               else if (secondlist.get("lwstate").equals("4")) {               
                  num ++ ;
                  totalsuggests ++ ;
              }
               else if (secondlist.get("lwstate").equals("5")) {               
                  num ++ ;
                  totalsuggests ++ ;
              }
              if ( fuyi_score < 4 ){
                  fuyi_score ++ ;
              }
            }
            totalSuggestScore += fuyi_score ;
            if ( totalSuggestScore > 10 ) {
                totalSuggestScore = 10 ;
            }
            totalScore = totalSuggestScore;
   
            RssListView list4 = new RssListView(pageContext, "activities_userlist");
            list4.query("SELECT classify,COUNT(*) AS num FROM activities_userlist_list_view WHERE userid=" + list.get("myid") + " and attendancetype=2 GROUP BY classify");
           
            while ( list4.for_in_rows() ) {
                String classify = list4.get("classify");
                String aa[] = classify.split(",");
                int z = Integer.parseInt( aa [ 0 ] );   
                ta[z] = list4.get("num");               
                num += Integer.valueOf(list4.get("num"));
                
                if ( z >=6 && z <= 8 ) {
                    //处理视察调研执法检查
                    totalMixActivities += Integer.parseInt(ta[ z]);
                }else {
                    for ( int i = 0 ;i < z ; i ++ ){

                        taScore[ z ] += baseScore [ z ] ;
                        if ( i > 0 ) {
                         taScore[ z ] += extraScore [ z ] ;
                        }
                        if ( taScore[ z ] >= maxScore[ z ] ){
                            taScore[ z ] = maxScore[ z ];
                            break;
                        }
                    }     
                }
                
//                totalScore +=  taScore[ z ];
            }
           
            //计算参加视察、调研及执法检查
            for ( int i = 0 ; i < totalMixActivities ; i ++ ) {
              taScore[ 6 ] += baseScore [ 6 ] ;
                if ( i > 0 ) {
                 taScore[ 6 ] += extraScore [ 6  ] ;
                }
                if ( taScore[6 ] >= maxScore[ 6  ] ){
                    taScore[ 6 ] = maxScore[ 6  ];
                    break;
                }  
            }
//            totalScore +=  taScore[ 6 ];
            
int isadded = 0;
        if ( UserList.MyID(request).equals(list.get("myid"))) {
            pids = list.get("myid");
            out.print("<script>alert('审核通过')</script>");
isadded = 1 ;
        }
            totalScore =  0 ;
          
            //totalMixActivities = 1 ;
            myTotalScore = totalScore;
           RssList rslt = new RssList( pageContext,tablename );
//            rslt.delete().where("myid=1407").submit();
//            rslt.delete().where("myid="+list.get("myid")).submit();
            rslt.keyvalue( "myid",list.get("myid") );
            rslt.keyvalue( "realname",list.get("realname") );
            rslt.keyvalue( "delegationname",list.get("delegationname") );

            rslt.keyvalue("num",num );
            rslt.keyvalue("totalScore",totalScore);
            rslt.keyvalue("state",1);
            
            rslt.keyvalue("inspection",ta[ 6 ]);
            rslt.keyvalue("investigation",ta[ 7 ]);
            rslt.keyvalue("enforcement", ta[ 8 ]); 
            
            rslt.keyvalue("meeting", ta[ 1 ] );
            rslt.keyvalue("othermeeting",ta[ 2 ] );
            rslt.keyvalue("study",ta[ 3 ]);  
            rslt.keyvalue("suggest",totalsuggests );
            rslt.keyvalue("specialsurvey", ta[ 5 ]  );
            rslt.keyvalue("totalMixActivities", totalMixActivities );
            rslt.keyvalue("recievevoters", ta[ 9 ]  );
            rslt.keyvalue("reslovedispute", ta[ 10 ]  );
            rslt.keyvalue("helpweak", ta[ 11 ]  );
            rslt.keyvalue("goodthing", ta[ 12 ]  );
            rslt.keyvalue("charity", ta[ 13 ]  );
            rslt.keyvalue("reportvoter", ta[ 14 ]  );
            rslt.keyvalue("other", ta[ 15 ]  );
//            rslt.append().submit();
            
          

//            rslt.select().where("myid=?",list.get("myid")).get_first_rows();
//            if( rslt.totalrows > 0  ){
            if( rslt.select().where("myid=?",list.get("myid")).get_first_rows() ){    
                
                if ( isadded == 1) {
          
            out.print("<script>alert('添加1111')</script>");

        }
                rslt.remove("num");
                rslt.keyvalue("num",num );
                
                rslt.remove("totalScore");
                rslt.keyvalue("totalScore",totalScore);
                
                rslt.remove("inspection");
                rslt.keyvalue("inspection", ta[ 6 ] );
                rslt.remove("investigation");
                rslt.keyvalue("investigation", ta[ 7 ] );
                rslt.remove("enforcement");
                rslt.keyvalue("enforcement", ta[ 8 ] );
                 
                
          
                rslt.remove("meeting");
                rslt.keyvalue("meeting", ta[ 1 ] );
                
                rslt.remove("othermeeting");
                rslt.keyvalue("othermeeting",ta[ 2 ] );
                
                rslt.remove("study");
                rslt.keyvalue("study",ta[ 3 ]);
                
                rslt.remove("suggest");
                rslt.keyvalue("suggest", totalsuggests );
                
                rslt.remove("specialsurvey");
                rslt.keyvalue("specialsurvey", ta[ 5 ]  );
                
                rslt.remove("totalMixActivities");
               
                rslt.keyvalue("totalMixActivities", totalMixActivities  );
                
                rslt.remove("recievevoters");
                rslt.keyvalue("recievevoters", ta[ 9 ]  );
                
                rslt.remove("reslovedispute");
                rslt.keyvalue("reslovedispute", ta[ 10 ]  );
                
                rslt.remove("helpweak");
                rslt.keyvalue("helpweak", ta[ 11 ]  );
                
                rslt.remove("goodthing");
                rslt.keyvalue("goodthing", ta[ 12 ]  );
                
                rslt.remove("charity");
                rslt.keyvalue("charity", ta[ 13 ]  );
                
                rslt.remove("reportvoter");
                rslt.keyvalue("reportvoter", ta[ 14 ]  );
                
                rslt.remove("other");
                rslt.keyvalue("other", ta[ 15 ]  );
                
                           
                rslt.update().where("myid=?",list.get("myid")).submit();
               
            }else{
              
        if ( isadded == 1) {
          
            out.print("<script>alert('添加')</script>");

        }
        
            rslt.append().submit();
            }
            
       
            
           
        }
        
        RssList myranklist = new RssList(pageContext,tablename );
        myranklist.request();
        myranklist.pagesize=30;
        //myrank.select().where("myid=").get_page_desc("totalScore");
        myranklist.select().where("myid="+UserList.MyID(request)).get_first_rows();
        //myranklist.select().where("myid="+UserList.MyID(request)).get_page_desc("totalScore");
     
   // int myTotalScore =  myranklist.get("totalScore") ;
    String myrank ="我的总得分:" + String.valueOf( myTotalScore );
    myrank ="我的总得分:" + myranklist.get("totalScore") + pids ;
   
   
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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="export" class="butreports">导出</button>
                <div style="width:165px;margin-top:-26px;margin-left:80%;font-size: 15px;font-family:微软雅黑;font-weight: bold" >排序：<select id="select" style="border:1px;border-color:#82bee9;background-color:#0090D1;color:#ffffff;height:25px;margin-top:-3px;font-weight: bold">
                    <option value="1">&nbsp;总分</option> 
                    <option value="2" >&nbsp;出席人大会</option>  
                    <option value="3">&nbsp;附议建议</option>                 
                    <option value="4">&nbsp;领衔议案</option>
                    <option value="5">&nbsp;附议议案</option>
                    <option value="6">&nbsp;代表视察</option>
                    <option value="7">&nbsp;专题调研</option>
                    <option value="8">&nbsp;执法检查</option>
                    <option value="9">&nbsp;学习培训</option>
                    <option value="10">&nbsp;履职总数</option>                   
                    </select></div>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
               
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <%
                        if ( cookie.Get("powergroupid").equals("5")){  
                        %>
                        <tr>                  
                        <td colspan="20" class="tabheader" style="font-size:18px;font-weight: bold"><%out.print(myrank);%></td>  
                        
                        </tr>
                         <%
                          }  
                        %>
                        <tr>
                             <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w50">序号</th>
                            <th>代表姓名</th>
                            <th>代表团</th>
                            <th>出席人大会</th>
                            <th>参加其他会议</th>
                            <th>参加学习培训</th>
                            <th>提出议案、建议、批评和意见</th>
                            <th>开展专题调研</th>
                            <th>参加视察、调研及执法检查</th>
                            <th>接待选民</th>
                            <th>化解矛盾纠纷</th>
                            <th>履职总数</th>          
                            <th>总分</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                    
                           
                            RssList rank = new RssList(pageContext,tablename);
                            rank.request();
                            rank.pagesize=30;
                            rank.select().where("state = 1").get_page_desc("totalScore");
                            while(rank.for_in_rows()){
                            %>
                            <tr>
                            <td><input type="checkbox" name="id" value="<% out.print(rank.get("myid")); %>" /></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(rank.get("realname")); %></td>
                            <td><% out.print(rank.get("delegationname").isEmpty() ? "无" : rank.get("delegationname")); %></td>
                                <% 
                                if ( rank.get("meeting").equals("0")  ){   
                                %>    
                                <td><% out.print( rank.get("meeting") ); %></td>
                                <% 
                                }else {        
                                %>
                                 <td style="color:#c03e20;font-weight: bold;"><% out.print(rank.get("meeting") ); %></td>
                                 <%  
                                }
                                %> 
                                 <% 
                                if ( rank.get("othermeeting").equals("0")   ){   
                                %>    
                                <td><% out.print( rank.get("othermeeting") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("othermeeting") ); %></td>
                                 <%  
                                }
                                %> 
                                 <% 
                                if (  rank.get("study").equals("0")  ){   
                                %>    
                                <td><% out.print(  rank.get("study") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print(  rank.get("study") ); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if (  rank.get("suggest").equals("0")  ){   
                                %>    
                                <td><% out.print(rank.get("suggest") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("suggest")); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if ( rank.get("specialsurvey").equals("0")  ){   
                                %>    
                                <td><% out.print( rank.get("specialsurvey") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("specialsurvey") ); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if (  totalMixActivities  == 0 ){   
                                %>    
                                <td><% out.print( totalMixActivities ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( totalMixActivities ); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if (  rank.get("recievevoters").equals("0")   ){   
                                %>    
                                <td><% out.print(  rank.get("recievevoters") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("recievevoters") ); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if (   rank.get("reslovedispute").equals("0")  ){   
                                %>    
                                <td><% out.print(rank.get("reslovedispute")); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("reslovedispute") ); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if (  rank.get("num").equals("0")  ){   
                                %>    
                                <td><% out.print( rank.get("num") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("num") ); %></td>
                                 <%  
                                }
                                %> 
                                <% 
                                if ( rank.get("totalScore").equals("0") ){   
                                %>    
                                <td><% out.print( rank.get("totalScore") ); %></td>
                                <% 
                                }else {        
                                %>
                                <td style="color:#c03e20;font-weight: bold;"><% out.print( rank.get("totalScore") ); %></td>
                                 <%  
                                }
                                %> 
                    
                             <td>      
		            <span class="ys view" id="<% out.print( rank.get("myid")); %>" style="color:blue;cursor:pointer;font-weight:bold;">查看详情</span> 
                             |  <span class="ys export" id="<% out.print( rank.get("myid")); %>" style="color:blue;cursor:pointer;font-weight:bold;">导出</span>        
                            </td>   
                        </tr>
                        <%
                                a++;
                                 }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(rank.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(rank, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js">
        </script>
        
           <script >
            
            $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");

                     popuplayer.display("/lvzhilist/lzdetail.jsp?id=" + id + "&TB_iframe=true", '查看详情', {width: 1000, height: 650});
                })
            });   
            $(function(){
                ﻿$(".export").click(function(){
                    let id = $(this).attr("id");
                     popuplayer.display("/lvzhilist/userlist.jsp?relationid=" + id + "&TB_iframe=true", '导出', {width: 800, height: 550});
                })
            });   
             
        //    var $tt = $("#select").val();
           $("#select1").change(function(){
               var memutype = $("#select").val();
              console.log(memutype);
               $("#section tr").remove();
               new Ajax("LvZhiRankList").keyvalue({"state": memutype}).getJson(function (json) {
                    console.log(json);
                    $("#section").append("<tr><th>序号</th><th>代表姓名</th><th >代表团</th><th>领衔建议</th><th >附议建议</th><th >领衔议案</th><th >附议议案</th><th >代表视察</th> <th >专题调研</th> <th >执法检查</th> <th >学习培训</th> <th >履职总数</th>  <th >总分</th></tr>")
                   var t = 0;   
                $.each(json, function (k, v) {
                       t++;
                        $("#section").append("<tr><td>"+t+"</td><td>"+v.realname+"</td><td>"+v.delegationname+"</td><td>"+v.suggest+"</td><td>"+v.second_suggest+"</td><td>"+v.bill+"</td><td>"+v.fuyi_yian+"</td><td>"+v.inspection+"</td><td>"+v.investigation+"</td><td>"+v.enforcement+"</td><td>"+v.study+"</td><td>"+v.num+"</td><td>"+v.totalScore+"</td></tr>");
                    })
                })
           }) 
           
           
        
         $("#select").change(function () {
          var memutype = $("#select").val();
          //alert( $("#select").val() );
          if ( $("#select").val() == 1) { // 总分
                v_type = 'ranklist';
            }
            else if ($("#select").val() == 2){ //领衔建议
               v_type = 'ranklist2';
            }
            else if ($("#select").val() == 3){ // 附议建议
               v_type = 'ranklist3';
           }
           else if ($("#select").val() == 4){  // 领衔议案
               v_type = 'ranklist4';
           }
           else if ($("#select").val() == 5){ // 附议议案
               v_type = 'ranklist5';
           }
            else if ($("#select").val() == 6 ){ //代表视察
               v_type = 'ranklist6';
           }
           else if ($("#select").val() == 7 ){ //专题调研
               v_type = 'ranklist7';
           }
           else if ($("#select").val() == 8 ){ //执法检查
               v_type = 'ranklist8';
           }
           else if ($("#select").val() == 9 ){ //学习培训
               v_type = 'ranklist9';
           }
           else if ($("#select").val() == 10 ){ //履职总数
               v_type = 'ranklist10';
           }
               self.location = v_type + ".jsp";
               return false;
            })
           
           
        </script>

    </body>
</html>