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
            #top h1{background: #82bee9;border: 1px solid #6caddc;margin-top: -1px;margin-left: -1px;height: 34px;line-height: 34px;font-size: 12px;text-indent: 20px;margin-bottom: 0}
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
             #bzt{width: 700px;height:400px;margin: 0 auto;}
            #zzt{width: 800px;height:500px;margin: 0 auto;}
            #bottom td em{display: block;}
        </style>
    </head>
    <body>
        <div id="left">
            <ul><li class="select" style="font-size:14px;font-family: 微软雅黑">统计结果</li><li style="font-size:14px;font-family: 微软雅黑" >统计图形</li></ul>
            <div style="display: none;font-size:14px;font-family: 微软雅黑">
                <div id="bzt"></div>
                <div id="zzt"></div>
            </div>
            <table id="tablelist">
            </table>
        </div>
        <ul id="right">
            <li  style="font-size:13px;font-family: 微软雅黑" id="top">
                <h1 style="font-size:14px;fon-family: 微软雅黑">统计设置</h1>
                <select style="font-size:13px;font-family: 微软雅黑" memutype="lwstate"><option value="1">按建议统计</option><option value="2">按议案统计</option></select>
                <label><input style="font-size:14px;font-family: 微软雅黑" type="radio" name="state" memutype="1">建议状态统计</label>
                <label><input style="font-size:14px;font-family: 微软雅黑" type="radio" name="state" memutype="2">代表团建议统计</label>
                <label><input style="font-size:14px;font-family: 微软雅黑" type="radio" name="state" memutype="3">代表团办理统计</label>
                <!--<label><input type="radio" name="state" memutype="4">代表领衔建议统计</label>-->
                <label><input style="font-size:14px;font-family: 微软雅黑" type="radio" name="state" memutype="5">办理情况统计</label>
            </li>
            <li id="bottom">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" name="all" id="all"></th>
                            <th style="font-size:18px;font-family: 微软雅黑">届次</th>
                            <th style="font-size:18px;font-family: 微软雅黑">届次名称</th>
                            <th style="font-size:18px;font-family: 微软雅黑">年份</th>
                        </tr>
                    <tbody>
                    <%
                        RssList list = new RssList(pageContext, "session_classify");
                        list.request();
                        list.select().where("state=1").get_page_desc("id");
                        while (list.for_in_rows()) {
                    %>
                    <tr>
                        <td><input checked="checked" name="id" type="checkbox" relationid="<% out.print(list.get("id")); %>" rname="<% out.print(list.get("name")); %>"></td>
                        <td><% out.print(list.get("code")); %></td>
                        <td><% out.print(list.get("name")); %></td>
                        <td><em rssdate="<% out.print(list.get("year"));%>,yyyy-MM-dd"></em>&Tilde;<em rssdate="<% out.print(list.get("endyear"));%>,yyyy-MM-dd"></em></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
<!--                <div>
                    <button type="submit" id="filter">过滤</button>
                    <button type="submit" id="report">报表</button>
                    <button type="submit" id="generate">生成</button>
                </div>-->
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
                          var lwstatee = $("[memutype='lwstate']").val();
                          var arry = [];
                          $("[name='id']").each(function () {
                                if ($(this).is(":checked")) {
                                  arry.push($(this).attr("relationid"))  
                                }
                            })
                          var sessionide =arry.join(",");
                            optionajax(memutype,lwstatee,sessionide);
                        })
                        function optionajax(memutype,lwstatee,sessionide) {
    new Ajax("suggeststatistics").keyvalue({"state": memutype,"sessionide":sessionide,"lwstatee":lwstatee}).getJson(function (json) {
                                switch (memutype) {
                                    case "1":
                                        bingoption = [], tiaodate = [], tiaooption = [];
                                        bingtitle = {text: '状态统计', x: 'center'}
                                        var table = "<thead><tr><th class='70'>状态</th><th >统计</th><th >届次</th></tr></thead><tdody>";
                                        $.each(json, function (k, v) {
                                            var state = "";
                                            if (v.draft == "1") {
                                                state = "草稿"
                                            } else if (v.examination == "1" && v.draft == "2") {
                                                state = "待审查";
                                            } else if (v.examination == "2" && v.deal == "0" && v.draft == "2") {
                                                state = "交办中";
                                            } else if (v.deal == "1" && v.resume == "0") {
                                                state = "办理中";
                                            } else if (v.deal == "1" && v.resume == "1") {
                                                state = "已答复";
                                            } else if (v.examination == "3") {
                                                state = "已置回";
                                            } else if (v.draft == "2" && v.examination == "5"&& v.resume == "0") {
                                                state = "初审查";
                                            }else{
                                                state = "未知";
                                            }
                                            bingoption.push({value: v.num, name: state + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")"})
                                            tiaooption.push(state + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")");
                                            tiaodate.push(v.num);
                                            table += "<tr sid='" + v.sessionid + "'><td>" + state + "</td><td>" + v.num + "</td><td>" + emnull(dictdata["sessionclassify"][v.sessionid]) + "</td>"
                                        })
                                        table += "</tbody>"
                                        $("#tablelist").append(table);
                                        szt();
                                        bzt();
                                        break;
                                    case "2":
                                        bingoption = [], tiaodate = [], tiaooption = [];
                                        bingtitle = {text: '代表团建议统计', x: 'center'}
                                        var table = "<thead><tr><th>代表团名称</th><th >建议数量</th><th >届次</th></tr></thead><tdody>";
                                        $.each(json, function (k, v) {
                                            tiaooption.push(v.allname + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")");
                                            tiaodate.push(v.num);
                                            bingoption.push({value: v.num, name: v.allname + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")"})
                                            table += "<tr sid='" + v.sessionid + "'><td>" + v.allname + "</td><td>" + v.num + "</td><td>" + emnull(dictdata["sessionclassify"][v.sessionid]) + "</td>"
                                        })
                                        table += "</tbody>"
                                        $("#tablelist").append(table);
                                        szt();
                                        bzt();
                                        break;
                                    case "3":
                                        bingoption = [], tiaodate = [], tiaooption = [];
                                        bingtitle = {text: '代表团办理统计', x: 'center'}
                                        var table = "<thead><tr><th>代表团名称</th><th>单位名称</th><th >建议数量</th><th >届次</th></tr></thead><tdody>";
                                        $.each(json, function (k, v) {
                                            tiaooption.push(v.delegationname + "提出建议" + v.account + "办理(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")");
                                            tiaodate.push(v.num);
                                            bingoption.push({value: v.num, name: v.delegationname + "提出建议" + v.account + "办理(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")"})
                                            table += "<tr sid='" + v.sessionid + "'><td>" + v.delegationname + "</td><td>" + v.account + "</td><td>" + v.num + "</td><td>" + emnull(dictdata["sessionclassify"][v.sessionid]) + "</td>"
                                        })
                                        table += "</tbody>"
                                        $("#tablelist").append(table);
                                        szt();
                                        bzt();
                                        break;
                                    case "4":
                                        bingoption = [], tiaodate = [], tiaooption = [];
                                        bingtitle = {text: '代表领衔建议统计', x: 'center'}
                                        var table = "<thead><tr><th>领衔代表名称</th><th >建议数量</th><th >届次</th></tr></thead><tdody>";
                                        $.each(json, function (k, v) {
                                            tiaooption.push(v.realname + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")");
                                            tiaodate.push(v.num);
                                            bingoption.push({value: v.num, name: v.realname + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")"})
                                            table += "<tr sid='" + v.sessionid + "'><td>" + v.realname + "</td><td>" + v.num + "</td><td>" + emnull(dictdata["sessionclassify"][v.sessionid]) + "</td>"
                                        })
                                        table += "</tbody>"
                                        $("#tablelist").append(table);
                                        szt();
                                        bzt();
                                        break;
                                    case "5":
                                        bingoption = [], tiaodate = [], tiaooption = [];
                                        bingtitle = {text: '办理情况统计', x: 'center'}
                                        var table = "<thead><tr><th>办理单位名称</th><th >办理数量</th><th >届次</th></tr></thead><tdody>";
                                        $.each(json, function (k, v) {
                                            tiaooption.push(v.account + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")");
                                            tiaodate.push(v.num);
                                            bingoption.push({value: v.num, name: v.account + "(" + emnull(dictdata["sessionclassify"][v.sessionid]) + ")"})
                                            table += "<tr sid='" + v.sessionid + "'><td>" + v.account + "</td><td>" + v.num + "</td><td>" + emnull(dictdata["sessionclassify"][v.sessionid]) + "</td>"
                                        })
                                        table += "</tbody>"
                                        $("#tablelist").append(table);
                                        szt();
                                        bzt();
                                        break;
                                }

                            })
}
                        var emnull = function (e) {
                            if (e) {
                                return e[0]
                            } else {
                                return "未知"
                            }
                        }
                        $("#bottom input").change(function () {
                            $("[name='state']:checked").click();
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
//                                type: 'scroll',
                                orient: 'horizontal',
                                left : 80,
//                                right : 10,
                                bottom: 0,
                                data: bingoption,
//                                selected: data.selected
                          },
                                grid: {
//                                    containLabel: true,
                                     left: '40%',
                                     right: '40%',
                                     bottom:'10%',
                                },
                                series: [
                                    {
                                        name: '实际数据',
                                        type: 'pie',
                                        radius: '35%',
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
//                                    containLabel: true,
                                     left: '35%',
                                     right: '10%',
                                     bottom:'10%',
                                     y2:'140'
                                },
                                yAxis: 
                                    {
                                        type: 'category',
                                        data: tiaooption,
                                        axisTick: {
                                            alignWithLabel: true
                                        },
//                                        axisLabel: {
//                                           interval:0,
//                                           rotate:-70
//                                       }
                                    }
                                ,
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
                        ;

                        $("[name='state']").first().click();




</script>