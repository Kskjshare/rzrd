$(function () {
     // 首页专题集锦
    RssApi.Table.List("specail_collection").keyvalue({ "pagesize": 6 ,"state":1}).getJson(function (data) {
        console.log("data22 is:" + data);      
        
        
        if (data) {
            
            data=  data.sort(function(a, b) { return a.shijian < b.shijian ? 1 : -1;} ); //按时间排序

        	var str = "";
            for (var i = 0; i < data.length; i++) {
                var imgcont = data[i];             
                str = str + "<tr>";
                //str = str + "<td height='105 width='725'>";
                //str = str + "<a onclick='clickImg("+imgcont.collectiontype+")'> <img style='height:117px;' src='http://117.158.113.36:80/upfile/"+imgcont.ico+"' /></a>";
                str = str + "<td height='99px width='788px'>";
                str = str + "<a onclick='clickImg("+imgcont.collectiontype+")'> <img style='margin-left:6px;width:768px;height:99px;' src='http://117.158.113.36:80/upfile/"+imgcont.ico+"' /></a>";
                
                str = str + "</td>";
                str = str + "</tr>";
                str = str + "<tr>";
                str = str + "<td height='12' background='images/blank.png'>";
                str = str + "</td>";
                str = str + "</tr>";
            }
            $("#jijinTablel").append(str); 
        }
    })
})
// 通知公告2 改人大要闻1
    RssApi.Table.List("releasum").condition({ "classifyid": 1 ,"state":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        $(".notice").mapview(data, {});
        console.log(data)
        $(".notice p").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })

function clickImg(collectiontype) {
    if (collectiontype == 0) {
        location.href = "dangshi2.html";
    }
    else if ( collectiontype == 1 ) {
        location.href = "centralSpirit.html";
    }
    else if ( collectiontype == 2  ) {
        location.href = "helpCountrySide.html";
        
    }
    else {
        location.href = "collection.html";
    }
//    else {
//        location.href = "dangshi2.html";
//    }
}
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