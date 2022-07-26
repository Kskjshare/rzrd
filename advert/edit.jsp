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
    RssList entity = new RssList(pageContext, "advert");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.keyvalue("icodef", "/img/white.gif");
    if (entity.select().where("id=?", entity.get("id")).get_first_rows()) {
        entity.keyvalue("icodef", "/upfile/" + entity.get("ico"));
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
            <table class="wp100 vtop">
                <tbody>
                    <tr>
                        <!--                        <td class="w200">
                                                    <div class="h480 hscol">
                                                        <h2 class="font14">选择分类</h2>
                                                        <ul levelhelper="advertclassify" key="classifyid" def="<% entity.write("classifyid"); %>" offset="1" class="lanmubankuai"></ul>
                                                    </div>
                                                </td>-->
                        <td>
                            <table class="wp100 cellbor">
                                <tr>
                                    <td class="tr w50">图标：</td><td>
                                        <div class="imgupload">
                                            <ul id="icourlwrap" class="swfuploadwrap">
                                                <li><div class="swfuploadimg"><div><img src="<% entity.write("icodef"); %>"></div></div></li>
                                            </ul>
                                            <div>
                                                <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                                <br/>
                                            </div>
                                        </div>
                                        建议尺寸：320*165
                                        <input type="hidden" name="ico" id="ico" value="<% entity.write("ico"); %>">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tr">链接：</td>
                                    <td><input type="text" name="url" value="<% entity.write("url"); %>" /></td>
                                </tr>
                                <tr>
                                    <td class="tr">标题：</td>
                                    <td><input type="text" class="title" name="title" value="<% entity.write("title"); %>" /></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                                        <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <script src="/data/advert.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="upload.js" type="text/javascript"></script>
        <script>
            $(".popupwrap").submit(function () {
                if ($("#ico").val() == "") {
                    alert("请选择图片！");
                    return false;
                }
                if ($(".title").val() == "") {
                    alert("请填写标题！");
                    return false;
                }
            });
        </script>
    </body>
</html>
