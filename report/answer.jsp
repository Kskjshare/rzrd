
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州市第十五届人民代表大会第三次会议代表议案、建议、批评和意见办理情况征询意见表","utf-8") + ".doc");
    response.addHeader("Content-Type","application/ms-excel");
    response.addHeader("Pragma","no-cache");
    response.addHeader("Expires","0");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            p{text-indent: 2em;width: 190mm;padding-left:20mm; }
            h1{width: 200mm;padding: 0 20px;text-align: center;}
            h2{width: 200mm;padding: 0 20px;text-align: center;font-weight: 200}
            .top{width: 180mm;text-align:right;}
            span{text-indent: 30mm;display: inline-block}
            #modle{width: 180mm;;height: 20mm;}
        </style>
    </head>
    <body>
        <p class="top">分类A/B/C</p>
        <h1>汝州市<span>局(办)</span></h1>
        <p class="top">××函[2018]号</p>
        <h2>关于对自制县第十五届人民代表大会第三次会议<br/>第&nbsp;&nbsp;&nbsp;&nbsp号建议的答复</h2>
        <p>×××(等×名)代表:</p>
        <p>你(你们)在自治县第十五届人大三次会议上提出的《关于<br/>×××议案(或建议)》(第&nbsp;&nbsp;&nbsp;&nbsp号)收悉,现答复如下:<br/>(答复正文)</p>
        <div id="modle"></div>
        <p class="top">汝州市&nbsp;&nbsp;&nbsp;&nbsp;局(办)(盖章)</p>
        <p class="top">2018年&nbsp;&nbsp;月&nbsp;&nbsp;日</p>
        <p>承&nbsp;办&nbsp;人</p> 
        <p>联系电话</p>
        <p>抄送:自治县人大常委会办公室,自治县人民政府办公室,<br/>代表所在乡镇人大办公室.</p>
    </body>
<ml>

