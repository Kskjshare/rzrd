<%@page import="RssEasy.Core.CookieHelper"%>
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
    CookieHelper cookie = new CookieHelper(request, response);
    RssListView entity = null;
    if (cookie.Get("powergroupid").equals("5")) {
        entity = new RssListView(pageContext, "lzmessage_newsuser");
    } else {
        entity = new RssListView(pageContext, "newinformation");
    }
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
            .cellbor>tbody>tr>td>img{margin: .5rem;}
            .cellbor>tbody>tr>td>a{font-size: .12rem;color: blue}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;height: 200px;font-size: smaller;}
            /*#matter>div{height: 180px;overflow: auto;}*/
            /*            p{    font-size: large;
                              margin-top: 2px;}*/
            .popupwrap div table tr:last-of-type{height: 283px;}
            .iframe{height: 90%;height: 245px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--
                    <tr>
                        <td colspan="4" class="institle dce">查看新闻</td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件：</td>
                        <td colspan="3" style="font-weight:bold;"><a href="/upfile/<% entity.write("enclosure"); %>"><% entity.write("enclosurename"); %></a></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">缩略图：</td>
                        
                        <td colspan="3">
                            <img style="width:500px;" src="/upfile/<% entity.write("ico"); %>">
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">分类：</td>
                        <td infotype="<% entity.write("infotype"); %>"></td>
                        <td class="dce w100 ">录入日期：</td>
                        <td colspan="3" rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ><input type="text" class="w200 Wdate" name="shijian"  rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                    <!--
                    <tr>
                        <td class="dce w100 ">外部链接：</td>
                        <td colspan="3"><a href="<% out.print(entity.get("links"));%>"><% out.print(entity.get("links"));%></a></td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce w100 ">内容</td>
                        <!--td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td-->
                  <td colspan="4" id="matter"><div class="iframe" style="height:96%;"><iframe src="butview_1.jsp?id=<% out.print(entity.get("id"));%>"></iframe></div></td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
