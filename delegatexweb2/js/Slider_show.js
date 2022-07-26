$(function () {
    var rssid = window.location.href.split("id=")[1];
    console.log(rssid)

    RssApi.Table.Details("imagin_news").condition({ "id": rssid }).getJson(function (data) {
//        console.log(data);
//        console.log(data.channel)
        let shijian =  new Date(data.shijian * 1000).toString("yyyy-MM-dd");
        let str = '时间：' + shijian +'　　来源：'+data.origin;
        $(".n04").html(str);
        $(".module_caption").html(data.channel);
        $(".imagin_news").mapview(data);
       
    })
})