
    // echart1() 代表团建议
    // echart2() 行业建议
    // echart3() 代表学历
    // echart4() 代表党派
    // footerOne();  代表职业
    // footerTwo();  建议办理
    // footerTree(); 性别分析
    // footerFlour();履职活动
    function echart1(value,value2_parameter) {
    
    
    
    
    
    }
    
     function echart3( datasss ) {


     
    var datasss1 =[ 
            {name:"未知",value:0},
            {name:"佛教",value:0},
            {name:"基督教",value:0},
            {name:"天主教",value:0},
            {name:"伊斯兰教",value:0},
           

 
            ];
    console.log("________________ datasss1=",datasss1)
//    var datasss = [];
//    var cnt = 0 ;
//    for( var i = 0 ; i < datasss1.length ;i ++ ) {
//   
//        datasss.push( datasss1[i]);
//        cnt ++ ;
//        if ( cnt >= 3 )
//            break;
//    }
    

        var myChart3 = echarts.init(document.getElementById('main'));
        option = {
            title: {
                text: '宗教统计情况',
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
                    color: "#fff"
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            color: [
                'rgb(255,219,91)',
                'rgb(159,230,180)',
                'rgb(255,114,147)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                {name:"未知",value:0},
                {name:"佛教",value:0},
                {name:"基督教",value:0},
                {name:"天主教",value:0},
                {name:"伊斯兰教",value:0},
                ],
                textStyle: {
                    color: "#fff",
                }
            },
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: [
                        '15%', '50%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '62%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                color: "#fff",
                                fontSize: 12,
                                // lineHeight: 33
                                },
                            }
                    },
                    data: datasss,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart3.setOption(option);
        window.addEventListener("resize",function(){
            myChart3.resize();
        });
        myChart3.on('click', function (params) {
            //获得一个params对象；
            console.log(params );
            // if(params.value){
            //     // alert("单击了"+params.name+"柱状图");
            // }else{
            //     // alert("单击了"+params.name+"x轴标签");
            // }
        })

    }
    
    
    function echart2() {
      
   
    }
    function echart3( datasss ) {


     
    var datasss1 =[ 
            {name:"未知",value:0},
            {name:"满族",value:500},
            {name:"壮族",value:0},
            {name:"汉族",value:0},
            {name:"回族",value:0},
            {name:"苗族",value:0},
            {name:"藏族",value:0},       
            {name:"维吾尔族",value:0},
            {name:"土家族",value:0},
            {name:"彝族",value:0},
            {name:"蒙古族",value:0},
            {name:"布依族",value:0},
            {name:"侗族",value:0},  
              
            {name:"瑶族",value:0},
            {name:"朝鲜族",value:0},
            {name:"白族",value:0},
            {name:"哈尼族",value:0},
            {name:"哈萨克族",value:0},
            {name:"黎族",value:0},       
            {name:"傣族",value:0},
            {name:"畲族",value:0},
            {name:"傈僳族",value:0},
            {name:"东乡族",value:0},
            {name:"高山族",value:0},
            {name:"拉祜族",value:0},     
 
            {name:"水族",value:0},
            {name:"佤族",value:0},
            {name:"纳西族",value:0},
            {name:"羌族",value:0},
            {name:"土族",value:0},
            {name:"仫佬族",value:0},       
            {name:"锡伯族",value:0},
            {name:"达斡尔族",value:0},
            {name:"景颇族",value:0},
            {name:"瑶族",value:0},
            {name:"撒拉族",value:0},
            {name:"布朗族",value:0},  
     
            {name:"塔吉克族",value:0},
            {name:"阿昌族",value:0},
            {name:"普米族",value:0},
            {name:"鄂温克族",value:0},
            {name:"怒族",value:0},
            {name:"京族",value:0},       
            {name:"基诺族",value:0},
            {name:"德昂族",value:0},
            {name:"保安族",value:0},
            {name:"俄罗斯族",value:0},
            {name:"裕固族",value:0},
            {name:"乌孜别克族",value:0},
            
             {name:"乌孜别克族",value:0},
            {name:"门巴族",value:0},
            {name:"鄂伦春族",value:0},
            {name:"独龙族",value:0},
            {name:"赫哲族",value:0},
            {name:"毛南族",value:0},       
          
            
            ];
    console.log("________________ datasss1=",datasss1)
//    var datasss = [];
//    var cnt = 0 ;
//    for( var i = 0 ; i < datasss1.length ;i ++ ) {
//   
//        datasss.push( datasss1[i]);
//        cnt ++ ;
//        if ( cnt >= 3 )
//            break;
//    }
    

        var myChart3 = echarts.init(document.getElementById('main3'));
        option = {
            title: {
                text: '民族统计情况',
                // subtext: '纯属虚构',
                left: 'left',
                textStyle: {
                    color: "#fff"
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            color: [
                'rgb(255,219,91)',
                'rgb(159,230,180)',
                'rgb(255,114,147)',
            ],
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                  	'未知',
            '满族',
            '壮族',
            '汉族',
            '回族',
            '苗族',
            '藏族',       
            '维吾尔族',
            '土家族',
            '彝族',
            '蒙古族',
            '布依族',
            '侗族',  
              
            '瑶族',
            '朝鲜族',
            '白族',
            '哈尼族',
            '哈萨克族',
            '黎族',       
            '傣族',
            '畲族',
            '傈僳族',
            '东乡族',
            '高山族',
            '拉祜族',     
 
            '水族',
            '佤族',
            '纳西族',
            '羌族',
            '土族',
            '仫佬族',       
            '锡伯族',
            '达斡尔族',
            '景颇族',
            '瑶族',
            '撒拉族',
            '布朗族',  
     
            '塔吉克族',
            '阿昌族',
            '普米族',
            '鄂温克族',
            '怒族',
            '京族',       
            '基诺族',
            '德昂族',
            '保安族',
            '俄罗斯族',
            '裕固族',
            '乌孜别克族',
            
             '乌孜别克族',
            '门巴族',
            '鄂伦春族',
            '独龙族',
            '赫哲族',
            '毛南族',     
                ],
                textStyle: {
                    color: "#fff",
                }
            },
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: [
                        '15%', '50%'
                    ],
                    labelLine:{
                        normal:{
                            length:30,  //视觉引导线长度
                            length2:70
                        }
                    },
                    center: [
                        '45%', '62%'
                    ],
                    label:{   //文本样式处理
                          formatter: "{d}%,{b|{b}}\n\n",
                            borderWidth: 1,
                            borderRadius: 4,
                            padding: [0, -70],
                            // borderColor:'#fff',  // label border
                            rich: {
                                b: {
                                color: "#fff",
                                fontSize: 12,
                                // lineHeight: 33
                                },
                            }
                    },
                    data: datasss,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart3.setOption(option);
        window.addEventListener("resize",function(){
            myChart3.resize();
        });
        myChart3.on('click', function (params) {
            //获得一个params对象；
            console.log(params );
            // if(params.value){
            //     // alert("单击了"+params.name+"柱状图");
            // }else{
            //     // alert("单击了"+params.name+"x轴标签");
            // }
        })

    }
    function echart4(dangpai) {
        var myChart4 = echarts.init(document.getElementById('main4'));

        option = {
            title: {
                text: '代表党派构成分析',
                left: 'left',
                textStyle: {
                    color: "#fff"
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                right: '10',
                top:"10",
                data: [
                    '群众',
                    '共青团',
                    '无党派',
                    '民主党',
                    '中国共产党'
                ],
                textStyle: {
                    color: "#fff"
                }
            },
            color: [
                'rgba(255,219,91,.8)',
                'rgba(159,230,180,.8)',
                'rgba(255,114,147,.8)',
                'rgba(130,120,223,.8)',
                'rgba(47,197,223,.8)',
                'rgba(255,159,120,.8)',
                'rgb(231,188,242)',
                'rgb(71,96,255)',
            ],
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: [
                        '50%', '60%'
                    ],
                    center: [
                        '35%', '55%'
                    ],
                    data:dangpai,
                     
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart4.setOption(option);
        window.addEventListener("resize",function(){
            myChart4.resize();
        });
    }
    function footerOne() {
    
    }
    function footerTwo(obj) {
     
    }
    function footerTree(number,number2,maleFormate,femaleFormate) {
    
    }
    function footerFlour(name,value) {
        return;
      
       
    }

    function footerTwoooo() {
      
    }

