var genderChart = echarts.init(document.getElementById( 'gender' ));

function showgenderChart(male,female,maleFor,femaleFor ,unkown,unknowRate ){

option = {
   backgroundColor: '#FFFFFF',  
  title: {
    text: '人大代表性别统计',
//    subtext: 'Fake Data',
    left: 'center'
  },
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b} : {c} ({d}%)'
  },
  
  legend: {
    left: 'center',
    top: 'bottom',
    data: [
      '男',
      '女',
      '未知'
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
//    {
//      name: 'Radius Mode',
//      type: 'pie',
//      radius: [20, 140],
//      center: ['25%', '50%'],
//      roseType: 'radius',
//      itemStyle: {
//        borderRadius: 5
//      },
//      label: {
//        show: false
//      },
//      emphasis: {
//        label: {
//          show: true
//        }
//      },
//      data: [
//        { value: 40, name: '男' },
//        { value: 33, name: '女' },
//        { value: 28, name: '未知' },
//      ]
//    },
    {
      name: 'Area Mode',
      type: 'pie',
//      radius: [20, 140],
      radius: [40, 200],

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
      data: [
        { value: male, name: '男' },
        { value: female, name: '女' },
        { value: unkown, name: '未知' },
      ]
    }
  ]
};
 genderChart.setOption(option);
        window.addEventListener("resize",function(){
            genderChart.resize();
        });
        genderChart.on('click', function (params) {
            console.log(params );          
        })

}


function showgenderbarChart(  missionMale ,missionFemale, missionUnkown ){
    var gender_bar = echarts.init(document.getElementById( 'gender_bar' ));
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
            text: '代表团代表性别统计',
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
                '男性', '女性', '未知'
            ],
            textStyle: {
                color: "#000"
              }

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
                    name: '男性',
                    type: 'bar',
                    data: [
                        missionMale[ 0 ].value,
                        missionMale[ 1 ].value,
                        missionMale[ 2 ].value,
                        missionMale[ 3 ].value,
                        missionMale[ 4 ].value,
                        missionMale[ 5 ].value,
                        missionMale[ 6 ].value,
                        missionMale[ 7 ].value,
                        missionMale[ 8 ].value,
                        missionMale[ 9 ].value,
                        missionMale[ 10 ].value,
                        missionMale[ 11 ].value,
                        missionMale[ 12 ].value,
                        missionMale[ 13 ].value,
                        missionMale[ 14 ].value,
                        missionMale[ 15 ].value,
                        missionMale[ 16 ].value,
                        missionMale[ 17 ].value,
                        missionMale[ 18 ].value,
                        missionMale[ 19 ].value,
                        missionMale[ 20 ].value
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
                    name: '女性',
                    type: 'bar',
                    data: [
                        missionFemale[ 0 ].value,
                        missionFemale[ 1 ].value,
                        missionFemale[ 2 ].value,
                        missionFemale[ 3 ].value,
                        missionFemale[ 4 ].value,
                        missionFemale[ 5 ].value,
                        missionFemale[ 6 ].value,
                        missionFemale[ 7 ].value,
                        missionFemale[ 8 ].value,
                        missionFemale[ 9 ].value,
                        missionFemale[ 10 ].value,
                        missionFemale[ 11 ].value,
                        missionFemale[ 12 ].value,
                        missionFemale[ 13 ].value,
                        missionFemale[ 14 ].value,
                        missionFemale[ 15 ].value,
                        missionFemale[ 16 ].value,
                        missionFemale[ 17 ].value,
                        missionFemale[ 18 ].value,
                        missionFemale[ 19 ].value,
                        missionFemale[ 20 ].value
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
                    name: '未知',
                    type: 'bar',
                    data: [
                     missionUnkown[ 0 ].value,
                    missionUnkown[ 1 ].value,
                    missionUnkown[ 2 ].value,
                    missionUnkown[ 3 ].value,
                    missionUnkown[ 4 ].value,
                    missionUnkown[ 5 ].value,
                    missionUnkown[ 6 ].value,
                    missionUnkown[ 7 ].value,
                    missionUnkown[ 8 ].value,
                    missionUnkown[ 9 ].value,
                    missionUnkown[ 10 ].value,
                    missionUnkown[ 11 ].value,
                    missionUnkown[ 12 ].value,
                    missionUnkown[ 13 ].value,
                    missionUnkown[ 14 ].value,
                    missionUnkown[ 15 ].value,
                    missionUnkown[ 16 ].value,
                    missionUnkown[ 17 ].value,
                    missionUnkown[ 18 ].value,
                    missionUnkown[ 19 ].value,
                    missionUnkown[ 20 ].value
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

 gender_bar.setOption(option);
        window.addEventListener("resize",function(){
            gender_bar.resize();
        });
        gender_bar.on('click', function (params) {
            console.log(params );          
        })
}
