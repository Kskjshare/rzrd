
    // echart1() 代表团建议
    // echart2() 行业建议
    // echart3() 代表学历
    // echart4() 代表党派
    // footerOne();  代表职业
    // footerTwo();  建议办理
    // footerTree(); 性别分析
    // footerFlour();履职活动
    
    function  echart1111(name,value) {
        var myChart1 = echarts.init(document.getElementById('main'));

        var processdata=[  
            {name:"征集数",value:1},
            {name:"初审数",value:2},
            {name:"一审数",value:3},
            {name:"二审数",value:4},
            {name:"三审数",value:5},
            {name:"会议表决通过数",value:6},
            
            ],
        option = {
            backgroundColor: '#FFFFFF',
        
            title: {
                text: '立法过程管理情况',
                textStyle: {
                    color: "#000"                    
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
//                show:true,
//                data: ['活动次数'],
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '征集数',
                    '初审数',
                    '一审数',
                    '二审数',
                    '三审数',
                    '会议表决通过数',                 
                ],    
                
                textStyle: {
                    color: "#000"                    
                },
//                left:"right"
            },
             color: [
             
                'rgba(47,197,223,.8)',
                'rgba(255,159,120,.8)',
                'rgb(231,188,242)',
                'rgb(71,96,255)',
            ],
            
            
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
//                    color:"#fff"
                    color: "#000"                    
                        }
                    }
                }
            ],
            yAxis: [

                {   
                    type: 'value',
                    axisLine: {
                        lineStyle: {
//                    color:"#fff"
                    color: "#000"                    
                        }
                    }
                },


            ],
            series: [
                {   
                    name: '次数',
                    type: 'line',
                    stack: '总量',
                    areaStyle: {},
                    data: value
                }
            ]
        };

        myChart1.setOption(option);
        window.addEventListener("resize",function(){
            myChart1.resize();
        });
    }

    function echart1(value,value2) {
        console.log("______value=",value)
                console.log("______ value2 =",value2)

        var myChart1 = echarts.init(document.getElementById('main'));
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '立法过程管理情况',
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

            
            grid: {
                left: '4%',
                right: '10%',
                bottom: '3%',
                containLabel: true

            },
            xAxis: [
                {
                    type: 'category',
                    data: value,
                    textStyle:{
                        
                    },
                    axisTick: {
                        alignWithLabel: true,
                        barBorderRadius: [0, 0, 0, 0]
                    },
                    axisLine: {
                        lineStyle: {
//                    color: "#fff"
                    color: "#000"                             }
                    },
                    axisLabel:{
                         interval:0,//横轴信息全部显示
                         rotate:45,//度角倾斜显示
                         formatter:function(value){//只显示五个字 其余省略号
                             return value.length > 4?value.substring(0,8):value;
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
                    name: '数量',
                    type: 'bar',
                    barWidth: '20',
                    barBorderRadius: 5,
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
                text: '近五年立法计划项目征集情况',
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
                    '2017年', '2018年', '2019年', '2020年', '2021年'
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"                    
                }

            },
            color: [
                'rgba( 2,132,254)',
                'rgba( 2,132,254)',
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
                    color: "#000"                         }
                }
            },
            yAxis: {
                type: 'category',
                data: [
                    '2017年',
                    '2018年',
                    '2019年',
                    '2020年',
                    '2021年'
                ],
                axisLine: {
                    lineStyle: {
//                    color: "#fff"
                    color: "#000"                         }
                }

            },
            series: [
//                {
//                    name: '2011年',
//                    type: 'bar',
//                    data: [
//                        18203,
//                        23489,
//                        29034,
//                        104970,
//                        131744
//                    ],
//                    itemStyle: { // 柱形图圆角，鼠标移上去效果
//                        emphasis: {
//                            barBorderRadius: [10, 10, 10, 10]
//                        },
//
//                        normal: { // 柱形图圆角，初始化效果
//                            barBorderRadius: [10, 10, 10, 10]
//                        }
//                    }
//                }, 
                {
                    name: '数量',
                    type: 'bar',
                    data: [
                        0,
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
    function echart3(datasss) {
        var myChart3 = echarts.init(document.getElementById('main3'));
        option = {
            backgroundColor: '#FFFFFF',        
            title: {
                text: '立法计划类别占比图',
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
                'rgb(130,120,223)',
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
                    '制定',
                    '修改',
                    '废止',
//                    '高中',
//                    "大专",
//                    "本科",
//                    "研究生",
//                    "博士生"
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                }
            },
            
            series: [
                {
                    name: '立法计划类别',
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
    
    
 function echart5(datasss) {
     
        var myChart5 = echarts.init(document.getElementById('main5'));
        
       
        option = {
            backgroundColor: '#FFFFFF',        
            title: {
                text: '立法规划类别占比图',
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
//                'rgb(255,219,91)',
//                'rgb(159,230,180)',
//                'rgb(255,114,147)',
                'rgb(130,120,223)',
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
                    '制定',
                    '修改',
                    '废止',
                ],
                textStyle: {
//                    color: "#fff"
                    color: "#000"
                }
            },
            
            series: [
                {
                    name: '立法规划类别',
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
        myChart5.setOption(option);
        window.addEventListener("resize",function(){
            myChart5.resize();
        });
        myChart5.on('click', function (params) {
            console.log(params );
          
        })

    }    
    
    
    function echart4(value,value2) {
        var myChart4 = echarts.init(document.getElementById('main4'));
        option = {
            backgroundColor: '#FFFFFF',
            
            title: {
                text: '立法规划项目征集情况',
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

            
            grid: {
                left: '4%',
                right: '10%',
                bottom: '3%',
                containLabel: true

            },
            xAxis: [
                {
                    type: 'category',
                    data: value,
                    textStyle:{
                        
                    },
                    axisTick: {
                        alignWithLabel: true,
                        barBorderRadius: [0, 0, 0, 0]
                    },
                    axisLine: {
                        lineStyle: {
                        color: "#000"                        
                    }
                    },
                    axisLabel:{
                         interval:0,//横轴信息全部显示
                         rotate:45,//度角倾斜显示
                         formatter:function(value){//只显示五个字 其余省略号
                             return value.length > 4?value.substring(0,4)+'...':value;
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
                        color: "#000"     
                    }
                    }
                }
            ],
            // color:"rgb(0,227,255)",
            series: [
                {
                    name: '数量',
                    type: 'bar',
                    barWidth: '20',
                    barBorderRadius: 5,
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
    
    function echart4___(dangpai) {
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
                        '45%', '50%'
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
                text: '代表职业构成分析',
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
                    'rose2',
                    'rose3',
                    'rose4',
                    'rose5',
                    'rose6',
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
                    name: '面积模式',
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
                            name: 'rose1'
                        },
                        {
                            value: 5,
                            name: 'rose2'
                        },
                        {
                            value: 15,
                            name: 'rose3'
                        },
                        {
                            value: 25,
                            name: 'rose4'
                        }, {
                            value: 20,
                            name: 'rose5'
                        }, {
                            value: 35,
                            name: 'rose6'
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
    
   function echart6(obj1) {
        var myChart6 = echarts.init(document.getElementById('main6'));
       obj=[  
            {product:"法工委",数量: 6  },
            {product:"预算工委",数量: 5 },
            {product:"财经委",数量: 4 },
            {product:"办公室",数量: 3 },
            {product:"农工委",数量: 2 },
            ];    
//         console.log("___________ obj1=",obj1)
        option2 = {
            backgroundColor: '#FFFFFF',
//                                    color:"rgb(21,170,228)",

            legend: {
                textStyle: {
//                    color: "#fff",
                    color: "#000"                    
                    
                },
                right: "2",
                top:"25"
            },
            title: {
                text: '立法后评估涉及部门柱状图',
                // subtext:"待处理               处理中              已完成",
                textStyle: {
//                    color: "#fff",
                    color: "#000"                    
                   
                },
                // subtextStyle:{
                //     color: "#fff",
                //     fontSize:"8"
                  
                // },
                left: "0"
            },
            tooltip: {},
            dataset: {
                dimensions: ['product', '数量'],
//                dimensions: ['product', '待处理', '处理中', '已完成'],

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
//                        color: "#fff"
                        color: "#000"                    
                       
                    }
                }
            },
            yAxis: {
                axisLine: {
                    show:false,
                    lineStyle: {
//                        color: "#fff"
                        color: "#000"                    
                       
                    }
                }
            },
            series: [
                {
                    type: 'bar',
                    barWidth: '30',
                    itemStyle: {
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
//                {
//                    type: 'bar',
//                    barWidth: '10',
//                    itemStyle: {
//                        normal: { // 柱形图圆角，初始化效果
//                            barBorderRadius: [0, 0, 0, 0]
//                        }
//                    }
//                }, {
//                    type: 'bar',
//                    barWidth: '10',
//                    itemStyle: {
//                        normal: { // 柱形图圆角，初始化效果
//                            barBorderRadius: [0, 0, 0, 0]
//                        }
//                    }
//                },
            ]
        };
        myChart6.setOption(option2);
        window.addEventListener("resize",function(){
            myChart6.resize();
        });
    }  
    
  function footerTwo(obj) {
        var myChart6 = echarts.init(document.getElementById('footerTwo'));
        option2 = {
            legend: {
                textStyle: {
                    color: "#fff",
                },
                right: "2",
                top:"25"
            },
            title: {
                text: '建议办理结果',
                // subtext:"待处理               处理中              已完成",
                textStyle: {
                    color: "#fff",
                   
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
                    barWidth: '10',
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
            backgroundColor: '#FFFFFF',
        
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
//                    color:"#fff"
                    color: "#000"                    
                    
                }
            },
            title:{
                text:   `男女分析表\n\n\n\n                    ${number}人                 ${number}人\n\n\n\n\n`,
                subtext:`                 ${maleFormate}%            ${femaleFormate}%`,
                top:"0%",
                left:"5%",
                textStyle:{
//                    color:"#fff"
                    color: "#000"                    
                    
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
        var myChart8 = echarts.init(document.getElementById('footerFlour'));
        option = {
            backgroundColor: '#FFFFFF',
        
            title: {
                text: '履职活动分析表',
                textStyle: {
//                    color:"#fff"
                    color: "#000"                    
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
//                    color:"#fff"
                    color: "#000"                    
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
//                    color:"#fff"
                    color: "#000"                    
                        }
                    }
                }
            ],
            yAxis: [

                {   
                    type: 'value',
                    axisLine: {
                        lineStyle: {
//                    color:"#fff"
                    color: "#000"                    
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

