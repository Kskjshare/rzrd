<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%
    int isRuzhouFeature = 1 ;
    StaffList.IsLogin(request, response);

    String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
    Properties properties = new Properties();
    InputStream is = new FileInputStream(propertiesFileName);
    properties.load(is);
    is.close();
    String meetingTime = properties.get("meetingtime").toString();
    if (meetingTime.equals("1")) {

    } else {
    }
    
    CookieHelper cookie = new CookieHelper(request, response);
    String powergroupid = cookie.Get("powergroupid");
    
    
    //up added by jackie 
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
            .cellbor{width: 900px;margin-top:2px;}
            .red3{color:#c03e20}
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px;}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 12px;text-align: center;}
            .dce{background: #dce6f5;}
            .cellbor>tbody>tr>.indent{text-indent: 10px;text-align: left}
            #divide{height:6px;}
            .cellbor i{ color: #a79012;font-style: normal;}
            .cellbor tr i:nth-child(2){margin-left: 5px;}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop" style="font-size:16px;font-family: 微软雅黑" >
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
                    //CookieHelper cookie = new CookieHelper(request, response);
                    String rwhere = "";
                    String view = "";
                    if (cookie.Get("powergroupid").equals("16")) {//16:系统管理员
                        rwhere = "draft=2";
                        view = "sort";
                    } 
                    else if ( cookie.Get("powergroupid").equals ( "22" ) ) { //代表团
                        if (meetingTime.equals("1")) {//大会期间
                            rwhere = "draft=2  and userid=" +  UserList.MyID(request); 
                        }
                        else { //闭会
                            rwhere = "draft=2 and userid=" + UserList.MyID(request);
                        }
                      //  rwhere = "draft=2 and userid=" + UserList.MyID(request);
                        view = "scr_suggest";
                        
                        view = "sort";
                        rwhere = "draft=2";
                    } 
                    else if ( cookie.Get("powergroupid").equals("7") ) { //选工委:7
                        // rwhere = "draft=2 and isysw=21 and fsrID=" + UserList.MyID(request);

                        
                       //修改闭会期间选工委账号登录时，查看审查情况统计错误
                        //search records exclude draft by ding
                        //rwhere =    "draft=2  and userid=" + UserList.MyID(request);
                        //view = "scr_suggest";
                        rwhere =    "draft=2";
                        //added by ding 汝州项目选工委只能审批市级代表，所以加一个level条件查找记录
                        rwhere += " and level=1";
                        view = "sort";
                        
                        
                        
                    } 
                    else if ( cookie.Get("powergroupid").equals("8") ) { //议审委:8
                    }
                   else if ( cookie.Get("powergroupid").equals("25") ) { //乡镇人大主席团:25
                        //added by ding 汝州项目选工委只能审批市级代表，所以加一个level条件查找记录
                        //rwhere =    "draft=2  and scid=" + UserList.MyID(request);
                        rwhere =    "draft=2";
                        rwhere += " and level= 0";
                        view = "sort";
                    }
                    else if ( cookie.Get("powergroupid").equals("38") ) { //选工委:7
                                // rwhere = "draft=2 and isysw=21 and fsrID=" + UserList.MyID(request);

                       //修改闭会期间选工委账号登录时，查看审查情况统计错误
                        //search records exclude draft by ding
                        //rwhere =    "draft=2  and userid=" + UserList.MyID(request);
                        //view = "scr_suggest";
                        //added by ding 汝州项目选工委只能审批市级代表，所以加一个level条件查找记录
                        rwhere =    "draft=2";
                        rwhere += " and level=1";
                        view = "sort";
                    } 
             
                    
                    

//                    else {
//                        //原代码
//                        if (meetingTime.equals("1")) {//大会期间，该页面代表团用
//                            rwhere = "draft=2 and userid=" + UserList.MyID(request);
//                        } else if (meetingTime.equals("0")) {//闭会期间，该页面选工委与代表联络科用
//                            rwhere = "draft=2 and isysw=21 and fsrID=" + UserList.MyID(request);//and userid=" + UserList.MyID(request);//大会期间
//                        }
//                        view = "scr_suggest";
//                    }

                    RssListView list = new RssListView(pageContext, view);
                    list.pagesize = 10000000;
                    
                    list.request();
                    
 
                    if ( meetingTime.equals("1")){
                        rwhere += " and ismeet=1";
                     }
                    else {
                        rwhere += " and ismeet=0";
                     }


                    list.select().where(rwhere).get_page_desc("id");
                 
                    
                       //added by ding
                      //if ( list.get("ismeet").equals("1")){
                      if ( meetingTime.equals("1")){
        
                      }
                      else{
                           //打个补丁闭会期间代表和代表团看不到记录
                           if( (cookie.Get("powergroupid")).equals("5") || (cookie.Get("powergroupid")).equals("22") ) 
                           {               
                               list.select().where("draft=1").get_page_desc("realid");
                            }
                      }
                      //ding end

                    int b = 0;
                    int c = 0;
                    int d = 0;
                    int e = 0;
                    
                    //建议
                    int suggest_waiting = 0;
                    int suggest_agree_counter = 0 ;
                    int suggest_disagree_counter = 0 ;
                    String suggest_agree_url = "list.jsp?lwstate=1&examination=2&draft=2&isdbtshenhe=1";
                    String suggest_disagree_url = "list.jsp?lwstate=1&examination=3&draft=2";
                  
                     //议案
                    int yian_waiting = 0;
                    int yian_agree_counter = 0 ;
                    int yian_disagree_counter = 0 ;
                    String yian_agree_url = "list.jsp?lwstate=2&examination=2&draft=2&isdbtshenhe=1";
                    String yian_disagree_url = "list.jsp?lwstate=2&examination=3&draft=2";
                  
                      //批评
//                    int yian_waiting = 0;
//                    int yian_agree_counter = 0 ;
//                    int yian_disagree_counter = 0 ;
                    String criticism_agree_url = "list_criticism.jsp?lwstate=3&examination=2&draft=2&isdbtshenhe=1";
                    String criticism_disagree_url = "list_criticism.jsp?lwstate=3&examination=3&draft=2";
                        //意见
//                    int yian_waiting = 0;
//                    int yian_agree_counter = 0 ;
//                    int yian_disagree_counter = 0 ;
                    String opinion_agree_url = "list.jsp?lwstate=4&examination=2&draft=2&isdbtshenhe=1";
                    String opinion_disagree_url = "list.jsp?lwstate=4&examination=3&draft=2";
                    
                          //质询
//                    int yian_waiting = 0;
//                    int yian_agree_counter = 0 ;
//                    int yian_disagree_counter = 0 ;
                    String inquery_agree_url = "list.jsp?lwstate=5&examination=2&draft=2&isdbtshenhe=1";
                    String inquery_disagree_url = "list.jsp?lwstate=5&examination=3&draft=2";
                    
                    int bb = 0;
                    int cc = 0;
                    int unreviewed = 0; //未审查议案
                    int ee = 0;
                    int totalSuggestions = 0;
                    int recommendations = 0 ;
                   // int yian_submit = 0 ;//已提交议案
                   // int yian_unsubmit = 0 ; //未提交议案
                    
                    // examination :1 表示未审核   2 表示已审核
                    int totalCriticisms = 0;//所有批评
                    int totalOpinions = 0 ;//所有意见
                    int totalInquerys = 0;//所有质询
                    
                   
                    int unreviewed_criticisms = 0; //未审查的批评
                    int criticism_submit = 0 ;//已提交批评
                    int criticism_unsubmit = 0 ; //未提交批评
                    
                    int unreviewed_opinions= 0; //未审查的意见
                    int opinion_submit = 0 ;//已提交意见
                    int opinion_unsubmit = 0 ; //未提交意见
                    
                    
                    int unreviewed_inquerys = 0; //未审查的质询
                    int inquery_submit = 0 ;//已提交质询
                    int inquery_unsubmit = 0 ; //未提交质询
                    
                    
                    //  System.out.println("list.for_in_rows()：："+list.for_in_rows());
                    while (list.for_in_rows()) {
                        if (list.get("lwstate").equals("1")) {//建议   
                            totalSuggestions ++ ;
//                            if (cookie.Get("powergroupid").equals("22")) {//代表团初审流程
//                                if (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2")) {
//                                    d++;
//                                }
//                                if (meetingTime.equals("0")) {//汝州需求，闭会期间没有代表团流程，只有选工委或者乡镇人大主席团 ){
//                                    totalSuggestions --;
//                                }
//                            } 
//                            else if (cookie.Get("powergroupid").equals("7")) {//议案委初审流程  ding: 选工委
//                                if ((list.get("isysw").equals("21"))
//                                        && (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2"))) {
//                                   
//                                    d++;
//                                }
//                            }

                            if (list.get("examination").equals("1")) {
                               
                                suggest_waiting ++;
                            }
                            if (list.get("examination").equals("2")) {
                              
                                suggest_agree_counter ++;
                            }
                            
                              if (list.get("examination").equals("3")) {
                                suggest_disagree_counter ++;

                            }
                            
                        }
                        if ( list.get("lwstate").equals("2") ) { //议案
		
//                            recommendations ++;
//                            if (cookie.Get("powergroupid").equals("22")) {//代表团初审流程
//                                if (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2")) {
//		     
//                                 //added by ding 
//                                unreviewed ++;
//                                if (meetingTime.equals("0")) {//汝州需求，闭会期间没有代表团流程，只有选工委或者乡镇人大主席团 ){
//                                    unreviewed -- ;
//                                    recommendations --;
//                                }
//                            }
//                        } else if (cookie.Get("powergroupid").equals("7")) {//选工委
//                                if ((list.get("isysw").equals("21"))
//                                        && (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2"))) {
//                                
//                                    unreviewed ++;
//                                }
//                            }
//                            if (list.get("iscs").equals("1")) {
//                               bb++;
//                               yian_submit++;
//                            }
//                            if (list.get("examination").equals("3")) {
//                                cc++;
//                                yian_unsubmit++;
//                            }
//                            if (list.get("examination").equals("2")) {
//                                ee++;
//                            }
                            recommendations++;
                            if (list.get("examination").equals("1")) {
                               
                                yian_waiting ++;
                            }
                            if (list.get("examination").equals("2")) {
                              
                                yian_agree_counter ++;
                            }
                            
                              if (list.get("examination").equals("3")) {
                                yian_disagree_counter ++;

                            }
                            
                            
                        }
                         if ( list.get("lwstate").equals("3") ) { //批评
		
                            totalCriticisms ++;
//                            if (cookie.Get("powergroupid").equals("22")) {//代表团初审流程
//                                if (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2")) {
//		     
//                                 //added by ding 
//                                unreviewed_criticisms ++;
//                                if (meetingTime.equals("0")) {//汝州需求，闭会期间没有代表团流程，只有选工委或者乡镇人大主席团 ){
//                                    unreviewed_criticisms -- ;
//                                    totalCriticisms --;
//                                }
//                            }
//                        } else if (cookie.Get("powergroupid").equals("7")) {//选工委
//                                if ((list.get("isysw").equals("21"))
//                                        && (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2"))) {
//                                
//                                    unreviewed_criticisms ++;
//                                }
//                            }
//                            if (list.get("iscs").equals("1")) {
//                                bb++;
//                                criticism_submit++;
//                            }
//                            if (list.get("examination").equals("3")) {
//                                cc++;
//                                criticism_unsubmit++;
//                            }
//                            if (list.get("examination").equals("2")) {
//                                ee++;
//                            }
                            
                            
                            
                             if (list.get("examination").equals("1")) {
                               
                                unreviewed_criticisms ++;
                            }
                            if (list.get("examination").equals("2")) {
                              
                                criticism_submit ++;
                            }
                            
                            if (list.get("examination").equals("3")) {
                                criticism_unsubmit ++;

                            }
                            
                            
                        }
                            if ( list.get("lwstate").equals("4") ) { //意见
		
                 
                            totalOpinions ++;
//                            if (cookie.Get("powergroupid").equals("22")) {//代表团初审流程
//                                if (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2")) {
//		     
//                                 //added by ding 
//                                unreviewed_opinions ++;
//                                if (meetingTime.equals("0")) {//汝州需求，闭会期间没有代表团流程，只有选工委或者乡镇人大主席团 ){
//                                    unreviewed_opinions -- ;
//                                    totalOpinions --;
//                                }
//                            }
//                        } else if (cookie.Get("powergroupid").equals("7")) {//选工委
//                                if ((list.get("isysw").equals("21"))
//                                        && (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2"))) {
//                                
//                                    unreviewed_opinions ++;
//                                }
//                            }
//                            if (list.get("iscs").equals("1")) {
//                                bb++;
//                                opinion_submit++;
//                            }
//                            if (list.get("examination").equals("3")) {
//                                cc++;
//                                opinion_unsubmit++;
//                            }
//                            if (list.get("examination").equals("2")) {
//                                ee++;
//                            }
                            
                            
                            
                               if (list.get("examination").equals("1")) {
                               
                                unreviewed_opinions ++;
                            }
                            if (list.get("examination").equals("2")) {
                              
                                opinion_submit ++;
                            }
                            
                              if (list.get("examination").equals("3")) {
                                opinion_unsubmit ++;

                            }
                            
                            
                            
                        }
                            
                        if ( list.get("lwstate").equals("5") ) { //质问		              
                            
                            totalInquerys ++;
//                            if (cookie.Get("powergroupid").equals("22")) {//代表团初审流程
//                                if (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2")) {
//		     
//                                 //added by ding 
//                                unreviewed_inquerys ++;
//                                if (meetingTime.equals("0")) {//汝州需求，闭会期间没有代表团流程，只有选工委或者乡镇人大主席团 ){
//                                    unreviewed_inquerys -- ;
//                                    totalInquerys --;
//                                }
//                            }
//                        } else if (cookie.Get("powergroupid").equals("7")) {//选工委
//                                if ((list.get("isysw").equals("21"))
//                                        && (list.get("examination").equals("1") && list.get("isdbtshenhe").equals("2"))) {
//                                
//                                    unreviewed_inquerys ++;
//                                }
//                            }
//                            if (list.get("iscs").equals("1")) {
//                                bb++;
//                                inquery_submit++;
//                            }
//                            if (list.get("examination").equals("3")) {
//                                cc++;
//                                inquery_unsubmit++;
//                            }
//                            if (list.get("examination").equals("2")) {
//                                ee++;
//                            }
  
                               if (list.get("examination").equals("1")) {
                               
                                unreviewed_inquerys ++;
                            }
                            if (list.get("examination").equals("2")) {
                              
                                inquery_submit ++;
                            }
                            
                              if (list.get("examination").equals("3")) {
                                inquery_unsubmit ++;

                            }
                            

                        }
                    }

                %>
                <tr>
                    <td rowspan="4">建议</td>
                    <td>未审查</td>
                    <td align="left" class="indent">等待审查处理的建议</td>
                    <td class="red3"><% out.print( suggest_waiting );%></td>

   	     <%    
	         if ( isRuzhouFeature  == 1 ) { //汝州项目
 	       %>	
		<% 
                    if (suggest_waiting  == 0 ) {
		%>
		     <td>查看</td>
		<%
	     	} else {	  
	   	%>
		<td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=1&isdbtshenhe=2">查看</a></td><!--isdbtshenhe:1是2否//-->
		<%
	     	} 
	   	%>	
		 
	      <%    	
	         }
	         else {
	       %>	



                    <%
                        if (meetingTime.equals("1")) {//代表团初审流程
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=1&isdbtshenhe=2">查看</a></td><!--isdbtshenhe:1是2否//-->
                    <%
                    } else {//议案委初审流程
                    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=1&isdbtshenhe=2">查看</a></td><!--isdbtshenhe:1是2否//-->
                    <%
                        }
                    %>


 	<%    	
	 }
               %>	

                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent">经审查处理,确认<i>提交</i>的建议:<i><% out.print( suggest_agree_counter );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( suggest_agree_counter + suggest_disagree_counter );%></td>

	   <%
	        if ( ( suggest_agree_counter + suggest_disagree_counter  ) == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else{
	    %>
                    <td style="font-weight:bold;"><a href=<%out.print(suggest_agree_url);%>>查看</a></td>
                    
             <%
	       }
	    %>       
                    
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent">经审查处理,确认<i>不提交</i>的建议:<i><% out.print( suggest_disagree_counter );%></i></td>

	    <%
	        if ( suggest_disagree_counter == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }
                else if (list.get("isdbtshenhe").equals("1")) {
 %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=3&isdbtshenhe=1&draft=2">查看</a></td>
                    <%
                }else
               
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=3&isdbtshenhe=2&draft=2">查看</a></td>
                </tr>
                <tr align="center" style="display: none;">
                <td align="left" class="w300 indent">经审查处理,确认<i>撤案</i>的建议:<i><% out.print(c);%></i></td>
	<%
	        if (  c == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&examination=3&draft=2">查看</a></td>
                </tr>
                <tr align="center">
                    <td>总计</td>

                    <td align="left" class="w300 indent">所有建议
                        <!--(包含已交办)&nbsp;<i><% out.print(e);%></i>&nbsp;件-->
   
                    </td>
                    <!--td class="red3"><% out.print(d + b + c);%></td-->
	    <td class="red3"><% out.print( suggest_agree_counter + suggest_disagree_counter + suggest_waiting);%></td>


	<%
	        if (totalSuggestions  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=1&draft=2&isxzsc=0">查看</a></td>
                </tr>
                <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">议案</td>
    
                    <td>未审查</td>
                    <td align="left" class="indent">等待审查处理的议案</td>
                    <td class="red3"><% out.print( yian_waiting );%></td>
	    <!---汝州闭会期间代表团流程没有，只有选工委或者乡镇人大主席团------->
	     <%    
	         if ( isRuzhouFeature  == 1 ) { //汝州项目
 	       %>	
		<% 
	                 if (yian_waiting  == 0 ) {
		%>
		     <td>查看</td>
		<%
	     	} else {	  
	   	%>
		<td style="font-weight:bold;"><a href="list.jsp?lwstate=2&isdbtshenhe=2&examination=1">查看</a></td>
		<%
	     	} 
	   	%>	
		 
	      <%    	
	         }
	         else {
	       %>	

                             <%
                                if (meetingTime.equals("1")) {//代表团初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&isdbtshenhe=2&examination=1">查看</a></td>
                            <%
                             } else {//议案委初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&isdbtshenhe=2&examination=1">查看</a></td>
                           <%
                            }
                           %>

	<%
	     }	  
	   %>

                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent">经审查处理,确认<i>提交</i>的议案:<i><% out.print( yian_agree_counter );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( yian_agree_counter + yian_disagree_counter );%></td>

 	   <%
	        if ( ( yian_agree_counter + yian_disagree_counter ) == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else{
	    %>
                 
                    <td style="font-weight:bold;"><a href=<%out.print(yian_agree_url);%>>查看</a></td>
               <%
	       }
	    %>
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent">经审查处理,确认<i>不提交</i>的议案:<i><% out.print( yian_disagree_counter );%></i></td>

   	<%
	        if ( yian_disagree_counter  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }
               else if (list.get("isdbtshenhe").equals("1")) {
            %>
             <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
            <%
               }
               else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&isdbtshenhe=2&examination=3&draft=2">查看</a></td>
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经审查处理,确认<i>撤案</i>的议案:<i><% out.print(cc);%></i></td>

   	<%
	        if ( yian_disagree_counter  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else{
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                <%
	     	} 
	   	%>	            
                    
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有议案</td>
	    <!--
                    <td class="red3"><% out.print( yian_waiting + yian_agree_counter + yian_disagree_counter );%></td>
	    -->

	   <td class="red3"><% out.print( recommendations );%></td>


   	   <%
	        if ( recommendations == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=2&draft=2&isxzsc=0">查看</a></td>
                </tr>
                 <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">批评</td>
    
                    <td>未审查</td>
                    <td align="left" class="indent">等待审查处理的批评</td>
                    <td class="red3"><% out.print( unreviewed_criticisms );%></td>
	    <!---汝州闭会期间代表团流程没有，只有选工委或者乡镇人大主席团------->
	     <%    
	         if ( isRuzhouFeature  == 1 ) { //汝州项目
 	       %>	
		<% 
	                 if ( unreviewed_criticisms  == 0 ) {
		%>
		     <td>查看</td>
		<%
	     	} else {	  
	   	%>
		<td style="font-weight:bold;"><a href="list_criticism.jsp?lwstate=3&isdbtshenhe=2&examination=1">查看</a></td>
		<%
	     	} 
	   	%>	
		 
	      <%    	
	         }
	         else {
	       %>	

                             <%
                                if (meetingTime.equals("1")) {//代表团初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=3&isdbtshenhe=2&examination=1">查看</a></td>
                            <%
                             } else {//议案委初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=3&isdbtshenhe=2&examination=1">查看</a></td>
                           <%
                            }
                           %>

	<%
	     }	  
	   %>

                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent">经审查处理,确认<i>提交</i>的批评:<i><% out.print( criticism_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( criticism_submit + criticism_unsubmit );%></td>

 	   <%
	        if ( ( criticism_submit + criticism_unsubmit ) == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else{
	    %>
                  
                     <td style="font-weight:bold;"><a href=<%out.print(criticism_agree_url);%>>查看</a></td>
          <%
	     	} 
	   	%>	           
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent">经审查处理,确认<i>不提交</i>的批评:<i><% out.print( criticism_unsubmit );%></i></td>

   	<%
	        if ( criticism_unsubmit == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }
               else if (list.get("isdbtshenhe").equals("1")) {
            %>
             <td style="font-weight:bold;"><a href="list.jsp?lwstate=3&isdbtshenhe=1&examination=3&draft=2&all=0">查看</a></td>
            <%
               }
               else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=3&isdbtshenhe=2&examination=3&draft=2&all=0">查看</a></td>
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经审查处理,确认<i>撤案</i>的批评:<i><% out.print( criticism_unsubmit );%></i></td>

   	<%
	        if ( criticism_unsubmit  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
             <td style="font-weight:bold;"></td>
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有批评</td>
	    <!--
                    <td class="red3"><% out.print( unreviewed + bb + cc);%></td>
	    -->

	   <td class="red3"><% out.print( totalCriticisms );%></td>


   	   <%
	        if ( totalCriticisms == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list_criticism.jsp?lwstate=3&draft=2&isxzsc=0&all=1">查看</a></td>
                </tr>
                 <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">意见</td>
    
                    <td>未审查</td>
                    <td align="left" class="indent">等待审查处理的意见</td>
                    <td class="red3"><% out.print( unreviewed_opinions );%></td>
	    <!---汝州闭会期间代表团流程没有，只有选工委或者乡镇人大主席团------->
	     <%    
	         if ( isRuzhouFeature  == 1 ) { //汝州项目
 	       %>	
		<% 
	                 if ( unreviewed_opinions  == 0 ) {
		%>
		     <td>查看</td>
		<%
	     	} else {	  
	   	%>
		<td style="font-weight:bold;"><a href="list.jsp?lwstate=4&isdbtshenhe=2&examination=1">查看</a></td>
		<%
	     	} 
	   	%>	
		 
	      <%    	
	         }
	         else {
	       %>	

                             <%
                                if (meetingTime.equals("1")) {//代表团初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&isdbtshenhe=2&examination=1">查看</a></td>
                            <%
                             } else {//议案委初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&isdbtshenhe=2&examination=1">查看</a></td>
                           <%
                            }
                           %>

	<%
	     }	  
	   %>

                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent">经审查处理,确认<i>提交</i>的意见:<i><% out.print( opinion_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( opinion_submit + opinion_unsubmit );%></td>

 	   <%
	        if ( ( opinion_submit + opinion_unsubmit ) == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else{
	    %>
              <td style="font-weight:bold;"><a href=<%out.print(opinion_agree_url);%>>查看</a></td>  
              <%
                 }
	    %>
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent">经审查处理,确认<i>不提交</i>的意见:<i><% out.print( opinion_unsubmit );%></i></td>

   	<%
	        if ( opinion_unsubmit  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }
               else if (list.get("isdbtshenhe").equals("1")) {
            %>
             <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
            <%
               }
               else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&isdbtshenhe=2&examination=3&draft=2">查看</a></td>
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经审查处理,确认<i>撤案</i>的意见:<i><% out.print( opinion_unsubmit );%></i></td>

   	<%
	        if ( opinion_unsubmit  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有意见</td>
	    <!--
                    <td class="red3"><% out.print( unreviewed + opinion_submit + opinion_unsubmit );%></td>
	    -->

	   <td class="red3"><% out.print( totalOpinions );%></td>


   	   <%
	        if ( totalOpinions == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=4&draft=2&isxzsc=0">查看</a></td>
                </tr>
                 <tr id="divide" class="dce"></tr>
                 <tr>
                    <td rowspan="4">质询</td>
    
                    <td>未审查</td>
                    <td align="left" class="indent">等待审查处理的质询</td>
                    <td class="red3"><% out.print( unreviewed_inquerys );%></td>
	    <!---汝州闭会期间代表团流程没有，只有选工委或者乡镇人大主席团------->
	     <%    
	         if ( isRuzhouFeature  == 1 ) { //汝州项目
 	       %>	
		<% 
	        if ( unreviewed_inquerys  == 0 ) {
		%>
		     <td>查看</td>
		<%
	     	}
                else {	  
	   	%>
		<td style="font-weight:bold;"><a href="list.jsp?lwstate=5&isdbtshenhe=2&examination=1">查看</a></td>
		<%
	     	} 
	   	%>	
		 
	      <%    	
	         }
	         else {
	       %>	

                             <%
                                if (meetingTime.equals("1")) {//代表团初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&isdbtshenhe=2&examination=1">查看</a></td>
                            <%
                             } else {//议案委初审流程
                            %>
                                <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&isdbtshenhe=2&examination=1">查看</a></td>
                           <%
                            }
                           %>

	<%
	     }	  
	   %>

                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent">经审查处理,确认<i>提交</i>的质询:<i><% out.print( inquery_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( inquery_submit + inquery_unsubmit );%></td>

 	   <%
	        if ( ( inquery_submit + inquery_unsubmit ) == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else{
	    %>
             <td style="font-weight:bold;"><a href=<%out.print(inquery_agree_url);%>>查看</a></td>
            <%
	       }
	    %>
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent">经审查处理,确认<i>不提交</i>的质询:<i><% out.print( inquery_unsubmit );%></i></td>

   	<%
	        if ( inquery_unsubmit  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }
               else if (list.get("isdbtshenhe").equals("1")) {
            %>
             <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
            <%
               }
               else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&isdbtshenhe=2&examination=3&draft=2">查看</a></td>
                </tr>
                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent">经审查处理,确认<i>撤案</i>的质询:<i><% out.print( inquery_unsubmit);%></i></td>

   	<%
	        if ( inquery_unsubmit  == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                </tr>
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有质询</td>
	    <!--
                    <td class="red3"><% out.print( unreviewed + bb + cc);%></td>
	    -->

	   <td class="red3"><% out.print( totalInquerys );%></td>


   	   <%
	        if ( totalInquerys == 0 ) {
 	   %>
 	    <td>查看</td>
	    <%
	       }else
	    %>
                    <td style="font-weight:bold;"><a href="list.jsp?lwstate=5&draft=2&isxzsc=0">查看</a></td>
                </tr>
                <tr class="dce"><td colspan="5"><button <button style="visibility: hidden;" class="submission" type="button" transadapter="append" select="false">提交议案建议</button></td></tr>
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