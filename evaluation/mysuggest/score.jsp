<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "opinion");
    RssListView opinion = new RssListView(pageContext, "opinion");
    RssList user = new RssList(pageContext, "user");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (req.get("action").equals("delete")) {
        entity.remove("id");
        entity.keyvalue("myid", cookie.Get("myid"));
        entity.update().where("myid=" + cookie.Get("myid") + " and proposal=" + entity.get("id")).submit();
        opinion.select().where("proposal=" + entity.get("id")).get_first_rows();
        opinion.select("allscore").where("companyid="+ opinion.get("companyid")).query();
        int userscore = 0;
        int cs = 1;
        int realscore = 0;
        while (opinion.for_in_rows()) {                
               if (!opinion.get("allscore").isEmpty()) {
                   userscore = userscore+Integer.valueOf(opinion.get("allscore"));  
                   cs++;  
                   }
            }
        if (userscore!=0) {
              realscore=userscore/(cs-1);  
            }
        user.keyvalue("zxallscore",realscore);
        out.print(opinion.get("companyid")+"?"+realscore);
       user.update().where("myid="+opinion.get("companyid")).submit();
//        PoPupHelper.adapter(out).iframereload();
//        PoPupHelper.adapter(out).showSucceed();
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
                请输入分数(0～100)<input maxlength="3" name="allscore" type="number">
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="delete" />
                <button type="submit">确认</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                var score = $("input[name='allscore']").val();
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
