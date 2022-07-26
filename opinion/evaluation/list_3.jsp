<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    
 //ding
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssListView entity = new RssListView(pageContext, "sort");
    entity.request();
    entity.select().where("id=?", req.get("id") ).get_first_rows();
    int numpeople = Integer.parseInt ( entity.get("numpeople") ) ;
    
    
    
    RssList opinion_list = new RssList(pageContext, "opinion");
    opinion_list.request();
    //opinion_list.select().where("id=?", opinion_list.get("proposal")).get_page_desc("id");
    opinion_list.select().where("proposal="+ req.get("id")).get_page_desc("id");
    int isEvaluationDone =  0;
    
    int interview_0 = 0 ; 
    int interview_1 = 0;
    int interview_2 = 0;
    
    int attitude_0 = 0 ; 
    int attitude_1 = 0 ;
    int attitude_2 = 0 ;
    
    int reply_0 = 0 ; 
    int reply_1 = 0 ;
    int reply_2 = 0 ;
    
    
    int result_0 = 0 ; 
    int result_1 = 0 ;
    int result_2 = 0 ;
    
     int total_0 = 0 ; 
    int total_1 = 0 ;
    int total_2 = 0 ;
   
    int interview = 0;
    int attitude = 0;
    int reply = 0;
    int result = 0;
    int total = 0;
    
    int totalCount = 0;
    while (opinion_list.for_in_rows()) {
        if ( !opinion_list.get("evaluationDone").isEmpty()){
        isEvaluationDone = Integer.parseInt ( opinion_list.get("evaluationDone") ) ;
        }
       
        
        
        totalCount ++;
        interview = Integer.parseInt( opinion_list.get("effect") ); 
        
       
        
        if ( interview == 1  && isEvaluationDone == 1 ){
            interview_0 ++;
            
        } 
        else if( interview == 2 && isEvaluationDone == 1 ){
            interview_1 ++;
            
        }
         else if( interview == 3 && isEvaluationDone == 1 ){
            interview_2 ++;
            
        }
        attitude = Integer.parseInt( opinion_list.get("effect2") ); 
        if ( attitude == 1 && isEvaluationDone == 1 ){
            attitude_0 ++;
        } 
        else if( attitude == 2 && isEvaluationDone == 1 ){
            attitude_1 ++;
        }
         else if( attitude == 3 && isEvaluationDone == 1 ){
            attitude_2 ++;
        }
        reply = Integer.parseInt( opinion_list.get("effect3") ); 
         if ( reply == 1 && isEvaluationDone == 1 ){
            reply_0 ++;
        } 
        else if( reply == 2 && isEvaluationDone == 1 ){
            reply_1 ++;
        }
         else if( reply == 3 && isEvaluationDone == 1 ){
            reply_2 ++;
        }
        result = Integer.parseInt( opinion_list.get("effect4") ); 
         if ( result == 1 && isEvaluationDone == 1 ){
            result_0 ++;
        } 
        else if( result == 2 && isEvaluationDone == 1 ){
            result_1 ++;
        }
         else if( result == 3 && isEvaluationDone == 1 ){
            result_2 ++;
        }
        total = Integer.parseInt( opinion_list.get("effect5") );  
        if ( total == 1 && isEvaluationDone == 1 ){
            total_0 ++;
        } 
        else if( total == 2 && isEvaluationDone == 1 ){
            total_1 ++;
        }
         else if( total == 3 && isEvaluationDone == 1 ){
            total_2 ++;
        }
    }
    // out.print("<script>alert('操作成功！');</script>");
   RssList second_opinion_list = new RssList(pageContext, "second_opinion");
   second_opinion_list.request();
   //second_opinion_list.select().where("id=?",second_opinion_list.get("proposal") + "").get_page_desc("id");
    second_opinion_list.select().where("proposal="+ req.get("id")).get_page_desc("id");
    int isSecondEvaluationDone = 0 ;
    
    while (second_opinion_list.for_in_rows()) {
         if ( !second_opinion_list.get("evaluationDone").isEmpty()){
            isSecondEvaluationDone = Integer.parseInt ( second_opinion_list.get("evaluationDone") ) ;
         }
        totalCount ++;
        interview = Integer.parseInt( second_opinion_list.get("effect") ); 
        attitude = Integer.parseInt( second_opinion_list.get("effect2") ); 
        reply = Integer.parseInt( second_opinion_list.get("effect3") ); 
        result = Integer.parseInt( second_opinion_list.get("effect4") ); 
        total = Integer.parseInt( second_opinion_list.get("effect5") );  
        if ( isSecondEvaluationDone == 1 ){
            //已经评价完成
            if ( interview == 1 ) {
                interview_0 ++;
            }
            else if( interview == 2  ){
                interview_1 ++;
            }
            else if( interview == 3  ){
                interview_2 ++;
            }
            
            if ( attitude == 1 ) {
                attitude_0 ++;
            }
            else if( attitude == 2  ){
                attitude_1 ++;
            }
            else if( attitude == 3  ){
                attitude_2 ++;
            }
            if ( reply == 1 ){
                reply_0 ++;
            } 
            else if( reply == 2  ){
                reply_1 ++;
            }
            else if( reply == 3  ){
                reply_2 ++;
            }
            if ( result == 1 ){
                result_0 ++;
            } 
            else if( result == 2  ){
                result_1 ++;
            }
            else if( result == 3  ){
                result_2 ++;
            }
            if ( total == 1 ){
            total_0 ++;
            } 
            else if( total == 2  ){
            total_1 ++;
            }
            else if( total == 3  ){
            total_2 ++;
           }
        }
       
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
            .noscore{color: #6caddc;cursor: pointer;}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th colspan="3">面商</th>     
                        </tr>
                        <tr>
                          
                            <th style="color:grey" font-size="20px">满意</th>
                            <th style="color:grey" font-size="20px">基本满意</th>
                            <th style="color:grey" font-size="20px">不满意</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                   
                        <tr ondblclick="ck_MdbBlclick();"  style="cursor:pointer;">

                            <td><%
                                float n = Float.parseFloat(String.valueOf(interview_0 ));
                                float m = Float.parseFloat(String.valueOf( numpeople ));// totalCount
                                float percent = (n/m)*100;
                                out.print( Float.toString(percent ));
                                
                                out.print("%");
                            %></td>
                            
                           <td><%
                                float n1 = Float.parseFloat(String.valueOf(interview_1 ));
                                float m1 = Float.parseFloat(String.valueOf( numpeople  ));// totalCount
                                float percent1 = (n1/m1)*100;
                                out.print( Float.toString(percent1 ));
                                out.print("%");
                            %></td>
 
                           <td><%
                                float n2 = Float.parseFloat(String.valueOf(interview_2 ));
                                float m2 = Float.parseFloat(String.valueOf( numpeople ));// totalCount
                                float percent2 = (n2/m2)*100;
                                out.print( Float.toString(percent2 ));
                                out.print("%");
                            %></td>
 
                        </tr>
                       
                    </tbody>
                </table>
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>                        
                            <th colspan="3">态度</th>     
                        </tr>
                        <tr>
                          
                            <th style="color:grey" font-size="20px">满意</th>
                            <th style="color:grey" font-size="20px">基本满意</th>
                            <th style="color:grey" font-size="20px">不满意</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                      
                        <tr ondblclick="ck_MdbBlclick();"  style="cursor:pointer;">
                        <td><%
                                float attitude_fenzi0 = Float.parseFloat(String.valueOf(attitude_0 ));
                                float attitude_fenmu0 = Float.parseFloat(String.valueOf( numpeople ));// totalCount
                                float attitude_percent0 = ( attitude_fenzi0 / attitude_fenmu0 )*100;
                                out.print( Float.toString( attitude_percent0 ));
                                out.print("%");
                            %></td>
                            
                           <td><%
                                float attitude_fenzi1 = Float.parseFloat(String.valueOf(attitude_1 ));
                                float attitude_fenmu1 = Float.parseFloat(String.valueOf( numpeople ));
                                float attitude_percent1 = ( attitude_fenzi1 / attitude_fenmu1)*100;
                                out.print( Float.toString( attitude_percent1 ));
                                out.print("%");
                            %></td>
 
                           <td><%
                                  float attitude_fenzi2 = Float.parseFloat(String.valueOf( attitude_2 ));
                                float attitude_fenmu2 = Float.parseFloat(String.valueOf( numpeople ));
                                float attitude_percent2 = ( attitude_fenzi2 / attitude_fenmu2 )*100;
                                out.print( Float.toString( attitude_percent2 ));
                                out.print("%");
                            %></td>
    
                        </tr>
                      
                    </tbody>
                </table>
                     <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>                      
                            <th colspan="3">答复</th>
                        </tr>
                        <tr>
                          
                            <th style="color:grey" font-size="20px">满意</th>
                            <th style="color:grey" font-size="20px">基本满意</th>
                            <th style="color:grey" font-size="20px">不满意</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                      
                        <tr ondblclick="ck_MdbBlclick();"  style="cursor:pointer;">
                            <td><%
                                float reply_fenzi0 = Float.parseFloat(String.valueOf(reply_0 ));
                                float reply_fenmu0 = Float.parseFloat(String.valueOf( numpeople ));
                                float reply_percent0 = ( reply_fenzi0 / reply_fenmu0 )*100;
                                out.print( Float.toString( reply_percent0 ));
                                out.print("%");
                            %></td>
                            
                           <td><%
                                 float reply_fenzi1 = Float.parseFloat(String.valueOf(reply_1 ));
                                float reply_fenmu1= Float.parseFloat(String.valueOf( numpeople ));
                                float reply_percen1 = ( reply_fenzi1 / reply_fenmu1 )*100;
                                out.print( Float.toString( reply_percen1 ));
                                out.print("%");
                            %></td>
 
                           <td><%
                                float reply_fenzi2 = Float.parseFloat(String.valueOf(reply_2 ));
                                float reply_fenmu2 = Float.parseFloat(String.valueOf( numpeople ));
                                float reply_percen2 = ( reply_fenzi2 / reply_fenmu2 )*100;
                                out.print( Float.toString( reply_percen2 ));
                                out.print("%");
                            %></td>
                            
                        </tr>
                        
                    </tbody>
                </table>
                     <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th colspan="3">结果</th>
                        </tr>
                        <tr>
                          
                            <th style="color:grey" font-size="20px">满意</th>
                            <th style="color:grey" font-size="20px">基本满意</th>
                            <th style="color:grey" font-size="20px">不满意</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <tr ondblclick="ck_MdbBlclick();"  style="cursor:pointer;">
                            <td><%
                                float result_fenzi0 = Float.parseFloat(String.valueOf(result_0 ));
                                float result_fenmu0 = Float.parseFloat(String.valueOf( numpeople ));
                                float result_percent0 = ( result_fenzi0 / result_fenmu0 )*100;
                                out.print( Float.toString( result_percent0 ));
                                out.print("%");
                            %></td>
                            
                             <td><%
                                float result_fenzi1 = Float.parseFloat(String.valueOf(result_1 ));
                                float result_fenmu1 = Float.parseFloat(String.valueOf( numpeople ));
                                float result_percent1 = ( result_fenzi1 / result_fenmu1 )*100;
                                out.print( Float.toString( result_percent1 ));
                                out.print("%");
                            %></td>
                             
                              <td><%
                                float result_fenzi2 = Float.parseFloat(String.valueOf(result_2 ));
                                float result_fenmu2 = Float.parseFloat(String.valueOf( numpeople ));
                                float result_percent2 = ( result_fenzi2 / result_fenmu2 )*100;
                                out.print( Float.toString( result_percent2 ));
                                out.print("%");
                            %></td>
                        </tr>
                       
                    </tbody>
                </table>
                     <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th colspan="3">综合</th>
                        </tr>
                        <tr>
                          
                            <th style="color:grey" font-size="20px">满意</th>
                            <th style="color:grey" font-size="20px">基本满意</th>
                            <th style="color:grey" font-size="20px">不满意</th>
                            
                            
                        </tr>
                    </thead>
                    <tbody>
                      
                        <tr ondblclick="ck_MdbBlclick();"  style="cursor:pointer;">

                             <td><%
                                float total_fenzi0 = Float.parseFloat(String.valueOf(total_0 ));
                                float total_fenmu0 = Float.parseFloat(String.valueOf( numpeople ));
                                float total_percent0 = ( total_fenzi0 / total_fenmu0 )*100;
                                out.print( Float.toString( total_percent0 ));
                                out.print("%");
                            %></td>
                            
                             
                               <td><%
                                float total_fenzi1 = Float.parseFloat(String.valueOf(total_1 ));
                                float total_fenmu1 = Float.parseFloat(String.valueOf( numpeople ));
                                float total_percent1 = ( total_fenzi1 / total_fenmu1)*100;
                                out.print( Float.toString( total_percent1 ));
                                out.print("%");
                            %></td>
                               
                                 <td><%
                                float total_fenzi2 = Float.parseFloat(String.valueOf(total_2 ));
                                float total_fenmu2 = Float.parseFloat(String.valueOf( numpeople ));
                                float total_percent2 = ( total_fenzi2 / total_fenmu2 )*100;
                                out.print( Float.toString( total_percent2 ));
                                out.print("%");
                            %></td>
                        </tr>
                      
                    </tbody>
                </table>
            </div>
            
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js" type="text/javascript"></script>
        <script>
                            $(".noscore").click(function () {
                                var score = $(this).parent().parent().find("[name='id']").val();
                                popuplayer.display("/evaluation/evaluation/score.jsp?id=" + score + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
                            })
                            function ck_MdbBlclick() {

                                $('tbody tr').dblclick(function () {

                                    popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 300});
                                })

                            }
        </script>
    </body>
</html>