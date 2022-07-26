//
function getUrlInfor(url) {
    let startNum = url.indexOf('?')
    if (startNum === -1) {
        console.log('getUrlInfor无法链接获取信息');
        return
    }
    let dataStr = url.substr(startNum + 1)
    let arrs = dataStr.split('&')
    let obj = {}

    arrs.map(item => {
        obj[item.split('=')[0]] = item.split('=')[1]
    })
    return obj
}

var newsshow_substationid = "100";
$(function () {
    console.log(window.location.href)
    var rssid = window.location.href.split("=")[1];
    var channel =  window.location.href.split("channel=")[1];
    var substationid =  window.location.href.split("substationid=")[1];

    console.log(rssid)
    var obj = getUrlInfor( window.location.href );
    channel = obj.channel ;
    rssid = obj.id ;
    
    console.log(" ___________ substationid:" , substationid )

    newsshow_substationid = substationid ;
    
    var mapData;
    var tablename ="stationcontent";
    //1 工作动态 2 通知公告 3代表履职 4代表风采 5法律法规 6专业知识 7资料管理 8 代表培训
    if ( channel == 5 ) {
        tablename = "legislative_lawandregulation";
    }
    else if ( channel == 6 ){
       tablename = "delegate_knowledge" ;
    }
    else if ( channel == 99 ) {
        //滚动新闻
         tablename = "imagin_news" ;
    }
    else if ( channel == 98 ) {
        //履职
         tablename = "activities" ;
    }
    console.log(" ___________ tablename:" , tablename )
    RssApi.Table.Details( tablename ).condition({ "id": rssid }).getJson(function (data) {
        console.log(" ___________ data:" , data )
        
        if ( channel == 98 ) {
             for (var i = 0; i < data.length; i++) {
                 if ( data[i].enclosure != null ) {
                     data[i].enclosure = "http://www.rzsrd.gov.cn:9002/upfile/"+data[i].enclosure ;
                 }
             }
        }

        let shijian =  new Date(data.shijian * 1000).toString("yyyy-MM-dd");
        var origin = data.origin ;
        if ( origin == null || origin == 'undefined ') {
            origin = '未知'
        }
        let str = '时间：' + shijian +'　　来源：'+ origin;
        $(".n04").html(str);
        mapData = data;
        $(".macont").mapview( data );

    })
    
    
    //获取代表团名
    var substationid = obj.substationid ;
    if ( substationid != null ) {
        substationid = substationid.replace("#","");
    }

    RssApi.Table.List("station_sub_id").condition( { "myid": newsshow_substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
            console.log("____ home_subtitle is : " +  data[i].name );
           $("#home_subtitle").html( data[i].name )
        }
    })

    $("#n003").click(function(){
        var href = mapData.enclosure;
        console.log(href);
        if (href != null && href != '') {
            window.open("http://www.rzsrd.gov.cn:9002/upfile/" + href);
        }
    })
})
$(function () {

            $("#nav li:has(ul)").mouseover(function(){
                    $(this).children("ul").stop(true,true).slideDown(400);
            });
            $("#nav li:has(ul)").mouseleave(function(){
                    // $(this).stop(true,true).slideUp("fast");
                $(this).children("ul").stop(true,true).slideUp('fast');
            });
    
          
            
            
$("#firstPage").click(function(){ //点击首页
    location.href = "contactstation.htm?substationid=" + newsshow_substationid ;
});
$("#shownews_contactStation").click(function(){ //点击联络站概况
    location.href = "contactstationDetail.htm?substationid=" + newsshow_substationid ;
});

$("#shownews_organization").click(function(){//组织机构
    location.href = "organization.htm?substationid=" + newsshow_substationid ;
});
$("#shownews_workdynamics").click(function(){//工作动态
    location.href = "workdynamics.htm?classify=1&state=2&substationid=" + newsshow_substationid ;         
});
$("#shownews_delegate").click(function(){//人大代表
   location.href = "representative.htm?substationid=" + newsshow_substationid ;           
});
$("#shownews_notice").click(function(){//通知公告
   location.href = "notice.htm?classify=3&state=2&substationid=" + newsshow_substationid ;           
});
$("#shownews_allstation").click(function(){//联络总站
   location.href = "/delegatexweb/bmweb.jsp";      
})
$("#shownews_institution").click(function(){//工作制度
    location.href = "institution.htm?substationid=" + newsshow_substationid ;          
});


  
$("#contactstationDetail_institution").click(function(){//工作制度
    location.href = "institution.htm";           
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

        });