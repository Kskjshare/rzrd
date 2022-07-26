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
            .cellbor{width: 900px;margin-top:10px;}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height:12px;text-align: center;}
            .dce{background: #dce6f5; }
            .indent{text-indent:6px;}
            .red3{color:#c03e20}
            .bold{font-weight: bold;}
        </style>
    </head>
    <body>
        <div>
            <table class="cellbor auto margintop" style="font-size:16px;font-family: 微软雅黑"  >
                <tr>
                    <td colspan="5" class="tabheader">提交情况</td>
                </tr>
                <tr class="dce">
                    <th class="w100">分类</th>
                    <th class="w100">项目</th>
                    <th class="w100">说明</th>
                    <th class="w100">数目</th>
                    <th class="w100">操作</th>
                </tr>
                <%
                    CookieHelper cookie = new CookieHelper(request, response);
                    RssListView list = new RssListView(pageContext, "sort");
                    list.pagesize = 10000000;
                    String sql = "";
                    if (cookie.Get("powergroupid").equals("23") || cookie.Get("powergroupid").equals("7")) {//督察局（市流程）
                        sql+=" and level=1";
                    } else if (cookie.Get("powergroupid").equals("25")) {//乡镇主席团
                        sql+=" and level=0";
                    }
             
                        String meetingTime="0";
                        int isMeeting = 0;
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
                            isMeeting = 1;
                         }
                        else {
                            sql += " and ismeet=0";
                         }
                         
                    
                    //list.select().where("draft=2 and examination=2"+sql).get_page_desc("id");//已提交，已审查
                   //  list.select().where("draft=2"+sql).get_page_desc("id");//已提交，已审查
                   
                   //督察局开会流程看不到记录，丁测试
                     list.select().where("draft=2 and examination=2").get_page_desc("id");//已提交，已审查

                    int a = 0, b = 0, c = 0, d = 0, aa = 0, bb = 0, cc = 0, dd = 0;
                    
                    int criticism_weiquding = 0 ; //未确定
                    int criticism_niqueding = 0 ; //拟确定
                    int criticism_yiqueding = 0 ; //已确定
                    int criticism_refused = 0 ; //驳回
                    
                    int opinion_weiquding = 0 ; //未确定
                    int opinion_niqueding = 0 ; //拟确定
                    int opinion_yiqueding = 0 ; //已确定
                    int opinion_refused = 0 ; //驳回
                    
                    int inquery_weiquding = 0 ; //未确定
                    int inquery_niqueding = 0 ; //拟确定
                    int inquery_yiqueding = 0 ; //已确定
                    int inquery_refused = 0 ; //驳回
                    
                    while (list.for_in_rows()) {
                        
                        if (list.get("type").equals("1")) {
                           
                            if (list.get("handlestate").equals("1")) {
                                a++;
                            }
                            if (list.get("handlestate").equals("2")) {
                                b++;
                            }
                            if (list.get("handlestate").equals("3")) {
                                c++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                d++;
                            }
                        }
                        
                        else if (list.get("type").equals("2")) {
                            if (list.get("handlestate").equals("1")) {
                                aa++;
                                if (isMeeting == 1  ) {
                                    if (list.get("isysw").equals("0")) {//没有经过议审委
                                    aa--;
                                    }
                                    
                                }
                            }
                            if (list.get("handlestate").equals("2")) {
                                bb++;
                            }
                            if (list.get("handlestate").equals("3")) {
                                cc++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                dd++;
                            }
                        }
                        
                        //批评
                          else if (list.get("type").equals("3")) {
                            if (list.get("handlestate").equals("1")) {
                                criticism_weiquding ++ ;
                                 if (isMeeting == 1  ) {
                                    if (list.get("isysw").equals("0")) {//没有经过议审委
                                    criticism_weiquding--;
                                    }
                                    
                                }
                            }
                            if (list.get("handlestate").equals("2")) {
                                criticism_niqueding ++;
                            }
                            if (list.get("handlestate").equals("3")) {
                                criticism_yiqueding ++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                criticism_refused ++;
                            }
                        }
                    
                
                          
                          else if (list.get("type").equals("4")) {
                            if (list.get("handlestate").equals("1")) {
                                opinion_weiquding++;
                                 if (isMeeting == 1  ) {
                                    if (list.get("isysw").equals("0")) {//没有经过议审委
                                    opinion_weiquding--;
                                    }
                                    
                                }
                            }
                            if (list.get("handlestate").equals("2")) {
                                opinion_niqueding++;
                            }
                            if (list.get("handlestate").equals("3")) {
                                opinion_yiqueding++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                opinion_refused++;
                            }
                        }
                        
                          //质询
                          else if (list.get("type").equals("5")) {
                            if (list.get("handlestate").equals("1")) {
                                inquery_weiquding++;
                                  if (isMeeting == 1  ) {
                                    if (list.get("isysw").equals("0")) {//没有经过议审委
                                    inquery_weiquding--;
                                    }
                                    
                                }
                            }
                            if (list.get("handlestate").equals("2")) {
                                inquery_niqueding++;
                            }
                            if (list.get("handlestate").equals("3")) {
                                inquery_yiqueding++;
                            }
                            if (list.get("handlestate").equals("4")) {
                                inquery_refused++;
                            }
                        }
                        
                        
                    }
                %>
                <tr align="center">
                    <td rowspan="4">建议</td>
                    <td>未确定</td>
                    <td align="left" class="w400 indent">没有确定主办单位的建议</td>
                    <td class="red3"><% out.print(a); %></td>
                    <%
                    if ( a == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=1&handlestate=1&type=1">查看</a></td>
                    <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td>拟确定</td>
                    <td align="left" class="indent">初步确定办理归入系统，待进一步确定具体主办单位的建议</td>
                    <td class="red3"><% out.print(b); %></td>
                    <%
                    if ( b == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=1&handlestate=2&type=1">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td rowspan="2">已确定</td>
                    <td align="left" class="indent">已确定具体主办单位的建议</td>
                    <td class="red3"><% out.print(c); %></td>
                    <%
                    if ( c == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=1&handlestate=3&type=1">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">其中主办单位申退的建议(件次)</td>
                    <td class="red3"><% out.print(d);%></td>
                    <%
                    if ( d == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=1&handlestate=4&type=1">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                
                <tr align="center">
                    <td rowspan="4">议案</td>
                    <td>未确定</td>
                    <td align="left" class="w400 indent">没有确定主办单位的议案</td>
                    <td class="red3"><% out.print(aa); %></td>
                    <%
                    if ( aa == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=2&handlestate=1&type=2">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td>拟确定</td>
                    <td align="left" class="indent">初步确定办理归入系统，待进一步确定具体主办单位的议案</td>
                    <td class="red3"><% out.print(bb); %></td>
                    <%
                    if ( bb == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=2&handlestate=2&type=2">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td rowspan="2">已确定</td>
                    <td align="left" class="indent">已确定具体主办单位的议案</td>
                    <td class="red3"><% out.print(cc); %></td>
                    <%
                    if ( cc == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=2&handlestate=3&type=2">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">其中主办单位申退的议案(件次)</td>
                    <td class="red3"><% out.print(dd);%></td>
                    <%
                    if ( dd == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=2&handlestate=4&type=2">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                
                
                 <tr align="center">
                    <td rowspan="4">批评</td>
                    <td>未确定</td>
                    <td align="left" class="w400 indent">没有确认主办单位的批评</td>
                    <td class="red3"><% out.print( criticism_weiquding ); %></td>
                    <%
                    if ( criticism_weiquding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=3&handlestate=1&type=3">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td>拟确定</td>
                    <td align="left" class="indent">拟确定具体的主办单位</td>
                    <td class="red3"><% out.print( criticism_niqueding ); %></td>
                    <%
                    if ( criticism_niqueding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=3&handlestate=2&type=3">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td rowspan="2">已确定</td>
                    <td align="left" class="indent">已确定具体主办单位的批评</td>
                    <td class="red3"><% out.print( criticism_yiqueding ); %></td>
                    <%
                    if ( criticism_yiqueding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=3&handlestate=3&type=3">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">其中主办单位申退的批评(件次)</td>
                    <td class="red3"><% out.print( criticism_refused );%></td>
                    <%
                    if ( criticism_refused == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=3&handlestate=4&type=3">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                
                
                 <tr align="center">
                    <td rowspan="4">意见</td>
                    <td>未确定</td>
                    <td align="left" class="w400 indent">未确认主办单位的意见</td>
                    <td class="red3"><% out.print( opinion_weiquding ); %></td>
                    <%
                    if ( opinion_weiquding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=4&handlestate=1&type=4">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td>拟确定</td>
                    <td align="left" class="indent">拟确定具体的主办单位</td>
                    <td class="red3"><% out.print( opinion_niqueding ); %></td>
                    <%
                    if ( opinion_niqueding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=4&handlestate=2&type=4">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td rowspan="2">已确定</td>
                    <td align="left" class="indent">已确定具体主办单位的意见</td>
                    <td class="red3"><% out.print( opinion_yiqueding ); %></td>
                    <%
                    if ( opinion_yiqueding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=4&handlestate=3&type=4">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">其中主办单位申退的意见(件次)</td>
                    <td class="red3"><% out.print( opinion_refused );%></td>
                    <%
                    if ( opinion_refused == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=4&handlestate=4&type=4">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                
                  <tr align="center">
                    <td rowspan="4">质询</td>
                    <td>未确定</td>
                    <td align="left" class="w400 indent">未确认主办单位的质询</td>
                    <td class="red3"><% out.print( inquery_weiquding ); %></td>
                    <%
                    if ( inquery_weiquding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=5&handlestate=1&type=5">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td>拟确定</td>
                    <td align="left" class="indent">拟确定具体的主办单位</td>
                    <td class="red3"><% out.print( inquery_niqueding ); %></td>
                    <%
                    if ( inquery_niqueding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=5&handlestate=2&type=5">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td rowspan="2">已确定</td>
                    <td align="left" class="indent">已确定具体主办单位的质询</td>
                    <td class="red3"><% out.print( inquery_yiqueding ); %></td>
                    <%
                    if ( inquery_yiqueding == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=5&handlestate=3&type=5">查看</a></td>
                     <%
                    };
                    %>
                </tr>
                <tr align="center">
                    <td align="left" class="indent">其中主办单位申退的质询(件次)</td>
                    <td class="red3"><% out.print( inquery_refused );%></td>
                    <%
                    if ( inquery_refused == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <td class="bold"><a href="list.jsp?lwstate=5&handlestate=4&type=5">查看</a></td>
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
