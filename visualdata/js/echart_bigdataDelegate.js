
    
    
    function echart1( datasss ){

       option1 = {
           
             backgroundColor: '#FFFFFF',

            tooltip: {
                trigger: 'item'
            },
            legend: {
                top: '5%',
                left: 'center'
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
            series: [
            {
                name: '数据',
                type: 'pie',
                radius: ['40%', '70%'],
                avoidLabelOverlap: false,
                itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
                },
                label: {
                show: false,
                position: 'center'
                },
                emphasis: {
                label: {
                  show: true,
                  fontSize: '40',
                  fontWeight: 'bold'
                }
                },
                labelLine: {
                show: false
                },
                data:datasss
            }
            ]
        };
        var myChart1 = echarts.init(document.getElementById('main'));
        myChart1.setOption(option1);
        window.addEventListener("resize",function(){
            myChart1.resize();
        });
        myChart1.on('click', function (params) {
            console.log(params );          
        })  
    }
  

    function echart_delegate(datasss) {


        var myChart3 = echarts.init(document.getElementById('main3'));
        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '人大代表学历分析',
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} 人 ({d}%)'
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
                    '无学历',
                    '小学',
                    '初中',                    
                    '高中',
                     '大专',
                    '本科',
                    '研究生',                    
                    '博士生',                   
                ],
                
           
                textStyle: {
                   color: "#000",
                }
            },
            series: [
                {
                    name: '具体数据',
                    type: 'pie',
                    radius: [
                        '35%', '60%'
                    ],
                    labelLine:{
                        normal:{
                            length:20,  //视觉引导线长度
                            length2:40
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
        myChart3.on('click', function (params) {
            console.log(params );          
        })

    }
  

  function echart_mission( missiondata , index ) {  
        var missionName =[ "mission1" , "mission2"   , "mission3" , "mission4" , "mission5" , "mission6" , "mission7" , "mission8" , "mission9" , "mission10" , 
            "mission11" , "mission12"  , "mission13"  , "mission14", "mission15", "mission16" , "mission17", "mission18", "mission19", "mission20", "mission21"];
             var titleCaption =[ "小屯镇人大代表学历分析" , "临汝镇人大代表学历分析"   , "寄料镇人大代表学历分析" , "温泉镇人大代表学历分析" , "蟒川镇人大代表学历分析" , "杨楼镇人大代表学历分析" ,
            "庙下镇人大代表学历分析" , "陵头镇人大代表学历分析" , "米庙镇人大代表学历分析" , "纸坊镇人大代表学历分析" , "大峪镇人大代表学历分析" , " 夏店镇人大代表学历分析"  , 
            "焦村镇人大代表学历分析"  , "骑岭乡人大代表学历分析", "王寨乡人大代表学历分析", "风穴路街道人大代表学历分析" , "煤山街道人大代表学历分析", "洗耳河街道人大代表学历分析", 
            "钟楼街道人大代表学历分析", "汝南街道人大代表学历分析", "紫云路街道人大代表学历分析"];
        //var mission = echarts.init(document.getElementById('mission1'));
        var missionechart = echarts.init(document.getElementById( missionName[ index] ));
        
       
        option = {
            backgroundColor: '#FFFFFF',
            title: {
//                text: '小屯镇人大代表学历分析',
                text: titleCaption[ index ],
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
                    color: "#000",
 
                }
            },
            tooltip: {
                trigger: 'item',

                formatter: '{a} <br/>{b} : {c} 人 ({d}%)'
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
                    '无学历',
                    '小学',
                    '初中',                    
                    '高中',
                     '大专',
                    '本科',
                    '研究生',                    
                    '博士生',                   
                ],
                
           
                textStyle: {
                   color: "#000",
                }
            },
            series: [
                {
                    name: '具体数据',
                    type: 'pie',
                    radius: '50%',
//                    radius: [
//                        '35%', '60%'
//                    ],
                    
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:40
                        },
                        lineStyle: {
                            color: 'rgba(255, 255, 255, 0.3)'
                        },
                         smooth: 0.2,
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
                    data: missiondata,
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

        missionechart.setOption(option);
        window.addEventListener("resize",function(){
            missionechart.resize();
        });
        missionechart.on('click', function (params) {
            console.log(params );          
        })
  }
 