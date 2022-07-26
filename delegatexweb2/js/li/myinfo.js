var arry = []
//点击选择民族样式的遮罩层
$("#zzc1").click(function () {
    $("#zzc1").hide();
});
$("section").load(function () {
    $("#zzc1").hide();
});
var zzc1 = function (t, e) {
    $("#zzc1 ul").empty();
    $("#zzc1").show();
    $.each(e, function (k, v) {
        $("#zzc1 ul").append("<li relationid='" + k + "'>" + v[0] + "</li>");
    });
    $("#zzc1 li").off("click").click(function (e) {
        e.stopPropagation();
        t.find("em").text($(this).text());
        t.find("em").attr("relationid", $(this).attr("relationid"));
        $("#zzc1").hide();
    });
};

//点击代表团
var zzc3 = function (t, e) {
    $("#zzc1 ul").empty();
    $("#zzc1").show();
    $.each(e, function (k, v) {
        $("#zzc1 ul").append("<li relationid='" + v.id + "'>" + v.delegationname + "</li>");
    });
    $("#zzc1 li").off("click").click(function (e) {
        e.stopPropagation();
        t.text($(this).text());
        t.attr("relationid", $(this).attr("relationid"));
        $("#zzc1").hide();
    });
};

//点击届次
var zzc4 = function (t, e) {
    $("#zzc1 ul").empty();
    $("#zzc1").show();
    $.each(e, function (k, v) {
        $("#zzc1 ul").append("<li relationid='" + v.id + "'>" + v.name + "</li>");
    });
    $("#zzc1 li").off("click").click(function (e) {
        e.stopPropagation();
        t.text($(this).text());
        t.attr("relationid", $(this).attr("relationid"));
        $("#zzc1").hide();
    });
};

$("#zzc10 ul .submitName").click(function () {
    $("#zzc10").hide();
});
$("section").load(function () {
    $("#zzc10").hide();
});
//点击层次
var zzc10 = function (t, e) {
    $("#zzc10 ul").empty();
    $("#zzc10").show();
//    for (var ever in e) {
//        e++;
//        console.log("ever:"+ever);
//    }
    $.each(e, function (k, v) {
//        console.log(v)
        $("#zzc10 ul").append("<li relationid='" + k + "'><input type='checkbox' name='myid'  idd='" + k + "' realname=" + v + " />" + v + "</li>");
        if (k == 4) {
            $("#zzc10 ul").append("<p class='submitName'>确定</p>");
        }
    });
    $("#zzc10 ul>li").slice(0).click(function () {
        // 切换样式
        $(this).toggleClass("tr_active");
        // 找到checkbox对象
        var chks = $("input[type='checkbox']", this);
        var tag = $(this).attr("tag");
        if (tag == "selected") {
            // 之前已选中，设置为未选中
            $(this).attr("tag", "");
            chks.prop("checked", false);
        } else {
            // 之前未选中，设置为选中
            $(this).attr("tag", "selected");
            chks.prop("checked", true);
        }
    });
    $("#zzc10 ul .submitName").off().click(function () {
        var id_array = new Array();
        var name_array = new Array();
        $('input[name="myid"]:checked').each(function () {
            id_array.push($(this).attr("idd"));//向数组中添加元素  
            name_array.push($($(this)).attr("realname"));//向数组中添加元素  
        });
        var idstr = id_array.join(',');//将数组元素连接起来以构建一个字符串  
        var namestr = name_array.join(',');
        console.log(idstr)
        console.log(namestr)
        $("#zzc10").hide();
        location.href = "#myinfo"
        $("#myinfo span").text(idstr + ",")
        $("#myinfo [circleslist]").text(namestr);
    });
};

$("#zzc11 ul .submitName").click(function () {
    $("#zzc11").hide();
});
$("section").load(function () {
    $("#zzc11").hide();
});
//点击届次
var zzc11 = function (t, e) {
    $("#zzc11 ul").empty();
    $("#zzc11").show();
    var len = 0, ee = 0;
    for (var ever in e) {
        ee++;
    }

    RssApi.Table.List("user").condition(new RssDict().keyvalue({
        "myid": RssUser.Data.myid
    }).getDict()).getJson(function (json) {
        var sessionlist1 = "";
        $.each(json, function (k, v) {
            sessionlist1 = v.sessionlist;
        })
//        sessionlist1 = sessionlist1.substring(0, sessionlist1.length - 1);

        let html = "";
        var flag = false;
        var sess = sessionlist1.split(",");
        $.each(e, function (k, v) {
            for (var i = 0; i < sess.length; i++) {
                if (k == sess[i]) {
                    flag = true;
                    break;
                }
            }
            len++;
            html += '<li relationid=' + k + '><input type="checkbox" ' + (flag ? "checked" : "") + ' name="myidd"  iddd="' + k + '" realname="' + v + '" />' + v + '</li>';
            flag = false;
        })
        $("#zzc11 ul").html(html);
        if (len == ee) {
            $("#zzc11 ul").append("<p class='submitName'>确定</p>");
        }
        $("#zzc11 ul>li").slice(0).click(function () {
            // 切换样式
            $(this).toggleClass("tr_active");
            // 找到checkbox对象
            var chks = $("input[type='checkbox']", this);
            var tag = $(this).attr("tag");
            if (tag == "selected") {
                // 之前已选中，设置为未选中
                $(this).attr("tag", "");
                chks.prop("checked", false);
            } else {
                // 之前未选中，设置为选中
                $(this).attr("tag", "selected");
                chks.prop("checked", true);
            }
        });
        $("#zzc11 ul .submitName").off().click(function () {
            var id_array1 = new Array();
            var name_array1 = new Array();
            $('input[name="myidd"]:checked').each(function () {
                id_array1.push($(this).attr("iddd"));//向数组中添加元素  
                name_array1.push($($(this)).attr("realname"));//向数组中添加元素  
            });
            var idstr1 = id_array1.join(',');//将数组元素连接起来以构建一个字符串  
            var namestr1 = name_array1.join(',');
            console.log(idstr1)
            console.log(namestr1)
            $("#zzc11").hide();
            location.href = "#myinfo"
            $("#myinfo s").text(idstr1 + ",")
            $("#myinfo [sessionlist]").text(namestr1);
        });
    });
};


//点击选择有输入框样式的遮罩层
$("#zzc2").click(function () {
    $("#zzc2").hide();
});
$("section").load(function () {
    $("#zzc2").hide();
});
var zzc2 = function (t, e) {
    $("#zzc2 ul").empty();
    $("#zzc2").show();
    $("#zzc2 ul").append("<li><input type='text' placeholder='请输入' value=" + e + "></li><li><button>确定<button></li>");
    $("#zzc2 li>input").off("click").click(function (e) {
        e.stopPropagation();
    });
    $("#zzc2 li>button").off("click").click(function (e) {
        e.stopPropagation();
        var before_num = t.parent("li").text().substr(0, 2);
        switch (before_num) {
            case "电子":
//                if ($("#zzc2 li>input").val().match(
////                        /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/
//                        /^[0-9]*$/
//                        )) {
                t.text($("#zzc2 li>input").val());
                $("#zzc2").hide();
//                } else {
//                    alert("请输入正确的邮箱地址");
//                }
                break;

            case "手机":
                if ($("#zzc2 li>input").val().match(
                        /^([0-9]|[._-]){4,19}$/
//                        /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/
                        )) {
                    t.text($("#zzc2 li>input").val());
                    $("#zzc2").hide();
                } else {
                    alert("请输入正确的手机号码");
                }
                break;

            case "通讯":
//                if ($("#zzc2 li>input").val().match(/^[\u4e00-\u9fa5]{2,}$/)) {
                t.text($("#zzc2 li>input").val());
                $("#zzc2").hide();
//                } else {
//                    alert("请输入正确的籍贯");
//                }
                break;
            case "姓名":
//                if ($("#zzc2 li>input").val().match(/^[\u4e00-\u9fa5]{2,}$/)) {
                t.text($("#zzc2 li>input").val());
                $("#zzc2").hide();
//                } else {
//                    alert("请输入正确的籍贯");
//                }
                break;
            case "出生":
//                if ($("#zzc2 li>input").val().match(/^[\u4e00-\u9fa5]{2,}$/)) {
                t.text($("#zzc2 li>input").val());
                $("#zzc2").hide();
//                } else {
//                    alert("请输入正确的籍贯");
//                }
                break;

            default:

                break;
        }
    });
};



//个人中心
$("#myinfo").load(function () {
    var sessionname = "", list = "{";
    RssApi.Table.List("session_classify").setLoading(true).keyvalue("pagesize", "1000").getJson(function (json) {
        var sessionlist = []
        $.each(json, function (k, v) {
            list += '"' + v.id + '":"' + v.name + '",';

        })
        list = list.substring(0, list.length - 1) + "}";
//        console.log(list);
//        console.log(JSON.parse(list))
        sessionname = JSON.parse(list);
//        console.log(sessionname)
//        zzc11($("#myinfo ul>li:nth-of-type(10)").find("em"), JSON.parse(list));
    });
    RssApi.View.List("user_delegation").setLoading(true).condition(new RssDict().keyvalue({"myid": RssUser.Data.myid}).getDict()).getJson(function (data) {
        console.log(data);
        if (data.length == 1) {
            //显示数据
            $("#myinfo>article>ul").mapview(data, {
                //出生日期
                "birthday": function (val) {
                    if (val != "0") {
                        return new Date(parseInt(val) * 1000).toString("yyyy-MM");
                    } else {
                        return "未知";
                    }
                },
                "circleslist": function (val) {
                    val = val.replace(/\s+/g, "");
                    var arry = val.split(","), aaaa = "", circleslist = ""
                    for (var i = 0; i < arry.length - 1; i++) {


                        circleslist = arry[i];
                        if (dictdata.circles[circleslist] != undefined) {
                            console.log("dictdata.circles[circleslist]:" + dictdata.circles[circleslist])
                            aaaa += dictdata.circles[circleslist] + ",";
                        }
                    }
                    return aaaa;
                },
                "sessionlist": function (val) {
                    console.log(val)
                    val = val.replace(/\s+/g, "");
                    var arry1 = val.split(","), bbb = ""
                    for (var i = 0; i < arry1.length - 1; i++) {
                        console.log(arry1[i])
                        $.each(sessionname, function (k, v) {
                            if (arry1[i] == k) {
                                bbb += v + ",";
                            }
                        })
                    }
                    return bbb;
                }
            });
            //性别
            $("#myinfo [sex]").text(dictdata["sex"][data[0].sex]).attr("relationid", data[0].sex);
            //民族
            $("#myinfo [nationid]").text(dictdata["nationalityid"][data[0].nationid][0]).attr("relationid", data[0].nationid);
            //党派
            $("#myinfo [clan]").text(dictdata["clan"][data[0].clan]).attr("relationid", data[0].clan);
            //界别 层次
//            var arry = [data[0].circleslist]
//            var circleslist = "", aaaa = "";
//            for (var i = 0; i < arry.length; i++) {
//                console.log(arry[i])
//                circleslist = arry[i];
//                aaaa += dictdata["circles"].circleslist;
////                console.log(circleslist)
//            }
//            $("#myinfo [circleslist]").text(aaaa).attr("relationid", aaaa);
//            //是否常委 届次
//            $("#myinfo [sessionname]").attr("relationid", data[0].sessionid);
//            $("#myinfo [sessionid]").text(dictdata["iscommittee"][data[0].iscommittee]).attr("relationid", data[0].iscommittee);
            //代表团
            $("#myinfo [delegationname]").attr("relationid", data[0].id);
            // 邮箱
            if (typeof data[0].email != "undefined") {
                $("#myinfo [email]").text(data[0].email);
            } else {
                $("#myinfo [email]").text("未知");
            }
            //职业
            $("#myinfo textarea").val(data[0].daibiaoDWjob);

            //点击姓名li标签
            $("#myinfo ul>li:nth-of-type(2)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc2($(this).find("em"), $(this).find("em").text());
            });
            //点击手机号码li标签
            $("#myinfo ul>li:nth-of-type(3)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc2($(this).find("em"), $(this).find("em").text());
            });
            //点击出生日期li标签
            $("#myinfo ul>li:nth-of-type(6)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc2($(this).find("em"), $(this).find("em").text());
            });
            //点击性别li标签
            $("#myinfo ul>li:nth-of-type(4)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc($(this).find("em"), dictdata["sex"]);
            });
            //点击民族li标签
            $("#myinfo ul>li:nth-of-type(5)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc1($(this), dictdata["nationalityid"]);
            });
            //点击党派li标签
            $("#myinfo ul>li:nth-of-type(8)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc($(this).find("em"), dictdata["clan"]);
            });
            //点击层次li标签
            $("#myinfo ul>li:nth-of-type(9)").off("click").click(function () {
                console.log($(this).find("em").text());
                zzc10($(this).find("em"), dictdata["circles"]);
            });
            //点击是否常委li标签 届次
            $("#myinfo ul>li:nth-of-type(10)").off("click").click(function () {
                RssApi.Table.List("session_classify").setLoading(true).keyvalue("pagesize", "1000").getJson(function (json) {
                    var sessionlist = "{"
                    $.each(json, function (k, v) {
                        sessionlist += '"' + v.id + '":"' + v.name + '",';

                    })
                    sessionlist = sessionlist.substring(0, sessionlist.length - 1) + "}";
                    console.log(sessionlist);
                    console.log(JSON.parse(sessionlist))
                    zzc11($(this).find("em"), JSON.parse(sessionlist));
                });
            });

            //点击代表团li标签
            $("#myinfo ul>li:nth-of-type(11)").off("click").click(function () {
                RssApi.Table.List("user_delegation").setLoading(true).keyvalue("pagesize", "1000").getJson(function (json) {
                    console.log(json);
                    console.log($("#myinfo ul>li:nth-of-type(11)").find("em").text());
                    zzc3($("#myinfo ul>li:nth-of-type(11)").find("em"), json);
                });
            });

//            //点击邮箱li标签
//            $("#myinfo ul>li:nth-of-type(12)").off("click").click(function () {
//                console.log($(this).find("em").text());
//                zzc2($(this).find("em"), $(this).find("em").text());
//            });
//            //点击籍贯li标签
//            $("#myinfo ul>li:nth-of-type(13)").off("click").click(function () {
//                console.log($(this).find("em").text());
//                zzc2($(this).find("em"), $(this).find("em").text());
//            });
        }

    });


    //点击提交按钮
    $("#myinfo .normalbutton").click(function () {
        var date = new Date($("#myinfo [birthday]").text());
        // 有三种方式获取
        var time3 = Date.parse(date);
        var clan = $("#myinfo [clan]").attr("relationid"),
                sessionlist = $("#myinfo s").text(),
                sex = $("#myinfo [sex]").attr("relationid"),
                nationid = $("#myinfo [nationid]").attr("relationid"),
                email = $("#myinfo [email]").val(),
                birthday = time3 / 1000,
                realname = $("#myinfo [realname]").text(),
                telphone = $("#myinfo [telphone]").text(),
                daibiaoDWaddress = $("#myinfo [daibiaoDWaddress]").val(),
                circleslist = $("#myinfo span").text(),
                delegationname = $("#myinfo [delegationname]").attr("relationid"),
                daibiaoDWjob = $("#myinfo textarea").val();
        console.log("性别：" + sex);
        console.log("民族：" + nationid);
        console.log("党派：" + clan);
        console.log("出生日期：" + birthday);
        console.log("姓名：" + realname);
        console.log("层次：" + circleslist);
        console.log("届次：" + sessionlist);
        console.log("职务：" + daibiaoDWjob);
        console.log("邮箱：" + email);
        console.log("手机号码：" + telphone);
        console.log("代表团：" + delegationname);
        console.log("通讯地址：" + daibiaoDWaddress);
        new Ajax("user/update").setLoading(true).keyvalue({"myid": RssUser.Data.myid, "clan": clan, "sessionlist": sessionlist, "sex": sex, "nationid": nationid, "email": email, "birthday": birthday, "telphone": telphone, "realname": realname, "daibiaoDWaddress": daibiaoDWaddress, "circleslist": circleslist, "mission": delegationname, "daibiaoDWjob": daibiaoDWjob, }).getJson(function (data) {
            location.href = "index.html#my";
        });
    });
});



var ceshi2 = "1";
//通讯录
$("#maillist").load(function () {
    $("#maillist .search button").off("click").click(function () {
        var key = $("#maillist .search input").val();
        var likeall = {};
        if (key == undefined || key == "") {

        } else {
            likeall = {'realname': "{likeall~" + key + "}"};
        }
        if (ceshi2 == "1") {
            $("#maillist ul li").eq(0).siblings().remove();
        } else {
            $("#maillist ul li").remove();
        }

        ceshi2 = "2"
        faqsajax = RssApi.View.List("fri_user_del").setLoading(true).condition(new RssDict().keyvalue({"myid": RssUser.Data.myid}).keyvalue(likeall).getDict()).setFlushUI(function (json, append) {
            if (json.length != "10") {
                $('.nodata').hide();
            } else {
                $('.nodata').show();
            }
            console.log(json);
            $("#maillist ul").mapview(json, {}, append);

            //点击通讯录li标签
            $("#maillist ul>li").off("click").click(function () {
                console.log($(this).attr("dataid"));
                var scanning_book_id = $(this).attr("dataid");
                location.href = "#scanning_book";
                //通讯录详情页
                RssApi.Details("user_delegation").setLoading(true).condition(new RssDict().keyvalue({"myid": scanning_book_id}).getDict()).getJson(function (data) {
                    console.log(data);
                    $("#scanning_book article>div").mapview(data, {
                        "sex": function (val) {
                            return dictdata["sex"][val];
                        },
                        "nationid": function (val) {
                            return dictdata["nationalityid"][val][0];
                        }
                    });
                    $("#scanning_book article>ul").mapview(data, {
                        "clan": function (val) {
                            return dictdata["clan"][val];
                        },
                        "circles": function (val) {
                            return dictdata["circles"][val];
                        }

                    });
                });
            });

            if (json.length == "0") {
                alert("未找到查询目标");
            }
        }).getJson();
    });
    if ($("#maillist .search input").val() == "") {
        $("#maillist .search button").click();
    }
});

//我的 头像和名字
$("#my").load(function () {
    $("#doublecode").find("canvas").remove();
    $("#doublecode").qrcode({"text": RssUser.Data.myid});
    RssApi.Table.List("user").setLoading(true).condition(new RssDict().keyvalue({"myid": RssUser.Data.myid}).getDict()).getJson(function (data) {
        $("#mybackgroundtop").mapview(data, {});
    });
});

