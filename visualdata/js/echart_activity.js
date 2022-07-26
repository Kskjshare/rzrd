var deputyChart = echarts.init(document.getElementById( 'deputy' ));
var deputydelegation =[
            '小屯镇',
            '临汝镇',
            '寄料镇',
            '温泉镇',
            '蟒川镇',
            '杨楼镇',
            '庙下镇',
            '陵头镇',
            '米庙镇',
            '纸坊镇',
            '大峪镇',
            '夏店镇',
            '焦村镇',
            '骑岭乡',
            '王寨乡',
            '风穴路街道',
            '煤山街道',
            '洗耳河街道',
            '钟楼街道',
            '汝南街道',
            '紫云路街道'
        ];
    
    

function showActivitybarChart( ddtArr , startIndex , deputy_bar){
    
    
    let xAxisData = [];

    let cnt = 0 ;
    for (let i = startIndex; i < ddtArr.length ; i++) {
        if ( cnt >= 20 ) {
            break;
        }
        cnt ++ ;
      xAxisData.push( ddtArr[i].name );
      
      
    }
   
//    var deputy_bar = echarts.init(document.getElementById( 'deputy_bar' ));
    var deputy_bar = echarts.init(document.getElementById( deputy_bar ));

    var title ='履职统计';
    if ( startIndex > 0 ) {
        title ='';
    }
    option = {
        backgroundColor: '#FFFFFF',
        title: {
            text: title,
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
//        legend: {
//            data: delegation,
//            textStyle: {
//                color: "#000"
//              }
//
//        },
        
        legend: {
        left: 'center',
        top: 'top',
        data: [
          '出席人代会',
          '参加其他会议',
          '参加学习培训',
          '提出议案、建议、批评、意见和质询',
          '开展专题调研',
          '参加视察、调研及执法检查',
          '接待选民',
          '化解矛盾纠纷',
          '扶弱济困',
          '办好事、办实事',
          '参加公益慈善事业',
          '向选民述职',
          '其他'
            ]
          },    
        
        
        color: [

                'rgb(159,230,180)',
                'rgb(255,114,147)',
                'rgb(130,120,223)',
                'rgb(47,197,223)',
                'rgb(255,159,120)',
                'rgb(231,188,242)',
                'rgb(71,96,255)',
                
                'rgb( 255 , 255 , 0 )',
                'rgb( 255 , 20 ,147 )',
                'rgb( 255 , 140 , 0 )',
                'rgb( 1 , 100 , 0 )',
                'rgb( 255 , 0 , 255 )',
             'rgb( 255 , 48 , 48 )',
           
        ],
        grid: {
            left: '4%',
            right: '10%',
            bottom: '3%',
            containLabel: true
        },
        yAxis: {
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
            
            
        xAxis: {
            type: 'category',
            data:xAxisData,
            axisLine: {
                lineStyle: {
                color: "#000"
                  }
            },
            
            axisLabel:{
                        interval:0,//横轴信息全部显示
                        rotate:45,//度角倾斜显示
                        formatter:function(xAxisData){//只显示五个字 其余省略号
                            return xAxisData.length > 4?xAxisData.substring(0,4)+'...':xAxisData;
                        }
                    }

            },
            series: [
                {
                    name: '出席人代会',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex  ].meeting,
                        ddtArr[ startIndex + 1 ].meeting,
                        ddtArr[ startIndex + 2 ].meeting,
                        ddtArr[ startIndex + 3 ].meeting,
                        ddtArr[ startIndex + 4 ].meeting,
                        ddtArr[ startIndex + 5 ].meeting,
                        ddtArr[ startIndex + 6 ].meeting,
                        ddtArr[ startIndex + 7 ].meeting,
                        ddtArr[ startIndex + 8 ].meeting,
                        ddtArr[ startIndex + 9 ].meeting,
                        ddtArr[ startIndex + 10 ].meeting,
                        ddtArr[ startIndex + 11 ].meeting,
                        ddtArr[ startIndex + 12 ].meeting,
                        ddtArr[ startIndex + 13 ].meeting,
                        ddtArr[ startIndex + 14 ].meeting,
                        ddtArr[ startIndex + 15 ].meeting,
                        ddtArr[ startIndex + 16 ].meeting,
                        ddtArr[ startIndex + 17 ].meeting,
                        ddtArr[ startIndex + 18 ].meeting,
                        ddtArr[ startIndex + 19 ].meeting,
//                        ddtArr[ startIndex + 20 ].meeting
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },

                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                }, 
                {
                    name: '参加其他会议',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex ].othermeeting,
                        ddtArr[ startIndex + 1 ].othermeeting,
                        ddtArr[ startIndex + 2 ].othermeeting,
                        ddtArr[ startIndex + 3 ].othermeeting,
                        ddtArr[ startIndex + 4 ].othermeeting,
                        ddtArr[ startIndex + 5 ].othermeeting,
                        ddtArr[ startIndex + 6 ].othermeeting,
                        ddtArr[ startIndex + 7 ].othermeeting,
                        ddtArr[ startIndex + 8 ].othermeeting,
                        ddtArr[ startIndex + 9 ].othermeeting,
                        ddtArr[ startIndex + 10 ].othermeeting,
                        ddtArr[ startIndex + 11 ].othermeeting,
                        ddtArr[ startIndex + 12 ].othermeeting,
                        ddtArr[ startIndex + 13 ].othermeeting,
                        ddtArr[ startIndex + 14 ].othermeeting,
                        ddtArr[ startIndex + 15 ].othermeeting,
                        ddtArr[ startIndex + 16 ].othermeeting,
                        ddtArr[ startIndex + 17 ].othermeeting,
                        ddtArr[ startIndex + 18 ].othermeeting,
                        ddtArr[ startIndex + 19 ].othermeeting,
//                        ddtArr[ 20 ].othermeeting
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                
                {
                    name: '参加学习培训',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].study,
                        ddtArr[ startIndex + 1 ].study,
                        ddtArr[ startIndex + 2 ].study,
                        ddtArr[ startIndex + 3 ].study,
                        ddtArr[ startIndex + 4 ].study,
                        ddtArr[ startIndex + 5 ].study,
                        ddtArr[ startIndex + 6 ].study,
                        ddtArr[ startIndex + 7 ].study,
                        ddtArr[ startIndex + 8 ].study,
                        ddtArr[startIndex +  9 ].study,
                        ddtArr[ startIndex + 10 ].study,
                        ddtArr[ startIndex + 11 ].study,
                        ddtArr[ startIndex + 12 ].study,
                        ddtArr[ startIndex + 13 ].study,
                        ddtArr[ startIndex + 14 ].study,
                        ddtArr[ startIndex + 15 ].study,
                        ddtArr[ startIndex + 16 ].study,
                        ddtArr[ startIndex + 17 ].study,
                        ddtArr[ startIndex + 18 ].study,
                        ddtArr[ startIndex + 19 ].study,
//                        ddtArr[ 20 ].study
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                {
                    name: '提出议案、建议、批评、意见和质询',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].suggest,
                        ddtArr[ startIndex + 1 ].suggest,
                        ddtArr[ startIndex + 2 ].suggest,
                        ddtArr[ startIndex + 3 ].suggest,
                        ddtArr[ startIndex + 4 ].suggest,
                        ddtArr[ startIndex + 5 ].suggest,
                        ddtArr[ startIndex + 6 ].suggest,
                        ddtArr[ startIndex + 7 ].suggest,
                        ddtArr[ startIndex + 8 ].suggest,
                        ddtArr[ startIndex + 9 ].suggest,
                        ddtArr[ startIndex + 10 ].suggest,
                        ddtArr[ startIndex + 11 ].suggest,
                        ddtArr[ startIndex + 12 ].suggest,
                        ddtArr[ startIndex + 13 ].suggest,
                        ddtArr[ startIndex + 14 ].suggest,
                        ddtArr[ startIndex + 15 ].suggest,
                        ddtArr[ startIndex + 16 ].suggest,
                        ddtArr[ startIndex + 17 ].suggest,
                        ddtArr[ startIndex + 18 ].suggest,
                        ddtArr[ startIndex + 19 ].suggest,
//                        ddtArr[ 20 ].suggest
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                {
                    name: '开展专题调研',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].specialsurvey,
                        ddtArr[ startIndex + 1 ].specialsurvey,
                        ddtArr[ startIndex + 2 ].specialsurvey,
                        ddtArr[ startIndex + 3 ].specialsurvey,
                        ddtArr[ startIndex + 4 ].specialsurvey,
                        ddtArr[ startIndex + 5 ].specialsurvey,
                        ddtArr[ startIndex + 6 ].specialsurvey,
                        ddtArr[ startIndex + 7 ].specialsurvey,
                        ddtArr[ startIndex + 8 ].specialsurvey,
                        ddtArr[ startIndex + 9 ].specialsurvey,
                        ddtArr[ startIndex + 10 ].specialsurvey,
                        ddtArr[ startIndex + 11 ].specialsurvey,
                        ddtArr[ startIndex + 12 ].specialsurvey,
                        ddtArr[ startIndex + 13 ].specialsurvey,
                        ddtArr[ startIndex + 14 ].specialsurvey,
                        ddtArr[ startIndex + 15 ].specialsurvey,
                        ddtArr[ startIndex + 16 ].specialsurvey,
                        ddtArr[ startIndex + 17 ].specialsurvey,
                        ddtArr[ startIndex + 18 ].specialsurvey,
                        ddtArr[ startIndex + 19 ].specialsurvey,
//                        ddtArr[ 20 ].specialsurvey
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                
                
                 {
                    name: '参加视察、调研及执法检查',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].totalMixActivities,
                        ddtArr[ startIndex + 1 ].totalMixActivities,
                        ddtArr[ startIndex + 2 ].totalMixActivities,
                        ddtArr[ startIndex + 3 ].totalMixActivities,
                        ddtArr[ startIndex + 4 ].totalMixActivities,
                        ddtArr[ startIndex + 5 ].totalMixActivities,
                        ddtArr[ startIndex + 6 ].totalMixActivities,
                        ddtArr[ startIndex + 7 ].totalMixActivities,
                        ddtArr[ startIndex + 8 ].totalMixActivities,
                        ddtArr[ startIndex + 9 ].totalMixActivities,
                        ddtArr[ startIndex + 10 ].totalMixActivities,
                        ddtArr[ startIndex + 11 ].totalMixActivities,
                        ddtArr[ startIndex + 12 ].totalMixActivities,
                        ddtArr[ startIndex + 13 ].totalMixActivities,
                        ddtArr[ startIndex + 14 ].totalMixActivities,
                        ddtArr[ startIndex + 15 ].totalMixActivities,
                        ddtArr[ startIndex + 16 ].totalMixActivities,
                        ddtArr[ startIndex + 17 ].totalMixActivities,
                        ddtArr[ startIndex + 18 ].totalMixActivities,
                        ddtArr[ startIndex + 19 ].totalMixActivities,
//                        ddtArr[ 20 ].totalMixActivities
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                
                 {
                    name: '接待选民',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].recievevoters,
                        ddtArr[ startIndex + 1 ].recievevoters,
                        ddtArr[ startIndex + 2 ].recievevoters,
                        ddtArr[ startIndex + 3 ].recievevoters,
                        ddtArr[ startIndex + 4 ].recievevoters,
                        ddtArr[ startIndex + 5 ].recievevoters,
                        ddtArr[ startIndex + 6 ].recievevoters,
                        ddtArr[ startIndex + 7 ].recievevoters,
                        ddtArr[ startIndex + 8 ].recievevoters,
                        ddtArr[ startIndex + 9 ].recievevoters,
                        ddtArr[ startIndex + 10 ].recievevoters,
                        ddtArr[ startIndex + 11 ].recievevoters,
                        ddtArr[ startIndex + 12 ].recievevoters,
                        ddtArr[ startIndex + 13 ].recievevoters,
                        ddtArr[ startIndex + 14 ].recievevoters,
                        ddtArr[ startIndex + 15 ].recievevoters,
                        ddtArr[ startIndex + 16 ].recievevoters,
                        ddtArr[ startIndex + 17 ].recievevoters,
                        ddtArr[ startIndex + 18 ].recievevoters,
                        ddtArr[ startIndex + 19 ].recievevoters,
//                        ddtArr[ 20 ].recievevoters
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                
                {
                    name: '化解矛盾纠纷',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].resolvedispute,
                        ddtArr[ startIndex + 1 ].resolvedispute,
                        ddtArr[ startIndex + 2 ].resolvedispute,
                        ddtArr[ startIndex + 3 ].resolvedispute,
                        ddtArr[ startIndex + 4 ].resolvedispute,
                        ddtArr[ startIndex + 5 ].resolvedispute,
                        ddtArr[ startIndex + 6 ].resolvedispute,
                        ddtArr[ startIndex + 7 ].resolvedispute,
                        ddtArr[ startIndex + 8 ].resolvedispute,
                        ddtArr[ startIndex + 9 ].resolvedispute,
                        ddtArr[ startIndex + 10 ].resolvedispute,
                        ddtArr[ startIndex + 11 ].resolvedispute,
                        ddtArr[ startIndex + 12 ].resolvedispute,
                        ddtArr[ startIndex + 13 ].resolvedispute,
                        ddtArr[ startIndex + 14 ].resolvedispute,
                        ddtArr[ startIndex + 15 ].resolvedispute,
                        ddtArr[ startIndex + 16 ].resolvedispute,
                        ddtArr[ startIndex + 17 ].resolvedispute,
                        ddtArr[ startIndex + 18 ].resolvedispute,
                        ddtArr[ startIndex + 19 ].resolvedispute,
//                        ddtArr[ 20 ].resolvedispute
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                {
                    name: '扶弱济困',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].helpweak,
                        ddtArr[ startIndex + 1 ].helpweak,
                        ddtArr[ startIndex + 2 ].helpweak,
                        ddtArr[ startIndex + 3 ].helpweak,
                        ddtArr[ startIndex + 4 ].helpweak,
                        ddtArr[ startIndex + 5 ].helpweak,
                        ddtArr[ startIndex + 6 ].helpweak,
                        ddtArr[ startIndex + 7 ].helpweak,
                        ddtArr[ startIndex + 8 ].helpweak,
                        ddtArr[ startIndex + 9 ].helpweak,
                        ddtArr[ startIndex + 10 ].helpweak,
                        ddtArr[ startIndex + 11 ].helpweak,
                        ddtArr[ startIndex + 12 ].helpweak,
                        ddtArr[ startIndex + 13 ].helpweak,
                        ddtArr[ startIndex + 14 ].helpweak,
                        ddtArr[ startIndex + 15 ].helpweak,
                        ddtArr[ startIndex + 16 ].helpweak,
                        ddtArr[ startIndex + 17 ].helpweak,
                        ddtArr[ startIndex + 18 ].helpweak,
                        ddtArr[ startIndex + 19 ].helpweak,
//                        ddtArr[ startIndex + 20 ].helpweak
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                {
                    name: '办好事、办实事',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].goodthing,
                        ddtArr[ startIndex + 1 ].goodthing,
                        ddtArr[ startIndex + 2 ].goodthing,
                        ddtArr[ startIndex + 3 ].goodthing,
                        ddtArr[ startIndex + 4 ].goodthing,
                        ddtArr[ startIndex + 5 ].goodthing,
                        ddtArr[ startIndex + 6 ].goodthing,
                        ddtArr[ startIndex + 7 ].goodthing,
                        ddtArr[ startIndex + 8 ].goodthing,
                        ddtArr[ startIndex + 9 ].goodthing,
                        ddtArr[ startIndex + 10 ].goodthing,
                        ddtArr[ startIndex + 11 ].goodthing,
                        ddtArr[ startIndex + 12 ].goodthing,
                        ddtArr[ startIndex + 13 ].goodthing,
                        ddtArr[ startIndex + 14 ].goodthing,
                        ddtArr[ startIndex + 15 ].goodthing,
                        ddtArr[ startIndex + 16 ].goodthing,
                        ddtArr[ startIndex + 17 ].goodthing,
                        ddtArr[ startIndex + 18 ].goodthing,
                        ddtArr[ startIndex + 19 ].goodthing,
//                        ddtArr[ startIndex + 20 ].goodthing
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                {
                    name: '参加公益慈善事业',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].charity,
                        ddtArr[ startIndex + 1 ].charity,
                        ddtArr[ startIndex + 2 ].charity,
                        ddtArr[ startIndex + 3 ].charity,
                        ddtArr[ startIndex + 4 ].charity,
                        ddtArr[ startIndex + 5 ].charity,
                        ddtArr[ startIndex + 6 ].charity,
                        ddtArr[ startIndex + 7 ].charity,
                        ddtArr[ startIndex + 8 ].charity,
                        ddtArr[ startIndex + 9 ].charity,
                        ddtArr[ startIndex + 10 ].charity,
                        ddtArr[ startIndex + 11 ].charity,
                        ddtArr[ startIndex + 12 ].charity,
                        ddtArr[ startIndex + 13 ].charity,
                        ddtArr[ startIndex + 14 ].charity,
                        ddtArr[ startIndex + 15 ].charity,
                        ddtArr[ startIndex + 16 ].charity,
                        ddtArr[ startIndex + 17 ].charity,
                        ddtArr[ startIndex + 18 ].charity,
                        ddtArr[ startIndex + 19 ].charity,
//                        ddtArr[ 20 ].inquery
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
                {
                    name: '向选民述职',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].reportvoter,
                        ddtArr[ startIndex + 1 ].reportvoter,
                        ddtArr[ startIndex + 2 ].reportvoter,
                        ddtArr[startIndex +  3 ].reportvoter,
                        ddtArr[ startIndex + 4 ].reportvoter,
                        ddtArr[ startIndex + 5 ].reportvoter,
                        ddtArr[ startIndex + 6 ].reportvoter,
                        ddtArr[ startIndex + 7 ].reportvoter,
                        ddtArr[ startIndex + 8 ].reportvoter,
                        ddtArr[ startIndex + 9 ].reportvoter,
                        ddtArr[ startIndex + 10 ].reportvoter,
                        ddtArr[ startIndex + 11 ].reportvoter,
                        ddtArr[ startIndex + 12 ].reportvoter,
                        ddtArr[ startIndex + 13 ].reportvoter,
                        ddtArr[ startIndex + 14 ].reportvoter,
                        ddtArr[ startIndex + 15 ].reportvoter,
                        ddtArr[ startIndex + 16 ].reportvoter,
                        ddtArr[ startIndex + 17 ].reportvoter,
                        ddtArr[ startIndex + 18 ].reportvoter,
                        ddtArr[ startIndex + 19 ].reportvoter,
//                        ddtArr[ startIndex + 20 ].inquery
                    ],
                    itemStyle: { // 柱形图圆角，鼠标移上去效果
                        emphasis: {
                            barBorderRadius: [0, 0, 0, 0]
                        },
                        normal: { // 柱形图圆角，初始化效果
                            barBorderRadius: [0, 0, 0, 0]
                        }
                    }
                },
       
                {
                    name: '其他',
                    type: 'bar',
                    data: [
                        ddtArr[ startIndex + 0 ].other,
                        ddtArr[ startIndex + 1 ].other,
                        ddtArr[ startIndex + 2 ].other,
                        ddtArr[startIndex +  3 ].other,
                        ddtArr[ startIndex + 4 ].other,
                        ddtArr[ startIndex + 5 ].other,
                        ddtArr[ startIndex + 6 ].other,
                        ddtArr[ startIndex + 7 ].other,
                        ddtArr[ startIndex + 8 ].other,
                        ddtArr[ startIndex + 9 ].other,
                        ddtArr[ startIndex + 10 ].other,
                        ddtArr[ startIndex + 11 ].other,
                        ddtArr[ startIndex + 12 ].other,
                        ddtArr[ startIndex + 13 ].other,
                        ddtArr[ startIndex + 14 ].other,
                        ddtArr[ startIndex + 15 ].other,
                        ddtArr[ startIndex + 16 ].other,
                        ddtArr[ startIndex + 17 ].other,
                        ddtArr[ startIndex + 18 ].other,
                        ddtArr[ startIndex + 19 ].other,
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

 deputy_bar.setOption(option);
        window.addEventListener("resize",function(){
            deputy_bar.resize();
        });
        deputy_bar.on('click', function (params) {
            console.log(params );          
        })
}



function showdeputyChart( ddtArr ) {
    
    option = {
        backgroundColor: '#FFFFFF',    

    title: {
        text: '代表团建议议案统计',
        left: 'left'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c}件 ({d}%)'
    },
    legend: {
      type: 'scroll',
      orient: 'vertical',
      right: 40,
      top: 20,
      bottom: 20,
      data: deputydelegation

    },
    series: [
      {
        name: '数据',
        type: 'pie',
        radius: [50, 250],
        center: ['50%', '50%'],
        roseType: 'area',
        itemStyle: {
          borderRadius: 8
        },
        label:{   //文本样式处理
          formatter: "{b|{b}} {c}件, {d}%\n\n",
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
       

      
//      data: suggestdata
      data: [
        { value: ddtArr[ 0 ].value , name: ddtArr[ 0 ].name },
        { value: ddtArr[ 1 ].value , name: ddtArr[ 1 ].name },
        { value: ddtArr[ 2 ].value , name: ddtArr[ 2 ].name },
        { value: ddtArr[ 3 ].value , name: ddtArr[ 3 ].name },
        { value: ddtArr[ 4 ].value , name: ddtArr[ 4 ].name },
        { value: ddtArr[ 5 ].value , name: ddtArr[ 5 ].name },
        { value: ddtArr[ 6 ].value , name: ddtArr[ 6 ].name },
        { value: ddtArr[ 7 ].value , name: ddtArr[ 7 ].name },
        { value: ddtArr[ 8 ].value , name: ddtArr[ 8 ].name },
        { value: ddtArr[ 9 ].value , name: ddtArr[ 9 ].name },
        { value: ddtArr[ 10 ].value , name: ddtArr[ 10 ].name },
        { value: ddtArr[ 11 ].value , name: ddtArr[ 11 ].name },
        { value: ddtArr[ 12 ].value , name: ddtArr[ 12 ].name },
        { value: ddtArr[ 13 ].value , name: ddtArr[ 13 ].name },
        { value: ddtArr[ 14 ].value , name: ddtArr[ 14 ].name },
        { value: ddtArr[ 15 ].value , name: ddtArr[ 15 ].name },
        { value: ddtArr[ 16 ].value , name: ddtArr[ 16 ].name },
        { value: ddtArr[ 17 ].value , name: ddtArr[ 17 ].name },
        { value: ddtArr[ 18 ].value , name: ddtArr[ 18 ].name },
        { value: ddtArr[ 19 ].value , name: ddtArr[ 19 ].name },
        { value: ddtArr[ 20 ].value , name: ddtArr[ 20 ].name },
      ]
    }
  ]
};
 deputyChart.setOption(option);
 window.addEventListener("resize",function(){
    deputyChart.resize();
 });
 deputyChart.on('click', function (params) {
    console.log(params );          
 })

}



function showActivityBarChart_old( data ){
    var activity_bar = echarts.init(document.getElementById( 'activity_bar' ));

    option = {
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          // Use axis to trigger tooltip
          type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
        }
      },
      legend: {},
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      xAxis: {
        type: 'value'
      },
      yAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      series: [
        {
          name: 'Direct',
          type: 'bar',
          stack: 'total',
          label: {
            show: true
          },
          emphasis: {
            focus: 'series'
          },
          data: [320, 302, 301, 334, 390, 330, 320]
        },
        {
          name: 'Mail Ad',
          type: 'bar',
          stack: 'total',
          label: {
            show: true
          },
          emphasis: {
            focus: 'series'
          },
          data: [120, 132, 101, 134, 90, 230, 210]
        },
        {
          name: 'Affiliate Ad',
          type: 'bar',
          stack: 'total',
          label: {
            show: true
          },
          emphasis: {
            focus: 'series'
          },
          data: [220, 182, 191, 234, 290, 330, 310]
        },
        {
          name: 'Video Ad',
          type: 'bar',
          stack: 'total',
          label: {
            show: true
          },
          emphasis: {
            focus: 'series'
          },
          data: [150, 212, 201, 154, 190, 330, 410]
        },
        {
          name: 'Search Engine',
          type: 'bar',
          stack: 'total',
          label: {
            show: true
          },
          emphasis: {
            focus: 'series'
          },
          data: [820, 832, 901, 934, 1290, 1330, 1320]
        }
      ]
    };
    activity_bar.setOption(option);
    window.addEventListener("resize",function(){
       activity_bar.resize();
    });
 
}



