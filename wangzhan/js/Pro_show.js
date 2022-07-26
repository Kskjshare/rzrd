$(function () {
    var rssid = window.location.href.split("id=")[1];
    console.log(rssid)

    RssApi.Table.Details("sceneryimg").condition({ "id": rssid }).getJson(function (data) {
        console.log(data);
        $(".sceneryimg").mapview(data);
    })
})