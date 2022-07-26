<%-- 
    Document   : see
    Created on : 2018-5-14, 12:00:34
    Author     : Administrator
--%>
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
    if ( meetingTime.equals("1")) {
        isMeeting =  1;
    }
    
    StaffList.IsLogin(request, response);
//    RssList user = new RssList(pageContext, "suggest");
    RssListView list = new RssListView(pageContext, "sort");
    RssListView list1 = new RssListView(pageContext, "sort");

//    if (user.select().where("myid=?", UserList.MyID(request)).get_first_rows()) {
    if (isMeeting == 1)
         list.query("SELECT myid,resume,consultation,COUNT(*) AS num FROM sort_list_view WHERE draft=2 and ismeet=1 and myid=" + UserList.MyID(request) + " GROUP BY myid,resume,consultation");
    else 
    list.query("SELECT myid,resume,consultation,COUNT(*) AS num FROM sort_list_view WHERE draft=2 and ismeet=0 and myid=" + UserList.MyID(request) + " GROUP BY myid,resume,consultation");
//    } else {
    list1.query("SELECT userid,resume,consultation,COUNT(*) AS num FROM sortuser_list_view WHERE draft=2 and userid=" + UserList.MyID(request) + " GROUP BY userid,resume,consultation");
//    }
    String[] use = {"0", "0"};
    while (list1.for_in_rows()) {
        if (list1.get("resume").equals("1") && list1.get("consultation").equals("0")) {
            use[0] = list1.get("num");
        } else if (list1.get("resume").equals("1") && list1.get("consultation").equals("1")) {
            use[1] = list1.get("num");
        }
    }
    int num = Integer.parseInt(use[0]) + Integer.parseInt(use[1]);
    String[] ta = {"0", "0", "0"};
    
    while (list.for_in_rows()) {
        if (list.get("resume").equals("0") && list.get("consultation").equals("0")) {
                

            ta[0] = list.get("num");
        } else if (list.get("resume").equals("1") && list.get("consultation").equals("0")) {
            ta[1] = list.get("num");
        } else if (list.get("resume").equals("1") && list.get("consultation").equals("1")) {
            ta[2] = list.get("num");
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
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop" style="font-size:16px;font-family: 微软雅黑">
                <tr>
                    <td font-size=14px colspan="5" class="tabheader">评价情况汇总</td>
                </tr>
                <tr class="dce">
                    <th class="w100">项目</th>
                    <th colspan="2">说明</th>
                    <th class="w100">件数</th>
                    <th class="w100">操作</th>
                </tr>

                <tr align="center">
                    <td rowspan="2">未填写</td>
                    <td align="left"  colspan="2" class="indent">承办单位未答复(没有办理回复报告)的意见建议</td>
                    <td class="red3"><% out.print(ta[0]); %></td>
                 <!--zyx 增加判定，没有的时候查看不可点击     开始-->
                    <%
                    if ( (ta[0]) == "0" ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td style="font-weight:bold;"><a href="table.jsp?resume=0&consultation=0">查看</a></td>
                    <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td align="left"  colspan="2" class="indent">承办单位已答复(已有办理回复报告)的意见建议</td>
                    <td class="red3"><% out.print(ta[1]);%></td>
                     <%
                    if ( (ta[1]) == "0" ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td style="font-weight:bold;"><a href="table.jsp?resume=1&consultation=0">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td>已填写</td>
                    <td align="left" colspan="2" class="indent">领衔代表已填写对议案建议办理答复的意见</td>
                    <td class="red3" ><% out.print(ta[2]);%></td>
                     <%
                    if ( (ta[2]) == "0" ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td style="font-weight:bold;"><a href="table.jsp?resume=1&consultation=1">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr class="dce"> </tr>
                <tr align="center">
                    <td>附议意见</td>
                    <td align="left" colspan="2" class="indent">附议代表填写对议案建议办理答复的意见</td>
                    <td class="red3"><% out.print(num);%></td>
                     <%
                    if ( num == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td style="font-weight:bold;"><a href="table_1.jsp?resume=1">查看</a></td>
                     <%
                    };
                    %>
            <!--zyx 结束-->
                </tr>
                <tr class="dce"> </tr>
            </table>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
    </body>
</html>
