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
    
    RssList entity = new RssList(pageContext, "supervision_dismissal");
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
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">撤职案的审议和决定</td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
<!--                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>
                      -->
                    
                    <tr>
                        <td class="w100 dce" >撤职案发起者</td>
                        <td colspan="5"><% 
                            
                            if ( entity.get("initiator").equals("1") ) {
                                    out.print("人民政府");
                                }
                            
                              else if ( entity.get("initiator").equals("2") ) {
                                    out.print( "监察委");
                                }
                                else if ( entity.get("initiator").equals("3") ) {
                                    out.print( "检察院");
                                }
                                else if ( entity.get("initiator").equals("4") ) {
                                    out.print( "法院");
                                }
                                else if ( entity.get("initiator").equals("5") ) {
                                    out.print( "主任会议" );
                                }
                            else if ( entity.get("initiator").equals("6") ) {
                                    out.print( "常委会成员联名" );
                                }
                        %></td>
                       
                    </tr>
                    
                   <tr>
<!--                        <td class="w100 dce">类别</td>-->
                        <!--<td><% entity.write("reviewclass"); %></td>-->                    
                       <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                        <td class="w250"  rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>


                        <td class="w100 dce" >当前进度</td>
                        <td colspan="2" >
                            <% 
                            if ( entity.get("state").equals("1") ) {
                                if ( entity.get("initiator").equals("6")) {
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                                }
                                else {
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >待常委会议审议</b>" );     
                                }
                            }
                            else if ( entity.get("state").equals("2") )
                            out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议中</b>" ); 
                            else if ( entity.get("state").equals("3") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >撤职案主任会审议不通过</b>" );
                            else if ( entity.get("state").equals("4") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议结束</b>" );
                             else if ( entity.get("state").equals("5") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >撤职案常委会审议不通过</b>" );
                             else if ( entity.get("state").equals("6") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >意见征求已通过</b>" );
                            else if ( entity.get("state").equals("7") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >意见已反馈</b>" );
                             else if ( entity.get("state").equals("8") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >待常委会审议</b>" );
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
                    
                    <%
                        if ( entity.get("initiator").equals("6") ){
                    %>
                    <tr>  
                        <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会时间</td>
                        <td rssdate="<% entity.write("directorshijian"); %>,yyyy-MM-dd" ></td>
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会议届次</td>
                        <td><% entity.write("directormeetingnum"); %></td>
                    </tr>
                    <%
                    }
                    %>
                    
                    
                    <%
                    if ( state > 1 && state != 3 ) {
                    %>
                    <tr>
                        <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">常委会议时间</td>
                        <td rssdate="<% entity.write("committeeshijian"); %>,yyyy-MM-dd"></td>
                    
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">常委会议届次</td>
                        <td><% entity.write("committeemeetingnum"); %></td>
                    </tr>
                    <%
                    }
                    %>
                    
                    <tr>
                        <td class="dce w120 ">撤职文件</td>
                        <td colspan="5" >
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
                if ( state == 2 || state == 3 || state == 4 ) {
                    if ( entity.get("initiator").equals("6") ) {
                    int idx0 = 0 ;
                    boolean isEmpty = true ;
                    String[] arry0 = {"", "", ""};
                    if (!entity.get("enclosure1").isEmpty()) {
                        String[] str1 = entity.get("enclosure1").split(",");
                        for (  idx0 = 0; idx0 < str1.length; idx0 ++) {
                            arry0[idx0] = str1[idx0 ];
                            isEmpty = false; 
                        }
                    }
                if ( !isEmpty ) {
                %>
                    <tr>
                    <td class="dce w100 ">主任会审议意见</td>
                    <td colspan="5">
                        <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename1"); %>"/><a href="/upfile/<% out.print(arry0[ idx0 ]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                   
                    </td>
                    </tr>   
                <%
                }
                }
                else{
                %>
                
                <tr>
                   <td class="dce w100 ">常委会审议意见</td>
                   <td colspan="5">
                       <%
                           String[] arry = {"", "", ""};
                           if (!entity.get("enclosure2").isEmpty()) {
                               String[] str1 = entity.get("enclosure2").split(",");
                               for (int idx = 0; idx < str1.length; idx++) {
                                   arry[idx] = str1[idx];
                       %>
                       <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename2"); %>"/><a href="/upfile/<% out.print(arry[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                       <%
                            }
                        }
                       %>
                   </td>
                </tr>
                
                <% 
                 }
                }
                %>

            </tr>
            
       
            <%
            if ( state >=4 ) {
                int idx = 0 ;
                String[] arry = {"", "", ""};
                boolean isEmpty = true;
                if (!entity.get("enclosure2").isEmpty()) {
                    String[] str1 = entity.get("enclosure2").split(",");
                    for ( idx = 0; idx < str1.length; idx++ ) {
                        arry[idx] = str1[idx];
                        isEmpty = false;
                    }
            }
            if ( !isEmpty ) {
            %>    

         
            <tr>
              <td class="dce w100 ">常委会审议意见</td>
              <td colspan="5">
              <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename2"); %>"/><a href="/upfile/<% out.print(arry[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>  
              </td>
           </tr>
            <%
            }
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