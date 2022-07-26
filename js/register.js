$('#valicode').click(function () {
    $(this).attr("src", "vidatecode.jsp?" + Math.random());
});

$("#accounttype>li>button").click(function () {
    $("#operation").show().siblings().hide();
    if ($(this).attr("tid") == "1") {
        $("#operation div>.classifyid").val("3");
    }
});

function verification() {
    var tel = $(".tel").val(), nc = $(".nc").val(), zs = $(".zs").val(), pwd = $(".pwd").val(), repwd = $(".repwd").val(), regsmsimgcode = $("#regsmsimgcode").val(), telcode = $("#telcode").val();
    if (!tel.match(/^1[34578]\d{9}$/)) {
        alert("请输入正确的手机号");
        return false;
    }
    if (nc == "") {
        alert("请填写昵称");
        return false;
    }
    if (zs == "") {
        alert("请填写真实姓名");
        return false;
    }
    if (!pwd.match(/^\S{6,}$/)) {
        alert("请按格式填写密码");
        return false;
    }
    if (pwd != repwd) {
        alert("两次密码不一致");
        return false;
    }
//    if (MD5(telcode) != smstelcode) {
//        alert("短信验证码错误！");
//        return false;
//    }
    $("#operation>form>div>input").val();
    $("#operation .action").val("append");
}


$('#register').load(function () {
    $('#register img').click();
});
$("[userreg]").click(function (ev) {
    var t = $(this), dict = t.attrmap(t.attr("userreg"));
    dict["smstoken"] = RssApp.SmsToken;
    try {
        ValidatedV2.dictset(dict).keyset("account").isMobphone().keyset("pwd").isPwd().keyset("smscode").isSmsCode();
        new Ajax("user/reg").keyvalue(dict).getJson(function (json) {
            RssUser.Update(json);
            alert("注册成功");
            location.href = "#loginpage";
            new Ajax("saas/userset").keyvalue({'action': "updpwd", 'myid': RssUser.Data.myid, 'parentid': RssUser.Data.myid}).getJson(function (json) {
                var rsscode = json['rsscode'];
                if (rsscode) {
                    alert(dictdata.rsscode[rsscode] || rsscode);
                    return;
                } else {
                }
            });
        });
    } catch (e) {
        RssCode.alert(e);
    }
});

if (a.state == "repeat") {
    alert("账号已存在！");
}

function getCookie(name)
{
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}