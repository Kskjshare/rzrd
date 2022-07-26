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
    
    

function showSpecialworkbarChart( ddtArr ,startIndex , deputy_bar){
var chartDom = document.getElementById('deputy_bar');
var myChart = echarts.init(chartDom);


    let xAxisData = [];
    let yAxisData = [];
    let cnt = 0 ;
    for (let i = startIndex; i < ddtArr.length ; i++) {  
      cnt ++ ;
      xAxisData.push( ddtArr[i].name );
      yAxisData.push( ddtArr[i].cnt )
    }
var title ='听取和审议专项工作报告统计';
var option;

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
    
  xAxis: {
    type: 'category',
    data: xAxisData
  },
  yAxis: {
    type: 'value'
  },
  
  
   legend: {
        left: 'center',
        top: 'top',
        data:xAxisData
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
  
  series: [
    {
      data: yAxisData,
      type: 'bar',
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

option && myChart.setOption(option);

}


function showSpecialworkbarChart111( ddtArr ,startIndex , deputy_bar){
    var deputy_bar = echarts.init(document.getElementById( 'deputy_bar' ));
   
   
   console.log(" ___________ ddtarr = ", ddtArr )
    let xAxisData = [];

    let cnt = 0 ;
    for (let i = startIndex; i < ddtArr.length ; i++) {
        if ( cnt >= 20 ) {
            break;
        }
        cnt ++ ;
      xAxisData.push( ddtArr[i].name );
      
      
    }
   
    var title ='听取和审议专项工作报告统计';
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
          '经济类',
          '交通类',
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
                    name: '听取和审议专项工作报告',
                    type: 'bar',
                    data: [
                        ddtArr[ 0 ].cnt,
                        ddtArr[ 1 ].cnt,
                        ddtArr[ 2 ].cnt,
                        ddtArr[ 3 ].cnt,
                        
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