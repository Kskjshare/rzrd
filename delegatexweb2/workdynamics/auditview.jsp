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
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "workdynamics");
    entity.request();
    
    
    RssList contactstation = new RssList(pageContext, "stationcontent");
    contactstation.request();
    //contactstation_sub.select().where("myid=?", UserList.MyID(request)).get_first_rows();


    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {     
            case "update":
                //entity.remove("id,myid");
                entity.keyvalue("state",2 );
                entity.update().where("id=?", entity.get("id")).submit();
                
                contactstation.keyvalue("state",2 );
                contactstation.remove("id");
                //contactstation.update().where("relationid=" + entity.get("id") + " and stationid=" +  entity.get("stationid")).submit();
                contactstation.update().where("relationid=" + entity.get("id") ).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
   
    
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
            #matter{line-height: 12px;height: 200px;}
            #matter>div{height: 180px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">分类</td>
                        <td dynamicclass="<% entity.write("classify"); %>"></td>
                        <td class="dce w100 ">状态</td>
                        <td style="color:red;font-weight:bold;" noticestate="<% 
                            if ( entity.get("state").equals("1") ) {
                                out.print("未审核");
                            }else {
                                out.print("发布");
                            }
                           // entity.write("state"); 
                        %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">发布者</td>
                        <td><% entity.write("realname"); %></td>
                        <td class="dce w100 ">录入日期</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr><td colspan="4" id="matter"><div><% entity.write("matter"); %></div></td></td>
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
