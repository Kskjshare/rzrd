/// <reference path="jquery.min.js" />
/// <reference path="rsseasy.min.js" />
/// <reference path="jquery.signalR.js" />

var rssim = new RssIM();
rssim.connect();
rssim.onReceive = function (json) {
    JsAdapter.Notity({ "title": json["title"], "text": json["title"] }).Submit();
    console.info(json);
}