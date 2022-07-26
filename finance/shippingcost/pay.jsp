 <%@page import="RssEasy.MySql.User.UserBankListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Fund.WithdrawList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    WithdrawList entity = new WithdrawList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id", "myid").keyvalue("staffmyid", UserList.MyID(request));
        entity.keyvalue("state", 1);
        entity.update().where("id=? and state=2", entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    if (entity.select("myid,fee").where("id=? and state=1", entity.get("id")).get_first_rows() == false) {
        PoPupHelper.adapter(out).showDisabled("未审核通过");
    }
    UserBankListView bank = new UserBankListView(pageContext);
    bank.select("name,cardno").where("myid=?",entity.get("myid")).query();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <input type="hidden" name="myid" value="<% entity.write("myid"); %>"/>
                <input type="hidden" name="fee" value="<% entity.write("fee"); %>"/>
                <p dict-radio="paychannel" dict-name="channelid" def="2"></p>
                <br />
                <table class="cellbor wp100">
                    <thead>
                        <tr>
                            <th>银行</th>
                            <th>卡号</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (bank.for_in_rows()) {                                
                                out.print("<tr><td>"+bank.get("name")+"</td><td>"+bank.get("cardno")+"</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit" class="btnface">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
