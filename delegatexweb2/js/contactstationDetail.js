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
var contactstationDetail_substationid = "100" ;
$(function () {
   var substationid = window.location.href.split("substationid=")[1];
   
    var obj = getUrlInfor(window.location.href);
    var classify = obj.classify ;
    var state = 2 ;
    substationid = obj.substationid ;
    if ( substationid != null ) {
        substationid = substationid.replace("#","") ;
    }
    contactstationDetail_substationid = substationid ;
    console.log("____ classify : " + classify );
    console.log("____ substationid is : " +  substationid);
   
   RssApi.Table.List("stationcontent").condition({ "classify":14 ,"substationid":substationid }).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        console.log(data);
        $("#introduceDetail").html(data[0].matter)
//        for (var i = 0; i < data.length; i++) {
//            var imgContent = data[i];
//            var imgHtml = "<li onclick='showLi("+imgContent.id+")'>";
//            imgHtml = imgHtml + "<img src='http://117.158.113.36:80/upfile/"+imgContent.ico+"' alt=''>";
//            imgHtml = imgHtml + "<p><strong>"+imgContent.title+"</strong></p>";
//            var imgHtml = imgHtml + "</li>";
//            $(".contentListul").append(imgHtml);
//        };
    })
    
    
    //获取代表团名
    RssApi.Table.List("station_sub_id").condition( { "myid": substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
           $("#home_subtitle").html( data[i].name )
        }
    })
    
})

$("#firstPage").click(function(){ //点击首页
    location.href = "contactstation.htm?substationid=" + contactstationDetail_substationid ;   
});
$("#contactstationDetail_contactStation").click(function(){ //点击联络站概况
    location.href = "contactstationDetail.htm?substationid=" + contactstationDetail_substationid ;   
});

$("#contactstationDetail_organization").click(function(){//组织机构
    location.href = "organization.htm?substationid=" + contactstationDetail_substationid ; 
});
$("#contactstationDetail_workdynamics").click(function(){//工作动态
    location.href = "workdynamics.htm?classify=1&state=2&substationid=" + contactstationDetail_substationid ;           
});
$("#contactstationDetail_delegate").click(function(){//人大代表
   location.href = "representative.htm?substationid=" + contactstationDetail_substationid ;            
});
$("#contactstationDetail_notice").click(function(){//通知公告
   location.href = "notice.htm?classify=3&state=2&substationid=" + contactstationDetail_substationid ;            
});
$("#contactstationDetail_station").click(function(){//联络总站
   location.href = "/delegatexweb/bmweb.jsp";      
})
$("#contactstationDetail_institution").click(function(){//工作制度
   location.href = "institution.htm?substationid=" + contactstationDetail_substationid ;       
})        