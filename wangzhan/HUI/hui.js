/// <reference path="external/jquery-v1.10.2/jquery-1.10.2.min.js"/*tpa=http://www.pdsrd.gov.cn:7081/HUI/external/jquery-v1.10.2/jquery-1.10.2.min.js*/ />

//import { param } from "./external/jquery-v1.10.2/jquery-1.10.2.min";

var hui = hui || {};

hui.version = 'v-1.0.1';
hui.CODE_SUCCESS = 100;
hui.GUID_EMPTY = '00000000-0000-0000-0000-000000000000';
hui.browser = {
    ie: / msie /.test(window.navigator.userAgent.toLowerCase()),
    moz: /gecko/.test(window.navigator.userAgent.toLowerCase()),
    opera: /opera/.test(window.navigator.userAgent.toLowerCase()),
    safari: /safari/.test(window.navigator.userAgent.toLowerCase())
};
hui.external = {
    base: '/HUI/external',
    layer: '../layer-v3.1.1/layer.js'/*tpa=http://www.pdsrd.gov.cn:7081/layer-v3.1.1/layer.js*/,
    laydate: '../laydate-v5.0.9/laydate.js'/*tpa=http://www.pdsrd.gov.cn:7081/laydate-v5.0.9/laydate.js*/,
};

(function ($, hui) {
    function paddingLeft(digits, pad) {
        var obj = String(this);
        if (obj.length < digits) {
            while (digits > obj.length) {
                obj = pad + obj;
            }
        }
        return obj;
    };
    function paddingRight(digits, pad) {
        var obj = String(this);
        if (obj.length < digits) {
            while (digits > obj.length) {
                obj = obj + pad;
            }
        }
        return obj;
    };

    String.prototype.paddingLeft = paddingLeft;
    Number.prototype.paddingLeft = paddingLeft;
    String.prototype.paddingRight = paddingRight;
    Number.prototype.paddingRight = paddingRight;

        String.prototype.isEmpty = function () { return /^\s*$/.test(this); }
    String.prototype.Trim = function () { return Trim(this, " "); }
    String.prototype.LTrim = function () { return LTrim(this, " "); }
    String.prototype.RTrim = function () { return RTrim(this, " "); }

        function LTrim(str, letter) {
        var i;
        for (i = 0; i < str.length; i++) {
            if (str.charAt(i) != letter && str.charAt(i) != letter) break;
        }
        str = str.substring(i, str.length);
        return str;
    }

        function RTrim(str, letter) {
        var i;
        for (i = str.length - 1; i >= 0; i--) {
            if (str.charAt(i) != letter && str.charAt(i) != letter) break;
        }
        str = str.substring(0, i + 1);
        return str;
    }

        function Trim(str, letter) {
        return LTrim(RTrim(str, letter), letter);
    }
})(jQuery, hui);
(function ($, hui) {
    hui.eval = function (obj) {
        try {
            if (typeof obj == 'string') {
                if (obj == 'True' || obj == 'False') {
                    obj = obj.toLowerCase();
                }
            }

            return eval('(' + obj + ')');
        } catch (e) {
            return obj;
        }
    };
    hui.formData = function (form) {
        return new FormData($(form)[0]);
    };
    hui.funDownload = function (path, filename) {
                var eleLink = document.createElement('a');
        eleLink.download = filename;
        eleLink.style.display = 'none';
                var blob = new Blob([path]);
        eleLink.href = URL.createObjectURL(blob);
                document.body.appendChild(eleLink);
        eleLink.click();
                document.body.removeChild(eleLink);
        
    };
    hui.parseUrl = function (url, args) {
        if (args != undefined && args != null && typeof (args) == 'object') {
            var ar = new Array();
            $.each(args, function (n, v) {
                ar.push(n + '=' + v);
            });
            if (url.lastIndexOf('?') > -1) {
                url += '&' + ar.join('&');
            } else {
                url += '?' + ar.join('&');
            }
        }

        return url;
    };
    hui.loadJS = function (url, fnCallback) {
        var xmlHttp = null;

        if (window.ActiveXObject)        {
            try {
                                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e) {
                                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        else if (window.XMLHttpRequest)        {
            xmlHttp = new XMLHttpRequest();
        }

                xmlHttp.open("GET", url, false);

                xmlHttp.send(null);

                if (xmlHttp.readyState == 4) {
                        if ((xmlHttp.status >= 200 && xmlHttp.status < 300) || xmlHttp.status == 0 || xmlHttp.status == 304) {

                var myHead = document.getElementsByTagName("body").item(0);
                var _script = document.createElement("script");
                _script.language = "javascript";
                _script.type = "text/javascript";
                _script.src = url;
                _script.onload = _script.onreadystatechange = function (e) {
                    if (typeof (fnCallback) == 'function') {
                        if (hui.browser.ie) {
                            if (this.readyState == 'loaded' || this.readyState == 'complete') {
                                return fnCallback.call(hui);
                            }
                        } else {
                            return fnCallback.call(hui);
                        }
                    }
                }

                try {
                                        _script.appendChild(document.createTextNode(xmlHttp.responseText));
                }
                catch (ex) {
                    _script.text = xmlHttp.responseText;
                }

                myHead.appendChild(_script);

                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    };
    hui.loadCSS = function (url) {
        try {
            var _link = document.createElement('link');
            _link.rel = 'stylesheet';
            _link.type = 'text/css';
            _link.href = url;

            document.getElementsByTagName('head')[0].appendChild(_link);
            return true;
        } catch (e) {
            return false;
        }
    };
    hui.formatString = function (obj, ...args) {
        args = args || [];
        $.each(args, function (i, e) {
            obj = obj.replace('{' + i + '}', e);
        });
        return obj;
    };
    hui.factory = function (plugin, path, domain, fnCallback) {
        if (typeof (fnCallback) == 'function') {
            if (window[plugin] == undefined) {
                hui.loadJS(hui.external.base + path, function () {
                    if (window[plugin] == undefined) {
                        throw plugin + '加载异常';
                    } else {
                        return fnCallback.call(domain, window[plugin]);
                    }
                });
            } else {
                return fnCallback.call(domain, window[plugin]);
            }
        }
    };
    hui.guid = function () {
        var s = [];
        var hexDigits = "0123456789abcdef";
        for (var i = 0; i < 36; i++) {
            s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
        }
        s[14] = "4";          
        s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);          
        s[8] = s[13] = s[18] = s[23] = "-";

        var uuid = s.join("");
        return uuid;
    };
    hui.getUrlParam = function () {
        var param = [];
        if (window.location.search) {
            var search = window.location.search.replace('?', '');
            $.each(search.split('&'), function (i, e) {
                var args = e.split('=');
                param[args[0]] = args[1];
            });
        }
        return param;
    }
    hui.enter = function (elem, fCallback) {
        $(document).on('keydown', elem, function (e) {
            var theEvent = window.event || e;
            var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
            if (code == 13) {
                fCallback && fCallback();
            }
        });
    }

})(jQuery, hui);
(function ($, hui) {
    hui.random = function (min, max) {
        min = parseInt(min);
        max = parseInt(max);
        var Range = max - min;
        var Rand = Math.random();
        var num = min + Math.floor(Rand * Range);         return num;
    };
    hui.random.num = function (len) {
        return this(Math.pow(10, len - 1), Math.pow(10, len));
    };
    hui.random.str = function (len) {
        return this.padding(Math.random().toString(36).substr(2), len);
    };
    hui.random.padding = function (str, len) {
        if (len == -1) return str;
        if (str.length > len) return str.substr(0, len);
        if (str.length < len) return this.padding(str + this.str(-1), len);
        return str;
    }
})(jQuery, hui);
(function ($, hui) {
    hui.date = function (time) {
        try {
            if (typeof (time) == 'string') {
                if (time.indexOf('Date') > -1) {
                    var reg = /\d+/.exec(time);
                    if (reg != null) time = hui.eval(reg[0]);
                } else {
                    time = time.replace('T', ' ');
                }
            }
            var date = new Date(time);
            if (date == 'Invalid Date') throw null;
            return date;
        } catch (e) {
            return new Date('1700-1-1');
        }
    };
    hui.date.format = function (obj, format) {
        var date = this(obj),
            weeksX = ['星期日?', '星期一', '星期二?', '星期三?', '星期四?', '星期五?', '星期六?'],
            weeksZ = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
            year = date.getFullYear(),
            month = date.getMonth() + 1,
            day = date.getDate(),
            hour = date.getHours(),
            minute = date.getMinutes(),
            second = date.getSeconds(),
            week = date.getDay();

        format = format.replace('yyyy', year);
        format = format.replace('MM', month.paddingLeft(2, '0'));
        format = format.replace('dd', day.paddingLeft(2, '0'));
        format = format.replace('hh', hour.paddingLeft(2, '0'));
        format = format.replace('mm', minute.paddingLeft(2, '0'));
        format = format.replace('ss', second.paddingLeft(2, '0'));
        format = format.replace('ww', week);
        format = format.replace('wx', weeksX[week]);
        format = format.replace('wz', weeksZ[week]);
        return format;
    };
})(jQuery, hui);
(function ($, hui) {
    hui.ajax = function (opts) {
        var token = $('input[name=__RequestVerificationToken]').val();

        if (opts.isForm) {
            opts.data.append('__RequestVerificationToken', token);
        } else {
            opts.data = opts.data || {};
            opts.data.__RequestVerificationToken = token;
        }

        var _success = opts.success;
        opts.success = function (result, status, xhr) {
            _success && _success.call(this, result, status, xhr);
        };

        var _error = opts.error;
        opts.error = function (xhr, status, error) {
            if (xhr.status == 302) {
                top.document.location.href = 'http://www.pdsrd.gov.cn:7081/RedirectToLogin.html';
            }
            _error && _error.call(this, xhr, status, error);
        }

        return $.ajax($.extend(true, {}, hui.ajax._defaults, opts));
    };
    hui.ajax.get = function (url, data, func, opts) {
        return this($.extend({ url: url, type: 'get', data: data, success: func }, opts));
    };
    hui.ajax.post = function (url, data, func, opts) {
        return this($.extend({ url: url, type: 'post', data: data, success: func }, opts));
    };
    hui.ajax.sync = function (url, data, func, opts) {
        return this($.extend({ url: url, type: 'post', async: false, data: data, success: func }, opts));
    };
    hui.ajax.form = function (url, data, func, opts) {
        return this($.extend({
            url: url,
            type: 'post',
            data: data,
            success: func,
            dataType: 'JSON',
            cache: false,
            contentType: false,
            processData: false,
            isForm: true,
        }, opts));
    };
    hui.ajax.exportFiles = function (url, data, isForm) {
        debugger;
        var index = layer.load(1);
        if (isForm) {
            hui.ajax.form(url, data, function (result) {
                if (result.Code == 100) {
                    layer.close(index);
                    var data = hui.eval(result.Data);
                    window.location.href = "http://www.pdsrd.gov.cn:7081/BizCommonManage/AjaxResult/DownTempFiles?filePath=" + data.FilePath;
                } else {
                    layer.close(index);
                    hui.layer.error(result.Message);
                }
            });
        } else {
            hui.ajax.post(url, data, function (result) {
                if (result.Code == 100) {
                    layer.close(index);
                    var data = hui.eval(result.Data);
                    window.location.href = "http://www.pdsrd.gov.cn:7081/BizCommonManage/AjaxResult/DownTempFiles?filePath=" + data.FilePath;
                } else {
                    layer.close(index);
                    hui.layer.error(result.Message);
                }
            });
        }

    }
    hui.ajax._defaults = {
        url: '',
        type: 'post',
        async: true,                 
        cache: true,         
        data: null,         
        dataType: null,         
        contentType: 'application/x-www-form-urlencoded',                                     }
})(jQuery, hui);
(function ($, hui) {
    hui.device = {
        version: function () {
            var app = navigator.appVersion,
                left = app.indexOf('('),
                right = app.indexOf(')'),
                result = app.substring(left + 1, right).split(';'),
                data = { type: 0 };

            if (/window/i.test(result[0])) {
                if (result[1]) {
                    var ver = result[1].split(' ');

                    data.type = 101;
                    data.model = result[0];
                    data.version = ver[1];
                }
            } else if (/iphone/i.test(result[0])) {
                var ver = result[1].replace(/^\s+|\s+$/g, "").split(' ');

                data.type = 201;
                data.model = result[0];
                data.version = ver[1] + ' ' + ver[2] + ' ' + ver[3];
            } else if (/ipad/i.test(result[0])) {
                var ver = result[1].replace(/^\s+|\s+$/g, "").split(' ');

                data.type = 202;
                data.model = result[0];
                data.version = ver[1] + ' ' + ver[2];
            } else if (/linux/i.test(result[0])) {
                data.type = 301;

                if (/android/i.test(result[2])) {
                    data.model = result[4];
                    data.version = result[2];
                } else {
                    data.model = result[2];
                    data.version = result[1];
                }
            }

            return data;
        }(),
        isWeiXin: function () {
            return navigator.userAgent.toLowerCase().indexOf('micromessenger') !== -1;
        }(),
    }
})(jQuery, hui);
(function ($, hui) {
    hui.parse = {
        eval: function (obj) {
            try {
                return eval('(' + obj + ')');
            } catch (e) {
                console.log(e);
                return obj;
            }
        },
        date: function (obj) {
            try {
                obj = obj.replace('T', ' ');
                return new Date(obj);
            } catch (e) {
                console.log(e);
                return new Date('1700-1-1');
            }
        },
        dateFormat: function (obj, format) {
            var date = hui.parse.date(obj);
            var weekAr = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
            var weekArr = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
            var year = date.getFullYear(),
                month = date.getMonth() + 1,
                day = date.getDate(),
                hour = date.getHours(),
                minute = date.getMinutes(),
                second = date.getSeconds(),
                week = date.getDay();
            format = format.replace('yyyy', year);
            format = format.replace('MM', month);
            format = format.replace('dd', day);
            format = format.replace('hh', hour.paddingLeft(2, '0'));
            format = format.replace('mm', minute.paddingLeft(2, '0'));
            format = format.replace('ss', second.paddingLeft(2, '0'));
            format = format.replace('ww', week);
            format = format.replace('tt', weekArr[week]);
            format = format.replace('WW', weekAr[week]);
            return format;
        },
    }
})(jQuery, hui);
(function ($, hui) {
    hui.layer = function (opts) {
        return hui.layer.factory(function (o) {
            opts = $.extend({}, this.defaults, opts);

            if (opts.area == undefined || opts.area == null) {
                opts.area = this.defaults.area;
            }

            var success = opts.success;
            opts.success = function (layero) {
                hui.layer.auto(layero);
                var min = layero.find('.layui-layer-min');
                var max = layero.find('.layui-layer-max');
                var close = layero.find('.layui-layer-close');

                min.attr('title', '最小化');
                max.attr('title', '还原');
                close.attr('title', '关闭');

                success && success(layero);
            };

            return o.open($.extend({}, this.defaults, opts));
        });
    };
    hui.layer.msg = function (content, time, fnEnd, opts) {
        /* msg和open方法调用的样式不同，msg方法调用close按钮会有样式�?�?
         * 所以这里根�?�?否需要调用close按钮区分2种方法调�?
         */
        return this.factory(function (o) {
            opts = $.extend({ time: time, end: fnEnd }, opts);

            if (opts.time == 0) {
                opts.title = null;
                opts.btn = null;
                opts.closeBtn = 2;
                opts.content = content;
                opts.end = fnEnd;
                return this(opts);
            } else {
                opts.time = opts.time || 2000;
                return o.msg(content, opts);
            }
        });
    };
    hui.layer.success = function (content, time, fnEnd, opts) {
        opts = $.extend({ icon: 1 }, opts);
        return this.msg(content, time, fnEnd, opts);
    };
    hui.layer.error = function (content, time, fnEnd, opts) {
        opts = $.extend({ icon: 2 }, opts);
        return this.msg(content, time, fnEnd, opts);
    };
    hui.layer.confirm = function (title, content, fnYes, fnNo, opts) {
        return this.factory(function (o) {
            opts = $.extend({ title: (title || '提示') }, opts);
            return o.confirm(content, opts, function (index, layero) {
                if (typeof (fnYes) == 'function' && fnYes.call(this, index, layero) != false) {
                    hui.layer.close(index);
                }
            }, function (index, layero) {
                if (typeof (fnNo) == 'function') {
                    fnNo.call(this, index, layero);
                }
            });
        });
    };
    hui.layer.content = function (title, content, area, fnEnd, opts) {
        return this($.extend({
            type: 1,
            title: title,
            content: content,
            area: area || 'auto',
            end: fnEnd
        }, opts));
    };
    hui.layer.iframe = function (title, content, area, fnEnd, opts) {

        var that = this;
        var full = false;
        var index = -1;
        opts = opts || {};

        if (area == undefined || area == null) {
            full = true;
            
            area = ['100%', '100%'];
        }

        var success = opts.success;
        opts.success = function (layero) {
            layero.css('visibility', 'visible');
            
            success && success(layero);
        };

        var restore = opts.restore;
        opts.restore = function (layero) {
            layero.css('top', (window.innerHeight - layero.height()) / 2);
            layero.css('left', (window.innerWidth - layero.width()) / 2);

            restore && restore();
        };

        var obj = {
            type: 2,
            title: title,
            content: content,
            area: area,
            end: fnEnd,
            maxmin: full
        };
        index = this($.extend(obj, opts));
        return full && this.full(index), index;

    };
    hui.layer.load = function (type, time) {
        return this.factory(function (o) {
            return o.load(type, { time: time });
        });
    };
    hui.layer.full = function (index) {
        return this.factory(function (o) {
            o.full(index);
        });
    };
    hui.layer.auto = function (layero) {
        var title = layero.find('.layui-layer-title');
        var iframe = layero.find('iframe');
        var context = iframe.contents();
        var container = context.find('.hui-layer-container');

        if (container.hasClass('hui-layer-auto')) {
            var body = context.find('.hui-layer-body');
            var foot = context.find('.hui-layer-foot');
            iframe.css('height', body[0].scrollHeight + foot[0].scrollHeight + 2);
            layero.css('height', iframe.height() + title.height());
        }
    };
    hui.layer.close = function (index) {
        return this.factory(function (o) {
            if (index) return layer.close(index);

            index = parent.layer.getFrameIndex(window.name) * 1;
            if (index > 0) return parent.layer.close(index);

            index = layer.index;
            if (index > 0) return layer.close(index);
        });
    };
    hui.layer.factory = function (fnCallback) {
        return hui.factory('layer', hui.external.layer, this, fnCallback);
    };
    hui.layer.defaults = {
        skin: 'hz-laydate-skin',
        lang: 'en',
        type: 0,         
        title: '信息',
        content: '',
        area: 'auto',         
        offset: 'auto',         
        closeBtn: 1,         
        shade: 0.3,         
        shadeClose: false,         
        time: 0,         
        anim: 0,         
        isOutAnim: true,         
        maxmin: true,         
        fixed: true,         
        resize: true,         
        resizing: null,         
        scrollbar: true,         
        maxWidth: 360,         
        maxHeight: null,         
        move: '.layui-layer-title',         
        moveOut: false,         
        moveEnd: null,         
        success: null,         
        cancel: null,         
        end: null,             
    };
})(jQuery, hui);
(function ($, hui) {
    hui.laydate = function (elem, opts) {
        return hui.laydate.factory(function (o) {
            $(elem).each(function () {
                var _opts = $.extend({}, hui.laydate.defaults, opts);
                var value = _opts.value || this.value;
                _opts.elem = this;
                _opts.value = value ? hui.date(value) : '';
                _opts.type = $(this).data('type') || _opts.type;
                _opts.format = $(this).data('format') || _opts.format;
                o.render(_opts);
            });
        });
    };
    hui.laydate.format = function (value, type) {
        if (value) {
            var format = '';

            switch (type) {
                case 'year':
                    format = 'yyyy';
                    break;
                case 'month':
                    format = 'yyyy-MM';
                    break;
                case 'date':
                    format = 'yyyy-MM-dd';
                    break;
                case 'time':
                    format = 'hh:mm:ss';
                    break;
                case 'datetime':
                    format = 'yyyy-MM-dd hh:mm:ss';
                    break;
                default:
                    break;
            }

            value = hui.date.format(value, format);
        }
    };
    hui.laydate.factory = function (fnCallback) {
        return hui.factory('laydate', hui.external.laydate, this, fnCallback);
    };
    hui.laydate.defaults = {
        elem: '',
        type: 'date',         
        range: false,         
        format: 'yyyy-MM-dd',         
        value: '',
        isInitValue: true,
        trigger: 'click',
        lang: 'cn',         
        calendar: false,                                 
    };
})(jQuery, hui);
(function ($, hui) {
    hui.bsTable = function (obj, opts) {
        this._factory();
        this.table = $(obj);
        this.opts = $.extend({}, hui.bsTable._defaults, opts);
    };
    hui.bsTable.prototype.init = function () {
        this.defaultOptions();
        this.table.bootstrapTable(this.opts);
        return this;
    };
    hui.bsTable.prototype.config = function (opts) {
        $.extend(this.opts, opts);
    };
    hui.bsTable.prototype.setUrl = function (url) {
        this.opts.url = url;
    };
    hui.bsTable.prototype.setQuery = function (func) {
        this.opts._queryParams.push(func);
        //this.opts.queryParams = func;
    };
    hui.bsTable.prototype._setQuery = function (obj) {
        this.opts._param = $.extend({}, this.opts._param, obj);
    };
    hui.bsTable.prototype.setHeight = function (height) {
        var $tool = $('.fixed-table-toolbar', this.table);
        var $cntr = $('.fixed-table-container', this.table);
        var $foot = $('.fixed-table-pagination', this.table);

        height = height || window.innerHeight;
        height -= $tool.height();
        height -= $foot.height();

        $cntr.css('height', height);
    };
    hui.bsTable.prototype.setColumns = function (column) {
        this.opts.columns = column;
    };
    hui.bsTable.prototype.addColumns = function (column) {
        if (!$.isArray(this.opts.columns)) this.opts.columns = [];
        this.opts.columns.push(column);
    };
    hui.bsTable.prototype.getData = function () {
        return this.table.bootstrapTable('getData');
    };
    hui.bsTable.prototype.getSelections = function () {
        return this.table.bootstrapTable('getSelections');
    };
    hui.bsTable.prototype.getRowNum = function (index) {
        var opts = this.methods('getOptions');
        var limit = opts.pageNumber;
        var offset = opts.pageSize == 'All' ? 99999999 : opts.pageSize;

        return ((limit - 1) * offset) + index + 1;
    };
    hui.bsTable.prototype.methods = function (method, param) {
        return this.table.bootstrapTable(method, param);
    };
    hui.bsTable.prototype.refresh = function () {
        //this.table.bootstrapTable('refresh', params);
        this.table.bootstrapTable('refreshOptions', { pageNumber: 1 });
    };
    hui.bsTable.prototype.refreshOptions = function (opts) {
        opts = opts || {};
        this.table.bootstrapTable('refreshOptions', opts);
    };
    hui.bsTable.prototype.defaultOptions = function () {
        var curThis = this;

        if ($(this.opts.toolbar).length == 0) this.opts.toolbar = null;

        this.opts.queryParams = function (param) {
            var q = this;
            $.each(curThis.opts._queryParams, function () {
                this.call(q, param);
            });

            return param;
        };

        this.opts.responseHandler = function (res) {
            res = hui.eval(res);
            if (res.Code == hui.CODE_SUCCESS) {
                return hui.eval(res.Data) || [];
            } else {
                throw res.Message;
            }
        };
    };
    hui.bsTable.prototype._factory = function () {
        if (!$.fn.bootstrapTable) throw 'Not loaded [bootstrapTable-v3]';
    };
    hui.bsTable._defaults = {
        url: '',
        toolbar: '#hui-toolbar',
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        sidePagination: "server",                 
        clickToSelect: true,         
        striped: true,                                
        pagination: true,        
        pageSize: 10,        
        pageList: [10, 25, 50, 100, 200, 500, 'ALL'],         
        cache: false,        
        detailView: false,                         
        _queryParams: [],
    };
})(jQuery, hui);
(function ($, hui) {
    hui.selectpicker = {
        show: function (obj) {
            $(obj).selectpicker('show');
        },
        hide: function (obj) {
            $(obj).selectpicker('hide');
        },
        setItem: function (obj, data) {
            obj = $(obj).empty();

            $.each(data || [], function () {
                var option = $('<option>').html(this.Text).val(this.Value).appendTo(obj);
                if (this.Selected) {
                    option.attr('selected', true);
                }
            });

            hui.selectpicker.refresh(obj);
        },
        setValue: function (obj, value) {
            return $(obj).selectpicker('val', value);
        },
        getValue: function (obj) {
            return $(obj).selectpicker('val');
        },
        refresh: function (obj) {
            $(obj).selectpicker('refresh');
        },
        render: function (obj) {
            $(obj).selectpicker('render');
        },
    }
})(jQuery, hui);
(function ($, hui) {
    var handle = function (opts) {
        this.init(opts);
    }
    handle.prototype.init = function (opts) {
        this.opts = $.extend({}, deft.opts, opts);
        this.cntr = $(this.opts.cntr);
    }
    handle.prototype.request = function (data) {
        if (this.opts.url) {
            var that = this;
            $.ajax({
                url: that.opts.url,
                data: data,
                type: 'post',
                dataType: 'json',
                async: false,
                cache: false,
                success: function (result, status, xhr) {
                    if (result.Code == hui.CODE_SUCCESS) {
                        that.renderData(result.Data);
                    }
                }
            });
        }
    }
    handle.prototype.renderData = function (data) {
        var that = this;
        this.cntr.empty();
        $.each(data, function (i, e) {
            that.renderItem(e);
        });
        this.renderPicker();
    }
    handle.prototype.renderItem = function (data) {
        var item = $('<option>').appendTo(this.cntr);
        item.val(data.Value).html(data.Text);

        if (data.Selected) {
            item.attr('selected', 'selected');
        }
    }
    handle.prototype.renderPicker = function () {
        this.cntr.selectpicker('refresh');
    }

    var deft = {
        opts: { cntr: null, url: null }
    }

    hui.picker = handle;
})(jQuery, hui);
(function ($, hui) {
    hui.media = function (obj) {
        this.elem = $(obj)[0];
        this.opts = {};
        this.init();
    };
    hui.media.prototype.init = function () {
        this.opts.container = this.elem;
        this.opts.mediaId = 'hui-media-' + hui.random.str(4);
        this.opts.mediaUrl = util.parseFileUrl(this.elem);
        this.opts.mediaExt = util.parseFileExt(this.opts.mediaUrl);
        this.opts.mediaType = util.parseFileType(this.opts.mediaExt);
        this.opts.mediaName = util.parseFileName(this.opts.mediaUrl);
    };
    hui.media.prototype.play = function () {
        switch (this.opts.mediaType) {
            case 'PHOTO':
                fnPhotoPlayer(this.opts);
                break;
            case 'VIDEO':
                fnVideoPlayer(this.opts);
                break;
            case 'VOICE':
                fnVoicePlayer(this.opts);
                break;
            case 'FILES':
                fnFilesPlayer(this.opts);
                break;
            default:
                break;
        }
    };
    function fnPhotoPlayer(opts) {
        var content = $('<img>').appendTo('body').hide();
        content.attr({ src: opts.mediaUrl, title: opts.mediaName });
        content.addClass('hui-media-photo');
        content.css('maxWidth', window.innerWidth * 0.9);
        content.css('maxHeight', window.innerHeight * 0.9);
        content.load(function () {
            return util.showMedio(content);
        }).error(function () {
            hui.layer.error('图片加载异常');
        });
    };
    function fnVideoPlayer(opts) {
        var cntr = $('<div>').appendTo('body').hide();
        cntr.attr('id', opts.mediaId);
        cntr.css('width', window.innerWidth * 0.8);
        cntr.css('height', window.innerHeight * 0.8);

        return util._vPlayer(cntr, opts.mediaUrl);
    };
    function fnVoicePlayer(opts) {
        var cntr = $('<div>').appendTo('body').hide();
        cntr.attr('id', opts.mediaId);
        cntr.css('width', window.innerWidth * 0.8);
        cntr.css('height', window.innerHeight * 0.8);

        return util._vPlayer(cntr, opts.mediaUrl);
    };
    function fnFilesPlayer(opts) {
        return util._fPlayer(opts.mediaUrl);
    };
    var util = {
        TYPE_PHOTO: ['.JPG', '.JPEG', '.PNG', '.BMP'],
        TYPE_VIDEO: ['.MP4'],
        TYPE_VOICE: ['.MP3'],
        TYPE_FILES: ['.PDF'],
        parseFileUrl: function (elem) {
            return $(elem).data('mediaurl') || elem.href;
        },
        parseFileExt: function (url) {
            if (url && url.length > 0 && url.indexOf('.') != -1) {
                return url.substr(url.lastIndexOf('.')).toUpperCase();
            }
            return null;
        },
        parseFileName: function (url) {
            return url.substr(url.lastIndexOf('/') + 1);
        },
        parseFileType: function (ext) {
            if ($.inArray(ext, util.TYPE_PHOTO) > -1) {
                return 'PHOTO';
            } else if ($.inArray(ext, util.TYPE_VIDEO) > -1) {
                return 'VIDEO';
            } else if ($.inArray(ext, util.TYPE_VOICE) > -1) {
                return 'VOICE';
            } else if ($.inArray(ext, util.TYPE_FILES) > -1) {
                return 'FILES';
            } else {
                return null;
            }
        },
        showMedio: function (content) {
            hui.layer({
                type: 1,
                title: null,
                                area: ['auto'],
                skin: 'layui-layer-nobg',                 shadeClose: true,
                content: content,
                end: function () {
                    content.remove();
                },
                success: function (layero) {
                    layero.css('visibility', 'visible');
                }
            });
        },
        _vPlayer: function (container, mediaUrl) {
            if (!window.ckplayer) throw 'Not loaded ckplayer-v.x';

            var player = new ckplayer({
                container: '#' + container.attr('id'),                
                variable: 'player',                
                flashplayer: false,                
                video: mediaUrl            
            });

            player.addListener('loadedmetadata', function () {
                util.showMedio(container);
            });

            player.addListener('error', function () {
                container.remove();
            });

            return player;
        },
        _fPlayer: function (mediaUrl) {
            var href = 'http://www.pdsrd.gov.cn:7081/HUI/external/pdfjs/web/viewer.html?file=' + mediaUrl;
            var cntr = $('<iframe>').appendTo('body').hide();
            cntr.attr({ src: href });
            cntr.css('border', 0);
            cntr.css('width', window.innerWidth * 0.9);
            cntr.css('height', window.innerHeight * 0.8);

            util.showMedio(content);
        },
    };
})(jQuery, hui);
(function ($, hui) {
    hui.validation = function (cntr, opts) {
        this.cntr = $(cntr);
        this.opts = opts;

        this.init();
    };
    hui.validation.register = function (regExp) {
        $.extend(util.defaults.regExp, regExp);
    };
    hui.validation.prototype.init = function (opts) {
        return this.opts = $.extend({}, util.defaults, this.opts, opts), this.bind(), this;
    };
    hui.validation.prototype.bind = function () {
        var curThis = this;
        $(this.cntr).on(this.opts.trigger, '[data-' + this.opts.key + ']', function () {
            curThis.validate(this);
        });
    };
    hui.validation.prototype.validate = function (elem) {
        var curThis = this, valid = elem ? $(elem) : $(util.getValid(this.cntr, this.opts.key)), result = true, isBlur = elem ? true : false;
        $.each(valid, function (i, e) {
            var regOpt = util.getRegOpt(e, curThis.opts.key), r = true;
            $.each(regOpt.regAr, function (o, r) {
                var regx = util.parseRegExp(r, curThis.opts.regExp);
                if (!regx) return true;

                regx.text = regOpt.info || regx.text;

                util.clearTip(e);
                util.doValidate(regOpt, regx);
                if (regx.result == false) {
                    if (isBlur == false) {
                        $(e).focus();
                        isBlur = true;
                    }
                    util.showTip(regOpt.elem, regx.text);
                    return result = result && false, false;
                }
            });
        });

        return result;
    };
    hui.validation.prototype.register = function (regExp) {
        $.extend(this.opts.regExp, regExp);
    };

    var util = {
        parseRegExp: function (reg, regExp) {
            var regx = null, r = null,
                lenReg = /^(\d+)-(\d+)$/,                    
                numReg = /n(\d+)-(\d+)/,                 
                strReg = /s(\d+)-(\d+)/,                 
                chnReg = /c(\d+)-(\d+)/;  
            if (lenReg.test(reg) && (r = lenReg.exec(reg))) {
                regx = util.parseRegObj(reg, lenReg, '^[\\w\\W]{{0},{1}}$', '请输�?{0}-{1}�?字�?�串');
            } else if (numReg.test(reg) && (r = numReg.exec(reg))) {
                regx = util.parseRegObj(reg, numReg, '^\\d{{0},{1}}$', '请输�?{0}-{1}�?数字');
            } else if (strReg.test(reg) && (r = strReg.exec(reg))) {
                regx = util.parseRegObj(reg, strReg, '^[0-9a-z]{{0},{1}}$', '请输�?{0}-{1}�?字母或数�?');
            } else if (chnReg.test(reg) && (r = chnReg.exec(reg))) {
                regx = util.parseRegObj(reg, chnReg, '^[\\u4E00-\\u9FA5\\uf900-\\ufa2d]{{0},{1}}$', '请输�?{0}-{1}�?�?文字�?');
            } else {
                regx = regExp[reg] || { reg: reg, text: 'falid' };
                regx.reg == '*' && (regx.text = '不能为空');

            }
            regx.result = true;
            regx.reg.lastIndex = 0;
            return regx;
        },
        parseRegObj: function (reg, ext, exp, txt) {
            var regx = ext.test(reg) ? ext.exec(reg) : null;
            return regx && {
                reg: new RegExp(hui.formatString(exp, reg[1], reg[2])),
                text: hui.formatString(txt, reg[1], reg[2])
            };
        },
        getInfo: function (elem) {
            return $(elem).data('info');
        },
        getValue: function (elem) {
            return $.trim(elem.value);
        },
        getValid: function (cntr, key) {
            var elems = new Array();
            elems = elems.concat(util.getElems(cntr, key, 'input'));
            elems = elems.concat(util.getElems(cntr, key, 'select'));
            elems = elems.concat(util.getElems(cntr, key, 'textarea'));
            return elems;
        },
        getElems: function (cntr, key, tag) {
            return cntr.find(tag + '[data-' + key + ']').toArray();
        },
        getRegOpt: function (elem, key) {
            return elem && {
                elem: elem,
                type: elem.tagName.toUpperCase(),
                info: util.getInfo(elem),
                value: util.getValue(elem),
                regAr: util.getRegAr(elem, key),
            }
        },
        getRegAr: function (elem, key) {
            var reg = $(elem).data(key);
            return typeof reg == 'string' && reg.indexOf('|') > -1 ? reg.split('|') : [reg];
        },
        doValidate: function (regOpt, regx) {
            if (typeof regx.reg == 'string' && regx.reg.length > 0) {
                util._validateFunc(regOpt, regx);
                util._validateEqual(regOpt, regx);
                util._validateEmpty(regOpt, regx);
            } else if (typeof regx.reg == 'object') {
                util._validate(regOpt, regx);
            }

            return regx;
        },
        showTip: function (elem, text) {
            var $tip = elem.hui_tip || $('<div>'),
                offset = $(elem).offset();

            elem.hui_tip = $tip;
            offset.top += elem.offsetHeight + 10;
            offset.left += elem.offsetWidth - 60;
            $tip.addClass('hui-validation-container hui-arrow hui-arrow-top')
                .html(text)
                .insertAfter(elem)
                .offset(offset);
        },
        clearTip: function (elem) {
            $(elem.hui_tip).remove();
        },
        _validate: function (regOpt, regx) {
            regOpt.value && (regx.result = regx.reg.test(regOpt.value));
        },
        _validateFunc: function (regOpt, regx) {
            var m = regx.reg.match(/(fn:)([\s\S]*)/),
                f = m != null && window[m[2]],
                r = { text: '', result: true };

            if ($.isFunction(f)) {
                var b = f.call(regOpt.elem, regOpt.value);
                if (typeof b == 'boolean') {
                    regx.result = regx.result && b;
                } else if (typeof b == 'object') {
                    regx.result = regx.result && b.result;
                    regx.text = b.text || regx.text;
                } else {
                    regx.result = false;
                }
            }
        },
        _validateEqual: function (regOpt, regx) {
            var m = regx.reg.match(/([>|=|<|>=|<=])([\s\S]*)/),
                f = m != null && hui.formatString('"{0}"{1}"{2}"', regOpt.value, m[1], $(m[2]).val());

            if (f) {
                regx.result = regx.result && (hui.eval(f) == true);
            }
        },
        _validateEmpty: function (regOpt, regx) {
            if (regx.reg == '*') {
                regx.result = regx.result && regOpt.value && regOpt.value.length > 0;
            }
        },
        defaults: {
            key: 'valid',
            trigger: 'blur',
            regExp: {
                                w: {
                    reg: /^\S+$/g,
                    text: '不能为空'
                },
                                s: {
                    reg: /^[0-9a-zA-Z]+/i,
                    text: '�?能输入字母和数字'
                },
                                n: {
                    reg: /^[0-9]+\.?[0-9]*$/,
                    text: '�?能输入数�?'
                },
                                twosign: {
                    reg: /^(-)?\d{0,10}(\.\d{0,2})?$/,
                    text: '�?能输入�?�数负数�?0，小数点后最�?2�?'
                },
                                allnatural: {
                    reg: /^(\-|\+)?\d+(\.\d+)?$/,
                    text: '�?能输入数�?'
                },
                                natural: {
                    reg: /^(0|[1-9][0-9]*)$/,
                    text: '必须输入大于等于0的整�?'
                },
                                n0_9: {
                    reg: /^([0-9]*)$/,
                    text: '必须输入0-9的整�?'
                },
                                c: {
                    reg: /^[\u4E00-\u9FA5\uf900-\ufa2d]+$/,
                    text: '�?能输入中�?'
                },
                                e: {
                    reg: /^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}$/i,
                    text: '�?箱格式不正确'
                },
                                time: {
                    reg: /^([01][0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?$/img,
                    text: '时间格式不�?�确,格式�? HH:mm:ss �? HH:mm'
                },
                                date: {
                    reg: /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))( (20|21|22|23|[0-1]?\d):[0-5]?\d(:[0-5])?\d?)?$/img,
                    text: '日期格式不�?�确,格式�?:yyyy-MM-dd HH:mm:ss �? yyyy-MM-dd HH:mm'

                },
                                post: {
                    reg: /^[1-9][0-9]{5}$/,
                    text: '�?编不正确'
                },
                                tel: {
                    reg: /(^((199)|(198)|(166)|(13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0-9])|(17[0-9]))\d{8}$)|(^(0\d{2}-\d{8}(-\d{1,4})?)|(0\d{2,3}-\d{7,8}(-\d{1,4})?)$)/,
                    text: '0xx(x)-xxxxxxx(x) �? 1xxxxxxxxxx'
                },
                                homePhone: {
                    reg: /(^(0\d{2}-\d{8}(-\d{1,4})?)|(0\d{2,3}-\d{7,8}(-\d{1,4})?)$)/,
                    text: '0xx(x)-xxxxxxx(x)'
                },
                                mobilePhone: {
                    reg: /(^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0-9])|(17[0-9])|166|198|199)\d{8}$)/,
                    text: '1xxxxxxxxxx'
                },
                                datetime: {
                    reg: /^(((1[8-9]\d{2})|([2-9]\d{3}))([-\/])(10|12|0?[13578])([-\/])(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/])(11|0?[469])([-\/])(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))([-\/])(0?2)([-\/])(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)([-\/])(0?2)([-\/])(29)$)|(^([3579][26]00)([-\/])(0?2)([-\/])(29)$)|(^([1][89][0][48])([-\/])(0?2)([-\/])(29)$)|(^([2-9][0-9][0][48])([-\/])(0?2)([-\/])(29)$)|(^([1][89][2468][048])([-\/])(0?2)([-\/])(29)$)|(^([2-9][0-9][2468][048])([-\/])(0?2)([-\/])(29)$)|(^([1][89][13579][26])([-\/])(0?2)([-\/])(29)$)|(^([2-9][0-9][13579][26])([-\/])(0?2)([-\/])(29))|(((((0[13578])|([13578])|(1[02]))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|((([469])|(11))[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\-\/\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\-\/\s]?\d{4})\s(((0[1-9])|([1-9])|(1[0-2])))&/mg,
                    text: '日期格式不�?�确,格式�?:yyyy-MM-dd'
                },
                                nick: {
                    reg: /^[0-9a-zA-Z\u4e00-\u9fa5]+[0-9a-zA-Z\u4e00-\u9fa5\u2669-\u266f_-]*$/i,
                    text: '�?能输入中文、英文、数字和下划�?(_)'
                },
                                fax: {
                    reg: /^(\d{3,4}-)?\d{7,8}$/,
                    text: '传真格式不�?�确'
                },
                                password: {
                    reg: /^[\w\W]{6,20}$/,
                    text: '密码长度须为6-20�?'
                },
                                weburl: {
                    reg: /^(https?:\/\/)/,
                    text: '必须�?http:'                
                }
            }
        },
    }
})(jQuery, hui);
(function ($, hui) {
    hui.table = function (cntr, opts) {
        this.cntr = cntr;
        this.opts = opts;

        this.init();
    };
    hui.table.prototype.init = function () {
        this.cntr = $(this.cntr).addClass('hui-table').empty();
        this.opts = $.extend({}, defs.opts, this.opts);
        this.head = $('<thead>').appendTo(this.cntr);
        this.body = $('<tbody>').appendTo(this.cntr);
        if (this.opts.head == false) {
            this.head.hide();
        }

        var data = func.parseHead(this.opts.cols);
        func.addRow(this.head, this.opts.cols, data, true);
    };
    hui.table.prototype.addRow = function (data) {
        if (data == undefined || data == null) return;

        return func.addRow(this.body, this.opts.cols, data);
    };
    hui.table.prototype.getRows = function () {
        return this.body.children('tr');
    };
    hui.table.prototype.empty = function () {
        this.body.empty();
    }

    var defs = {
        opts: {
            head: true,
            cols: [],
        },
        cols: {
            field: '',
            title: '',
            class: '',
            width: '',
            minWidth: '',
            format: null,
        }
    }, func = {
        parseData: function (data) {
            return $.isArray(data) ? data : [data];
        },
        parseHead: function (cols) {
            var data = {};
            $.each(cols, function () {
                var col = $.extend({}, defs.cols, this);
                data[col.field] = col.title;
            });
            return data;
        },
        addRow: function (cntr, cols, data, head) {
            var row = $('<tr>').appendTo(cntr);
            row.data('data', data);
            func.addCel(row, cols, data, head);
            return row;
        },
        addCel: function (cntr, cols, data, head) {
            $.each(cols, function (i, e) {
                var col = $.extend({}, defs.cols, this);
                var val = data[col.field];
                var cel;

                if (head == true) {
                    cel = $('<th>').appendTo(cntr);
                    col.width && cel.css('width', col.width);
                    col.minWidth && cel.css('min-width', col.minWidth);
                    val = val.replace('*', '<span style="color: red">（必�?�?</span>');
                } else {
                    cel = $('<td>').appendTo(cntr);
                    col.width && cel.css('width', col.width);

                    if ($.isFunction(col.format)) {
                        val = col.format.call(cel, val, data, cntr, cntr.index());
                    }
                }

                if (col.class) {
                    cel.addClass(col.class);
                }

                cel.append(val);
            });
        },
    }

})(jQuery, hui);
(function ($, hui) {
    hui.single = function (trigger, selector, func) {
        $(document).on(trigger, selector, function () {
            if (this.disabled == true) {
                return false;
            }

            this.disabled = true;
            if (func() == true) {
                this.disabled = false;
            }
        })
    }
})(jQuery, hui);
(function ($, hui) {
    hui.lock = function (fCallback, elem) {
        this.context = new handler((lock) => {
            if (elem instanceof HTMLElement) {
                if (lock == true)
                    $(elem).prop('disabled', true).addClass('disabled');
                else
                    $(elem).prop('disabled', false).removeClass('disabled');
            }
        });
        this.context.func(fCallback);
    }

    var handler = function (raise) {
        if (window.static == undefined) {
            window.static = new Object();
        }
        if (window.static.lock == undefined) {
            window.static.lock = false;
        }

        this.raise = raise;
        this.static = window.static;
    }
    handler.prototype.lock = function () {
        this.static.lock = true;
        this.call(this.raise, this.static.lock);
    }
    handler.prototype.unlock = function () {
        this.static.lock = false;
        this.call(this.raise, this.static.lock);
    }
    handler.prototype.func = function (func) {
        if (this.static.lock == false) {
            this.lock();
            if (this.call(func, this) != false) {
                this.unlock();
            }
        }
    }
    handler.prototype.call = function (func, args) {
        if (typeof func == 'function') {
            return func(args);
        }
    }

})(jQuery, hui);




