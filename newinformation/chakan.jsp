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
    RssList entity = new RssList(pageContext, "deputyActivity");
    entity.request();

    entity.select().where("id="+entity.get("id")).get_first_rows();
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
                        <td class="dce w100 ">主题：</td>
                        <td><% entity.write("topic"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">地点：</td>
                        <td sex="<% entity.write("place"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织单位：</td>
                        <td><% entity.write("organization"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">类型：</td>
                        <td><% entity.write("type"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">开始时间：</td>
                        <td><% entity.write("starttime"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间：</td>
                        <td><% entity.write("endtime"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">内容：</td>
                     <td><% entity.write("content"); %></td></tr>
                    <tr>
                        <td>封面</td>
                        <td> <img src="/upfile/<% entity.write("cover"); %>"></td>
                        
                       
                    </tr>
                    <tr>
                        <td>图片</td>
                        <td><img src="/upfile/<% entity.write("picture"); %>"></td>
                    </tr>
                    </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            var aa = $("#inp").val()
            
            document.getElementById("con").innerHTML = aa;
        </script>
    </body>
</html>
