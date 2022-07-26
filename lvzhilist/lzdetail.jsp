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

<%    
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
     
    RssListView userEntity = new RssListView(pageContext, "user_delegation");
    userEntity.request();
    //userEntity.select().where("myid=?", userEntity.get("id")).get_first_rows();
    userEntity.select().where("myid=?", req.get("id")).get_first_rows();
   
    
//    String ahref = "lzdetailList.jsp?id=" + req.get("id");
    String ahref = "lzbutview.jsp?id=" + req.get("id");
    String ahref_suggest = "suggestlist.jsp?id=" + req.get("id");
    int suggests = 0 ;
    int second_suggests = 0 ;
    
    int proposals = 0;
    int second_proposals = 0 ;
    int num = 0 ;
    

    String[] ta = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
    String[] tahref = {"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"};
    RssListView suggestList = new RssListView(pageContext, "sort");
    suggestList.query("SELECT lwstate,COUNT(*) AS num FROM sort_list_view WHERE myid=" + req.get("id") + " and draft=2 GROUP BY lwstate");
   

    int SuggestCnt = 0 ;
    while (suggestList.for_in_rows()) {
  
        if (suggestList.get("lwstate").equals("1")) {
            num += Integer.valueOf( suggestList.get("num") );
            suggests += Integer.valueOf( suggestList.get("num") ); //建议总数
        }
        if (suggestList.get("lwstate").equals("2")) {
            num += Integer.valueOf(suggestList.get("num"));
            proposals += Integer.valueOf(suggestList.get("num"));//议案总数
        }
        
        if (suggestList.get("lwstate").equals("3")) {
 
            num += Integer.valueOf(suggestList.get("num"));
         
        }
        
        if (suggestList.get("lwstate").equals("4")) {
           num += Integer.valueOf(suggestList.get("num"));
      
        }
        if (suggestList.get("lwstate").equals("5")) {
          // num ++ ;
          num += Integer.valueOf( suggestList.get("num") );
        }
        
        SuggestCnt ++ ;
        
        SuggestCnt =  Integer.valueOf( suggestList.get("num") ) ;
        num =  Integer.valueOf( suggestList.get("num") ) ;
    }
    
   

    //如果处理联名表     
    int fuyi_score = 0 ;
    RssListView secondlist = new RssListView(pageContext, "second_suggest");//second_user second_suggest
    secondlist.select().where("userid=" + userEntity.get("myid")).query();
   
    while (secondlist.for_in_rows()) {

        if (secondlist.get("lwstate").equals("1")) {
            second_suggests ++;
            num ++;
        }
        else if (secondlist.get("lwstate").equals("2")) {
            second_proposals ++ ;
            num ++ ;
        }
        else if (suggestList.get("lwstate").equals("3")) {
            num ++;      
        }
        
        else if (suggestList.get("lwstate").equals("4")) {
           num ++;
        }
        else if (suggestList.get("lwstate").equals("5")) {
           num ++;  
        }
         SuggestCnt ++ ;

        if ( fuyi_score < 4 ){
            fuyi_score ++ ;
        }
    }
    
    String ids = "";
    String usrid = "";
    RssListView list4 = new RssListView(pageContext, "activities_userlist");
    list4.query("SELECT classify,COUNT(*) AS num FROM activities_userlist_list_view WHERE userid=" + userEntity.get("myid") + " and attendancetype=2 GROUP BY classify");
     while ( list4.for_in_rows() ) {
         
        ids = list4.get("place");
        usrid = list4.get("department");
        int z = Integer.parseInt( list4.get("classify") );
        //这个地方以后还需要处理，因为如果用户单独上传视察调研和执法检查的话。20200628
        if ( z > 6 ) {
            z += 2 ;
        }
        tahref[z] = "lzbutview"+ list4.get("classify") + ".jsp?id=" + req.get("id");
        ta[z] = list4.get("num");
        //num += Integer.valueOf(list4.get("num"));
    }
    
     
     
     
//     
//    RssList activities_upload = new RssList( pageContext, "activities_upload" );
//    activities_upload.select().where("myid="+ req.get("id") + " and auditstate=1").get_page_desc("id");
//    int[] indextransfer = { 1 , 1 ,2 , 3, 4 , 5, 6 , 9, 10 , 11 , 12 ,13, 14, 15 };
//    int classify = 1 ;
//    while( activities_upload.for_in_rows() ){            
//        classify = Integer.parseInt( activities_upload.get("classify") );   
//        int mcounter = Integer.parseInt( ta[ indextransfer[classify] ]) + 1;
//        ta[ indextransfer[classify] ] = "" + mcounter  ;
//    }
//     
   

//    RssListView list2 = new RssListView(pageContext, "activities_userlist");
//    list2.query("SELECT classify,COUNT(*) AS num FROM activities_userlist_list_view WHERE userid=" + userEntity.get("myid") + " and attendancetype=2 and classify=2 GROUP BY classify");
//     while (list2.for_in_rows()) {
//         dddddd ++;
//         ids = list2.get("place");
//         usrid = list2.get("department");
//
//         
//        int z = Integer.parseInt( list2.get("classify"));
//        tahref[ 2 ] = "lzbutview"+ list2.get("classify") + ".jsp?id=" + req.get("id");
//        ta[ 2 ] = list2.get("num");
//        num += Integer.valueOf( list2.get("num"));
//        
//        tahref[ 2 ] = "lzbutview2" + ".jsp?id=" + req.get("id");
//        
//        RssListView tmplist = new RssListView(pageContext, "activities");
//        aaaa += list2.get("activitiesid");
//        tmplist.query("SELECT classify,COUNT(*) AS num FROM activities_list_view WHERE userid=" + userEntity.get("myid") + " and id=" + list2.get("activitiesid") + " and classify=2 GROUP BY classify");
//        num += tmplist.totalrows ;
//        ta[ 2 ] = tmplist.get("num");
//    }
    
  //计算参加视察、调研及执法检查的数量
  int activitiesCounter =   Integer.parseInt( ta[ 1 ] ) + Integer.parseInt( ta[ 3 ] ) + Integer.parseInt( ta[ 4 ] ) ;
  String activityHref = "lzbutview1.jsp?id=" +  req.get("id");
  

//为了解决手机统计页面和电脑统计一致的问题。需要读取rank_sort的数据（因为上面的代码统计有点问题）。后续有问题再检查。
  RssList rankSort = new RssList(pageContext, "rank_sort");
  rankSort.request();
  rankSort.select().where("myid=?",req.get("id") ).get_first_rows();
  num = Integer.parseInt(rankSort.get("suggest"));
  ta[ 1 ] = rankSort.get("meeting");
  ta[ 2 ] = rankSort.get("othermeeting");
  ta[ 3 ] = rankSort.get("study");
  ta[ 5 ] = rankSort.get("specialsurvey");
  ta[ 6 ] = rankSort.get("totalMixActivities");
  ta[ 7 ] = rankSort.get("reslovedispute");

  ta[ 9 ] = rankSort.get("recievevoters");
  ta[ 10 ] = rankSort.get("reslovedispute");
  ta[ 11 ] = rankSort.get("helpweak");
  ta[ 12 ] = rankSort.get("goodthing");
  ta[ 13 ] = rankSort.get("charity");
  tahref[13] = "lzbutview13"+ ".jsp?id=" + req.get("id");
  ta[ 14 ] = rankSort.get("reportvoter");
  tahref[14] = "lzbutview14"+  ".jsp?id=" + req.get("id");

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
            .bold{font-weight: bold;}
        </style>
    </head>
    <body>
    <form method="post" class="popupwrap">     
        <div>
            <table class="cellbor auto margintop" style="margin-top:10px">
                <tr>
                    <td colspan="5" class="tabheader"><%out.print(userEntity.get("realname"));%>履职活动详情</td>
                </tr>
                <tr class="dce">
                    <td>履职活动<%out.print(req.get("meeting"));%></td>
                    <td>次数</td>
                    <td>操作</td>
                </tr>
                
                  <tr>
                    <td align="left" class="indent">出席人代会</td>
                     <% 
                    if ( ta[ 1 ].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"><%out.print( ta[ 1 ] ); %> </td>
                     <td class="bold"><a href=<%out.print( tahref[ 1 ]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                <tr>
                    <td align="left" class="indent">参加其他会议</td>
                     <% 
                    if ( ta[ 2 ].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3">  <% out.print( ta[ 2 ] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[ 2 ]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                
                 <tr>
                    <td align="left" class="indent">参加学习培训</td>
                     <% 
                    if ( ta[3].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[ 3 ] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[ 3 ]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                
                  <tr>
                    <td align="left" class="indent">提出议案、建议、批评和意见</td>
                     <% 
                    //if ( suggests + second_suggests + proposals + second_proposals == 0  ){  
                    if ( SuggestCnt == 0  ){  

                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( SuggestCnt ); %></td>
                    <td class="bold"><a href=<%out.print( ahref_suggest );%>>查看</a></td>
                    <%  
                    }
                    %>   
                    
                </tr>
                
                 <tr>
                    <td align="left" class="indent">开展专题调研</td>
                    <% 
                    if ( ta[5].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[5] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[5]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                
                <tr>
                    <td align="left" class="indent">参加视察、调研及执法检查</td>
                    <% 
                    //if ( activitiesCounter == 0   ){   
                    if ( ta[ 6 ].equals("0")   ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <!--<td class="red3"> <% out.print(activitiesCounter ); %></td>-->
                    <!--<td class="bold"><a href=<%out.print( activityHref );%>>查看</a></td>-->
                    <td class="red3"> <% out.print( ta[ 6 ] ); %></td>
                    <td class="bold"><a href=<%out.print( tahref[ 6 ]  );%>>查看</a></td>
                    <%  
                    }
                    %>    
                </tr>
 
              
                <tr>
                    <td align="left" class="indent">接待选民</td>
                     <% 
                    if ( ta[9].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[9] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[9]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                <tr>
                    <td align="left" class="indent">化解矛盾纠纷</td>
                     <% 
                    if ( ta[10].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[10] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[10]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                <tr>
                    <td align="left" class="indent">扶弱济困</td>
                     <% 
                    if ( ta[11].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[11] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[11]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                <tr>
                    <td align="left" class="indent">办好事、实事</td>
                     <% 
                    if ( ta[12].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[12] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[12]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                <tr>
                    <td align="left" class="indent">参加公益慈善事业</td>
                     <% 
                    if ( ta[13].equals("0")  ){   
                    %>
                    <td>0</td>
                    <td >查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[13] ); %></td>
                    <td class="bold"><a href=<%out.print( tahref[13]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                <tr>
                    <td align="left" class="indent">向选民述职</td>
                     <% 
                    if ( ta[14].equals("0")  ){   
                    %>    
                    <td>0</td>   
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[14] ); %></td>
                    <td class="bold"><a href=<%out.print( tahref[14]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
                </tr>
                 <tr>
                    <td align="left" class="indent">其他</td> 
                     <% 
                    if ( ta[15].equals("0")  ){   
                    %>    
                    <td>0</td>
                    <td>查看</td>
                    <% 
                    }else {        
                    %>
                    <td class="red3"> <% out.print( ta[15] ); %></td>
                     <td class="bold"><a href=<%out.print( tahref[15]  );%>>查看</a></td>
                    <%  
                    }
                    %>   
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