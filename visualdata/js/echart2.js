// var myChart = echarts.init(document.getElementById('main2'));
// option = {
//     title: {
//         text: '世界人口总量',
//         subtext: '数据来自网络',
//         textStyle: {
//             color: "#fff",
//         }
//     },
//     tooltip: {
//         trigger: 'axis',
//         axisPointer: {
//             type: 'shadow'
//         }
//     },
//     legend: {
//         data: ['2011年', '2012年'],
//         textStyle: {
//             color: "#fff",
//         }
        
//     },
//     grid: {
//         left: '3%',
//         right: '10%',
//         bottom: '3%',
//         containLabel: true
//     },
//     xAxis: {
//         type: 'value',
//         boundaryGap: [0, 0.01],
//         axisLine: {
//             lineStyle: {
//                 color: "#fff",
//             }
//         }
//     },
//     yAxis: {
//         type: 'category',
//         data: ['巴西', '印尼', '美国', '印度', '中国', '世界人口(万)'],
//         axisLine: {
//             lineStyle: {
//                 color: "#fff",
//             }
//         }

//     },
//     series: [
//         {
//             name: '2011年',
//             type: 'bar',
//             data: [18203, 23489, 29034, 104970, 131744, 630230],
//             itemStyle: {
//                 //柱形图圆角，鼠标移上去效果
//                 emphasis: {
//                     barBorderRadius: [10, 10, 10, 10]
//                 },

//                 normal: {
//                     //柱形图圆角，初始化效果
//                     barBorderRadius: [10, 10, 10, 10]
//                 }
//             },
//         },
//         {
//             name: '2012年',
//             type: 'bar',
//             data: [19325, 23438, 31000, 121594, 134141, 681807],
//             itemStyle: {
//                 //柱形图圆角，鼠标移上去效果
//                 emphasis: {
//                     barBorderRadius: [10, 10, 10, 10]
//                 },
//                 normal: {
//                     //柱形图圆角，初始化效果
//                     barBorderRadius: [10, 10, 10, 10]
//                 }
//             },
//         }
//     ]
// };

// myChart.setOption(option);