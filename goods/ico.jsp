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
    RssList entity = new RssList(pageContext, "goods");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        entity.update().where("id=?", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("ico").where("id=?", entity.get("id")).get_first_rows();
    if (entity.get("ico").isEmpty()) {
        entity.keyvalue("ico", "goods.png");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <ul id="icourlwrap" class="swfuploadwrap">
                    <li><div class="swfuploadimg"><div><img src="/upfile/<% entity.write("ico"); %>"></div></div></li>
                </ul>
                <div>
                    <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                    <br/>
                </div>
                <input type="hidden" name="ico" id="ico" value="<% entity.write("ico");%>">
            </div>
            <div class="footer">                
                <input type="hidden" name="action" value="update" />
                <button type="submit">确定</button> 建议尺寸：100*75
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="ico.js" type="text/javascript"></script>
    </body>
</html>
