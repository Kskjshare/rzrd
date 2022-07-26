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
            #left table{margin: 5px;width:98%}
            #left table thead{background: #f0f0f0}
            #left table tr th{font-weight: normal;border: 1px solid #cbcbcb;font-size: 12px;height: 25px}
            #left table tr td{border: 1px solid #cbcbcb;font-size: 12px;text-align: center;height: 25px}
            #left table tr .line{text-indent: 10px;text-align: left}
            #right{margin-left: .5%;width: 24%;height: 99%;display: inline-block;margin-bottom: .5%;border-bottom: 1px solid #cbcbcb;overflow: hidden;border-top: 1px solid #cbcbcb}
            #top{border: 1px solid #cbcbcb;height: 60%;display: inline-block;width: 99.5%;display: block;margin-bottom: 1%;border-top: 0}
            #bottom{border: 1px solid #cbcbcb;height: 39%;display: inline-block;width: 99.5%;border-bottom: 0;position: relative}
            #top h1{background: #82bee9;border: 1px solid #6caddc;margin-top: -1px;margin-left: -1px;height: 34px;line-height: 34px;font-size: 12px;text-indent: 20px;margin-bottom: 10px}
            #top select{margin: 10px;height: 30px;width: 150px;font-size: 12px;text-indent: 5px;border: 1px solid #cbcbcb;}
            #top label{display: block;margin: 0 15px 8px;height: 18px;line-height: 18px;}
            #top label input{display: block;float: left;width: 17px;height: 17px;background: #fff;border: 1px solid #d2d2d2;margin-right: 12px;}
            #left>div{position: relative;margin: 5px;border: 1px solid #cbcbcb}
            #left>div h1{margin: 0;width: 100%;text-align: center;height: 30px;font-size: 12px;line-height: 30px;position: absolute;top: 20px;}
            #left #di{width: 100%;height: 35px;background: #f0f0f0;position: absolute;margin: 0;border: 0;border-top: 1px solid #cbcbcb;bottom: 0;line-height: 35px;text-align: center;display: none}
            #bzt,#zzt{width: 650px;height:650px;margin: 0 auto;}
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
                <label><input type="radio" name="state" memutype="1">民族统计</label>
                <label><input type="radio" name="state" memutype="2">性别统计</label>
                <label><input type="radio" name="state" memutype="3">学历统计</label>
                <label><input type="radio" name="state" memutype="4">学位统计</label>
                <!--<label><input type="radio" name="state" memutype="5">党派统计</label>-->
                <label><input type="radio" name="state" memutype="6">年龄统计</label>
                <label><input type="radio" name="state" memutype="7">代表团统计</label>
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
        new Ajax("delegatestatistics").keyvalue({"state": memutype}).getJson(function (json) {
            bingoption = [], tiaodate = [], tiaooption = [];
            switch (memutype) {
                case "1":
                    bingtitle = {text: '建议状态统计', x: 'center'}
                    var table = "<thead><tr><th class='w70'>序号</th><th >民族</th><th>代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(json, function (k, v) {
                        bingoption.push({value: v.num, name: dictdata["nationid"][v.nationid]})
                        tiaooption.push(dictdata["nationid"][v.nationid]);
                        tiaodate.push(v.num);
                        table += "<tr><td class='num'>" + num + "</td><td>" + dictdata["nationid"][v.nationid] + "</td><td>" + v.num + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    szt();
                    bzt();
                    break;
                case "2":
                    bingtitle = {text: '代表性别统计', x: 'center'}
                    var table = "<thead><tr><th>序号</th><th >性别</th><th >代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(json, function (k, v) {
                        bingoption.push({value: v.num, name: dictdata["sex"][v.sex]})
                        tiaooption.push(dictdata["sex"][v.sex]);
                        tiaodate.push(v.num);
                        table += "<tr><td>" + num + "</td><td>" + dictdata["sex"][v.sex] + "</td><td>" + v.num + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    szt();
                    bzt();
                    break;
                case "3":
                    bingtitle = {text: '代表学历统计', x: 'center'}
                    var table = "<thead><tr><th>序号</th><th>学历</th><th >代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(json, function (k, v) {
                        bingoption.push({value: v.num, name: dictdata["eduid"][v.eduid]})
                        tiaooption.push(dictdata["eduid"][v.eduid]);
                        tiaodate.push(v.num);
                        table += "<tr><td>" + num + "</td><td>" + dictdata["eduid"][v.eduid] + "</td><td>" + v.num + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    szt();
                    bzt();
                    break;
                case "4":
                    bingtitle = {text: '代表学位统计', x: 'center'}
                    var table = "<thead><tr><th>序号</th><th >学位</th><th >代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(json, function (k, v) {
                        bingoption.push({value: v.num, name: dictdata["degree"][v.degree]})
                        tiaooption.push(dictdata["degree"][v.degree]);
                        tiaodate.push(v.num);
                        table += "<tr><td>" + num + "</td><td>" + dictdata["degree"][v.degree] + "</td><td>" + v.num + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    szt();
                    bzt();
                    break;
                case "5":
                    bingtitle = {text: '代表党派统计', x: 'center'}
                    var table = "<thead><tr><th>序号</th><th >党派</th><th >代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(json, function (k, v) {
                        bingoption.push({value: v.num, name: dictdata["clan"][v.clan]})
                        tiaooption.push(dictdata["clan"][v.clan]);
                        tiaodate.push(v.num);
                        table += "<tr><td>" + num + "</td><td>" + dictdata["clan"][v.clan] + "</td><td>" + v.num + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    szt();
                    bzt();
                    break;
                case "6":
                    bingtitle = {text: '代表年龄统计', x: 'center'}
                    var agejson = {"num1": "20岁以下", "num2": "20岁-30岁", "num3": "30岁-40岁", "num4": "40岁-50岁", "num5": "50岁-60岁", "num6": "60岁-70岁", "num7": "70岁以上", };
                    var table = "<thead><tr><th>序号</th><th >年龄</th><th >代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(agejson, function (k, v) {
                        bingoption.push({value: json[k], name: v})
                        tiaooption.push(v);
                        tiaodate.push(json[k]);
                        table += "<tr><td>" + num + "</td><td>" + v + "</td><td>" + json[k] + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
                    szt();
                    bzt();
                    break;
                case "7":
                    bingtitle = {text: '代表团统计', x: 'center'}
                    var table = "<thead><tr><th>序号</th><th >代表团</th><th >代表人数</th></tr></thead><tdody>";
                    var num = 1;
                    $.each(json, function (k, v) {
                        bingoption.push({value: v.num, name: v.delegationname})
                        tiaooption.push(v.delegationname);
                        tiaodate.push(v.num);
                        table += "<tr><td>" + num + "</td><td>" + v.delegationname + "</td><td>" + v.num + "</td>"
                        num++;
                    })
                    table += "</tbody>"
                    $("#tablelist").append(table);
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
                  left : 60,
                  bottom: 0,
                  itemGap:4,
                          },
            series: [
                {
                    name: '实际数据',
                    type: 'pie',
                    radius: '40%',
                    center: ['50%', '50%'],
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
                left: '2%',
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
                    barWidth: '90%',
                    data: tiaodate
                }
            ]
        };
        myChart2.setOption(option);
        $('#zxt').show().siblings().hide();
    }
    ;

    $("[name='state']").first().click();



</script>