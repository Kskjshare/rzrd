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
    
    RssList entity = new RssList(pageContext, "supervision_finance");
    //RssListView entityView = new RssListView(pageContext, "supervision_topic");
    entity.request();
    //entityView.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entityView.select().where("id=?", req.get("id")).get_first_rows();
    
    
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    
    String title = "听取国民经济和社会发展计划、财政预算执行及审计工作流程";
    
    int state = 0 ;
    if ( !entity.get("state").isEmpty() ) {
        state = Integer.valueOf( entity.get("state") ).intValue(); 
    }
    

    RssListView user = new RssListView(pageContext, "user_delegation");
    //RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + entity.get("initiator")).get_first_rows();
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
                      
<!--                    <tr>
                        <td class="w100 dce">通知消息</td>                    
                         <td colspan="5" style="font-size:14px;font-family: 微软雅黑;"><% out.print(entity.get("notice")); %></td>
                    </tr>-->
                  
                 
                    <tr>
                        <td class="w100 dce" >发起者</td>
                        <td colspan="5"><% 

                          out.print(user.get("realname"));
                        
                        %></td>                
                    </tr>
                   
    
                   <tr>                   
                       <td class="w100 dce" style="font-size:14px;font-family: 微软雅黑;"class="w100 dce">发起时间</td>
                       <td class="w250"  rssdate="<% entity.write("shijian"); %>,yyyy-MM-dd" ></td>
                       <td class="w100 dce" >当前进度</td>
                       <td colspan="2" >
                          <% 
                          if ( entity.get("state").equals("1") ) {
                                out.print( "<b style='color:CadetBlue;font-size:14px;' >通知已发</b>" ); 
                            }
                            else if ( entity.get("state").equals("2") )
                            out.print( "<b style='color:DarkOrange;font-size:14px;' >调研结束</b>" ); 
                            else if ( entity.get("state").equals("3") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议中</b>" );
                            else if ( entity.get("state").equals("4") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >组织调研</b>" );
                            else if ( entity.get("state").equals("5") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >专题询问方案被主任会议驳回</b>" );   
                            else if ( entity.get("state").equals("6") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >总询问问题提纲准备中</b>" );   
                            else if ( entity.get("state").equals("7") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >待主任会议审议总询问问题提纲</b>" );   
                            else if ( entity.get("state").equals("10") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >常委会审议意见办理中</b>" );   
                            else if ( entity.get("state").equals("11") )
                            out.print( "<b style='color:CadetBlue;font-size:14px;' >已完结</b>" );   
                            %>
                        </td>                                        
                    </tr>
             
            <%
                int items = 0 ;
                String titlestr[] = new String[10];
                String prefpath[] = new String[10];
                String prefname[] = new String[10];
                if ( entity.get("investigationDepartment").equals("1") ) {
                    items = 6 ;
                    titlestr[0] ="报告草案";
                    titlestr[1] ="计划依据";
                    titlestr[2] ="计划目标";
                    titlestr[3] ="项目明细";
                    titlestr[4] ="其他需要说明的情况";
                    titlestr[5] ="其他资料";
                    titlestr[6] ="报告草案";                   
                }
                else if ( entity.get("investigationDepartment").equals("2") ) {
                    items = 4 ;
                    titlestr[0] ="报告草案";
                    titlestr[1] ="计划依据";
                    titlestr[2] ="计划目标";
                    titlestr[3] ="项目明细";
                   
                }
                else if ( entity.get("investigationDepartment").equals("3") ) {
                    items = 10 ;
                    titlestr[0] ="年度决算草案";
                    titlestr[1] ="重点项目决算收支表";
                    titlestr[2] ="单位收支决算表";
                    titlestr[3] ="基金收支决算表";
                    titlestr[4] ="补助下级支出情况说明";
                    titlestr[5] ="基本建设资金支出表";
                    titlestr[6] ="国债资金使用情况表";
                    titlestr[7] ="有关决算的相关说明材料";
                    titlestr[8] ="财政法律法规情况";
                    titlestr[9] ="其他资料";
                   
                }
                else if ( entity.get("investigationDepartment").equals("4") ) {
                    items = 5 ;
                    titlestr[0] ="财政收支情况的审计报告";
                    titlestr[1] ="项目基本情况统计表";
                    titlestr[2] ="违法违规资金统计表";
                    titlestr[3] ="审计报告";
                    titlestr[4] ="其他资料";
                   
                }
                else if ( entity.get("investigationDepartment").equals("5") ) {
                    items = 5 ;
                    titlestr[0] ="税收计划执行情况";
                    titlestr[1] ="分阶段的税收收入情况";
                    titlestr[2] ="税收情况报表和材料";
                    titlestr[3] ="侦查和打击违法犯罪等情况";
                    titlestr[4] ="其他资料";
                   
                }
                else if ( entity.get("investigationDepartment").equals("6") ) {
                    items = 2 ;
                    titlestr[0] ="发展指标有关资料";
                    titlestr[1] ="其他资料";                   
                }
            
           
            int i = 1 ;
            for ( int ii = 0 ; ii< items ; ii ++ ) {
                 prefpath[ ii ] = "finance_enclosure" + i ;
                 prefname[ ii ] = "finance_enclosurename" + i ;
                 i ++ ;
            %>
             <tr>
                <td class="dce" style="width:160px;font-size:15px;font-family: 微软雅黑"><%out.print(titlestr[ ii ]);%></td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry0 = {"", "", ""};
                     if (!entity.get( prefpath[ii]  ).isEmpty()) {
                         String[] str1 = entity.get( prefpath[ii]  ).split(",");
                         for (int idx = 0; idx < str1.length; idx++) {
                             arry0[idx] = str1[idx];
                 %>
                 <%  entity.write( prefname[ii] ); %><a href="/upfile/<% out.print( arry0[idx] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr>
            <%
            }
            %>  
           
                

       
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

          
            
            <%
            if (!entity.get("enclosure1").isEmpty()) {
            %>
            <tr>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会审议意见</td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry1 = {"", "", ""};
                     if (!entity.get("enclosure1").isEmpty()) {
                         String[] str1 = entity.get("enclosure1").split(",");
                         for (int idx1 = 0; idx1 < str1.length; idx1 ++ ) {
                             arry1[ idx1 ] = str1[ idx1 ];
                 %>
                 <%  entity.write("enclosurename1"); %><a href="/upfile/<% out.print( arry1[ idx1 ] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
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
            
            
            
            <!----调研报告--->     
            <%
            if (!entity.get("investigationenclosure").isEmpty()) {
            %>
            <tr>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">调研报告</td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry1 = {"", "", ""};
                     if (!entity.get("investigationenclosure").isEmpty()) {
                         String[] str1 = entity.get("investigationenclosure").split(",");
                         for (int idx1 = 0; idx1 < str1.length; idx1 ++ ) {
                             arry1[ idx1 ] = str1[ idx1 ];
                 %>
                 <%  entity.write("investigationenclosurename"); %><a href="/upfile/<% out.print( arry1[ idx1 ] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr> 
            <%
            }
            %>
            
            
         
            
            <!----总询问问题提纲--->     
            <%
            if (!entity.get("summaryenclosure").isEmpty()) {
            %>
            <tr>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">总询问问题提纲</td>
                <td style="font-weight:bold;" colspan="5">
                 <%
                     String[] arry1 = {"", "", ""};
                     if (!entity.get("summaryenclosure").isEmpty()) {
                         String[] str1 = entity.get("summaryenclosure").split(",");
                         for (int idx1 = 0; idx1 < str1.length; idx1 ++ ) {
                             arry1[ idx1 ] = str1[ idx1 ];
                 %>
                 <%  entity.write("summaryenclosurename"); %><a href="/upfile/<% out.print( arry1[ idx1 ] );%>" style="cursor: pointer;color:blue;font-weight: bold;font-size: 15px;float:right;margin-right:10%;">点击查看</a>
                 </td>
                 <%
                   }
                 }
                 %>
            </tr> 
            <%
            }
            %>
            
             <% 
            if ( state > 6 ) {
            %>
            <tr>
            <td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">专题询问方案的主任会议信息</td></tr>
            <tr>  
                <td class="w120 dce" style="font-size:15px;font-family: 微软雅黑;"class="w100 dce">主任会时间</td>
                <td rssdate="<% entity.write("directormeetingshijian2"); %>,yyyy-MM-dd" ></td>
                <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会议届次</td>
                <td><% entity.write("directormeetingnum2"); %></td>
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