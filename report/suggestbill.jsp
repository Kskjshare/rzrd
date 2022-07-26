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
            p{text-indent: 2em;width: 210mm;}
            h1{width: 200mm;padding: 0 20px;text-align: center;}
            #top{width: 200mm;text-align: right;}
            span{text-indent: 10em;}
            table{width: 200mm;border: none;text-align: center;}
            table>tbody>tr>td{border: #000 solid thin;min-width: 50px;margin: 0;padding: 0;height: 30px}
            #modle{width: 200mm;border-bottom:#000 solid thin;height: 100px;}
            #footer{margin-top:70mm;width: 200mm;border: #000 solid thin}
        </style>
    </head>
    <body>
        <p id="top">建议第＿＿号</p>
        <h1>汝州市第十五届人民代表大会第三次会议<br/>代表议案、建议、批评和意见办理情况征询意见表</h1>
        <table cellspacing="0">
                    <tbody>
                        <tr>
                            <td>标题</td>
                            <td></td>
                            <td>代表证号码</td>
                            <td>&nbsp;&nbsp;</td>
                            <td>联系电话</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>通讯地址</td>
                            <td colspan="3"></td>
                            <td>邮政编码</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>代表姓名</td>
                            <td>代表证号码</td>
                            <td colspan="3">通讯地址</td>
                            <td>邮政编码</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td  colspan="3"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td  colspan="3"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td  colspan="3"></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
        <div id="modle"></div>
        <p id="footer">备注:需回复</p> 
        <p></p>
    </body>
<ml>

