$(function () {
    var rssid = window.location.href.split("=")[1];
    console.log(rssid)
    var mapData;

//    RssApi.Table.List("releasum").keyvalue({ "pagesize": 1000 ,"state":1}).getJson(function (data) {
//        var arrays = [];
//        $.each(data, function (k, v) {
//            if (v.ico != null && v.ico != undefined) {
//                arrays.push(v)
//                if (arrays.length == 3) {
//                    return false
//                }
//            }
//        })
//        // console.log(arrays)
//        $(".imgcont").mapview(arrays, {});
//        $(".imgcont center").click(function () {
//            console.log($(this).find("a").attr("rssid"))
//            var rssid = $(this).find("a").attr("rssid");
//            location.href = "News_show.htm?id=" + rssid + "";
//        })
//    })


    // ������
    console.log("_________data id=", rssid );

//    RssApi.Table.Details("stationcontent").condition({ "id": rssid }).getJson(function (data) {
//                        console.log("_________data");
//
//                console.log(data);
//
//        let shijian =  new Date(data.shijian * 1000).toString("yyyy-MM-dd");
//        let str = '时间：' + shijian +'　　来源：'+data.origin;
//        $(".n04").html(str);
//        mapData = data;
//        $(".macont").mapview(data);
//
//    })
    
    
     RssApi.Table.List("stationcontent").keyvalue({ "pagesize": 1000 ,"id":rssid }).getJson(function (data) {
        var arrays = [];
            console.log("_________data data=", data );

        $.each(data, function (k, v) {
            if ( v.id == rssid ) {
            var origin = v.origin ;
            if ( origin === "" || origin === 'undefined' ) {
                origin = "未知"
            }
            let shijian =  new Date(v.shijian * 1000).toString("yyyy-MM-dd");
            let str = '时间：' + shijian +'　　来源：'+ origin;
            $(".n04").html(str);
            mapData = v;
            $(".macont").mapview(v);
        }
            
            
        })
       
    })


    $("#n003").click(function(){
        var href = mapData.enclosure;
        console.log(href);
        if (href != null && href != '') {
            window.open("http://117.158.113.36:80/upfile/" + href);
        }
    })
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