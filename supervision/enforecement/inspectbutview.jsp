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
    
    RssList entity = new RssList(pageContext, "supervision_enforcement");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //RssListView entityView = new RssListView(pageContext, "supervision_enforcement");
    //entityView.request();
   
    //entityView.select().where("id=?", req.get("id")).get_first_rows();
     

    //参与单位
     RssListView list = new RssListView(pageContext, "user_delegation");
     list.request();
    //int a = 1;
    //list.pagesize = 30;
    //list.select().where("state=3 and (company like '%" + list.get("searchkey") + "%' or danweiCode like '%" + list.get("searchkey") + "%' or realname like '%" + list.get("searchkey") + "%')").get_page_desc("myid");

  
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
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">执法检查信息</td></tr>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;">标题</td>
                        <td colspan="5" style="font-size:15px;font-family: 微软雅黑;"><% out.print(entity.get("title")); %></td>
                    </tr>
                      
                    <tr>
                        <td class="w100 dce">当前进程</td>
                        <td>
                            <% 
                                if ( entity.get("state").equals("1") ) {
                                    if ( entity.get("leaderpreview").equals("1") ) { //需要预审
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待审阅</b>" );
                                    }
                                    else 
                                    {
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" ); 
                                    }
                                }
                                else if ( entity.get("state").equals("2") ) {
                                    
                                    if ( entity.get("leaderpreview").equals("1") ) 
                                    { //需要预审
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议</b>" );
                                    }else {
                                       out.print( "<b style='color:DarkOrange;font-size:14px;' >主任会议审议中</b>" ); 
                                    }
                                    
                                }
                                else if ( entity.get("state").equals("3") ) {
                                    
                                     if ( entity.get("leaderpreview").equals("1") )  {//需要预审
                                   
                                        out.print( "<b style='color:DarkOrange;font-size:14px;' >主任会审议检查方案中</b>" ); 
                                    }
                                    else 
                                    {
                                        out.print( "<b style='color:DarkOrange;font-size:14px;' >待出执法工作报告</b>" );
                                     }  
                                   
                                }
                                else if ( entity.get("state").equals("4") ) {
                                     if ( entity.get("leaderpreview").equals("1") )  {//需要预审
                                        out.print( "<b style='color:DarkOrange;font-size:14px;' >待出执法工作报告</b>" ); 
                                    }else {
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >执法检查中</b>" );
                                    }     
                                 
                                }
                                else if ( entity.get("state").equals("5") ) {
                                   if ( entity.get("needsubmitmeeting").equals("2") )  {//需要预审
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >不需要提交主任会议</b>" );
                                    }else {
                                        out.print( "<b style='color:CadetBlue;font-size:14px;' >已提交执法工作报告,待出执法报告</b>" );
                                    }
                                   
                                   
                                }
                                else if ( entity.get("state").equals("6") ) {
                                   
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >主任会审议执法检查报告中</b>" );
                                   
                                }
                                else if ( entity.get("state").equals("7") ) {
                                   
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议执法检查报告中</b>" );
                                   
                                }
                                 else if ( entity.get("state").equals("10") ) {
                                   
                                    out.print( "<b style='color:CadetBlue;font-size:14px;' >满意度测评中</b>" );
                                   
                                }
                                else {
                                     out.print( "<b style='color:CadetBlue;font-size:14px;' >执法检查已完成</b>" );
                                }
                            %>
                        </td>
                         <td colspan="2" class="w120 dce">方案制定单位</td><td><% out.print(entity.get("initiator")); %></td>
                    </tr>
                    <tr>
                        <td class="w120 dce">执法检查类别</td><td><% entity.write("reviewclass");out.print(list.get("leaderpreview")); %></td>
                        <td colspan="2" class="w100 dce">执法检查地点</td><td><% entity.write("place"); %></td>
                    </tr>
                    
                     <%
                    if ( !entity.get("company").isEmpty() ) {
                    %> 
                    <tr><td class="w100 dce">参加单位</td>
                        <td colspan="5" ><% 
                              String company = entity.get("company");
                              String comarray[] = company.split(",");
                              int counter1 =  0;
                              if ( !entity.get("company").isEmpty()) {
                              for ( int i = 0 ; i < comarray.length; i ++ ) {
                                  if ( counter1 > 0 ){
                                    out.print("     ");
                                    out.print(",");
                                    out.print("     ");
                                  }
                                  list.select().where("state=3 and myid="+ comarray[i] ).get_first_rows();
                                  out.print(list.get("company"));
                                 
                                  counter1 ++ ;
                              }
                              }
                           %>&nbsp;</td>                   
                    </tr>
                       <%
                   }
                    %>
                    
                    <%
                    if ( !entity.get("committeeobjid").isEmpty() ) {
                    %>
                    <tr><td class="w100 dce">常委会成员</td>
                        <td colspan="5" ><% 
                           // entity.write("committeeobjid"); 
                            String committeeobjid = entity.get("committeeobjid");
                            String committeeobjids[] = committeeobjid.split(",");
                            int objects = 0 ;
                            for ( int i = 0 ; i < committeeobjids.length; i ++ ) {
                                  if ( objects > 0 ){
                                     out.print("     ");
                                    out.print(",");
                                    out.print("     ");
                                  }
                                  list.select().where("state=2 and myid="+ committeeobjids[i] ).get_first_rows();
                                  out.print(list.get("realname"));
                                  objects ++ ;
                                  
                              }
                        %></td>                   
                    </tr>
                      <%
                   }
                    %>
                    
                    <%
                    if ( !entity.get("objid").isEmpty() ) {
                    %>
                    <tr><td class="w100 dce">人大代表</td>
                        <td colspan="5" ><% 
                           // entity.write("objid"); 
                            String objid = entity.get("objid");
                            String objids[] = objid.split(",");
                            int counter = 0 ;
                            for ( int i = 0 ; i < objids.length; i ++ ) {
                                  if ( counter > 0 ){
                                     out.print("     ");
                                    out.print(",");
                                    out.print("     ");
                                  }
                                  list.select().where("state=2 and myid="+ objids[i] ).get_first_rows();
                                  out.print(list.get("realname"));
                                  counter ++ ;
                                  
                              }
                        %></td>                   
                    </tr>
                    <%
                   }
                    %>
                    
                    <!--tr><td style="font-size:16px;font-family: 微软雅黑;"class="w100 dce">制定方案时间:</td><td rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd hh-mm-ss" ></td></tr-->
                    <tr>
                        <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">制定方案时间</td>
                        <td colspan="2" rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                        
                        <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w120 dce">执法检查时间</td>
                        <td colspan="2" rssdate="<% entity.write("inspecttime"); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                    <%
                   
                    int state_int = Integer.valueOf( entity.get("state") ).intValue(); 
                    
                    if ( state_int > 2 ) {
                    %>
                    <tr>
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会议时间</td>
                        <td colspan="2" rssdate="<% entity.write("meetingshijian"); %>,yyyy-MM-dd" ></td>
                        
                        <td class="w100 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会议届次</td>                      
                        <td colspan="2"><% entity.write("directormeetingnum"); %></td>
                    </tr>
                    <%
                   }
                    %>
                    
                    <tr>
                        <td class="dce w100 ">执法检查方案</td>
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
                   if (!entity.get("workreportenclosure").isEmpty()) {
                  %>
                    <tr>
                        <td class="dce w100 ">执法工作报告</td>
                        <td colspan="5">
                            <%
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("workreportenclosure").isEmpty()) {
                                    String[] str1 = entity.get("workreportenclosure").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry2[idx] = str1[idx];
                            %>
                            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("workreportenclosurename"); %>"/><a href="/upfile/<% out.print(arry2[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
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
                        String  progress = ( entity.get("state")) ;
                        int i = Integer.valueOf(progress).intValue(); 
                        if ( i >= 2 ){ 
                    %>
                  <%
                   if (!entity.get("Reportenclosure").isEmpty()) {
                  %>
                    <tr>
                        <td class="dce w100 ">执法检查报告</td>
                        <td colspan="5">
                            <%
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("Reportenclosure").isEmpty()) {
                                    String[] str1 = entity.get("Reportenclosure").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry2[idx] = str1[idx];
                            %>
                            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("Reportenclosurename"); %>"/><a href="/upfile/<% out.print(arry2[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    </tr>
                    
                    
                     <tr>
                        <td class="dce w100 ">交办意见</td>
                        <td colspan="5">
                            <%
                                String[] arry3 = {"", "", ""};
                                if (!entity.get("assignenclosure").isEmpty()) {
                                    String[] str1 = entity.get("assignenclosure").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry3[idx] = str1[idx];
                            %>
                            <input style="font-size:15px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("assignenclosurename"); %>"/><a href="/upfile/<% out.print(arry3[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
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
                     }
                    %>
             
                    
            <% 
                String  state = ( entity.get("state")) ;
                int stateindex = Integer.valueOf(state).intValue(); 
                String organizationid = entity.get("organizationid");
                if ( stateindex >= 3 && !organizationid.isEmpty() ){              
            %>        
            <tr><td class="w100 dce">主办单位</td>
                <td colspan="5" ><% 
                     
                      String[] organizationids = organizationid.split(",");
                      int cnt = 0 ;
                      
                    
                      for ( int ii = 0 ; ii < organizationids.length; ii ++ ) {
                          if ( cnt > 0 ){
                            out.print("     ");
                            out.print(",");
                            out.print("     ");
                          }
                          list.select().where("state=3 and myid="+ organizationids[ii] ).get_first_rows();
                          out.print(list.get("company"));                        
                          cnt ++ ;
                      }
                   %>&nbsp;</td>                   
            </tr>        
                    
            <% 
             }   
            %>
           
              <% 
                String  state1 = ( entity.get("state")) ;
                int e = Integer.valueOf(state1).intValue();
                String enclosure = entity.get("handleReportenclosure");
                if ( e >= 4 && !enclosure.isEmpty() ){              
            %>      
            <tr>
                        <td class="dce w100 ">办理报告</td>
                        <td colspan="5">
                            <%
                                String[] arry3 = {"", "", ""};
                                if (!entity.get("handleReportenclosure").isEmpty()) {
                                    String[] str1 = entity.get("handleReportenclosure").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry3[idx] = str1[idx];
                            %>
                            <input style="font-size:14px;font-weight: bold;line-height:34px; " readonly="true" class="xz" value="<%  entity.write("handleReportenclosurename"); %>"/><a href="/upfile/<% out.print(arry3[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击查看</a>
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