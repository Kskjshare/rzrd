<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "companyscore");
    RssList entity2 = new RssList(pageContext, "companyscore");
    RssList user = new RssList(pageContext, "user");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (req.get("action").equals("delete")) {
        entity.remove("id");
        entity.keyvalue("companyid", entity.get("id"));
        entity.keyvalue("myid", cookie.Get("myid"));
        entity.timestamp();
        entity.append().submit();
        entity2.select("score").where("companyid=" + entity.get("id")).query();
        int allscore = 0;
        int allnum = 0;
        while (entity2.for_in_rows()) {
            allnum++;
            allscore = allscore + Integer.parseInt(entity2.get("score"));
        }
        allscore = allscore / allnum;
        user.keyvalue("allscore", allscore);
        user.update().where("myid=" + entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
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
        <style>
            .infowrap>input{vertical-align:middle;margin-left: 10px;width: 100px;}   
            .infowrap{line-height: 32px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div class="infowrap">
                请输入分数(0～100)<input maxlength="3" name="score" type="number">
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                var score = $("input[name='score']").val();
                var match11 = /^\d{1,3}$/;
                if (match11.test(score)) {
                    score = parseInt(score)
                    if (score > 100) {
                        alert("分数最大为100")
                        return false;
                    }
                } else {
                    alert("评分应为纯数字")
                    return false;
                }
            })
        </script>
    </body>
</html>
