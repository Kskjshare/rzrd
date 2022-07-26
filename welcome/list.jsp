<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.SkinList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="java.util.Date,java.text.SimpleDateFormat" %>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="api.saas.TimeConvert" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);

    int dropshipping = 0;//代发货订单
    int pastorder = 0;//昨日订单
    int pastordersum = 0;//昨日交易额
    String cancashoutsum = "";

    TimeConvert timeconvert = new TimeConvert();
    RssList user = new RssList(pageContext, "user");
    RssList ordernum = new RssList(pageContext, "order");
    RssList order = new RssList(pageContext, "order");
    ordernum.request();
    String pastDate = timeconvert.dateToStamp(timeconvert.stampToDate(String.valueOf(new Date().getTime() - 24 * 60 * 60 * 1000)));
    String thisDate = timeconvert.dateToStamp(timeconvert.stampToDate(String.valueOf(new Date().getTime())));
    user.select().where("myid=" + UserList.MyID(request) + "").get_first_rows();
    ordernum.select().where("state=1").query();
    order.select().where("shijian<" + pastDate + " and shijian>" + thisDate + "").query();
    while (ordernum.for_in_rows()) {
        dropshipping++;
    }
    while (order.for_in_rows()) {
        pastorder++;
        pastordersum = pastordersum + Integer.parseInt(order.get("totalprice"));
    }
    cancashoutsum = user.get("withdraw");
    //    String str = timeconvert.stampToDate(date);
    //    String timestamp = timeconvert.dateToStamp(str);
    //    String zuotian = str.format(date);
    //     String str2 = timeconvert.stampToDate(zuotian);
    //    order.select().where("state=1").query();

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
        <!--<form method="post" id="mainwrap">-->
        <!--            <div class="toolbar">
                        <button type="button" transadapter="append" select="false">增加</button>
                        <button type="button" transadapter="edit">编辑</button>
                        <button type="button" transadapter="delete">删除</button>
                        <button type="button" transadapter="select">使用</button>
                        <input type="hidden" id="transadapter" find="[name='id']:checked" />
                    </div>-->
        <div class="bodywrap">
            <ul id="sysheader">
                <li><span>待发货订单</span><p><%out.print(dropshipping); %></p></li><li><span>昨日订单</span><p><%out.print(pastorder); %></p></li><li><span>昨日交易额</span><p><%out.print(pastordersum); %></p></li><li><span>可提现金额</span><p><%out.print(cancashoutsum);%></p></li>
            </ul>
            <h1>常用功能</h1>
            <ol id="jump">
                <li jump="goods">商品管理</li>
                <li jump="goodsd">竞拍管理</li>
                <li jump="order">订单管理</li>
                <li jump="logistics">物流管理</li>
                <li jump="driver">司机管理</li>
                <li jump="user">子账号管理</li>
            </ol>
        </div>
        <!--<div class="footer"></div>-->
        <!--</form>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script src="../js/welcome.js" type="text/javascript"></script>
        <script>
            $("#jump>li").click(function () {
                var jump = $(this).attr("jump");
                if (jump == "goodsd") {
                    parent.document.getElementById("goods").click();
                    parent.document.getElementById("goodsauctionmanagementauctionlist").click();
                }
                if (jump == "driver") {
                    parent.document.getElementById("logistics").click();
                    parent.document.getElementById("logisticsauctionmanagementauctionlist").click();
                } else {
                    parent.document.getElementById(jump).click();
                }
            })
        </script>
    </body>
</html>
