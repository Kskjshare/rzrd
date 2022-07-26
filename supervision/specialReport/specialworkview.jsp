<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>


<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookie = new CookieHelper(request, response);
    
    RssList entity = new RssList(pageContext, "supervision_specialwork");
    //RssListView entityView = new RssListView(pageContext, "supervision_topic");
    entity.request();
    //entityView.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entityView.select().where("id=?", req.get("id")).get_first_rows();
    
    int state = 0 ;
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor td img{width: 100%}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{min-height: 100px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .popupwrap>div:first-child{height: 100%;}
            td>h1{text-align: center;margin:0;}
            .xz{width: 70%;border: 0px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">听取和审议专项工作报告</td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>
                      
                    
                    <tr>
                        <td class="w100 dce">方案制定人</td>
                        <td><% out.print(entity.get("initiator")); %></td>
                        <td class="w100 dce" >当前进度</td>
                        <td colspan="2" >
                            <% 
                            if ( entity.get("state").equals("1") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                            else if ( entity.get("state").equals("2") )
                            out.print( "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>" ); 
                            else if ( entity.get("state").equals("3") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >方案实施中</b>" );
                            else if ( entity.get("state").equals("4") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >专项报告准备中</b>" );
                             else if ( entity.get("state").equals("5") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                             else if ( entity.get("state").equals("6") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >意见征求已通过</b>" );
                            else if ( entity.get("state").equals("7") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >意见已反馈</b>" );
                             else if ( entity.get("state").equals("8") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议中</b>" );
                             else if ( entity.get("state").equals("9") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议意见处理中</b>" );
                            else if ( entity.get("state").equals("10") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见中</b>" );
                            else if ( entity.get("state").equals("11") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >征求意见已通过</b>" );
                            else if ( entity.get("state").equals("12") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >已反馈意见</b>" );
                            else if ( entity.get("state").equals("13") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >已向常委会提出书面报告</b>" );
                            %>
                        </td>                                        
                    </tr>
                    
                    <tr>
                        <td class="w100 dce">类别</td>
                        <td><% entity.write("reviewclass"); %></td>                    
                       <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">制定方案时间</td>
                        <td class="w250"  rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                    <tr>  
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会时间</td>
                        <td rssdate="<% entity.write("directorshijian"); %>,yyyy-MM-dd" ></td>
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会议届次</td>
                        <td><% entity.write("directormeetingnum"); %></td>
                    </tr>
                    
                    
                    <%
                    if ( state >= 8 ) {
                    %>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">常委会议时间</td>
                        <td rssdate="<% entity.write("committeshijian"); %>,yyyy-MM-dd"></td>
                    
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">常委会议届次</td>
                        <td><% entity.write("committemeetingnum"); %></td>
                    </tr>
                    <%
                    }
                    %>
                    
                    <tr>
                        <td class="dce w100 ">实施方案</td>
                        <td colspan="5">
                            <%
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                            %>
                            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename"); %>"/><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                   
                    </tr> 
                    <% 
                    if ( state >= 2 ) {
                    %>
                    <tr>
                        <td class="dce w100 ">视察调研报告</td>
                        <td colspan="5">
                            <%
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure1").isEmpty()) {
                                    String[] str1 = entity.get("enclosure1").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry2[idx] = str1[idx];
                            %>
                            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename1"); %>"/><a href="/upfile/<% out.print(arry2[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    <% 
                     }
                    %>
                 </tr>    
                    
                     <%                    
                    if ( state >= 4 ) {
                    %>
                     <tr>
                        <td class="dce w100 ">专项报告</td>
                        <td colspan="5">
                            <%
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure2").isEmpty()) {
                                    String[] str1 = entity.get("enclosure2").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry2[idx] = str1[idx];
                            %>
                            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename2"); %>"/><a href="/upfile/<% out.print(arry2[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                        
                     </tr>       
                <%
                if ( state >= 7  && !entity.get("enclosure3").isEmpty() ) { //反馈的意见
                %>   
                <tr>
                     <td class="w120 dce">反馈意见</td>
                     <td colspan="5">
                         <%
                             String[] arry3 = {"", "", ""};
                             if ( !entity.get("enclosure3").isEmpty() ) {
                                 String[] str1 = entity.get("enclosure3").split(",");
                                 for (int idx = 0; idx < str1.length; idx++) {
                                     arry3[idx] = str1[idx];
                         %>
                         <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename3"); %>"/><a href="/upfile/<% out.print(arry3[idx]);%>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                         <%
                                 }
                             }
                         %>
                     </td>
                <%
                }
                %>    
                        
                        
                    </tr>
                    <% 
                     }
                    %>
                    
                    
                    
 
                
            <%
             if ( state == 6  ) { //没有意见
            %>
            <tr>
                  <td class="w120 dce">反馈意见</td>
                  <td colspan="5">

                      <%  out.print("对于报告没有任何意见"); %>

                  </td>   
            <%
             }
            %>        
                 </tr>
                 <tr>
            <td class="w120 dce">常委会审议意见</td>
            <td colspan="5">
                <%
                    String[] arry2 = {"", "", ""};
                    if ( !entity.get("enclosurename4").isEmpty() ) {
                        String[] str1 = entity.get("enclosurename4").split(",");
                        for (int idx = 0; idx < str1.length; idx++) {
                            arry2[idx] = str1[idx];
                %>
                <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename4"); %>"/><a href="/upfile/<% out.print(arry2[idx]);%>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                <%
                        }
                    }
                %>
            </td>      
                 </tr>
                    
                    
            
            <%
           if ( state >= 10 ) {
            %>    
            
            <tr>
            <td class="w120 dce">最终专项报告</td>
            <td colspan="5">
            <%
                String[] arry5 = {"", "", ""};
                if ( !entity.get("enclosurename5").isEmpty() ) {
                    String[] str1 = entity.get("enclosurename5").split(",");
                    for (int idx = 0; idx < str1.length; idx++) {
                        arry5[idx] = str1[idx];
            %>
            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename5"); %>"/><a href="/upfile/<% out.print( arry5[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
            <%
                }
            }
            %>
            </td>   
            </tr>
            <%
            }
            %>
            
              <%
           if ( state >= 13 ) {
            %>    
            
        
             <tr>
            <td class="w120 dce">反馈意见</td>
            <td colspan="5">
            <%
                String[] arry6 = {"", "", ""};
                if ( !entity.get("enclosurename6").isEmpty() ) {
                    String[] str1 = entity.get("enclosurename6").split(",");
                    for (int idx = 0; idx < str1.length; idx++) {
                        arry6[idx] = str1[idx];
            %>
            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename6"); %>"/><a href="/upfile/<% out.print( arry6[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
            <%
                }
            }
            %>
            </td>          
             </tr>
             <tr>
            <td class="w120 dce">书面报告</td>
            <td colspan="5">
            <%
                String[] arry7 = {"", "", ""};
                if ( !entity.get("enclosurename7").isEmpty() ) {
                    String[] str1 = entity.get("enclosurename7").split(",");
                    for (int idx = 0; idx < str1.length; idx++) {
                        arry7[idx] = str1[idx];
            %>
            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename7"); %>"/><a href="/upfile/<% out.print( arry7[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
            <%
                }
            }
            %>
            </td>      
            </tr>    

            <%
            }
            %>
            
            
                    
                    
                    <!--<tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">办理进度</td></tr>-->

                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/nationality.js"></script>
        <script src="/data/session.js"></script>
        <script src="/data/dictdata.js"></script>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
            })
            if (<% entity.write("nationid"); %>) {
                $("#nationid").text(dictdata["nationid"][<% entity.write("nationid");%>][0])
            }

        </script>
    </body>
</html>