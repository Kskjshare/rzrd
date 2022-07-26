$.extend($.fn.validatebox.defaults.rules,
				{
				    NotEmpty: { // 非空字符串验证。 easyui 原装required 不能验证空格
				        validator: function (value, param) {
				            return $.trim(value).length > 0;
				        },
				        message: '该项为必输入项'
				    },

				    pinteger: {  // 验证正整数
				        validator: function (value, param) {
				            return /^[+]?[1-9]\d*$/.test(value);
				        },
				        message: '请输入正整数'
				    },
				    // 验证汉字
				    CHS: {
				        validator: function (value) {
				            return /^[\u0391-\uFFE5]+$/.test(value);
				        },
				        message: "只能输入汉字"
				    },
				    idcard: {
				        validator: function (num) {
				            num = $.trim(num).toUpperCase();
				            //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。

				            //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
				            //下面分别分析出生日期和校验位
				            var len, re;
				            len = num.length;
				            // 判断是否包含空格变量
				            var arr = new Array();
				            arr = num.split(" ");
				            var re = /[_~#^$@%&!*()<>:;'"[]{}【】  ]/gi;
				            // 如果身份证号码包含空格,提示错误
				            if (arr.length != 1 || re.test(num)) {
				                return false;
				            } else {
				                if (len == 18) {
				                    re = new RegExp(
                                        /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/);
				                    var arrSplit = num.match(re);

				                    //检查生日日期是否正确
				                    var dtmBirth = new Date(arrSplit[2] + "/"
                                        + arrSplit[3] + "/" + arrSplit[4]);
				                    var bGoodDay;
				                    bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2]))
                                        && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3]))
                                        && (dtmBirth.getDate() == Number(arrSplit[4]));
				                    if (!bGoodDay) {
				                        return false;
				                    } else {
				                        //检验18位身份证的校验码是否正确。
				                        //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
				                        var valnum;
				                        var arrInt = new Array(7, 9, 10, 5, 8, 4,
                                            2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
				                        var arrCh = new Array('1', '0', 'X', '9',
                                            '8', '7', '6', '5', '4', '3', '2');
				                        var nTemp = 0, i;
				                        for (i = 0; i < 17; i++) {
				                            nTemp += num.substr(i, 1) * arrInt[i];
				                        }
				                        valnum = arrCh[nTemp % 11];
				                        if (valnum != num.substr(17, 1)) {
				                            return false;
				                        }
				                        return true;
				                    }
				                }

				                return false;
				            }
				        },
				        message: '身份证号码格式不正确'
				    },
				    minLength: {
				        validator: function (value, param) {
				            return value.length >= param[0];
				        },
				        message: '请输入至少（2）个字符'
				    },
				    maxLengthSjh: {
				        validator: function (value, param) {
				            return value.length <= param;
				        },
				        message: '请输入至多填写（20）个字符.'
				    },
				    length: {
				        validator: function (value, param) {
				            var len = $.trim(value).length;
				            return len >= param[0] && len <= param[1];
				        },
				        message: "输入内容长度必须介于{0}和{1}之间."
				    },
				    phone: {// 验证电话号码
				        validator: function (value) {
				            return /^0\d{2,3}-[1-9]\d{6,7}$/i
									.test(value);
				        },
				        message: '格式不正确,请使用下面格式:025-88888888'
				    },
				    mobile: {// 验证手机号码
				        validator: function (value) {
				            return /^(13|14|15|18|17|19)\d{9}$/i.test(value);
				        },
				        message: '手机号码格式不正确'
				    },
				    intLength: {// 验证手机号码
				        validator: function (value, param) {
				            return /^\d{11}$/i.test(value) && $.trim(value).length == param;
				        },
				        message: '手机号码格式不正确'
				    },
				    intOrFloat: {// 验证整数或小数
				        validator: function (value) {
				            return /^\d+(\.\d+)?$/i.test(value);
				        },
				        message: '请输入数字，并确保格式正确'
				    },
				    currency: {// 验证货币
				        validator: function (value) {
				            return /^\d+(\.\d+)?$/i.test(value);
				        },
				        message: '货币格式不正确'
				    },
				    qq: {// 验证QQ,从10000开始
				        validator: function (value) {
				            return /^[1-9]\d{4,9}$/i.test(value);
				        },
				        message: 'QQ号码格式不正确'
				    },
				    integer: {// 验证整数 可正负数
				        validator: function (value) {
				            // return /^[+]?[1-9]+\d*$/i.test(value);

				            return /^([+]?[0-9])|([-]?[0-9])+\d*$/i.test(value);
				        },
				        message: '请输入整数'
				    },
				    age: {// 验证年龄
				        validator: function (value) {
				            return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i
									.test(value);
				        },
				        message: '年龄必须是0到120之间的整数'
				    },

				    chinese: {// 验证中文
				        validator: function (value) {
				            return /^[\Α-\￥]+$/i.test(value);
				        },
				        message: '请输入中文'
				    },
				    english: {// 验证英语
				        validator: function (value) {
				            return /^[A-Za-z]+$/i.test(value);
				        },
				        message: '请输入英文'
				    },
				    unnormal: {// 验证是否包含空格和非法字符
				        validator: function (value) {
				            return /.+/i.test(value);
				        },
				        message: '输入值不能为空和包含其他非法字符'
				    },
				    username: {// 验证用户名
				        validator: function (value) {
				            return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
				        },
				        message: '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
				    },
				    faxno: {// 验证传真
				        validator: function (value) {
				            // return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[
				            // ]){1,12})+$/i.test(value);
				            return /^((\d{2,3})|(\d{3}\-))?(0\d{2,3}|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
									.test(value);
				        },
				        message: '传真号码不正确'
				    },
				    zip: {// 验证邮政编码
				        validator: function (value) {
				            return /^[1-9]\d{5}$/i.test(value);
				        },
				        message: '邮政编码格式不正确'
				    },
				    ip: {// 验证IP地址
				        validator: function (value) {
				            return /d+.d+.d+.d+/i.test(value);
				        },
				        message: 'IP地址格式不正确'
				    },
				    name: {// 验证姓名，可以是中文或英文
				        validator: function (value) {
				            return /^[\Α-\￥]+$/i.test(value)
									| /^\w+[\w\s]+\w+$/i.test(value);
				        },
				        message: '请输入正确格式的姓名'
				    },
				    date: {// 验证姓名，可以是中文或英文
				        validator: function (value) {
				            // 格式yyyy-MM-dd或yyyy-M-d
				            return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i
									.test(value);

				        },
				        message: '请输入合适的日期格式'
				    },

				    /*    验证时间    ^\d{4}-(0\d|1[0-2])-([0-2]\d|3[01])( ([01]\d|2[0-3])\:[0-5]\d\:[0-5]\d)?$
				    这个正则
				    yyyy-MM-dd hh:mm:ss可以
				    yyyy-MM-dd 后面不带准备时间也可以
				    如果一定要准备时间, 去掉最后一个问号, 如下
				    ^\d{4}-(0\d|1[0-2])-([0-2]\d|3[01])( ([01]\d|2[0-3])\:[0-5]\d\:[0-5]\d)$*/
				    dateTime: {
				        validator: function (value) {
				            //						return	 /^\d{4,}\/(?:0?\d|1[12])\/(?:[012]?\d|3[01]) (?:[01]?\d|2[0-4]):(?:[0-5]?\d|60)$/.test(value);
				            return /^\d{4}-(0\d|1[0-2])-([0-2]\d|3[01])( ([01]\d|2[0-3])\:[0-5]\d\:[0-5]\d)$/i.test(value);
				        },
				        message: '请输入合适的日期格式'
				    },
				    msn: {
				        validator: function (value) {
				            return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
									.test(value);
				        },
				        message: '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
				    },
				    same: {
				        validator: function (value, param) {
				            if ($("#" + param[0]).val() != "" && value != "") {
				                return $("#" + param[0]).val() == value;
				            } else {
				                return true;
				            }
				        },
				        message: '两次输入的密码不一致！'
				    },
				    email: {// 验证email
				        validator: function (value) {
				            //		                    return /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/i.test(value);
				            return /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/i.test(value);
				        },
				        message: '邮箱格式不正确'
				    },
				    radio: { // 单选按钮必选
				        validator: function (value, param) {
				            var frm = param[0], groupname = param[1], ok = false;
				            $('input[name="' + groupname + '"]', document[frm]).each(function () { //查找表单中所有此名称的radio
				                if (this.checked) { ok = true; return false; }
				            });

				            return ok
				        },
				        message: '该项为必选项！'
				    },
				    checkbox: {//checkbox验证
				        validator: function (value, param) {
				            var frm = param[0], groupname = param[1], checkNum = 0;
				            $('input[name="' + groupname + '"]', document[frm]).each(function () { //查找表单中所有此名称的checkbox
				                if (this.checked) checkNum++;
				            });
				            return checkNum > 0 && checkNum < 4;
				        },
				        message: '选择1~3项！'
				    },
				    englishCheckSub: {
				        validator: function (value) {
				            return /^[a-zA-Z0-9]+$/.test(value);
				        },
				        message: '只能包括英文字母、数字'
				    },

				    chineseEnglishNumber: {
				        validator: function (value) {
				            return /^[\u4e00-\u9fa5a-zA-Z0-9 (^\s*)|(\s*$)]+$/.test(value);
				        },
				        message: '存在特殊字符！'
				    },
				    equaldDate: {
				        validator: function (value, param) {
				            var start = $(param[0]).datetimebox('getValue');  //获取开始时间  
				            return value > start;                             //有效范围为当前时间大于开始时间  
				        },
				        message: '结束日期应大于开始日期!'                     //匹配失败消息
				    }
				});
