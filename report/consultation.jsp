<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("汝州市第十五届人民代表大会第三次会议代表议案建议批评和意见办理情况征询意见表","utf-8") + ".doc");
    response.addHeader("Content-Type","application/ms-excel");
    response.addHeader("Pragma","no-cache");
    response.addHeader("Expires","0");
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
    </head>
    <body>
        <h1>汝州市第十五届人民代表大会第三次会议<br/>代表议案、建议、批评和意见办理情况征询意见表</h1>
        <p id="top">代表:</p>
        <p> 现寄去自治县第十五届人大三次会议代表议案、建议、批评和意见办<br/>理情况征询意见表一式两份,请您收到意见表后及时反馈一下情况给我们.<br/>谢谢</p>
        <table border="1">
                    <tbody>
                        <tr>
                            <td>标题</td>
                            <td colspan="2"></td>
                            <td>建议(议案)编号</td>
                        </tr>
                        <tr>
                            <td>主办单位</td>
                            <td colspan="2"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>你是否收到答复函</td>
                            <td></td>
                            <td>收到时间</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td rowspan="2">收到答复函您认为</td>
                            <td>满意</td>
                            <td>基本满意</td>
                            <td>不满意</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>您对办理情况意见</td>
                            <td colspan="3">
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>签名:<span>年:&nbsp;月:&nbsp;日:&nbsp;</span></p>
                            </td>
                        </tr>
                    </tbody>
                </table>
        <p>填表说明:①请在"标题"栏填写议案或建议标题;②请在"议案(建<br/>议)编号"栏填写编号;③请在"主办单位"栏填写给您答复的单位;④<br/>"收到时间"请填写您收到答复函的时间;⑤请选择在"满意"、"基本满<br/>意"、"不满意"空格内打"√";⑥此意见表一式两份,请寄自治县人民政<br/>府督查室和自治县人大常委会选举联络工委收,邮编:547599,联系电话:<br/>6214198、6215033</p>
        <p>您的通讯地址:<span>联系电话:</span></p>
        
    </body>
<ml>

