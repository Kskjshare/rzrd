<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RssListView entity = new RssListView(pageContext, "sort");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<html class="no-js" lang="zh">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--<meta http-equiv="Content-Type" content="textml; charset=UTF-8">-->
        <title>汝州市第十五届人民代表大会第四次会议代表建议专用纸</title>

        <link href="/css/reset.css" rel="stylesheet"type="text/css" media="screen,print">
        <link href="../css/print.css" rel="stylesheet" type="text/css"  media="screen,print"/>
        <link href="../css/print.css" rel="stylesheet" type="text/css" />

        <link href="../css/print_1.css" rel="stylesheet"type="text/css" media="screen,print">
        <link href="../css/print_2.css" rel="stylesheet" type="text/css"  media="screen,print"/>
        <link href="../css/print_1.css" rel="stylesheet" type="text/css" />
        <link href="../css/print_2.css" rel="stylesheet" type="text/css" />

        <style type='text/css'>
            .float-left{float: left;}
            #content_holder{float: left;}
            .example{/* float: left; */margin: auto;width: 80%}
            .example-5{background: #fee3a1;color: #354768;text-align: center;padding: 15px;}
        </style>
        <style media="print">
            @page {
                size: auto;  /* auto is the initial value */
                margin: 0mm; /* this affects the margin in the printer settings */
            }
        </style>
    </head>
    <body>
        <div class="htmleaf-container">
            <div id="content_holder">
                <div id="ele1" class="example example-1">
                    <table border="1" class="wp100">
                        <%
                            RssListView user = new RssListView(pageContext, "user_delegation");
                            if (entity.get("myid").isEmpty()) {
                                entity.keymyid(UserList.MyID(request));
                            }
                            user.select().where("myid=?", entity.get("myid")).get_first_rows();
                        %> 
                        <p id="p">
                            <select id="lwstate" class="select" class="lstate" name="lwstate" dict-select="lwstate" def="<% entity.write("lwstate"); %>"></select>
                            <i class="lwstate"></i>第<em><% entity.write("realid"); %></em>号
                        </p>
                        <select name="sessionid" id="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select><select id="meetingnum" type="text" maxlength="80" class="w260" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" ></select>
                        <caption>
                            <i class="sessionid"></i><i class="meetingnum"></i>人大代表建议议案专用纸</caption>
                        <tbody>

                            <tr>
                                <td class="tr w100 ">代表姓名</td>
                                <td  class="matter"><% user.write("realname"); %></td>
                                <td class="tr w100">代表证号码</td>
                                <td><% user.write("code"); %></td>
                                <td class="tr w100 ">联系电话</td>
                                <td><% user.write("telphone"); %></td>
                            </tr>
                            <tr>
                                <td class="tr w100 ">通讯地址</td>
                                <td colspan="3"><% user.write("daibiaoDWaddress"); %></td>
                                <td class="tr w100 ">邮政编码</td>
                                <td><% user.write("postcode"); %></td>
                            </tr>
                            <tr>
                                <td class="tr w100 ">代表姓名</td>
                                <td class="tr w100 ">代表证号</td>
                                <td class="tr w100 " colspan="3">通讯地址</td>
                                <td class="tr w100 ">邮政编码</td>
                            </tr>
                            <%
                                if (!entity.get("id").isEmpty()) {
                                    RssListView secondlist = new RssListView(pageContext, "second_user");
                                    secondlist.select().where("suggestid=" + entity.get("id")).query();
                                    while (secondlist.for_in_rows()) {
                            %>
                            <tr>
                                <td class="matter"><% out.print(secondlist.get("realname"));%></td>
                                <td><% out.print(secondlist.get("code"));%></td>
                                <td colspan="3"><% out.print(secondlist.get("daibiaoDWaddress"));%></td>
                                <td><% out.print(secondlist.get("postcode"));%></td>
                            </tr>
                            <%
                                    }
                                }
                            %> 

                            <tr>
                                <td colspan="6" class="jianjie"><% out.print(entity.get("matter"));%></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="../js/lvzhi/jquery.min.js" type="text/javascript"></script>
        <script src="../js/lvzhi/jQuery.print.js" type="text/javascript"></script>
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js_1.html" %>
        <script src="/data/session.js"></script>
        <script language="javascript">
            $(function () {
                $("title").text($("caption").text());
                $(".meetingnum").text($("#meetingnum option:selected").text())
                $(".sessionid").text($("#sessionid option:selected").text());
                $(".lwstate").text($("#lwstate option:selected").text());
//                    //打印初始化
                setTimeout(function () {
                    jQuery.print();
                }, 500);
//
            })
        </script>

    </body>
</html>