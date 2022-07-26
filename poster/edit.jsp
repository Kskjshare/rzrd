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
    RssList entity = new RssList(pageContext, "poster");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
//        if (entity.get("myid").isEmpty()) {
//            entity.keymyid(UserList.MyID(request));
//        }
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
        <link href="/css/swfupload.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w120">广告名称：</td>
                        <td><input type="text" class="w500" name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w120">图片：</td>
                        <td>
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
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/goods.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
        <script type="text/javascript">
            //data-val:默认值
            //dict-name:对应表单的name值
            dictdata["area"] = AreaListData;
        </script>
        <script src="../js/upload.js" type="text/javascript"></script>
        <script src="ico.js" type="text/javascript"></script>
        <script>
            var a = 0;
            $("teble input").each(function () {
                a++;
            })
            $("form").submit(function () {
                if (a > 0) {
                    alert("请完善广告信息");
                    return false;
                }
            })
        </script>
    </body>
</html>
