<%@page import="RssEasy.MySql.RssList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.addHeader("Content-Disposition", "attachment;filename=" + DateTimeExtend.format("yyyy-MM-dd") + URLEncoder.encode("考题信息", "utf-8") + ".xls");
    response.addHeader("Content-Type", "application/ms-excel");
    response.addHeader("Pragma", "no-cache");
    response.addHeader("Expires", "0");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
            <caption>考题信息</caption>
            <thead>
                <tr>
                    <th>考题类别</th>
                    <th>考题类型</th>
                    <th>题目</th>
                    <th>所有选项</th>
                    <th>答案</th>
                    <th>提示：判断题 A正确 B错误</th>
                </tr>
            </thead>
            <%
                RssList mas = new RssList(pageContext, "question_bank");
                mas.request();
                mas.pagesize = 30;
                mas.select().where("id in(" + mas.get("id") + ")").get_page_desc("id");
                int x = 1;
                while (mas.for_in_rows()) {
                    System.out.println(mas.get("type"));
                    
                    
            %>

            <tbody>
                <tr>
                    <td>
                        <%
                            switch (mas.get("type")){
                                case "1":
                                    out.print("宪法");
                                    break;
                                case "2":
                                    out.print("法院组织法");
                                    break;
                                case "3":
                                    out.print("检察官法");
                                    break;
                                case "4":
                                    out.print("人民检察院组织法");
                                    break;
                                case "5":
                                    out.print("自治条例及部份地方性法规");
                                    break;
                                case "6":
                                    out.print("监察法");
                                    break;
                                case "7":
                                    out.print("组织法");
                                    break;
                                case "8":
                                    out.print("选举法");
                                    break;
                                case "9":
                                    out.print("代表法");
                                    break;
                                case "10":
                                    out.print("自治法");
                                    break;
                                case "11":
                                    out.print("监督法");
                                    break;
                                case "12":
                                    out.print("公务员法");
                                    break;
                                case "13":
                                    out.print("行政诉讼法");
                                    break;
                                case "14":
                                    out.print("法官法");
                                    break;
                                default:
                                    out.print("");
                                    break;
                            }
                        %>
                    </td>
                    <td>
                        <%  
                            switch (mas.get("questiontype")){
                                case "1":
                                    out.print("单选");
                                    break;
                                case "2":
                                    out.print("多选");
                                    break;
                                case "3":
                                    out.print("判断");
                                    break;
                                default:
                                    out.print("");
                                break;
                            }
                           
                        %>
                    </td>
                    <td><% out.print(mas.get("title"));%></td>
                    <td><% out.print(mas.get("options"));%></td>
                    <td><% out.print(mas.get("answer"));%></td>
                    
                </tr>
            </tbody>
            <tfoot>
                <%
                        x++;
                    }
                %>
            </tfoot>    
        </table>
        <script src="/data/companytype.js" type="text/javascript"></script>
    </body>
    <ml>