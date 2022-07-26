var quatityChart = echarts.init(document.getElementById( 'quatity' ));

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
function showquatityChart( delegateData ){

option = {
   backgroundColor: '#FFFFFF',  
  title: {
    text: '代表团人大代表数量统计',
//    subtext: 'Fake Data',
    left: 'left'
  },
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b} : {c} ({d}%)'
  },
  
  legend: {
    type: 'scroll',
    orient: 'vertical',
    right: 10,
    top: 20,
    bottom: 20,
    data: delegation
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
      radius: [40, 200],

      center: ['50%', '50%'],
      roseType: 'area',
      itemStyle: {
        borderRadius: 5
      },
      labelLine:{
            normal:{
                length:20,  //视觉引导线长度
                length2:30
            }
        },
       label:{   //文本样式处理
        formatter: "{b|{b}} {c}人,{d}%\n\n",
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
        { value: delegateData[ 0 ].value, name: delegation[ 0 ] },
        { value: delegateData[ 1 ].value, name: delegation[ 1 ] },
        { value: delegateData[ 2 ].value, name: delegation[ 2 ] },
        { value: delegateData[ 3 ].value, name: delegation[ 3 ] },
        { value: delegateData[ 4 ].value, name: delegation[ 4 ] }, 
        { value: delegateData[ 5 ].value, name: delegation[ 5 ] },
        { value: delegateData[ 6 ].value, name: delegation[ 6 ] }, 
        { value: delegateData[ 7 ].value, name: delegation[ 7 ] },
        { value: delegateData[ 8 ].value, name: delegation[ 8 ] },
        { value: delegateData[ 9 ].value, name: delegation[ 9 ] },
        { value: delegateData[ 10 ].value, name: delegation[ 10 ] },
        { value: delegateData[ 11 ].value, name: delegation[ 11 ] },
        { value: delegateData[ 12 ].value, name: delegation[ 12 ] }, 
        { value: delegateData[ 13 ].value, name: delegation[ 13 ] },
        { value: delegateData[ 14 ].value, name: delegation[ 14 ] }, 
        { value: delegateData[ 15 ].value, name: delegation[ 15 ] },
        { value: delegateData[ 16 ].value, name: delegation[ 16 ] }, 
        { value: delegateData[ 17 ].value, name: delegation[ 17 ] },
        { value: delegateData[ 18 ].value, name: delegation[ 18 ] },
        { value: delegateData[ 19 ].value, name: delegation[ 19 ] },
        { value: delegateData[ 20 ].value, name: delegation[ 20 ] },
      ]
    }
  ]
};
 quatityChart.setOption(option);
        window.addEventListener("resize",function(){
            quatityChart.resize();
        });
        quatityChart.on('click', function (params) {
            console.log(params );          
        })

}


function showquatitybarChart(  delegateData ){
    var quatity_bar = echarts.init(document.getElementById( 'quatity_bar' ));
   
   option = {
        backgroundColor: '#FFFFFF',
        title: {
            text: '代表团代表数量统计',
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
            data: delegation,
            textStyle: {
                color: "#000"
              }

        },
//        color: [
//
//                'rgb(159,230,180)',
//                'rgb(255,114,147)',
//                'rgb(130,120,223)',
//                'rgb(47,197,223)',
//                'rgb(255,159,120)',
//                'rgb(231,188,242)',
//                'rgb(71,96,255)',
//            
//           
//        ],
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
                    name: '数量',
                    type: 'bar',
                    data: [
                        delegateData[ 0 ].value,
                        delegateData[ 1 ].value,
                        delegateData[ 2 ].value,
                        delegateData[ 3 ].value,
                        delegateData[ 4 ].value,
                        delegateData[ 5 ].value,
                        delegateData[ 6 ].value,
                        delegateData[ 7 ].value,
                        delegateData[ 8 ].value,
                        delegateData[ 9 ].value,
                        delegateData[ 10 ].value,
                        delegateData[ 11 ].value,
                        delegateData[ 12 ].value,
                        delegateData[ 13 ].value,
                        delegateData[ 14 ].value,
                        delegateData[ 15 ].value,
                        delegateData[ 16 ].value,
                        delegateData[ 17 ].value,
                        delegateData[ 18 ].value,
                        delegateData[ 19 ].value,
                        delegateData[ 20 ].value
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

 quatity_bar.setOption(option);
        window.addEventListener("resize",function(){
            quatity_bar.resize();
        });
        quatity_bar.on('click', function (params) {
            console.log(params );          
        })
}
