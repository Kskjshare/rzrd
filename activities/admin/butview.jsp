<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.*,java.text.*"%>

<%@page import="RssEasy.Core.CookieHelper"%>
<%
    int participate_person = 0 ;
    StaffList.IsLogin(request, response);
    
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    String currentperson = "0" ;
         
    //RssListView entity = new RssListView(pageContext, "activities"); //removed by ding
    RssListView entity = new RssListView(pageContext, "activitiesmy");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    
    RssListView userlist = new RssListView(pageContext, "activities_userlist");
   
    
    if ( cookie.Get("powergroupid").equals("5") ) {
       userlist.select().where("activitiesid= "+ entity.get("id") + " and userid="+ UserList.MyID(request)  ).get_first_rows();
    }
    else {
       userlist.select().where("activitiesid=?", entity.get("id")).get_first_rows();
    }
   
    
    RssList userlist1 = new RssList(pageContext, "activities_userlist");
    userlist1.request();
    userlist1.select().where("activitiesid="+ req.get("id") ).get_page_desc("id");
     //这里处理排除选工委（发起者），否则报名人数显示错误。但是不知大会不会引起问题。
    int mcurrentperson = 0 ;
    while (userlist1.for_in_rows()) {
        String enroll = userlist1.get("enroll"); 
        String myid = userlist1.get("myid"); 

        if ( enroll.equals( "1" ) && myid.equals("1429")) {
            
        }
        else {
            mcurrentperson ++ ;
        }
          
    }
    currentperson = mcurrentperson + "";
  
    
//    currentperson = userlist1.totalrows + "";
    //userlist.select().where("activitiesid="+ list.get("id") + " and userid="+ UserList.MyID(request) ).get_first_rows;
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
            .cellbor{border:1px}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border:1;line-height: 34px;position: relative;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                     <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动类型</td>
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td><% entity.write("department"); %></td>
                    </tr>
                    
                    <%
                    if (entity.get("enroll").equals("1") ){
                    %>
                    <tr>
                        <td class="dce w100 ">报名开始日期</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <%
                    }
                    %>
                    
                    
                    <%
                    if (entity.get("enroll").equals("2") ){
                    %>
                    <tr>
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce" style="width:110px;">结束时间</td>
                        <td rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <%
                    }
                    %>
                                       
                  
                    
                     <tr>
                        <td class="dce w100 ">活动状态</td>
                        <td>
                        <% 
                            
                           
                            //entity.write("place"); 
                            
                            long systemTime1 = System.currentTimeMillis();                                  
                            long beginshijian1 = Long.parseLong( entity.get("beginshijian") );
                            long finishshijian1 = Long.parseLong( entity.get("finishshijian") );
                            
                            Date nowTime = new Date(System.currentTimeMillis());
                            //SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
                            SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            String retStrFormatNowDate = sdFormatter.format(nowTime);
                            
                            String datasplit [] = retStrFormatNowDate.split("-");                 
                            int sysYear = Integer.valueOf( datasplit[0]).intValue();
                            int sysMonth = Integer.valueOf( datasplit[1]).intValue();
                            int sysDay = Integer.valueOf( datasplit[2]).intValue();
                           
                            nowTime = new Date(Long.parseLong( entity.get("beginshijian") )*1000);
                            sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            retStrFormatNowDate = sdFormatter.format(nowTime);
                            String datasplit1 [] = retStrFormatNowDate.split("-");          
                            int beginYear = Integer.valueOf( datasplit1[0]).intValue();
                            int beginMonth = Integer.valueOf( datasplit1[1]).intValue();
                            int beginDay = Integer.valueOf( datasplit1[2]).intValue();
                            
                            nowTime = new Date(Long.parseLong( entity.get("finishshijian") )*1000);
                            sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
                            retStrFormatNowDate = sdFormatter.format(nowTime);
                            String datasplit2 [] = retStrFormatNowDate.split("-");          
                            int finishYear = Integer.valueOf( datasplit2[0]).intValue();
                            int finishMonth = Integer.valueOf( datasplit2[1]).intValue();
                            int finishDay = Integer.valueOf( datasplit2[2]).intValue();

                            if ( sysYear ==  beginYear && sysYear ==  finishYear ) {
                                 if ( sysMonth ==  beginMonth && sysMonth ==  finishMonth ) {
                                     if ( sysDay >= beginDay && sysDay <= finishDay  ) {
                                         out.print("<em style='color:orange;font-weight:bold;'>活动中</em>");
                                     }
                                     else if (  sysDay < beginDay ) {
                                          out.print("<em style='color:red;font-weight:bold;'>活动未开始</em>");
                                     }
                                     else if (  sysDay > finishDay ) {
                                          out.print("<em style='color:#a9a9a9;font-weight:bold;'>活动已结束</em>");
                                     }
                                 }
                                 else if ( sysMonth >  finishMonth ) {
                                      out.print("<em style='color:#a9a9a9;font-weight:bold;'>活动已结束</em>");
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      out.print("<em style='color:red;font-weight:bold;'>活动未开始</em>");
                                
                                }
                            }
                            else if ( sysYear  >  finishYear ) {
                                out.print("<em style='color:#a9a9a9;font-weight:bold;'>活动已结束</em>");
                            }
//                            if ( systemTime1 >= beginshijian1 &&  systemTime1 <= finishshijian1 ) {
//                                out.print("活动中");
//                            }
//                            else if ( systemTime1 < beginshijian1 ) {
//                                out.print("活动未开始");
//                            }
//                            else if ( systemTime1 > finishshijian1 ) {
//                                out.print("活动已结束");
//                            }
//                            out.print( Integer.toString( sysYear ) );
//                            out.print( Integer.toString( sysMonth ) );
//                            out.print( Integer.toString( sysDay ) );
  //out.print(datasplit[0] );
//  out.print( Integer.toString( sysDay ) );
//   out.print("|");
   //out.print(datasplit[1] );
//    out.print(Integer.toString( beginDay ) );
//   out.print("|");
   //out.print(datasplit[2] );
//    out.print(Integer.toString( finishDay  ) );
//   out.print("|");
//                                  out.print( ( retStrFormatNowDate ) );                      
                           

                        %>
                        </td>
                    </tr>
                    
                    
                   
                    
                    <tr>
                        <td class="dce w100 ">参与代表</td>
                        <td id="seluserlist">
                        <%
                         RssListView entity2 = new RssListView(pageContext, "activities_realname");
                        entity2.select().where("activitiesid="+entity.get("id")).query();
                        while (entity2.for_in_rows()) {
                        participate_person ++;
                        %>
                        <!--<em myid='<% out.print(entity2.get("userid"));%>'><% out.print(entity2.get("realname"));%></em>-->
                        <% out.print(entity2.get("realname"));%>
                        <% out.print("  ");%>
                        <%
                        }
                        %>
                        </td>
                    </tr>
                    
                   
                    
                    <%
                    //如果是代表账号显示当前代表考勤状态
                    if ( cookie.Get("powergroupid").equals("5") ) {
                    %>
                    <tr>
                        <td class="dce w100 ">考勤状态</td>
                        <td>
                        <% 
                            if ( userlist.get("attendancetype").equals("1") ) {
                                out.print( "<em style='color:#999900;font-weight:bold;'>未考勤</em>" ); 
                            }
                            else {
                                out.print( "<em style='color:#00cc33;font-weight:bold;'>已考勤</em>" );
                            }
                        %>
                        </td>
                    </tr>
                    <%
                     }
                    %>
                   
                    <%
                       //自愿报名才显示
                    if (entity.get("enroll").equals("1") )
                    {
                    %>
                    
                    
                     <tr>
                        <td class="dce w100 ">报名状态</td>
                         <td>
                         <% 
                            if ( cookie.Get("powergroupid").equals("5") ) {
                                if( userlist.get("jointype").equals("1")){
                                    out.print("<em style='color:green;font-weight:bold;'>未报名</em>");
                                }else {
                                    out.print("<em style='color:orange;font-weight:bold;'>已报名</em>");
                                }
                            }
                            else {
                                if ( currentperson.equals( entity.get("maxperson") )) {
                                      out.print("<em style='color:red;font-weight:bold;'>报名已满</em>");
                                }
                                else {
                                     out.print("<em style='color:orangered;font-weight:bold;'>名额未满</em>");
                                }
                            }
                        %></td>
                    </tr>
                    
                    <tr>
                        <td class="dce w100 ">限额报名人数</td>
                        <td><% entity.write("maxperson"); %></td>                      
                    </tr>
                    
                   
                    
                    <tr>
                        <td class="dce w100 ">已报名人数</td>
                        <td><% out.print(currentperson); %></td>                      
                    </tr>
                    
                    
                    <tr>
                        <td class="dce w100 ">未考勤代表</td>
                        <td id="unseluserlist">
                            <!--<em id="sdsign">点击手动考勤</em>-->
                            <%
                                RssListView entity4 = new RssListView(pageContext, "activities_realname");
                                entity4.select().where("activitiesid=" + entity.get("id") + " and attendancetype=1 and jointype=2").query();
                                while (entity4.for_in_rows()) {
                            %>
                            <% out.print(entity4.get("realname"));%>
                            <% out.print( "  ");%>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">已考勤代表</td>
                        <td id="seluserlist">
                            <%
                                RssListView entity3 = new RssListView(pageContext, "activities_realname");
                                entity3.select().where("activitiesid=" + entity.get("id") + " and attendancetype=2").query();
                                while (entity3.for_in_rows()) {
                            %>
                             <% out.print(entity3.get("realname"));%>
                             <% out.print( "  ");%>
                            <%
                            }
                            %>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    
                    
                    
                    <tr>
                        <td class="dce w100 ">活动安排</td>
                        <td class="textareadiv"><% entity.write("note"); %></td>
                    </tr>
<!--                    <tr>
                        <td colspan="2" class="dce w100 ">活动正式报告：</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline"><div class="textareadiv"><% entity.write("savezs"); %></div></td>
                    </tr>-->
                    <tr class="thismyid">
                        <td class="tr">作者ID</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <!--            <div class="footer">
                            <input type="hidden" name="action" value="append" />
                            <button type="submit">确定</button>
                        </div>-->
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
        </script>
    </body>
</html>
