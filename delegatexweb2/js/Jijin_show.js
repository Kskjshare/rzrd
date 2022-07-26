$(function () {
    var rssid = window.location.href.split("id=")[1];
    console.log(rssid)

    RssApi.Table.Details("specail_collection").condition({ "id": rssid }).getJson(function (data) {
        console.log(data);
        $(".specail_collection").mapview(data);
    })
})