﻿/// <reference path="jquery.min.js" />
/// <reference path="jquery.signalR.js" />

var RssOS = {
    "agent": (location.hostname + navigator.userAgent).toLowerCase().replace(/\s/img, ""),
    "os": "",
    "isios": false,
    "isandroid": false,
    "ispc": false,
    "parse": function () {
        this.os = this.agent.match(/windows|safari|localhost|android|iphone|ipad|ipod|rsseasy/) + "";
        switch (this.os) {
            case "iphone":
            case "ipad":
            case "ipod":
                this.os = "ios";
                this.isios = true;
                break;
            case "android":
                this.os = "android";
                this.isandroid = true;
                break;
            default:
                this.ispc = true;
                break;
        }
    }
}
RssOS.parse();

//验证方法集
var RssVerify = {}
var RssEasy = { "Deviceid": 1 };
var RssApp = { "UpFileApi": "", "LiVeUrl": "" };
var RssDialog = {}  //对话框

RssEasy.Debug = false;

function viod() {
    return false;
}
/******************************************Cookie******************************************/
var Cookie = {};
Cookie.Get = function (k) {
    if (document.cookie) {
        return document.cookie.replace(/; /img, ";").toKeyValue(";")[k] || false;
    }
}

//k:cookie文件，v:对应的值,n:保存天数,m:域
Cookie.Set = function (k, v, n, m) {
    v = v == undefined ? "" : ("" + v);
    var r = /^s?[\d\w\u4e00-\u9fa5]*$/img
    if (!k.match(r)) {
        return false;
    }
    n = n || "";
    if (n) {
        var d = new Date();
        d.setDate(d.getDate() + n);
        n = ";expires=" + (window.ActiveXObject ? d.toGMTString() : d);
    }
    m = m ? ";domain=" + m : "";
    document.cookie = k + "=" + v + ";path=/" + n + m;
    return true;
}
//移除指定的cookie
Cookie.Remove = function (k) {
    this.Set(k, "", -100);
}
//移除所有cookie
Cookie.RemoveAll = function () {
    var c = document.cookie.split("; ");
    var len = c.length
    for (var i = 0; i < len; i++) {
        this.Remove(c[i].split("=")[0]);
    }
}
//本地存储
var Storage = {};
Storage.Set = function (k, v) {
    this.remove(k);
    if (window.localStorage) {
        window.localStorage.setItem(k, v);
    } else {
        Cookie.Set(k, v, 360);
    }
}
Storage.Get = function (k) {
    return window.localStorage ? window.localStorage.getItem(k) : Cookie.Get(k);
}
Storage.remove = function (k) {
    if (window.localStorage) {
        window.localStorage.removeItem(k);
    } else {
        Cookie.Remove(k);
    }
}
Storage.setJson = function (k, json) {
    if (json.constructor == Object) {
        json = Object.toJson(json);
    }
    this.Set(k, json);
}
Storage.getJson = function (k, def) {
    return decodeURIComponent(this.Get(k) || def || "{}").toJson();
}
/******************************************以下扩展String对象的功能******************************************/
String.prototype.trimleft = function () {
    return this.replace(/^\s+/, "");
}
String.prototype.trimright = function () {
    return this.replace(/\s+$/, "");
}
String.prototype.trim = function () {
    return this.trimleft().trimright();
}
//解析到json数据格式
String.prototype.toJson = function () {
    return eval("(" + this + ")");
}

//删除HTML标识
String.prototype.delHtml = function () {
    return this.replace(/<.+?>/img, "");
}
//获取实体字符
String.prototype.getEntity = function () {
    var t = "";
    var len = this.length;
    for (var i = 0; i < len; i++) {
        t = t + "&#" + this.charCodeAt(i) + ";";
    }
    return t;
}
String.prototype.toFixed = function (precision) {
    return parseFloat(this).toFixed(precision);
}
//把字符串中指定的字符串替换成实体字符
String.prototype.toEntity = function () {
    var len = arguments.length;
    var t = this;
    for (var i = 0; i < len; i++) {
        t = t.replace(new RegExp(arguments[i], "img"), arguments[i].getEntity())
    }
    return t;
}
//把字符串日期转换为中文日期格式
String.prototype.toDateCn = function () {
    return this.ParseDate().toDateCn();
}
//把KeyValue对的字符串转换成对象
String.prototype.toKeyValue = function (s) {
    if (!this.replace(/\s/img, "")) {
        return {};
    }
    var arr = this.split(s || "&");
    var len = arr.length;
    var obj = {};
    for (var i = 0; i < len; i++) {
        var tmp = arr[i].split("=");
        obj[decodeURIComponent(tmp[0])] = decodeURIComponent(tmp[1]);
    }
    return obj;
}
String.prototype.round = function (num) {
    var t = parseFloat(isNaN(this) ? 0 : this).round(num);
    t = t + 1 / Math.pow(10, num + 1) + "";
    return t.substring(0, t.indexOf(".") + num + 1);
}
String.prototype.idcard = function (uppercase) {
    return this + (this.length > 17 ? "" : (uppercase ? "X" : "x"));
}
String.prototype.padleft = function (total, char) {
    var len = this.length;
    var t = this;
    char = char || '0';
    len = total - len;
    var s = "";
    for (var i = 0; i < len; i++) {
        s += char;
    }
    return s + t;
}
String.prototype.padright = function (total, char) {
    var len = this.length;
    var t = this;
    char = char || '0';

    len = total - len;
    var s = "";
    for (var i = 0; i < len; i++) {
        s += char;
    }
    return t + s;
}
String.prototype.ParseDate = function () {
    try {
        var re = /\d+/img;
        var ds = this.match(re);
        ds[1] = ds[1] - 1;
        return new Date(parseInt(ds[0]), parseInt(ds[1]), parseInt(ds[2]), parseInt(ds[3]) || 0, parseInt(ds[4]) || 0, parseInt(ds[5]) || 0);
    } catch (e) {
        return new Date();
    }
}
String.prototype.trans = function (precision) {
    return parseFloat(this).trans(precision);
}
String.prototype.tomoney = function (def, capital) {
    var str = "";
    var money = this.match(/^\d/) && this.indexOf(".") == -1 ? this + ".00" : this;
    var split = money.split(".");
    if (capital) {
        var daxie = ["零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖", "拾"];
        var upper = ["亿", "万", "仟", "佰", "拾", "兆", "万", "仟", "佰", "拾", "亿", "仟", "佰", "拾", "万", "仟", "佰", "拾", "元", "角", "分"].reverse();
        var len = split[0].length;
        for (var i = 0; i < len; i++) {
            str += daxie[split[0].substr(i, 1)] + upper[len - i + 1];
        }
        for (var i = 0; i < 2; i++) {
            str += daxie[split[1].substr(i, 1)] + upper[1 - i];
        }
    } else {
        if (split[0]) {
            var re = /(\d{1,3})?(\d{3})?(\d{3})?(\d{3})?(\d{3})?$/;
            var arr = re.exec(split[0]);
            if (arr) {
                arr.splice(0, 1);
                str = arr.toString();
            }
        }
        if (split[1]) {
            var re = /^(\d{3})?(\d{3})?(\d{3})?(\d{3})?(\d{1,3})?/;
            var arr = re.exec(split[1]);
            if (arr) {
                arr.splice(0, 1);
                str += "." + arr.toString();
            }
        }
        str = str.replace(/,{2,}/g, ",").replace(",.", ".").replace(".,", ".");
    }
    return str || def || "0.00";
}

//时间相减
Date.prototype.subtract = function (dt) {
    if (typeof dt == "string") {
        dt = dt.ParseDate();
    }
    return new Date((this - dt) - 28800000);
}
Date.prototype.addYear = function (yeah) {
    return this.setFullYear(this.getFullYear() + yeah);
}
Date.prototype.addMonth = function (mon) {
    return this.setMonth(this.getMonth() + mon);
}
Date.prototype.addDay = function (day) {
    return this.setDate(this.getDate() + day);
}
Date.prototype.addHour = function (hour) {
    return this.setHours(this.getHours() + hour);
}
Date.prototype.addMinutes = function (min) {
    return this.setMinutes(this.getMinutes() + min);
}
Date.prototype.addSeconds = function (sec) {
    return this.setSeconds(this.getSeconds() + sec);
}
Date.prototype.addMilliseconds = function (sec) {
    return this.setMilliseconds(this.getMilliseconds() + sec);
}
Date.prototype.getCnWeek = function () {
    var week = ['日', '一', '二', '三', '四', '五', '六'];
    return week[this.getDay()];
}
//获取每月1号的星期数
Date.prototype.getFirstDayWeek = function () {
    var dt = this.toString().ParseDate();
    dt.setHours(0, 0, 0, 0);
    dt.setDate(1);
    return dt.getDay();
}
//获取上一月的天数
Date.prototype.getPreMonthDay = function () {
    var dt = this.toString().ParseDate();
    dt.setHours(0, 0, 0, 0);
    dt.setDate(1);
    dt.setDate(dt.getDate() - 1);
    return parseInt(dt.getDate());
}
//获取下一月的天数
Date.prototype.getNextMonthDay = function () {
    var dt = this.toString().ParseDate();
    dt.setHours(0, 0, 0, 0);
    dt.setDate(1);
    dt.setMonth(dt.getMonth() + 2);
    dt.setDate(dt.getDate - 1);
    return parseInt(dt.getDate());
}
//获取每月中的最大天数
Date.prototype.getMaxDay = function () {
    var dt = this.toString().ParseDate();
    dt.setHours(0, 0, 0, 0);
    dt.setDate(1);
    dt.setMonth(dt.getMonth() + 1);
    dt.setDate(dt.getDate() - 1);
    return parseInt(dt.getDate());
}
//获取上一月
Date.prototype.getPreMonth = function () {
    var dt = this.toString("yyyy-MM-dd").ParseDate();
    dt.setDate(1);
    dt.setMonth(dt.getMonth() - 1);
    return dt;
}
//获取时间戳
Date.prototype.getTimestamp = function () {
    return parseInt(this.getTime() / 1000);
}
//获取下一月
Date.prototype.getNextMonth = function () {
    var dt = this.toString("yyyy-MM-dd").ParseDate();
    dt.setDate(1);
    dt.setMonth(dt.getMonth() + 1);
    return dt;
}
//format:yyyy*MM*dd HH*mm*ss*ms
Date.prototype.toString = function (ft) {
    ft = ft || "yyyy-MM-dd HH:mm:ss";
    var tmp = {
        "yyyy": this.getFullYear(),
        "yy": this.getFullYear().toString().substring(2),
        "MM": this.getMonth() + 1,
        "dd": this.getDate(),
        "HH": this.getHours(),
        "hh": this.getHours(),
        "mm": this.getMinutes(),
        "ss": this.getSeconds(),
        "ms": this.getMilliseconds()
    }
    for (var key in tmp) {
        var val = tmp[key];
        if (val.toString() < 10) {
            val = "0" + val;
        }
        ft = ft.replace(key, val);
    }
    return ft;
}

Date.prototype.toDateCn = function (format) {
    var rt = new Date().subtract(this);
    if (rt.getFullYear() > 1970) {
        return this.toString(format);
    }
    if (rt.getMonth() >= 3) {
        return this.toString("MM月dd日 hh:mm");
    }
    var d = rt.getDate();
    if (d == 2) {
        return this.toString("前天 hh:mm");
    }
    if (d == 1) {
        return this.toString("昨天 hh:mm");
    }
    var h = rt.getHours();
    if (h > 1 && h < 24) {
        return this.toString("今天 hh:mm");
    }
    var s = rg.getSeconds();
    if (s > 1 && s < 60) {
        return s + "秒前";
    }
    return "刚刚"
}
Number.prototype.round = function (num) {
    var pow = Math.pow(10, num);
    return Math.round(this * pow) / pow;
}
Number.prototype.floor = function (num) {
    var pow = Math.pow(10, num);
    return Math.floor(this * pow) / pow;
}
Number.prototype.tomoney = function (def) {
    return this.toString().tomoney(def);
}
Number.prototype.trans = function (precision) {
    precision = precision || 0;
    var tmp = this.toFixed(precision), len = tmp.indexOf("."), tmp = len > 0 ? tmp.substring(0, len) : tmp;
    if (this < 10000) {
        return this.toFixed(precision);
    }
    len = Math.floor(tmp.length / 4);
    var unit = ["", "万", "亿", "兆"];
    return (this / Math.pow(10000, len)).toFixed(precision) + unit[len];
}

//URL处理
var Url = self.location.search.replace(/^\?/, "").toKeyValue();

Object.HasChild = function (obj) {
    for (var key in obj) {
        return true;
    }
    return false;
}
Object.Query = function (obj, where) {
    try {
        if (!obj) {
            return {};
        }
        if (!where) {
            return obj;
        }
        var ret = {}
        switch (where.constructor) {
            case Array:
                var re = where[1];
                if (where[1].constructor != RegExp) {
                    re = new RegExp("^" + where[1] + "$", "img");
                }
                for (var o in obj) {
                    if (obj[o][where[0]].toString().match(re)) {
                        ret[o] = obj[o];
                    }
                }
                break;
            case Number:
            case String:
                for (o in obj) {
                    if (obj[o] == where) {
                        ret[o] = obj[o];
                    }
                }
                break;
            case Object:
                for (var key in where) {
                    var re = where[key];
                    if (where[key].constructor != RegExp) {
                        re = new RegExp("^" + where[key] + "$", "img");
                    }
                    for (var o in obj) {
                        if (obj[o][key].toString().match(re)) {
                            ret[o] = obj[o];
                        }
                    }
                }
                break;
            default:
                ret = obj;
        }
        return ret;
    } catch (e) {
        alert("在对像查询中出现错误：" + where + "," + e.messaage);
    }
}
Object.toJson = function (obj, where) {
    if (!obj) {
        return null;
    }
    if (obj.constructor == Array) {
        return Array.toJson(obj);
    }
    if (where) {
        obj = this.Query(obj, where);
    }
    var tmp = "";
    var key = null;
    var value = null;
    for (key in obj) {
        value = obj[key] == null || obj[key] === undefined ? "" : obj[key];

        key = '"' + key + '"';
        switch (value.constructor) {
            case String:
                value = '"' + value.toEntity('"') + '"';
                break;
            case Array:
                value = Array.toJson(value);
                break;
            case Boolean:
                value = true ? "true" : "false";
                break;
            case Object:
                value = Object.toJson(value);
                break;
        }
        tmp += key + ":" + value + ",";
    }
    if (tmp.length > 1) {
        tmp = tmp.substring(0, tmp.length - 1);
    }
    return "{" + tmp + "}";
}
Object.toQueryString = function (obj) {
    var query = [];
    $.each(obj, function (key, val) {
        query.push(key + "=" + encodeURIComponent(val));
    });
    return query.join("&");
}

Object.Count = function (obj, filter) {
    var count = 0;
    if (filter) {
        obj = this.Query(obj, filter);
    }
    for (var key in obj) {
        count++;
    }
    return count;
}

Object.format = function (dict, format) {
    $.each(dict, function (key, val) {
        if (format[key]) {
            dict[key] = format[key](val);
        }
    });
    return dict;
}
Object.fieldmap = function (data, field) {
    var tmp = {};
    switch (typeof data) {
        case "array":
            tmp = [];
            $.each(data, function (idx, obj) {
                var t = {};
                $.each(obj, function (key, val) {
                    t[field[key] || key] = val;
                });
                tmp.push(t);
            });
            break;
        case "object":
            $.each(data, function (key, val) {
                tmp[field[key] || key] = val;
            });
            break;
    }
    return tmp;
}

Array.IsExist = function (arr, val) {
    var len = arr.length;
    for (var i = 0; i < len; i++) {
        if (arr[i] == val) {
            return i;
        }
    }
    return false;
}
//把数据中的元素值转换成对象的属性名，属性对应值为数组索引号
Array.toKeyValue = function (arr) {
    var t = {};
    var len = arr.length;
    for (var i = 0; i < len; i++) {
        t[arr[i]] = i + 1;
    }
    return t;
}
Array.toJson = function (arr, where) {
    var tmp = "";
    var value = null;
    var len = arr.length;

    for (var i = 0; i < len; i++) {
        value = arr[i];
        if (!isNaN(value)) {
            value = parseInt(value) || value;
        }
        switch (value.constructor) {
            case Number:
                break;
            case String:
                value = '"' + value.toEntity('"') + '"';
                break;
            case Array:
                value = Array.toJson(value);
                break;
            case Object:
                value = Object.toJson(value);
                break;
            default:
                value = '"' + value.toString().toEntity('"') + '"';
                break;
        }
        tmp += value + ",";
    }
    if (tmp.length > 1) {
        tmp = tmp.substring(0, tmp.length - 1);
    }
    return "[" + tmp + "]";
}

function scrollBarTop(top, el) {
    if (!el) {
        el = "html,body";
    }
    $(el).animate({ "scrollTop": top }, 500);
}

//
$("[contenteditable]").keydown(function (ev) {
    if (ev.keyCode === 9) {
        ev.preventDefault();
    }
});

//jquery扩展
jQuery.fn.extend({
    "selectcascade": function ()  //级联
    {
        $(this).each(function () {
            var t = $(this), datadict = dictdata[t.attr("selectcascade")] || {}, dataname = (t.attr("dict-name") || "").split(','), dataval = (t.attr("dict-val") || "").split(',');

            function create(pid) {
                var data = Object.Query(datadict, [1, pid]), html = "";
                $.each(data, function (k, v) {
                    html += '<option value="' + k + '">' + v[0] + '</option>';
                });
                if (html.length == 0) {
                    return;
                }
                var select = t.find("select"), len = select.length, name = dataname[len];
                if (!name) {
                    name = dataname[0];
                    select.removeAttr("name");
                }
                select = $('<select name="' + name + '"></select>');
                select.html(html);
                t.append(select);
                select.change(function () {
                    var t = $(this);
                    while (t.next().length) {
                        t.next().remove();
                    }
                    create(this.value);
                });
                if (select.find("option[value='" + dataval[len] + "']").length) {
                    select.val(dataval[len]);
                }
                select.change();
            }
            create(0);
        });
    },
    "vcenter": function () //垂子居中
    {
        $(this).each(function () {
            var t = $(this), pt = t.parent(), th = t.height(), pth = pt.height();
            t.css("margin-top", (pth - th) / 2);
        });
        return $(this);
    },
    "dictparse": function () {
        $(this).each(function () {
            var t = $(this), k = t.attr("dictparse"), dict = dictdata[k] || {}, val = (t.attr("dict-val") || "").split(','), split = t.attr("dict-split") || "", data = [], prifix = t.attr("prefix") || "";
            $.each(val, function (i, v) {
                v = dict[v] || v;
                if (v.constructor == Array) {
                    v = v[0];
                }
                data.push(v);
            });
            switch (t.attr("dict-tag")) {
                case "checkbox":
                case "radio":
                    $('[name=' + k + ']').val(data);
                    return true;
            }
            data = prifix + data.join(split);
            switch (this.tagName.toLowerCase()) {
                case "select":
                case "input":
                    t.val(data);
                    break;
                default:
                    t.html(data);
                    break;
            }
        });
    },
    "binddict": function (dict) {  //绑定词典数据
        return $(this).each(function () {
            var t = $(this), tag = "";
            $.each(dict, function (key, val) {
                tag = t.find("[" + key + "]");
                if (tag.length) {
                    switch (tag.get(0).tagName.toLowerCase()) {
                        case "select":
                        case "input":
                            tag.val(val);
                            break;
                        default:
                            tag.html(val);
                            break;
                    }
                }
            });
        });
    },
    "lazyload": function ()  //图片按需加载
    {
        var that = $(this);
        that.scroll(function () {
            lazyload();
        });
        $(document).ready(function () {
            lazyload();
        });

        var height = that.height() + (scroller ? that.offset().top : 0);
        function lazyload() {
            var top = that.scrollTop();
            var viewbottom = top + height;
            var queue = that.find("[lazyload]");
            queue.each(function () {
                var offsetTop = $(this).offset().top;
                if (offsetTop >= top && offsetTop < viewbottom) {
                    var _t = $(this);
                    var img = new Image();
                    img.onload = function () {
                        if (_t[0].tagName.toLowerCase() == "img") {
                        } else {
                            _t.attr("src", img.src);
                        }

                        img = null;
                    }
                    img.src = _t.attr("lazyload");
                    _t.removeAttr("lazyload");
                }
            });
            queue = null;
        }
    },
    "horizontalslip": function () {
        $(this).each(function () {
            var t = $(this), width = 0;  //
            var params = t.attr("horizontalslip").split(",");
            var action = t.find(params[0]);
            var target = $("#" + params[1]);
            target.find(">*").each(function (i) {
                $(this).attr("idx", i);
            });
            var style = params[2];
            if (params[3] == "auto") {
                $(window).resize(resize);
            }
            var itemcount = action.length;
            var time = parseInt(params[4] || 1000);
            target.show();

            function resize() {
                width = parseInt(params[3]) || t.width();
                target.find(">*").width(width);
                target.width(itemcount * width);
                action.eq(curidx).mouseover();
            }
            resize();
            var autotime = parseInt(params[5] || 0);
            var tick = null;
            var curidx = 0;
            action.mouseover(function (e) {
                curidx = $(this).index();
                action.removeClass(style);
                $(this).addClass(style);
                var idx = target.find("[idx=" + curidx + "]").index();
                var marginleft = -idx * width;
                target.stop();
                target.animate({ marginLeft: marginleft }, time, function () {
                    for (var i = 0; i < idx; i++) {
                        target.append(target.find(">*").first());
                    }
                    target.css({ "margin-left": 0 });
                });
            }).mouseout(autoloop).mousemove(function (e) {
                e.stopPropagation();
                if (tick) {
                    clearInterval(tick);
                    tick = null;
                }
            });
            target.mouseover(function (e) {
                e.stopPropagation();
                if (tick) {
                    clearInterval(tick);
                    tick = null;
                }
            }).mouseout(autoloop);
            if (params[6]) {
                $("#" + params[6]).click(function () {
                    action.eq(++curidx).mouseover();
                });
            }
            if (params[7]) {
                $("#" + params[7]).click(function () {
                    action.eq(--curidx).mouseover();
                });
            }
            function autoloop() {
                if (autotime > 0 && !tick) {
                    tick = setInterval(function () {
                        if (++curidx >= itemcount) {
                            curidx = 0;
                        }
                        action.eq(curidx).mouseover();
                    }, autotime);
                }
            }
            autoloop();
        });
    },
    "loopslip": function () {
        $(this).each(function () {
            var t = $(this), width = 0, autotime = 0;  //
            var params = t.attr("loopslip").split(",");
            autotime = parseInt(params[3] || 0);
            var target = $("#" + params[0]);
            target.show();
            if (params[1] == "auto") {
                $(window).resize(resize);
            }
            function resize() {
                width = parseInt(params[1]) || target.parent().width();
                target.find(">*").width(width);
                target.width(target.find(">*").length * width);
            }
            resize();
            var time = parseInt(params[2] || 1000);
            var loopleft = t.find("[loopleft]");
            var loopright = t.find("[loopright]");
            var cur = loopright;
            var digitlist = t.find("#" + params[4] + ">*");
            t.find("[loopleft]").click(function () {
                cur = loopleft;
                target.stop(false, true);
                digitno();
                target.animate({ "margin-left": -width }, time, function () {
                    var item = target.find(">*");
                    target.append(item.first());
                    target.css({ "margin-left": 0 });
                    autoclick();
                });
            });
            t.find("[loopright]").click(function () {
                cur = loopright;
                var item = target.find(">*");
                var last = item.last();
                last.insertBefore(item.first());
                target.css({ "margin-left": -width });
                target.stop();
                digitno();
                target.animate({ "margin-left": 0 }, time, function () {
                    autoclick();
                });
            });
            function digitno() {
                if (digitlist.length) {
                    digitlist.removeClass();
                    digitlist.eq(target.find(">*").first().attr("idx")).addClass("selected");
                }
            }
            var tick = null;
            function autoclick() {
                if (autotime > 0) {
                    if (tick) {
                        clearTimeout(tick);
                        tick = null;
                    }
                    tick = setTimeout(function () {
                        cur.click();
                    }, autotime);
                }
            }
            autoclick();
        });
    },
    "verticalslip": function () {
        $(this).each(function () {
            var t = $(this);
            var params = t.attr("verticalslip").split(",");
            var action = t.find(params[0]);
            var itemcount = action.length;
            var target = $("#" + params[1]);
            var style = params[2];
            var height = 0;
            if (params[3] == "auto") {
                $(window).resize(resize);
            }
            function resize() {
                height = parseInt(params[3]) || target.find(">*").first().height();
                target.parent().height(height);
            }
            resize();
            var time = parseInt(params[4] || 1000);
            var curidx = 0, tick = null;
            action.mouseover(function () {
                e.stopPropagation();
                if (tick) {
                    clearTimeout(tick);
                    tick = null;
                }
                curidx = $(this).index();
                action.removeClass(style);
                $(this).addClass(style);
                target.stop();
                var margintop = -curidx * height;
                target.animate({ marginTop: margintop }, time, function () {
                    autoloop();
                });
            });
            if (params[6]) {
                $("#" + params[6]).click(function () {
                    action.eq(++curidx).mouseover();
                });
            }
            if (params[7]) {
                $("#" + params[7]).click(function () {
                    action.eq(--curidx).mouseover();
                });
            }
            function autoloop() {
                if (autotime > 0) {
                    tick = setTimeout(function () {
                        if (++curidx >= itemcount) {
                            curidx = 0;
                        }
                        action.eq(curidx).mouseover();
                    }, autotime);
                }
            }
            autoloop();
        });
    },
    "switchslip": function ()  //幻灯切换
    {
        $(this).each(function () {
            var t = $(this);
            var params = t.attr("switchslip").split(",");
            var action = t.children();
            var target = $("#" + params[0]).find(">*");
            var style = params[1];
            var time = parseInt(params[2] || 1000);
            var curel = target.first();
            action.mouseover(function (ev) {
                ev.stopPropagation();
                action.removeClass(style);
                curel = $(this).addClass(style);
                target.fadeOut(time).eq(curel.index()).fadeOut(0).stop(false, true).fadeIn(time);
            });
            action.first().mouseover();
            var auto = parseInt(params[3] || 0);

            if (auto > 0 && action.length > 1) {
                var tick = null;
                function autotask() {
                    tick = setInterval(function () {
                        var next = curel.next();
                        if (!next.length) {
                            next = action.first();
                        }
                        next.mouseover();
                    }, auto + time);
                }
                action.parent().mouseover(function () {
                    if (tick) {
                        clearInterval(tick);
                    }
                }).mouseleave(function () {
                    autotask();
                });
                autotask();
            }
        });
    },
    "tabswitch": function ()  //标签切换
    {
        $(this).each(function () {
            var t = $(this);
            var params = t.attr("tabswitch");
            var action = t.find(">li");
            var target = $("#" + params).find(">*");
            target.hide();
            action.click(function (e) {
                e.preventDefault();
                var _t = $(this);
                action.removeClass("current");
                _t.addClass("current");
                target.hide();
                target.eq(_t.index()).show();
            });
            action.first().click();
        });
    },
    "scrolltoel": function ()  //滚动到元素
    {
        $(this).click(function () {
            var scrolltoel = $(this).attr("scrolltoel").split(",");
            scrollBarTop($("#" + scrolltoel[0]).offset().top + parseInt(scrolltoel[1] || 0))
        });
    },
    "backtotop": function () //滚动到顶部
    {
        $(this).click(function () {
            scrollBarTop(0);
        });
    },
    "underline": function () {
        $(this).each(function () {
            var t = $(this);
            var params = t.attr("underline").split(",");
            var action = t.find(params[0]);
            var target = $("#" + params[1]);
            target.show();
            var time = parseInt(params[2] || 200);
            var pad = parseInt(params[3]) || 0, _t = action.first();
            action.mouseover(function (e) {
                _t = $(this);
                target.stop();
                target.animate({ "left": _t.offset().left - pad / 2, "width": _t.outerWidth() + pad }, time);
            });
            action.eq(params[4] || 0).mouseover();
            $(window).resize(function () {
                target.css("left", _t.offset().left - pad / 2);
            });
        });
    },
    "touchslide": function () {  //滑动事件
        return this.each(function () {
            var t = $(this), pt = t.parent(), slidezoom = parseInt(t.attr("slidezoom")) ? true : false, zindex = parseInt(t.css("z-index")) ? true : false, offset = t.offset(), left = offset.left, top = offset.top, zoom = 1, scale = 1;

            if (slidezoom) {
                t.on("mouseover.rsseasy", function (e) {
                    t.on("mousewheel.rsseasy", function (e) {
                        if (e.deltaY > 0) {
                            zoom += 0.1;
                        }
                        else {
                            zoom -= 0.1;
                        }
                        data = { "zoom": zoom };
                        t.trigger("slidezoom", data);
                    });
                }).on("mouseout.rsseasy", function (e) {
                    t.off('mousewheel.rsseasy');
                });
            }
            t.on('touchstart.rsseasy mousedown.rsseasy', function (e) {
                var ev = e.type == 'touchstart' ? e.originalEvent.touches[0] : e,
                    startX = ev.pageX,  //鼠标点到文档左边的距离
                    startY = ev.pageY,  //鼠标点到文档顶边的距离
                    offset = t.offset(),
                    posleft = startX - offset.left,
                    postop = startY - offset.top,
                    ex = 0, ey = 0,
                    height = t.height(),
                    width = t.width(),
                    zoomx = 0, zoomscale = 0,
                    direction = "";
                data = { "left": offset.left, "top": offset.top, "pageX": ev.pageX, "pageY": ev.pageY, "touch": e.type == "touchstart" };

                if (pt.attr("zindex")) {
                    t.css("z-index", 1000);
                }
                if (e.type == 'touchstart' && e.originalEvent.touches.length > 1) {
                    zoomx = parseInt(Math.abs(e.originalEvent.touches[0].pageY - e.originalEvent.touches[1].pageY) * 100) / 100;
                }

                t.trigger("slidestart", data);

                t.parent().on('touchmove.rsseasy mousemove.rsseasy mousewheel.rsseasy', function (e) {
                    var ev = e.type == 'touchmove' ? e.originalEvent.touches[0] : e;
                    ex = ev.pageX,
                    ey = ev.pageY,

                    mx = ex - startX,
                    my = ey - startY,

                    data = { "left": ex - posleft - left, "top": ey - postop - top, "moveX": mx, "moveY": my };

                    mx = Math.abs(ex - startX);
                    my = Math.abs(ey - startY);

                    if (slidezoom && e.type == 'touchmove' && e.originalEvent.touches.length > 1) {
                        var sx = Math.abs(e.originalEvent.touches[0].pageY - e.originalEvent.touches[1].pageY);
                        if (zoomx > 0 && Math.abs(sx - zoomx) > 4) {
                            zoomscale = parseInt(sx / zoomx * 100) / 100;
                            data = { "zoom": scale + zoomscale };
                            t.trigger("slidezoom", data);
                        }
                    } else {
                        t.trigger("slidemove", data);
                        if (!direction) {
                            if (mx > 2) {
                                direction = "xaxis";
                            }
                            if (my > 2) {
                                direction = 'yaxis';
                            }
                        }
                        if (direction) {
                            t.trigger("slide" + direction, data);
                        }
                    }
                });

                t.parent().on('touchend.rsseasy mouseup.rsseasy', function (e) {
                    direction = "";
                    scale = scale + zoomscale;
                    if (Math.ceil(scale) >= 2) {
                        scale -= 1;
                    }
                    t.css("z-index", zindex);
                    t.trigger("slideend", data);

                    t.parent().off('.rsseasy');
                });
            });
        });
    },
    "pageslide": function () {
        return $(this).each(function (idx) {
            var t = $(this); wrap = t.parent(), items = t.children();
            var opt = { "dis": parseInt(t.attr("dis") || 60), "auto": parseInt(t.attr("auto") || 0), "speed": parseInt(t.attr("speed") || 1000) };
            var marginleft = 0, itemwidth = wrap.outerWidth() || $(window).width(), totalpage = items.length, wrapwidth = totalpage * itemwidth, curpage = 0;
            items.width(itemwidth);
            t.width(itemwidth * totalpage);

            t.on("slidexaxis", function (ev, json) {
                $(this).css("margin-left", json["left"]);
            }).on("slideend", function (ev, json) {
                var left = json["left"];
                if (Math.abs(left) > opt.dis) {
                    curpage = Math.abs(left / itemwidth);
                    curpage = json["moveX"] > 0 ? Math.floor(curpage) : Math.ceil(curpage);
                    if (curpage >= totalpage) {
                        curpage = totalpage - 1;
                    }
                }
                marginleft = -curpage * itemwidth;
                $(this).animate({ "margin-left": marginleft }, 200);
                t.trigger("pageslideend", { "totalpage": totalpage, "curpage": curpage + 1 });
            }).touchslide();
            if (opt.auto > 0) {
                items.each(function (idx) {
                    $(this).attr("idx", idx);
                });
                var tick = null;
                t.on("slidestart", function (ev, json) {
                    t.stop();
                    if (tick) {
                        clearTimeout(tick);
                        tick = null;
                    }
                });
                function autoloop() {
                    if (totalpage < 2) {
                        t.trigger("slidestart")
                        return;
                    }
                    if (curpage >= totalpage) {
                        curpage = 0;
                    }
                    tick = setTimeout(function () {
                        t.stop().animate({ "margin-left": -itemwidth }, opt.speed, function () {
                            var first = t.find(":first");
                            t.append(first);
                            t.css("margin-left", 0);
                            t.trigger("pageslideend", { "totalpage": totalpage, "curpage": parseInt(t.find(":first").attr("idx")) + 1 });
                            curpage++;
                            autoloop();
                        });
                    }, opt.auto + opt.speed);
                }
                t.on("slideend", function () {
                    autoloop();
                })
                autoloop();
            }
        });
    },
    "selectslide": function () {
        return $(this).each(function () {
            var t = $(this), first = t.children().first(), initpage = parseInt(t.attr("selectslide") || 0), data = dictdata[t.attr("dict")], dis = t.attr("dis") || 20, fixed = t.attr("fixed") ? true : false, index = 0;
            if (data) {
                var html = '';
                $.each(data, function (key, val) {
                    html += '<li key="' + key + '">' + val + '</li>';
                });
                first.html(html);
            }
            var th = t.innerHeight(), items = first.children(), itemheight = items.outerHeight(), totalitem = items.length, wrapheight = totalitem * itemheight, h = (th - itemheight) / 2, margintop = -initpage * itemheight;

            // items.height(items.first().innerHeight());
            first.css({ "transform": "translateY(" + h + "px)", "-webkit-transform": "translateY(" + h + "px)", "margin-top": margintop });

            t.on("slidestart", function (ev, json) {
                t.trigger("selectslidestart", json);
                margintop = parseInt(first.css("margin-top")) || 0;
            }).on("slideyaxis", function (ev, json) {
                var top = margintop + json["moveY"];
                if (fixed && (top >= 0 || Math.abs(top) >= wrapheight - itemheight)) {
                    return;
                }
                first.css("margin-top", top);
                t.trigger("selectslidemove", json);
            }).on("slideend", function (ev, json) {
                if (Math.abs(json["moveY"]) > dis) {
                    index = margintop > 0 ? 0 : Math.abs((margintop + json["moveY"]) / itemheight);

                    index = json["moveY"] > 0 ? Math.floor(index) : Math.ceil(index);

                    if (index >= totalitem) {
                        index = totalitem - 1;
                    }
                }
                margintop = -index * itemheight;
                first.animate({ "margin-top": margintop }, 200);
                $.extend(json, { "source": t, "totalitem": totalitem, "idx": index, "value": items.eq(index).attr("value"), "text": items.eq(index).text() });
                t.attr("value", json["value"]);

                t.trigger("selectslideend", json);
            });
            t.trigger("selectslideready", this);
        }).touchslide()
    },
    "slideajax": function () {
        return $(this).each(function () {
            var t = $(this);
            var margintop = 0, wrapheight = 0, sroller = t.children().first(), srollerheight = 0, dis = parseInt(t.attr("dis") || 32), top = 0, bottom = t.attr("bottom"), scrtop = 0, touch = false;

            t.on("slidestart", function (ev, json) {
                touch = json["touch"];
                t.append(RssWin.AjaxLoad);
                scrtop = t.scrollTop();
            }).on("slidemove", function (ev, json) {
                scrtop = t.scrollTop();
                top = json["moveY"];

                t.addClass("load");
                RssWin.AjaxLoad.hide();
                if (top > 0 && scrtop < dis / 2) {
                    if (top > dis) {
                        top = dis;
                        t.removeClass("load");
                        RssWin.AjaxLoad.show();
                    }
                    sroller.css("margin-top", top);
                    return;
                }
            }).on("slideend", function (ev, json) {
                top = json["moveY"];
                if (top > 0 && scrtop < dis / 2) {
                    sroller.css("margin-top", 0)
                    if (top > dis) {
                        t.trigger("ajaxupdate", json);
                    }
                }
                //t.trigger("ajaxload", json);
            }).touchslide();
        });
    }
});

$("[horizontalslip]").horizontalslip();
$("[verticalslip]").verticalslip();
$("[backtotop]").backtotop();
$("[scrolltoel]").scrolltoel();
$("[switchslip]").switchslip();//slideslip
$("[tabswitch]").tabswitch();
$("[loopslip]").loopslip();
$("[underline]").underline();
$("[pageslide]").pageslide();

jQuery.fn.extend({
    "mapjson": function (json, parse) {
        var t = $(this);
        $.each(parse, function (key, val) {
            if (json[key]) {
                json[key] = val(json[key]);
            }
        });
        if (json["id"]) {
            json["rssid"] = json["id"];
        }
        if (json["name"]) {
            json["rssname"] = json["name"];
        }
        t.find("[bindkeys]").each(function () {
            var t = $(this), bindkeys = t.attr("bindkeys").split(","), vals = [];
            $.each(bindkeys, function (idx, val) {
                vals.push(json[val] === undefined ? val : json[val] || "");
            });
            t.html(vals.join(""));
        });
        t.find("[bindattr]").each(function () {
            var t = $(this), attrs = t.attr("bindattr").split(",");
            $.each(attrs, function (idx, val) {
                t.removeAttr(val);
            });
        });
        $.each(json, function (key, val) {
            if (key === "id" || key === "name") {
                return;
            }
            if (t.attr(key)) {
                t.attr(key, val);
            }
            t.find('[' + key + ']').each(function () {
                var tag = $(this);
                var length = parseInt(tag.attr("len")) || 0;
                if (length && val.length > length) {
                    val = val.substr(0, length);
                }
                var attr = tag.attr(key);
                if (attr) {
                    val = attr.replace(/(\{\w+?\})/ig, function (k) {
                        k = k.replace(/[\{\}]/ig, "");
                        return json[k];
                    });
                }
                switch (tag.get(0).tagName.toLowerCase()) {
                    case "input":
                        switch (tag.attr("type")) {
                            case "checkbox":
                            case "radio":
                                tag.val(val.split(','))
                                break;

                        }
                    case "select":
                    case "textarea":
                        tag.val(val);
                        break;
                    case "img":
                    case "audio":
                    case "video":
                    case "iframe":
                        tag.attr("src", RssApp.UpHost + val);
                        break;
                    default:
                        tag.html(val);
                        break;
                }
            });
        });
        t.find("[bindattr]").each(function () {
            var t = $(this), attrs = t.attr("bindattr").split(",");
            $.each(attrs, function (idx, val) {
                t.attr(val, json[val] || "");
            });
        });
        t.trigger("mapjson");
        return t;
    },
    "mapitem": function (json, parse, isappend) {
        var t = $(this);
        if (!t.data("rsstemp")) {
            t.data("rsstemp", t.html());
        }
        if (!isappend) {
            t.empty();
        }
        var querykey = t.attr("querykey");
        querykey = querykey ? querykey.split(",") : []
        $.each(json, function (idx, rows) {
            var el = $(t.data("rsstemp"));
            el.mapjson(rows, parse);
            t.append(el);
            el.click(function () {
                if (querykey.length) {
                    var map = {}
                    $.each(querykey, function (idx, val) {
                        map[val] = rows[val] || "";
                    });
                    $("#" + (rows["mappage"] || t.attr("mappage"))).data("query", map);
                }
            });
            var dataid = el.attr("dataid");
            if (dataid) {
                el.attr("dataid", rows[dataid]);
            }
            el.show();
        });
        t.trigger("mapitem");
        return t;
    },
    "maphtml": function (json, parse) {
        $(this).each(function () {
            var t = $(this);
            t.html(t.html().replace(/({\w+?})/img, function (k) {
                k = json[k.replace(/[\{\}]/ig, "")];
                return parse[k] || k;
            }));
        });
    },
    "mapview": function (json, parse, isappend) {
        return $.isArray(json) ? this.mapitem(json, parse, isappend) : this.mapjson(json, parse);
    },
    "mapselect": function (json) {
        var t = $(this), value = t.attr("value"), text = t.attr("text"), html = "";
        $.each(json, function (idx, rows) {
            html += '<option value="' + rows[value] + '">' + rows[text] + '</option>'
        });
        t.html(html);
        return t;
    },
    "mapradio": function (json, wrap) {
        return $(this).html(RssHtml.KeyValueArr.Radio(json, { "wrap": wrap, "name": t.attr("name"), "value": t.attr("value"), "text": t.attr("text") }));
    },
    "mapcheckbox": function (json, wrap) {
        var t = $(this), name = t.attr("name"), value = t.attr("value"), text = t.attr("text"), html = "";
        if (wrap) {
            $.each(json, function (idx, rows) {
                html += '<label for="' + name + rows[value] + '"><input type="checkbox" id="' + name + rows[value] + '" name="' + name + '" value="' + rows[value] + '" />' + rows[text] + '</label>'
            });
        } else {
            $.each(json, function (idx, rows) {
                html += '<input type="checkbox" id="' + name + rows[value] + '" name="' + name + '" value="' + rows[value] + '" /><label for="' + name + rows[value] + '">' + rows[text] + '</label>'
            });
        }
        t.html(html);
        return t;
    },
    "iframe": function (ifrwin) {
        return $(this).click(function (ev) {
            ev.stopPropagation();
            var t = $(this);
            document.getElementById(t.attr("iframe") || ifrwin).setAttribute("src", t.attr("src"));
        });
    },
    "attrmap": function (attr) {
        var t = $(this), form = $("#" + t.attr("mapform")), dict = form.length ? form.serialize().toKeyValue() : {}, ids = attr ? attr.split(",") : [];
        attr = t.attr("attrmap");
        if (attr) {
            ids = attr.split(",").concat(ids);
        }
        $.each(ids, function (key, val) {
            dict[val.replace(/^map/, "")] = $("#" + (t.attr(val) || val)).val() || "";
        });
        $.extend(t.data("attrmap"), dict);
        return dict;
    },
    "attrval": function (attr) {
        var t = $(this), dict = {}, ids = attr.split(",");
        attr = t.attr("attrval");
        if (attr) {
            ids.concat(attr.split(","));
        }
        $.each(ids, function (key, val) {
            dict[val] = t.attr(val) || "";
        });
        return dict;
    }
});

jQuery.fn.extend({
    "rssparse": function (dict) {
        return $(this).data("rssparse", dict);
    },
    "rssverify": function (func) {
        return $(this).data("rssverify", func);
    },
    "rssedit": function (act) {
        try {
            act = act || "rssedit";
            var t = $(this), dict = t.attrmap(t.attr(act));
            var verify = t.data("rssverify");
            if (verify && verify.constructor == Function && !verify(dict)) {
                return;
            }
            var ajax = new Ajax(t.attr("api")).keyvalue(dict);
            if (t.attr("usemyid") != undefined) {
                ajax.keymyid(t.attr("usemyid"));
            }
            t.trigger("ajaxready", ajax);
            ajax.post(function (json) {
                t.trigger(act, json);
            });
        }
        catch (e) {
            RssCode.alert(e);
        }
    },
    "rssdel": function () {
        $(this).rssedit("rssdel");
    },
    "rssadd": function () {
        $(this).rssedit("rssadd");
    },
    "rssview": function (params) {
        var t = $(this), dict = $.extend(null, t.attrmap(t.attr("rssview") || ""), params || {});
        var ajax = new Ajax(t.attr("api")).keyvalue(dict);
        if (t.attr("usemyid") != undefined) {
            ajax.keymyid(t.attr("usemyid"));
        }
        ajax.getJson(function (json) {
            var parse = t.data("rssparse") || {};
            $("#" + t.attr("bind")).mapjson(json, parse);
        });
    },

    "rssitem": function (params) {
        return $(this).each(function (params) {
            var t = $(this), dict = $.extend(null, t.attrmap(t.attr("rssitem")), params || {}), pt = t.parent(), nextbtn = $("#" + t.attr("nextbtn")), prevbtn = $("#" + t.attr("prevbtn"));
            var ajax = new Ajax(t.attr("api")).keyvalue(dict).setFlushUI(function (json, append) {
                t.mapitem(json, t.data("rssparse"), prevbtn.length ? false : append);
            });
            if (t.attr("usemyid") != undefined) {
                ajax.keymyid(t.attr("usemyid"));
            }
            pt.on("ajaxupdate", function () {
                ajax.firstpage().getJson();
            }).trigger("ajaxupdate");
            nextbtn.click(function () {
                ajax.nextpage().getJson();
            });
            prevbtn.click(function () {
                ajax.prevpage().getJson();
            });
        });
    }
});
//你今天的日积月累，是别人的望成莫及
$(window).ready(function () {
    $("[selectcascade]").selectcascade();
    $.each(window.dictdata || {}, function (k, v) {
        $("[" + k + "]").each(function () {
            var t = $(this);
            t.attr({ "dictparse": k, "dict-val": t.attr(k) });
            t.dictparse();
        });
    });

    $("[dict-select]").each(function () {
        var t = $(this), dict = window.dictdata[t.attr("dict-select")] || {}, html = "";

        $.each(dict, function (k, v) {
            if (v.constructor == Array) {
                v = v[0];
            }
            html += '<option value="' + k + '">' + v + '</option>';
        });
        if (this.tagName.toLowerCase() != "select") {
            t = t.append('<select></select>');
        }
        t.append(html);
        if (t.attr("def")) {
            t.val(t.attr("def"));
        }
    });

    $("[dict-radio]").each(function () {
        createinput($(this), "radio");
    });
    $("[dict-checkbox]").each(function () {
        createinput($(this), "checkbox");
    });
    function createinput(t, tp) {
        var dict = window.dictdata[t.attr("dict-" + tp)] || {}, html = "", name = t.attr("dict-name") || t.attr("dict-" + tp), keys = (t.attr("dict-keys") || "");
        if (keys.length) {
            keys = keys.split(',');
            var tmp = {};
            $.each(keys, function (k, v) {
                if (dict[v]) {
                    tmp[v] = dict[v];
                }
            });
            dict = tmp;
        }
        $.each(dict, function (k, v) {
            html += '<label for="' + name + k + '"><input type="' + tp + '" id="' + name + k + '" name="' + name + '" value="' + k + '" />' + (v.constructor == Array ? v[0] : v) + '</label>';
        });
        t.html(html);
        var item = t.find("input[name=" + name + "]");
        if (t.attr("def")) {
            item.val(t.attr("def").split(","));
        }
        if (tp == "checkbox") {
            item.removeAttr("name");
            var ipt = $('<input type="hidden" name="' + name + '" value=""/>');
            t.append(ipt);
            item.click(function () {
                var val = [];
                t.find("input:checked").each(function () {
                    val.push(this.value);
                });
                ipt.val(val.join());
            })
        }
    }
});

$(".hisback").click(function (ev) {
    ev.preventDefault();
    ev.stopPropagation();
    history.back();
});
$("[selectall]").click(function () {
    var t = $(this), sel = $(t.attr("selectall"));
    sel.prop("checked", this.checked);
});
$("[rssdate]").each(function () {
    var t = $(this);
    var data = t.attr("rssdate").split(",");
    if (!data[0]) {
        return;
    }
    var ft = data[1] || "yyyy-MM-dd HH:mm:ss";
    var val = new Date(parseInt(eval(data[0])) * 1000).toString(ft);
    switch (this.tagName.toLowerCase()) {
        case "input":
            t.val(val);
            break;
        default:
            t.html(val);
            break;
    }
});
$("[ueditor]").each(function () {
    UE.getEditor(this.id, eval("({" + $(this).attr("ueditor") + "})"));
});
$("[rssip]").each(function () {
    var t = $(this);
    var hex = parseInt(t.attr("rssip")).toString("16").padleft(8, '0');
    var vals = hex.match(/\w{2}/img);
    t.html(parseInt(vals[0], 16) + "." + parseInt(vals[1], 16) + "." + parseInt(vals[2], 16) + "." + parseInt(vals[3], 16));
});
$("[fixedphone]").each(function () {
    var t = $(this);
    var fixedphone = t.attr("fixedphone");
    if (fixedphone.length < 8) {
        return;
    }
    var quhao = /^(10|2[\d]|[\d]{3})/g;
    var phone = fixedphone.match(quhao);
    switch (this.tagName.toLowerCase()) {
        case "input":
            break;
        default:
            t.html(fixedphone.replace(quhao, function (val) {
                return "0" + val + "-";
            }));
            break;
    }
});
$("[rssmoney]").each(function () {
    var t = $(this);
    var money = t.attr("rssmoney").split(",");
    t.html(money[0].tomoney(money[1], money[2]));
});
$("[rssidcard]").each(function () {
    var t = $(this);
    var idcard = t.attr("rssidcard");
    if (idcard.length == 17) {
        idcard += "X"
    }
    switch (this.tagName.toLowerCase()) {
        case "input":
            t.val(idcard);
            break;
        default:
            t.html(idcard);
            break;
    }
});
$("[disedit]").each(function () {
    var t = $(this);
    if (t.val()) {
        t.prop("disabled", true);
    }
});

if (!('placeholder' in document.createElement("input"))) {
    $("[placeholder]").each(function () {
        var t = $(this), placeholder = t.attr("placeholder"), height = t.height(), width = t.outerWidth(), right = parseInt(t.css("margin-right")), border = width - t.width();
        var label = $('<label>').insertAfter(t).html(placeholder).css({ "margin-top": -height, "margin-left": -(width + right), "margin-right": right, "height": height, "width": width, "line-height": height + "px" }).addClass("placeholder").hide();
        label.attr("id", t.attr("name") + 'placeholder');
        label.click(function () {
            t.focus();
        });
    });
    $("[placeholder]").focus(function () {
        var t = $(this), placeholder = $("#" + t.attr("name") + "placeholder");
        placeholder.hide();
    }).keyup(function () {
        var t = $(this), placeholder = $("#" + t.attr("name") + "placeholder");
        t.val() == "" ? placeholder.show() : placeholder.hide();
    }).blur(function () {
        $(this).keyup();
    }).blur();
}
$("input[type!=hidden]").each(function (k, v) {
    var t = $(this);
    t.prop("tabindex", k + 1);
});
$(document).on("dragstart", function (e) {
    e.preventDefault();
});

//输入限定
var allowinput = {};
allowinput["number"] = function (e) {
    var val = e.target.value;
    if (e.which == 189) {
        return !val.match(/^-[\d\.]*$/);
    }
    return (e.which > 47 && e.which < 58) || (e.which > 95 && e.which < 106)
}
allowinput["real"] = function (e) {
    if (e.which == 110) {
        return !e.target.value.match(/\./img);
    }
    return this.number(e) || e.which == 190;
}
allowinput["time"] = function (e) {
    return this.number(e) || e.which == 59;
}
allowinput["money"] = function (e) {
    return this.real(e);
}
allowinput["idcard"] = function (e) {
    return this.number(e) || e.which == 88;
}
$("[allowinput]").each(function () {
    var t = $(this);
    t.keydown(function (e) {
        return e.which == 8 || e.which == 9 || e.which == 13 || e.which == 46 || (e.which > 36 && e.which < 41) || allowinput[t.attr("allowinput")](e);
    });
})

//后台事件适配器
var transadapter = { "id": "" };
transadapter.factory = function (t, trans) {
    t = $(t);
    var adapter = $(t.attr(trans) || "#transadapter");
    var selected = eval(t.attr("select"));
    if (selected != false) {
        var find = $(adapter.attr("find"));
        var ids = [];
        find.each(function () {
            ids.push($(this).val());
        });
        transadapter.id = ids.join(',');
        if (!transadapter.id) {
            window.popuplayer ? popuplayer.showError("请选择") : alert("请选择");
            return;
        }
    }
    if (transadapter[trans]) {
        transadapter[trans](t);
    }
}
$("[transadapter]").click(function (e) {
    e.preventDefault();
    var t = $(this);
    transadapter.factory(t, t.attr("transadapter"));
});

//媒体
function RssMedia() {
    this.player = null;
    this.playlist = [];
    this.loop = false;
}
RssMedia.prototype = {
    "duration": 0,
    "ispause": true,
    //播放器内置购买验证，如果没有购买，回调方法onPay()
    "isbuy": true,
    "onPay": $.noop(),
    "currentTime": 0,
    "play": function () {
        if (this.isbuy) {
            this.player.play();
            return;
        }
        if (this.onPay == $.noop) {
            RssCode.alert("224");
            return;
        }
        this.onPay();
    },
    "stop": function () {
        if (this.pause() && this.player.currentTime) {
            this.player.currentTime = 0;
            this.ispause = true;
        }
    },
    "pause": function () {
        if (this.player && !this.player.paused) {
            this.player.pause();
            return true;
        }
        return false;
    },
    "onready": function () { },
    "onpause": function () { },
    "onend": function () { },
    "onprogress": function () { },
    "poster": function (url) {
        this.player.setAttribute("poster", url);
    },
    "setsrc": function (url, auto) {
        if (this.player.getAttribute("src") == url) {
            return;
        }
        this.player.removeAttribute("autoplay");
        if (auto) {
            this.player.setAttribute("autoplay", true);
        }
        if (!url) {
            this.player.removeAttribute("src");
            return;
        }
        this.player.setAttribute("src", url);
        var t = this;
        this.player.onloadeddata = function () {
            t.duration = parseInt(this.duration);
            t.onready();
        }
        this.player.ontimeupdate = function () {
            t.onprogress(t.duration, this.currentTime);
        }
        this.player.onplay = function () {
            if (!t.isbuy) {
                t.pause();
                return;
            }
            t.ispause = false;
        }
        this.player.onended = function () {
            t.onend();
        }
        this.player.onpause = function () {
            t.ispause = true;
            t.onpause();
        }
        this.player.load();
        return this;
    },
    "onplayend": function () { }
}

//音频
var RssAudio = new RssMedia();
RssAudio.player = document.createElement("audio");
RssAudio.player.setAttribute("preload", "auto");
RssAudio.player.removeAttribute
document.body.appendChild(RssAudio.player);

//视频
var RssVideo = new RssMedia();

//媒体播放
(function () {
    if (window.addEventListener) {
        var media = [];
        var item = document.getElementsByTagName('audio');
        for (var i = 0; i < item.length; i++) {
            media.push(item[i]);
        }
        item = document.getElementsByTagName('video');
        for (var i = 0; i < item.length; i++) {
            media.push(item[i]);
        }
        window.addEventListener('touchstart', removeBehaviorsRestrictions);
        function removeBehaviorsRestrictions() {
            var len = media.length;
            for (var i = 0; i < len; i++) {
                media[i].load();
                if (media[i].getAttribute("loop")) {
                    media[i].addEventListener("pause", function () {
                        if (this.currentTime == 0) {
                            this.play();
                        }
                    });
                }
            }
            window.removeEventListener('touchstart', removeBehaviorsRestrictions);
        }
    }
})();

var RssCode = {
    "label": "",
    "value": function (code) {
        var msg = (dictdata.rsscode[code] || code + "").replace("label", this.label);
        this.label = "";
        return msg;
    },
    "alert": function (code, key) {
        if (code) {
            if (key) {
                key = "：" + key;
            }
            alert(this.value(code) + (key || ""));
        }
    }
};

var rssclick = {}
$("[rssclick]").click(function (ev) {
    ev.stopPropagation();
    ev.preventDefault();
    var t = $(this), adapter = t.attr("rssclick");
    if (rssclick[adapter] && rssclick[adapter].constructor == Function) {
        rssclick[adapter].call(this);
    }
});

//事件
var RssEvent = {
    "onLevelClick": function (ev) { }
}

//任务处理
var RssTask = {
    //当前时间(日期格式)
    "curtime": new Date(),
    //默认刻度，每隔100毫秒执行一次
    "tick": 100,
    //任务队列
    "queue": {},
    //执行任务队列所用总时间
    "usetime": 0,
    //增加任务：任务名称，任务（函数），是否验证已存在的任务
    "add": function (name, task, tick, check) {
        if (check && this.queue[name]) {
            alert("已存在相同的任务");
            return;
        }
        if (typeof task != "function") {
            alert("任务应该是一个可执行的函数");
            return;
        }
        tick = tick || 1000;
        this.queue[name] = { "tick": tick, "task": task };
        return this;
    },
    "pauseitem": {},
    "pause": function (name) {
        if (this.queue[name]) {
            this.pauseitem[name] = this.queue[name];
            delete this.queue[name];
        }
    },
    "restart": function (name) {
        if (this.pauseitem[name]) {
            this.queue[name] = this.pauseitem[name];
        }
        delete this.pauseitem[name];
    },
    "remove": function (name) {  //移除指定的任务
        delete this.queue[name];
        return this;
    },
    "removeAll": function () {
        this.queue = {};
        return this;
    }, //移除所有任务
    "synctime": function (url) {  //从指定的URL地址处获取服务器时间,与指定的服务器时间同步
        var st = new Date().getTime();
        $.get(url, function (data) {
            RssTask["curtime"] = new Date(data * 1000 + (new Date().getTime() - st));
        });
        return this;
    },
    "task": null,
    "start": function (n) {
        this.tick = n || 100;
        if (this.task) {
            return this;
        }
        this.task = setInterval(function () {
            RssTask["curtime"].addMilliseconds(RssTask.tick);
            var tick = RssTask.curtime.getTime();
            var st = new Date().getTime();
            $.each(RssTask["queue"], function (key, val) {
                if ((parseInt(tick / RssTask.tick) * RssTask.tick) % val["tick"] === 0) {
                    val["task"]();
                }
            });
            RssTask.usetime = new Date().getTime() - st;

        }, this.tick);
        return this;
    },
    "stop": function () {
        if (this.task) {
            clearInterval(this.task);
            this.task = null;
        }
        return this;
    }
}
//词典助手
function RssDict(obj) {
    this.dict = obj || {};
}
RssDict.DataParse = {}
RssDict.prototype.keyvalue = function (key, value) {
    if (!key) {
        return this;
    }
    var t = this;
    switch (key.constructor) {
        case RssTable:
            $.extend(t.dict, key.dict);
            if (value) {
                this.dict["rowsdata"] = key.rows;
            }
            break;
        case Object:
            $.extend(t.dict, key);
            break;
        case Array:
            $.each(key, function (idx, val) {
                t.dict[val["name"]] = val["value"];
            });
            break;
        default:
            if (value !== null && value !== undefined) {
                t.dict[key] = value;
                break;
            }
            $.extend(t.dict, key.toKeyValue());
            break;
    }
    return this;
}
RssDict.prototype.keymyid = function (myid) {
    this.keyvalue("myid", myid || RssUser.Data.myid || "");
    return this;
}
RssDict.prototype.parse = function (data, split) {
    return this;
}
RssDict.prototype.toJson = function () {
    return Object.toJson(this.dict);
}
RssDict.prototype.toQueryString = function () {
    return Object.toQueryString(this.dict);
}
RssDict.prototype.extend = function (data) {

}
RssDict.prototype.getDict = function () {
    return this.dict;
}

function RssIM() {
    this.host = "http://im.rsseasy.com";
    this.proxy = "caiLaiHub";
    this.connid = "";
}
RssIM.prototype.Message = { "title": "", "matter": "", "clasifyid": "", "sender": "", "myid": "", "nickname": "", "audio": "", "video": "", "picture": "" };
RssIM.prototype.connid = "";
RssIM.prototype.host = "";
RssIM.prototype.im = "";
RssIM.prototype.connect = function (host, proxy) {
    var t = this;
    if (!$.hubConnection) {
        alert("hubConnection不存在，请检查");
        return;
    }
    var conn = $.hubConnection((host || this.host));
    this.im = conn.createHubProxy(proxy || this.proxy);
    if (RssUser.Data.myid) {
        this.im.connection.qs = "myid=" + RssUser.Data.myid + "&username=" + RssUser.Data.nickname;
    }
    this.im.on("Upline", function (data) {
        t.onUpline(data.toJson());
    });
    this.im.on("Receive", function (data) {
        t.onReceive(data.toJson());
    });
    this.im.on("Reconnected", function (data) {
        t.onReconnected(data.toJson());
    });
    this.im.on("Disconnected", function (data) {
        t.onDisconnected(data.toJson());
    });
    this.im.on("GetUsers", function (data) {
        t.onGetUsers(data.toJson());
    });
    this.im.on("GetGroups", function (data) {
        t.onGetGroups(data.toJson());
    });
    conn.start().done(function () {
        t.connid = t.im.connection.id;
        t.onConnected();
    }).fail(function () {
        alert("即时通信服务器连接失败，请与管理员联系！");
    });
}
//当用用户上线后
RssIM.prototype.onUpline = function () {
}
//当连接成功后，获取用户自己的连接ID
RssIM.prototype.onConnected = function () {
}
//当某一用户重新连接成功后
RssIM.prototype.onReconnected = function (connid) {
}
//当某一用户连接断开后
RssIM.prototype.onDisconnected = function (connid) {
}
//当获取到信息后
RssIM.prototype.onReceive = function (message) {
    console.log(message);
}
RssIM.prototype.getJson = function (params) {
    this.Message.sender = this.connid;
    if (RssUser.Data.myid) {
        this.Message.myid = RssUser.Data.myid;
        this.Message.nickname = RssUser.Data.nickname || "游客";
    }
    $.extend(this.Message, params);
    return Object.toJson(this.Message);
}
//给指定的MyID用户发送消息
RssIM.prototype.SendMyID = function (myid) {
    this.im.invoke("sendMyID", this.getJson(), $.isArray(myid) ? myid : myid.split(","));
}
//给指定的ConnID用户发送消息
RssIM.prototype.SendConnID = function (connid) {
    this.im.invoke("sendConnID", this.getJson(), $.isArray(connid) ? connid : connid.split(","));
}
//对所有人发送消息
RssIM.prototype.SendAll = function () {
    this.im.invoke("sendAll", this.getJson());
}
//对除自己这外的所有人发送广播消息
RssIM.prototype.SendOtherUser = function () {
    this.im.invoke("sendOtherUser", this.getJson());
}
//发送组消息
RssIM.prototype.SendGroup = function (groupname) {
    this.im.invoke("sendGroup", groupname, this.getJson({ "group": groupname }));
}
//加入组
RssIM.prototype.JoinGroup = function (groupname) {
    this.im.invoke("joinGroup", groupname);
}
//离开组
RssIM.prototype.LeaveGroup = function (groupname) {
    this.im.invoke("leaveGroup", groupname);
}
RssIM.prototype.onJsAdapter = function (json) {
}
RssIM.prototype.GetUsers = function () {
    this.im.invoke("getUsers");
}
RssIM.prototype.onGetUsers = function (json) {
}
RssIM.prototype.GetGroups = function () {
    this.im.invoke("getGroups");
}
RssIM.prototype.onGetGroups = function (json) {
}

//AJAX
var Ajax = function (api, params) {
    this.method = "post";
    this.url = this.host + api;
    this.params = params || {};
    this.curpage = 1;
    this.pagesize = 10;
    this.refertime = RssTask.curtime;
    this.contentType = "application/x-www-form-urlencoded";
    this.dataType = "text";
    this.headers = new RssDict();
    this.xhr = null;
    this.newid = -1;
    this.rsstable = new RssTable();
    if (typeof params == "string") {
        this.params = params.toKeyValue();
    }
    this.oncreate();
    return this;
}
Ajax.prototype.formdata = window.FormData ? new FormData() : null;
Ajax.prototype.oncreate = function () { }
Ajax.success = function (data, bc) {
    if (!data) {
        return;
    }
    if (typeof data == "object" && data["rsscode"] != undefined && data["rsscode"] != 100) {
        if (this.onrsscode == null || this.onrsscode == $.noop) {
            Ajax.rsscode.call(this, data["rsscode"], data)
        }
        else {
            this.onrsscode(this, data["rsscode"], data);
        }
        return;
    }
    this.refertime = RssTask.curtime;
    var size = -1;
    if ($.isArray(data)) {
        size = data.length;
    } else if ($.isPlainObject(data) && data["data"]) {
        size = data["data"].length;
    }
    if (size > 0) {
        this.getnewid(data);
    }
    if (this.curpage == 1 && size == 0 && this.onnotdata != $.noop) {
        this.onnotdata();
        return;
    }
    if (this.flushui != $.noop) {
        this.flushui(data, this.params["curpage"] != "0");
    }
    if (this.params["curpage"] == "0" && this.curpage == 1 && size == this.pagesize) {
        this.curpage = 2;
    } else {
        if (size > 0) {
            this.curpage++;
        }
        if (size < this.pagesize && this.onlastpage != $.noop) {
            this.onlastpage(size);
            return;
        }
    }
    if (bc) {
        bc.call(this, data);
    }
    Ajax.onsuccess(data);
};
Ajax.rsscode = function (code, data) {
}
Ajax.error = function (bc, xhr) {
    if (bc) {
        bc({ "xhr": xhr, "code": xhr.status, "txt": xhr.statusText });
    }
    Ajax.onerror(xhr);
}
Ajax.complete = function (bc, xhr) {
    if (this.isload) {
        Ajax.unloading();
    }
    if (bc) {
        bc({ "xhr": xhr, "code": xhr.status, "txt": xhr.statusText });
    }
    Ajax.oncomplete(xhr);
}
Ajax.sort = function (json) {

}
Ajax.onsuccess = function (data) { }
Ajax.oncomplete = function (data) { }
Ajax.onerror = function (data) { }
Ajax.prototype.isload = false;
Ajax.prototype.setLoading = function (isload) {
    this.isload = isload;
    return this;
}
Ajax.prototype.onrsscode = $.noop;
Ajax.prototype.rsscode = function (onrsscode) {
    this.onrsscode = onrsscode;
    return this;
}
Ajax.prototype.bind = function (obj) {
    return this;
}
Ajax.loading = false;
Ajax.onloading = function () {
    if (Ajax.loading) {
        clearTimeout(Ajax.loading);
        Ajax.loading = null;
    }
    RssWin.MaskLayer.show();
    RssWin.LoadBox.show();
    return this;
}
Ajax.unloading = function () {
    Ajax.loading = setTimeout(function () {
        RssWin.LoadBox.close();
        RssWin.MaskLayer.close();
    }, 500);
    return this;
}
Ajax.prototype.sign = function () {
    var keys = [], sign = [], t = this;
    $.each(this.params, function (key) {
        if (!t.params[key]) {
            delete t.params[key];
        }
        else {
            keys.push(key);
        }
    });
    keys.sort();

    $.each(keys, function (i, key) {
        sign.push(key + "=" + t.params[key]);
    });
    this.params["signtoken"] = MD5(sign.join("&") + "&key=" + this.prikey);
    return this;
}
Ajax.prototype.host = "http://sys.coal.itemjia.com/";
Ajax.prototype.prikey = "www.rsseasy.com";
Ajax.prototype.params = {};
Ajax.prototype.url = "";
Ajax.prototype.condition = function (dict) {
    return this.keyvalue("rsswhere", dict.constructor == String ? dict : Object.toJson(dict));
}
Ajax.prototype.keyext = function (t) {
    return this.keyvalue("extdata", t.attr("extdata")).keyvalue("extpost", t.attr("extpost"));
}
Ajax.prototype.setverify = function (verify) {
    if (verify || verify.constructor == Function) {
        this.verify = verify;
    }
    return this;
}
Ajax.prototype.verify = function (dict) {
    return true;
}
Ajax.prototype.keyvalue = function (key, value) {
    if (!key) {
        return this;
    }
    var t = this;
    switch (key.constructor) {
        case RssTable:
            $.extend(t.params, key.dict);
            if (value) {
                this.params["rowsdata"] = key.rows;
            }
            break;
        case Object:
            $.extend(t.params, key);
            break;
        case Array:
            $.each(key, function (idx, val) {
                t.params[val["name"]] = val["value"];
            });
            break;
        default:
            if (value !== null && value !== undefined) {
                t.params[key] = value;
                break;
            }
            $.extend(t.params, key.toKeyValue());
            break;
    }
    return this;
}
Ajax.prototype.getnewid = function (data) {
    data = data["data"] || data;
    if ($.isArray(data)) {
        var ids = [];
        $.each(data, function (idx, rows) {
            ids.push(rows["id"] || rows["myid"] || 0);
        })
        this.newid = Math.max.apply(null, ids);
    }
}
Ajax.prototype.keymyid = function (key) {
    if (RssUser.Data.myid) {
        this.params[key || "myid"] = RssUser.Data.myid;
    }
    if (RssUser.Data.usertoken) {
        this.headers.keyvalue("usertoken", RssUser.Data.usertoken);
    }
    return this;
}
//所有者Myid，
Ajax.prototype.keyowner = function (myid) {
    this.keyvalue("owner", myid);
    return this;
}
Ajax.prototype.setHead = function (key, value) {
    this.headers.keyvalue(key, value);
    return this;
}
Ajax.prototype.setType = function (datatype) {
    this.dataType = datatype;
    return this;
}
Ajax.prototype.setFlushUI = function (flush) {
    this.flushui = flush || this.flushui || $.noop;
    return this;
}
Ajax.prototype.prevpage = function () {
    this.curpage -= 2;
    if (this.curpage < 0) {
        this.curpage = 1;
        this.onnotdata();
        return;
    }
    this.params["curpage"] = this.curpage;
    this.params["pagesize"] = this.pagesize;
    return this;
}
Ajax.prototype.nextpage = function () {
    this.params["curpage"] = this.curpage;
    this.params["pagesize"] = this.pagesize;
    return this;
}
Ajax.prototype.flushui = function (json, append) {

}
Ajax.prototype.onlastpage = $.noop;
Ajax.prototype.onnotdata = $.noop;
Ajax.prototype.notdata = function (bc) {
    this.onnotdata = bc;
    return this;
}
Ajax.prototype.lastpage = function (bc) {
    this.onlastpage = bc;
    return this;
}
Ajax.prototype.firstpage = function (bc) {
    this.params["curpage"] = "0";
    this.params["pagesize"] = this.pagesize;
    this.params["refertime"] = parseInt(this.refertime.getTime() / 1000);
    this.params["newid"] = this.newid;
    return this;
}
Ajax.prototype.getJson = function (success, error, complete) {
    this.dataType = "json";
    this.method = "get";
    return this.submit(success, error, complete);
}
Ajax.prototype.get = function (success, error, complete) {
    this.method = "get";
    return this.submit(success, error, complete);
}
Ajax.prototype.post = function (success, error, complete) {
    return this.submit(success, error, complete);
}
Ajax.prototype.sendJson = function (success, error, complete) {
    this.contentType = "application/json; charset=utf-8";
    this.dataType = "json";
    return this.submit(success, error, complete);
};
Ajax.prototype.submit = function (success, error, complete) {
    var t = this;
    if (!this.verify(this.params)) {
        return false;
    }
    this.sign();
    if (this.isload) {
        Ajax.onloading();
    }
    this.xhr = $.ajax({
        type: this.method,
        url: this.url,
        headers: this.headers.dict,
        contentType: this.contentType,
        data: this.params,
        dataType: this.dataType,
        success: function (data) {
            Ajax.success.call(t, data, success);
        },
        error: function (xhr, status, thrown) {
            Ajax.error.call(t, error, xhr, thrown);
        },
        "complete": function (xhr) {
            Ajax.complete.call(t, complete, xhr);
        }
    });
    return this;
}
Ajax.prototype.sendFrom = function (success, error, complete, progress) {
    var t = this;
    var xhr = this.xhr = new XMLHttpRequest();
    xhr.open("post", this.url, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                Ajax.success.call(t, xhr.responseText.trim().toJson(), success);
            } else {
                Ajax.error.call(t, error, xhr);
            }
            Ajax.complete.call(t, complete, xhr);
        }
    }
    xhr.upload.onprogress = function (evt) {
        if (progress) {
            if (evt.lengthComputable) {
                progress(evt.total, evt.loaded);
            }
        }
    }
    if (this.isload) {
        Ajax.onloading();
    }
    $.each(this.params, function (key, val) {
        t.formdata.append(key, val);
    });
    xhr.send(this.formdata);
}

//数据映射
var RssORM = {}
RssORM.Append = function (tablename) {
    tablename = tablename.split(",");
    $.each(tablename, function (indx, name) {
        RssORM[name] = {};  //初始化表操作对象
        RssORM[name]["entity"] = {};  //单列数据，键值对存储
        RssORM[name]["item"] = [];  //多行数据，数组方式存储
        RssORM[name]["layout"] = {};  //布局列表
    });
}

//用户操作对象
var RssUser = {};
RssUser.Data = { "myid": 0 }   //用户数据
RssUser.Item = {}
RssUser.IsLogin = function (ev) {
    if (!RssUser.Data["myid"]) {
        ev && ev.preventDefault();
        location.hash = "#loginpage";
        return false;
    }
    return true;
}
RssUser.onLogin = function () {
    location.hash = RssUser.History;
}
RssUser.History = "#homepage";
RssUser.Update = function (json) {
    RssUser.Data = Storage.getJson("userdata");
    $.each(json, function (k, v) {
        RssUser.Data[k] = v;
    });
    Storage.Set("userdata", Object.toJson(RssUser.Data));
    this.onUpdate();

}
RssUser.onUpdate = function () { }
RssUser.LoginOut = function (back) {
    Storage.remove("userdata");
    RssUser.Update();
    if (typeof back == "function") {
        back();
    }
}
RssUser.Append = function (myid, json) {
    this.Item[myid] = json;
}

//验证登录
$("[islogin]").click(function (ev) {
    RssUser.History = $(this).attr("islogin") || "/";
    RssUser.IsLogin(ev);
});

RssUser.Update({});

//权限控制
var RssPower = {}
RssPower.List = [];
$.each((Cookie.Get("powerlist") || "").split(","), function (idx, val) {
    RssPower.List[idx] = parseInt(val).toString(2).padleft(53, '0');
});
RssPower.List = "1" + RssPower.List.join("");
RssPower.verify = function (offset) {
    return RssPower.List.substr(offset, 1) == 1;
};
$("[powerid]").hide().each(function () {
    var t = $(this), offset = parseInt(t.attr("powerid") || 0);
    if (RssPower.verify(offset)) {
        t.show();
    }
});

//窗口
var RssWin = {
    "MaskLayer": {
        "layer": $("#masklayer"),
        "show": function () {
            if (!this.layer.length) {
                this.layer = $('<div id="masklayer" class="masklayer"><!--遮罩层--></div>');
                $(document.body).append(this.layer);
            }
            this.layer.show();

        },
        "close": function () {
            this.layer.hide();
        },
    },
    "LoadBox": {
        "box": $("#loadbox"),
        "show": function (msg) {
            RssWin.MaskLayer.show();
            this.box.show();
            if (msg) {
                this.box.find("span").html(msg);
            }
            this.box.css("margin-left", -this.box.outerWidth() / 2);
        },
        "close": function () {
            RssWin.MaskLayer.close();
            this.box.hide();
        }
    },
    "DeBug": {
        "box": $("#debug"),
        "log": function (json) {
            if (RssEasy.Debug) {
                this.box.find("ul").append('<li>' + JSON.stringify(json) + '</li>');
            }
        },
        "show": function (json) {
            this.box.show();
        }
    },
    "topifr": function (name) {
        var ifr = top.window.frames[name || 0];
        return ifr.window || ifr.contentWindow;
    }
};
RssWin.MaskLayer.layer.click(function (ev) {
    ev.stopPropagation();
});

$("[rsswin]").click(function () {
    var win = $(this).attr("rsswin");
    if (!RssWin[win]) {
        alert(win + "窗口不存在");
        return;
    }
    RssWin[win].show();
});
var RssFrame = {}
RssFrame.RootMenu = {}
RssFrame.LeftMenu = {}

//与其它设备通信适配器
function RssAppAdapter(params) {
    try {
        switch (RssOS.os) {
            case "android":
                window.jsadapter ? window.jsadapter.factory(JSON.stringify(params)) : "";
                return;
            case "ios":
                window.webkit.messageHandlers.jsadapter ? window.webkit.messageHandlers.jsadapter.postMessage(params) : "";
                return;
            case "rsseasy":
                window.external.jsadapter(JSON.stringify(params));
                return;
            default:
                break;
        }
    } catch (e) { }
    var adapter = params["adapter"];
    if (window.WebAdapter && WebAdapter[adapter]) {
        delete params["adapter"];
        WebAdapter[adapter](params);
    }
}

//浏览器接口回调工厂方法
function RssAppCallBackFactory(module, params) {
    RssWin.DeBug.log(params);
    var marker = params["adapter"];
    if (marker) {
        delete params["adapter"];
        if (module[marker]) {
            module[marker](params);

            var allot = module["TaskAllot"];
            if (allot && module[marker][allot]) {
                module[marker][allot](params);
                module["TaskAllot"] = "";
            }

            return;
        }
        alert(marker + "适配器不存在！");
    }
}
//浏览器相关
var RssWebView = {};
RssWebView.onStart = function (json) {

}
RssWebView.onProgress = function (json) {

}
RssWebView.onComplete = function (json) { }

//文件上传相关
var RssUpFile = {};
RssUpFile.TaskAllot = "";
RssUpFile.Action = "";
RssUpFile.Params = {};
RssUpFile.Submit = function (params) {
    RssAppAdapter($.extend(null, { "adapter": "UpFile", "action": this.Action, "url": RssApp.UpFileApi }, this.Params, params || {}));
}
RssUpFile.File = function (params) {
    this.Action = "file";
    return this.Submit(params);
}
RssUpFile.Image = function (params) {
    this.Action = "gallery";
    return this.Submit(params);
}
RssUpFile.TakePhoto = function (params) {
    this.Action = "takephoto";
    return this.Submit(params);
}
RssUpFile.onStart = function (json) {

}
RssUpFile.onProgress = function (json) {

}
RssUpFile.onComplete = function (json) {

}
RssUpFile.onError = function (json) {

}

//文件下载类
var RssDownFile = {}
RssDownFile.Params = { "background": false };
RssDownFile.setBackGround = function (bool) {
    this.Params["background"] = bool;
    return this;
}
RssDownFile.Start = function (url) {
    this.Params["url"] = url;
    this.Submit();
}
RssDownFile.Submit = function (params) {
    RssAppAdapter($.extend(null, { "adapter": "DownFile" }, this.Params, params || {}));
}

RssDownFile.onStart = function (json) {

}
RssDownFile.onProgress = function (json) {

}
RssDownFile.onComplete = function (json) {

}

//播放器
var RssPlayer = {}

//内存虚拟表
function RssTable(name) {
    $.extend(this, RssDict.prototype);
    RssTable.Table[name] = name;
    this.header = [];
    this.headerdict = {};
    this.rows = [];
    this.colcount = 0;
    this.currowno = -1;
    this.rowscount = 0;
    this.prikey = "id";
    this.dict = {}
}
RssTable.Table = {};
//设置表头，数组或以','分割的表头字符串
RssTable.prototype.setHeader = function (header) {
    switch (header.constructor) {
        case Array:
            this.header = header;
            break;
        case String:
            this.header = header.split(",");
            break;
        case Object:
            var arr = [];
            $.each(row, function (key, val) {
                arr.push(key);
            });
            this.rows.push(arr);
            break;
        default:
            alert("设置表头出错");
            break;

    }
    var t = this;
    $.each(this.header, function (idx, val) {
        t.headerdict[val] = idx;
        t.dict[val] = "";
    });
    this.colcount = this.header.length;
    return this;
}

RssTable.prototype.onUpdateRow = function () {

}
RssTable.prototype.onAddRow = function () {

}
//增加行数据，当是数组或字符串时，顺序需要与表头一致，如果是字典数据，则自动按表头存储
RssTable.prototype.addRow = function (row) {
    row = this.ParseRow(row);
    if (row) {
        this.rows.push(row);
        this.rowscount = this.rows.length;
        this.onAddRow();
    }
    return this;
}
RssTable.prototype.ParseRow = function (row) {
    switch (row.constructor) {
        case Array:
            return row
        case String:
            return row.split(",");
        case Object:
            var arr = [];
            var t = this;
            $.each(row, function (key, val) {
                var idx = t.headerdict[key];
                arr[idx] = val;
            });
            return arr;
    }
}
RssTable.prototype.onSetRows = function () {

}
//增加表，二组数组
RssTable.prototype.setRows = function (rows) {
    this.rows = rows;
    this.rowscount = this.rows.length;
    this.onSetRows();
    return this;
}
RssTable.prototype.updatetRow = function (row, rowidx) {
    row = this.ParseRow(row);
    if (row) {
        this.rows[rowidx || this.currowno] = row;
        this.onUpdateRow();
    }
    return this;
}
RssTable.prototype.setTable = function (header, rows) {
    this.setHeader(header);
    this.setRows(rows);
    return this;
}
//获取列数
RssTable.prototype.getColumnCount = function () {
    return this.header.length;
}
//获取列的表头名称
RssTable.prototype.getColumnLabel = function (idx) {
    return this.header[idx] || "";
}
//向下移动一行
RssTable.prototype.next = function () {
    return ++this.currowno < this.rowscount;
}
//获取当前行的数据，数组格式
RssTable.prototype.getRows = function () {
    return this.rows[this.currowno];
}
//循环获取表数据，返回字段与值的字典格式，使用get方法取值
RssTable.prototype.for_in_row = function () {
    if (this.next()) {
        var arr = this.getRows();
        var dict = {}, t = this;
        $.each(arr, function (idx, val) {
            if (val) {
                dict[t.header[idx]] = val;
            }
        });
        this.dict = dict;
        return true;
    }
    this.beforeFirst();
    return false;
}
//获取当前行指定列的值
RssTable.prototype.getValue = function (colidx) {
    return this.rows[this.currowno][colidx];
}
//设置当前行指定列的值
RssTable.prototype.setValue = function (colidx, val) {
    this.rows[this.currowno][colidx] = val;
    this.onUpdateRow();
    return this;
}
//获取指定单元格的值
RssTable.prototype.getCell = function (rowidx, colidx) {
    return this.rows[rowidx][colidx];
}
//设置指定单元格的值
RssTable.prototype.setCell = function (rowidx, colidx, val) {
    this.rows[rowidx][colidx] = val;
    this.onUpdateRow();
    return this;
}
//获取指定列名的值
RssTable.prototype.get = function (key) {
    return this.dict[key] || "";
}
//移动到第一行之前
RssTable.prototype.beforeFirst = function () {
    this.currowno = -1;
    return this;
}
//删除表数据及表结构
RssTable.prototype.drop = function () {
    this.header = [];
    this.headerdict = {};
    this.rows = [];
    return this;
}
//删除表数据
RssTable.prototype.clear = function () {
    this.rows = [];
    return this;
}
//生成键值对的JSON字符串
RssTable.prototype.toKeyValue = function () {
    var rows = [];
    while (this.for_in_row()) {
        rows.push(this.dict);
    }
    return Object.toJson(rows);
}
//当排序完成后
RssTable.prototype.onSort = function () {

}
//只支持单列排序
RssTable.prototype.sort = function (sort) {
    sort = sort.split(' ');
    var desc = sort[1] === "desc";
    var colidx = this.headerdict[sort[0]];
    this.rows.sort(function (x, y) {
        return x[colidx] > y[colidx] ? 1 : -1;
    });
    if (desc) {
        this.rows.reverse();
    }
    this.onSort();
}
RssTable.prototype.copy = function (header) {
    var table = new RssTable();
    table.setHeader(header);

    var t = this;
    var idx = [];
    $.each(header, function (i, val) {
        idx.push(t.headerdict[val]);
    });
    var rows = [];
    while (this.next()) {
        rows = [];
        var currows = t.getRows();
        $.each(idx, function (i, val) {
            rows[i] = currows[val];
        });
        table.addRow(rows);
    }
    return table;
}