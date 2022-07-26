<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("主办单位信息表", "utf-8") + ".word");
//    response.addHeader("Content-Type", "application/msword");
//    response.addHeader("Pragma", "no-cache");
//    response.addHeader("Expires", "0");
    RssListView entity = new RssListView(pageContext, "sort");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>汝州市第十五届人民代表大会第四次会议代表建议、批评和意见专用纸</title>
        <link href="/css/reset.css" rel="stylesheet"type="text/css" media="screen,print">
        <link href="/css/layout.css" rel="stylesheet"type="text/css" media="screen,print">
        <link href="../css/print.css" rel="stylesheet" type="text/css"  media="screen,print"/>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="../css/print.css" rel="stylesheet" type="text/css" />
        <script src="../js/lvzhi/jquery-1.4.4.min.js" type="text/javascript"></script>
        <script src="../js/lvzhi/jquery.jqprint-0.3.js" type="text/javascript"></script>
    </head>
    <body>
        <div id="ddd">
            <table border="1" class="wp100">
                <%
                    RssListView user = new RssListView(pageContext, "user_delegation");
                    if (entity.get("myid").isEmpty()) {
                        entity.keymyid(UserList.MyID(request));
                    }
                    user.select().where("myid=?", entity.get("myid")).get_first_rows();
                %> 
                <caption><select name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select><select type="text" maxlength="80" class="w260" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" ></select>代表建议、批评和意见专用纸</caption>

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

        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script language="javascript">
            $(function () {
                $("title").text($("caption").text());
                setTimeout(function () {
                    $("#ddd").jqprint({
                        debug: false,
                        importCSS: true,
                        printContainer: true,
                        operaSupport: false
                    });
//                    history.go(-1)
                }, 1000);
                //打印初始化
            })
        </script>
    </body>
    <ml>