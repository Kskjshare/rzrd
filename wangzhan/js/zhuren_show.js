function compare(p){ //这是比较函数
    return function(m,n){
        var a = m[p];
        var b = n[p];
        return b - a; //升序
    }
}

$(function () {
    var rssid = window.location.href.split("=")[1];
    console.log(rssid)


 RssApi.Table.List("reldirector").keyvalue({ "pagesize": 20 ,sortkey: "id asc"}).getJson(function (data) {
        data = data.sort(function(a, b) { return parseInt(a.id) > parseInt(b.id) ? 1 : -1;} );
        var data2 = []
        for (var i = 0; i < data.length; i++) {
                   data2.push(data);

        }
       
        $(".dedirectors").mapview(data);
        $(".dedirectors a").click(function () {
            console.log($(this).attr("rssid"))
            var rssid = $(this).attr("rssid");
            location.href = "zhuren_show.htm?id=" + rssid + "";
        })
    })


    // 主任之窗（时松虎）
//    RssApi.Table.List("reldirector").keyvalue({ "pagesize": 20 ,sortkey: "id asc"}).getJson(function (data) {
//        data = data.sort(function(a, b) { return parseInt(a.id) > parseInt(b.id) ? 1 : -1;} );
//        console.log(data)
////        data.sort(compare("shijian"));
//
//
//        var data2 = []
//        var m,n,k = 0;
//        var zhurenNameData1, zhurenNameData2, zhurenNameData3;
//        for (var i = 0; i < data.length; i++) {
//            var zhurenNameData = data[i];
//            if (zhurenNameData.worktitle == 3 && zhurenNameData.nickname == '郑学伟') {
//                m = i;
//                zhurenNameData1 = zhurenNameData;
//            }
//            if (zhurenNameData.nickname == '张红伟') {
//                n = i;
//                zhurenNameData2 = zhurenNameData;
//            }
//             if (zhurenNameData.worktitle == 4 && zhurenNameData.nickname == '郑学伟') {
//                k = i;
//                zhurenNameData3 = zhurenNameData;
//            }
//        }
//        for (var i = 0; i < data.length; i++) {
//            if (i != m && i != n && i != k) {
//                data2.push(data[i]);
//            }
//        }
//        data2.push(zhurenNameData1);
//        data2.push(zhurenNameData2);
//        data2.push(zhurenNameData3);
//        $(".dedirectors").mapview(data2);
//        $(".dedirectors a").click(function () {
//            console.log($(this).attr("rssid"))
//            var rssid = $(this).attr("rssid");
//            location.href = "zhuren_show.htm?id=" + rssid + "";
//        })
//    })


    // 主任介绍
    RssApi.Table.Details("reldirector").condition({ "id": rssid }).getJson(function (data) {
        console.log(data);
        $(".n01").html("<h3 style=‘font-weight:bolder;color:#1c92cf;float:left;’>|&nbsp;</h3><a style='font-size: 18px;' href='index.htm'>首页</a> > " + data.nickname);
        $(".diredet").mapview(data, {
            "nickname": function (val) {
                return "姓名：" + val
            },
            "job": function (val) {
                return "职务：" + val
            }
        })
        $("#branchContent").text(data.branch);
    })

    // 相关活动
    // RssApi.View.List("releasum_reldirector").condition({ "reldirectorid": rssid ,"state":1}).getJson(function (data) {
    //     console.log(data)
    //     if (data.length > 0) {
    //         var releasumid = data[0].releasumid;
    //         RssApi.Table.Details("releasum").condition({ "id": releasumid }).getJson(function (data) {
    //             console.log(data);
    //             mapData = data;
    //             $(".macont").mapview(data);

    //         })
    //     }
    //     // $(".macont").mapview(data, {
    //     //     "shijian": function (val) {
    //     //         return new Date(val * 1000).toString("yyyy-MM-dd")
    //     //     }
    //     // })
    //     // $(".macont table").click(function () {
    //     //     console.log($(this).find("tr").attr("releasumid"))
    //     //     var rssid = $(this).find("tr").attr("releasumid");
    //     //     location.href = "News_show.htm?id=" + rssid + "";

    //     // })
    // })

    // 图片内容
    RssApi.Table.List("releasum").condition({"state":1}).keyvalue({ "pagesize": 100 }).getJson(function (data) {
        console.log(data)
        var arrays = [];
        $.each(data, function (k, v) {
            if (v.ico != null && v.ico != undefined) {
                arrays.push(v)
                if (arrays.length == 3) {
                    return false
                }
            }
        })
        $(".imgcont").mapview(arrays, {});
        $(".imgcont center").click(function () {
            console.log($(this).find("a").attr("rssid"))
            var rssid = $(this).find("a").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })


    // 分页
    // var pageParam = {
    //     next: '.next',//下一页按钮jq选择器
    //     prev: '.prev',//上一页按钮jq选择器
    //     // nextMore: '.nextMore',//下n页按钮jq选择器
    //     // prevMore: '.prevMore',//上n页按钮jq选择器
    //     totalEl: '.total',//总页数jq元素  元素内包含 eq:“共n页”
    //     curPageEl: '.cur_page',//当前页数jq元素  元素内包含 eq:“当前第n页”
    //     perPageCount: 15//每页显示数量
    //     // morePage: 5//上、下n页跳转数
    // }
    // //demo为包裹列表的容器
    // $(".macont").page(pageParam);
})
$(function () {

            $("#nav li:has(ul)").mouseover(function(){
                    $(this).children("ul").stop(true,true).slideDown(400);
            });
            $("#nav li:has(ul)").mouseleave(function(){
                    // $(this).stop(true,true).slideUp("fast");
                $(this).children("ul").stop(true,true).slideUp('fast');
            });
    
             $("#firstPage").click(function(){
                location.href = "index.htm";
            });
            // $("#rendagaikuang").click(function(){
            //     location.href = "rendajianjie.htm";
            // });
            $("#rendayaowen2").click(function(){
                location.href = "NewsTop.htm?classifyid=1&newsid=1";
            });
            $("#shizhengxinwen").click(function(){
                location.href = "News.htm?classifyid=17";
            });
            $("#huiyibaodao").click(function(){
                location.href = "huiyibaodao.htm";
            });
            $("#zhuantijijin").click(function(){
                location.href = "zhuantijijin.htm";
            });
            $("#jiguanjianshe").click(function(){
                location.href = "News.htm?classifyid=11";
            });

              $(document).keydown(function(event){
                if(event.keyCode == 13){ 
                    var searchInput = $("#searchInput").val();
                    location.href = "searchResult.htm?searchInput=" + encodeURIComponent(searchInput);
                }
            });

            $("#searchBtn").click(function(){
                var searchInput = $("#searchInput").val();
                location.href = "searchResult.htm?searchInput=" + encodeURIComponent(searchInput);
            })

        });