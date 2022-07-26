swfupload["icourlswf"].onselect = function (key, data) {
    $("#icourlwrap").html('<li id="' + this.name + key + '"><div class="swfuploadimg"><div><img src="/img/white.gif" /></div></div><h2>等待上传<div></div></h2></li>');
}
swfupload["icourlswf"]["querystring"] = {"cutwidth": 180, "ext": ""}
swfupload["icourlswf"].onsucceed = function (key, data) {
    data = data.toJson();
    $("#ico").val(data["url"]);
}