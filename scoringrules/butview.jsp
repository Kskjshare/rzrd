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
    RssList entity = new RssList(pageContext, "scoringrules");
    entity.request();
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
            .cellbor>tbody>tr>td>div{padding: 3px;}
            .cellbor>tbody>tr>td>img{margin: 3px;}
            .cellbor>tbody>tr>td>a{font-size: .12rem;color: blue}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;height: 200px;}
            #matter>div{height: 180px;overflow: auto;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                   <tr>
                        <td colspan="4" class="institle dce">评分规则信息</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">编码：</td>
                        <td><% entity.write("code"); %></td>
                        <td class="dce w100 ">标题：</td>
                        <td><% entity.write("rulesname"); %></td>
                    </tr>
                    <tr>
                        
                        <td class="dce w100 ">基础分：</td>
                        <td><% entity.write("basescore"); %></td>
                        <td class="dce w100 ">最高分：</td>
                        <td><% entity.write("maxscore"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">发言加分：</td>
                        <td><% entity.write("speakscore"); %></td>
                        <td class="dce w100 ">递增加分：</td>
                        <td><% entity.write("incrementing"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">缺勤扣分：</td>
                        <td><% entity.write("absence"); %></td>
                        <td class="dce w100 ">请假扣分：</td>
                        <td><% entity.write("leavescore"); %></td>
                    </tr>
                    <tr>
                        <td class="w100 " colspan="4"><div><% entity.write("matter"); %></div></td>
                    </tr>
                    </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
