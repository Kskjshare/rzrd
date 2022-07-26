$(function () {
    var rssid = window.location.href.split("id=")[1];
    console.log(rssid)

    RssApi.Table.Details("ztimges").condition({ "id": rssid }).getJson(function (data) {
        console.log(data);
        let shijian =  new Date(data.shijian * 1000).toString("yyyy-MM-dd");
        let origin = data.origin;
        
        let str = '时间：' + shijian +'　　来源：'+ origin;
        $(".n04").html(str);
        
        $(".ztimges").mapview(data);
    });

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
            $("#rendagaikuang").click(function(){
                location.href = "rendajianjie.htm";
            });
            $("#rendayaowen2").click(function(){
                location.href = "NewsTop.htm?classifyid=1";
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
})