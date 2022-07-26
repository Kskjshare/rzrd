
    // echart1() 代表团建议
    // echart2() 行业建议
    // echart3() 代表学历
    // echart4() 代表党派
    // footerOne();  代表职业
    // footerTwo();  建议办理
    // footerTree(); 性别分析
    // footerFlour();履职活动
    function echart1(value,value2_parameter) {
        let obj = []; //定义新数组，传入echart图表所需要的数据格式 和字段
        obj.push({product:"汽车及装备制造业","待处理":1,"处理中":2,"已完成":3})
        obj.push({product:"电子信息工业","待处理":1,"处理中":2,"已完成":3})

        
        var month=[ "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月","10月", "11月", "12月"];                 
        var datasss = [];
        var cnt = 0 ;
        for( var i = 0 ; i < value.length ;i ++ ) {

           // datasss.push( value[i]);
            datasss.push( month[i]);
            
            cnt ++ ;
            if ( cnt > 11 )
                break;
        }
        
        
        var value2 = [];
        cnt = 0 ;
        for( var i = 0 ; i < value2_parameter.length ;i ++ ) {

            value2.push( value2_parameter[i]);
            cnt ++ ;
            if ( cnt > 11 )
                break;
        }
    
        
        var myChart1 = echarts.init(document.getElementById('main'));
        option = {
            backgroundColor: '#FFFFFF',

            title: {
                text: '七大主导工业增加值同比图',
                // subtext: '数据来自网络',
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                    
                }
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }

            },
            
            
            dataset: {
                dimensions: ['product', '待处理', '处理中', '已完成'],
                source: obj
            },
            
            grid: {
                left: '4%',
                right: '10%',
                bottom: '3%',
                containLabel: true

            },
            xAxis: [
                {
                    type: 'category',
                    data: datasss,
                    textStyle:{
                        
                    },
                    axisTick: {
                        alignWithLabel: true,
                        barBorderRadius: [0, 0, 0, 0]
                    },
                    axisLine: {
                        lineStyle: {
//                    color: "#fff"
                    color: "#000"
                          }
                    },
                    axisLabel:{
                         interval:0,//横轴信息全部显示
                         rotate:45,//度角倾斜显示
                         formatter:function(datasss){//只显示五个字 其余省略号
                             return datasss.length > 4?datasss.substring(0,4)+'...':datasss;
                         }
                     }
                }
            ],
            yAxis: [
                { 
                    // min:0, //y轴的最小值
                    // max:number, //y轴最大值
                    interval:10, //值之间的间隔
                    type: 'value',
                    axisLine: {
                        lineStyle: {
//                    color: "#fff"
                    color: "#000"
                          }
                    }
                }
            ],
            // color:"rgb(0,227,255)",
            series: [
                {
                    name: '总产值',
                    type: 'bar',
                    barWidth: '20',
                    barBorderRadius: 0,
                    data: value2,
                    itemStyle: {
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0],
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            {
                                offset: 0,
                                color: 'rgb(4,233,255)'

                            },
                            {
                                offset: 0.5,
                                color: 'rgb(255,54,254)'

                            },
                            {
                                offset: 0.5,
                                color: 'rgb(255,54,254)'

                            },
                            {
                                offset: 1,
                                color: 'rgb(2,132,254)'
                            }
                         ]),
                        },
                       
                    },
                }
            ]
        };
        myChart1.setOption(option);
        window.addEventListener("resize",function(){
            myChart1.resize();
        });
        myChart1.on('click', function (params) {
            console.log(params);
        });

    }
    function echart2() {
        var myChart2 = echarts.init(document.getElementById('main2'));
        option = {
            backgroundColor: '#FFFFFF',

            title: {
                text: '各金融机构年度存、贷款余额情况',
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            legend: {
                data: [
                    '存款余额', '贷款余额'
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }

            },
            color: [
                'rgba(91,227,226)',
                'rgba(41,120,206)',
            ],
            grid: {
                left: '3%',
                right: '10%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'value',
                boundaryGap: [
                    0, 0.01
                ],
                axisLine: {
                    lineStyle: {
//                    color: "#fff"
                    color: "#000"
                      }
                }
            },
            yAxis: {
                type: 'category',
                data: [
                    '中国银行',
                    '农业银行',
                    '建设银行',
                    '工商银行',
                    '交通银行'
                ],
                axisLine: {
                    lineStyle: {
//                    color: "#fff"
                    color: "#000"
                      }
                }

            },
            series: [
                {
                    name: '存款余额',
                    type: 'bar',
                    data: [
                        18203,
                        23489,
                        29034,
                        104970,
                        131744
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },

                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                }, {
                    name: '贷款余额',
                    type: 'bar',
                    data: [
                        19325,
                        23438,
                        31000,
                        121594,
                        134141
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                }
            ]
        };

        myChart2.setOption(option);
        window.addEventListener("resize",function(){
            myChart2.resize();
        });
    }
    function echart3(datasss1) {

    var datasss = [];
    var cnt = 0 ;
    for( var i = 0 ; i < datasss1.length ;i ++ ) {
   
        datasss.push( datasss1[i]);
        cnt ++ ;
        if ( cnt >= 3 )
            break;
    }
    

        var myChart3 = echarts.init(document.getElementById('main3'));
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '房地产开发和销售情况',
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            color: [
                'rgb(255,219,91)',
                'rgb(159,230,180)',
                'rgb(255,114,147)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '竣工面积',
                    '销售面积1',
                    '销售面积',                    
                    '销售额',
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: [
                        '35%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '62%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                color: "#fff",
                                fontSize: 12,
                                // lineHeight: 33
                                },
                            }
                    },
                    data: datasss,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart3.setOption(option);
        window.addEventListener("resize",function(){
            myChart3.resize();
        });
        myChart3.on('click', function (params) {
            //获得一个params对象；
            console.log(params );
            // if(params.value){
            //     // alert("单击了"+params.name+"柱状图");
            // }else{
            //     // alert("单击了"+params.name+"x轴标签");
            // }
        })

    }
    function echart4(dangpai) {
        var myChart4 = echarts.init(document.getElementById('main4'));

        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '代表党派构成分析',
                left: 'left',
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '群众',
                    '共青团',
                    '无党派',
                    '民主党',
                    '中国共产党'
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            color: [
                'rgba(255,219,91,.8)',
                'rgba(159,230,180,.8)',
                'rgba(255,114,147,.8)',
                'rgba(130,120,223,.8)',
                'rgba(47,197,223,.8)',
                'rgba(255,159,120,.8)',
                'rgb(231,188,242)',
                'rgb(71,96,255)',
            ],
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: [
                        '50%', '60%'
                    ],
                    center: [
                        '35%', '55%'
                    ],
                    data:dangpai,
                     
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart4.setOption(option);
        window.addEventListener("resize",function(){
            myChart4.resize();
        });
    }
    function footerOne() {
        var myChart5 = echarts.init(document.getElementById('footerOne'));
        option = {
            backgroundColor: '#FFFFFF',      
            title: {
                text: '主要工业经济指标同比',

                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            color:['rgb(155,0,255)','rgb(31,121,213)','rgb(251,1,100)','rgb(1,0,250)','rgb(255,0,250)','rgb(253,145,23)'],
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top: 30,
                data: [
                    'rose1',
                    '亏损企业亏损额',
                    '营业收入',
                    '利税总额',
                    '利润总额',
                    '应收票据和应收账款',
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  }
            },
            toolbox: {
                show: false,
                feature: {
                    mark: {
                        show: true
                    },
                    dataView: {
                        show: false,
                        readOnly: false
                    },
                    magicType: {
                        show: false,
                        type: ['pie', 'funnel']
                    },
                    restore: {
                        show: false
                    },
                    saveAsImage: {
                        show: false
                    }
                }
            },
            series: [
                {
                    name: '模式',
                    type: 'pie',
                    radius: [
                        30, 80
                    ],
                    center: [
                        '35%', '60%'
                    ],
                    roseType: 'area',
                    data: [
                        {
                            value: 10,
                            name: '亏损企业'
                        },
                        {
                            value: 5,
                            name: '亏损企业亏损额'
                        },
                        {
                            value: 15,
                            name: '营业收入'
                        },
                        {
                            value: 25,
                            name: '利税总额'
                        }, {
                            value: 20,
                            name: '利润总额'
                        }, {
                            value: 35,
                            name: '应收票据和应收账款'
                        },
                    ]
                }
            ]
        };


        myChart5.setOption(option);
        window.addEventListener("resize",function(){
            myChart5.resize();
        });

    }
    function footerTwo(obj) {
        var myChart6 = echarts.init(document.getElementById('footerTwo'));
        option2 = {
            legend: {
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                  },
                right: "2",
                top:"25"
            },
            title: {
                text: '建议办理结果',
                // subtext:"待处理               处理中              已完成",
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                     
                },
                // subtextStyle:{
                //     color: "#fff",
                //     fontSize:"8"
                  
                // },
                right: "0"
            },
            tooltip: {},
            dataset: {
                dimensions: ['product', '待处理', '处理中', '已完成'],
                source: obj
            },
            grid: {
                left: '3%',
                right: '10%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                axisLine: {
                    lineStyle: {
                        color: "#fff"
                    }
                }
            },
            yAxis: {
                axisLine: {
                    show:false,
                    lineStyle: {
                        color: "#fff"
                    }
                }
            },
            series: [
                {
                    type: 'bar',
                    barWidth: '10',
                    itemStyle: {
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [10, 10, 10, 10]
                        }
                    }
                }, {
                    type: 'bar',
                    barWidth: '30',
                    itemStyle: {
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [10, 10, 10, 10]
                        }
                    }
                }, {
                    type: 'bar',
                    barWidth: '10',
                    itemStyle: {
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [10, 10, 10, 10]
                        }
                    }
                },
            ]
        };
        myChart6.setOption(option2);
        window.addEventListener("resize",function(){
            myChart6.resize();
        });
    }
    function footerTree(number,number2,maleFormate,femaleFormate) {
        var myChart7 = echarts.init(document.getElementById('footerTree'));
        option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: ['男', '女'],
                top:"2%",
                right:"5%",
                textStyle:{
                    color:"#fff"
                }
            },
            title:{
                text:   `男女分析表\n\n\n\n                    ${number}人                 ${number}人\n\n\n\n\n`,
                subtext:`                 ${maleFormate}%            ${femaleFormate}%`,
                top:"0%",
                left:"5%",
                textStyle:{
                    color:"#fff"
                },
                subtextStyle:{
                    lineHeight:50,
                    height:100,
                    color:"rgb(21,170,228)",
                    fontSize:"20",
                    // textBorderColor:"rgba(218, 33, 33, 1)"
                },
            },
            grid: {
                left: '10%',
                right: '4%',
                top: '50%',
                height:"60",
                containLabel: true
            },
            label:{
                offset:"100"
            },
            xAxis: {
                 show:false,
                type: 'value',
                splitLine:{
                    show:false,
                }
            },
            yAxis: {
                show:false,
                type: 'category',
                data: ['数量'],
                axisTick:{
                    show:false,
                },
                axisLine:{
                    show: false,
                    lineStyle:{
                        height:"20",
                        color:"rgb(21,170,228)"
                    }
                }
            },
            series: [
                {
                    name: '男',
                    type: 'bar',
                    stack: '总量', // bar 堆叠放置
                     barWidth: '20', // 
                    label: {
                        show: true,
                        position: 'insideRight'
                    },
                    data: [number],
                    // borderRadius:"50%",
                    itemStyle:{
                        normal: {
                        color:"rgb(21,170,228)",
                        barBorderRadius: [10, 0, 0, 10],
                            label: {
                                show: false, //开启显示
                            }
                        }

                    }
                },
                {
                    name: '女',
                    type: 'bar',
                    stack: '总量',
                    label: {
                        show: true,
                        position: 'insideRight'
                    },
                    data: [number2],
                    itemStyle:{
                        normal: {
                        color:"rgb(255,119,119)",
                        barBorderRadius: [0, 10, 10, 0],
                            label: {
                                show: false, //开启显示
                            }
                        }
                    }
                }
            ]
        };
        // option = {
        //     tooltip: {
        //         formatter: '男女比例: {c}%'
        //     },
        //     title: {
        //         text: '建议性别分析',
        //         subtext: '男                                                                  女',
        //         subtextStyle: {
        //             color: "white",
        //             fontSize:16,
        //         },
        //         textStyle: {
        //             color: "white",
        //         },
        //         left: "center"
        //     },
        //     toolbox: {
        //         feature: {
        //             restore: {
        //                 show: false
        //             },
        //             saveAsImage: {
        //                 show: false
        //             }
        //         }
        //     },
        //     series: [
        //         {
        //             name: '',
        //             type: 'gauge',
        //             radius:"90%",
        //             pointer: { //指针粗细
		// 	width: 5,
                       
        //             },
        //             itemStyle:{
                            
        //                 color:"rgb(130)",
        //                 },
        //             detail: {
        //                 formatter: '{value}%',
        //                 color:"#fff",
        //             },
        //             data: [
        //                 {
        //                     value: a
        //                     // name: '男女比例'
        //                 }
        //             ],
        //             center: [
        //                 '50%', '60%'
        //             ],
        //             title: {               //设置仪表盘中间显示文字样式
        //                 textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
        //                     fontWeight: 'bolder',
        //                     fontSize: 10,
        //                     fontStyle: 'italic',
        //                     color:"white"
        //                 }
        //             },
        //             axisLabel : { //文字样式（及“10”、“20”等文字样式）
        //                 color : "#ddd",
        //                 distance : 5 //文字离表盘的距离
        //             },
        //             axisLine: {      //仪表盘轴线相关配置
        //                 show:true,
        //                 lineStyle: {
        //                     color: [  //仪表盘背景颜色渐变
        //                         [1,new echarts.graphic.LinearGradient(0, 0, 1, 0, [
        //                               {
        //                                 offset: 0.1,
        //                                 color: "rgba(21,168,229)"
        //                               },
        //                               {
        //                                 offset: 0.6,
        //                                 color: "rgba(255,119,119)"
        //                               },
        //                         ])
        //                       ]
        //                     ],
        //                     width:20,  //轴线宽度
        //                 },
                        
      
        //             }
        //         }
        //     ]
        // };

        myChart7.setOption(option);
        window.addEventListener("resize",function(){
            myChart7.resize();
        });
    }
    function footerFlour(name,value) {
        return;
        var myChart8 = echarts.init(document.getElementById('footerFlour'));
        option = {
            title: {
                text: '履职活动分析表',
                textStyle: {
                    color: "#fff"
                }
            },
            color:["rgba(21,69,125)"],
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
                show:true,
                data: ['活动次数'],
                textStyle: {
                    color: "#fff"
                },
                left:"right"
            },
            toolbox: {
                feature: {
                    saveAsImage: {
                        show: false
                    }
                }
            },
            grid: {
                left: '3%',
                right: '10%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: name,
                    axisLine: {
                        lineStyle: {
                            color: "#fff"
                        }
                    }
                }
            ],
            yAxis: [

                {   
                    type: 'value',
                    axisLine: {
                        lineStyle: {
                            color: "#fff"
                        }
                    }
                },


            ],
            series: [
                {   
                    name: '活动次数',
                    type: 'line',
                    stack: '总量',
                    areaStyle: {},
                    data: value
                }
            ]
        };

        myChart8.setOption(option);
        window.addEventListener("resize",function(){
            myChart8.resize();
        });
    }

    function footerTwoooo() {
        var myChart6 = echarts.init(document.getElementById('footerTwo'));

        option2 = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
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
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '直接访问',
                    type: 'bar',
                    barWidth: '60%',
                    data: [10, 52, 200, 334, 390, 330, 220]
                }
            ]
        };
        
        myChart6.setOption(option2);
        window.addEventListener("resize",function(){
            myChart6.resize();
        });
    }

