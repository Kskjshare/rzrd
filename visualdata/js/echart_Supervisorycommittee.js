
    // echart1() 代表团建议
    // echart2() 行业建议
    // echart3() 代表学历
    // echart4() 代表党派
    // footerOne();  代表职业
    // footerTwo();  建议办理
    // footerTree(); 性别分析
    // footerFlour();履职活动
  
 
   

    
    function echart1() {
        var myChart1 = echarts.init(document.getElementById('main1'));
        
        var oldcases = 1 ;
        var newcases = 21 ;
        var average1 = 1 ;
        var average2 = 1 ;
        var rate1 = 30 ;
        var rate2 = 20 ;
        var rate3 = 30 ;        
        
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '收结存动态统计',
//                subtext:   `\n旧存案件数:${oldcases}               新收案件数:${newcases}\n\n法官人均结案数:${average1}         法院人均结案数:${average2}\n\n调解率:${rate1}%                  撤诉率:${rate2}%\n\n增减百分比:${rate3}%           收结率:${rate3}%\n\n`,

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
                    '旧存',
                    '新收',
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
                        '50%', '50%'
                    ],
                    roseType: 'area',
                    data: [
                        {
                            value: 1,
                            name: '旧存'
                        },
                        {
                            value: 2,
                            name: '新收'
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
        
     
        option = {
            backgroundColor: '#FFFFFF',         
            title: {
                text: '各类案件收结存情况统计',
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
                    '接收案件', '完结案件'
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
                    name: '接收案件',
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
                    name: '完结案件',
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

      
        myChart2.setOption(option);
        window.addEventListener("resize",function(){
            myChart2.resize();
        });

    }
    
    
    
    function echart3(  ) { 
        var myChart3 = echarts.init(document.getElementById('main3'));
        var datasss =[ 
              {name:"和解率",value:28 },          
            ];
  
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '和解率动态统计百分比',
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
                    '和解率',
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
 
        myChart3.setOption(option);
        window.addEventListener("resize",function(){
            myChart3.resize();
        });

 } 
 
function echart4(  ) { 
        var myChart4 = echarts.init(document.getElementById('main4'));
        var datasss =[ 
              {name:"收结率",value:28 },
            ];
  
     
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '收结率动态统计百分比',
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
            
            color:['rgb(251,1,100)','rgb(253,145,23)','rgb(255,0,250)','rgb(155,0,255)',],

            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '收结率',   
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
                        '40%', '70%'
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
              {name:"立案",value:2 },
              {name:"撤案",value: 1  },
            ];
  
      option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '全市检察机关民事行政检察情况统计表',
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
                    '立案',
                    '撤案',
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
        var myChart6 = echarts.init(document.getElementById('main6'));
        var datasss =[ 
              {name:"立案",value:2 },
              {name:"撤案",value: 2  },
            ];
  
      option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '全市检察机关刑罚执行监督情况统计表',
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
                     '立案',
                    '撤案',
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

        var myChart7 = echarts.init(document.getElementById('main7'));
        option = {
            backgroundColor: '#FFFFFF',         
            title: {
                text: '全市检察机关督办职务犯罪统计表',
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
                    '立案率',
                    '立大案率',
                    '立要案率',
                    '起诉率'
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
