$(function () {
   RssApi.Table.List("ztimges").condition({"collectiontype":2,"type":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        console.log(data);
        for (var i = 0; i < data.length; i++) {
            var imgContent = data[i];
            var imgHtml = "<li onclick='showLi("+imgContent.id+")'>";
            imgHtml = imgHtml + "<img src='http://117.158.113.36:80/upfile/"+imgContent.ico+"' alt=''>";
            imgHtml = imgHtml + "<p><strong>"+imgContent.title+"</strong></p>";
            var imgHtml = imgHtml + "</li>";
            $(".contentListul").append(imgHtml);
        };
    })
    
    
    //获取代表团名
    RssApi.Table.List("station_sub_id").condition( { "myid": substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
            console.log("____ home_subtitle is : " +  data[i].name );
           $("#home_subtitle").html( data[i].name )
        }
    })
 
     $("#topTitle").click(function(){
        location.href = "Dangshi_show.htm?id=" + topTitleRssid + "";
     })

     $("#topImg").click(function(){
        location.href = "Dangshi_show.htm?id=" + topImgRssid + "";
     })
})

function showLi(rssid) {
    location.href = "helpCountrySide_show.htm?id=" + rssid + "";
}

$("#firstPage").click(function(){ //点击首页
    location.href = "contactstation.htm";
});
$("#organization_contactStation").click(function(){ //点击联络站概况
    location.href = "contactstationDetail.htm";
});

$("#contactstation_organization").click(function(){//组织机构
    location.href = "organization.htm";
});
$("#organization_workdynamics").click(function(){//工作动态
    location.href = "workdynamics.htm?classify=1&state=2";           
});
$("#organization_delegate").click(function(){//人大代表
   location.href = "representative.htm";           
});
$("#organization_notice").click(function(){//通知公告
   location.href = "notice.htm?classify=3&state=2";           
});
$("#organization_station").click(function(){//联络总站
   location.href = "/delegatexweb/bmweb.jsp";      
})
$("#organization_institution").click(function(){//工作制度
    location.href = "institution.htm";           
});
        