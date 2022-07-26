
    
    var missionEducation_wave = echarts.init(document.getElementById( 'mission21_wave'));
    var educationData ;
    function echartEducation( datasss ,index ) {
        
      educationData = datasss ;
      var missionName =[ "mission1" , "mission2"   , "mission3" , "mission4" , "mission5" , "mission6" , "mission7" , "mission8" , "mission9" , "mission10" , 
            "mission11" , "mission12"  , "mission13"  , "mission14", "mission15", "mission16" , "mission17", "mission18", "mission19", "mission20", "mission21"];
             var titleCaption =[ "小屯镇人大代表学历分析" , "临汝镇人大代表学历分析"   , "寄料镇人大代表学历分析" , "温泉镇人大代表学历分析" , "蟒川镇人大代表学历分析" , "杨楼镇人大代表学历分析" ,
            "庙下镇人大代表学历分析" , "陵头镇人大代表学历分析" , "米庙镇人大代表学历分析" , "纸坊镇人大代表学历分析" , "大峪镇人大代表学历分析" , " 夏店镇人大代表学历分析"  , 
            "焦村镇人大代表学历分析"  , "骑岭乡人大代表学历分析", "王寨乡人大代表学历分析", "风穴路街道人大代表学历分析" , "煤山街道人大代表学历分析", "洗耳河街道人大代表学历分析", 
            "钟楼街道人大代表学历分析", "汝南街道人大代表学历分析", "紫云路街道人大代表学历分析"];
        var myChart3 = echarts.init(document.getElementById( missionName[index] ));
        
        
        missionEducation_wave =   echarts.init(document.getElementById( missionName[index] + '_wave'));

        option = {
            backgroundColor: '#FFFFFF',
            title: {
                text: titleCaption[ index ],
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
                    center: [
                        '45%', '60%'
                    ],
                    borderRadius: 10,
                    borderColor: '#fff',
                    borderWidth: 2,
                    
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:40
                        }
                    },
                    
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            position: 'outer',
                            alignTo: 'labelLine',
                            bleedMargin: 5,
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
   
   
   
   
   
   
   
   option1 = {
    backgroundColor: '#FFFFFF',
//    legend: {},
    tooltip: {
      trigger: 'axis',
      showContent: false
    },
    dataset: {
      source: [
        ['product', '2018', '2019', '2020', '2021', '2022'],
        ['无学历', 3, 15, educationData[0].value, educationData[0].value, educationData[0].value],
        ['小学',  5, 4, educationData[1].value, educationData[1].value, educationData[1].value],
        ['初中', 2, 3, educationData[2].value, educationData[2].value, educationData[2].value],
        ['高中', 1, 8, educationData[3].value, educationData[3].value, educationData[3].value],
        ['大专', 0, 9, educationData[4].value, educationData[4].value, educationData[4].value],
        ['本科', 2, 11, educationData[5].value, educationData[5].value, educationData[5].value],
        ['研究生', 3, 1, educationData[6].value, educationData[6].value, educationData[6].value],
        ['博士生', 0, 0, educationData[7].value, educationData[7].value, educationData[7].value]
        
        
//        ['无学历', educationData[0].value, educationData[0].value, educationData[0].value, educationData[0].value, educationData[0].value],
//        ['小学',  educationData[1].value, educationData[1].value, educationData[1].value, educationData[1].value, educationData[1].value],
//        ['初中', educationData[2].value, educationData[2].value, educationData[2].value, educationData[2].value, educationData[2].value],
//        ['高中', educationData[3].value, educationData[3].value, educationData[3].value, educationData[3].value, educationData[3].value],
//        ['大专', educationData[4].value, educationData[4].value, educationData[4].value, educationData[4].value, educationData[4].value],
//        ['本科', educationData[5].value, educationData[5].value, educationData[5].value, educationData[5].value, educationData[5].value],
//        ['研究生', educationData[6].value, educationData[6].value, educationData[6].value, educationData[6].value, educationData[6].value],
//        ['博士生', educationData[7].value, educationData[7].value, educationData[7].value, educationData[7].value, educationData[7].value]
      ]
    },
    xAxis: { type: 'category' },
    yAxis: { gridIndex: 0 },
    grid: { top: '55%' },
    series: [
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'pie',
        id: 'pie',
        radius: '30%',
        center: ['50%', '25%'],
        emphasis: {
          focus: 'self'
        },
        label: {
          formatter: '{b}: {@2018} ({d}%)'
        },
        encode: {
          itemName: 'product',
          value: '2018',
          tooltip: '2018'
        }
      }
    ]
  };
   missionEducation_wave.setOption(option1);
   
   
   
    }
  

  
  
setTimeout(function () {
  option = {
    backgroundColor: '#FFFFFF',
//    legend: {},
    tooltip: {
      trigger: 'axis',
      showContent: false
    },
    dataset: {
      source: [
         
        
        ['product', '2012', '2013', '2014', '2015', '2016', '2017'],
        ['Milk Tea', 56.5, 82.1, 88.7, 70.1, 53.4, 85.1],
        ['Matcha Latte', 51.1, 51.4, 55.1, 53.3, 73.8, 68.7],
        ['Cheese Cocoa', 40.1, 62.2, 69.5, 36.4, 45.2, 32.5],
        ['Walnut Brownie', 25.2, 37.1, 41.2, 18, 33.9, 49.1]
      
//        ['product', '2018', '2019', '2020', '2021', '2022'],
//        ['无学历', 3, 15, educationData[0].value, educationData[0].value, educationData[0].value],
//        ['小学',  5, 4, educationData[1].value, educationData[1].value, educationData[1].value],
//        ['初中', 2, 3, educationData[2].value, educationData[2].value, educationData[2].value],
//        ['高中', 1, 8, educationData[3].value, educationData[3].value, educationData[3].value],
//        ['大专', 0, 9, educationData[4].value, educationData[4].value, educationData[4].value],
//        ['本科', 2, 11, educationData[5].value, educationData[5].value, educationData[5].value],
//        ['研究生', 3, 1, educationData[6].value, educationData[6].value, educationData[6].value],
//        ['博士生', 0, 0, educationData[7].value, educationData[7].value, educationData[7].value]  
         
         
//        ['无学历', datasss[0].value, datasss[0].value, datasss[0].value, datasss[0].value, datasss[0].value],
//        ['小学',  datasss[1].value, datasss[1].value, datasss[1].value, datasss[1].value, datasss[1].value],
//        ['初中', datasss[2].value, datasss[2].value, datasss[2].value, datasss[2].value, datasss[2].value],
//        ['高中', datasss[3].value, datasss[3].value, datasss[3].value, datasss[3].value, datasss[3].value],
//        ['大专', datasss[4].value, datasss[4].value, datasss[4].value, datasss[4].value, datasss[4].value],
//        ['本科', datasss[5].value, datasss[5].value, datasss[5].value, datasss[5].value, datasss[5].value],
//        ['研究生', datasss[6].value, datasss[6].value, datasss[6].value, datasss[6].value, datasss[6].value],
//        ['博士生', datasss[7].value, datasss[7].value, datasss[7].value, datasss[7].value, datasss[7].value]
      ]
    },
    xAxis: { type: 'category' },
    yAxis: { gridIndex: 0 },
    grid: { top: '55%' },
    series: [
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'line',
        smooth: true,
        seriesLayoutBy: 'row',
        emphasis: { focus: 'series' }
      },
      {
        type: 'pie',
        id: 'pie',
        radius: '30%',
        center: ['50%', '25%'],
        emphasis: {
          focus: 'self'
        },
        label: {
          formatter: '{b}: {@2012} ({d}%)'
        },
        encode: {
          itemName: 'product',
          value: '2012',
          tooltip: '2012'
        }
      }
    ]
  };
  missionEducation_wave.on('updateAxisPointer', function (event) {
    const xAxisInfo = event.axesInfo[0];
    if (xAxisInfo) {
      const dimension = xAxisInfo.value + 1;
      missionEducation_wave.setOption({
        series: {
          id: 'pie',
          label: {
            formatter: '{b}: {@[' + dimension + ']} ({d}%)'
          },
          encode: {
            value: dimension,
            tooltip: dimension
          }
        }
      });
    }
  });
   window.addEventListener("resize",function(){
            missionEducation_wave.resize();
        });
  missionEducation_wave.setOption(option);
});
