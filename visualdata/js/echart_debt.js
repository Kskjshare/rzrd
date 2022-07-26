
    // echart1() 代表团建议
    // echart2() 行业建议
    // echart3() 代表学历
    // echart4() 代表党派
    // footerOne();  代表职业
    // footerTwo();  建议办理
    // footerTree(); 性别分析
    // footerFlour();履职活动
  
 
   

    function echart_main_1(  ) { 
    var main_1 = echarts.init(document.getElementById('main_1'));
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '机关案件分类统计表-检察院',
                left: 'left',
                textStyle: {
                    color: "#000"
                   
                }
            },
//            color:['rgb(155,0,255)','rgb(31,121,213)','rgb(251,1,100)','rgb(1,0,250)','rgb(255,0,250)','rgb(253,145,23)'],
            color:['rgb(155,0,255)','rgb(251,1,100)','rgb(253,145,23)','rgb(255,0,250)'],

            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top: 30,
                data: [
                    '刑事',
                    '民事',
                    '行政',
                    '执行',
                ],
                textStyle: {
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
                    name: '案件类型',
                    type: 'pie',
                    radius: [
                        60, 120
                    ],
                    center: [
                        '50%', '50%'
                    ],
                    
                  labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

                                fontSize: 12,
                                // lineHeight: 33
                                },
                            }
                    },    
                    
                    roseType: 'area',
                    data: [
                        {
                            value: 5,
                            name: '刑事'
                        },
                        {
                            value: 15,
                            name: '民事'
                        },
                        {
                            value: 25,
                            name: '行政'
                        }, {
                            value: 20,
                            name: '执行'
                        }, 

                    ]
                }
            ]
        };


        main_1.setOption(option);
        window.addEventListener("resize",function(){
            main_1.resize();
        });

    }
    
    function echart_main_2( datasss ) { 
    var main_2 = echarts.init(document.getElementById('main_2'));
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '机关案件分类统计表-人民法院',
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
                    //color: "#fff"
                    color: "#000",
 
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
                'rgb(130,120,223)',
//                'rgb(47,197,223)',
//                'rgb(255,159,120)',
//                'rgb(231,188,242)',
//                'rgb(71,96,255)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '刑事',
                    '民事',
                    '行政',                    
                    '执行',
                ],
                textStyle: {
//                    color: "#fff",
                    color: "#000",

                }
            },
            series: [
                {
                    name: '案件数量',
                    type: 'pie',
                    radius: [
                        '0%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '50%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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


        main_2.setOption(option);
        window.addEventListener("resize",function(){
            main_2.resize();
        });

    }
      
      
     function echart_main_3(  ) { 
    var main_3 = echarts.init(document.getElementById('main_3'));
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '机关案件分类统计表-监察委',
                left: 'left',
                textStyle: {
                    color: "#000"
                   
                }
            },
//            color:['rgb(155,0,255)','rgb(31,121,213)','rgb(251,1,100)','rgb(1,0,250)','rgb(255,0,250)','rgb(253,145,23)'],
            color:['rgb(155,0,255)','rgb(251,1,100)','rgb(253,145,23)','rgb(255,0,250)'],

            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top: 30,
                data: [
                    '刑事',
                    '民事',
                    '行政',
                    '执行',
                ],
                textStyle: {
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
                    name: '案件类型',
                    type: 'pie',
                    radius: [
                        0, 120
                    ],
                    center: [
                        '50%', '50%'
                    ],
                    
                  labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

                                fontSize: 12,
                                // lineHeight: 33
                                },
                            }
                    },    
                    
                    roseType: 'area',
                    data: [
                        {
                            value: 5,
                            name: '刑事'
                        },
                        {
                            value: 15,
                            name: '民事'
                        },
                        {
                            value: 25,
                            name: '行政'
                        }, {
                            value: 20,
                            name: '执行'
                        }, 

                    ]
                }
            ]
        };


        main_3.setOption(option);
        window.addEventListener("resize",function(){
            main_3.resize();
        });

    }
    
    
    
    function echart_main_4( datasss ) { 
    var main_4 = echarts.init(document.getElementById('main_4'));
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '机关案件分类统计表-公安局',
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            color: [
//               'rgb(255,219,91)',
//                'rgb(159,230,180)',
//                'rgb(255,114,147)',
//                'rgb(130,120,223)',
                'rgb(47,197,223)',
                'rgb(255,159,120)',
                'rgb(231,188,242)',
                'rgb(71,96,255)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '刑事',
                    '民事',
                    '行政',                    
                    '执行',
                ],
                textStyle: {
                    color: "#000",

                }
            },
            series: [
                {
                    name: '案件数量',
                    type: 'pie',
                    radius: [
                        '0%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '50%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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
 
        main_4.setOption(option);
        window.addEventListener("resize",function(){
            main_4.resize();
        });

    }
      
   function echart_main_5( datasss ) { 
 var main_5 = echarts.init(document.getElementById('main_5'));
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '机关案件分类统计表-司法局',
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            
            color:['rgb(155,0,255)','rgb(130,120,223)','rgb(253,145,23)','rgb(255,0,250)'],

//            color: [
////               'rgb(255,219,91)',
////                'rgb(159,230,180)',
////                'rgb(255,114,147)',
//                'rgb(130,120,223)',
//                'rgb(47,197,223)',
////                'rgb(255,159,120)',
////                'rgb(231,188,242)',
//                'rgb(71,96,255)',
//            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '刑事',
                    '民事',
                    '行政',                    
                    '执行',
                ],
                textStyle: {
                    color: "#000",

                }
            },
            series: [
                {
                    name: '案件数量',
                    type: 'pie',
                    radius: [
                        '30%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '50%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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
 
        main_5.setOption(option);
        window.addEventListener("resize",function(){
            main_5.resize();
        });

 }
      
    
    function echart1() {
        var myChart1 = echarts.init(document.getElementById('main1'));
        
        var oldcases = 10000 ;
        var newcases = 21000 ;
        var average1 = 5000 ;
        var average2 = 1000 ;
        var rate1 = 30 ;
        var rate2 = 20 ;
        var rate3 = 30 ;        
        
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '债务余额情况统计（万元）',
                subtext:   `\n一般债务限额:${oldcases}万元          专项债务限额:${newcases}万元\n\n一般债务:${average1}万元                   专项债务:${average2}万元\n\n`,

                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                   
                },
                subtextStyle:{
                            lineHeight:50,
                            height:100,
                            color:"rgb(21,170,228)",
                            fontSize:"16",
                            // textBorderColor:"rgba(218, 33, 33, 1)"
                        },                    
                
            },
//            color:['rgb(155,0,255)','rgb(31,121,213)','rgb(251,1,100)','rgb(1,0,250)','rgb(255,0,250)','rgb(253,145,23)'],
            color:['rgb(155,0,255)','rgb(251,1,100)','rgb(253,145,23)','rgb(255,0,250)'],

            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top: 30,
                data: [
                    '一般债务',
                    '专项债务',
                ],
                textStyle: {
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
                    name: '情况分析',
                    type: 'pie',
                    radius: [
                        50, 120
                    ],
                    center: [
                        '64%', '50%'
                    ],
                    roseType: 'area',
                    data: [
                        {
                            value: 1,
                            name: '一般债务'
                        },
                        {
                            value: 2,
                            name: '专项债务'
                        },                      
                    ]
                }
            ]
        };


        myChart1.setOption(option);
        window.addEventListener("resize",function(){
            myChart1.resize();
        });

    }
 

 function echart2() {
        var myChart2 = echarts.init(document.getElementById('main2'));
        
        var oldcases = 10000 ;
        var newcases = 2100 ;
        var average1 = 1 ;
        var average2 = 1 ;
        var rate1 = 30 ;
        var rate2 = 20 ;
        var rate3 = 30 ;        
        
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '政府债券发行情况(万元)',
//                subtext:   `\n一般债券:${oldcases}               专项债券:${newcases}\n\n调解率:${rate1}%                  撤诉率:${rate2}%\n\n二审改判率:${rate3}%           收结率:${rate3}%\n\n`,
                subtext:   `\n一般债券:${oldcases}万元               专项债券:${newcases}万元`,

                left: 'left',
                textStyle: {
                    color: "#000"
                   
                },
                subtextStyle:{
                            lineHeight:50,
                            height:100,
                            color:"rgb(21,170,228)",
                            fontSize:"16",
                            // textBorderColor:"rgba(218, 33, 33, 1)"
                        },                    
                
            },
//            color:['rgb(155,0,255)','rgb(31,121,213)','rgb(251,1,100)','rgb(1,0,250)','rgb(255,0,250)','rgb(253,145,23)'],
            color:['rgb(253,145,23)','rgb(255,0,250)','rgb(253,145,23)','rgb(255,0,250)'],

            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top: 30,
                data: [
                    '一般债券',
                    '专项债券',
                ],
                textStyle: {
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
                    name: '情况分析',
                    type: 'pie',
                    radius: [
                        50, 120
                    ],
                    center: [
                        '60%', '50%'
                    ],
                    roseType: 'area',
                    data: [
                        {
                            value: 1,
                            name: '一般债券'
                        },
                        {
                            value: 2,
                            name: '专项债券'
                        },                      
                    ]
                }
            ]
        };


        myChart2.setOption(option);
        window.addEventListener("resize",function(){
            myChart2.resize();
        });

    }
    
    
    
    function echart3(  ) { 
        var myChart3 = echarts.init(document.getElementById('main3'));
        var datasss =[ 
              {name:"政府债券",value:0 },
              {name:"非政府债券形式的存量政府债务",value: 2  },
              {name:"存量担保债务",value:1 },
              {name:"存量救济债务",value:0 },            
            ];
  
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '债务类别统计情况',
                //subtext:   `\n旧存案件数:${oldcases}               新收案件数:${newcases}\n\n调解率:${rate1}%                  撤诉率:${rate2}%\n\n二审改判率:${rate3}%           收结率:${rate3}%\n\n`,
            
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            
            color:['rgb(155,0,255)','rgb(130,120,223)','rgb(253,145,23)','rgb(255,0,250)'],

            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '政府债券',
                    '非政府债券形式的存量政府债务',
                    '存量担保债务',                    
                    '存量救济债务',
                ],
                textStyle: {
                    color: "#000",

                }
            },
            series: [
                {
                    name: '债务数量',
                    type: 'pie',
                    radius: [
                        '30%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '55%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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

 } 



 function echart4() {
        let obj = []; //定义新数组，传入echart图表所需要的数据格式 和字段
        obj.push({product:"汽车及装备制造业","待处理":1,"处理中":2,"已完成":3})
        obj.push({product:"电子信息工业","待处理":1,"处理中":2,"已完成":3})

        
        var month=[ "2010年", "2011年", "2012年", "2013年", "2014年", "2015年", "2016年", "2017年", "2018年","2019年", "2020年", "2021年"];                 
        var datasss = [];
        var cnt = 0 ;
        for( var i = 0 ; i < 12;i ++ ) {

           // datasss.push( value[i]);
            datasss.push( month[i]);
            
            cnt ++ ;
            if ( cnt > 11 )
                break;
        }
        
        
        var value2 = [];
        value2.push(20);
        value2.push(40);
        value2.push(60);
        value2.push(80);

        value2.push(30);
        value2.push(60);
        value2.push(50);
        value2.push(100);
        value2.push(40);
        value2.push(120);
        value2.push(140);
        value2.push(100);          
//        cnt = 0 ;
//        for( var i = 0 ; i < value2_parameter.length ;i ++ ) {
//
//            value2.push( value2_parameter[i]);
//            cnt ++ ;
//            if ( cnt > 11 )
//                break;
//        }
//    
        
        var myChart4 = echarts.init(document.getElementById('main4'));
            option = {
            backgroundColor: '#FFFFFF',

            title: {
                text: '近年负债率统计',
                textStyle: {
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
                             return datasss.length > 4?datasss.substring(0,5):datasss;
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
                    name: '负债值',
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
        myChart4.setOption(option);
        window.addEventListener("resize",function(){
            myChart4.resize();
        });
        myChart4.on('click', function (params) {
            console.log(params);
        });

    }

function echart4444(  ) { 
        var myChart4 = echarts.init(document.getElementById('main4'));
        var datasss =[ 
              {name:"旧存",value:0 },
              {name:"新收",value: 2  },
              {name:"办结",value:1 },
              {name:"未结",value:0 },            
            ];
  
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '法院民商事案件统计表',
                //subtext:   `\n旧存案件数:${oldcases}               新收案件数:${newcases}\n\n调解率:${rate1}%                  撤诉率:${rate2}%\n\n二审改判率:${rate3}%           收结率:${rate3}%\n\n`,
            
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            
            color:['rgb(155,0,255)','rgb(251,1,100)','rgb(253,145,23)','rgb(255,0,250)'],

            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '旧存',
                    '新手',
                    '办结',                    
                    '未结',
                ],
                textStyle: {
                    color: "#000",

                }
            },
            series: [
                {
                    name: '案件数量',
                    type: 'pie',
                    radius: [
                        '30%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '55%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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
 
        myChart4.setOption(option);
        window.addEventListener("resize",function(){
            myChart4.resize();
        });

 } 
 
function echart5(  ) { 
        var myChart5 = echarts.init(document.getElementById('main5'));
        var datasss =[ 
              {name:"交通运输设施建设",value:1 },
              {name:"市政建设",value: 4 },
              {name:"工业和能源",value:1 },
              {name:"生态建设和环境保护",value:1 },
              {name:"农林水利建设",value:1 },
              {name:"教科文卫",value:1 },
              {name:"保障性住房",value:3 },
              {name:"土地收储",value:1 },
              {name:"其他",value:1 },
   
              
            ];
  
      option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '政府或有债务投向',
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            color: [
                'rgb(47,197,223)',
                'rgb(255,159,120)',
                'rgb(231,188,242)',
                'rgb(71,96,255)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '交通运输设施建设',
                    '市政建设',
                    '工业和能源',    
                    '生态建设和环境保护',
                    '农林水利建设',
                    '教科文卫',    
                    '保障性住房',
                    '土地收储',
                    '其他',                        
                ],
                textStyle: {
                    color: "#000",

                }
            },
            series: [
                {
                    name: '数量',
                    type: 'pie',
                    radius: [
                        '0%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '55%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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
  
        myChart5.setOption(option);
        window.addEventListener("resize",function(){
            myChart5.resize();
        });

 } 
 
function echart6(  ) { 
    return;
        var myChart6 = echarts.init(document.getElementById('main6'));
        var datasss =[ 
              {name:"未赔偿",value:0 },
              {name:"赔偿中",value: 2  },
              {name:"已赔偿",value:1 },
            ];
  
      option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '法院国家赔偿案件统计表',
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
                    //color: "#fff"
                    color: "#000",
 
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
                'rgb(130,120,223)',
//                'rgb(47,197,223)',
//                'rgb(255,159,120)',
//                'rgb(231,188,242)',
//                'rgb(71,96,255)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                     '未赔偿',
                    '赔偿中',
                    '已赔偿',       
                ],
                textStyle: {
//                    color: "#fff",
                    color: "#000",

                }
            },
            series: [
                {
                    name: '案件数量',
                    type: 'pie',
                    radius: [
                        '0%', '70%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '55%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                //color: "#fff",
                                color: "#000",

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

        myChart6.setOption(option);
        window.addEventListener("resize",function(){
            myChart6.resize();
        });

 } 

    function echart7(  ) { 
return
        var myChart7 = echarts.init(document.getElementById('main7'));
        option = {
            backgroundColor: '#FFFFFF',         
            title: {
                text: '法院各类案件收结存情况统计表',
                textStyle: {
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
                    '旧存', '新收'
                ],
                orient: 'vertical',
                right: '10',
                top:"10",    
                textStyle: {
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
                    color: "#000"
                    }
                }
            },
            yAxis: {
                type: 'category',
                data: [
                    '刑事',
                    '民事',
                    '行政',
                    '执行'
                ],
                axisLine: {
                    lineStyle: {
                    color: "#000"
                    }
                }

            },
            series: [
                {
                    name: '旧存',
                    type: 'bar',
                    data: [
                        1,
                        2,
                        3,
                        14
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
                    name: '新收',
                    type: 'bar',
                    data: [
                        1,
                        2,
                        3,
                        4
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

        myChart7.setOption(option);
        window.addEventListener("resize",function(){
            myChart7.resize();
        });
    }     
