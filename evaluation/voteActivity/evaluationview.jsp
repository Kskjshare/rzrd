<%-- 
    Document   : lzdetail.jsp
    Created on : 2021-3-26, 9:30:32
    Author     : Administrator
--%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
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
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.net.URLDecoder"%>

<%    
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    
    RssList vote_activity = new RssList(pageContext, "vote_activity");
    vote_activity.request(); 
    vote_activity.select().where("id="+ req.get("id")).get_page_desc("id");
    int totalDelegate = 0;
     while (vote_activity.for_in_rows()) {
        if ( vote_activity.get("votetype").equals("1") ) {
            //    RssListView users = new RssListView(pageContext, "user_delegation");
//            RssListView users = new RssListView(pageContext, "userrole");
//            users.request();
//            users.pagesize = 30;
//            users.select().where("state=2").get_page_desc("shijian");
            
            
            RssList users = new RssList(pageContext, "user");
            users.request();
            users.pagesize = 30;
            users.select().where("isdelegate=1").get_page_desc("shijian");
            
            totalDelegate = users.totalrows ;   
        }
        else {
            String  voterids = vote_activity.get("voterids");
            String[] ids = voterids.split(",");
            
            totalDelegate = ids.length ;   
        }
     }

    
 

    RssList overall_satisfaction = new RssList(pageContext, "vote_evaluation");
    overall_satisfaction.request();
    String sql = "";
//    sql += "opinion like '%" + URLDecoder.decode(overall_satisfaction.get("opinion"), "utf-8") + "%'" + " and proposal="+ req.get("id");
//    sql += "opinion like '%" + URLDecoder.decode(overall_satisfaction.get("opinion"), "utf-8") + "%'" + " and proposal="+ req.get("id");
    sql = "evaluationId="+ req.get("id");
    overall_satisfaction.select().where(sql).get_page_desc("id");
    int satisfaction = 0 ;
    int basicsatisfaction = 0;
    int dissatisfaction = 0 ;
    float unsatisfactionRate ;
    float satisfactionRate ;
    float basicsatisfactionRate ;
    
    while (overall_satisfaction.for_in_rows()) {
        if ( overall_satisfaction.get("evaluationResult").contains("3") ){
            dissatisfaction ++ ;
        }
        else if ( overall_satisfaction.get("evaluationResult").contains("2") ) {
            basicsatisfaction ++ ;
        }
        else {
            satisfaction ++;
        }
        
    }
    
    float temp = dissatisfaction;
    float totaldelegate = totalDelegate ;
    unsatisfactionRate = dissatisfaction/totaldelegate;
    unsatisfactionRate = unsatisfactionRate*100;
    satisfactionRate = satisfaction/totaldelegate;
    satisfactionRate = satisfactionRate*100;
    basicsatisfactionRate = basicsatisfaction/totaldelegate;
    basicsatisfactionRate = basicsatisfactionRate*100;
    


   
   

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
            .cellbor{width: 700px;}
            .red3{color:#c03e20;font-weight: bold;}
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px; height: 40px; font-size: 25px; font-weight: 600px }
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 17px;text-align: center;}
            .dce{background: #dce6f5;}
            .cellbor>tbody>tr>.indent{text-indent: 10px;text-align: left}
            #divide{height: 10px;}
            .cellbor i{ color: #a79012;font-style: normal}
            .cellbor tr i:nth-child(2){margin-left: 5px;}
        </style>
    </head>
    <body>
    <form method="post" class="popupwrap">     
        <div>
            <table class="cellbor auto margintop" style="margin-top:10px">
              
                <tr class="dce">
                    <td align="left" class="indent">总代表人数</td>  
                    <td><%out.print(totalDelegate);%></td>            
                </tr>
                
                    <tr class="dce">
                    <td align="left" class="indent">满意人数</td>  
                    <td><%out.print(satisfaction);%></td>            
                </tr>
                <tr class="dce">
                    <td align="left" class="indent">满意率</td>  
                    <td><%out.print( satisfactionRate );out.print( "%" );%></td>            
                </tr>
                
                <tr class="dce">
                    <td align="left" class="indent">基本满意人数</td>  
                    <td><%out.print(basicsatisfaction);%></td>            
                </tr>
                
                <tr class="dce">
                    <td align="left" class="indent">基本满意率</td>  
                    <td><%out.print( basicsatisfactionRate );out.print( "%" );%></td>            
                </tr>
                
                 <tr class="dce">
                    <td align="left" class="indent">不满意人数</td>  
                    <td><%out.print( dissatisfaction );%></td>            
                </tr>
                <tr class="dce">
                    <td align="left" class="indent">不满意率</td>  
                    <td><%out.print( unsatisfactionRate );out.print( "%" );%></td>            
                </tr>
                
             
             
             
<!--                <tr id="divide" class="dce"></tr>
                <tr class="dce"><td colspan="5"><button <button style="visibility: hidden;" class="submission" type="button" transadapter="append" select="false">提交议案建议</button></td></tr>-->
            </table>
        </div>
    </form>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $('#yian').click(function () {
                parent.quicksearch("/bill/list.jsp?type=2")
            })
        </script>
    </body>
</html>