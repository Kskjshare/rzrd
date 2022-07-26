/// <reference path="jquery.min.js" />
/// <reference path="rsseasy.min.js" />

var popuplayer = {}
popuplayer.wrap = $('<div class="popuplayer nofooter"></div>')
popuplayer.header = $('<div><h2></h2><span>×</span></div>');
popuplayer.content = $('<div></div>');
popuplayer.footer = $('<div><span></span><button type="button">取消</button><button type="button">确认</button></div>');
popuplayer.create = function () {
    var t = this;
    this.wrap.append(this.header);
    this.wrap.append(this.content);
    this.wrap.append(this.footer);
    this.title = this.header.find(">h2");
    this.status = this.footer.find("span");
    var button = this.footer.find(">button");
    button.click(function () {
        t.onclose();
    });
    button.last().click(function () {
        if (t.onconfirm()) {
            popuplayer.close();
        }
    });
    button.first().click(function () {
        if (t.oncancel()) {
            popuplayer.close();
        }
    });
    this.header.find(">span").click(function () {
        if (t.onclose()) {
            popuplayer.close();
        }
    });
    $(document.body).append(this.wrap);
    return this;
};
popuplayer.create();

popuplayer.onconfirm = function () {
    return true;
}
popuplayer.oncancel = function () {
    return true;
}
popuplayer.onclose = function () {
    return true;
}
popuplayer.close = function () {
    RssWin.MaskLayer.close();
    this.wrap.hide();
}
popuplayer.options = {
    "width": 0,
    "height": 0,
    "animate": 200,
    "border": 1,
    "loading": true,
    "bottom": 0,
    "top": 1
}
popuplayer.resize = function (params) {
    this.wrap.addClass("nofooter noheader");
    if (this.options.bottom) {
        this.wrap.removeClass("nofooter");
    }
    if (this.options.top) {
        this.wrap.removeClass("noheader");
    }
    this.wrap.show();
    var dict = $.extend(null, {"width": 300, "height": 100, "animate": this.options.animate}, params);
    console.log(dict);
    if (dict.width === this.options.width && dict.height === this.options.height) {
        return this;
    }
    $.extend(this.options, params);
    dict.width = parseInt(dict.width);
    dict.height = parseInt(dict.height);
    if (dict.width < 10) {
        dict.width = 10;
    }
    if (dict.height < 10) {
        dict.height = 10;
    }
    var len = this.options.bottom + this.options.top;

    dict.width += (parseInt(this.wrap.css("border-width")) || 0) * len;
    var h = this.header.height();
    dict.height += h * len + (parseInt(this.wrap.css("border-width")) || 0) * len;

    this.content.css({"top": h * this.options.top, "bottom": h * this.options.bottom});

    $.extend(dict, {"margin-left": -dict.width / 2, "margin-top": -dict.height / 2});
    if (dict.animate > 0) {
        this.wrap.animate(dict, dict.animate);
    } else {
        this.wrap.css(dict);
    }
    return this;
}
popuplayer.display = function (content, title, params) {
    if (content.match(/\.(png|jpg|gif)/)) {
        this.showImage(content, title, params);
    } else {
        this.showIframe(content.replace(/[\?&]TB_[^&]+/i, ""), title, params)
    }
}
popuplayer.show = function (content, title, params) {
    RssWin.MaskLayer.show();
    this.resize(params || {});
    this.title.html(title || "消息提醒");
    this.content.html(content);
}
popuplayer.showImage = function (src, title) {
    var t = this;
    var img = new Image();
    img.onload = function () {
        var params = {"width": img.width, "height": img.height};

        var winw = $(window).width(), winh = $(window).height();
        var xs = img.width > winw ? winw / img.width : img.width / winw, ys = img.height > winh ? winh / img.height : img.height / winh;
        if (img.width < winw && img.height < winh) {
            xs = ys = 1;
        }
        console.log(xs + "," + ys);
        if (xs >= ys) {
            xs = ys;
        }
        xs -= 0.01;
        params.width *= xs;
        params.height *= xs;

        t.show('<img src="' + src + '" />', title || "浏览图片", params);
    }
    img.onerror=function(){
        t.showError("图片不存在！")
    }
    img.src = src;
    return this;
}
popuplayer.showContent = function (content) {
    this.show(content, title, params);
}
popuplayer.showHtml = function (html, title, params) {
    this.show(html, title, params);
}
popuplayer.showIframe = function (href, title, params) {
    this.show('<iframe src="' + href + '"/>', title, params)
}
popuplayer.showError = function (error, options) {
    this.show('<div class="infowrap"><span class="red">' + error + '</span></div>' || "", "信息提示", options || {"width": 300, "height": 50})
}
popuplayer.showLoading = function (load) {
    this.params.loading = load || false;
    return this;
}

//弹出框
if (window.popuplayer) {
    window.popuplayer = popuplayer;
    if (window.parent && window.parent.popuplayer) {
        popuplayer = window.parent.popuplayer;
    }
}

$("[popup]").each(function () {
    var t = $(this);
    t.click(function () {
        var href = t.attr("src") || t.attr("href");
        if (t[0].tagName.toLowerCase() === "img") {
            popuplayer.showImage(href, t.attr("title"));
        } else {
            popuplayer.display(href, t.attr("title"));
        }
    });
});