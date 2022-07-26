<%-- 
    Document   : list_2
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
<%    StaffList.IsLogin(request, response);
    String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
    Properties properties = new Properties();
    InputStream is = new FileInputStream(propertiesFileName);
    properties.load(is);
    is.close();
    String meetingTime = properties.get("meetingtime").toString();
    

    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "deputyActivity");
    entity.pagesize = 10000000;
     entity.select().where("pid=1").get_page_desc("id");
    int a = 0;
    int aa = 0;
    int bb = 0;
     int cc = 0;
    int dd = 0;
     int ee = 0;
    int ff = 0;
    int gg = 0;
    int hh = 0;
     int ii = 0;
    int jj = 0;
     int kk = 0;
    int ll = 0;
    int mm = 0;
    int nn = 0;
     int oo = 0;
    int pp = 0;
     int qq = 0;
    int rr = 0;
      while (entity.for_in_rows()) {
           if (entity.get("pid").equals("1")) {//议案
                            a++;
            if (entity.get("typeid").equals("1")) {
                            aa++;
            }else
            if (entity.get("typeid").equals("2")) {
                                bb++;
             }else
            if (entity.get("typeid").equals("3")) {
                                cc++;
             }else
            if (entity.get("typeid").equals("4") ) {
                                dd++;
            }else
            if (entity.get("typeid").equals("5")) {
                                ee++;
             }else
            if (entity.get("typeid").equals("6")) {
                                ff++;
             }else
            if (entity.get("typeid").equals("7")) {
                                gg++;
             }else
            if (entity.get("typeid").equals("8")) {
                                hh++;
             }else
            if (entity.get("typeid").equals("9")) {
                                ii++;
             }else
            if (entity.get("typeid").equals("10")) {
                                jj++;
             }else
            if (entity.get("typeid").equals("11")) {
                                kk++;
             }else
            if (entity.get("typeid").equals("12")) {
                                ll++;
             }else
            if (entity.get("typeid").equals("13") ) {
                                mm++;
            }else
            if (entity.get("typeid").equals("14")) {
                                nn++;
             }else
            if (entity.get("typeid").equals("15")) {
                                oo++;
             }else
            if (entity.get("typeid").equals("16")) {
                                pp++;
             }else
            if (entity.get("typeid").equals("17")) {
                                qq++;
             }else
            if (entity.get("typeid").equals("18")) {
                                rr++;
             }
          }else{
               if (entity.get("typeid").equals("1")) {
                            aa++;
            }else
            if (entity.get("typeid").equals("2")) {
                                bb++;
             }else
            if (entity.get("typeid").equals("3")) {
                                cc++;
             }else
            if (entity.get("typeid").equals("4") ) {
                                ee++;
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
            .cellbor{width: 700px;}
            .red3{color:#c03e20}
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px; height: 40px; font-size: 25px; font-weight: 600px }
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 17px;text-align: center;}
            .dce{background: #dce6f5;}
            .cellbor>tbody>tr>.indent{text-indent: 10px;text-align: left}
            #divide{height: 10px;}
            .cellbor i{ color: #a79012;font-style: normal}
            .cellbor tr i:nth-child(2){margin-left: 5px;}
            .bold{font-weight:bold;}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop" style="margin-top:10px">
                <tr>
                    <td colspan="5" class="tabheader">履职活动情况</td>
                </tr>
                <tr class="dce">
                    <td>项目</td>
                    <td>件数</td>
                    <td>操作</td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加人代会</td>
                    <td class="red3"><%out.print(aa); %> </td>
                    <td class="bold"><a href="list_3.jsp?typeid=1">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加常委会</td>
                    <td class="red3">  <% out.print(bb); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=2">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加主任会议</td>
                    <td class="red3"> <% out.print(cc); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=3">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加代表团会议/活动</td>
                    <td class="red3"> <% out.print(dd); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=4">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">其他会议/活动</td>
                    <td class="red3"> <% out.print(ee); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=5">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加视察调研</td>
                    <td class="red3"> <% out.print(ff); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=6">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加执法检查</td>
                    <td class="red3"> <% out.print(gg); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=7">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加专题座谈</td>
                    <td class="red3"> <% out.print(hh); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=8">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">参加学习培训</td>
                    <td class="red3"> <% out.print(ii); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=9">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">联系、接待基层代表和人民群众</td>
                    <td class="red3"> <% out.print(jj); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=10">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">报告履职情况</td>
                    <td class="red3"> <% out.print(kk); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=11">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">获省级及以上表彰奖励</td>
                    <td class="red3"> <% out.print(ll); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=12">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">获市级表彰奖励</td>
                    <td class="red3"> <% out.print(mm); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=13">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">列席市人大常委会会议</td>
                    <td class="red3"> <% out.print(nn); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=14">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">列席县（市、区）人民代表大会</td>
                    <td class="red3"> <% out.print(oo); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=15">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">列席县（市、区）人大常委会会议</td>
                    <td class="red3"> <% out.print(pp); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=16">查看</a></td>
                </tr>
                <tr>
                    <td align="left" class="indent">个人持证视察或调研</td>
                    <td class="red3"> <% out.print(qq); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=17">查看</a></td>
                </tr>
                  <tr>
                    <td align="left" class="indent">为民办实事</td>
                    <td class="red3"> <% out.print(rr); %></td>
                    <td class="bold"><a href="list_3.jsp?typeid=18">查看</a></td>
                </tr>
                <tr id="divide" class="dce"></tr>
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