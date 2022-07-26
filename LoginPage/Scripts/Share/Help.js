var Help = (function () {
    function Help() {
        /**
        *获取flash版本号
        */
        this.flashVersion = this.getFlashVersion();
        /**
        *获取服务器地址
        */
        this.serverPath = this.getWebServerPath();
        //this.serverPath = "http://58.16.86.103:8086/";        
        /*---------------------字段方式二-------------------------*/
        /**
        * 判断浏览器是否支持图片的base64
        */
        this.isSupportBase64 = function () {
            var data = new Image();
            var support = true;
            data.onload = data.onerror = function () {
                if (this.width != 1 || this.height != 1) {
                    support = false;
                }
            };
            data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
            return support;
        };
    }
    /**
    * 获取网址路径(含第一个文件目录)
    */
    Help.prototype.getDocumentPath = function () {
        var curWwwPath = window.document.location.href;
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        var localhostPaht = curWwwPath.substring(0, pos);
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return localhostPaht + projectName;
    };
    /**
    * 获取网址路径(含第一个文件目录)---------------------------服务器改地址------------------
    */
    Help.prototype.getWindowtPath = function () {
        var hostPath = window.location.host;
        var pathName = window.location.pathname;
        return 'http://' + hostPath + '/' + pathName.split('/')[1]; //服务器地址
    };
    /**
    * 获取url参数部分
    */
    Help.prototype.getUrlParams = function () {
        var url = decodeURI(location.search); //获取url中"?"符后的字串   
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            var strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = decodeURI(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    };
    /**
    * 获取文本信息
    * @param url 文件地址
    * @param success 成功使用的函数
    * @param error 失败使用的函数
    */
    Help.prototype.getDocumentContent = function (option) {
        var oAjax;
        //1.创建ajax对象
        if (XMLHttpRequest) {
            oAjax = new XMLHttpRequest();
        }
        else {
            oAjax = new ActiveXObject("Microsoft.XMLHTTP");
        }
        //2.链接服务器（打开服务器的连接）
        //open(方法，文件名，异步传输)
        oAjax.open('get', option.url, true);
        //3.发送
        oAjax.send();
        //4.接收返回
        oAjax.onreadystatechange = function () {
            if (oAjax.readyState == 4) {
                if (oAjax.status == 200) {
                    option.success(oAjax.responseText);
                }
                else {
                    option.error(oAjax);
                }
            }
            ;
        };
    };
    /**
    * 动态创建script
    * @param content 脚本中的代码内容
    */
    Help.prototype.setCreatScript = function (content) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        try {
            script.appendChild(document.createTextNode(content));
        }
        catch (ex) {
            script.text = content;
        }
        document.body.appendChild(script);
    };
    /**
    * 动态引用script
    * @param url script脚本地址
    */
    Help.prototype.setQuoteScript = function (url) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = url;
        document.getElementsByTagName('HEAD').item(0).appendChild(script);
    };
    /*---------------------字段方式一-------------------------*/
    /**
    * 获取flash版本
    */
    Help.prototype.getFlashVersion = function () {
        var version;
        try {
            version = navigator.plugins['Shockwave Flash'];
            version = version.description;
        }
        catch (ex) {
            try {
                version = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
                    .GetVariable('$version');
            }
            catch (ex2) {
                version = '0.0';
            }
        }
        version = version.match(/\d+/g);
        return parseFloat(version[0] + '.' + version[1]);
    };
    /**
    * 获取文件地址
    */
    Help.prototype.getWebServerPath = function () {
        var hostPath = window.location.host;
        if (hostPath.indexOf('localhost') != -1) {
            return 'http://localhost/files/';
        } else {
            return 'http://58.16.86.103:8086/files/';
        }

    };
    /**
    * 预览图片
    * @param option
    */
    Help.prototype.getBase64Image = function (option) {
        try {
            var reader = new FileReader();
            reader.readAsDataURL(option.file);
            reader.onload = function (e) {
                var url = e.target.result;
                var image = new Image();
                image.src = url;
                image.onload = function () {
                    var canvas = document.createElement("canvas");
                    if (option.scaling != null && option.scaling > 0 && option.scaling < 1) {
                        image.width = image.width * option.scaling;
                        image.height = image.height * option.scaling;
                    }
                    if (option.width != null) {
                        image.width = option.width;
                    }
                    if (option.height != null) {
                        image.height = option.height;
                    }
                    canvas.width = image.width;
                    canvas.height = image.height;
                    var ctx = canvas.getContext("2d");
                    ctx.drawImage(image, 0, 0, image.width, image.height);
                    var ext = image.src.substring(image.src.lastIndexOf(".") + 1).toLowerCase();
                    var dataURL = canvas.toDataURL("image/" + ext);
                    if (option.success != null) {
                        option.success(dataURL);
                    }
                };
            };
        }
        catch (e) {
            if (option.error != null) {
                option.error(e);
            }
        }
    };
    /**
    * js根据条件获取json数据
    * @param sql
    * @param json
    */
    //----------------------------------------start---------------------------------------------
    Help.prototype.getParameterObject = function (sql, json) {
        var returnfields = sql.match(/^(select)\s+([a-z0-9_\,\.\s\*]+)\s+from\s+([a-z0-9_\.]+)(?: where\s+\((.+)\))?\s*(?:order\sby\s+([a-z0-9_\,]+))?\s*(asc|desc|ascnum|descnum)?\s*(?:limit\s+([0-9_\,]+))?/i);
        var ops = {
            fields: returnfields[2].replace(' ', '').split(','),
            from: returnfields[3].replace(' ', ''),
            where: (returnfields[4] == undefined) ? "true" : returnfields[4],
            orderby: (returnfields[5] == undefined) ? [] : returnfields[5].replace(' ', '').split(','),
            order: (returnfields[6] == undefined) ? "asc" : returnfields[6],
            limit: (returnfields[7] == undefined) ? [] : returnfields[7].replace(' ', '').split(',')
        };
        return this.returnParse(json, ops);
    };
    Help.prototype.returnParse = function (json, ops) {
        var o = { fields: ["*"], from: "json", where: "", orderby: [], order: "asc", limit: [] };
        for (var i in ops) {
            o[i] = ops[i];
        }
        var result = [];
        result = this.returnFilter(json, o);
        result = this.returnOrderBy(result, o.orderby, o.order);
        result = this.returnLimit(result, o.limit);
        return result;
    };
    Help.prototype.returnFilter = function (json, jsonsql_o) {
        var jsonsql_scope = eval(jsonsql_o.from);
        var jsonsql_result = [];
        var jsonsql_rc = 0;
        if (jsonsql_o.where == "") {
            jsonsql_o.where = "true";
        }
        for (var i = 0; i < jsonsql_scope.length; i++) {
            var test = jsonsql_scope[i];
            demo(test);
        }
        function demo(info) {
            var where = jsonsql_o.where;
            var numberlike = where.match(/like/g);
            if (numberlike != null) {
                if (where.indexOf("||") >= 0 || where.indexOf("&&") >= 0) {
                }
                else {
                    if (numberlike.length == 1) {
                        var condition = where.replace(/info\./, "");
                        var shuzu = condition.split(' ');
                        var shuxing = shuzu[0];
                        var zhi = shuzu[2];
                        if (info[shuxing].indexOf(zhi) >= 0) {
                            jsonsql_result[jsonsql_rc++] = Help.returnFields(info, jsonsql_o.fields);
                        }
                    }
                    else {
                    }
                }
            }
            else {
                // let condition = jsonsql_o.where.replace(/\s+/g, "").replace(/info\./, "").replace(/\'/g, "")
                // let shuzu = condition.split('==');
                // console.log(shuzu);
                if (eval(jsonsql_o.where)) {
                    jsonsql_result[jsonsql_rc++] = Help.returnFields(info, jsonsql_o.fields);
                }
            }
        }
        return jsonsql_result;
    };
    Help.returnFields = function (scope, fields) {
        if (fields.length == 0)
            fields = ["*"];
        if (fields[0] == "*")
            return scope;
        var returnobj = {};
        for (var i in fields) {
            returnobj[fields[i]] = scope[fields[i]];
        }
        return returnobj;
    };
    Help.prototype.returnOrderBy = function (result, orderby, order) {
        if (orderby.length == 0) {
            return result;
        }
        result.sort(function (a, b) {
            switch (order.toLowerCase()) {
                case "desc": return (eval('a.' + orderby[0] + ' < b.' + orderby[0])) ? 1 : -1;
                case "asc": return (eval('a.' + orderby[0] + ' > b.' + orderby[0])) ? 1 : -1;
                case "descnum": return (eval('a.' + orderby[0] + ' - b.' + orderby[0]));
                case "ascnum": return (eval('b.' + orderby[0] + ' - a.' + orderby[0]));
            }
        });
        return result;
    };
    Help.prototype.returnLimit = function (result, limit) {
        switch (limit.length) {
            case 0: return result;
            case 1: return result.splice(0, limit[0]);
            case 2: return result.splice(limit[0] - 1, limit[1]);
        }
    };
    //--------------------------------end------------------------------------------
    /**
    * 获取IE版本
    */
    Help.prototype.getIEVersion = function () {
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器  
        var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器  
        var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
        if (isIE) {
            var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
            reIE.test(userAgent);
            var fIEVersion = parseFloat(RegExp["$1"]);
            if (fIEVersion == 7) {
                return 7;
            }
            else if (fIEVersion == 8) {
                return 8;
            }
            else if (fIEVersion == 9) {
                return 9;
            }
            else if (fIEVersion == 10) {
                return 10;
            }
            else {
                return 6; //IE版本<=7
            }
        }
        else if (isEdge) {
            return 0; //ie的edge浏览器
        }
        else if (isIE11) {
            return 11; //IE11  
        }
        else {
            return -1; //不是ie浏览器
        }
    };
    /**
    * 判断数组是否存在某值，存在返回集合(在数组中的索引)
    * @param value 判断值
    * @param list 数组
    */
    Help.prototype.getIndexList = function (value, list) {
        var results = [];
        var len = list.length;
        var pos = 0;
        while (pos < len) {
            pos = list.indexOf(value, pos);
            if (pos === -1) {
                break;
            }
            results.push(pos); //找到就存储索引
            pos += 1; //并从下个位置开始搜索
        }
        return results;
    };
    /**************************************时间格式化处理************************************/
    Help.prototype.getFormatData = function (format, date) { //author: meizz   
        var o = {
            "M+": date.getMonth() + 1,                 //月份   
            "d+": date.getDate(),                    //日   
            "h+": date.getHours(),                   //小时   
            "m+": date.getMinutes(),                 //分   
            "s+": date.getSeconds(),                 //秒   
            "q+": Math.floor((date.getMonth() + 3) / 3), //季度   
            "S": date.getMilliseconds()             //毫秒   
        };
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(format))
                format = format.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return format;
    }
    //生成guid
    Help.prototype.getGUID = function () {
        var date = new Date();   /* 判断是否初始化过，如果初始化过以下代码，则以下代码将不再执行，实际中只执行一次 */
        var guidStr = '';
        sexadecimalDate = this.hexadecimal(this.getGUIDDate(date), 16);
        sexadecimalTime = this.hexadecimal(this.getGUIDTime(date), 16);
        for (var i = 0; i < 9; i++) {
            guidStr += Math.floor(Math.random() * 16).toString(16);
        }
        guidStr += sexadecimalDate;
        guidStr += sexadecimalTime;
        while (guidStr.length < 32) {
            guidStr += Math.floor(Math.random() * 16).toString(16);
        }
        return this.formatGUID(guidStr);
    }
    /* * 功能：获取当前日期的GUID格式，即8位数的日期：19700101 * 返回值：返回GUID日期格式的字条串 */
    Help.prototype.getGUIDDate = function (date) {
        return date.getFullYear() + this.addZero(date.getMonth() + 1) + this.addZero(date.getDay());
    }
    /* * 功能：获取当前时间的GUID格式，即8位数的时间，包括毫秒，毫秒为2位数：12300933 * 返回值：返回GUID日期格式的字条串 */
    Help.prototype.getGUIDTime = function (date) {
        return this.addZero(date.getHours()) + this.addZero(date.getMinutes()) + this.addZero(date.getSeconds()) + this.addZero(parseInt(date.getMilliseconds() / 10));
    }
    /* * 功能: 为一位数的正整数前面添加0，如果是可以转成非NaN数字的字符串也可以实现 * 参数: 参数表示准备再前面添加0的数字或可以转换成数字的字符串 * 返回值: 如果符合条件，返回添加0后的字条串类型，否则返回自身的字符串 */
    Help.prototype.addZero = function (num) {
        if (Number(num).toString() != 'NaN' && num >= 0 && num < 10) {
            return '0' + Math.floor(num);
        } else {
            return num.toString();
        }
    }
    /*  * 功能：将y进制的数值，转换为x进制的数值 * 参数：第1个参数表示欲转换的数值；第2个参数表示欲转换的进制；第3个参数可选，表示当前的进制数，如不写则为10 * 返回值：返回转换后的字符串 */
    Help.prototype.hexadecimal = function (num, x, y) {
        if (y != undefined) { return parseInt(num.toString(), y).toString(x); }
        else { return parseInt(num.toString()).toString(x); }
    }
    /* * 功能：格式化32位的字符串为GUID模式的字符串 * 参数：第1个参数表示32位的字符串 * 返回值：标准GUID格式的字符串 */
    Help.prototype.formatGUID = function (guidStr) {
        //var str1 = guidStr.slice(0, 8) + '-', str2 = guidStr.slice(8, 12) + '-', str3 = guidStr.slice(12, 16) + '-', str4 = guidStr.slice(16, 20) + '-', str5 = guidStr.slice(20);
        //return str1 + str2 + str3 + str4 + str5;
        return guidStr;
    }
    //获取guid结束
    return Help;
} ());
//# sourceMappingURL=help.js.map