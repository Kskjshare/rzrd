<%-- 
    Document   : see
    Created on : 2018-5-14, 12:00:34
    Author     : Administrator
--%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>    
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    String parentid = cookie.Get("parentid");
    String state = cookie.Get("state");
    String powergroupid = cookie.Get("powergroupid");
    String rid = "0";
    String view = "company_sug";
    if (state.equals("2") || state.equals("5")) {
        rid = "and companyid=" + parentid;        
    } else {
        rid = "and companyid=" + UserList.MyID(request);        
    }
    
    //自然资源和规划局18
    if ( powergroupid.equals("16") ) { 
        rid = " ";
        view = "sort";
    }
    
  
    RssListView list = new RssListView(pageContext, view);
    list.pagesize = 1000000;
    
      //
    String suggest_weibanfu = "" ;   
    String suggest_resolved = "" ;
    list.select().where("type=1 and draft=2 and examination=2 and handlestate=3 and resume=0 and deal=1 " + rid).get_page_desc("id");
    suggest_weibanfu = "" + list.totalrows;
    list.select().where("type=1 and draft=2 and examination=2 and handlestate=3 and resume=1 and deal=1 " + rid).get_page_desc("id");
    suggest_resolved = "" + list.totalrows; 
     
//    RssListView list1 = new RssListView(pageContext, view);
//    list1.pagesize = 1000000;
//    list1.select().where("type=1 and draft=2 and examination=2 and handlestate=3 and resume=1 and deal=1 " + rid).get_page_desc("id");

    
    
    String view_bill = "company_sug";//sort
    String yian_weibanfu = "" ;   
    String yian_resolved = "" ;
    RssListView list2 = new RssListView(pageContext, view_bill );
    list2.pagesize = 1000000;
    //list2.select().where("type=2 and draft=2 and examination=2 and handlestate=3 and resume=0 and deal=1 " + rid).get_page_desc("id");
    list2.select().where("type=2 and draft=2 and examination=2 and handlestate=3 and resume=0 and deal=1 "  + rid ).get_page_desc("id");
    int records = list2.totalrows ;
//    while (list2.for_in_rows()) {    
//        String realcompanyid = list2.get("realcompanyid");
//       
//        if ( realcompanyid.contains( cookie.Get("myid") )) {
//            records ++ ;
//        }
//    }
    //yian_weibanfu = "" + list2.totalrows;
    yian_weibanfu = "" + records;
    
    
    list2.select().where("type=2 and draft=2 and examination=2 and handlestate=3 and resume=1 and deal=1 " + rid).get_page_desc("id");
    yian_resolved = "" + list2.totalrows;
    
    
    
     //批评
    String criticism_weibanfu = "" ;   
    String criticism_resolved = "" ;
    String criticism_resolving =  ""  ;
    RssListView criticismList = new RssListView(pageContext, "company_sug"); // sort
    criticismList.pagesize = 1000;
    criticismList.select().where("type=3 and deal=1 and draft=2 and examination=2 and handlestate=3 and resume=0 "+ rid ).get_page_desc("id");
    criticism_weibanfu = "" + criticismList.totalrows;
    criticismList.select().where("type=3 and deal=1 and draft=2 and examination=2 and handlestate=3 and resume=1 " + rid ).get_page_desc("id");
    criticism_resolved = "" + criticismList.totalrows;
    
     //意见
    String opinion_weibanfu = "" ;   
    String opinion_resolved = "" ;
    String opinion_resolving =  ""  ;
    RssListView opionList = new RssListView(pageContext, "company_sug"); // sort
    opionList.pagesize = 1000;
    opionList.select().where("type=4 and deal=1 and draft=2 and examination=2 and handlestate=3 and resume=0 "+ rid ).get_page_desc("id");
    opinion_weibanfu = "" + opionList.totalrows;
    opionList.select().where("type=4 and deal=1 and draft=2 and examination=2 and handlestate=3 and resume=1 "+ rid  ).get_page_desc("id");
    opinion_resolved = "" + opionList.totalrows;
    
    
    //质询
    String inquery_weibanfu = "" ;   
    String inquery_resolved = "" ;
    String zhixun_resolving =  ""  ;
    RssListView list5 = new RssListView(pageContext, "company_sug"); // sort
    list5.pagesize = 1000;
    list5.select().where("type=5 and deal=1 and draft=2 and examination=2 and handlestate=3 and resume=0 " + rid).get_page_desc("id");
    inquery_weibanfu = "" + list5.totalrows;
    list5.select().where("type=5 and deal=1 and draft=2 and examination=2 and handlestate=3 and resume=1 " + rid).get_page_desc("id");
    inquery_resolved = "" + list5.totalrows;
    
    
//    RssListView list3 = new RssListView(pageContext, view);
//    list3.pagesize = 1000000;
//    list3.select().where("type=2 and draft=2 and examination=2 and handlestate=3 and resume=1 and deal=1 " + rid).get_page_desc("id");
    String a1 = "0", a2 ="0", a3 ="0", a4 ="0", b1 ="0", b2 ="0", b3 ="0", b4 ="0";
    RssListView list4 = new RssListView(pageContext, view);
    list4.query("SELECT type,degree,COUNT(*) as num FROM "+view+"_list_view WHERE draft=2 and examination=2 and handlestate=3 and resume=1 and deal=1 " + rid + " GROUP BY degree,type");
    while (list4.for_in_rows()) {        
        if (list4.get("type").equals("1")) {
            switch(list4.get("degree")){
            case "1":
                a1=list4.get("num");
                break;
            case "2":
                a2=list4.get("num");
                break;
            case "3":
                a3=list4.get("num");
                break;
            case "4":
                a4=list4.get("num");
                break;
            }
        } else if (list4.get("type").equals("2")) {
           switch(list4.get("degree")){
            case "1":
                b1=list4.get("num");
                break;
            case "2":
                b2=list4.get("num");
                break;
            case "3":
                b3=list4.get("num");
                break;
            case "4":
                b4=list4.get("num");
                break;
            } 
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 20px;}
            .dce{background: #dce6f5;}
            .indent{text-indent: 10px}
            .red3{color:#c03e20}
            .bold{font-weight: bold;}
        </style>
    </head>
    <body>
        <div>
            <table style="font-size:16px;font-family: 微软雅黑" class="cellbor auto margintop">
                <tr>
                    <td colspan="5" class="tabheader">议案建议提交情况</td>
                </tr>
                <tr class="dce">
                    <th class="w100">分类</th>
                    <th class="w100">项目</th>
                    <th class="w100">说明</th>
                    <th class="w100">数目</th>
                    <th class="w100">操作</th>
                </tr>
                <tr align="center">
                    <td rowspan="2">建议</td>
                    <td>未办复</td>
                    <td align="left" class="w400 indent">已交办，未办复的建议</td>
                    <td class="red3"><% out.print( suggest_weibanfu ); %></td>
                    <%
                    if ( suggest_weibanfu.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=1&draft=2&examination=2&handlestate=3&resume=0&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td rowspan="1">已办复</td>
                    <td align="left" class="indent">已交办，已解决的建议</td>
                    <td class="red3"><% out.print( suggest_resolved ); %></td>
                    <%
                    if ( suggest_resolved.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=1&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                <!--
                <tr align="center">
                    <td align="left" class="indent">已交办，正在解决的建议</td>
                    <td><% out.print(a2); %></td>
                    <td><a href="resumesee.jsp?type=1&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=2">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">已交办，列入解决计划的建议</td>
                    <td><% out.print(a3); %></td>
                    <td><a href="resumesee.jsp?type=1&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=3">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">已交办，因条件限制无法解决的建议</td>
                    <td><% out.print(a4); %></td>
                    <td><a href="resumesee.jsp?type=1&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=4">查看</a></td>
                </tr>
                -->
                <tr align="center">
                    <td rowspan="2">议案</td>
                    <td>未办复</td>
                    <td align="left" class="w400 indent">已交办，未办复的议案</td>
                    <td class="red3"><% out.print( yian_weibanfu ); %></td>
                    <%
                    if ( yian_weibanfu.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=0&deal=1&lwstate=2">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td rowspan="1">已办复</td>
                    <td align="left" class="indent">已交办，已解决的议案</td>
                    <td class="red3"><% out.print( yian_resolved ); %></td>
                    <%
                    if ( yian_resolved.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <!--
                <tr align="center">
                    <td align="left" class="indent">已交办，正在解决的议案</td>
                    <td><% out.print(b2); %></td>
                    <td><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=2">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">已交办，列入解决计划的议案</td>
                    <td><% out.print(b3); %></td>
                    <td><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=3">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">已交办，因条件限制无法解决的议案</td>
                    <td><% out.print(b4); %></td>
                    <td><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=4">查看</a></td>
                </tr>
                -->
                
                
                
                 <tr align="center">
                    <td rowspan="2">批评</td>
                    <td>未办复</td>
                    <td align="left" class="w400 indent">已交办，未办复的批评</td>
                    <td class="red3"><% out.print( criticism_weibanfu ); %></td>
                    <%
                    if ( criticism_weibanfu.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=3&draft=2&examination=2&handlestate=3&resume=0&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td rowspan="1">已办复</td>
                    <td align="left" class="indent">已交办，已解决的批评</td>
                    <td class="red3"><% out.print( criticism_resolved ); %></td>
                    <%
                    if ( criticism_resolved.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=3&draft=2&examination=2&handlestate=3&resume=1&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                
                
                
                 <tr align="center">
                    <td rowspan="2">意见</td>
                    <td>未办复</td>
                    <td align="left" class="w400 indent">已交办，未办复的意见</td>
                    <td class="red3"><% out.print( opinion_weibanfu ); %></td>
                    <%
                    if ( opinion_weibanfu.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=4&draft=2&examination=2&handlestate=3&resume=0&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td rowspan="1">已办复</td>
                    <td align="left" class="indent">已交办，已解决的意见</td>
                    <td class="red3"><% out.print( opinion_resolved ); %></td>
                    <%
                    if ( opinion_resolved.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=4&draft=2&examination=2&handlestate=3&resume=1&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                
              
                <tr align="center">
                    <td rowspan="2">质询</td>
                    <td>未办复</td>
                    <td align="left" class="w400 indent">已交办，未办复的质询</td>
                    <td class="red3"><% out.print( inquery_weibanfu ); %></td>
                    <%
                    if ( inquery_weibanfu.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=5&draft=2&examination=2&handlestate=3&resume=0&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td rowspan="1">已办复</td>
                    <td align="left" class="indent">已交办，已解决的质询</td>
                    <td class="red3"><% out.print( inquery_resolved ); %></td>
                    <%
                    if ( inquery_resolved.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="resumesee.jsp?type=5&draft=2&examination=2&handlestate=3&resume=1&deal=1">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <!--
                <tr align="center">
                    <td align="left" class="indent">已交办，正在解决的议案</td>
                    <td><% out.print(b2); %></td>
                    <td><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=2">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">已交办，列入解决计划的质询</td>
                    <td><% out.print(b3); %></td>
                    <td><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=3">查看</a></td>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">已交办，因条件限制无法解决的质询</td>
                    <td><% out.print(b4); %></td>
                    <td><a href="resumesee.jsp?type=2&draft=2&examination=2&handlestate=3&resume=1&deal=1&degree=4">查看</a></td>
                </tr>
                -->
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
