<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>

<%
    StaffList.IsLogin(request, response);
    
//增加闭会 开会 条件过滤 
   String meetingTime="0";
   int isMeeting = 0 ;
   try {
       String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
       Properties properties = new Properties();
       InputStream is = new FileInputStream(propertiesFileName);
       properties.load(is);
       is.close();
       meetingTime = properties.get("meetingtime").toString();
   } catch (Exception e) {
       e.printStackTrace();
   }
   if ( meetingTime.equals("1")){
       isMeeting = 1;
    }
    else {
       isMeeting = 0 ;
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
            .cellbor{width: 900px;margin-top:20px;}
            .red3{color:#c03e20}
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height:12px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height:12px;text-align: center;}
            .dce{background: #dce6f5;}
            .cellbor>tbody>tr>.indent{text-indent: 10px;text-align: left}
            #divide{height:6px;}
            .cellbor i{ color: #a79012;font-style: normal}
            .cellbor tr i:nth-child(2){margin-left: 5px;}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop">
                <tr>
                    <td colspan="5" class="tabheader">提交情况</td>
                </tr>
                <tr class="dce">
                    <td>分类</td>
                    <td>项目</td>
                    <td>说明</td>
                    <td>件数</td>
                    <td>操作</td>
                </tr>
                <%
                    CookieHelper cookie = new CookieHelper(request, response);
                    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                    
                    //统计界面提示信息
                    String unreviewString = "等待审查处理的建议";
                    String isdbtshenhe = "1";  // 是否通过代表团审查 （2 否  1是）
                    //String examination = "5"; //审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查
                    String auditState = "未审查" ;
                    String type = "建议";
                    
                    String row1Url = "list.jsp?lwstate=1&isdbtshenhe=1&examination=2&isxzsc=1";
                    //建议栏目的url
                    String unReview_url = "list.jsp?lwstate=1&iscs=0&examination=1&isdbtshenhe=2&isxzsc=0";
                    String agree_url = "list.jsp?lwstate=1&handlestate=3&draft=2";
                    String disagree_url = "list.jsp?lwstate=1&handlestate=3&draft=2";
                    
                    ////议案栏目的url
                    String unReview_yian_url = "list.jsp?lwstate=2&examination=1&iscs=0&isdbtshenhe=2&isxzsc=0";
                    String yian_agree_url = "list.jsp?lwstate=2&isxzsc=1&examination=2&isdbtshenhe=1";
                    
                    //所有建议的URL
                    String totalSuggestUrl = "list.jsp?lwstate=1&draft=2";
                    
                    //批评
                    String criticism_agree_url = "list.jsp?lwstate=3&examination=2&draft=2";
                    String criticism_disagree_url = "list.jsp?lwstate=3&examination=3&draft=2";
                    
                     //意见
                    String opinion_agree_url = "list.jsp?lwstate=4&examination=2&draft=2";
                    String opinion_disagree_url = "list.jsp?lwstate=4&examination=3&draft=2";
                    //质询
                    String inquery_agree_url = "list.jsp?lwstate=5&examination=2&draft=2";
                    String inquery_disagree_url = "list.jsp?lwstate=5&examination=3&draft=2";
                    
                    
//                    String strXzfb = "经乡镇人大主席团办审查处理确认";
                    String strXzfb = "经审查处理确认";
                    //added by ding
                    if ( isMeeting == 1 && cookie.Get("powergroupid").equals("25") ){
                        //如果开会期间主席团登录，不应该看到被代表团置回的记录
                         unReview_url = "list.jsp?lwstate=1&isdbtshenhe=1&examination=5&isxzsc=0";  
                         strXzfb = "经审查处理确认";
                         auditState = "未审查";
                         
                        // unReview_yian_url = "list.jsp?lwstate=2&examination=1&iscs=1&isdbtshenhe=1&isxzsc=0";
                        
                    }
                    
                 
                    String rwhere = "";
                    String view = "";
                    if (cookie.Get("powergroupid").equals("16")) {
                        rwhere = "draft=2";
                        view = "sort";
                    } else {
                        if (cookie.Get("powergroupid").equals("25")) { //乡镇人大主席团                  
                            rwhere = "draft=2 and xzscID=" + UserList.MyID(request);
                           
                             //2021.4.11  ding
                            if ( isMeeting == 1 )
                                rwhere = "draft=2 and ismeet=1 and examination=2 and xzscID=" + UserList.MyID(request);

                            else
                                rwhere = "draft=2 and ismeet=0 and xzscID=" + UserList.MyID(request);
                            //rwhere = "draft=2 and ismeet=0";
                            view = "scr_suggest";
                            
                            //added by ding
                            unreviewString = "等待审查处理的建议";
                            isdbtshenhe = "2" ;
                        } else {
                            rwhere = "draft=2 and userid=" + UserList.MyID(request);    
                            //2021.4.11  ding
                            if ( isMeeting == 1 )
                                rwhere = "draft=2 and ismeet=1 and userid=" + UserList.MyID(request);
                            else
                                rwhere = "draft=2 and ismeet=0 and userid=" + UserList.MyID(request);
                              
                            view = "scr_suggest";
                        }
                    }

                    RssListView list = new RssListView(pageContext, view);
                    list.request();
                    list.pagesize = 10000000;
                    list.select().where(rwhere).get_page_desc("id");
                    int a = 0;
                    int b = 0;
                    int refuseCount = 0;
                    int d = 0;
                    int e = 0;
                    int aa = 0;
                    int bb = 0;
                    int refuseCount_yian = 0;
                    int dd = 0;
                    int ee = 0;
                    
                    int handleCount = 0 ;
                    int suggest_waiting = 0 ;//待处理的建议
                    int suggest_agree = 0 ;//审查同意的建议 
                    
                    int yian_waiting = 0 ; //待处理的议案
                    int yian_agree = 0 ;
                    
                    int criticism_waiting = 0 ; //待处理的批评
                    int criticism_agree = 0;
                    int criticism_unsubmit = 0;
                    
                    int opinion_waiting = 0 ;//待处理的意见
                    int opinion_unsubmit = 0;
                    int opinion_submit = 0;
                    int inquery_waiting = 0;//带处理的质询
                    int inquery_unsubmit = 0;
                    int inquery_submit = 0;
                   
                    
                    totalSuggestUrl= "list.jsp?lwstate=1&examination=5&iscs=1&isdbtshenhe=1&isxzsc=0";               
//                   if (list.get("lwstate").equals("1")){//建议            
//                     type = "建议";
//                     suggest_waiting = 3 ;
//                     totalSuggestUrl = "list.jsp?lwstate=1&draft=2";
//                      if (cookie.Get("powergroupid").equals("25")) { //乡镇人大主席团
//                        totalSuggestUrl= "list.jsp?lwstate=1&examination=2&iscs=&isxzsc=0";                  
//                        unReview_url = "list.jsp?lwstate=1&isdbtshenhe=1&examination=1&isxzsc=0"; 
//                        if ( isMeeting == 1 ) {
//                             totalSuggestUrl= "list.jsp?lwstate=1&draft=2&ismeet=1&isxzsc=0"; 
//                        }
//                        else {
//                            totalSuggestUrl= "list.jsp?lwstate=1&draft=2&ismeet=0&isxzsc=0"; 
//                        }
//                        
//                      }
//                      
//                      
//                    }
//                    
//                    else if (list.get("lwstate").equals("2")){ //议案
//                        type = "议案";
//                        //totalSuggestUrl = "list.jsp?lwstate=1&draft=2";
//                    }
//                    else if (list.get("lwstate").equals("3")){ //批评
//                     type = "批评";
//                     totalSuggestUrl = "list.jsp?lwstate=3&draft=2";
//                    }
//                    else if (list.get("lwstate").equals("4")){ //意见
//                     type = "意见";
//                     totalSuggestUrl = "list.jsp?lwstate=4&draft=2";
//                    }
//                    else if (list.get("lwstate").equals("5")){ //质询
//                     type = "质询";
//                     totalSuggestUrl = "list.jsp?lwstate=5&draft=2";
//                    }
                    
                    // type =list.get("lwstate") +cookie.Get("powergroupid");
                    while (list.for_in_rows()) {
                        
                      
                     if (list.get("lwstate").equals("1")){//建议
                  
                     type = "建议";
                    
                     totalSuggestUrl = "list.jsp?lwstate=1&draft=2";
                      if (cookie.Get("powergroupid").equals("25")) { //乡镇人大主席团
                        //totalSuggestUrl= "list.jsp?lwstate=1&examination=2&iscs=&isxzsc=0";                  
                        //unReview_url = "list.jsp?lwstate=1&isdbtshenhe=1&examination=1&isxzsc=0"; 
                        if ( isMeeting == 1 ) {
                             totalSuggestUrl= "list.jsp?lwstate=1&draft=2&ismeet=1&isxzsc=0"; 
                             //yian_agree_url = "list.jsp?lwstate=2&isxzsc=0&examination=2&isdbtshenhe=1&ismeet=1";
                             yian_agree_url = "list.jsp?lwstate=2&examination=2&isdbtshenhe=1&ismeet=1";
                             criticism_agree_url = "list.jsp?lwstate=3&examination=2&draft=2&ismeet=1&isdbtshenhe=1" ;
                              opinion_agree_url = "list.jsp?lwstate=4&examination=2&draft=2&ismeet=1&isdbtshenhe=1" ;
                                inquery_agree_url = "list.jsp?lwstate=5&examination=2&draft=2&ismeet=1&isdbtshenhe=1" ;
                        }
                        else {
                            //totalSuggestUrl= "list.jsp?lwstate=1&draft=2&ismeet=0&isxzsc=" + list.get("isxzsc"); 
                            totalSuggestUrl= "list.jsp?lwstate=1&draft=2&ismeet=0"; 
                            unReview_url = "list.jsp?lwstate=1&isdbtshenhe=2&examination=1&isxzsc=0"; 
                            criticism_agree_url = "list.jsp?lwstate=3&examination=2&draft=2&ismeet=0" ;
                            criticism_disagree_url = "list.jsp?lwstate3&examination=3&draft=2&ismeet=0";
                            
                            opinion_agree_url = "list.jsp?lwstate=4&examination=2&draft=2&ismeet=0" ;
                            opinion_disagree_url = "list.jsp?lwstate=4&examination=3&draft=2&ismeet=0";
                            
                             inquery_agree_url = "list.jsp?lwstate=5&examination=2&draft=2&ismeet=0" ;
                            inquery_disagree_url = "list.jsp?lwstate=5&examination=3&draft=2&ismeet=0";
                          
                 
                        }
                        
                      }
                    }
                    
                    else if (list.get("lwstate").equals("2")){ //议案
                        type = "议案";
                        //totalSuggestUrl = "list.jsp?lwstate=1&draft=2";
                    }
                    else if (list.get("lwstate").equals("3")){ //批评
                     type = "批评";
                     totalSuggestUrl = "list.jsp?lwstate=3&draft=2";
                     criticism_agree_url = "list.jsp?lwstate=3&examination=2&ismeet=0&draft=2";
                     criticism_disagree_url = "list.jsp?lwstate=3&examination=3&ismeet=0&draft=2";
                    }
                    else if (list.get("lwstate").equals("4")){ //意见
                     type = "意见";
                     totalSuggestUrl = "list.jsp?lwstate=4&draft=2";
                    }
                    else if (list.get("lwstate").equals("5")){ //质询
                     type = "质询";
                     totalSuggestUrl = "list.jsp?lwstate=5&draft=2";
                    }
                        
                        
                        
                        
                        if (list.get("lwstate").equals("1")) {
                            a++;
                            if (list.get("examination").equals("1")) {
                                d++;
                                suggest_waiting ++;
                            }
                            if (list.get("examination").equals("2")) {
                              
                                suggest_agree ++;
                            }
                           
                            if (list.get("examination").equals("3")) {
                                refuseCount ++;
                                
                                //added by ding
                                if ( isMeeting == 1 && cookie.Get("powergroupid").equals("25") ){
                                    //如果开会期间主席团登录，不应该看到被代表团置回的记录
                                    refuseCount --;
                                }
                            }
                            
                             if (list.get("isxzsc").equals("1")) {
                                 //removed by ding
                               // b++;
                            }
//                            if ( list.get("handlestate").equals("3") ) {
//                                //handlestate : 3代表已经交办的状态
//                                handleCount ++ ;
//                                
//                            }
                            
//                            //闭会期间，人大主席团登录，在统计界面，为审查记录数量不对，把iscs 从1 改为0 examination的值5改为0
//                            if ( list.get("iscs").equals("0") && list.get("examination").equals("1") && list.get("isxzsc").equals("0") 
//                                    && meetingTime.equals("0") && cookie.Get("powergroupid").equals("25") ) {
//                                e++;
//                            }
                            
                            //开会       removed by ding 2021.4.11                
//                             if (  meetingTime.equals("1") && cookie.Get("powergroupid").equals("25") ) {
//                                //e++;
//                                if ( list.get("handlestate").equals("2") && list.get("examination").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
//                                    suggest_waiting ++ ;
//                                }
//                            }
//                             
                             
                            
                             
                        }
                        
                        if (list.get("lwstate").equals("2")) { //议案
                            aa++;
                            if (list.get("examination").equals("1")) {
                                dd++;
                                yian_waiting ++;
                            }
                            
                             if (list.get("examination").equals("2")) {
                                yian_agree ++;
                            }
                            if (list.get("isxzsc").equals("1")) {
                                bb++;
                            }
                           // if (list.get("examination").equals("3")) {
                            //    cc++;
                            //}
                            
                             if (list.get("examination").equals("3")) {
                                refuseCount_yian ++;
                                
                                //added by ding
                                if ( isMeeting == 1 && cookie.Get("powergroupid").equals("25") ){
                                    //如果开会期间主席团登录，不应该看到被代表团置回的记录
                                    refuseCount_yian --;
                                }
                            }
                            
//                            
//                            //闭会期间，人大主席团登录，在统计界面，为审查记录数量不对，把iscs 从1 改为0 examination的值5改为0
//                            if ( meetingTime.equals("0") && list.get("iscs").equals("0") && list.get("examination").equals("1") && list.get("isxzsc").equals("0")) {
//                                yian_waiting++;
//                            }
//                            
//                       
//                             //开会
//                             if (  meetingTime.equals("1") && cookie.Get("powergroupid").equals("25") ) {
//                                //e++;
//                                if ( list.get("handlestate").equals("2") && list.get("examination").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
//                                    yian_waiting ++ ;
//                                }
//                            }    
                        }
                        
                        
                         
                         
                          if (list.get("lwstate").equals("3")) {//批评                     
                            if (list.get("examination").equals("1")) {
                                  criticism_waiting ++;
                            }
                            
                             if (list.get("examination").equals("2")) {
                                  criticism_agree ++;
                            }
                            
//                            if (list.get("handlestate").equals("3") &&  list.get("deal").equals("1")) {
//                                criticism_agree ++ ;
//                                if ( criticism_waiting > 0 )
//                                criticism_waiting --;
//                            }
                            
                             if (list.get("examination").equals("3")) {
                               criticism_unsubmit ++;
                            }
                        }
                          
                          
                           if (list.get("lwstate").equals("4")) { ////意见  
                            
                              if (list.get("examination").equals("1")) {
                               opinion_waiting ++;
                            }
                              
                            if (list.get("examination").equals("2")) {
                                  opinion_submit ++;
                            }
                            
//                            if (list.get("handlestate").equals("3") &&  list.get("deal").equals("1")) {
//                                opinion_submit ++ ;
//                                if ( opinion_waiting > 0 )
//                                opinion_waiting --;
//                            }
//                            
                             if (list.get("examination").equals("3")) {
                               opinion_unsubmit ++;
                            }
                        }
                           
                           
                        if (list.get("lwstate").equals("5")) { ////质询
                            
                            if (list.get("examination").equals("1")) {
                               inquery_waiting ++;
                            }
                            
                              if (list.get("examination").equals("2")) {
                                  inquery_submit ++;
                            }
//                            if (list.get("handlestate").equals("3") &&  list.get("deal").equals("1")) {
//                                inquery_submit ++ ;
//                                if ( inquery_waiting > 0 )
//                                inquery_waiting --;
//                            }
//                            


                             if (list.get("examination").equals("3")) {
                               inquery_unsubmit ++;
                            }
                                                
                        }
                        
                        
                    }
                %>
                <tr>
                    <td rowspan="4">建议</td>
                    <td><% out.print(auditState);%></td> 
                    <td align="left" class="indent">等待审查处理的建议</td>
                    <td class="red3"><% out.print( suggest_waiting );%></td>
                    <!--td><a href="list.jsp?lwstate=1&iscs=1&examination=5&isdbtshenhe=1&isxzsc=0">查看</a></td-->
                    <!--zyx-->
                    <% 
                    if ( suggest_waiting  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                     <td style="font-weight:bold;"><a href=<%
                         if ( suggest_waiting ==  0 )
                             out.print("list.jsp?lwstate=1&examination=1&draft=2");
                         else
                         out.print( unReview_url );
                     %> >查看</a></td>
                      <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>提交的建议:</i><i><% out.print( suggest_agree + handleCount );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( suggest_agree + refuseCount + handleCount  );%></td>
                    <!--td><a href=<%out.print("list.jsp?lwstate=1&handlestate=3&draft=2");%>>查看</a></td-->
                    <!--zyx-->
                    <% 
                    if ( suggest_agree + handleCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                     <td style="font-weight:bold;"><a href=<%out.print(agree_url);%>>查看</a></td>
                      <%
                    } ;
                    %>
                    <!--zyx end-->
                    
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不提交</i>的建议:<i><% out.print( refuseCount );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                  
                    <td style="font-weight:bold;"><a href=<%
                        if ( refuseCount == 0 )
                              out.print("list.jsp?lwstate=1&examination=1&draft=1");
                        else
                        out.print(disagree_url);
                    %>>查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end--> 
                    
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经现乡镇政府办审查处理,确认<i>撤案</i>的建议:<i><% out.print( refuseCount );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                    
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有建议</td>
                    <td class="red3"><% out.print( suggest_waiting + suggest_agree  + refuseCount+ handleCount );%></td>
                    <!--zyx-->
                    <% 
                    if ( suggest_waiting + suggest_agree  + refuseCount+ handleCount   == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print(totalSuggestUrl);%> >查看</a></td> 
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">议案</td>
                    <td>未审查</td>
                    <td align="left" class="indent">已经正式提交且待审查处理议案</td>
                    <td class="red3"><% out.print( yian_waiting);%></td>
                    <!--td><a href="list.jsp?lwstate=2&examination=5&iscs=1&isdbtshenhe=1&isxzsc=0">查看</a></td-->
                    <!--zyx-->
                    <% 
                    if ( yian_waiting  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print(unReview_yian_url);%>>查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%>确认<i>提交</i>的议案:<i><% out.print( yian_agree );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( yian_agree + refuseCount_yian );%></td>
                    <!--zyx-->
                    <% 
                    if ( yian_agree  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <!--td><a href="list.jsp?lwstate=2&isxzsc=1&examination=2&isdbtshenhe=1">查看</a></td-->
                      <td style="font-weight:bold;"><a href=<%out.print(yian_agree_url);%>>查看</a></td>
                      <%
                    } ;
                    %>
                    <!--zyx end-->
                    
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不交提交</i>的议案:<i><% out.print( refuseCount_yian );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount_yian  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td><a href="list.jsp?lwstate=2&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>撤案</i>的议案:<i><% out.print( refuseCount_yian );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount_yian  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有议案</td>
                    <td class="red3"><% out.print( yian_waiting + yian_agree + refuseCount_yian );%></td>
                    <!--zyx-->
                    <% 
                    if ( yian_waiting + yian_agree + refuseCount_yian  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr>
                    <td rowspan="4">批评</td>
                    <td><% out.print(auditState);%></td> 
                    <td align="left" class="indent">等待审查<i>处理的</i>批评</td>
                    <td class="red3"><% out.print( criticism_waiting );%></td>
                    <!--td><a href="list.jsp?lwstate=1&iscs=1&examination=5&isdbtshenhe=1&isxzsc=0">查看</a></td-->
                    <% 
                    if ( criticism_waiting  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                     <td style="font-weight:bold;"><a href=<%
                            if ( criticism_waiting ==  0 )
                             out.print("list.jsp?lwstate=3&examination=1&draft=2");
                         else
                         out.print("list.jsp?lwstate=3&draft=2");
                            %> >查看</a></td>
                      <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>提交的批评:</i><i><% out.print( criticism_agree );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( criticism_agree + criticism_unsubmit );%></td>
                    <!--zyx-->
                    <% 
                    if ( criticism_agree  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print(criticism_agree_url);%>>查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不提交</i>的批评:<i><% out.print( criticism_unsubmit );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( criticism_unsubmit  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=3&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经现乡镇政府办审查处理,确认<i>撤案</i>的批评:<i><% out.print( refuseCount );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=3&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有批评</td>
                    <td class="red3"><% out.print( criticism_agree + criticism_unsubmit + criticism_waiting );%></td>
                    <!--zyx-->
                    <% 
                    if ( criticism_agree + criticism_unsubmit + criticism_waiting  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print("list.jsp?lwstate=3&draft=2");%> >查看</a></td> 
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr> 
                <tr id="divide" class="dce"></tr>
                <tr>
                    <tr>
                    <td rowspan="4">意见</td>
                    <td><% out.print(auditState);%></td> 
                    <td align="left" class="indent">已经正式提交的,且待审查<i>处理的</i>意见</td>
                    <td class="red3"><% out.print( opinion_waiting );%></td>
                    <!--td><a href="list.jsp?lwstate=1&iscs=1&examination=5&isdbtshenhe=1&isxzsc=0">查看</a></td-->
                    <% 
                    if ( opinion_waiting  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                     <td style="font-weight:bold;"><a href=<%
                         
                         if ( opinion_waiting ==  0 )
                             out.print("list.jsp?lwstate=4&examination=1&draft=2");
                         else
                         out.print("list.jsp?lwstate=4&handlestate=2&draft=2");
                     %> >查看</a></td>
                      <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>提交的意见:</i><i><% out.print(  opinion_submit  );%></i></td>
                    <td class="red3" rowspan="2"><% out.print(  opinion_submit + opinion_unsubmit );%></td>
                    <!--zyx-->
                    <% 
                    if ( opinion_submit  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print( opinion_agree_url );%>>查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不提交</i>的意见:<i><% out.print( refuseCount );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经现乡镇政府办审查处理,确认<i>撤案</i>的意见:<i><% out.print( refuseCount );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有意见</td>
                    <td class="red3"><% out.print( opinion_waiting   + opinion_submit + opinion_unsubmit );%></td>
                    <!--zyx-->
                    <% 
                    if ( opinion_waiting   + opinion_submit + opinion_unsubmit  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print( "list.jsp?lwstate=4&draft=2 ");%> >查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr id="divide" class="dce"></tr>
                <tr>
                    <tr>
                    <td rowspan="4">质询</td>
                    <td><% out.print(auditState);%></td> 
                    <td align="left" class="indent">已经正式提交的,且待审查<i>处理的</i>质询</td>
                    <td class="red3"><% out.print( inquery_waiting );%></td>
                    <!--td><a href="list.jsp?lwstate=1&iscs=1&examination=5&isdbtshenhe=1&isxzsc=0">查看</a></td-->
                    <% 
                    if ( inquery_waiting  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                     <td style="font-weight:bold;"> <a href=<%
                          
                         if ( opinion_waiting ==  0 )
                             out.print("list.jsp?lwstate=5&examination=1&draft=2");
                         else
                         out.print("list.jsp?lwstate=5&handlestate=2&draft=2");
                        
                     
                     %> >查看</a></td>
                      <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>提交的质询:</i><i><% out.print( inquery_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( inquery_submit + inquery_unsubmit );%></td>
                    <!--td><a href=<%out.print( "list.jsp?lwstate=5&examination=2&handlestate=3&draft=2" );%>>查看</a></td-->
                     <!--zyx-->
                    <% 
                    if ( inquery_submit  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print( inquery_agree_url );%>>查看</a>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                    </td>
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不提交</i>的质询:<i><% out.print( inquery_unsubmit );%></i></td>
                     <!--zyx-->
                    <% 
                    if ( inquery_unsubmit  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&examination=3&handlestate=4&draft=2">查看</a></td>
                     <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经现乡镇政府办审查处理,确认<i>撤案</i>的质询:<i><% out.print( refuseCount );%></i></td>
                    <!--zyx-->
                    <% 
                    if ( refuseCount  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&examination=3&draft=2">查看</a></td>
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有质询</td>
                    <td class="red3"><% out.print( inquery_waiting  + inquery_submit + inquery_unsubmit );%></td>
                    <!--zyx-->
                    <% 
                    if ( inquery_waiting  + inquery_submit + inquery_unsubmit  == 0 ) {
                    %>
		     <td>查看</td>
                    <%
                    } else {	  
                    %>
                    <td style="font-weight:bold;"><a href=<%out.print(  "list.jsp?lwstate=5&draft=2" );%> >查看</a></td> 
                    <%
                    } ;
                    %>
                    <!--zyx end-->
                </tr>
                <tr id="divide" class="dce"></tr>
                <tr>
                <tr class="dce">
                    <td colspan="5">
                        <button style="visibility: hidden;" class="submission" type="button" transadapter="append" select="false">提交议案建议</button>
                        </td>
                </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $('#yian').click(function () {
                parent.quicksearch("/bill/list.jsp?type=2")
            })
        </script>
    </body>
</html>