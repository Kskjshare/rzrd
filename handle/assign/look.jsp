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


<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>

<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "sort");
    CookieHelper cookie = new CookieHelper(request, response);
    list.pagesize = 1000000;
    String sql = "";
    if ( cookie.Get("powergroupid").equals("23") || cookie.Get("powergroupid").equals("7") ) {//市级 督察局
       // sql += " and isxzsc=0 and level=1";
        sql += " and isxzsc=0";
    } else if (cookie.Get("powergroupid").equals("25")) {//乡镇 政府办
        sql += " and (isxzsc=1 or level=0)";
    } 
    
    //增加闭会 开会 条件过滤
   //if ( list.get("ismeet").equals("1")){
      //   sql += " and ismeet=1";
   // }
   // else {
   //  sql += " and ismeet=0";
   //}
    
                 //增加闭会 开会 条件过滤 
                        String meetingTime="0";
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
                            sql += " and ismeet=1";
                         }
                        else {
                            sql += " and ismeet=0";
                         }
    
    
      String weijiaoban1 = "" ;
    String yijiaoban1 =  ""  ;
    list.select().where("type=1 and deal=0 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    RssListView list1 = new RssListView(pageContext, "sort");
    list1.pagesize = 10000;
    list1.select().where("type=1 and deal=1 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
     yijiaoban1 = "" + list1.totalrows;
      list1.select().where("type=1 and deal=0 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
     weijiaoban1 = "" + list1.totalrows;
    
     String weijiaoban2 = "" ;
    String yijiaoban2 =  ""  ;
    RssListView list2 = new RssListView(pageContext, "sort");
    list2.pagesize = 10000;
    list2.select().where("type=2 and deal=1 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    yijiaoban2 = "" + list2.totalrows;
    list2.select().where("type=2 and deal=0 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
     weijiaoban2 = "" + list2.totalrows;
    //批评
     String weijiaoban3 = "" ;
    String yijiaoban3 =  ""  ;
   
    RssListView list3 = new RssListView(pageContext, "sort");
    list3.pagesize = 1000;
    list3.select().where("type=3 and deal=1 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    yijiaoban3 = "" + list3.totalrows;
    list3.select().where("type=3 and deal=0 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    weijiaoban3 = "" + list3.totalrows;
   
    //意见
    String weijiaoban4 = "" ;
    String yijiaoban4 =  ""  ;
   
    RssListView list4 = new RssListView(pageContext, "sort");
    list4.pagesize = 1000;
    list4.select().where("type=4 and deal=1 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    yijiaoban4 = "" + list4.totalrows;
    list4.select().where("type=4 and deal=0 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    weijiaoban4 = "" + list4.totalrows;
   
     //质询
    String weijiaoban5 = "" ;
    String yijiaoban5 =  ""  ;
   
    RssListView list5 = new RssListView(pageContext, "sort");
    list5.pagesize = 1000;
    list5.select().where("type=5 and deal=1 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    yijiaoban5 = "" + list5.totalrows;
    list5.select().where("type=5 and deal=0 and draft=2 and examination=2 and handlestate=3"+sql).get_page_desc("id");
    weijiaoban5 = "" + list5.totalrows;
   
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
            <table class="cellbor auto margintop" style="font-size:16px;font-family: 微软雅黑">
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
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的建议</td>
                    <td class="red3"><% out.print( weijiaoban1 ); %></td>
                    <%
                    if ( weijiaoban1.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                     <td class="bold"><a href="table.jsp?type=1&deal=0&examination=2&handlestate=3">查看</a></td>
                     <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的建议</td>
                    <td class="red3"><% out.print( yijiaoban1 ); %></td>
                    <%
                    if ( yijiaoban1.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=1&deal=1&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                    
                </tr>
                
                <tr align="center">
                    <td rowspan="2">议案</td>
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的议案</td>
                    <td class="red3"><% out.print( weijiaoban2 ); %></td>
                    <%
                    if ( weijiaoban2.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=2&deal=0&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的议案</td>
                    <td class="red3"><% out.print( yijiaoban2  );%></td>
                    <%
                    if ( yijiaoban2.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=2&deal=1&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                
                 <tr align="center">
                    <td rowspan="2">批评</td>
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的批评</td>
                    <td class="red3"><% out.print( weijiaoban3 ); %></td>
                    <%
                    if ( weijiaoban3.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=3&deal=0&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的批评</td>
                    <td class="red3"><% out.print( yijiaoban3 );%></td>
                    <%
                    if ( yijiaoban3.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=3&deal=1&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                 
                 <tr align="center">
                    <td rowspan="2">意见</td>
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的意见</td>
                    <td class="red3"><% out.print( weijiaoban4 ); %></td>
                    <%
                    if ( weijiaoban4.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=4&deal=0&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的意见</td>
                    <td class="red3"><% out.print( yijiaoban4 );%></td>
                    <%
                    if ( yijiaoban4.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=4&deal=1&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                 
                 <tr align="center">
                    <td rowspan="2">质询</td>
                    <td>未交办</td>
                    <td align="left" class="w400 indent">未正式交办的质询</td>
                    <td class="red3"><% out.print(weijiaoban5); %></td>
                    <%
                    if ( weijiaoban5.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=5&deal=0&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                <tr align="center">
                    <td>已交办</td>
                    <td align="left" class="indent">已正式交办的质询</td>
                    <td class="red3"><% out.print(yijiaoban5);%></td>
                    <%
                    if ( yijiaoban5.equals("0") ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="table.jsp?type=5&deal=1&examination=2&handlestate=3">查看</a></td>
                    <%
                     };
                     %>
                </tr>
                
                
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
