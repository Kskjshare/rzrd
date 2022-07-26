var nationalityChart = echarts.init(document.getElementById( 'nationality' ));

var nationalityList = ["未知", "汉族", "壮族","满族","回族", "苗族","藏族", "维吾尔族","土家族","彝族", 
			"蒙古族", "布依族", "侗族","瑶族","朝鲜族", "白族", "哈尼族", "哈萨克族","黎族", "傣族", 
			"畲族","傈僳族","仡佬族","东乡族","高山族","拉祜族","水族","佤族","纳西族","羌族",
			"土族", "仫佬族", "锡伯族","柯尔克孜族","达斡尔族","景颇族", "瑶族", "撒拉族","布朗族","塔吉克族",
			"阿昌族","普米族","鄂温克族","怒族","京族","基诺族","德昂族","保安族", "俄罗斯族","裕固族", 
			"乌孜别克族","门巴族","鄂伦春族","独龙族", "塔塔尔族", "赫哲族", "珞巴族","毛南族"];
function shownationChart( nationality  ){
option = {
   backgroundColor: '#FFFFFF',  
  title: {
    text: '人大代表民族统计',
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
    data: nationalityList
  },
//  legend: {
//    left: 'center',
//    top: 'top',
//    data: nationalityList
//  },

  series: [
    {
      name: '具体数据',
      type: 'pie',
      radius: [20, 260],
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
       
      data: nationality
    }
  ]
};


//function genData(count) {
// 
//  const legendData = [];
//  const seriesData = [];
//  for (var i = 0; i < count; i++) {
//    var name =
//      Math.random() > 0.65
//        ? makeWord(4, 1) + '·' + makeWord(3, 0)
//        : makeWord(2, 1);
//    legendData.push(name);
//    seriesData.push({
//      name: name,
//      value: Math.round(Math.random() * 100000)
//    });
//  }
//  return {
//    legendData: legendData,
//    seriesData: seriesData
//  };
//  function makeWord(max, min) {
//    const nameLen = Math.ceil(Math.random() * max + min);
//    const name = [];
//    for (var i = 0; i < nameLen; i++) {
//      name.push(nameList[Math.round(Math.random() * nameList.length - 1)]);
//    }
//    return name.join('');
//  }
//}



 nationalityChart.setOption(option);
        window.addEventListener("resize",function(){
            nationalityChart.resize();
        });
        nationalityChart.on('click', function (params) {
            console.log(params );          
        })

}


function shownationbarChart(  nationality0 , nationality1 ,nationality2 ,nationality3 ,nationality4   ){
    var nationality_bar = echarts.init(document.getElementById( 'nationality_bar' ));
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
            text: '代表团代表民族统计',
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
        data:nationalityList
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
                    name: nationalityList[0] ,
                    type: 'bar',
                    data: [
                        nationality0[ 0 ].value,
                        nationality0[ 1 ].value,
                        nationality0[ 2 ].value,
                        nationality0[ 3 ].value,
                        nationality0[ 4 ].value,
                        nationality0[ 5 ].value,
                        nationality0[ 6 ].value,
                        nationality0[ 7 ].value,
                        nationality0[ 8 ].value,
                        nationality0[ 9 ].value,
                        nationality0[ 10 ].value,
                        nationality0[ 11 ].value,
                        nationality0[ 12 ].value,
                        nationality0[ 13 ].value,
                        nationality0[ 14 ].value,
                        nationality0[ 15 ].value,
                        nationality0[ 16 ].value,
                        nationality0[ 17 ].value,
                        nationality0[ 18 ].value,
                        nationality0[ 19 ].value,
                        nationality0[ 20 ].value
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
                    name: nationalityList[1],
                    type: 'bar',
                    data: [
                        nationality1[ 0 ].value,
                        nationality1[ 1 ].value,
                        nationality1[ 2 ].value,
                        nationality1[ 3 ].value,
                        nationality1[ 4 ].value,
                        nationality1[ 5 ].value,
                        nationality1[ 6 ].value,
                        nationality1[ 7 ].value,
                        nationality1[ 8 ].value,
                        nationality1[ 9 ].value,
                        nationality1[ 10 ].value,
                        nationality1[ 11 ].value,
                        nationality1[ 12 ].value,
                        nationality1[ 13 ].value,
                        nationality1[ 14 ].value,
                        nationality1[ 15 ].value,
                        nationality1[ 16 ].value,
                        nationality1[ 17 ].value,
                        nationality1[ 18 ].value,
                        nationality1[ 19 ].value,
                        nationality1[ 20 ].value
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
                    name: nationalityList[2],
                    type: 'bar',
                    data: [
                    nationality2[ 0 ].value,
                    nationality2[ 1 ].value,
                    nationality2[ 2 ].value,
                    nationality2[ 3 ].value,
                    nationality2[ 4 ].value,
                    nationality2[ 5 ].value,
                    nationality2[ 6 ].value,
                    nationality2[ 7 ].value,
                    nationality2[ 8 ].value,
                    nationality2[ 9 ].value,
                    nationality2[ 10 ].value,
                    nationality2[ 11 ].value,
                    nationality2[ 12 ].value,
                    nationality2[ 13 ].value,
                    nationality2[ 14 ].value,
                    nationality2[ 15 ].value,
                    nationality2[ 16 ].value,
                    nationality2[ 17 ].value,
                    nationality2[ 18 ].value,
                    nationality2[ 19 ].value,
                    nationality2[ 20 ].value
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
                    name: nationalityList[3],
                    type: 'bar',
                    data: [
                    nationality3[ 0 ].value,
                    nationality3[ 1 ].value,
                    nationality3[ 2 ].value,
                    nationality3[ 3 ].value,
                    nationality3[ 4 ].value,
                    nationality3[ 5 ].value,
                    nationality3[ 6 ].value,
                    nationality3[ 7 ].value,
                    nationality3[ 8 ].value,
                    nationality3[ 9 ].value,
                    nationality3[ 10 ].value,
                    nationality3[ 11 ].value,
                    nationality3[ 12 ].value,
                    nationality3[ 13 ].value,
                    nationality3[ 14 ].value,
                    nationality3[ 15 ].value,
                    nationality3[ 16 ].value,
                    nationality3[ 17 ].value,
                    nationality3[ 18 ].value,
                    nationality3[ 19 ].value,
                    nationality3[ 20 ].value
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

 nationality_bar.setOption(option);
        window.addEventListener("resize",function(){
            nationality_bar.resize();
        });
        nationality_bar.on('click', function (params) {
            console.log(params );          
        })
}



