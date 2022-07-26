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
<%@page import="RssEasy.Core.CookieHelper"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    //RssListView entity = new RssListView(pageContext, "activities"); //removded by ding
    RssListView entity = new RssListView(pageContext, "activitiesmy");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    String currentperson = "0" ;
    RssList userlist = new RssList(pageContext, "activities_userlist");
    userlist.request();
    if (cookie.Get("powergroupid").equals("5")) {
        //ding\
         
        userlist.select().where("activitiesid="+req.get("id") + " and userid="+ UserList.MyID(request) ).get_first_rows();         
    }
    else {
    
             
        userlist.select().where("activitiesid=?", req.get("id") ).get_first_rows();
    }
    currentperson = entity.get("currentperson");
    

   //因为手机端报名以后，不能更新currentperson字段，所以这里左了特殊处理，通过activities_userlist判断.
//   if ( currentperson.equals("0")){
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
    //currentperson = userlist1.totalrows + "";
//    }
   
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
            .cellbor{border: 0}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{line-height: 34px;position: relative;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;border: #ffffff solid 2px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{
/*                position: absolute;top: 10px;left: 6px;*/
                line-height:50px;
            }
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #unseluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
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
                    if (entity.get("enroll").equals("1")) {
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
                    };
                    %>          
                    
                    
                    <%
                    if (entity.get("enroll").equals("2")) {
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
                    };
                    %>          
                    
                   
                   
                     <tr>
                        <td class="dce w100 ">报名状态</td>
                         <td>
                         <% 
                            if ( cookie.Get("powergroupid").equals("5") ) {
                                if( userlist.get("jointype").equals("2")){
                                    out.print("<em style='color:orange;font-weight:bold;'>已报名</em>");
                                }else {
                                   if ( currentperson.equals( entity.get("maxperson") )) {
                                      out.print("<em style='color:red;font-weight:bold;'>报名已满</em>");
                                    }
                                   else {
                                    out.print("<em style='color:green;font-weight:bold;'>未报名</em>");
                                   }
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
                    
                    <!--
                    <tr>
                        <td class="dce w100 ">未报名代表</td>
                        <td id="seluserlist">
                        <%
                         RssListView entity2 = new RssListView(pageContext, "activities_realname");
                        //entity2.select().where("activitiesid="+ entity.get("id")+" and jointype=1").query();
                        entity2.select().where("jointype=1 and activitiesid=?", req.get("id") ).query();
                        while (entity2.for_in_rows()) {
                        %>
                        <em myid='<% out.print(entity2.get("userid"));%>'><% out.print(entity2.get("realname"));%></em>
                        <%
                        }
                        %>
                        </td>
                    </tr>
                    -->
                    
                    
                     <% 
                         //如果已报名人数==0 ，则不显示已报名人栏目
                       int sign = Integer.valueOf( entity.get("currentperson") ).intValue();
                       if ( sign > 0 ) {
                     %>
                    <tr>
                        <td class="dce w100 ">已报名代表</td>
                        <td id="seluserlist">
                        <%
                         RssListView entity3 = new RssListView(pageContext, "activities_realname");
                        //entity3.select().where("activitiesid="+entity.get("id")+" and jointype=2").query();
                         entity3.select().where("activitiesid=?",entity.get("id")+" and jointype=2").query();
               
                        while (entity3.for_in_rows()) {
                        %>
<!--                        <em myid='<% out.print(entity3.get("userid"));%>'><% out.print(entity3.get("realname"));%></em>-->
                        
                        <% out.print(entity3.get("realname"));out.print( ("  "));%>
                        <%
                        }
                        %>
                        </td>
                    </tr>
                    <%};%>
                    
                    <tr>
                        <td class="dce w100 left"><span>活动安排</span></td>
                        <td><div class="textareadiv"><% entity.write("note"); %></div></td>
                    </tr>
                    <!--                 <tr class="thismyid">
                                            <td class="tr">作者ID：</td>
                                            <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <label></label></td>
                                    </table>-->
            </div>
            <!--            <div class="footer">
                            <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                            <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
                        </div>-->
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
    </body>
</html>
