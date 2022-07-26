var bingoption = [], bingtitle = [], tiaooption = [], tiaodate = [];
//                        $("#left>ul>li:first").click(function () {
//                            $(this).addClass("select").siblings("li").removeClass("select");
//                            $('#left table').show();
//                            $('#left>div').hide();
//                        });
//                        $("#left>ul>li:last").click(function () {
//                            $(this).addClass("select").siblings("li").removeClass("select");
//                            $('#left table').hide();
//                            $('#left>div').show();
//                            $('input[name=photo]').first().click();
//                        });
//                        $("[name='state']").click(function () {
//                            var memutype = $(this).attr("memutype");//统计类型
//                          var lwstatee = "1";//建议议案
//                          var sessionide ="";
//                            optionajax(memutype,lwstatee,sessionide);
//                        })
function optionajax(memutype, lwstatee, sessionide) {
    var jyya = "建议";
    if (lwstatee == "2") {
        jyya = "议案"
    }
    new Ajax("suggeststatistics").keyvalue({"state": memutype, "sessionide": sessionide, "lwstatee": lwstatee}).getJson(function (json) {
        switch (memutype) {
            case "1":
                bingoption = [], tiaodate = [], tiaooption = [];
                bingtitle = {text: jyya + '状态统计', x: 'center'}
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
                    } else if (v.draft == "2" && v.examination == "5" && v.resume == "0") {
                        state = "初审查";
                    } else {
                        state = "未知";
                    }
                    bingoption.push({value: v.num, name: state + "(" + emnull(v.sessionname) + ")"})
                    tiaooption.push(state + "(" + emnull(v.sessionname) + ")");
                    tiaodate.push(v.num);
                })
                bzt();
                break;
            case "2":
                bingoption = [], tiaodate = [], tiaooption = [];
                bingtitle = {text: '代表团' + jyya + '统计', x: 'center'}
                $.each(json, function (k, v) {
                    tiaooption.push(v.allname + "(" + emnull(v.sessionname) + ")");
                    tiaodate.push(v.num);
                    bingoption.push({value: v.num, name: v.allname + "(" + emnull(v.sessionname) + ")"})
                })
                bzt();
                break;
            case "3":
                bingoption = [], tiaodate = [], tiaooption = [];
                bingtitle = {text: '代表团办理统计', x: 'center'}
                $.each(json, function (k, v) {
                    tiaooption.push(v.delegationname + "提出" + jyya + v.allname + "办理(" + emnull(v.sessionname) + ")");
                    tiaodate.push(v.num);
                    bingoption.push({value: v.num, name: "[" + v.delegationname + "]" + v.allname + "(" + emnull(v.sessionname) + ")"})
                })
                bzt();
                break;
            case "4":
                bingoption = [], tiaodate = [], tiaooption = [];
                bingtitle = {text: '代表领衔' + jyya + '统计', x: 'center'}
                $.each(json, function (k, v) {
                    tiaooption.push(v.realname + "(" + emnull(v.sessionname) + ")");
                    tiaodate.push(v.num);
                    bingoption.push({value: v.num, name: v.realname + "(" + emnull(v.sessionname) + ")"})
                })
                bzt();
                break;
            case "5":
                bingoption = [], tiaodate = [], tiaooption = [];
                bingtitle = {text: '办理情况统计', x: 'center'}
                $.each(json, function (k, v) {
                    tiaooption.push(v.allname + "(" + emnull(v.sessionname) + ")");
                    tiaodate.push(v.num);
                    bingoption.push({value: v.num, name: v.allname + "(" + emnull(v.sessionname) + ")"})
                })
                bzt();
                break;
        }

    })
}
var emnull = function (e) {
    if (e) {
        return e
    } else {
        return "未知"
    }
}

var myChart1 = echarts.init(document.getElementById('bzt'));
//                        var myChart2 = echarts.init(document.getElementById('zzt'));
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
            left: 50,
//                                right : 10,
            bottom: 0,
            data: bingoption,
//                                selected: data.selected
        },
        grid: {
//                                    containLabel: true,
            left: '10%',
            right: '10%',
            top: '10%',
        },
        series: [
            {
                name: '实际数据',
                type: 'pie',
                radius: '35%',
                center: ['50%', '35%'],
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
//                            $('#zxt').show().siblings().hide();
}
//                        function szt() {
//                            option = {
//                                color: ['#3398DB'],
//                                tooltip: {
//                                    trigger: 'axis',
//                                    axisPointer: {// 坐标轴指示器，坐标轴触发有效
//                                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
//                                    }
//                                },
//                                grid: {
////                                    containLabel: true,
//                                     left: '35%',
//                                     right: '10%',
//                                     bottom:'10%',
//                                     y2:'140'
//                                },
//                                yAxis: 
//                                    {
//                                        type: 'category',
//                                        data: tiaooption,
//                                        axisTick: {
//                                            alignWithLabel: true
//                                        },
////                                        axisLabel: {
////                                           interval:0,
////                                           rotate:-70
////                                       }
//                                    }
//                                ,
//                                xAxis: [
//                                    {
//                                        type: 'value'
//                                    }
//                                ],
//                                series: [
//                                    {
//                                        name: '实际数据',
//                                        type: 'bar',
//                                        barWidth: '60%',
//                                        data: tiaodate
//                                    }
//                                ]
//                            };
//                            myChart2.setOption(option);
//                            $('#zxt').show().siblings().hide();
//                        }
;

