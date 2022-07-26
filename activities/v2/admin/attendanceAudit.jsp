<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.JPushClient"%>
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
<%@page import="java.net.URLDecoder"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    //推送接口
//    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
//    RssList senduser = new RssList(pageContext, "userDeviceid");
//    Map<String, String> map = new HashMap<String, String>();
//    map.put("key", "1");
//    RssList entity2 = new RssList(pageContext, "activities");
//    RssList user = new RssList(pageContext, "activities_userlist");
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();
    //entity.select().where("userid=?",req.get("id") ).get_first_rows();
    entity.select().where("id=?",req.get("id") ).get_first_rows();



  
     RssListView userlist = new RssListView(pageContext, "activities_userlist");
     userlist.request();
//     if ( cookie.Get("powergroupid").equals("5") ) {
//       userlist.select().where("activitiesid= "+ entity.get("id") + " and userid="+ UserList.MyID(request)  ).get_first_rows();
//    }
//    else {
//       //userlist.select().where("userid=?",req.get("id")).get_first_rows();
//         
//        userlist.select().where("activitiesid="+ req.get("id") + " and userid=" + req.get("userid")).get_first_rows();
//     
//    }
    userlist.select().where("activitiesid="+ req.get("id") + " and userid=" + req.get("userid")).get_first_rows();
     
    RssList userActitivityTable = new RssList(pageContext, "activities_userlist");
    userActitivityTable.request();
    userActitivityTable.select().where("activitiesid= "+ req.get("id") + " and userid="+ req.get("userid")   ).get_first_rows();

    //履职排名表
     RssList ranktable = new RssList(pageContext, "activities_rank");
     ranktable.request();
     ranktable.select().where("realname like '%" + URLDecoder.decode(ranktable.get("realname"), "utf-8") + "%'").get_page_desc("id");
//     RssListView realname = new RssListView(pageContext, "activities_realname");
//     realname.request();
//     realname.select().where("userid="+ req.get("id")).get_first_rows();
 
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity2.timestamp();
//                entity2.remove("userid");
                
                //插入履职排行榜
                if ( entity.get( "evaluateResult").equals("2") ) {
              
                ranktable.timestamp();
                ranktable.keymyid(UserList.MyID(request));               
                
                ranktable.keyvalue("realname",userlist.get("realname"));        
                ranktable.keyvalue("userid", userlist.get("userid")); // userlist.get("userid")
                ranktable.keyvalue("activitiesid",entity.get("id") ); // userlist.get("activitiesid")
                
                ranktable.remove("id");
                ranktable.keyvalue("id",ranktable.totalrows + 1);
                
               
                ranktable.keyvalue("classify",userlist.get("classify"));
                ranktable.keyvalue("lwstate","0");
                ranktable.append().submit();
                //用户履职表状态该更改
                long systemTime = System.currentTimeMillis();  
                userActitivityTable.remove("id");
                //userActitivityTable.keyvalue("id",userlist.autoid);
                userActitivityTable.keyvalue("auditshijian",systemTime/1000);
                userActitivityTable.remove("auditState");
                //userActitivityTable.keyvalue("userid",req.get("id"));
                userActitivityTable.keyvalue("userid", userlist.get("userid"));
                userActitivityTable.keyvalue("auditState",2);
                
                userActitivityTable.keyvalue("evaluateResult", 2 );
                
                
                //userActitivityTable.update().where("userid=" + req.get("id")).submit();
                userActitivityTable.update().where("activitiesid=" + req.get("id") + " and userid="+ req.get("userid")  ).submit();
                
                
                //更改审核状态，为了列表不显示审核两个字
                RssList entityList = new RssList(pageContext, "activities");
                entityList.request();
                entityList.select().where("id="+req.get("id") +" and private=0").get_first_rows();
                entityList.keyvalue("privateaudit", 1 );
                entityList.update().where("id=" + req.get("id") + " and myid="+ req.get("userid") +" and private=0" ).submit();
                out.print("<script>alert('审核通过')</script>");
                }
                else {
                ranktable.timestamp();
                ranktable.keymyid(UserList.MyID(request));               
                
                ranktable.keyvalue("realname",userlist.get("realname"));
                //ranktable.keyvalue("userid",req.get("id")); // userlist.get("userid")
                ranktable.keyvalue("userid",userlist.get("userid"));// userlist.get("userid")
                ranktable.keyvalue("activitiesid",entity.get("id") ); // userlist.get("activitiesid")

                ranktable.remove("id");
                ranktable.keyvalue("id",ranktable.totalrows + 1);

                ranktable.keyvalue("classify",userlist.get("classify"));
                ranktable.keyvalue("lwstate","0");
                ranktable.append().submit();
                //用户履职表状态该更改
                long systemTime = System.currentTimeMillis();  
                userActitivityTable.remove("id");
                //userActitivityTable.keyvalue("id",userlist.autoid);
                userActitivityTable.keyvalue("auditshijian",systemTime/1000);
                userActitivityTable.remove("auditState");
                //userActitivityTable.keyvalue("userid",req.get("id"));
                userActitivityTable.keyvalue("userid", userlist.get("userid"));
                userActitivityTable.keyvalue("auditState", 3 );
                userActitivityTable.keyvalue("evaluateResult", 1);
                //userActitivityTable.update().where("userid=" + req.get("id")).submit();
                userActitivityTable.update().where("activitiesid=" + req.get("id") + " and userid="+ req.get("userid")  ).submit();
                out.print("<script>alert('审核不通过')</script>");
                }
                
              
                
              
                break;
            case "update":
//                entity2.remove("userid");
//                entity2.update().where("id=" + entity2.get("id")).submit();
//                user.delete().where("activitiesid=" + entity2.get("id") + "").submit();
                  out.print("<script>alert('更新')</script>");
              
                break;
        }
 
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
//    entity.select().where("id=?",entity.get("id") ).get_first_rows();
  

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
            .cellbor{border: 1}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: 1;line-height: 34px;position: relative;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            .w250{width: 94%;}
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
                        <td class="dce w100 ">活动类型</td>                       
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td><% entity.write("department"); %></td>
                    </tr>
                    
                    <%
                    if (entity.get("enroll").equals("1") ){
                    %>
                    <tr>
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <%
                    }
                    %>
                    
                    <tr>  
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>                      
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间</td>                   
                        <td rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                   
                   
                    
                    
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
                                         out.print("活动中");
                                     }
                                     else if (  sysDay < beginDay ) {
                                          out.print("活动未开始");
                                     }
                                     else if (  sysDay > finishDay ) {
                                          out.print("活动已结束");
                                     }
                                 }
                                 else if ( sysMonth >  finishMonth ) {
                                      out.print("活动已结束");
                                
                                }
                                else if ( sysMonth <  beginMonth ) {
                                      out.print("活动未开始");
                                
                                }
                            }
                            else if ( sysYear  >  finishYear ) {
                                out.print("活动已结束");
                            }

                        %>
                        </td>
                    </tr>
                    
                    
                     <tr>
                        <td class="dce w100 ">考勤代表</td>
                        <td id="seluserlist">
                        <%
                        RssListView participant = new RssListView(pageContext, "activities_realname");
                        
                        //participant.select().where("id="+ entity.get("idd") +" and userid="+ req.get("id") ).query();
                        
                        participant.select().where("activitiesid="+ entity.get("id") +" and userid="+ entity.get("userid") ).query();
                        while (participant.for_in_rows()) {
                        //participate_person ++;
                        %>
                        <% out.print(participant.get("realname"));%>
                        <% out.print("  ");%>
                        <%
                        }
                        %>
                        </td>
                    </tr>
 
                <!--
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
                 -->   
                   
                  
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
         
             
            
            <div class="footer">
                <%
                if ( userlist.get("attendancetype").equals("2") ) {
                %>   
               
                <input type="hidden" name="action" value="<% out.print("append");%>" />
                <button style="float:left;" type="submit"  ><% out.print("审核不通过");%></button>
                <button type="submit"><% out.print("审核通过");%></button>
                <input name="evaluateResult" type="hidden">
                <%
               }
                %>   
            </div>
            
            
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                           
            $('.footer button:first').click(function () {
                $('[name=evaluateResult]').val(1);
                //alert("11111111");
            });
            $('.footer button:last').click(function () {
                $('[name=evaluateResult]').val(2);
                 //alert("22222");
            });
                           
        </script>
    </body>
</html>
