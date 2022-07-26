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
    
    
    
    RssList tempentity2 = new RssList(pageContext, "activities");
    RssList user = new RssList(pageContext, "activities_userlist");
    RssList user2 = new RssList(pageContext, "activities_userlist");
    //RssListView tempEntity = new RssListView(pageContext, "activities");
    //tempEntity.request();
    tempentity2.request();
   
    if (entity.get("action").equals("sign")) 
    {
        
         //更改activities表格的签到人数    
        RssList activitylist = new RssList(pageContext, "activities");
        activitylist.select().where("id=?", req.get("id")).get_first_rows();
        int currentperson = Integer.valueOf(activitylist.get("currentperson") ).intValue(); 
        currentperson ++;
        activitylist.remove("currentperson");
        activitylist.keyvalue("currentperson",currentperson);
        //activitylist.update().submit();
        activitylist.update().where("id=" + req.get("id")).submit();
        
        String str = tempentity2.get("userid");
        String[] arry = str.split(",");
        String str2 = tempentity2.get("unuserid");
        String[] arry2 = str2.split(",");
        user.delete().where("activitiesid=" + entity.get("id") + " and jointype=1").submit();
        for (int i = 0; i < arry.length; i++) {
            user.timestamp();
            user.keyvalue("activitiesid", entity.get("id"));
            //user.keyvalue("userid", arry[i]);
            user.keyvalue("userid", UserList.MyID(request));
             
            user.keyvalue("jointype", "2");
            user.keyvalue("myid", tempentity2.get("myid"));
            user.append().submit();
        }
       
        
//        
//         for (int i = 0; i < arry2.length; i++) {
//            user2.timestamp();
//            user2.keyvalue("activitiesid", entity.get("id"));
//            user2.keyvalue("userid", arry2[i]);
//            user2.keyvalue("jointype", "1");
//            user2.keyvalue("myid", tempentity2.get("myid"));
//            user2.append().submit();
//        }
        
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed(); 
    }
    entity.select().where("id=?", req.get("id")).get_first_rows();
    
    RssList userlist = new RssList(pageContext, "activities_userlist");
    userlist.request();
    userlist.select().where("activitiesid=?", req.get("id")).get_first_rows();
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
<!--                    <tr>
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">报名开始日期</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                   
                     <tr>
                        <td class="dce w100 ">报名状态</td>
                         <td>
                         <% 
                             
                         if ( cookie.Get("powergroupid").equals("7")) {
                            //选工委账号登录
                            if ( entity.get("maxperson").equals( entity.get("currentperson") ) ) 
                                //out.print("报名已满"); 
                                out.print("<em style='color:red;font-weight:bold;'>报名已满</em>");
                            else {
                                //out.print("报名中");
                                long systemTime = System.currentTimeMillis()/1000;                                  
                                long endshijian = Long.parseLong(entity.get("finishshijian"));
                               
                                if ( systemTime >  endshijian ){
                                     //out.print("报名已截止");
                                     out.print("<em style='color:red;font-weight:bold;'>报名已截止</em>");
                                }
                                else {
                                   out.print("报名中"); 
                                }
                            }
                                     
                         }     
                         if( userlist.get("jointype").equals("2")){
                            //out.print("已报名");
                            out.print("<em style='color:blue;font-weight:bold;'>已报名</em>");
                        }else {
                            //out.print("未报名");
                            out.print("<em style='color:green;font-weight:bold;'>未报名</em>");
                        }       

                        %></td>
                    </tr>
                    
                    <tr>
                        <td class="dce w100 ">限额报名人数</td>
                        <td><% entity.write("maxperson"); %></td>                      
                    </tr>
                    
                   
                    
                    <tr>
                        <td class="dce w100 ">已报名人数</td>
                        <td><% entity.write("currentperson"); %></td>                      
                    </tr>
                    
                    
<!--                    <tr>
                        <td class="dce w100 ">未报名代表</td>
                        <td id="seluserlist">
                        <%
                         RssListView entityRealName = new RssListView(pageContext, "activities_realname");
                        //entity2.select().where("activitiesid="+ entity.get("id")+" and jointype=1").query();
                        entityRealName.select().where("jointype=1 and activitiesid=?", req.get("id") ).query();
                        while (entityRealName.for_in_rows()) {
                        %>
                        <em myid='<% out.print(entityRealName.get("userid"));%>'><% out.print(entityRealName.get("realname"));%></em>
                        <% out.print(entityRealName.get("realname"));%>
                        <%
                        }
                        %>
                        </td>
                    </tr>-->
                    
                    
                    
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
                         entity3.select().where("id=?",entity.get("idd")+" and jointype=2").query();
                        while (entity3.for_in_rows()) {
                        %>
                        <em myid='<% out.print(entity3.get("userid"));%>'><% out.print(entity3.get("realname"));%></em>
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
                                     <tr class="thismyid">
                                            <td class="tr">作者ID：</td>
                                            <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <label></label></td>
                                    </table>
            </div>
                <div class="footer">
                <!--<input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />-->
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "sign" : "sign"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "确定报名" : "确定报名");%></button>
                </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
    </body>
</html>
