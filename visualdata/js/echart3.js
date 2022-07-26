
// var myChart = echarts.init(document.getElementById('main3'));
// option = {
//     title: {
//         text: '某站点用户访问来源',
//         subtext: '纯属虚构',
//         left: 'left',
//         textStyle:{
//             color:"#fff"
//         }
//     },
//     tooltip: {
//         trigger: 'item',
//         formatter: '{a} <br/>{b} : {c} ({d}%)'
//     },
//     legend: {
//         orient: 'vertical',
//         right: '30',
//         data: ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎'],
//         textStyle:{
//             color:"#fff"
//         }
//     },
//     series: [
//         {
//             name: '访问来源',
//             type: 'pie',
//             radius:  ['50%', '70%'],
//             center: ['35%', '60%'],
//             data: [
//                 {value: 335, name: '直接访问'},
//                 {value: 310, name: '邮件营销'},
//                 {value: 234, name: '联盟广告'},
//                 {value: 135, name: '视频广告'},
//                 {value: 1548, name: '搜索引擎'}
//             ],
//             emphasis: {
//                 itemStyle: {
//                     shadowBlur: 10,
//                     shadowOffsetX: 0,
//                     shadowColor: 'rgba(0, 0, 0, 0.5)'
//                 }
//             }
//         }
//     ]
// };
// myChart.setOption(option);
// myChart.on('click', function (params) { 
//     //获得一个params对象；
//     console.log(params );
//     // if(params.value){
//     //     // alert("单击了"+params.name+"柱状图");
//     // }else{
//     //     // alert("单击了"+params.name+"x轴标签");
//     // }
// })
