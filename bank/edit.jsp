<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="RssEasy.MySql.BankList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    BankList entity = new BankList(pageContext);
    entity.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.append().submit();

                if (!entity.get("url").isEmpty()) {
                    DirectoryExtend.MoveUpfile(request, entity.get("url"), "bank/" + entity.autoid);
                }
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        BankList.CreateJson(pageContext);
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.keyvalue("ico", "white.gif");
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
                        <td class="tr w80">名称：</td>
                        <td>
                            <input class="thisname" type="text" id="name" name="name" class="w100" value="<% entity.write("name"); %>" maxlength="50" /><label for="name"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">代码：</td>
                        <td>
                            <input type="text" id="code" name="code" class="w100" value="<% entity.write("code"); %>" maxlength="50" /><label for="code"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">图标：</td>
                        <td>
                            <ul id="icourlwrap" class="swfuploadwrap">
                                <li><div class="swfuploadimg"><div><img src="/upfile/<% entity.write("ico"); %>"></div></div></li>
                            </ul>
                            <div>
                                <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                <br/>
                                宽度建议在：180px
                            </div>
                            <input type="hidden" name="ico" id="ico" value="<% entity.write("ico"); %>">
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">单笔限额：</td>
                        <td>
                            <input type="text" id="danbi" name="danbi" class="w100" value="<% entity.write("danbi"); %>" maxlength="5" /><label for="danbi">万</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">单日限额：</td>
                        <td>
                            <input type="text" id="danri" name="danri" class="w100" value="<% entity.write("danri"); %>" maxlength="10" /><label for="danri">万</label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改"); %></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="upload.js" type="text/javascript"></script>
        <%
            entity.outinfo();
        %>
        <script>
//            $("#danbi,#danri").bind("input propertychange",function(){
//                if(isNaN($(this).val())){
//                    $(this).val($(this).val().substring(0,$(this).val().length-1));
//                }
//            })

            $(".popupwrap").submit(function () {
                if (!$(".thisname").val().match(/^[\u4E00-\u9FA5]+$/)) {
                    alert("请填写名称正确的！")
                    return false;
                }
                if(!$("#code").val().match(/^\w+$/)){
                    alert("代码中不能有中文和符号！");
                    return false;
                }
                if (!$("#danbi,#danri").val().match(/^[0-9]+$/)) {
                    alert("金额格式错误！")
                    return false;
                }
            })
        </script>
    </body>
</html>
