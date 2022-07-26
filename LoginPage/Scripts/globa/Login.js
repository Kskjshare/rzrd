var help = new Help();
$(function () {
    $('#login').click(function () {
        var name = $('#username').val();
        var mima = $('#password').val();
        if (name == "") {
            $.messager.alert("提示", "请输入用户名");
            return;
        }
        if (mima == "") {
            $.messager.alert("提示", "请输入密码");
            return;
        }
        $.ajax({
            url: help.getWindowtPath() + '/Login/TryLogin',
            type: 'post',
            dataType: 'json',
            data: $('#trylogin').serialize(),
            success: function (date) {
                if (date.success) {
                    window.location.href = help.getWindowtPath() + '/Home/ChooseModelView';
                }
                else {
                    $.messager.alert("提示", date.msg);
                }
            }
        })
    })
})
function readyLogin() {
    if (event.keyCode == 13) {
        return $('#login').click();
    }

}