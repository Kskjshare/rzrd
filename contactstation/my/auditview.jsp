<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    StaffList.IsLogin(request, response);
//    RssListView entity = new RssListView(pageContext, "workdynamics");
//    entity.request();
    
    
    RssList entity = new RssList(pageContext, "stationcontent");
    entity.request();
    //contactstation_sub.select().where("myid=?", UserList.MyID(request)).get_first_rows();


    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {     
            case "update":
                //entity.remove("id,myid");
                entity.keyvalue("state",2 );
                entity.keyvalue("audit",3 );
                entity.update().where("id=?", entity.get("id")).submit();
                
                entity.keyvalue("state",2 );
                entity.keyvalue("audit",3 );
                entity.remove("id");
                //contactstation.update().where("relationid=" + entity.get("id") + " and stationid=" +  entity.get("stationid")).submit();
                entity.update().where("relationid=" + entity.get("id") ).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
   
    
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    
    //获取发布者名字
    RssList user_entity = new RssList(pageContext, "user");
    user_entity.request();
    user_entity.select().where("myid=?", entity.get("myid")).get_first_rows();
    
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
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
             .popupwrap>div:first-child{height: 100%;}
             #matter{line-height: 12px;}
             .w630{width:630px;}
            .b99{width:99%;}
            #abc{position: absolute;left: -10000px;} #headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
        </style>
    </head>
    <body>
         <form id="abc" enctype="multipart/form-data" method="post">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form> 
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">

                    
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">类别</td>
                        <td dynamicclass="<% entity.write("classify"); %>"></td>
                        <td class="dce w100 ">状态</td>
                        
                        <% if  ( entity.get("state").equals("1") ) { %>
                        <td style="color:green;font-weight:bold;" noticestate="发布"
                        </td>
                        <%}else{%>
                        <td style="color:red;font-weight:bold;" noticestate="未审核"
                        </td>
                        <%}%>
                        
                    </tr>
                    <tr>
                        <td class="dce w100 ">发布者</td>
                        <td><% user_entity.write("realname"); %></td>
                        <td class="dce w100 ">提交时间</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                   
                 
                  
                    <tr>
                        <td class="dce w100 " colspan="4"><script style="width:100%" ueditor="toolbars: [[]],initialFrameHeight:400" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
               <input type="hidden" name="action" value="<% out.print("update"); %>" />
               <button type="submit"><% out.print("审核通过");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        
    </body>
</html>
