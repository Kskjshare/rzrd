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
    RssListView entity = new RssListView(pageContext, "emaillist");
    RssList entity2 = new RssList(pageContext, "emaillist");
    entity2.request();
    entity.request();
    entity2.keyvalue("readstate","2");
    entity2.update().where("id=?", entity2.get("id")).submit();
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
            .cellbor{width: 770px;margin: 20px auto;}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;border: #e9e9e9 solid thin;}
            #matter{line-height: 12px;}
            .w630{width:630px;}
            .fileeform{position: absolute;left: -10000px;}
            #uediv{width: 750px;height: 200px;margin: 5px auto;border: #6caddc solid thin;background: #fff;padding: 0 4px;}
            #headxq{height: 28px;padding:0 3px;position: relative;border: #e9e9e9 solid thin;background: #f0f0f0;}
            #headxq>span{color: #fff;background:#539314;width: 20px;height: 20px;border-radius: 5px;line-height: 20px;position: absolute;right: 4px;top: 4px;text-align: center;cursor: pointer;font-size: 22px;}
            #headxq>em{padding-left:30px; background: url(../../../img/soft/zip.png) no-repeat 5px 4px;background-size: 18px;line-height: 28px;display: inline-block; }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap"> 
            <div>
            <div id="headxq"><em>查看邮件</em><span>×</span></div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">查看邮件</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">邮件题目：</td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">收件人：</td>
                        <td><% out.print(entity.get("sendstate").equals("2") ? entity.get("sendname") : entity.get("sendallname"));%></td>
                        <td class="dce w100 ">附件：</td>
                        <td> <div><a href="/upfile/<% out.print(entity.get("enclosure")); %>">点击查看文件</a></div></td>
                    <tr>
                        <td class="dce w100 " colspan="4"><div id="uediv"><% out.print(entity.get("matter"));%><div></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <input name="sendid" value="<% out.print(entity.get("myid"));%>"></td>
                </table>
            </div>
                <div class="footer">
                <button type="button" id="addsub">回复</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#addsub").click(function() {
          popuplayer.display("/workexchange/mailbox/see/write.jsp?id=<% out.print(entity.get("id"));%>&TB_iframe=true", '回复', {width: 790, height: 490});
                  })
              $("#headxq>span").click(function() {
                      history.go(-1);
               })
        </script>
    </body>
</html>
