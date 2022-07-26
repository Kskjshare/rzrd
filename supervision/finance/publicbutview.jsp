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
    RssList entity = new RssList(pageContext, "releasum");
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
                     <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">财政预算公开</td></tr>
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    <%
                    if (!entity.get("ico").isEmpty()) {
                    %>
                    <tr>
                    <td class="dce w100 ">图片：</td>
                    <td id="divPreview"><img id="imgHeadPhoto" src="/upfile/<% entity.write("ico"); %>"></td>
                    </tr>
                     <%
                    };
                    %>
                    <tr>
                        <td class="dce w100 ">预算分类：</td>
                        <td publiclassifyid="<% entity.write("publiclassifyid"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">公开时间：</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <%
                    if (!entity.get("enclosure").isEmpty()) {
                    %>
                    <tr>
                        <td class="dce w120 ">预算公开附件：</td>
                        <td colspan="5" style="font-weight:bold;">
                            <%
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                            %>
                            <%  entity.write("enclosurename"); %><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;float: right;margin-right: 10%;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    </tr>
                    <%
                    };
                    %>
                    <tr>
                        <td class="dce w100 ">内容：</td>
                        <td><% entity.write("matter"); %></td>
                    </tr>

                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                    </tr>
                </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
