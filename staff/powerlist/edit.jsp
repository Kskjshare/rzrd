<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    StaffPowerList entity = new StaffPowerList(pageContext);
    StaffPowerList queryk = new StaffPowerList(pageContext);
    entity.request().remove("id");
//    queryk.request().remove("id");
    if (!entity.get("action").isEmpty()) {
        if (entity.get("offsetid").isEmpty()) {
            throw new Exception("权限标识不能为空！");
        }
        //梁小竹修改
        //生成的querykey会重复，这里做下判断知道不重复为止
        String querykey = entity.createquerykey();
        //for(int i = 0; i < 100; i++)
        while(true)
        {
            queryk.select().where("querykey = '" + querykey + "'").get_first_rows();
            if(queryk.get("querykey") != null && !"".equals(queryk.get("querykey"))){
                Long a = Long.parseLong(querykey)+1;
                querykey = a + "";
                queryk.clear("querykey");
            }else{
                break;
            }
        }
        //梁小竹修改结束
        entity.keyvalue("querykey", querykey);
        switch (entity.get("action")) {
            case "append":
                out.print(entity.append().submit());
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        StaffList.CreateJson(pageContext);
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" class="popupwrap">
            <table class="wp100 vtop">
                <tbody>
                    <tr>
                        <td class="w300 h480">
                            <ul levelhelper="power" dict-offset="2" class="lanmubankuai"></ul>
                        </td>
                        <td>
                            <table class="wp100 cellbor">
                                <tr>
                                    <td class="tr w80">名称：
                                    </td>
                                    <td>
                                        <input type="text" id="name" name="name" class="w100" value="<% entity.write("name"); %>" maxlength="50" /><label for="name"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tr">权限标识：
                                    </td>
                                    <td>
                                        <input type="text" id="offsetid" allowinput="number" name="offsetid" class="w60" value="<% entity.write("offsetid"); %>" maxlength="50" /><label for="offsetid"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                                        <button type="submit" class="btnface"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改"); %></button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <%
            entity.outinfo();
        %>
        <script type="text/javascript">
            $(window).ready(function ()
            {
                $("[name=pid]").val([<% out.print(entity.get("entity"));%>]);
            });
        </script>
    </body>
</html>
