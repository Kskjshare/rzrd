swfupload["icourlswf"].onselect = function (key, data) {
    $("#icourlwrap").html('<li id="' + this.name + key + '"><div class="swfuploadimg"><div><img src="/img/white.gif" /></div></div><h2>等待上传<div></div></h2></li>');
    $(".fileName").val(data.name.split(".")[0]);
}
swfupload["icourlswf"]["querystring"] = {"cutwidth": 300,"ext":""}
swfupload["icourlswf"].onsucceed = function (key, data) {
    data = data.toJson();
   $("#avatar").val(data["url"]);
}
