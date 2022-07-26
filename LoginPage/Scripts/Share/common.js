//为所有 AJAX 请求设置默认 成功与失败函数：
$.ajaxSetup({
    timeout: '2000000',
    error: function (xhr, textStatus, errorThrown) {
        if (textStatus == 'timeout') {
            alert('请求超时！');
        } else {
            console.log(xhr);
            var message = eval('(' + xhr.responseText + ')').msg;
            if ($.messager != null) {

                $.messager.alert("错误提示", message, 'error');
            } else {
                alert(message);
            }

        }
    }
});

var common = {

    //js验证是否包含特殊字符
    ValidString: function (str) {
        var patrn = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）&;|{}【】‘；：”“'。，、？]")
        if (patrn.exec(str)) {
            return false
        }
        return true;

    },
    //js去除特殊字符
    excludeSpecial: function (s) {
        var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）&;|{}【】‘；：”“'。，、？]")
        var rs = "";
        for (var i = 0; i < s.length; i++) {
            rs = rs + s.substr(i, 1).replace(pattern, '');
        }
        return rs;
    },
    addTab: function (id, title, href, iconCls) {
        var tabPanel = $("#tab-main");
        if (tabPanel.length == 0) {
            tabPanel = parent.$("#tab-main");
        }
        if (tabPanel.length == 0) {
            tabPanel = parent.parent.$("#tab-main");
        }
        if (!tabPanel.tabs('exists', title)) {
            //添加页签
            var content = '<iframe scrolling="auto" frameborder="0"  src="'
				+ href + '" style="width:100%;height:100%;"></iframe>';
            tabPanel.tabs('add', {
                id: id,
                title: title,
                content: content,
                bodyCls: 'tab-body',
                fit: true,
                closable: true
            });
        } else {
            common.refreshTab(title);
        }
    },
    getCurrentTabTitle: function () {
        var tabPanel = $("#tab-main");
        if (tabPanel.length == 0) {
            tabPanel = parent.$("#tab-main");
        }
        if (tabPanel.length == 0) {
            tabPanel = parent.parent.$("#tab-main");
        }
        return tabPanel.tabs('getSelected').panel('options').title;
    },
    updateTab: function () {
        var tabPanel = $("#tab-main");
        if (tabPanel.length == 0) {
            tabPanel = parent.$("#tab-main");
        }
        if (tabPanel.length == 0) {
            tabPanel = parent.parent.$("#tab-main");
        }
        var iframe = $(tabPanel.tabs('getSelected').panel(
			'options').content);
        var src = iframe.attr('src');
        tabPanel.tabs(
				'update',
				{
				    tab: tabPanel.tabs('getSelected'),
				    options: {
				        content: '<iframe scrolling="auto" frameborder="0"  src="'
							+ src
							+ '" style="width:100%;height:100%;"></iframe>'
				    }
				});
    },
    refreshTab: function (title, url) {
        //选中需要刷新的目标tab
        var tabPanel = $("#tab-main");
        if (tabPanel.length == 0) {
            tabPanel = parent.$("#tab-main");
        }
        if (tabPanel.length == 0) {
            tabPanel = parent.parent.$("#tab-main");
        }
        tabPanel.tabs('select', title);
        var iframe = $(tabPanel.tabs('getSelected').panel(
			'options').content);
        var src = iframe.attr('src');
        var id = iframe.attr('id');
        if (url != null) {
            //地址存在，则覆盖地址
            src = url;
        }
        tabPanel.tabs(
				'update',
				{
				    tab: tabPanel.tabs(
						'getSelected'),
				    options: {
				        content: '<iframe scrolling="auto" frameborder="0" id="' + id + '"  src="'
							+ src
							+ '" style="width:100%;height:100%;"></iframe>'
				    }
				});
    },
    closeTab: function (title) {
        //关闭tab
        var tabPanel = $("#tab-main");
        if (tabPanel.length == 0) {
            tabPanel = parent.$("#tab-main");
        }
        if (tabPanel.length == 0) {
            tabPanel = parent.parent.$("#tab-main");
        }
        tabPanel.tabs('close', title);
    },
    addNewTab: function (id, title, href, iconCls) {
        var tabPanel = $("#tab-main");
        if (tabPanel.length == 0) {
            tabPanel = parent.$("#tab-main");
        }
        if (tabPanel.length == 0) {
            tabPanel = parent.parent.$("#tab-main");
        }
        //添加页签
        var content = '<iframe scrolling="auto" frameborder="0"  src="' + href
			+ '" style="width:100%;height:100%;"></iframe>';
        if (!tabPanel.tabs('exists', title)) {

            tabPanel.tabs('add', {
                id: id,
                title: title,
                content: content,
                bodyCls: 'tab-body',
                fit: true,
                closable: true
            });
        } else {
            tabPanel.tabs("select", title);
            var selTab = tabPanel.tabs('getSelected');
            tabPanel.tabs('update', {
                tab: selTab,
                options: {
                    title: title,
                    content: content
                }
            });

        }
    },
    dictionary: function () {
        this.data = new Array();

        this.put = function (key, value) {
            this.data[key] = value;
        };

        this.get = function (key) {
            return this.data[key];
        };

        this.remove = function (key) {
            this.data[key] = null;
        };

        this.isEmpty = function () {
            return this.data.length == 0;
        };

        this.size = function () {
            return this.data.length;
        };
    },
    init: function () {
        //初始化日期格式
        $.fn.datebox.defaults.formatter = function (date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '/' + common.datePlusZearo(m) + '/'
				+ common.datePlusZearo(d);
        };
        $.fn.datebox.defaults.parser = function (s) {
            var t = Date.parse(s);
            if (!isNaN(t)) {
                return new Date(t);
            } else {
                return new Date();
            }
        };
        //日期验证
        $.extend($.fn.validatebox.defaults.rules, {
            dateValidate: {
                validator: function (value, param) {
                    var datePattern = /^(\d{4})\/(\d{2})\/(\d{2})$/;
                    return datePattern.test(value);
                },
                message: '参照日期格式{0}'
            }
        });
    },
    datePlusZearo: function (s) {
        //日期补0
        return s < 10 ? '0' + s : s;
    },
    timestampToTime: function (timestamp) {
        return new Date(parseInt(timestamp)).toLocaleString().replace(/年|月/g,
			"-").replace(/日/g, " ");
    },

    getCurrentMonthFirst: function () {
        var d = new Date();
        var m = d.getMonth() + 1;
        var minutes = d.getMinutes();
        var seconds = d.getSeconds();
        var hours = d.getHours();
        return d.getFullYear() + '-' + (m < 10 ? '0' + m : m) + '-1'
			+ ' '
			+ '00:00:00';
    },
    // 获取指定时间后N天(包含时分秒)
    addDate: function (date, days) {
        var d = new Date(Date.parse(date.replace(/-/g, "/")) * 1);
        var minutes = d.getMinutes();
        var seconds = d.getSeconds();
        var hours = d.getHours();
        d.setDate(d.getDate() + days);
        var m = d.getMonth() + 1;
        return d.getFullYear() + '-' + (m < 10 ? '0' + m : m) + '-'
			+ (d.getDate() < 10 ? '0' + d.getDate() : d.getDate()) + ' '
			+ (hours < 10 ? '0' + hours : hours) + ':'
			+ (minutes < 10 ? '0' + minutes : minutes) + ':'
			+ (seconds < 10 ? '0' + seconds : seconds);
    },
    // 获取指定时间后N天(只包含年月日)
    addYear: function (date, days) {
        var d = new Date(Date.parse(date.replace(/-/g, "/")) * 1);
        var minutes = d.getMinutes();
        var seconds = d.getSeconds();
        var hours = d.getHours();
        d.setDate(d.getDate() + days);
        var m = d.getMonth() + 1;
        return d.getFullYear() + '-' + (m < 10 ? '0' + m : m) + '-'
			+ (d.getDate() < 10 ? '0' + d.getDate() : d.getDate());
    },

    // 显示当前日期
    formatterDate: function (date) {
        var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
        var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
		+ (date.getMonth() + 1);
        var hor = date.getHours();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        return date.getFullYear() + '-' + month + '-' + day + " " + hor + ":"
			+ min + ":" + sec;
    },
    //随机生成uuid   
    guid: function guid() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
            return v.toString(16);
        });
    },
    disableBackSpace: function (e) {
        var ev = e || window.event; // 获取event对象
        var obj = ev.target || ev.srcElement; // 获取事件源
        var t = obj.type || obj.getAttribute('type'); // 获取事件源类型
        // 获取作为判断条件的事件类型
        var vReadOnly = obj.getAttribute('readonly');
        // 处理null值情况
        vReadOnly = (vReadOnly == "") ? false : vReadOnly;
        // 当敲Backspace键时，事件源类型为密码或单行、多行文本的，
        // 并且readonly属性为true或enabled属性为false的，则退格键失效
        var flag1 = (ev.keyCode == 8
		&& (t == "password" || t == "text" || t == "textarea") && vReadOnly == "readonly") ? true
			: false;
        // 当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
        var flag2 = (ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea") ? true
			: false;

        // 判断
        if (flag2) {
            return false;
        }
        if (flag1) {
            return false;
        }
    },
    // 去除数组中重复的元素
    removeDuplicates: function (arr) {

        var temp = {}, r = [];
        for (var i in arr)
            temp[arr[i]] = true;
        for (var k in temp)
            r.push(k);
        return r;
    },
    chooseSzdq: function () {

    }
};
// 禁止后退键 作用于Firefox、Opera
document.onkeypress = common.disableBackSpace;
//禁止后退键  作用于IE、Chrome
document.onkeydown = common.disableBackSpace;