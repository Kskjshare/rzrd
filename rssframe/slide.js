var picture = $("#picture");

var pictureurl = picture.val() ? picture.val().split(",") : [];
swfupload["pictureurlswf"].onselect = function (key, data) {
    $("#pictureurlwrap").append('<li id="' + this.name + key + '"><div class="swfuploadimg"><div><img src="/img/white.gif" /></div></div><h2>等待上传<div></div></h2></li>');
}
swfupload["pictureurlswf"]["querystring"] = {"cutwidth": 180, "ext": ""}
swfupload["pictureurlswf"].onsucceed = function (key, data) {
    data = data.toJson();
    pictureurl.push(data["url"]);
    picture.val(pictureurl.toString());
}
$("#pictureurlwrap del").click(function () {
    var t = $(this);
    pictureurl.splice(t.parent().index(), 1);
    picture.val(pictureurl.toString());
    t.parent().remove();
});