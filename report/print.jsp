<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州人民代表大会代表议案建议信息表","utf-8") + ".doc");
    response.addHeader("Content-Type","application/ms-excel");
    response.addHeader("Pragma","no-cache");
    response.addHeader("Expires","0");
	RssListView entity = new RssListView(pageContext, "sort");
    entity.request();
    entity.select().where("id in ("+entity.get("id")+")").query();
	
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
		
        <style>
            p{text-indent: 2em;width: 660px;padding: 0 20px}
            h1{width: 560px;padding: 0 20px}
            #top{text-indent: 4em;}
            span{text-indent: 10em;}
            table{width: 700px;border: none};
            table td{border: #000 solid thin}
            td>p{margin-top: 100px;}
        </style>
		<script src="../js/lvzhi/jquery.min.js" type="text/javascript"></script>
        <script src="../js/lvzhi/jQuery.print.js" type="text/javascript"></script>
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js_1.html" %>
        <script src="/data/session.js"></script>
    </head>
    <body>
	<%
		while (entity.for_in_rows()) {
		%>
        <table border="1">
		
                         <%
                            RssListView user = new RssListView(pageContext, "user_delegation");
                           
                            user.select().where("myid=?", entity.get("myid")).get_first_rows();
                        %> 
                        <p id="p">
                           <!--<select id="lwstate" class="select" class="lstate" name="lwstate" dict-select="lwstate" def="<% entity.write("lwstate"); %>"></select>-->
                            <i class="lwstate"></i>第<em><% entity.write("realid"); %></em>号
                        </p>
                        <!--<select name="sessionid" id="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select><select id="meetingnum" type="text" maxlength="80" class="w260" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" ></select>-->
                        <caption>
                            <i class="sessionid"></i><i class="meetingnum"></i>代表议案建议、批评和意见专用纸</caption>
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
                                    secondlist.select().where("suggestid in(" + entity.get("id")+")").query();
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
				<p>&nbsp;</P>
				</br>
				<p>&nbsp;</P>
				</br>
        <%
		}
		%>
    </body>
<ml>

