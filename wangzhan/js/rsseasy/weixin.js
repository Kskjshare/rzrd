/// <reference path="rsseasy.min.js" />

var RssWeiXin = {};
RssWeiXin.onLoginReg = function (json) {
    var refer = Cookie.Get("loginrefer");
    if (refer) {
        Cookie.Remove("loginrefer");
        location.href = decodeURIComponent(refer);
    }
    return refer;
};

RssWeiXin.Authorize = function () {
     location.href = "http://open.weixin.qq.com/connect/oauth2/authorize?appid=wxcae41963ebcee081&redirect_uri=http://sys.coal.itemjia.com/api/weixin/reg&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
//    $.ajax({
//        url: 'http://open.weixin.qq.com/connect/oauth2/authorize?appid=wxcae41963ebcee081&redirect_uri=http://sys.coal.itemjia.com/api/weixin/reg&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect',
//        type: 'GET',
//        beforeSend: function(xhr){
//            xhr.setRequestHeader("Access-Control-Allow-Origin", '*');
//        },
//        success: function (data) {
////            location.href = data;  
//        },
//        error: function (data) {
////            console.log("上传失败");
//        }
//    });
    new Ajax("weixin/authorize").get(function (data) {
        console.log(data)
        location.href = data;  //用户转到微信授权登录页面
    });
}

//注册注册登录
RssWeiXin.LoginReg = function (refer) {
    if (!RssUser.Data.openid && !Url['openid']) {
        Cookie.Set("loginrefer", encodeURIComponent(refer));
        RssWeiXin.Authorize();
        return;
    }
    new Ajax("weixin/login").keyvalue({ "openid": RssUser.Data.openid }).getJson(function (data) {
        RssUser.Update(data);
        RssWeiXin.onLoginReg(data);
    });
}

RssWeiXin.GetTicket = function () {
    new Ajax("weixin/ticket").keyvalue("url", location.href.replace(location.hash, "")).getJson(function (data) {
        data["jsApiList"] = ["onMenuShareTimeline", "onMenuShareAppMessage", "onMenuShareQQ", "onMenuShareWeibo", "onMenuShareQZone", "startRecord", "stopRecord", "onVoiceRecordEnd", "playVoice", "pauseVoice", "stopVoice", "onVoicePlayEnd", "uploadVoice", "downloadVoice", "chooseImage", "previewImage", "uploadImage", "downloadImage", "translateVoice", "getNetworkType", "openLocation", "getLocation", "hideOptionMenu", "showOptionMenu", "hideMenuItems", "showMenuItems", "hideAllNonBaseMenuItem", "showAllNonBaseMenuItem", "closeWindow", "scanQRCode", "chooseWXPay", "openProductSpecificView", "addCard", "chooseCard", "openCard"];
        wx.config(data);
    });
}
