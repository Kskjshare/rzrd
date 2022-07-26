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
            #left{margin-left: .5%;margin-bottom: .5%;width: 74%;border: 1px solid #cbcbcb;height: 99%;display: inline-block;float: left;position: relative}
            #left ul{background: #82bee9;color: #fff;border: 1px solid #6caddc;margin-top: -1px;margin-left: -1px;height: 34px;cursor: pointer;}
            #left ul li{float: left;height: 25px;width: 90px;text-align: center;line-height: 28px;margin-top: 4px;border-radius: 4px;margin-left: 5px;}
            #left ul .select{background: #fff;color: #186aa3;border: 1px solid #cbcbcb;}
            #left table{margin: 5px;}
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
        </style>
    </head>
    <body>
        <div id="left">
            <ul><li class="select">统计结果</li><li>统计图形</li></ul>
            <div style="display: none;">
                <h1>提交状态</h1>
                <div id="zxt" style="width: 500px;height:300px;margin: 0 auto"></div>
                <div id="bzt" style="width: 500px;height:300px;margin: 0 auto;display: none"></div>
                <div id="qzt" style="width: 500px;height:300px;margin: 0 auto;display: none"></div>
                <div id="zzt" style="width: 500px;height:300px;margin: 0 auto;display: none"></div>
                <div id="tzt" style="width: 500px;height:300px;margin: 0 auto;display: none"></div>
                <div id="mjt" style="width: 500px;height:300px;margin: 0 auto;display: none"></div>
            </div>
            <div id="di">
                <label><input type="radio" name="photo" value="1" checked>折线图</label>
                <!--                <label><input type="radio" name="photo" value="2">饼状图</label>
                                <label><input type="radio" name="photo" value="3">圈状图</label>-->
                <label><input type="radio" name="photo" value="4">柱状图</label>
                <label><input type="radio" name="photo" value="5">条状图</label>
                <label><input type="radio" name="photo" value="6">面积图</label>
            </div>
            <table id="tablelist">
                <thead>
                    <tr>
                        <th rowspan="2" class="w30"></th>
                        <th rowspan="2" class="w150">请先进行统计生成</th>
                        <!--<th colspan="2">十二届三次</th>-->
                    </tr>
                    <tr>
                        <!--                        <th class="w70">人数</th>
                                                <th class="w70">百分比</th>-->
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <!--                        <td>1</td>
                                                <td class="line">博士</td>
                                                <td>0</td>
                                                <td>0.00%</td>-->
                    </tr>
                </tbody>
            </table>
        </div>
        <ul id="right">
            <li id="top">
                <h1>统计设置</h1>
                <select memutype="lwstate"><option value="1">按建议统计</option><option value="2">按议案统计</option></select>
                <label><input type="radio" name="state" memutype="draft">提交状态</label>
                <label><input type="radio" name="state" memutype="meet">是否会上</label>
                <label><input type="radio" name="state" memutype="methoded">处理方式</label>
                <label><input type="radio" name="state" memutype="opinioned">征求意见方式</label>
                <label><input type="radio" name="state" memutype="seconded">可否联名提出</label>
                <label><input type="radio" name="state" memutype="reviewclass">审查分类</label>
                <label><input type="radio" name="state" memutype="registertype">立案形式</label>
                <label><input type="radio" name="state" memutype="handle">办理方式</label>
                <label><input type="radio" name="state" memutype="permission">可否网上公开</label>
            </li>
            <li id="bottom">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" name="all" id="all"></th>
                            <th>届次</th>
                            <th>届次名称</th>
                            <th></th>
                        </tr>
                    <tbody>
                    <script>
                        var sessionobj = {};
                    </script>
                    <%
                        RssList list = new RssList(pageContext, "session_classify");
                        list.request();
                        list.select().where("state=1").get_page_desc("id");
                        while (list.for_in_rows()) {
                    %>
                    <tr>
                        <td><input name="id" type="checkbox" relationid="<% out.print(list.get("id")); %>" rname="<% out.print(list.get("name")); %>"></td>
                        <td><% out.print(list.get("code")); %></td>
                        <td><% out.print(list.get("name")); %></td>
                        <td></td>
                    </tr>
                    <script>
                        sessionobj[<% out.print(list.get("id")); %>] = "<% out.print(list.get("name")); %>";
//                        sessionarry.push("{"<% out.print(list.get("id")); %>":"<% out.print(list.get("name")); %>""}")  
                    </script>
                    <%
                        }
                    %>
                    </tbody>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <div>
                    <button type="submit" id="filter">过滤</button>
                    <!--<button type="submit" id="report">报表</button>-->
                    <button type="submit" id="generate">生成</button>
                </div>
            </li>
        </ul>
    </body>
</html>
<%@include  file="/inc/js.html" %>
<script src="/statistics/echarts.min.js" type="text/javascript"></script>
<script>

                        var arr = Object.keys(dictdata.opinioned);
                        var len = arr.length;
                        $("#generate").click(function () {
                            changepic();
                        })
                        var parameter;
                        var jieci;
                        var tjtitle = "";
                        var sessionthjson = {};
                        var tabtitle = "";
                        var sessionth = [];
                        function changepic() {
                            var titlearry = [];
                            var titlenum = 0;
                            var sessionarry = [];
                            var session = "";
                            sessionth = []
                            $(".ls").remove();
                            tjtitle = $("#top").find("input:checked").attr("memutype");
                            tabtitle = $("#top").find("input:checked").parent().text();
                            $.each(dictdata[tjtitle], function (key, val) {
                                titlearry.push(key);
                            })
                            titlenum = titlearry.join(",");
                            var lwstate = $("select[memutype]").val();
                            if (tjtitle == "" || tjtitle == undefined) {
                                alert("请选择统计目标");
                                return false;
                            }
                            $("input[name='id']").each(function () {
                                if ($(this).is(":checked")) {
                                    sessionarry.push($(this).attr("relationid"));
                                    sessionth.push($(this).attr("rname"));
                                    sessionthjson[$(this).attr("relationid")] = $(this).attr("rname");
                                }
                            })
                            if (sessionarry.length == "0") {
                                alert("请选择届次");
                                return false;
                            }
                            jieci = sessionarry;
                            session = sessionarry.join(",");
                            $("#tablelist>thead>tr").eq(0).find(".w150").text("项目");
                            $.each(sessionth, function (k, v) {
                                var thead1 = "<th class='ls' colspan='2'>" + v + "</th>";
                                var thead2 = "<th class='ls' >人数</th><th class='ls' >百分比</th>";
                                console.log(thead1);
                                $("#tablelist thead>tr").eq(0).append(thead1)
                                $("#tablelist thead>tr").eq(1).append(thead2)
                            })
                            popuplayer.showHtml('<div class="infowrap">正在生成，请稍候</div>', "信息提示", {"width": 300, height: 50});
                            $.get("/statistics/suggest/processing.jsp", {'lwstate': lwstate, 'session': session, 'titlenum': titlenum, 'tjtitle': tjtitle}, function (json) {
                                $("#left>ul>li:first").click();
                                var json = JSON.parse(json);
                                parameter = json
                                var tbody1 = "";
                                var xh = 1;
                                $.each(json, function (k, v) {
                                    tbody1 += "<tr class='ls'><td>" + xh + "</td><td>" + dictdata[tjtitle][k] + "</td>"
                                    $.each(v, function (ke, va) {
                                        tbody1 += "<td>" + va["num"] + "</td><td>" + zero(va["allnum"]) + "%</td>"
                                    })
                                    tbody1 += "</tr>";
                                })
                                $("#tablelist").append(tbody1);
                                popuplayer.close();
                            });
                        }
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
                        var myChart1 = echarts.init(document.getElementById('zxt'));
                        var myChart2 = echarts.init(document.getElementById('zzt'));
                        var myChart3 = echarts.init(document.getElementById('tzt'));
                        var myChart4 = echarts.init(document.getElementById('mjt'));
                        $('input[name=photo]').click(function () {
                            var xAxis = [];
                            $.each(parameter, function (k, v) {
                                xAxis.push(dictdata[tjtitle][k]);

                            })
                            var echarts = {
                                "1": function (val) {
                                    var series = [];
                                    $.each(jieci, function (k, v) {
                                        var serdata = [];
                                        $.each(parameter, function (ke, va) {
                                            serdata.push(va[v]["num"]);
                                        })
                                        var ser = {
                                            name: sessionthjson[v],
                                            type: 'line',
                                            stack: '总量',
                                            data: serdata
                                        }
                                        series.push(ser);
                                    })
                                    option = {
                                        tooltip: {
                                            trigger: 'axis',
                                            axisPointer: {
                                                type: 'cross',
                                                label: {
                                                    backgroundColor: '#6a7985'
                                                }
                                            }
                                        },
                                        legend: {
                                            data: sessionth
                                        },
                                        grid: {
                                            left: '3%',
                                            right: '4%',
                                            bottom: '3%',
                                            containLabel: true
                                        },
                                        xAxis: {
                                            type: 'category',
                                            boundaryGap: false,
                                            data: xAxis
                                        },
                                        yAxis: {
                                            type: 'value'
                                        },
                                        series: series
                                    };
                                    myChart1.setOption(option);
                                    $('#zxt').show().siblings().hide();
                                },
                                "4": function (val) {
                                    var series = [];
                                    $.each(jieci, function (k, v) {
                                        var serdata = [];
                                        $.each(parameter, function (ke, va) {
                                            serdata.push(va[v]["num"]);
                                        })
                                        var ser = {
                                            name: sessionthjson[v],
                                            type: 'bar',
                                            data: serdata
                                        }
                                        series.push(ser);
                                    })

                                    option = {
                                        tooltip: {
                                            trigger: 'axis'
                                        },
                                        legend: {
                                            data: sessionth
                                        },
                                        calculable: true,
                                        xAxis: [
                                            {
                                                type: 'category',
                                                data: xAxis,
                                            }
                                        ],
                                        yAxis: [
                                            {
                                                type: 'value'
                                            }
                                        ],
                                        series: series
                                    };
                                    myChart2.setOption(option);
                                    $('#zzt').show().siblings().hide();
                                },
                                "5": function (val) {
                                    var series = [];
                                    $.each(jieci, function (k, v) {
                                        var serdata = [];
                                        $.each(parameter, function (ke, va) {
                                            serdata.push(va[v]["num"]);
                                        })
                                        var ser = {
                                            name: sessionthjson[v],
                                            type: 'bar',
                                            data: serdata,
                                        }
                                        series.push(ser);
                                    })
                                    option = { 
                                        tooltip: {
                                            trigger: 'axis',
                                            axisPointer: {
                                                type: 'shadow'
                                            }
                                        },
                                        grid: {
                                            left: '3%',
                                            right: '4%',
                                            bottom: '3%',
                                            containLabel: true
                                        },
                                        xAxis: {
                                            type: 'value',
                                            boundaryGap: [0, 0.01]
                                        },
                                        yAxis: {
                                            type: 'category',
                                            data: xAxis
                                        },
                                        series: series
                                    };
                                    myChart3.setOption(option);
                                    $('#tzt').show().siblings().hide();
                                },
                                "6": function (val) {
                                    var series = [];
                                    $.each(jieci, function (k, v) {
                                        var serdata = [];
                                        $.each(parameter, function (ke, va) {
                                            serdata.push(va[v]["num"]);
                                        })
                                        var ser = {
                                            name: sessionthjson[v],
                                            type: 'line',
                                            stack: '总量',
                                            areaStyle: {normal: {}},
                                            data: serdata
                                        }
                                        series.push(ser);
                                    })
                                    option = {
                                        tooltip: {
                                            trigger: 'axis',
                                            axisPointer: {
                                                type: 'cross',
                                                label: {
                                                    backgroundColor: '#6a7985'
                                                }
                                            }
                                        },
                                        legend: {
                                            data: sessionth
                                        },
                                        grid: {
                                            left: '3%',
                                            right: '4%',
                                            bottom: '3%',
                                            containLabel: true
                                        },
                                        xAxis: [
                                            {
                                                type: 'category',
                                                boundaryGap: false,
                                                data: xAxis
                                            }
                                        ],
                                        yAxis: [
                                            {
                                                type: 'value'
                                            }
                                        ],
                                        series: series
                                    };
                                    myChart4.setOption(option);
                                    $('#mjt').show().siblings().hide();
                                }
                            };
                            echarts[$(this).val()]();
                        });


                        function zero(e) {
                            if (e == ".00") {
                                return "0"
                            } else {
                                return e
                            }
                        }


</script>