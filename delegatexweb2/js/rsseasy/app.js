// / <reference path="jquery.min.js" />
// / <reference path="rsseasy.adapter.min.js" />
// / <reference path="rsseasy.min.js" />
// / <reference path="rsseasy.dialog.min.js" />


//APP?????????
// RssApp["WwwHost"] = "http://wsrd.cloudrich.top:10000/";  //wsrd
// RssApp["WwwHost"] = "http://116.95.33.77:10000/";  //wsrd
//RssApp["WwwHost"] = "http://219.159.165.98:81/";//bmrd
RssApp["WwwHost"] = "http://117.158.113.36:80/";  //???????
RssApp["ApiHost"] = RssApp.WwwHost + "api/";   //API??????
RssApp["UpHost"] = RssApp.WwwHost + "upfile/";
RssApp["UpFileApi"] = RssApp.WwwHost + "widget/upload.jsp";
RssApp["LiVeUrl"] = "http://live.itemjia.com/rsseasy/";
RssApp["AllPage"] = $("section");  //????????
RssApp["CurPage"] = RssApp["AllPage"].first().show();  //??????????
RssApp["Hash"] = "#";
RssApp["HashLoad"] = true;
RssApp["Menu"] = $("body>footer>a");   //?????
RssApp["Width"] = $(window).width();  //APP??????
RssApp["WinHeight"] = $(window).height();  //APP??????
RssApp["SmsToken"] = "";  //?????????????????????
RssApp["ImgToken"] = "";  //???????????????
RssApp["Module"] = {"goods": 3}

//?????????
//RssUpFile.DoMain = "http://wsrd.cloudrich.top:10000/upfile/";//wsrd
// RssUpFile.DoMain = "http://116.95.33.77:10000/upfile/";//wsrd
//RssUpFile.DoMain = "http://219.159.165.98:81/upfile/";//bmrd
// RssUpFile.DoMain = "http://192.168.1.104:8084/upfile/";//???????
RssUpFile.DoMain = "http://117.158.113.36:80/upfile/";//???????


$(window).resize(function () {
    RssApp.Width = $(window).width();
    // $("html").css("font-size", parseInt(RssApp.Width / 750 * 100));
}).resize();

//AJAX??????
Ajax.prototype.prikey = "www.rsseasy.com";  //?????????
Ajax.prototype.host = RssApp["ApiHost"];   //AJAX?????RL?????????
Ajax.prototype.oncreate = function () {
};
Ajax.onrsscode = function () { }
Ajax.rsscode = function (code) {
    if (Ajax.onrsscode(code)) {
        Ajax.onrsscode = function () { };
        alert("9999999")
        location.hash = "#loginpassword";
        return;
    }
    alert("88888")
    RssCode.alert(code);
}

RssTask.synctime(RssApp.ApiHost + "time");  //?????????????????
RssVideo.player = document.getElementById("videoplay");   //???????????,??????????????????????????????

RssApp["Menu"].click(function () {
    RssApp["Menu"].removeClass();
    $(this).addClass("active");
    if (!$(this).attr("islogin")) {
        JsAdapter.ClearHistory().Submit();
    }
});

//???????
var RssPage = {};
RssPage["MaskLayer"] = $("#masklayer");
RssPage.Init = function (pageid) {
    if (!this[pageid]) {
        var page = $("#" + pageid);
        this[pageid] = {
            "page": page,
            "header": page.find(">header"),
            "title": page.find(">header h1"),
            "article": page.find(">article"),
            "footer": page.find(">footer"),
            "right": page.find(">header .right"),
            "left": page.find(">header .left"),
            "top": function () {
                var t = this;
                this.page.attr("target", "top").find(".hisback").unbind().click(function (ev) {
                    ev.preventDefault();
                    ev.stopPropagation();
                    t.page.removeAttr("target");
                });
                return t;
            }
        }
    }
    return this[pageid];
};
RssPage.onpagechange = function (to, isload) {
    RssApp["AllPage"].hide();
    if (to) {
        if (to != "#loginpage") {
            RssApp.Hash = to;
        }
        RssAudio.stop();
        RssVideo.stop();
        RssApp["Menu"].filter("[href='" + to + "']").click();//???footer???????????????RssApp["Menu"].click()
        document.title = $("#hash header h1").text() || document.title;
        to = $(to).show();
        if (isload) {
            to.load();
        }
        to.trigger("pagechange");
        return;
    }
    RssApp["AllPage"].first().show().load();
}
$("section").each(function ()//?????????ection?????ssPage??
{
    var id = this.id;//??????section??d??
    if (id) {
        RssPage[id] = RssPage.Init(id);
    }
})
window.onhashchange = function () {
    RssPage.onpagechange(location.hash, true);
};
window.onhashchange();

RssPage.PageToggle = function (to) {
    RssApp["AllPage"].hide();
    var isload = true;
    if (to) {
        $(RssApp.Hash).trigger("unload", function (load) {
            isload = load;
        });
        if (to != "#loginpage") {
            RssApp.Hash = to;
        }
        RssAudio.stop();
        RssVideo.stop();
        RssApp["Menu"].filter("[href='" + to + "']").click();//???footer???????????????RssApp["Menu"].click()
        document.title = $("#hash header h1").text() || document.title;
        to = $(to).show();
        if (isload) {
            to.load();
        }
        return;
    }
    RssApp["AllPage"].first().show().load();
}

//????????
JsAdapter.onGetVersion = function (json) {
    new Ajax("version").keyvalue(json).getJson(function (json) {
        if (!json["url"]) {
            return;
        }
        RssDialog.onConfig = function () {
            // JsAdapter.Push({"adapter": "SoftUpdate", "url": RssApp.UpHost + json["url"]}).Submit();
            //alert("????2??????");
		}
        RssDialog.SetTitle("????????").setConfig("??????").AddHtml(json["remark"]).Popup();
        console.log(JSON.stringify(json));
    });
}

JsAdapter.GetVersion().Submit();

JsAdapter.onReady = function (pzhi) {
    new Ajax("Deviceid").keyvalue({"myid": RssUser.Data.myid, "deviceid": pzhi["deviceid"]}).getJson(function (pzhi) {
    });
//    alert(pzhi["deviceid"]);
}
JsAdapter.Ready({"myid": RssUser.Data.myid}).Submit();

JsAdapter.onPushMessage = function (mg) {
    if (mg["key"] == "1") {
        //???
        location.href = "#applyHD";
    }
    if (mg["key"] == "2") {
        //????
        location.href = "#suggesthandle";
    }
    if (mg["key"] == "3") {
        //????
        location.href = "#suggesthandleYA";
    }

    // 4 5 6 7???????
    if (mg["key"] == "4") {
        location.href = "#noticebulletin";
    }
    if (mg["key"] == "5") {
        location.href = "#noticebulletin";
    }
    if (mg["key"] == "6") {
        location.href = "#noticebulletin";
    }
    if (mg["key"] == "7") {
        location.href = "#noticebulletin";
    }
    if (mg["key"] == "8") {
        //??????
        location.href = "#courseware";
    }
    if (mg["key"] == "9") {
        //???????
        location.href = "#lecture";
    }
    if (mg["key"] == "10") {
        //???????
        location.href = "#reference";
    }
    if (mg["key"] == "11") {
        //??????? ????
        location.href = "#statute";
    }
    if (mg["key"] == "12") {
        //???
        location.href = "#statute";
    }
    if (mg["key"] == "13") {
        //???????
        location.href = "#statute";
    }



//    switch (mg["key"]) {
//        case 1:
//            location.href = "#applyHD";
//            break;
//        case 2:
//            location.href = "#suggesthandle";
//            break;
//        case 3:
//            location.href = "#suggesthandleYA";
//            break;
//        case 4:
//            location.href = "#notice";
//            break;
//        case 5:
//            location.href = "#notice";
//            break;
//        case 6:
//            location.href = "#notice";
//            break;
//        case 7:
//            location.href = "#notice";
//            break;
//        case 8:
//            location.href = "#courseware";
//            break;
//        case 9:
//            location.href = "#lecture";
//            break;
//        case 10:
//            location.href = "#reference";
//            break;
//        case 11:
//            location.href = "#statute";
//            break;
//        case 12:
//            location.href = "#statute";
//            break;
//        case 13:
//            location.href = "#statute";
//            break;
////        case 14:
////            location.href = "#user_cbdweval";
////            break;
//        default:
//            break;
//    }
}

if (!Storage.Get("launch")) {
    Storage.Set("launch", "1");
    $("#launchpage").on("pageslideend", function (ev, json) {
        if (json["curpage"] == json["totalpage"]) {
            $(this).hide();
        }
    }).show();
}
//if(Url['bb']){
//    loct
//}
//?????????
//function num(obj) {
//    $('input').bind('input propertychange', function () {
//        obj.value = obj.value.replace(/[^\d.]/g, ""); //???"???"??"."?????????
//        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
//        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //?????????????
//    })
//}