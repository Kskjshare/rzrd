swfupload["icourlswf"].onselect = function (key, data) {
    $("#icourlwrap").html('<li id="' + this.name + key + '"><div class="swfuploadimg"><div><img src="/img/white.gif" /></div></div><h2>等待上传<div></div></h2></li>');
}
swfupload["icourlswf"]["querystring"] = {"cutwidth": 180, "ext": ""}
swfupload["icourlswf"].onsucceed = function (key, data) {
    data = data.toJson();
    if (data["succeed"])
    {
        $("#avatar").val(data["url"]);
    }
}

swfupload["videourlswf"].onselect = function (key, data) {
    $("#videourlwrap").html('<li id="' + this.name + key + '"><div class="swfuploadimg"><div><img src="/img/white.gif" /></div></div><h2>等待上传<div></div></h2></li>');
}
swfupload["videourlswf"].onsucceed = function (key, data) {
    data = data.toJson();
    if (data["succeed"])
    {
        $("#videourl").val(data["url"]);
    }
}

swfupload["posterswf"].onselect = function (key, data) {
    $("#posterwrap").html('<li id="' + this.name + key + '"><div class="swfuploadimg"><div><img src="/img/white.gif" /></div></div><h2>等待上传<div></div></h2></li>');
}
swfupload["posterswf"].onsucceed = function (key, data) {
    data = data.toJson();
    if (data["succeed"])
    {
        $("#videoposter").val(data["url"]);
    }
}

