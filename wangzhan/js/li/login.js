//用户登陆
//    empty('#loginpage');


$("[userlogin]").click(function () {
    var t = $(this), dict = t.attrmap(t.attr("userlogin"));
    try {
        ValidatedV3.setdict(dict).isNotEmpty("account", "登陆账号不能为空").isNotEmpty("pwd", "密码不能为空").isPwd("pwd");
        new Ajax("applogin").keyvalue(dict).getJson(function (json) {
//        new Ajax("user/login").keyvalue(dict).getJson(function (json) {
            if (json["state"] == "no") {
                alert("账号或密码错误！")
                return false;
            }
            if (json["state"] == "yes") {
                alert("第一次登录请修改密码！")
                $(".cfpwd").show();
                $("[name='newpsw']").blur(function () {
                    if (!$("[name='newpsw']").val().match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/)) {
                        alert("格式不正确");
                    }
                })
                $("[name='againpsw']").blur(function () {
                    console.log($("[name='newpsw']").val() == $("[name='againpsw']").val())
                    if ($("[name='newpsw']").val() != $("[name='againpsw']").val()) {
                        alert("两次密码格输入不一致");
                    }
                })
                $(".cfpwd .normalbutton").click(function () {
                    var account = $('#loginform input[name="account"]').val();
                    var pwd = $('#loginform input[name="againpsw"]').val();
                    new Ajax("userloginpwd").keyvalue({"account": account, "pwd": pwd}).getJson(function (jsons) {
                        $(".cfpwd").hide();
                        $('#loginform input[name="account"]').val(account);
                        $('#loginform input[name="againpsw"]').val(pwd);
                    });
                });
            } else {
                delete json.matter;
                RssUser.Update(json[0]);
                if ($("#forget").is(":checked")) {
                    localStorage.password = $("input[name='pwd']").val();
                }
                $("input[name='account']").val("");
                $("input[name='pwd']").val("");
                location.href = "#notice"
                RssApi.Edit("syslog").keyvalue({"logclass": "1", "logtitle": "手机登录成功", "matter": "手机app登录", "myid": RssUser.Data.myid}).getJson(function (json) {
                })
            }
        });
    } catch (e) {
        console.log(e)
        RssCode.alert(e);
    }
});
$("#logout").click(function () {
    if (confirm("确定退出登陆?")) {
//        location.href = "#loginpage"
//        RssApi.Delete("userDeviceid").keyvalue({"myid": RssUser.Data.myid}).getJson(function (json) {
//        })
//        RssApi.Delete("userDeviceid").condition(new RssDict().keyvalue({
//            "myid": RssUser.Data.myid,
//            "state":1
//        }).keymyid().getDict()).getJson(function (jsonn) {
//        });
        RssUser.LoginOut();
        RssPage.PageToggle("#loginpage", false);
        JsAdapter.ClearHistory().Submit();
    }
})
    