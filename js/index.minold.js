/// <reference path="jquery.min.js" />
/// <reference path="rsseasy.js" />

$(function () {
    var hash = {"uid": "", "sid": ""};
    if (location.hash) {
        hash = eval("(" + location.hash.replace("#", "{").replace(/:/g, ':"').replace(",", '",') + "\"})");
    }
//    var right = $("#right"), tagbar = right.find("ul"), ifrwrap = right.find('div');
//    var leftbar = $("#left");
//    $("#controlbtn").click(function (ev) {
//        switch (leftbar.offset().left) {
//            case 0:
//                leftbar.animate({"left": -leftbar.width()-50}, 500);
//                right.animate({"left": 50}, 500);
//                break;
//            case - leftbar.width()-50:
//                leftbar.animate({"left": 0}, 500);
//                right.animate({"left": leftbar.width()}, 500);
//                break;
//        }
//    });
    //权限验证
    var powerlist = Cookie.Get("powerlist") || "";
   //  alert("powerlist00::"+powerlist);//jackie debug
    powerlist = powerlist.split(",");
    var len = powerlist.length;
   // alert("powerlist11::"+powerlist);//jackie debug
    for (var i = 0; i < len; i++) {
        //alert("powerlist11.51::"+powerlist[i]+"###"+parseInt(powerlist[i])+"@@@"+parseInt(powerlist[i]).toString(2)+"&&&"+parseInt(powerlist[i]).toString(2).padleft(53, '0'));//jackie debug
        powerlist[i] = parseInt(powerlist[i]).toString(2).padleft(53, '0');//左边补0，总共长度53
    }
    powerlist = "0" + powerlist.join("");
    //alert("我powerlist2我::"+powerlist+"==substr2=="+powerlist.substr(2,1));//jackie debug//从下标2位开始( 第一个下标为0，所以实际上是第三个字符)，取1个长度的字符
    function powervalidate(powerid) {
       // alert("powerid=="+powerid+"==substr=="+powerlist.substr(powerid, 1)+"parse::"+parseInt(powerlist.substr(powerid, 1)));
        return Cookie.Get("staffmyid") == "1" || parseInt(powerlist.substr(powerid, 1));
    }
    //导航栏
    var navbar = $("#nav");
    var powerid = 0;
    //var powerids = [];//jackie debug
    $.each(menudata, function (k, v) {//把一级都撸了一遍
        powerid = v["powerid"];       
       //alert("powerid::"+powerid+"=!="+!powerid+"::parse:::"+parseInt(powerlist.substr(powerid, 1)));//jackie debug
       // powerids=powerids+powerid;//jackie debug
        if (!powerid || powervalidate(powerid)) {//跟当前帐号角色权限有关//为空或符合当前帐号角色的一级出来
            //alert("k::"+k);//jackie debug
            navbar.append('<li id="' + k + '">' + v['text'] + '</li>');
        }
    });
    //alert("powerids33::"+powerids);//jackie debug
    if (RssFrame.RootMenu["frame"]) {
        RssFrame.RootMenu["frame"]();
    }
    var navli = navbar.find("li");
    var leftMenus = $("#leftMenus");
    navli.click(function () {
        navli.removeClass();
        var nav = $(this);
        nav.addClass("actived");

        hash.uid = this.id;

        leftMenus.empty();


        var children = menudata[this.id]['children'];
        $.each(children, function (uk, v) {
            var children = v["children"];
            powerid = v["powerid"];
            if (!powerid || powervalidate(powerid)) {
                if (children) {
                    var dl = $("<dl><dt>" + v["text"] + "<img src='../css/limg/l1.png'></dt></dl>");
                    var dd = $("<dd></dd>");
                    dl.append(dd);
                    leftMenus.append($("<li class='reset'></li>").append(dl));
                    $.each(children, function (k, v) {
                        powerid = v["powerid"];
                        if (!powerid || powervalidate(powerid)) {
                            dd.append('<p id="' + hash.uid + uk + k + '" href="' + v['url'] + '">' + v["text"] + '</p>');
                        }
                    });
                    dl.find("dt").click(function () {
                        dd.slideToggle();
                        var ind = $(this).parents("li").index();
                        if (ind != "0") {
                            if ($(this).attr("hhh")) {
                                $(this).find("img").attr("src", "../css/limg/l1.png");
                                $(this).css("color", "#000")
                                $(this).removeAttr("hhh")
                            } else {
                                $("#leftMenus").find("dt[hhh='0']").click();
                                $(this).find("img").attr("src", "../css/limg/sl1.png")
                                $(this).css("color", "#fff")
                                $(this).attr("hhh", "0")
                            }
                        }
                    });
                    return;
                }
                leftMenus.append('<li><p id="' + hash.uid + uk + k + '" href="' + v['url'] + '">' + v["text"] + '</p></li>');
            }
        });
        leftMenus.find(".reset").eq(0).attr("id", "controlbtn")
        $("#controlbtn").find("dt").find("img").attr("src", "../css/limg/l0.png")
        if ($("#left").css("left") == "-265px") {
//          $("#controlbtn").css("width","245px") 
            $("#controlbtn").find("dt").find("img").attr("src", "../css/limg/sl0.png")
        }

        var right = $("#right"), tagbar = right.find("ul"), ifrwrap = right.find('div');
        var leftbar = $("#left");
        leftbar.css("overflow", "auto");
        leftbar.css({"left": 0, "width": "265"});
        leftMenus.find(".reset").eq(0).css({"width": "250"});
        leftMenus.find(".reset").eq(0).find("dt").find("img").attr("src", "../css/limg/l0.png")
        right.css("left","270");
        $("#controlbtn").click(function (ev) {
            switch (leftbar.offset().left) {
                case 0:
                    leftbar.css("overflow", "hidden");
                    leftbar.animate({"left": -leftbar.width(), "width": "295"}, 500);
                    leftMenus.find(".reset").eq(0).animate({"width": "295"}, 500);
                    leftMenus.find(".reset").eq(0).find("dt").find("img").attr("src", "../css/limg/sl0.png")
                    right.animate({"left": 30}, 500);
                    break;
                default:
                    leftbar.css("overflow", "auto");
                    leftbar.animate({"left": 0, "width": "265"}, 500);
                    leftMenus.find(".reset").eq(0).animate({"width": "250"}, 500);
                    leftMenus.find(".reset").eq(0).find("dt").find("img").attr("src", "../css/limg/l0.png")
                    right.animate({"left": "270"}, 500);
                    break;
            }
        });

        if (RssFrame.LeftMenu[hash.uid]) {
            RssFrame.LeftMenu[hash.uid]();
        }
        var plist = leftMenus.find("p");
        plist.click(function (ev) {
            RssWin.MaskLayer.show();
            ev.preventDefault();
            var menu = $(this);
            hash.sid = this.id;
            top.location.hash = "#uid:" + hash.uid + ",sid:" + hash.sid;

            var tmphash = top.location.hash.replace(/#|,|:/img, '');

            var sm = $("#" + tmphash);
            if (sm.length) {
                sm.click();
                return;
            }
            if (tagbar.find("li").length > 8) {
                RssWin.MaskLayer.close();
                alert("打开的标签过多！");
                return;
            }

            var tabli = $('<li id="' + tmphash + '">' + $(this).text() + '<b>×</b></li>');
            tagbar.append(tabli);
            ifrwrap.find("iframe").hide();
            var ifr = $('<iframe src="' + $(this).attr("href") + '"></iframe>');
            ifrwrap.append(ifr);
            ifr.load(function () {
                popuplayer.close();
                this.onload = null;
            });
            tabli.click(function () {
                $('#right li').removeClass();
                tabli.addClass("actived");

                plist.removeClass("selected");
                menu.addClass("selected");

                navli.removeClass();
                nav.addClass("actived");
                RssWin.MaskLayer.close();

                ifrwrap.find("iframe").hide().removeAttr("id").removeAttr("name").eq($(this).index()).show().attr({"id": "workspace", "name": "workspace"});
            }).click();
            tabli.find("b").click(function (ev) {
                if (tabli.prev().length) {
                    tabli.prev().click();
                } else {
                    tabli.next().click();
                }
                ev.stopPropagation();
                tabli.remove();
                ifr.remove();
            });
            tabli.mousedown(function () {
                return false;
            });
            tabli.dblclick(function () {
                $(this).find("b").click();
            });
            popuplayer.showHtml('<div class="infowrap">正在加载，请稍候</div>', "信息提示", {"width": 300, height: 50});
        });
        var smenu = hash["sid"] && hash["sid"].indexOf(hash.uid) == 0 ? $("#" + hash["sid"]) : plist.first();
        smenu.click();
    });
    if (hash["uid"]) {
        $("#" + hash["uid"]).click();
    } else {
        navli.first().click();
    }
});

