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
    RssListView entity = new RssListView(pageContext, "backups");
    entity.request();
    entity.select().where("id=?",entity.get("relationid")).get_first_rows();
//   entity.select().where("myid="+UserList.MyID(request)).get_page_desc("id");
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
            .dce{text-indent: 0px}
             .cellbor .h100{ height:80px; }
            .cellbor td{padding-left:4px;  border: #6caddc solid thin;}
            .cellbor td:nth-child(2n+1){background-color: #6caddc50;}
            .cellbor .fileName{ color: red; }
            .cellbor>tbody>tr>td{position: relative; text-align: left;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;border: #ffffff solid 2px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .popupwrap>div:first-child{
                height: 100%;
            }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                     <tr>
                        <td class="dce w100 ">发文文号：</td>
                        <td><% entity.write("titleNumber"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">批报标题：</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">批报时间：</td>
                        <td rssdate="<% out.print(entity.get("reportingData")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td >提请报告：</td>
                        <td ><% entity.write("matter"); %></td>
                    </tr>
                    <tr class="h100">
                        <td class="dce w100 h100 ">提出审议结果报告:	</td>
                        <td><% entity.write("matter2"); %></td>
                    </tr>
                    <tr >
                        <td class="dce w100 h100 ">地方性法规文件及说明:</td>
                        <td><% entity.write("matter3"); %></td>
                    </tr>
                     <tr>
                        <td class="dce w100 ">主送机关：</td>
                        <td><% entity.write("office"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">省人大审批意见：</td>
                        <td><% entity.write("suggestion"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">省批文件：</td>
                        <td class="fileName"><% entity.write("enclosure"); %></td>
                    </tr>
            </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
