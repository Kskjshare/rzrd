/// <reference path="jquery.min.js" />
/// <reference path="rsseasy.min.js" />
/// <reference path="rsseasy.app.js" />
/// <reference path="validated.v2.min.js" />
/// <reference path="rsseasy.popup.min.js" />

//图片验证码生成
$("[imgtoken]").click(function () {
    var t = $(this);
    new Ajax("validate/img").get(function (data) {
        t.attr("src", "data:image/png;base64," + data);
        RssApp.ImgToken = this.xhr.getResponseHeader("imgtoken");
    });
}).click();

//发送短信验证码
$("[rsssmscode],[rsssmsreg],[rsssmspwd]").each(function () {
    var t = $(this), smscode = count = parseInt(t.attr("time")) || 60;
    t.click(function () {
        try {
            var dict = { "telphone": $("#" + t.attr("telphone")).val(), "imgcode": $("#" + t.attr("imgcode")).val(), "imgtoken": RssApp.ImgToken, "matter": t.attr("matter") }
            ValidatedV2.dictset(dict).keyset("telphone").isMobphone().keyset("imgcode").isImgCode();
            if (count != smscode) {
                return;
            }
            --count;
            RssTask.add("smscode", function () {
                t.html(count + "秒");
                if (count <= 0) {
                    t.html("重新发送");
                    RssTask.remove("smscode");
                    count = smscode;
                    return;
                }
                --count;
            }, 1000).start();
            new Ajax("sms/" + (t.attr("act") || "verify")).keyvalue(dict).rsscode(function () {
                count = 0;
            }).getJson(function (json) {
                RssApp.SmsToken = json["smstoken"];
            });
        }
        catch (ex) {
            RssCode.alert(ex);
        }
    });
});

$("[rssedit]").click(function () {
    $(this).rssedit();
});
$("[rssdel]").click(function () {
    $(this).rssdel();
});
$("[rssadd]").click(function () {
    $(this).rssadd();
});
$("[rssview]").click(function () {
    $(this).rssview();
});

//删除列表
$(".photolist").on("click", ".btndel", function () {
    var p = $(this).parent();
    p.parent().children().last().show();
    p.remove();
});

//选择图片来源框,属性值为图片预览容器
$("[chooseimage]").click(function () {
    var t = $(this), amount = t.attr("amount") || 1, key = t.attr("chooseimage");

    //图片选择或剪切完毕后上传成功
    RssUpFile.onComplete = function (json) {
        var html = $('<li class="uploadpreview"><b class="btndel"></b><div><img src="' + (json["base64"] ? json["base64"] : RssApp.UpHost + json["url"]) + '" /><input type="hidden" name="' + key + '" value="' + json["url"] + '"/></div></li>');
        if (amount > 1) {
            html.insertBefore(t);

            if (t.parent().children().length > amount) {
                t.hide();
            }

        } else {
            t.html(html).find(".btndel").remove();
        }
        t.trigger("uploadcomplete", json["url"]);
        RssWin.MaskLayer.close();
        RssWin.LoadBox.close();
    }
//    RssUpFile.onStart = function () {
//        RssWin.MaskLayer.show();
//        RssWin.LoadBox.show();
//    }
    RssPopup.SetTitle("选择图片").AddHtml('<li rssupfile="gallery">相册</li><li rssupfile="takephoto">拍照</li>').ItemWrap.find("li").unbind().click(function () {
//        RssWin.MaskLayer.close();
//        RssWin.LoadBox.close();
        var params = { "action": $(this).attr("rssupfile") };
        if (t.attr("cut")) {
            params["cut"] = parseInt(t.attr("cut")) || 300;
        }
        RssUpFile.Submit(params);
    });
    RssPopup.Popup();
});

//录音
$("[recordaudio]").click(function () {
    var t = $(this), time = t.attr("time") || 60, key = t.attr("recordaudio");

    //音频录制完毕并上传成功
    JsAdapter.onUpLoadFile = function (json) {
        t.html('<input type="hidden" name="' + key + '" value="' + json["url"] + '" />');
    }
    JsAdapter.RecordAudio({ "action": "upload", "time": time }).Submit();
});


//输入框
$("[rssinput]").click(function () {
    var t = $(this);
    var rssinputpage = RssPage.Init("rssinputpage").top();
    rssinputpage.title.html(t.attr("ipttitle"));
    rssinputpage.article.find("textarea").val(t.val().replace(/(?:<br \/>)/img, "\n"));
    rssinputpage.header.unbind().click(function () {
        t.val(rssinputpage.article.find("textarea").val().replace(/\n/img, "<br />"));
    });
    rssinputpage.right.unbind().click(function () {
        rssinputpage.left.click();
    });
});

//下载文件
$(document).on("click", "[downfile]", function () {    
    RssDownFile.Start($(this).attr("downfile"));
});