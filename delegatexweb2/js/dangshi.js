$(function () {
    //RssApi.Table.List("ztimges").keyvalue({ "pagesize": 12, "type": 1 }).getJson(function (data) {
   RssApi.Table.List("ztimges").condition({"collectiontype":0,"type":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        console.log(data);
        for (var i = 0; i < data.length; i++) {
            var imgContent = data[i];
            var imgHtml = "<li onclick='showLi("+imgContent.id+")'>";
            imgHtml = imgHtml + "<img src='http://117.158.113.36:80/upfile/"+imgContent.ico+"' alt=''>";
            imgHtml = imgHtml + "<p><strong>"+imgContent.title+"</strong></p>";
            var imgHtml = imgHtml + "</li>";
            $(".bndsbox").append(imgHtml);
        };
    })

    //RssApi.Table.List("ztimges").keyvalue({ "pagesize": 12, "type": 2 }).getJson(function (data) {
    RssApi.Table.List("ztimges").condition({"collectiontype":0,"type":2}).keyvalue({ "pagesize": 12 }).getJson(function (data) {	
        console.log("data2 is:", data);

        var pstr1 = "";
        var pstr2 = "";
        for (var i = 0; i < data.length; i++) {
            var title = data[i].title;
            if (title.length > 26) {
                title = title.substring(0, 25) + "...";
            };
            if (i % 2 == 0) {
                pstr1 = pstr1 + "<p class='news-item1'>";
                pstr1 = pstr1 + "<a target='_blank' onclick='showLi("+data[i].id+")'>"+title+"</a>";
                pstr1 = pstr1 + "</p>";
            } else {
                pstr2 = pstr2 + "<p class='news-item1'>";
                pstr2 = pstr2 + "<a target='_blank' onclick='showLi("+data[i].id+")'>"+title+"</a>";
                pstr2 = pstr2 + "</p>";
            }
            
        }
        $("#leftContent").append(pstr1);
        $("#rightContent").append(pstr2);
    })

    var topTitleRssid;
    var topImgRssid;

    RssApi.Table.List("ztimges").condition({"collectiontype":0,"type":3}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        console.log("data3 is:", data);
        if (data.length > 0) {
            topTitleRssid = data[0].id;
            $("#topTitle").html(data[0].title);
        };
    });

     RssApi.Table.List("ztimges").condition({"collectiontype":0,"type":4}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        console.log("data4 is:", data);
        if (data.length > 0) {
            topImgRssid = data[0].id;
            $("#topImg").attr("src", "http://117.158.113.36:80/upfile/" + data[0].ico);
        }
    });

     $("#topTitle").click(function(){
        location.href = "Dangshi_show.htm?id=" + topTitleRssid + "";
     })

     $("#topImg").click(function(){
        location.href = "Dangshi_show.htm?id=" + topImgRssid + "";
     })
})

function showLi(rssid) {
    location.href = "Dangshi_show.htm?id=" + rssid + "";
}
