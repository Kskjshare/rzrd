/// <reference path="jquery.min.js" />
/// <reference path="rsseasy.min.js" />
/// <reference path="webviewadapter.min.js" />
/// <reference path="jquery.signalR.js" />

$(function () {
    var im = new RssIM();
    im.Message.title = "什么";
    im.Message.matter = "好啊";
    im.Message.clasifyid = "1";
    im.onReceive = function (json) {
        JsAdapter.Notity({ "title": json["title"], "text": json["title"] }).Submit();
        console.info(json);
    }
    im.onConnected = function (data) {
        //console.log(data);
        //im.SendMyID($("#myid").val());
    }

    $("#sendbtn").click(function () {
        RssUser.Update({ "myid": $("#logmyid").val() });
        im.connect();
    });
});