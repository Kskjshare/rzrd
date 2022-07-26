<%-- 
    Document   : proposal
    Created on : 2018-5-22, 15:25:14
    Author     : Administrator
--%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList suggest = new RssList(pageContext, "suggest");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #left{margin-left: .5%;margin-bottom: .5%;width: 74%;border: 1px solid #cbcbcb;height: 99%;display: inline-block;float: left;position: relative;overflow: auto;}
            #left ul{background: #82bee9;color: #fff;border: 1px solid #6caddc;margin-top: -1px;margin-left: -1px;height: 34px;cursor: pointer;}
            #left ul li{float: left;height: 25px;width: 90px;text-align: center;line-height: 28px;margin-top: 4px;border-radius: 4px;margin-left: 5px;}
            #left ul .select{background: #fff;color: #186aa3;border: 1px solid #cbcbcb;}
            #left table{margin: 5px;width: 98%}
            #left table thead{background: #f0f0f0}
            #left table tr th{font-weight: normal;border: 1px solid #cbcbcb;font-size: 12px;height: 25px}
            #left table tr td{border: 1px solid #cbcbcb;font-size: 12px;text-align: center;height: 25px}
            #left table tr .line{text-indent: 10px;text-align: left}
            #right{margin-left: .5%;width: 24%;height: 99%;display: inline-block;margin-bottom: .5%;border-bottom: 1px solid #cbcbcb;overflow: hidden;border-top: 1px solid #cbcbcb}
            #top{border: 1px solid #cbcbcb;height: 60%;display: inline-block;width: 99.5%;display: block;margin-bottom: 1%;border-top: 0}
            #bottom{border: 1px solid #cbcbcb;height: 39%;display: inline-block;width: 99.5%;border-bottom: 0;position: relative}
            #top h1{background: #82bee9;border: 1px solid #6caddc;margin-top: -1px;margin-left: -1px;height: 34px;line-height: 34px;font-size: 12px;text-indent: 20px;margin-bottom: 10px;}
            #top select{margin: 10px;height: 30px;width: 150px;font-size: 12px;text-indent: 5px;border: 1px solid #cbcbcb;}
            #top label{display: block;margin: 0 15px 8px;height: 18px;line-height: 18px;}
            #top label input{display: block;float: left;width: 17px;height: 17px;background: #fff;border: 1px solid #d2d2d2;margin-right: 12px;}
            #bottom table tr th,#bottom table tr td{font-weight: normal;border-bottom: 1px solid #cbcbcb;font-size: 12px;height: 20px;border-right:1px solid #cbcbcb;}
            #bottom table tr td{text-align: center}
            #bottom table{width: 100%}
            #bottom table thead{background: #f0f0f0;width: 100%}
            #bottom table tr th:first-child{width: 30px}
            #bottom table tr th:nth-child(2){width: 70px}
            #bottom table tr th:nth-child(3){width: 100px;}
            #bottom>div{height: 50px;border-top: 1px solid #cbcbcb;position: absolute;bottom: 0;width: 100%}
            #bottom>div button{float: right;width: 48px;height: 24px;border: 1px solid #6caddc;font-size: 12px;margin-right: 24px;margin-top: 15px;color: #fff}
            #bottom>div #generate{background: #186aa3}
            #bottom>div #report{background: #82bee9}
            #bottom>div #filter{background: #a79012}
            #left>div{position: relative;margin: 5px;border: 1px solid #cbcbcb}
            #left>div h1{margin: 0;width: 100%;text-align: center;height: 30px;font-size: 12px;line-height: 30px;position: absolute;top: 20px;}
            #left #di{width: 100%;height: 35px;background: #f0f0f0;position: absolute;margin: 0;border: 0;border-top: 1px solid #cbcbcb;bottom: 0;line-height: 35px;text-align: center;display: none}
            #bzt,#zzt{width: 500px;height:600px;margin: 0 auto;}
        </style>
    </head>
    <body>
        <div id="left">
            <ul><li class="select">统计结果</li><li>统计图形</li></ul>
            <div style="display: none;">
                <div id="bzt"></div>
                <div id="zzt"></div>
            </div>
            <table id="tablelist">
            </table>
        </div>
        <ul id="right">
            <li id="top">
                <h1>统计设置</h1>
                <!--<select memutype="lwstate"><option value="1">按建议统计</option><option value="2">按议案统计</option></select>-->
                <label><input type="radio" name="state" memutype="1">建议统计</label>
                <label><input type="radio" name="state" memutype="2">议案统计</label>
                <label><input type="radio" name="state" memutype="3">活动统计</label>
            </li>
        </ul>
    </body>
</html>
<%@include  file="/inc/js.html" %>
<script src="/data/session.js"></script>
<script src="/statistics/echarts.min.js" type="text/javascript"></script>
<script>
    var bingoption = [], bingtitle = [], tiaooption = [], tiaodate = [];
    $("#left>ul>li:first").click(function () {
        $(this).addClass("select").siblings("li").removeClass("select");
        $('#left table').show();
        $('#left>div').hide();
    });
    $("#left>ul>li:last").click(function () {
        $(this).addClass("select").siblings("li").removeClass("select");
        $('#left table').hide();
        $('#left>div').show();
        $('input[name=photo]').first().click();
    });
    $("[name='state']").click(function () {
        $("#tablelist").empty();
        var memutype = $(this).attr("memutype");
        new Ajax("lvzhistatistics").keyvalue({"state": memutype}).getJson(function (json) {
            switch (memutype) {
                case "1":
                    bingoption = [], tiaodate = [], tiaooption = [];
                    bingtitle = {text: '建议统计', x: 'center'}
                    var table = "<thead><tr><th>代表姓名</th><th >代表证号</th><th >代表团</th><th>领衔提交</th><th >联名提交</th><th >总计</th></tr></thead><tdody>";
                    $.each(json[0], function (k, v) {
                        table += "<tr sid='" + v.myid + "'><td>" + v.realname + "</td><td>" + v.code + "</td><td>" + v.delegationname + "</td><td class='lx'>0</td><td class='lm'>0</td><td class='suball'></td>"
                    })

                    table += "</tbody>"
                    $("#tablelist").append(table);
                    $.each(json[1], function (k, v) {
                        $("[sid='" + v.userid + "']").find(".lm").text(v.num)
                    })
                    $.each(json[2], function (k, v) {
                        $("[sid='" + v.myid + "']").find(".lx").text(v.num)

                    })
                    $("[sid]").each(function () {
                        var lx = parseInt($(this).find(".lx").text());
                        var lm = parseInt($(this).find(".lm").text());
                        $(this).find(".suball").text(lx + lm);
                        if ($(this).find(".suball").text() != "0") {
                            bingoption.push({value: $(this).find(".suball").text(), name: $(this).find("td").eq(0).text()})
                            tiaooption.push($(this).find("td").eq(0).text());
                            tiaodate.push($(this).find(".suball").text())
                        }
                    })
                    szt();
                    bzt();
                    break;
                case "2":
                    bingoption = [], tiaodate = [], tiaooption = [];
                    bingtitle = {text: '议案统计', x: 'center'}
                    var table = "<thead><tr><th>代表姓名</th><th >代表证号</th><th >代表团</th><th>领衔提交</th><th >联名提交</th><th >总计</th></tr></thead><tdody>";
                    $.each(json[0], function (k, v) {
                        table += "<tr sid='" + v.myid + "'><td>" + v.realname + "</td><td>" + v.code + "</td><td>" + v.delegationname + "</td><td class='lx'>0</td><td class='lm'>0</td><td class='suball'></td>"
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    $.each(json[1], function (k, v) {
                        $("[sid='" + v.userid + "']").find(".lm").text(v.num)
                    })
                    $.each(json[2], function (k, v) {
                        $("[sid='" + v.myid + "']").find(".lx").text(v.num)

                    })
                    $("[sid]").each(function () {
                        var lx = parseInt($(this).find(".lx").text());
                        var lm = parseInt($(this).find(".lm").text());
                        $(this).find(".suball").text(lx + lm);
                        if ($(this).find(".suball").text() != "0") {
                            bingoption.push({value: $(this).find(".suball").text(), name: $(this).find("td").eq(0).text()})
                            tiaooption.push($(this).find("td").eq(0).text());
                            tiaodate.push($(this).find(".suball").text())
                        }
                    })
                    szt();
                    bzt();
                    break;
                case "3":
                    bingoption = [], tiaodate = [], tiaooption = [];
                    bingtitle = {text: '活动统计', x: 'center'}
                    var table = "<thead><tr><th>代表姓名</th><th >代表证号</th><th >代表团</th><th>报名次数</th><th >考勤次数</th><th >缺席次数</th></tr></thead><tdody>";
                    $.each(json[0], function (k, v) {
                        table += "<tr sid='" + v.myid + "'><td>" + v.realname + "</td><td>" + v.code + "</td><td>" + v.delegationname + "</td><td class='bm'>0</td><td class='kq'>0</td><td class='qx'>0</td>"
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    $.each(json[1], function (k, v) {
                        if (v.jointype == "2" && v.attendancetype == "2") {
                            $("[sid='" + v.userid + "']").find(".kq").text(v.num)
                        }
                        if (v.jointype == "2" && v.attendancetype == "1") {
                            $("[sid='" + v.userid + "']").find(".qx").text(v.num)
                        }
                    })
                    $("[sid]").each(function () {
                        var lx = parseInt($(this).find(".kq").text());
                        var lm = parseInt($(this).find(".qx").text());
                        $(this).find(".bm").text(lx + lm);
                        if ($(this).find(".bm").text() != "0") {
                            bingoption.push({value: $(this).find(".bm").text(), name: $(this).find("td").eq(0).text()})
                            tiaooption.push($(this).find("td").eq(0).text());
                            tiaodate.push($(this).find(".bm").text())
                        }
                    })
                    szt();
                    bzt();
                    break;
            }

        })
    })
    var myChart1 = echarts.init(document.getElementById('bzt'));
    var myChart2 = echarts.init(document.getElementById('zzt'));
    function bzt() {
        option = {
            title: bingtitle,
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                  orient: 'horizontal',
                  left : 80,
                  bottom: 0,
                          },
            series: [
                {
                    name: '实际数据',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '55%'],
                    data: bingoption,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart1.setOption(option);
        $('#zxt').show().siblings().hide();
    }
    function szt() {
        option = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {// 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            yAxis: [
                {
                    type: 'category',
                    data: tiaooption,
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            xAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '实际数据',
                    type: 'bar',
                    barWidth: '60%',
                    data: tiaodate
                }
            ]
        };
        myChart2.setOption(option);
        $('#zxt').show().siblings().hide();
    }

    $("[name='state']").first().click();


</script>