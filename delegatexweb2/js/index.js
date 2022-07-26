




function compare(p){ //这是比较函数
    return function(m,n){
        var a = m[p];
        var b = n[p];
        return b - a; //升序
    }
}

function getUrlInfor(url) {
    let startNum = url.indexOf('?')
    if (startNum === -1) {
        console.log('getUrlInfor无法链接获取信息');
        return null ;
    }
    let dataStr = url.substr(startNum + 1)
    let arrs = dataStr.split('&')
    let obj = {}

    arrs.map(item => {
        obj[item.split('=')[0]] = item.split('=')[1]
    })
    return obj
}
// location.reload();
$(document).ready(function () {
    //第一次进入页面刷新一次，仅一次
    //location.href.indexOf("#")获取当前页面地址并在其中查找"#"首次出现位置，找不到就是-1
    if(location.href.indexOf("#")==-1){
        //在当前页面地址加入"#"，使下次不再进入此判断
        location.href=location.href+"#";
        location.reload();
    }
})

var mission = "1027";
var substationid = "100";
$(function () {
    
    console.log("____entry of station href is : ", window.location.href ) ;
    substationid  = window.location.href.split("=")[1];
    mission =  window.location.href.split("mission=")[1];
    
    var mObj = getUrlInfor( window.location.href );
    if ( mObj != null ) {
        mission = mObj.mission;
        substationid = mObj.myid ;
    }
    else {
        substationid  = window.location.href.split("=")[1];
        mission =  window.location.href.split("mission=")[1];   
    }
    
    if ( mission != null ) {
        mission = mission.replace("#","");
    }   
    if ( substationid == null ) {
         substationid  = window.location.href.split("=")[1];
    }   
   
   if ( substationid != null ) {
    substationid = substationid.replace("#","") ;
   }
    Gsubstationid = substationid ;

    console.log("____entry of station substationid is : " + substationid + " mission is " + mission );
      

    //获取代表团名
    RssApi.Table.List("station_sub_id").condition( { "myid": substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
            console.log("____ home_subtitle is : " +  data[i].name );
           $("#home_subtitle").html( data[i].name )
        }
    })
    //获取工作动态
    //RssApi.Table.List("stationcontent").condition({ "classifyid": 1 ,"state":2, "newsid":1}).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
    RssApi.Table.List("stationcontent").condition({ "classify": 1 ,"state":2  ,"substationid":substationid }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        console.log("____datais : " + data );

        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#workdynamicsNews").append(liStr); 
    });
    //通知公告
    RssApi.Table.List("stationcontent").condition({ "classify": 3 ,"state":2   ,"substationid":substationid }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#noticeNews").append(liStr); 
    }); 
    
    //代表履职
    RssApi.Table.List("stationcontent").condition({ "classify": 2 ,"state":2   ,"substationid":substationid }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#dblvNews").append(liStr); 
    }); 
 
    //代表风采
    RssApi.Table.List("stationcontent").condition({ "classify": 4 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#dbfcNews").append(liStr); 
    }); 
    
    
    //代表培训
    RssApi.Table.List("stationcontent").condition({ "classify": 8 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#investigation").append(liStr); 
    }); 
    
    //代表述职
    RssApi.Table.List("stationcontent").condition({ "classify": 11 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#proposal").append(liStr); 
    }); 
     //矛盾调节
    RssApi.Table.List("stationcontent").condition({ "classify": 9 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#importantMeeting").append(liStr); 
    }); 
    
    //民生实事项目
    RssApi.Table.List("stationcontent").condition({ "classify": 10 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#legislationWork").append(liStr); 
    }); 
     //活动预告
    RssApi.Table.List("stationcontent").condition({ "classify": 12 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {      
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#townshipCongress").append(liStr); 
    }); 
    
       //好人好事
    RssApi.Table.List("stationcontent").condition({ "classify": 13 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 1000 }).getJson(function (data) {  
        data.sort(compare("shijian"));
        var dataLength = data.length;
        if (dataLength > 8) {
            dataLength = 8;
        }
        var liStr = "";
        for (var i = 0; i <  dataLength; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot' style='top:-9px;'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#journal").append(liStr); 
    }); 
    
    
    //法律法规
    RssApi.Table.List("legislative_lawandregulation").condition({ }).keyvalue({ "pagesize": 100 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.shijian < b.shijian ? 1 : -1;} ); //按时间排序

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='lawnewsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#lawknowledge").append(liStr);
    })
    
    //代表专业知识
    RssApi.Table.List("stationcontent").condition({ "classify": 6 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 100 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.shijian < b.shijian ? 1 : -1;} ); //按时间排序

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='knowledgenewsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#delegateknowledge").append(liStr);
    })
    
    
     //资料管理
    RssApi.Table.List("stationcontent").condition({ "classify": 7 ,"state":2  ,"substationid":substationid  }).keyvalue({ "pagesize": 100 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.shijian < b.shijian ? 1 : -1;} ); //按时间排序

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='knowledgenewsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        $("#representativeWork4").append(liStr);
    })
    
    
     // 资料管理
//    $("#representativeWork4").click(function () {
//        var classify = $(this).attr("classify");
//
//        location.href = "document.htm?classify=7" +  "&substationid=" + substationid ;
////        console.log("News.htm?classifyid=" + classifyid + "")
//
//    })

     // 好人好事
    $(".charity").click(function () {
        var classifyid = $(this).attr("classifyid");

        location.href = "goodthing.htm?classify=13" +  "&substationid=" + substationid ;
//        console.log("News.htm?classifyid=" + classifyid + "")

    })

    // 活动预告
       $(".forenotice").click(function () {
           var classifyid = $(this).attr("classifyid");
           location.href = "forenotice.htm?classify=12"  +  "&substationid=" + substationid ;
   //        console.log("News.htm?classifyid=" + classifyid + "")

       })

    // 更多
    $(".more").click(function () {
        var classifyid = $(this).attr("classifyid");

        location.href = "News.htm?classifyid=" + classifyid + "";
//        console.log("News.htm?classifyid=" + classifyid + "")

    })


   // 滚动图片新闻
   //RssApi.Table.List("imagin_news").keyvalue({ "pagesize": 6 ,"state":1}).getJson(function (data) {
   RssApi.Table.List("imagin_news").keyvalue({"pagesize": 66 ,"category":2 }).getJson(function (_data) {
         _data.sort(compare("shijian"));

       console.log("滚动图片新闻data.length:" + _data.length);   
       var data = [];
        for (var i = 0; i < _data.length; i++) {
            if (eval(_data[i].category) == 2 ) {
                 data.push( _data[i] );   
            }
             
        }
			
  
       if (data) {
            data=  data.sort(function(a, b) { return a.shijian < b.shijian ? 1 : -1;} ); //增加时间排序

            var ul = "<ul class='slider' >";
           for (var i = 0; i < data.length; i++) {
                console.log("滚动图片新闻data.title:" + data[i].id);   
               var imgcont = data[i];
               ul = ul + "<li onclick='clickLi("+imgcont.id+")'><img src='http://117.158.113.36:80/upfile/"+imgcont.ico+"'/></li>";
           }
           ul = ul + "</ul>";
           $(".v_content_list").append(ul);

           var titleul = "<ul class='titleul'>";
           if (data.length > 0) {

                for (var i = 0; i < data.length; i++) {
                    var titlecont = data[i];
                    titleul = titleul + "<li><span id='sliderSpan'>" + titlecont.title + "</span></li>";
                }

           };


           var num = "<ul class='num' >";
           for (var i = 0; i < data.length; i++) {
                if (i == 0) {
                    num = num + "<li class='on'>"+(i+1)+"</li>";
                } else {
                    num = num + "<li>"+(i+1)+"</li>";
                }
           }
           num = num + "</ul>";
           $("#sliderDiv").append(titleul);
           $("#sliderDiv").append(num);
        
           
       }
       
        var len = data.length;
        var totalWidth = 564 * len;
         $(".v_content_list").width(totalWidth + "px");
         var ulWidth = 16 * len + 10 * (len - 1);
         $(".num").width(ulWidth + "px");
         $(".num").css("marginLeft", (564 - ulWidth) + "px");
         var index = 0;
         var adTimer;
         $(".num li").mouseover(function(){
            index  =   $(".num li").index(this);
            showImg(data[index].title, index);
         }).eq(0).mouseover();  
         //滑入 停止动画，滑出开始动画.
         $('.v_content_list').hover(function(){
                 clearInterval(adTimer);
             },function(){
                 adTimer = setInterval(function(){
                    showImg(data[index].title, index)
                    index++;
                    if(index==len){index=0;}
                  } , 7000);
         }).trigger("mouseleave");

   })
   


    $("#nav li:has(ul)").mouseover(function(){
            $(this).children("ul").stop(true,true).slideDown(400);
    });
    $("#nav li:has(ul)").mouseleave(function(){
            // $(this).stop(true,true).slideUp("fast");
        $(this).children("ul").stop(true,true).slideUp('fast');
    });

    $(".navLiH3").mouseover(function(){
        $(this).addClass("orangeColor");
    });

    $(".navLiH3").mouseleave(function(){
        $(this).removeClass("orangeColor");
    });



    let obj = {
        'nw1':[
            {id:'zhongyaohuiyi',value:'importantMeeting'},
            {id:'legislation',value:'legislationWork'},
            {id:'yianjianyi',value:'proposal'}
        ],
        'nw2':[
            {id:'jiandugongzuo',value:'lawknowledge'},
            {id:'election',value:'delegateknowledge'},
            {id:'daibiaogongzuo1',value:'representativeWork4'},         
            {id:'diaochayanjiu',value:'investigation'}
        ],
        'nw3':[
            {id:'daibiaogongzuo2',value:'representativeWork'},
            {id:'huiyijueding',value:'meetingDecision'}
        ],
        'nw4' :[
            {id:'baogao',value:'reporting'},
            {id:'yusuangongkai',value:'budgetPublic'},
            {id:'yusuantiaozheng',value:'budgetAdjustment'},
            {id:'shichadiaoyan',value:'inspectionInvestigation'}
        ],
        'nw5':[
            {id:'workdynamics',value:'workdynamicsNews'},
            {id:'noticeboard',value:'noticeNews'},
            {id:'daibiaolvzhi',value:'dblvNews'},
            {id:'daibiaofengcai',value:'dbfcNews'},

            
        ],
    }

     $(".lmTitle ul li a").mouseover((event)=>{
            event.stopPropagation();
            let id  = event.target.id;
            $("#" + id).parents("li").addClass("on").siblings().removeClass("on");
            if (id == 'workdynamics') { //工作动态
                $("#" + id).addClass("renDaBottom");
                $("#noticeboard").removeClass("renDaBottom");
                
                $("#daibiaolvzhi").removeClass("renDaBottom");
                $("#daibiaofengcai").removeClass("renDaBottom");

            } else if (id == 'noticeboard') { //通知公告
                $("#" + id).addClass("renDaBottom");
                $("#workdynamics").removeClass("renDaBottom");

                $("#daibiaolvzhi").removeClass("renDaBottom");
                $("#daibiaofengcai").removeClass("renDaBottom");
                
            }
            else if (id == 'daibiaolvzhi') { //代表履职
                $("#" + id).addClass("renDaBottom");
                $("#workdynamics").removeClass("renDaBottom");
                
                $("#noticeboard").removeClass("renDaBottom");
                $("#daibiaofengcai").removeClass("renDaBottom");
            }
            else if (id == 'daibiaofengcai') { //代表风采
                $("#" + id).addClass("renDaBottom");
                $("#workdynamics").removeClass("renDaBottom");
                
                $("#noticeboard").removeClass("renDaBottom");
                $("#daibiaolvzhi").removeClass("renDaBottom");
            }
            else {
                

               $("#" + id).addClass("highlightbar").parents("li").siblings().find("a").removeClass("highlightbar");
            }
            let nw = $('#'+id).parents('.newsWrap').attr('class').replace('newsWrap','').replace('tab_box','').replace(' ','').replace(' ','');
            if(obj[nw]&& obj[nw].length){
                obj[nw].forEach(ele => {
                    if(ele.id === id){
                        $('#' + ele.value).parent().addClass("left");
                        $('#' + ele.value).parent().removeClass("right");
                        $('#' + ele.value).parent().show();
                    }else{
                        $('#' + ele.value).parent().hide();
                    }
                });
            }
           
           
        });

        //点击工作动态
        $("#workdynamics").click(function(){
            location.href = "NewsTop.htm?classify=1&state=2&substationid="+substationid;
        });
        //点击通知公告
        $("#noticeboard").click(function(){
//            location.href = "NewsCurrent.htm?classify=1&state=2";
            location.href = "notice.htm?classify=3&state=2&substationid=" + substationid ;
        });
        //点击代表履职
        $("#daibiaolvzhi").click(function(){
            location.href = "lvzhi.htm?classify=2&state=2&substationid=" + substationid ;
        });
        //点击代表风采
        $("#daibiaofengcai").click(function(){
            location.href = "fengcai.htm?classify=4&state=2&substationid=" + substationid ;
        });
        
        $("#zhongyaohuiyi").click(function(){ //矛盾纠纷调处
            location.href = "dispute.htm?classify=9&substationid=" + substationid ;
        });
        $("#legislation").click(function(){ //民生实事项目
            location.href = "livelihood.htm?classify=10&substationid=" + substationid ;
        });
        $("#yianjianyi").click(function(){ //代表述职
            location.href = "report.htm?classify=11&substationid=" + substationid ;
        });
        $("#townCongress").click(function(){
            location.href = "News.htm?classify=5&substationid=" + substationid ;
        });
        $("#zuixingonggao").click(function(){
            location.href = "News.htm?classify=8&substationid=" + substationid ;
        });
       
        $("#daibiaogongzuo").click(function(){
            location.href = "News.htm?classify=7&substationid=" + substationid ;
        });
        $("#huiyijueding").click(function(){
            location.href = "News.htm?classifyid=9";
        });
        $("#baogao").click(function(){
            location.href = "News.htm?classifyid=14&publiclassifyid=1";
        });
        $("#yusuangongkai").click(function(){
            location.href = "News.htm?classify=14&publiclassifyid=2";
        });
        $("#yusuantiaozheng").click(function(){
            location.href = "News.htm?classify=14&publiclassifyid=3";
        });
        $("#shichadiaoyan").click(function(){
            location.href = "News.htm?classify=14&publiclassifyid=4";
        });
        $("#newsTongzhi").parent().click(function(){
            location.href = "News.htm?classify=8";
        });
        
        $("#jiandugongzuo").click(function(){ //法律法规
            location.href = "law.htm?classify=5&substationid=" + substationid ;
        });
        $("#election").click(function(){ //专业知识
            location.href = "knowledge.htm?classify=6&substationid=" + substationid ;
        });
        
        $("#daibiaogongzuo1").click(function(){ //资料管理
            location.href = "document.htm?classify=7&substationid=" + substationid ;
        });
        $("#diaochayanjiu").click(function(){ //代表培训
            location.href = "trainning.htm?classify=8&substationid=" + substationid ;
        });
        

        $("#firstPage").click(function(){ //点击首页
//            location.href = "contactstation.htm?substationid=" + substationid;
        });
        $("#contactstation_contactstation").click(function(){ //点击联络站概况
            location.href = "contactstationDetail.htm?substationid="+ substationid ;
        });
        
        $("#contactstation_organization").click(function(){//组织机构
            location.href = "organization.htm?substationid="+ substationid;
        });
        $("#contactstation_workdynamics").click(function(){//工作动态
            location.href = "workdynamics.htm?classify=1&state=2&substationid=" + substationid;           
        });
        $("#contactstation_delegate").click(function(){//人大代表
           location.href = "representative.htm?substationid=" + substationid + "&mission="+mission;                  
        });
        $("#contactstation_notice").click(function(){//通知公告
           location.href = "notice.htm?classify=3&state=2&substationid=" + substationid;              
        });
        $("#contactstation_allstation").click(function(){//联络总站
           location.href = "/delegatexweb/bmweb.jsp";      
        })
        
        $("#contactstation_institution").click(function(){//工作制度
           location.href = "institution.htm?substationid=" + substationid ;
        })
        
        $("#submit_opinion").click(function(){//提交意见
           location.href = "/delegatexweb/infopage/suggestsubmit.jsp?myid=" + mission ;
        })
        
       
        
        
        

        $("#huiyibaodao").click(function(){
            location.href = "huiyibaodao.htm";
        });
        $("#zhuantijijin").click(function(){
            location.href = "zhuantijijin.htm";
        });
        $("#jiguanjianshe").click(function(){
            location.href = "News.htm?classifyid=11";
        });

         //首页二维码
        $('.right-nav li').hover(function () {
            $(this).find('.show-ewm').animate({ 'left': '-140px', 'opacity': '1' }).show();
        }, function () {
            $(this).find('.show-ewm').animate({ 'left': '-50px', 'opacity': '0' }).hide();
        });

        $(document).keydown(function(event){
            if(event.keyCode == 13){ 
                var searchInput = $("#searchInput").val();
                location.href = "searchResult.htm?searchInput=" + encodeURIComponent(searchInput);
            }
        });

        $("#searchBtn").click(function(){
            var searchInput = $("#searchInput").val();
            location.href = "searchResult.htm?searchInput=" + encodeURIComponent(searchInput);
        })

})

function clickImg(rssid) {
    location.href = "Pro_show.htm?id=" + rssid + "";
}

function clickLi(rssid) {
//    location.href = "Slider_show.htm?id=" + rssid + "";
    location.href = "News_show.htm?id=" + rssid + "&channel=99" + "&substationid="+substationid;

}

function newsShow(rssid) {
    location.href = "News_show.htm?id=" + rssid  + "&substationid=" + substationid;
}
function lawnewsShow(rssid) {
    //1 工作动态 2 通知公告 3代表履职 4代表风采 5法律法规 6专业知识 7资料管理 8 代表培训
    location.href = "News_show.htm?id=" + rssid + "&channel=5"+ "&substationid=" + substationid;
}
function knowledgenewsShow(rssid) {
    //1 工作动态 2 通知公告 3代表履职 4代表风采 5法律法规 6专业知识 7资料管理 8 代表培训
//    location.href = "News_show.htm?id=" + rssid + "&channel=6";
    location.href = "News_show.htm?id=" + rssid + "&substationid="+ substationid;

}

function enterPage(rssid) {
    location.href = "zhuren_show.htm?id=" + rssid + "";
}

// 通过控制left ，来显示不同的幻灯片
function showImg(spanTitle, index){
        $("#sliderSpan").html(spanTitle);
        var adWidth = $("#sliderDiv").width();
        // $(".slider").stop(true,false).animate({left : -adWidth*index},1000);
        // $(".num li").removeClass("on")
        //     .eq(index).addClass("on");
        $(".v_content_list").animate({left : -adWidth*index},1000);
        $(".titleul li").hide().eq(index).show();
        $(".num li").removeClass("on")
            .eq(index).addClass("on");
}
