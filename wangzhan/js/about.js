$(function () {
    RssApi.Table.Details("pcsurvey").getJson(function (data) {
        console.log(data);
        $(".artcont").mapview(data);
    })
})