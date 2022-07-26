/// <reference path="../jquery.min.js" />
/// <reference path="rsseasy.v2.js" />


//使用浏览器调用打开
var WebAdapter = {
    "Request": function (params) {
        new Ajax(params["url"]).getJson(function (data) {
            JsAdapterCallBack(data);
        });
    },
    "GetContactsPhone": function () {
        JsAdapter.onGetContactsPhoneComplete({});
    },
    "SQLite": function (params) {
        var sqlite = new SqliteHelper(params);
        sqlite.action();
    },
    "Progress": function (params) {
        switch (params["action"]) {
            case "hide":
                RssWin.MaskLayer.close();
                RssWin.LoadBox.close();
                break;
            default:
                RssWin.MaskLayer.show();
                RssWin.LoadBox.show(params["message"] || "加载中...");
                break;
        }
    },
    "MusicPlay": function (params) {
        RssAudio.play(params["url"])
    },
    "TakePhotos": function (params) { },
    "GetVersion": function () {
        JsAdapter.onGetVersion(0);
    }
}

var JsAdapter = {
    Params: {},
    Push: function (params) {
        JsAdapter.Params = params;
        return this;
    },
    onPageFinished: function () {

    },
    onHttpConnOpen: function ()  //在链接打开的时候
    {

    },
    ClearHistory: function () {  //清除历史缓存
        this.Push({ "adapter": "ClearHistory" });
        return this;
    },
    onClearHistory: function () {
    },
    Print: function (params) {
        params["adapter"] = "Print";
        this.Push(params);
        return this;
    },
    onPrint: function (json) {

    },
    Close: function (params) {  //关闭
        params = params || {};
        params["adapter"] = "Close";
        this.Push(params);
        return this;
    },
    onClose: function (params) {

    },
    Vibrator: function (params) {  //调用震动
        params["adapter"] = "Vibrator";
        this.Push(params);
        return this;
    },
    MusicPlay: function (params) {  //播放音乐：loop-循环播放，action(play|pause|stop|loop),url-需要播放的音频地址
        params["adapter"] = "MusicPlay";
        this.Push(params);
        return this;
    },
    onPlayReady: function () { },
    onPlayEnd: function () { },
    PdfReader: function (params) {  //Pdf阅读
        params["adapter"] = "PdfReader";
        this.Push(params);
        return this;
    },
    GetPackageSign: function () {  //获取包的签名信息
        this.Push({ "adapter": "GetPackageSign" });
        return this;
    },
    onGetPackageSign: function (json) {
    },
    GetStatus: function () {
        this.Push({ "adapter": "GetStatus" });
        return this;
    },
    Base64Image: function (params) {
        params["adapter"] = "Base64Image";
        this.Push(params);
        return this;
    },
    onGetStatus: function (json) {

    },
    onResume: function (json) {
    },
    Progress: function (params) {
        params = params || {};
        params["adapter"] = "Progress";
        this.Push(params);
        return this;
    },
    onProgress: function (json) {
    },
    onComplete: function (json) {
    },
    GetContactsPhone: function ()  //逐条获取通讯录电话
    {
        this.Push({ "adapter": "GetContactsPhone" });
        return this;
    },
    onGetContactsPhone: function (array)  //当获取通讯录
    {

    },
    onGetContactsPhoneComplete: function (json) { //当获取完通许录所有电话

    },
    onGetContactsPhoneFail: function (json) {
    },
    QRcodeMake: function (params) {  //生成二维码 {"data":"需要生成的二维码数据"}
        params["adapter"] = "QRcodeMake";
        this.Push(params);
        return this;
    },
    onQRcodeMake: function (json) { },
    QRcodeScan: function () {  //二维码扫描
        this.Push({ "adapter": "QRcodeScan" });
        return this;
    },
    onQRcodeDecode: function (json) {  //二维码扫描后的数据
        return this;
    },
    SysSetting: function (params) {  //调用系统设置相关界面,参数action:apn|gps
        params["adapter"] = "SysSetting";
        this.Push(params);
        return this;
    },
    WebPing: function (url) {  //网站是否正常
        this.Push({ "adapter": "WebPing", "url": url });
        return this;
    },
    onWebPing: function (json) {

    },
    GetGpsState: function () {  //获取GPS状态
        this.Push({ "adapter": "GetGpsState" });
        return this;
    },
    onGetGpsState: function (json) {
    },
    GetNetState: function () {  //获取网络状态
        this.Push({ "adapter": "GetNetState" });
        return this;
    },
    OpenGps: function () {
        this.Push({ "adapter": "OpenGps" });
        return this;
    },
    onOpenGps: function (json) {
    },
    onGetNetState: function (json) {
    },
    onWiFiChange: function (json) {  //当WiFi发化变化的时候

    },
    GetAppList: function (params) {
        params = params || {};
        params["adapter"] = "GetAppList";
        this.Push(params);
        return this;
    },
    onGetAppListStart: function (json) {  //当开始获取APP列表开始

    },
    onGetAppList: function (json) {  //获取APP列表

    },
    onGetAppListEnd: function (json) {  //获取APP列表结束

    },
    Request: function (params) {
        params["adapter"] = "Request";
        this.Push(params);
        return this;
    },
    Focus: function () {
        this.Push({ "adapter": "Focus" });
        return this;
    },
    onRequest: function (params) {

    },
    PhotoCut: function (params)  //图片剪切
    {
        params = params || {};
        params["adapter"] = "PhotoCut";
        this.Push(params);
        return this;
    },
    onPhotoCut: function (json) {
    },
    GalleryList: function (params)  //获取手机图片列表
    {
        params["adapter"] = "GalleryList";
        this.Push(params);
        return this;
    },
    onGalleryListReady: function (params) {  //已准备好获取

    },
    onGalleryList: function (params) {
    },
    onGalleryListComplete: function (params) {

    },
    GallerySelect: function (params) {   //从相册中选择
        params["adapter"] = "GallerySelect";
        this.Push(params);
        return this;
    },
    onGallerySelect: function (params) //当相册文件被选择后
    {

    },
    TakePhotos: function (params)  //拍照
    {
        params = params || {};
        params["adapter"] = "TakePhotos";
        this.Push(params);
        return this;
    },
    onTakePhotos: function (json) {
    },
    onTakePhotosError: function (json) {
        alert(json["error"]);
    },
    DownloadApk: function (url) {
        this.Push({ "adapter": "DownloadApk", "url": url });
        return this;
    },
    onMenuClick: function (params) {

    },
    ToastShow: function (message)  //
    {
        this.Push({ "adapter": "ToastShow", "message": message });
        return this;
    },
    onSoftKeyBoard: function (json) {

    },
    GetVersion: function () {
        this.Push({ "adapter": "GetVersion" });
        return this;
    },
    onGetVersion: function (params) {

    },
    MapMarkerPoint: function (params)  //在地图上显示点
    {
        params["adapter"] = "MapMarkerPoint";
        this.Push(params);
        return this;
    },
    MapSelectPoint: function (params)  //在地图上获取选定点的信息
    {
        params = params || {};
        params["adapter"] = "MapSelectPoint";
        this.Push(params);
        return this;
    },
    onMapSelectPoint: function (json) {
    },
    MapNavigation: function (params) {

    },
    LocationListener: function (params)//启动定位侦听
    {
        params = params || {};
        params["adapter"] = "LocationListener";
        this.Push(params);
        return this;
    },
    onLocationReceive: function (json)  //当成功收到定位信息时
    {
    },
    onLocationReceiveFail: function (json)  //当定位信息出错时
    {
    },
    PolygonContains: function (params) {   //判断指定的坐标点是否在多边型中
        params["adapter"] = "PolygonContains";
        this.Push(params);
        return this;
    },
    onLatLngContains: function (json) {  //在指定的坐标在形状中
    },
    ComputeDistance: function (params)  //测试两点之间的距离,p1lat,p1lng,p2lat,p2lng
    {
        params["adapter"] = "ComputeDistance";
        this.Push(params);
        return this;
    },
    onComputeDistance: function (json)  //距离结果
    {
    },
    onComputeDistanceFail: function (json)  //距离错误
    {
    },
    MapNavAutoMode: function (params) {//获取自动数据
        params["adapter"] = "MapNavAutoMode";
        this.Push(params);
        return this;
    },
    onMapNavAutoMode: function (json) {
    },
    onMapNavAutoModeStop: function (json) {
    },
    ClearCache: function () {
        this.Push({ "adapter": "ClearCache" });
        return this;
    },
    onClearCache: function (json) {

    },
    onSQLite: function (params) {

    },
    StartUpApp: function (params) {
        params["adapter"] = "StartUpApp";
        this.Push(params);
        return this;
    },
    //debug:false
    Ready: function (params) {
        params = params || {};
        params["adapter"] = "Ready";
        this.Push(params);
        return this;
    },
    onReady: function (json) {
    },
    InnerWeb: function (params) {
        params["adapter"] = "InnerWeb";
        this.Push(params);
        return this;
    },
    Notity: function () {
        this.Push({ "adapter": "Notity" });
        return this;
    },
    onNotity: function (data) {

    },
    PushMessage: function () {
        this.Push({ "adapter": "PushMessage" });
        return this;
    },
    onPushMessage: function (data) {
    },
    PushReg: function () {
        this.Push({ "adapter": "PushReg", 'myid': RssUser.Data.myid || "", 'account': RssUser.Data.account || "" });
        return this;
    },
    onPushReg: function (json) {
    },
    Browser: function (url) {
        this.Push({ "adapter": "Browser", "url": url });
        return this;
    },
    onNotity: function () {

    },
    onKeyBoardShow: function (json) {

    },
    onKeyBoardHide: function (json) {
    },
    Md5Sign: function (params) {
        params["adapter"] = "Md5Sign";
        this.Push(params);
        return this;
    },
    onMd5Sign: function (json) {

    },
    TaskTick: function (params) {
        params["adapter"] = "TaskTick";
        this.Push(params);
        return this;
    },
    onTaskTick: function () { },
    onNotityError: function (json) {
        alert(json["error"]);
    },
    onRollBack: function (params) {
    },
    onThreadQueueStart: function () { },
    onThreadQueueComplete: function () { },
    onSqlError: function (json) {
        console.info(json["error"]);
    },
    onSqlDrop: function (json) {
    },
    onSqlAppend: function (json) {
    },
    onSqlUpdate: function (json) {
    },
    onSqlDelete: function (json) {
    },
    onSqlQuery: function (json) {
    },
    onSqlGetFirstRows: function (json) {
    },
    Submit: function () {
        RssAppAdapter(this.Params);
    }
}

function JsAdapterCallBack(params) {
    RssAppCallBackFactory(JsAdapter, params);
}

$("[jsadapter]").click(function () {
    var t = $(this);
    var adapter = t.attr("jsadapter");
    if (!JsAdapter[adapter]) {
        alert(adapter + "指令不存在！");
        return;
    }
    var params = (t.attr("params") || "{}").toJson();
    JsAdapter[adapter](params).Submit();
});
$('[input]').focus(function () {
    JsAdapter.Focus().Submit();
});

JsAdapter.PushMessage().Submit();

$("[js-innerweb]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    var t = $(this);
    JsAdapter.InnerWeb({ "url": t.attr("js-innerweb"), "bgcolor": t.data("bgcolor") || "#000000" }).Submit();
});

$("[js-close]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.Close($(this).data("params")).Submit();
});

$("[js-musicplay]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    var t = $(this);
    JsAdapter.MusicPlay({ "url": t.data("url"), "action": t.attr("js-musicplay") }).Submit();
});

$("[js-qrcodescan]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.QRcodeScan().Submit();
});

$("[js-vibrator]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.Vibrator({ "time": parseInt($(this).attr("js-vibrator")) || 50 }).Submit();
});

$("[js-locationlistener]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    var t = $(this);
    var dict = new RssDict().keyvalue("time", t.attr("js-locationlistener"));
    if (t.data("once")) {
        dict.keyvalue("once", 1);
    }
    if (t.data("stop")) {
        dict.keyvalue("stop", 1);
    }

    JsAdapter.LocationListener(dict.getDict()).Submit();
});

$("[js-mapmarkerpoint]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    var t = $(this);
    JsAdapter.MapMarkerPoint({ "lng": parseFloat(t.data("lng")), "lat": parseFloat(t.data("lat")), "title": t.data("title"), "zomm": t.data("zoom") }).Submit();
});

$("[js-mapselectpoint]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    var t = $(this);
    JsAdapter.MapSelectPoint().Submit();
});

$("[js-startupapp]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.StartUpApp($(this).attr("js-startupapp")).Submit();
});

$("[js-getpackagesign]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.GetPackageSign().Submit();
});

$("[js-getapplist]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.GetAppList().Submit();
});

$("[js-photocut]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.PhotoCut({ "url": $(this).attr("js-photocut") }).Submit();
});

$("[js-computedistance]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.ComputeDistance({ "url": $(this).attr("js-photocut") }).Submit();
});

$("[js-getversion]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.GetVersion().Submit();
});

$("[js-toastshow]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.ToastShow($(this).attr("js-toastshow")).Submit();
});

$("[js-browser]").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    JsAdapter.Browser($(this).attr("js-browser")).Submit();
});