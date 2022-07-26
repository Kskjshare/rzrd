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
    
    RssList entity = new RssList(pageContext, "supervision_specific_issue");
    //RssListView entityView = new RssListView(pageContext, "supervision_topic");
    entity.request();
    //entityView.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entityView.select().where("id=?", req.get("id")).get_first_rows();
    
    
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    String title = "特定问题调查";
    if ( entity.get("state").equals("1") ||   entity.get("state").equals("2")||  entity.get("state").equals("3") ||  entity.get("state").equals("5")){
        title = "审议成立特定问题调查委员会";
    }
    
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
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader"><%out.print(title);%></td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>
                  
                    <%
                    if ( entity.get("initiator").equals("1") || entity.get("initiator").equals("2"))  {      
                    %> 
                    <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="5"><% 

                            if ( entity.get("initiator").equals("1") ) {
                                    out.print("人民政府");
                            }
                            
                            else if ( entity.get("initiator").equals("2") ) {
                                out.print( "主任会议");
                            }
                            else if ( entity.get("initiator").equals("3") ) {
                               out.print( "常委会成员联名");
                            }
                        
                        %></td>                
                    </tr>
                    <%
                    }else{
                    %>
                     <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="5"><% 

                            if ( entity.get("initiator").equals("1") ) {
                                    out.print("人民政府");
                            }
                            
                            else if ( entity.get("initiator").equals("2") ) {
                                out.print( "主任会议");
                            }
                            else if ( entity.get("initiator").equals("3") ) {
                               out.print( "常委会成员联名");
                            }
                        
                        %></td>
                     </tr>
                     <%
                     };
                     %>

                     
                <%
                 if ( entity.get("initiator").equals("3") ) {      
                 %>          
                 <tr>
                 <td class="w120 dce" >常委会联名成员</td>
                 <td colspan="5"><% 
                     String[] cocommittees = entity.get("cocommittee").split(",");
                     int objects = 0 ;
                     for ( int i = 0 ; i < cocommittees.length; i ++ ) {
                           if ( objects > 0 ){
                              out.print("     ");
                             out.print(",");
                             out.print("     ");
                           }
                           list.select().where("state=2 and myid="+ cocommittees[i] ).get_first_rows();
                           out.print(list.get("realname"));
                           objects ++ ;

                       }
                     %></td>
                    <%
                    }
                    %>   
                   </tr>
                    
                   <tr>                   
                       <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                       <td class="w250"  rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                       <td class="w100 dce" >当前进度</td>
                       <td colspan="2" >
                          <% 
                          if ( entity.get("state").equals("1") ) {
                            if ( entity.get("initiator").equals("3")) {
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                             }
                             else {
                                 out.print( "<b style='color:CadetBlue;font-size:14px;' >待常委会议审议</b>" );     
                             }
                            }
                            else if ( entity.get("state").equals("2") ){
                            out.print( "<b style='color:DarkOrange;font-size:14px;' >常委会审议中</b>" ); 
                            }else if ( entity.get("state").equals("3") ){
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >成立特定问题调查委员会被主任会驳回</b>" );
                            }else if ( entity.get("state").equals("4") ){
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会同意成立特定问题调查委员会</b>" );
                            }else if ( entity.get("state").equals("5") ){
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >成立特定问题调查委员会被常委会驳回</b>" ); 
                            } else if ( entity.get("state").equals("8") ){
                                 //不需要满意度测评
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会听取审议调查报告结束</b>" );
                            }else if ( entity.get("state").equals("9") ){
                                if( entity.get("evaluationSwitch").equals("1")){
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >满意度测评中</b>" ); 
                                }else{
                                   out.print( "<b style='color:CadetBlue;font-size:14px;' >特定问题调查已完结</b>" ); 
                                }
                            }
                                  
                            %>
                        </td>                                        
                    </tr>
                    
                    <%
                    if ( entity.get("initiator").equals("3") ){
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
                        <td class="dce w120 ">成立委员会文件</td>
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
                if ( state == 1000  ) { // //原来的条件state == 2 || state == 3 || state == 4 ，为了不显示，我把他改为 1000
                    if ( entity.get("initiator").equals("3") ) {
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
            if ( state >= 1000 ) { //原来的条件 state >=4 ，为了不显示，我把他改为1000
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

            <!----主任会议--->
            <%
            String[] namearry = {"", "", ""};
            boolean isShow = false ;
            int idx = 0 ;
            if (!entity.get("enclosure1").isEmpty()) {
                String[] str1 = entity.get("enclosure1").split(",");
                for (  idx = 0; idx < str1.length; idx++) {
                    namearry[ idx ] = str1[ idx ];
                    isShow = true ;
                }
            }
            if ( isShow ) {
            %>        
            <tr>
                <td class="dce w120 ">主任会审议意见</td>
                <td colspan="5" > 
                <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename1"); %>"/><a href="/upfile/<% out.print(namearry[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>                   
                </td>
            </tr>    
            <%
            }
            %>   

            
            <!----常委会议--->
            <%
            String[] namearry2 = {"", "", ""};
            boolean isShow2 = false ;
            int idx2 = 0 ;
            if (!entity.get("enclosure2").isEmpty()) {
                String[] str1 = entity.get("enclosure2").split(",");
                for (  idx2 = 0; idx2 < str1.length; idx2 ++) {
                    namearry2[ idx2 ] = str1[ idx2 ];
                    isShow2 = true ;
                }
            }
            if ( isShow2 ) {
            %>        
            <tr>
                <td class="dce w120 ">主任会审议意见</td>
                <td colspan="5" > 
                <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("enclosurename2"); %>"/><a href="/upfile/<% out.print( namearry2[ idx2 ] ); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>                   
                </td>
            </tr>    
            <%
            }
            %>   
            
            
            
             <!----提供的材料--->
            <%
            String[] namearry3 = {"", "", ""};
            boolean isShow3 = false ;
            int idx3 = 0 ;
            if (!entity.get("providerenclosure").isEmpty()) {
                String[] str1 = entity.get("providerenclosure").split(",");
                for (  idx3 = 0; idx3 < str1.length; idx3 ++) {
                    namearry3[ idx3 ] = str1[ idx3 ];
                    isShow3 = true ;
                }
            }
            if ( isShow3 ) {
            %>        
            <tr>
                <td class="dce w120 ">材料文件</td>
                <td colspan="5" > 
                <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("providerenclosurename"); %>"/><a href="/upfile/<% out.print( namearry3[ idx3 ] ); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>                   
                </td>
            </tr>    
            <%
            }
            %>   
            
            
            
            <!----调查报告--->
            <%
            String[] namearry4 = {"", "", ""};
            boolean isShow4 = false ;
            int idx4 = 0 ;
            if (!entity.get("reportenclosure").isEmpty()) {
                String[] str1 = entity.get("reportenclosure").split(",");
                for (  idx4 = 0; idx4 < str1.length; idx4 ++) {
                    namearry4[ idx4 ] = str1[ idx4 ];
                    isShow4 = true ;
                }
            }
            if ( isShow4 ) {
            %>        
            <tr>
                <td class="dce w120 ">调查报告</td>
                <td colspan="5" > 
                <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("reportenclosurename"); %>"/><a href="/upfile/<% out.print( namearry4[ idx4 ] ); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>                   
                </td>
            </tr>    
            <%
            }
            %>   
            
            
             <!----调查报告--->
            <%
            String[] namearry5 = {"", "", ""};
            boolean isShow5 = false ;
            int idx5 = 0 ;
            String text = "决议文件";
            if (!entity.get("opinionenclosure").isEmpty()) {
                String[] str1 = entity.get("opinionenclosure").split(",");
                for (  idx5 = 0; idx5 < str1.length; idx5 ++) {
                    namearry5[ idx5 ] = str1[ idx5 ];
                    isShow5 = true ;
                }
                
                if ( entity.get("committeeopinion").equals("2") ) {
                    text = "决定文件";
                }
                
                
            }
            if ( isShow5 ) {
            %>        
            <tr>
                <td class="dce w120 "><%out.print(text);%></td>
                <td colspan="5" > 
                <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("opinionenclosurename"); %>"/><a href="/upfile/<% out.print( namearry5[ idx5 ] ); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>                   
                </td>
            </tr>    
            <%
            }
            %>   
                    
                    
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