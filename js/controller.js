JsAdapter.KeyWords = function (keyword)
{
    this.Push({"adapter": "KeyWords", "keyword": keyword});
    return this;
}

JsAdapter.LoginInfo = function (params)
{
    params["adapter"] = "LoginInfo";
    this.Push(params);
    return this;
}
if (Cookie.Get("isadmin"))
{
    $(".adminpow").show();
}
$('[getduration]').click(function () {
    var label = $(this).attr("getduration").split(',');
    RssVideo.onready = function () {
        $('[name="' + label[1] + '"]').val(RssVideo.duration);
    }
    var src=$('[name="' + label[0] + '"]').val();
    if(!src)
    {
        alert("请设置地址");
        return ;
    }
    RssVideo.setsrc(src);
});

$('[selectuser]').click(function (){
    var t=$(this);
    RssWin.onwinreceivemsg=function(dict){
        t.val(dict["myid"]);
    }
//    RssWin.open("/user/select.jsp",400,500);
});