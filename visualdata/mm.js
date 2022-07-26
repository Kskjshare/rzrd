<script>
    <--地址换成从github下载的文件路径-->
    var uploadedDataURL = "js/henan.json";

    myChart.showLoading();
    $.getJSON(uploadedDataURL, function(geoJson) {
        echarts.registerMap('henan', geoJson);
        myChart.hideLoading();
        var geoCoordMap = {
            '兰考': [114.385481, 34.825227],
            '郑州市': [113.4668, 34.6234],
            '开封市': [114.311523, 34.809969],
            '洛阳市': [112.471793, 34.62387],
            '平顶山市': [113.198486, 33.775454],
            '安阳市': [114.39891, 36.108225],
            '鹤壁市': [114.306924, 35.752846],
            '新乡市': [113.938978, 35.309189],
            '焦作市': [113.249079, 35.222425],
            '濮阳市': [115.038216, 35.764093],
            '许昌市': [113.860789, 34.040073],
            '漯河市': [114.021765, 33.590883],
            '三门峡市': [111.179383, 34.783409],
            '南阳市': [112.531584, 33.019279],
            '商丘市': [115.659125, 34.44116],
            '信阳市': [114.095355, 32.146995],
            '周口市': [114.693267, 33.644758],
            '驻马店市': [114.030964, 33.034777],
            '济源市': [112.623571, 35.078872],
        };
        var moveLine = {
            'normal': [
                {"fromName": "兰考","toName": "郑州市",'coords':[[114.385481, 34.825227],[113.4668, 34.6234]]},
                {"fromName": "兰考","toName": "开封市",'coords': [[114.385481, 34.825227],[114.311523, 34.809969]]},
                {"fromName": "兰考","toName": "洛阳市",'coords': [[114.385481, 34.825227],[112.471793, 34.62387]]},
                {"fromName": "兰考","toName": "平顶山市",'coords': [[114.385481, 34.825227],[113.198486, 33.775454]]},
                {"fromName": "兰考","toName": "安阳市",'coords': [[114.385481, 34.825227],[114.39891, 36.108225]]},
                {"fromName": "兰考","toName": "鹤壁市",'coords': [[114.385481, 34.825227],[114.306924, 35.752846]]},
                {"fromName": "兰考","toName": "新乡市",'coords': [[114.385481, 34.825227],[113.938978, 35.309189]]},
                {"fromName": "兰考","toName": "焦作市",'coords': [[114.385481, 34.825227],[113.249079, 35.222425]]},
                {"fromName": "兰考","toName": "濮阳市",'coords': [[114.385481, 34.825227],[115.038216, 35.764093]]},
                {"fromName": "兰考","toName": "许昌市",'coords': [[114.385481, 34.825227],[113.860789, 34.040073]]},
                {"fromName": "兰考","toName": "漯河市",'coords': [[114.385481, 34.825227],[114.021765, 33.590883]]},
                {"fromName": "兰考","toName": "三门峡市",'coords': [[114.385481, 34.825227],[111.179383, 34.783409]]},
                {"fromName": "兰考","toName": "南阳市",'coords': [[114.385481, 34.825227],[112.531584, 33.019279]]},
                {"fromName": "兰考","toName": "商丘市",'coords': [[114.385481, 34.825227],[115.659125, 34.44116]]},
                {"fromName": "兰考","toName": "信阳市",'coords': [[114.385481, 34.825227],[114.095355, 32.146995]]},
                {"fromName": "兰考","toName": "周口市",'coords': [[114.385481, 34.825227],[114.693267, 33.644758]]},
                {"fromName": "兰考","toName": "驻马店市",'coords': [[114.385481, 34.825227],[114.030964, 33.034777]]},
                {"fromName": "兰考","toName": "济源市",'coords': [[114.385481, 34.825227],[112.623571, 35.078872]]},
            ],
            'warning': [

            ]
        };
        var data = [{
                name: '郑州市',
                value: 190
            },
            {
                name: '开封市',
                value: 190
            },
            {
                name: '洛阳市',
                value: 190
            },
            {
                name: '平顶山市',
                value: 190
            },
            {
                name: '安阳市',
                value: 190
            },
            {
                name: '鹤壁市',
                value: 90
            },
            {
                name: '新乡市',
                value: 120
            },
            {
                name: '焦作市',
                value: 120
            },
            {
                name: '濮阳市',
                value: 120
            },
            {
                name: '许昌市',
                value: 120
            },
            {
                name: '漯河市',
                value: 190
            },
            {
                name: '三门峡市',
                value: 190
            },
            {
                name: '南阳市',
                value: 190
            },
            {
                name: '商丘市',
                value: 190
            },
            {
                name: '信阳市',
                value: 190
            },
            {
                name: '周口市',
                value: 190
            },
            {
                name: '驻马店市',
                value: 90
            },
            {
                name: '济源市',
                value: 90
            },
        ];
        var max = 480,
            min = 9; // todo 
        var maxSize4Pin = 100,
            minSize4Pin = 20;

        var convertData = function(data) {
            var res = [];
            for (var i = 0; i < data.length; i++) {
                var geoCoord = geoCoordMap[data[i].name];
                if (geoCoord) {
                    res.push({
                        name: data[i].name,
                        value: geoCoord.concat(data[i].value)
                    });
                }
            }
            return res;
        };
        

        option = {
            backgroundColor: '#091c3d',
            // title: {
            //     top: 20,
            //     text: '',
            //     subtext: '',
            //     x: 'center',
            //     textStyle: {
            //         color: '#ccc'
            //     }
            // },
            title: {
                text: '河南省中医院分布图',
                x: 'center',
                textStyle: {
                    color: '#fff'
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: function(params) {
                    console.log(params.value)
                    // if (typeof(params.value)[2] == "undefined") {
                    //     return params.name + ' : ' + params.value;
                    // } else {
                        return params.name + ' : ' + params.value[2];
                    // }
                }
            },
            legend: {
                orient: 'vertical',
                y: 'bottom',
                x: 'right',
                data: ['pm2.5'],
                textStyle: {
                    color: '#fff'
                }
            },
            visualMap: {
                show: false,
                min: 0,
                max: 500,
                left: 'left',
                top: 'bottom',
                text: ['高', '低'], // 文本，默认为数值文本
                calculable: true,
                seriesIndex: [1],
                inRange: {
                    // color: ['#9074c3', '#4487d5', '#7e9e8e', '#51a2c2']
                    // color: ['#3B5077', '#031525'] // 蓝黑
                    // color: ['#ffc0cb', '#800080'] // 红紫
                    // color: ['#3C3B3F', '#605C3C'] // 黑绿
                    //color: ['#0f0c29', '#302b63', '#24243e'] // 黑紫黑
                    //color: ['#23074d', '#cc5333'] // 紫红
                    // color: ['#00467F', '#A5CC82'] // 蓝绿
                    // color: ['#1488CC', '#2B32B2'] // 浅蓝
                    // color: ['#00467F', '#A5CC82'] // 蓝绿

                }
            },
           
            geo: {
                show: true,
                map: 'henan',
                label: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: false,
                    }
                },
                roam: true,
                itemStyle: {
                    normal: {
                        areaColor: 'transparent',
                        borderColor: '#3fdaff',
                        borderWidth: 2,
                        shadowColor: 'rgba(63, 218, 255, 0.5)',
                        shadowBlur: 30
                    },
                    emphasis: {
                        areaColor: '#2B91B7',
                    }
                }
            },
            series: [
                
                {
                    type: 'map',
                    map: 'henan',
                    geoIndex: 0,
                    aspectScale: 0.75, //长宽比
                    showLegendSymbol: false, // 存在legend时显示
                    label: {
                        normal: {
                            show: true
                        },
                        emphasis: {
                            show: false,
                            textStyle: {
                                color: '#fff'
                            }
                        }
                    },
                    roam: true,
                    itemStyle: {
                        normal: {
                            areaColor: '#031525',
                            borderColor: '#FFFFFF',
                        },
                        emphasis: {
                            areaColor: '#2B91B7'
                        }
                    },
                    animation: false,
                    data: data
                },
                
                {
                    name:  '城市',
                    type: 'effectScatter',
                    coordinateSystem: 'geo',
                    zlevel: 1,
                    showEffectOn: 'render',
                    rippleEffect: {
                        scale: 3,
                        brushType: 'stroke'
                    },
                    hoverAnimation: true,   //鼠标移上去显示数据
                    label: {
                        normal: {
                            show: true,
                            position: 'right',
                            formatter: '{b}'
                        },
                        emphasis: {
                            show: true
                        }
                    },
                    symbolSize: function (val) {
                        return val[2] / 10;
                    },
                    itemStyle: {
                        normal: {
                            color: '#F4E925',
                            shadowBlur: 10,
                            shadowColor: '#05C3F9'
                        }
                    },
                    data: convertData(data),
                },
        
                // 射线样式
                {
                    name: '线路',
                    type: 'lines',
                    coordinateSystem: 'geo',
                    zlevel: 2,  //数值越大越在上面
                    large: true,
                    symbol: ['none', 'arrow'],   
                    effect: {
                        show: true,
                        period: 6,
                        constantSpeed: 30,
                        trailLength: 0,
                        symbolSize:3    //圆点大小
                    },
                    lineStyle: {
                        normal: {
                            // 线条颜色
                            color:'#0fff17',

                            width: 0.5,
                            opacity: 0.6,
                            curveness: 0.2
                        }
                    },
                    data: moveLine.normal
                },
                // 射线样式
                {
                    name:  '线路',
                    type: 'lines',
                    coordinateSystem: 'geo',
                    zlevel: 3,
                    large: true,
                    effect: {
                        show: true,
                        period: 5,
                        trailLength: 0.8,   //特效尾迹的长度
                        color: '#fff',
                        symbolSize: 3   //圆点大小
                    },
                    lineStyle: {
                        normal: {
                            // color:'#0fff17',
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: '#0fff17'
                            }, {
                                offset: 1,
                                color: '#F4E925'
                            }], false),
                            width: 0.2,
                            curveness: 0.2
                        }
                    },
                    data: moveLine.normal
                }

            ]
        };
        myChart.setOption(option);
    });
</script>