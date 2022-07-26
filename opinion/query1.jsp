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
    RssListView list = new RssListView(pageContext, "sort");
    list.request();
    list.select().where("id=?", list.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            .popupwrap{width: 98%}
            .left_op{width: 30px}
            .mui-input-row span{display: none}
            .mui-input-range input[type=range]{background-color: #dce6f5;height: 6px;border: 1px solid #cbcbcb;width: 90%;margin: 0}
            .mui-input-row.mui-input-range{float: left;width: 90%;padding: 0;}
            .tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 36px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #baidubjq td{line-height: 17px;background: #dce6f5}
            #baidubjq td ul{width: 798px;margin-top: 5px;border-top: 1px solid #6caddc;border-left: 1px solid #6caddc;border-right: 1px solid #6caddc}
            #baidubjq td div{border-left: 1px solid #6caddc;border-right: 1px solid #6caddc;border-bottom: 1px solid #6caddc;margin-bottom: 5px;width: 778px;padding: 10px;background: #fff}
            .shu{line-height: 15px;text-align: center;}
            .uetd>ul{left: 0}
            .cellbor>tbody>tr .line{line-height: 24px}
            textarea{width: 99%;height: 60px;margin: 5px 0;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
                     <tr>
                        <td colspan="20" class="tabheader">建议信息</td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">建议编号：</td>
                        <td class="w261" colspan="6"><% out.print(list.get("realid")); %></td>
                        <td class="dce" colspan="4">届次：</td>
                        <td class="w261" colspan="6">11111</td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">建议题目：</td>
                        <td colspan="16"><% list.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">领衔代表：</td>
                        <td class="w261" colspan="6"><% out.print(list.get("nickname")); %></td>
                        <td class="dce" colspan="4">类型：</td>
                        <td class="w261" colspan="6" classify="<% out.print(list.get("type")); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">主办单位：</td>
                        <td class="w261" colspan="6"><% list.write("organizer"); %></td>
                        <td class="dce" colspan="4">办理类型：</td>
                        <td class="w261" colspan="6"></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">交办日期：</td>
                        <td class="w261" colspan="6" rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
                        <td class="dce" colspan="4">要求办结日期：</td>
                        <td class="w261" colspan="6"></td>
                    </tr>
                    <tr id="baidubjq">
                        <td colspan="20" class="uetd">
                                <ul><li class="sel">建议内容</li><li>办复信息</li></ul>
                                <div class="edui-default">
                                    <% out.print(list.get("matter")); %>
                                </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
