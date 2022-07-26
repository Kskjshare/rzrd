        
    var active1=0,active2=0,active3=0,active4=0,active5=0,active6 = 0;
    new Ajax("gedatabbb").getJson(function (json){
    $.each(json,function(i,val){
        if(val.classify==1){
            active1++;
        }else if(val.classify==2){
            active2++;
        }else if(val.classify==3){
            active3++;
        }else if(val.classify==4){
            active4++;
        }else if(val.classify==5){
            active5++;
        }else if(val.classify==6){
            active6++;
        }
    })  
        console.log(active1, active2, active3, active4, active5, active6);
        var dataAxis = ['视察活动', '调研活动', '小组活动', '检查活动', '会议活动', '培训活动'];
        var data = [active1, active2, active3, active4, active5, active6];
        var yMax = 10;
        var dataShadow = [];
        for (var i = 0; i < data.length; i++) {
            dataShadow.push(yMax);
        }

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        // 指定图表的配置项和数据
        option = {
                title: {
                    text: '人大履职',
                    subtext: '代表视察活动'
                },
                xAxis: {
                    data: dataAxis,
                    axisLabel: {
                        inside: true,
                        textStyle: {
                            color: '#fff'
                        }
                    },
                    axisTick: {
                        show: false
                    },
                    axisLine: {
                        show: false
                    },
                    z: 10
                },
                yAxis: {
                    axisLine: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },
                    axisLabel: {
                        textStyle: {
                            color: '#999'
                        }
                    }
                },
                dataZoom: [
                    {
                        type: 'inside'
                    }
                ],
                series: [
                    { // For shadow
                        type: 'bar',
                        itemStyle: {
                            color: 'rgba(0,0,0,0.05)'
                        },
                        barGap: '-100%',
                        barCategoryGap: '40%',
                        data: dataShadow,
                        animation: false
                    },
                    {
                        type: 'bar',
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#83bff6'},
                                    {offset: 0.5, color: '#188df0'},
                                    {offset: 1, color: '#188df0'}
                                ]
                            )
                        },
                        emphasis: {
                            itemStyle: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [
                                        {offset: 0, color: '#2378f7'},
                                        {offset: 0.7, color: '#2378f7'},
                                        {offset: 1, color: '#83bff6'}
                                    ]
                                )
                            }
                        },
                        data: data
                    }
                ]
            };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        window.addEventListener("resize", function () {
            myChart.resize();
        });
        myChart.on('click', function (params) { 
            //获得一个params对象；
            console.log(params );
            if(params.value){
                // alert("单击了"+params.name+"柱状图");
            }else{
                // alert("单击了"+params.name+"x轴标签");
            }
        })
    });
        