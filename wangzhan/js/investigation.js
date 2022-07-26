
$(function () {
    // console.log(window.location.href)
    var classify = window.location.href.split("classifyid=")[1];
    var meetid = window.location.href.split("meetid=")[1];
    RssApi.Table.List("releasum").condition({ "classifyid": 1 ,"state":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        $(".notice").mapview(data, {});
//        console.log(data)
        $(".notice p").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })





    // 主内容
    var contype = { "classifyid": classify ,"state":1};
//    var contype = { "classifyid": 15 ,"state":1};


    RssApi.Table.List("releasum").condition(contype).keyvalue({ "pagesize": 1000 }).getJson(function (data) {
        console.log(data)

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li><h4><a onclick='newsShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a><span class='time'>";
            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
            liStr = liStr + "</span></h4></li>";
        }
        $("#contentListul").append(liStr);
        
        
        
//        $(".investigation").each(function(){
//          var index = $(this).index();
//          $(this).find("idSpan").text(data[index].id);
//          $(this).find("title").text(data[index].title);
//          $(this).find("time").text(new Date(data[index].shijian * 1000).toString("yyyy-MM-dd"));
//        })


        $(".title").click(function(){
            var rssid = $(this).parent().find(".idSpan").html();
            location.href = "News_show.htm?id=" + rssid + "";
        });    
        
        fakePage();

    })
    
  

})

function newsShowContent(rssid) {
    location.href = "News_show.htm?id=" + rssid + "";
}

var pageNum = 20; 
var outlines;
var pageCount = 0; 
var CP = document.getElementById("pageJump");
var FileBody = document.getElementById("content");
var pageCounttext = document.getElementById("pageCount");    

function fakePage() {
        outlines = document.getElementById("contentListul").getElementsByTagName("li"); 
        if (outlines.length % pageNum > 0) {
            pageCount = ((outlines.length - (outlines.length % pageNum)) / pageNum + 1);
        } else {
            pageCount = outlines.length / pageNum;
        }
        pageCounttext.innerHTML = "共" + pageCount + "页";
        toPage(1);
    }


    function getCurrPage(_currentPage) {
        var cPage = 1;
        if (_currentPage <= 0 || _currentPage == "")
            cPage = 1;
        else if (_currentPage > pageCount)
            cPage = pageCount;
        else
            cPage = _currentPage;
        return cPage;
    }
    /**
     * goto()
     */
    function goto() {
        toPage(CP.value);
    }

    function toPage(_pageNum) {
        var cP = getCurrPage(_pageNum);
        var startPos = cP * pageNum - pageNum;
        var endPos = 0;
        if (cP * pageNum > outlines.length)
            endPos = outlines.length;
        else
            endPos = cP * pageNum;
        for (var i = 0; i < outlines.length; i++) {
            if ((i >= startPos) && (i < endPos)) {
                outlines[i].style.display = "block";
                
            } else {
                outlines[i].style.display = "none";
            }
        }
        CP.value = cP;
        showPageLineNum();
        return false;
    }
    /**
     * showPageLineNum()
     */
    function showPageLineNum() {
        var pL = "";
        console.log(CP.value)
        if (CP.value != 1) {
            pL += "<a href='javascript:void(0);'  style='background:#1c92cf;' onclick='toPage(" + (CP.value - 1) + ")'>上一页</a>";
        } else {
            pL += "<span class='sDisable'>上一页</span>";
        }
        for (var pageN = 1; pageN <= pageCount; pageN++) {
            if (pageN == CP.value) {
                //pL += "<strong>"+pageN+"</strong>";
            } else {
                //pL += "<a href='javascript:void(0);' onclick='toPage("+pageN+")'>"+pageN+"</a>";
            }
        }
        if (CP.value < pageCount) {
            pL += "<a href='javascript:void(0);' style='background:#1c92cf;' onclick='toPage(" + ((CP.value) * 1 + 1) + ")'>下一页</a>";
        } else {
            pL += "<span class='sDisable'>下一页</span>";
        }
        document.getElementById("pageDec").innerHTML = pL;
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