<%@page import="RssEasy.MySql.RssListView"%>
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
            .tablechuang{border: 1px solid #6caddc;position: relative}
            .tablechuang td{padding: 5px 5px;border: 1px solid #6caddc;}
            .tablechuang tr .blue{text-align: center;color: #fff;background: #82bee9;}
            .tablechuang tr  .tdd{text-align: center;background: #dce6f5;font-size: 14px;}
            .tablechuang tr  .td{height: 200px;background: #dce6f5;}
            .input{height: 20px;border:1px solid #909090;background: #fff}
            #ullist{position: relative;}
            #ullist>div{position: absolute;background: #fff;width: 98%;z-index: 2;display: none; overflow: auto; max-height: 200px;}
            #ullist>div>table{;width: 98%;margin: 5px auto;}
            #ullist>div>table th{border:solid 1px #cbcbcb;text-align: center;background: #f0f0f0}
            #ullist>div>table td{border:solid 1px #cbcbcb;text-align: center}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="auto tablechuang">
                    <tr>
                        <td style="font-size:16px;font-family: 微软雅黑" colspan="4" class="backdce blue">确定承办单位情况</td>
                    </tr>
                    <tr>
                        <td class="w100 tdd" style="font-size:18px;font-family: 微软雅黑">主办单位：</td>
                        <td id="ullist"><input style="font-size:18px;font-family: 微软雅黑" type="text" readonly="readonly" class="input w500" name="fenlei"/>
                            <div>
                                <table><thead><tr style="font-size:18px;font-family: 微软雅黑"><th>编号</th><th style="font-size:18px;font-family: 微软雅黑">姓名</th><th style="font-size:18px;font-family: 微软雅黑">职务</th><th></th></tr></thead>
                                    <tbody>
                                        <%
                                            RssListView list = new RssListView(pageContext, "userrole");
                                            list.request();
                                            list.select().where("state=2").get_page_desc("myid");
                                            while (list.for_in_rows()) {
                                        %>
                                        <tr relationid="<% out.print(list.get("myid")); %>" code="<% out.print(list.get("code")); %>" realname="<% out.print(list.get("realname")); %>" job="<% out.print(list.get("job")); %>"><td><% out.print(list.get("code")); %></td><td><% out.print(list.get("realname")); %></td><td><% out.print(list.get("job")); %></td><td></td></tr>
                                                <%
                                                    }
                                                %>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr><td colspan="4" class="td"><a style="font-size:18px;font-family: 微软雅黑" class="submission">确定</a></td></tr>
                </table>
            </div>
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
//            $('input').click(function () {
//                $("#ullist>div").show();
//            });
//            $("input").bind('input propertychange', function () {
//                $("#ullist>div").show();
//                var allname = $(this).val()
//                $("[relationid]").each(function () {
//                    var code = $(this).attr("code");
//                    var realname = $(this).attr("realname");
//                    if (code.indexOf(allname) != "-1" || realname.indexOf(allname) != "-1") {
//                        $(this).show();
//                    } else {
//                        $(this).hide();
//                    }
//                })
//            });
//            $("[relationid]").off("click").click(function () {
//                var realname = $(this).attr("realname");
//                $("#ullist>input").val(realname);
//                $("#ullist>div").hide();
//            })
                  $('input[name="fenlei"]').click(function () {
                var t = $(this);
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                    t.val(dict.myname);
                }
                RssWin.open("/selectwin/selectoneuser.jsp?state=3",450,550);
            });
            $('a').unbind().click(function () {
                var text = $("input").val();
                if (text != "") {
                    var nextPage = "list.jsp?realname=" + text;
                    var urla = encodeURI(nextPage)
                    window.location = urla;
                } else {
                    alert("请选择提出者")
                }
            })
        </script>
    </body>
</html>
