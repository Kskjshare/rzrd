var partyChart = echarts.init(document.getElementById( 'part' ));

function showpartyChart( dangpai  ){
option = {
   backgroundColor: '#FFFFFF',  
  title: {
    text: '人大代表党派统计',
    left: 'left'
  },
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b} : {c} ({d}%)'
  },

  legend: {
    left: 'center',
    top: 'top',
    data: [
      '中国共产党',
      '民主党',
      '无党派',
      '共青团',
      '群众'
    ]
  },
//  toolbox: {
//    show: true,
//    feature: {
//      mark: { show: true },
//      dataView: { show: true, readOnly: false },
//      restore: { show: true },
//      saveAsImage: { show: true }
//    }
//  },
  series: [
    {
      name: '具体数据',
      type: 'pie',
//      radius: [20, 140],
//      radius: [40, 140],
      radius: '35%',
      center: ['50%', '50%'],
      roseType: 'area',
      itemStyle: {
        borderRadius: 5
      },
      labelLine:{
            normal:{
                length:30,  //视觉引导线长度
                length2:50
            }
        },
       label:{   //文本样式处理
        formatter: "{b|{b}} {c}人, {d}%\n\n",
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
       
      data: [
        { value: dangpai[0].value, name: '中国共产党' },
        { value: dangpai[1].value, name: '民主党' },
        { value: dangpai[2].value, name: '无党派' },
        { value: dangpai[3].value, name: '共青团' },
        { value: dangpai[4].value, name: '群众' }
      ]
    }
  ]
};
 partyChart.setOption(option);
        window.addEventListener("resize",function(){
            partyChart.resize();
        });
        partyChart.on('click', function (params) {
            console.log(params );          
        })

}


function showpartybarChart(   partyCCP , partyDem ,partyNo ,partyYouth ,partyNormal  ){
    var party_bar = echarts.init(document.getElementById( 'party_bar' ));
    var delegation =[
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
   option = {
        backgroundColor: '#FFFFFF',
        title: {
            text: '代表团代表党派统计',
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
          '中国共产党',
          '民主党',
          '无党派',
          '共青团',
          '群众'
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
            data:delegation,
            axisLine: {
                lineStyle: {
                color: "#000"
                  }
            },
            
            axisLabel:{
                        interval:0,//横轴信息全部显示
                        rotate:45,//度角倾斜显示
                        formatter:function(delegation){//只显示五个字 其余省略号
                            return delegation.length > 4?delegation.substring(0,4)+'...':delegation;
                        }
                    }

            },
            series: [
                {
                    name: '中国共产党',
                    type: 'bar',
                    data: [
                        partyCCP[ 0 ].value,
                        partyCCP[ 1 ].value,
                        partyCCP[ 2 ].value,
                        partyCCP[ 3 ].value,
                        partyCCP[ 4 ].value,
                        partyCCP[ 5 ].value,
                        partyCCP[ 6 ].value,
                        partyCCP[ 7 ].value,
                        partyCCP[ 8 ].value,
                        partyCCP[ 9 ].value,
                        partyCCP[ 10 ].value,
                        partyCCP[ 11 ].value,
                        partyCCP[ 12 ].value,
                        partyCCP[ 13 ].value,
                        partyCCP[ 14 ].value,
                        partyCCP[ 15 ].value,
                        partyCCP[ 16 ].value,
                        partyCCP[ 17 ].value,
                        partyCCP[ 18 ].value,
                        partyCCP[ 19 ].value,
                        partyCCP[ 20 ].value
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
                    name: '民主党',
                    type: 'bar',
                    data: [
                        partyDem[ 0 ].value,
                        partyDem[ 1 ].value,
                        partyDem[ 2 ].value,
                        partyDem[ 3 ].value,
                        partyDem[ 4 ].value,
                        partyDem[ 5 ].value,
                        partyDem[ 6 ].value,
                        partyDem[ 7 ].value,
                        partyDem[ 8 ].value,
                        partyDem[ 9 ].value,
                        partyDem[ 10 ].value,
                        partyDem[ 11 ].value,
                        partyDem[ 12 ].value,
                        partyDem[ 13 ].value,
                        partyDem[ 14 ].value,
                        partyDem[ 15 ].value,
                        partyDem[ 16 ].value,
                        partyDem[ 17 ].value,
                        partyDem[ 18 ].value,
                        partyDem[ 19 ].value,
                        partyDem[ 20 ].value
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
                    name: '无党派',
                    type: 'bar',
                    data: [
                    partyNo[ 0 ].value,
                    partyNo[ 1 ].value,
                    partyNo[ 2 ].value,
                    partyNo[ 3 ].value,
                    partyNo[ 4 ].value,
                    partyNo[ 5 ].value,
                    partyNo[ 6 ].value,
                    partyNo[ 7 ].value,
                    partyNo[ 8 ].value,
                    partyNo[ 9 ].value,
                    partyNo[ 10 ].value,
                    partyNo[ 11 ].value,
                    partyNo[ 12 ].value,
                    partyNo[ 13 ].value,
                    partyNo[ 14 ].value,
                    partyNo[ 15 ].value,
                    partyNo[ 16 ].value,
                    partyNo[ 17 ].value,
                    partyNo[ 18 ].value,
                    partyNo[ 19 ].value,
                    partyNo[ 20 ].value
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
                    name: '共青团',
                    type: 'bar',
                    data: [
                    partyYouth[ 0 ].value,
                    partyYouth[ 1 ].value,
                    partyYouth[ 2 ].value,
                    partyYouth[ 3 ].value,
                    partyYouth[ 4 ].value,
                    partyYouth[ 5 ].value,
                    partyYouth[ 6 ].value,
                    partyYouth[ 7 ].value,
                    partyYouth[ 8 ].value,
                    partyYouth[ 9 ].value,
                    partyYouth[ 10 ].value,
                    partyYouth[ 11 ].value,
                    partyYouth[ 12 ].value,
                    partyYouth[ 13 ].value,
                    partyYouth[ 14 ].value,
                    partyYouth[ 15 ].value,
                    partyYouth[ 16 ].value,
                    partyYouth[ 17 ].value,
                    partyYouth[ 18 ].value,
                    partyYouth[ 19 ].value,
                    partyYouth[ 20 ].value
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
                    name: '群众',
                    type: 'bar',
                    data: [
                    partyNormal[ 0 ].value,
                    partyNormal[ 1 ].value,
                    partyNormal[ 2 ].value,
                    partyNormal[ 3 ].value,
                    partyNormal[ 4 ].value,
                    partyNormal[ 5 ].value,
                    partyNormal[ 6 ].value,
                    partyNormal[ 7 ].value,
                    partyNormal[ 8 ].value,
                    partyNormal[ 9 ].value,
                    partyNormal[ 10 ].value,
                    partyNormal[ 11 ].value,
                    partyNormal[ 12 ].value,
                    partyNormal[ 13 ].value,
                    partyNormal[ 14 ].value,
                    partyNormal[ 15 ].value,
                    partyNormal[ 16 ].value,
                    partyNormal[ 17 ].value,
                    partyNormal[ 18 ].value,
                    partyNormal[ 19 ].value,
                    partyNormal[ 20 ].value
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

 party_bar.setOption(option);
        window.addEventListener("resize",function(){
            party_bar.resize();
        });
        party_bar.on('click', function (params) {
            console.log(params );          
        })
}



