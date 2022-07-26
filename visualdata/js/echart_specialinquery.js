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
    
    

function showdeputybarChart( ddtArr ){
    var deputy_bar = echarts.init(document.getElementById( 'deputy_bar' ));
   
    var title ='代表团建议议案统计';
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
          '时间',
          '议案',
          '批评',
          '意见',
          '质询'
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
            data:deputydelegation,
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
                    name: '建议',
                    type: 'bar',
                    data: [
                        ddtArr[ 0 ].suggest,
                        ddtArr[ 1 ].suggest,
                        ddtArr[ 2 ].suggest,
                        ddtArr[ 3 ].suggest,
                        ddtArr[ 4 ].suggest,
                        ddtArr[ 5 ].suggest,
                        ddtArr[ 6 ].suggest,
                        ddtArr[ 7 ].suggest,
                        ddtArr[ 8 ].suggest,
                        ddtArr[ 9 ].suggest,
                        ddtArr[ 10 ].suggest,
                        ddtArr[ 11 ].suggest,
                        ddtArr[ 12 ].suggest,
                        ddtArr[ 13 ].suggest,
                        ddtArr[ 14 ].suggest,
                        ddtArr[ 15 ].suggest,
                        ddtArr[ 16 ].suggest,
                        ddtArr[ 17 ].suggest,
                        ddtArr[ 18 ].suggest,
                        ddtArr[ 19 ].suggest,
                        ddtArr[ 20 ].suggest
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
                    name: '议案',
                    type: 'bar',
                    data: [
                        ddtArr[ 0 ].bill,
                        ddtArr[ 1 ].bill,
                        ddtArr[ 2 ].bill,
                        ddtArr[ 3 ].bill,
                        ddtArr[ 4 ].bill,
                        ddtArr[ 5 ].bill,
                        ddtArr[ 6 ].bill,
                        ddtArr[ 7 ].bill,
                        ddtArr[ 8 ].bill,
                        ddtArr[ 9 ].bill,
                        ddtArr[ 10 ].bill,
                        ddtArr[ 11 ].bill,
                        ddtArr[ 12 ].bill,
                        ddtArr[ 13 ].bill,
                        ddtArr[ 14 ].bill,
                        ddtArr[ 15 ].bill,
                        ddtArr[ 16 ].bill,
                        ddtArr[ 17 ].bill,
                        ddtArr[ 18 ].bill,
                        ddtArr[ 19 ].bill,
                        ddtArr[ 20 ].bill
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
                    name: '批评',
                    type: 'bar',
                    data: [
                        ddtArr[ 0 ].criticise,
                        ddtArr[ 1 ].criticise,
                        ddtArr[ 2 ].criticise,
                        ddtArr[ 3 ].criticise,
                        ddtArr[ 4 ].criticise,
                        ddtArr[ 5 ].criticise,
                        ddtArr[ 6 ].criticise,
                        ddtArr[ 7 ].criticise,
                        ddtArr[ 8 ].criticise,
                        ddtArr[ 9 ].criticise,
                        ddtArr[ 10 ].criticise,
                        ddtArr[ 11 ].criticise,
                        ddtArr[ 12 ].criticise,
                        ddtArr[ 13 ].criticise,
                        ddtArr[ 14 ].criticise,
                        ddtArr[ 15 ].criticise,
                        ddtArr[ 16 ].criticise,
                        ddtArr[ 17 ].criticise,
                        ddtArr[ 18 ].criticise,
                        ddtArr[ 19 ].criticise,
                        ddtArr[ 20 ].criticise
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
                    name: '意见',
                    type: 'bar',
                    data: [
                        ddtArr[ 0 ].opinion,
                        ddtArr[ 1 ].opinion,
                        ddtArr[ 2 ].opinion,
                        ddtArr[ 3 ].opinion,
                        ddtArr[ 4 ].opinion,
                        ddtArr[ 5 ].opinion,
                        ddtArr[ 6 ].opinion,
                        ddtArr[ 7 ].opinion,
                        ddtArr[ 8 ].opinion,
                        ddtArr[ 9 ].opinion,
                        ddtArr[ 10 ].opinion,
                        ddtArr[ 11 ].opinion,
                        ddtArr[ 12 ].opinion,
                        ddtArr[ 13 ].opinion,
                        ddtArr[ 14 ].opinion,
                        ddtArr[ 15 ].opinion,
                        ddtArr[ 16 ].opinion,
                        ddtArr[ 17 ].opinion,
                        ddtArr[ 18 ].opinion,
                        ddtArr[ 19 ].opinion,
                        ddtArr[ 20 ].opinion
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
                    name: '质询',
                    type: 'bar',
                    data: [
                        ddtArr[ 0 ].inquery,
                        ddtArr[ 1 ].inquery,
                        ddtArr[ 2 ].inquery,
                        ddtArr[ 3 ].inquery,
                        ddtArr[ 4 ].inquery,
                        ddtArr[ 5 ].inquery,
                        ddtArr[ 6 ].inquery,
                        ddtArr[ 7 ].inquery,
                        ddtArr[ 8 ].inquery,
                        ddtArr[ 9 ].inquery,
                        ddtArr[ 10 ].inquery,
                        ddtArr[ 11 ].inquery,
                        ddtArr[ 12 ].inquery,
                        ddtArr[ 13 ].inquery,
                        ddtArr[ 14 ].inquery,
                        ddtArr[ 15 ].inquery,
                        ddtArr[ 16 ].inquery,
                        ddtArr[ 17 ].inquery,
                        ddtArr[ 18 ].inquery,
                        ddtArr[ 19 ].inquery,
                        ddtArr[ 20 ].inquery
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