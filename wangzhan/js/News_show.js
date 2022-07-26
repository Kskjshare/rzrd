$(function () {
    var rssid = window.location.href.split("=")[1];
    console.log(rssid)
    var mapData;



    //通知公告2，改人大要闻1��
    RssApi.Table.List("releasum").condition({ "classifyid": 1 ,"state":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        $(".notice").mapview(data, {});
        $(".notice p").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })



    // ͼƬ����
    RssApi.Table.List("releasum").keyvalue({ "pagesize": 1000 ,"state":1}).getJson(function (data) {
        var arrays = [];
        $.each(data, function (k, v) {
            if (v.ico != null && v.ico != undefined) {
                arrays.push(v)
                if (arrays.length == 3) {
                    return false
                }
            }
        })
        // console.log(arrays)
        $(".imgcont").mapview(arrays, {});
        $(".imgcont center").click(function () {
            console.log($(this).find("a").attr("rssid"))
            var rssid = $(this).find("a").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })


    // ������
    RssApi.Table.Details("releasum").condition({ "id": rssid }).getJson(function (data) {
        let shijian =  new Date(data.shijian * 1000).toString("yyyy-MM-dd");
        let str = '时间：' + shijian +'　　来源：'+data.origin;
        $(".n04").html(str);
        mapData = data;
        $(".macont").mapview(data);

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