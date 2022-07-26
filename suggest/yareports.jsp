<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "sort");
    entity.request();

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
            .dce{background: #dce6f5;text-indent: 10px}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default;margin: 0 auto;}
            #smalltab td{padding: 0; line-height: 28px;min-width: 30px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #smalltab tr td:first-child{background:#f0f0f0}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .uetd>ol{margin-top: 5px;}
            .uetd>ol>li{ width:525px;height: 430px;margin: 0px auto;display: none;border: #cbcbcb solid 1px}
            .uetd>ol>li label{display: block;margin-left: 25px;line-height: 36px;font-size: 14px}
            .uetd>ol>li label input{margin-right: 3px;}
            .uetd>ol>li label:first-child{margin-top: 15px}
            .cellbor thead{background:#f0f0f0 };
        </style>
    </head>
    <body>
        <div method="post" class="popupwrap">           
            <div class="uetd">
                <ul><li class="sel">数据设置</li><li>报表类型</li></ul>
                <ol>
                    <li>
                        <table id="smalltab" class="cellbor">
                            <thead><tr><td class="w30"></td><td class="w30"><input type="checkbox" name="allreport"></td><td>序号</td><td>议案编号</td><td class="w300">议案题目</td><td></td></tr></thead>
                            <tbody>
                                <%                                    entity.select().where("draft=2 and lwstate=1").get_page_asc("lwid");
                                    while (entity.for_in_rows()) {
                                %>
                                <tr><td class="w30"></td><td class="w30"><input type="checkbox" name="reportslist"></td><td><% out.print(entity.get("lwid"));%></td><td><% out.print(entity.get("realid"));%></td><td><% out.print(entity.get("title"));%></td><td></td></tr>
                                        <%
                                            }
                                        %>
                            </tbody>
                        </table>
                    </li>
                    <li>
                        <label><input type="radio" name="reporttype" url="companysat">单位目录</label>
                        <label><input type="radio" name="reporttype" url="companysat">承办单位满意度</label>
                        <label><input type="radio" name="reporttype" url="companysat">承办单位满意度</label>
                        <label><input type="radio" name="reporttype" url="suggimportant">重点建议目录</label>
                        <label><input type="radio" name="reporttype" url="suggexcellent">优秀建议目录</label>
                        <label><input type="radio" name="reporttype" url="userlist">人大代表信息名册</label>
                        <label><input type="radio" name="reporttype" url="consultation">征询意见附件</label>
                        <label><input type="radio" name="reporttype" url="suggestbill">建议表格</label>
                        <label><input type="radio" name="reporttype" url="answer">答复附件</label>
                        <!--                        <label><input type="radio" name="reporttype">单位承办议案建议数量</label>
                                                <label><input type="radio" name="reporttype">交办单</label>
                                                <label><input type="radio" name="reporttype">交办单及议案建议原件</label>
                                                <label><input type="radio" name="reporttype">议案建议办复单</label>
                                                <label><input type="radio" name="reporttype">单位办复议案建议进度表</label>
                                                <label><input type="radio" name="reporttype">办复议案建议解决程度统计</label>-->
                    </li>
                </ol>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <button type="button">生成</button>
                <%
                    Pagination pagination = new Pagination(entity, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </div>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".uetd>ol>li").eq(0).show();
            $(".uetd>ul>li").click(function () {
                var index = $(this).index()
                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>ol>li").eq(index).show().siblings().hide();
            })
            $(".footer>button").click(function () {
                console.log($("input[name='reporttype']:checked").attr("url"))
                var url = $("input[name='reporttype']:checked").attr("url");
                if (url) {
                    location.href = "../report/" + url + ".jsp";
                } else {
                    alert("请选择报表或附件类型")
                }
            })
            $("input[name='allreport']").change(function () {
                if ($(this).is(":checked")) {
                    $("input[name='reportslist']").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $("input[name='reportslist']").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })
        </script>
    </body>
</html>
