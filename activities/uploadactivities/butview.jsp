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
    
    RssListView entity = new RssListView(pageContext, "activities"); // activitiesmy
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    
    String currentperson = "0" ;

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
    
    
    RssList entity1 = new RssList(pageContext, "activities");
    entity1.request();
    entity1.select().where("id="+ req.get("id") ).get_page_desc("id");
    
    
    
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
                        <td class="dce w100 ">履职主题</td>
                        <td><% out.print(entity.get("name")); %></td>
                    </tr>
                    
                   
                     <tr>
                        <td class="dce w100 ">履职时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    
                     <tr>
                        <td class="dce w100 ">履职地点</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                   
                    
                  
                    
              
                    <tr>
                        <td class="dce w100 ">参与代表</td>
                        <td id="seluserlist">
                        <%
                         RssListView entity2 = new RssListView(pageContext, "activities_realname");
                        entity2.select().where("activitiesid="+entity.get("id")).query();
                        while (entity2.for_in_rows()) {
                        %>
                        <!--<em myid='<% out.print(entity2.get("userid"));%>'><% out.print(entity2.get("realname"));%></em>-->
                        <% out.print(entity2.get("realname"));%>
                        <% out.print("  ");%>
                        <%
                        }
                        %>
                        </td>
                    </tr>
                   
                    
                    <tr>
                        <td class="dce w100 left"><span>履职内容</span></td>
                        <td><% entity.write("note"); %></td>
                    </tr>
                    
                     <tr>
                        <td class="dce w100 ">附件</td>
                        <td>

                            
                            <input readonly="true" class="xz"  style="border:none" value="<% out.print(entity.get("enclosurename")); %>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/upfile/<% out.print(entity.get("enclosure")); %>" style="cursor: pointer;color: blue;font-weight: bold;">点击查看</a>
                           
                        </td>
                    </tr>       
                    
                    
<!--                   <tr>
                        <td class="dce w100 ">附件</td>
                        <td>

                            <%
                                String[] arry1 = {"", "", ""};
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity1.get("enclosure").split(",");
                                    String[] str2 = entity1.get("enclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                                        arry2[idx] = str2[idx];
                            %>
                            
                            <input readonly="true" class="xz"  style="border:none" value="<% out.print(arry2[idx]); %>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;font-weight: bold;">点击查看<% out.print(entity.get("enclosure")); %></a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    </tr>       -->
                    
                    
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
