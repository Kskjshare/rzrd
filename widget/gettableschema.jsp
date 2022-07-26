
<%@page import="RssEasy.MySql.DataBase"%>
<%@page import="javax.servlet.jsp.JspWriter"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <style type="text/css">
            body{display:block; width: 1000px; margin:0 auto;}
            table{ width: 100%;}
            td{ border: solid 1px gray;}
            .tablename td{font-weight: bold; font-size: 14px; border: none; padding-top: 10px; text-align: center;}
            .header td{ text-align: center; }
        </style>
    </head>
    <body>
        <table>
            <thead><tr class="header"><td>字段名称</td><td>数据类型</td><td>是否为空</td><td>默认值</td><td>扩展属性</td><td>注释</td></td></tr></thead>
            <tbody>
                <%
                    DataBase tables = new DataBase(pageContext, "");
                    tables.getTables();
                    while (tables.for_in_rows()) {
                        out.print("<tr class=\"tablename\"><td colspan=\"5\">表名：" + tables.get("Name") + "(" + tables.get("Comment") + ")</td></tr>");
                        DataBase db = new DataBase(pageContext, tables.get("Name"));
                        db.tablename = tables.get("Name");
                        db.getSchema();
                        while (db.for_in_rows()) {
                            out.print("<tr><td>" + db.get("Field") + "</td><td>" + db.get("Type") + "</td><td>" + db.get("Null") + "</td><td>" + db.get("Default") + "</td><td>" + db.get("Extra") + "</td><td>" + db.get("Comment") + "</td></tr>");
                        }
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
