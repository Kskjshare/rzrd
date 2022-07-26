/// <reference path="../jquery.min.js" />
/// <reference path="../rsseasy.min.js" />
/// <reference path="adapter.min.js" />
/// <reference path="app.js" />
/// <reference path="../validated.v3.min.js" />

//发送注册短信验证码
$("[rsssmsreg]").each(function () {
    $(this).attr("act", "reg");
});
//发送找回密码 短信验证码
$("[rsssmspwd]").each(function () {
    $(this).attr("act", "pwd");
});
//用户注册
$("[userreg]").click(function (ev) {
    if ($('#register label input').is(":checked")) {
        var t = $(this), dict = t.attrmap(t.attr("userreg"));
        dict["smstoken"] = RssApp.SmsToken;
        try {
            ValidatedV3.setdict(dict).isNotEmpty("account", "手机号不能为空").isMobphone("account").isNotEmpty("pwd", "密码不能为空").isPwd("pwd").isSmsCode("smscode");
            new Ajax("user/reg").keyvalue(dict).getJson(function (json) {
                RssUser.Update(json);
                location.href = "#loginpage";
            });
        }
        catch (e) {
            RssCode.alert(e);
        }
    } else {
        alert("请阅读并同意协议");
        ev.preventDefault();
        return false;
    }
});  
//用户登陆
//            RssUser.onLogin();
if(!RssUser.Data.myid){
    location.href = "#loginpage";
}
$("[userlogin]").click(function () {
    var t = $(this), dict = t.attrmap(t.attr("userlogin"));
    try {
        ValidatedV3.setdict(dict).isNotEmpty("account", "手机号不能为空").isMobphone("account").isNotEmpty("pwd", "密码不能为空").isPwd("pwd")
        new Ajax("user/login").keyvalue(dict).getJson(function (json) {
//            RssUser.Update(json);
//            $('#loginform input').val("");
//            location.href = "#homepage";
        });
    }
    catch (e) {
        RssCode.alert(e);
    }
});

//用户登陆退出
$("[userloginout]").click(function () {
    RssUser.LoginOut();
    RssApp.Menu.first().click();
    JsAdapter.ClearHistory().Submit();
});
$('#regpage').load(function () {
    RssUser.LoginOut();
    JsAdapter.ClearHistory().Submit();
});
//
////用户表
//var userlist = new RssTable("userlist");
//$("[userlist]").each(function () {
//    var t = $(this);
//    new Ajax("user/list").getJson(function (json) {
//        t.mapitem(json);
//        userlist.dict = json;
//    });
//});
//
////忘记密码
$("[usergetpwd]").click(function () {
    var t = $(this), dict = t.attrmap(t.attr("usergetpwd"));
    dict["smstoken"] = RssApp.SmsToken;
    dict["repwd"] = dict["pwd"];
    try {
        ValidatedV3.setdict(dict).isMobphone("account").isPwd("pwd").isSmsCode("smscode");
        new Ajax("user/getpwd").keyvalue(dict).getJson(function (json) {
            RssUser.Update(json);
            $('#pwdform input').val("");
            alert("重置密码成功");
            location.href = "#loginpage";
        });
    }
    catch (e) {
        RssCode.alert(e);
    }
});
//
////修改密码
//$("[userpwd]").click(function () {
//    var t = $(this), dict = t.attrmap(t.attr("userpwd"));
//    dict["account"] = RssUser.Data.account;
//    try {
//        ValidatedV3.setdict(dict).isPwd("oldpwd").isPwd("pwd").isPwd("repwd").isEqual("pwd", "repwd");
//        new Ajax("user/pwd").keyvalue(dict).getJson(function (json) {
//            RssUser.Update(json);
//            $('#mine_setting_pwd input').val("");
//            alert("修改密码成功");
//            location.href = "#mine_setting_safe";
//        });
//    }
//    catch (e) {
//        RssCode.alert(e);
//    }
//});