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


<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>

<%    StaffList.IsLogin(request, response);
    String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
    Properties properties = new Properties();
    InputStream is = new FileInputStream(propertiesFileName);
    properties.load(is);
    is.close();
    String meetingTime = properties.get("meetingtime").toString();
    int isMeeting = 0 ;
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
            .cellbor{width: 900px;margin-top:2px;}
            .red3{color:#c03e20}
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height:12px;text-align: center;}
            .dce{background: #dce6f5;}
            .cellbor>tbody>tr>.indent{text-indent: 10px;text-align: left}
            #divide{height:6px;}
            .cellbor i{ color: #a79012;font-style: normal;}
            .cellbor tr i:nth-child(2){margin-left: 5px;}
        </style>
    </head>
    <body>
        <div>
            <table style="font-size:16px;font-family: 微软雅黑" class="cellbor auto margintop">
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
                    String rwhere = "";
                    String view = "";
                    
                    
                 
                    String row1Url = "list.jsp?lwstate=1&isdbtshenhe=1&examination=2&isxzsc=1";
                    String strXzfb = "经选联委审查处理";
                    //added by ding
                    if ( isMeeting == 1 && cookie.Get("powergroupid").equals("8") ){ //议审委
                        //如果开会期间主席团登录，不应该看到被代表团置回的记录
                         strXzfb = "经审查处理";
                    }    
                    
                    
                    if (cookie.Get("powergroupid").equals("16")) {//16:系统管理员
                        rwhere = "draft=2";
                        view = "sort";
                    } else {
                        if (cookie.Get("powergroupid").equals("8")) {//议审委  7:选联委
                            //rwhere = "draft=2 and fsrID=" + UserList.MyID(request);
                            //view = "scr_suggest";
                            rwhere = "draft=2 and iscs= 1 and isysw=0";
                            view = "sort";
                            if ( meetingTime.equals("1")){
                                //ADDED by ding
                                rwhere = "draft=2 and iscs= 1 and isysw=21";
                                
                                 
                            }
                            
                        } else {
                            rwhere = "draft=2 and userid=" + UserList.MyID(request);
                            view = "scr_suggest";
                        }
                    }
                    System.out.println("rwhere:::" + rwhere);
                    RssListView list = new RssListView(pageContext, view);
                    list.pagesize = 10000000;
                    list.select().where(rwhere).get_page_desc("id");
                    int suggests =0;
                    int b = 0;
                    int c = 0;
                    int d = 0;
                    int e = 0;
                    int aa = 0;
                    int bb = 0;
                    int cc = 0;
                    int dd = 0;
                    int ee = 0;
                    
                    //批评
                    int ee_criticism = 0 ;
                    int bb_criticism_submit = 0 ;
                    int cc_criticism_unsubmit = 0 ;
                    
                     //意见
                    int ee_opinion = 0 ;
                    int bb_opinion_submit = 0 ;
                    int cc_opinion_unsubmit = 0 ;
                    
                       //质询
                    int ee_inquery = 0 ;
                    int bb_inquery_submit = 0 ;
                    int cc_inquery_unsubmit = 0 ;
                    
                    while (list.for_in_rows()) {
                        if (list.get("lwstate").equals("1")) {//建议
                            //System.out.println("examination::"+list.get("examination"));
                            suggests ++;
                            if (list.get("examination").equals("2")) {
                                b++;
                            }
                            if (list.get("examination").equals("3")) {
                                c++;
                            }
                            //System.out.println("flowtype::"+flowtype);
                            // System.out.println("list.getisysw::"+list.get("isysw"));
                            //   System.out.println("list.getexamination::"+list.get("examination"));
                            //below added by jackie
                            if (meetingTime.equals("1")) {//大会期间，所以走代表团初审流程
                                if (list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                    //examination 审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查
                                    e++;
                                }
                            } else if (meetingTime.equals("0")) {//闭会期间，不走代表团
                                if (list.get("examination").equals("1")) {
                                    //审查状态 1:未审查（不在大会期间22）,2:已审查,3:置回,5:待审查（在大会期间21）,6:乡镇已审查
                                    //初审状态 0：未初审,1：已初审
                                    //代表团审查1：已审核，2：未审核
                                    // System.out.println("examination:boolean:"+list.get("examination").equals("1"));
                                    e++;
                                }
                            }
                            //up added by jackie

                        }
                        if (list.get("lwstate").equals("2")) {//议案
                            aa++;
                            if (list.get("examination").equals("2")) {
                                bb++;
                            }
                            if (list.get("examination").equals("3")) {
                                cc++;
                            }
                            if (list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                //审查状态 1:未审查（不在大会期间22）,2:已审查,3:置回,5:待审查（在大会期间21）,6:乡镇已审查
                                //初审状态 0：未初审,1：已初审
                                //代表团审查1：已审核，2：未审核
                                ee++;
                            }
                        }
                        
                        
                        
                        
                         if (list.get("lwstate").equals("3")) {//批评
                            aa++;
                            if (list.get("examination").equals("2")) {
                                bb_criticism_submit++;
                            }
                            if (list.get("examination").equals("3")) {
                                cc_criticism_unsubmit++;
                            }
                            if (list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                //审查状态 1:未审查（不在大会期间22）,2:已审查,3:置回,5:待审查（在大会期间21）,6:乡镇已审查
                                //初审状态 0：未初审,1：已初审
                                //代表团审查1：已审核，2：未审核
                                ee_criticism ++;
                            }
                         }
                        
                                  
                         if (list.get("lwstate").equals("4")) {//意见
                            aa++;
                            if (list.get("examination").equals("2")) {
                                bb_opinion_submit++;
                            }
                            if (list.get("examination").equals("3")) {
                                cc_opinion_unsubmit++;
                            }
                            if (list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                //审查状态 1:未审查（不在大会期间22）,2:已审查,3:置回,5:待审查（在大会期间21）,6:乡镇已审查
                                //初审状态 0：未初审,1：已初审
                                //代表团审查1：已审核，2：未审核
                                ee_opinion ++;
                            }
                        }
                         
                               
                         if (list.get("lwstate").equals("5")) {//质询
                            aa++;
                            if (list.get("examination").equals("2")) {
                                bb_inquery_submit++;
                            }
                            if (list.get("examination").equals("3")) {
                                cc_inquery_unsubmit++;
                            }
                            if (list.get("iscs").equals("1") && list.get("examination").equals("5")) {
                                //审查状态 1:未审查（不在大会期间22）,2:已审查,3:置回,5:待审查（在大会期间21）,6:乡镇已审查
                                //初审状态 0：未初审,1：已初审
                                //代表团审查1：已审核，2：未审核
                                ee_inquery ++;
                            
                            }
                         }
                   
                            
                            
                            
                        
                    }
                %>
                <tr>
                    <td rowspan="4">建议</td>
                    
                    <td style="width:140px;">初审查</td>
                    <td align="left" class="indent"style="width:350px;">已经正式提交的,且已初审处理的建议</td>
                    <td class="red3"><% out.print(e);%></td>
                    <!--zyx-->
                    <%
                    if ( e == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <% if (meetingTime.equals("1")) {//大会期间，走代表团流程
                    %>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=1&examination=5&isdbtshenhe=1&iscs=1&draft=2">查看</a></td>
                    <%
                    } else if (meetingTime.equals("0")) {//闭会期间，不走代表团，examination=1
                    %>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=1&draft=2&examination=1&iscs=0">查看</a></td>

                    <!--<td><a href="list_2.jsp?lwstate=1&draft=2&examination=5&isdbtshenhe=1&iscs=1">查看</a></td>-->
                    <%
                        }};
                    %>


                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>交办</i>的建议:<i><% out.print(b);%></i></td>
                    <td class="red3" rowspan="2"><% out.print(b + c);%></td>
                    <!--zyx-->
                    <%
                    if ( b == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=1&isdbtshenhe=1&examination=2&draft=2">查看</a></td>
                    <!--zyx-->
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不交办</i>的建议:<i><% out.print(c);%></i></td>
                    <!--zyx-->
                    <%
                    if ( c == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=1&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
<!--                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>撤案</i>的建议:<i><% out.print(c);%></i></td>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=1&examination=3&draft=2">查看</a></td>
                </tr>-->
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有建议</td>
                    
                    <!--td class="red3"><% out.print(e + b + c);%></td-->
                     <td class="red3"><% out.print( e + b + c );%></td>
                   <!--zyx-->
                    <%
                    if ( e+b+c == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=1&draft=2">查看</a></td>
                     <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                    
                </tr>
                <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">议案</td>
                    <td>初审查</td>
                    <td align="left" class="indent">已经正式提交的,且由代表团审查处理的议案</td>
                    <td class="red3"><% out.print(ee);%></td>
                     <!--zyx-->
                    <%
                    if ( ee == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&examination=5&isdbtshenhe=1&iscs=1&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>交办</i>的议案:<i><% out.print(bb);%></i></td>
                    <td class="red3" rowspan="2"><% out.print(bb + cc);%></td>
                     <!--zyx-->
                    <%
                    if ( bb == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&examination=2&draft=2&isdbtshenhe=1">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不交办</i>的议案:<i><% out.print(cc);%></i></td>
                     <!--zyx-->
                    <%
                    if ( cc == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
<!--                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>撤案</i>的议案:<i><% out.print(cc);%></i></td>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&examination=3&draft=2">查看</a></td>
                </tr>-->
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有议案</td>
                    <td class="red3"><% out.print(ee + bb + cc);%></td>
                     <!--zyx-->
                    <%
                    if ( ee+bb+cc == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                
                
                
                  <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">批评</td>
                    <td>初审查</td>
                    <td align="left" class="indent">已经正式提交的且审查处理的批评</td>
                    <td class="red3"><% out.print( ee_criticism );%></td>
                     <!--zyx-->
                    <%
                    if ( ee_criticism == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=3&examination=5&isdbtshenhe=1&iscs=1&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>交办</i>的批评:<i><% out.print( bb_criticism_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( bb_criticism_submit + cc_criticism_unsubmit );%></td>
                     <!--zyx-->
                    <%
                    if ( bb_criticism_submit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=3&examination=2&draft=2&isdbtshenhe=1">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不交办</i>的批评:<i><% out.print( cc_criticism_unsubmit );%></i></td>
                     <!--zyx-->
                    <%
                    if ( cc_criticism_unsubmit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=3&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
<!--                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>撤案</i>的议案:<i><% out.print(cc);%></i></td>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=3&examination=3&draft=2">查看</a></td>
                </tr>-->
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有批评</td>
                    <td class="red3"><% out.print( ee_criticism +  bb_criticism_submit +  cc_criticism_unsubmit);%></td>
                     <!--zyx-->
                    <%
                    if ( ee_criticism +  bb_criticism_submit +  cc_criticism_unsubmit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=3&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                
                
               
                  <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">意见</td>
                    <td>初审查</td>
                    <td align="left" class="indent">已经正式提交且审查处理的意见</td>
                    <td class="red3"><% out.print( ee_opinion );%></td>
                     <!--zyx-->
                    <%
                    if ( ee_opinion == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=4&examination=5&isdbtshenhe=1&iscs=1&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>交办</i>的意见:<i><% out.print( bb_opinion_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( bb_opinion_submit + cc_opinion_unsubmit );%></td>
                     <!--zyx-->
                    <%
                    if ( bb_opinion_submit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=4&examination=2&draft=2&isdbtshenhe=1">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不交办</i>的意见:<i><% out.print( cc_opinion_unsubmit);%></i></td>
                     <!--zyx-->
                    <%
                    if ( cc_opinion_unsubmit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=2&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
<!--                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>撤案</i>的意见:<i><% out.print(cc);%></i></td>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=4&examination=3&draft=2">查看</a></td>
                </tr>-->
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有意见</td>
                    <td class="red3"><% out.print( ee_opinion +  bb_opinion_submit +  cc_opinion_unsubmit);%></td>
                     <!--zyx-->
                    <%
                    if ( ee_opinion +  bb_opinion_submit +  cc_opinion_unsubmit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=4&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                
                
                  <tr id="divide" class="dce"></tr>
                <tr>
                    <td rowspan="4">质询</td>
                    <td>初审查</td>
                    <td align="left" class="indent">已经正式提交且审查处理的质询</td>
                    <td class="red3"><% out.print( ee_inquery );%></td>
                     <!--zyx-->
                    <%
                    if ( ee_inquery == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=5&examination=5&isdbtshenhe=1&iscs=1&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td rowspan="2">已审查</td>
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>交办</i>的质询:<i><% out.print( bb_inquery_submit );%></i></td>
                    <td class="red3" rowspan="2"><% out.print( bb_inquery_submit + cc_inquery_unsubmit );%></td>
                     <!--zyx-->
                    <%
                    if ( bb_inquery_submit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=5&examination=2&draft=2&isdbtshenhe=1">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
                <tr align="center">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>不交办</i>的质询:<i><% out.print( cc_inquery_unsubmit);%></i></td>
                     <!--zyx-->
                    <%
                    if ( cc_inquery_unsubmit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;" ><a href="list_2.jsp?lwstate=5&isdbtshenhe=1&examination=3&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
                </tr>
<!--                <tr align="center" style="display: none;">
                    <td align="left" class="w300 indent"><%out.print(strXzfb);%><i>撤案</i>的质询:<i><% out.print(cc);%></i></td>
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=5&examination=3&draft=2">查看</a></td>
                </tr>-->
                <tr align="center">
                    <td>总计</td>
                    <td align="left" class="w300 indent">所有质询</td>
                    <td class="red3"><% out.print( ee_inquery +  bb_inquery_submit +  cc_inquery_unsubmit);%></td>
                     <!--zyx-->
                    <%
                    if ( ee_inquery +  bb_inquery_submit +  cc_inquery_unsubmit == 0 ){
                    %>
                    <td>查看</td>
                    <%
                    }else{
                    %>
                    <!--zyx end-->
                    <td style="font-weight:bold;"><a href="list_2.jsp?lwstate=5&draft=2">查看</a></td>
                    <!--zyx--> 
                    <%
                    };
                    %>
                    <!--zyx end-->
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