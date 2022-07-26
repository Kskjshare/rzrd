var myChart = echarts.init(document.getElementById('main3'));
chart.option = {
    tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: {c} ({d}%)'
    },
    legend: {
        orient: 'vertical',
        left: 10,
        data: ['男性', '女性']
    },
    series: [
        {
            name: '访问来源',
            type: 'pie',
            radius: ['50%', '70%'],
            avoidLabelOverlap: false,
            label: {
                show: false,
                position: 'center'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '30',
                    fontWeight: 'bold'
                }
            },
            labelLine: {
                show: false
            },
            data: [
                {value: 135, name: '男性'},
                {value: 310, name: '女性'}
            ]
        }
    ]
};


myChart.setOption(option);
// myChart.on('click', function (params) { 
//     //获得一个params对象；
//     console.log(params );
//     // if(params.value){
//     //     // alert("单击了"+params.name+"柱状图");
//     // }else{
//     //     // alert("单击了"+params.name+"x轴标签");
//     // }
// })
chart.on('mouseover', {seriesName: '访问来源'}, function () {
    // series name 为 'uuu' 的系列中的图形元素被 'mouseover' 时，此方法被回调。
    console.log("成");
});