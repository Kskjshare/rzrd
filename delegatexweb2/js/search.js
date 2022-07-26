$(function () {
    
    
    var index = 0;
    var searchInput = decodeURIComponent(window.location.href.split("searchInput=")[1]);
    $("#searchInput").val(searchInput);

    $("#searchul > li").click(function(){
        $(this).addClass("current").siblings().removeClass("current");
        index = $(this).index();
    })
    searchContent();

    $("#searchButton").click(function(){
        searchInput = $("#searchInput").val();
        searchContent();
    });

    function searchContent() {
        $("#searchedkeyword").html(searchInput);

        $("#contentList").empty();
        $("#pageArea").hide();

        var flag = false;
        var count = 0;
        if (searchInput != null && searchInput.trim() != '') {
            if (index == 0) {
                var d1 = RssApi.Table.List("releasum").condition({ "classifyid": 6 ,"state":1}).keyvalue({ "pagesize": 100 });
                var d2 = RssApi.Table.List("releasum").condition({ "classifyid": 10 ,"state":1}).keyvalue({ "pagesize": 100 });
                var d3 = RssApi.Table.List("releasum").condition({ "classifyid": 7 ,"state":1}).keyvalue({ "pagesize": 100 });
                var d4 = RssApi.Table.List("releasum").condition({ "classifyid": 9 ,"state":1}).keyvalue({ "pagesize": 100 });
                var d5 = RssApi.Table.List("releasum").condition({ "classifyid": 16 ,"state":1}).keyvalue({ "pagesize": 100 });
                $.when(
                    d1, d2, d3, d4, d5
                ).done(function(data1, data2, data3, data4, data5){
                    
                }).then(function (data1, data2, data3, data4, data5) {
                    var totalData = [];
                    data1.getJson(function (data6) {
                        totalData.push(data6);
                        data2.getJson(function (data7) {
                            totalData.push(data7);
                            data3.getJson(function (data8) {
                                totalData.push(data8);
                                data4.getJson(function (data9) {
                                    totalData.push(data9);
                                    data5.getJson(function (data10) {
                                        totalData.push(data10);

                                        var liStr = "";
                                        for (var i = 0; i < totalData.length; i++) {
                                            var subArray = totalData[i];
                                            for (var j = 0; j < subArray.length; j++) {
                                                var title = subArray[j].title;
                                                if (title.indexOf(searchInput) != -1) {
                                                    count++;
                                                    flag = true;
                                                    liStr = liStr + "<li class='font_micro' onclick='enterDetailPage("+subArray[j].id+")'>";
                                                    liStr = liStr + "<h2><a  target='_blank'>";
                                                    liStr = liStr + title;
                                                    liStr = liStr + "</a>";
                                                    liStr = liStr + "</h2>";
                                                    liStr = liStr + "<span class='data'>";
                                                    liStr = liStr + new Date(subArray[j].shijian * 1000).toString("yyyy-MM-dd");
                                                    liStr = liStr + "</span>";
                                                    liStr = liStr + "</li>";
                                                }
                                            }
                                        }
                                        console.log('count is:', count);
                                        $("#contentList").append(liStr);

                                        if (flag == false) {
                                            $("#nosearchDiv").hide();
                                            $("#searchResultNull").show();
                                            $("#recordNum").html("0");
                                            $("#recordTime").html("0.02");
                                        } else {
                                            $("#nosearchDiv").show();
                                            $("#searchResultNull").hide();
                                            $("#recordNum").html(count);
                                            $("#recordTime").html("0.089");

                                            $("#pageArea").show();   
                                            fakePage();
                                        }
                                    });
                                });
                            });
                        });
                        
                    });
                    
                });
            } else if (index == 1) {
                // 监督工作
                RssApi.Table.List("releasum").condition({ "classifyid": 6 ,"state":1}).keyvalue({ "pagesize": 100 }).getJson(function (data) {

                    var liStr = "";
                    for (var i = 0; i < data.length; i++) {
                        var title = data[i].title;
                        if (title.indexOf(searchInput) != -1) {
                            count++;
                            flag = true;
                            liStr = liStr + "<li class='font_micro' onclick='enterDetailPage("+data[i].id+")'>";
                            liStr = liStr + "<h2><a  target='_blank'>";
                            liStr = liStr + title;
                            liStr = liStr + "</a>";
                            liStr = liStr + "</h2>";
                            liStr = liStr + "<span class='data'>";
                            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                            liStr = liStr + "</span>";
                            liStr = liStr + "</li>";
                        }
                    }
                    $("#contentList").append(liStr);

                    if (flag == false) {
                        $("#nosearchDiv").hide();
                        $("#searchResultNull").show();
                        $("#recordNum").html("0");
                        $("#recordTime").html("0.02");
                    } else {
                        $("#nosearchDiv").show();
                        $("#searchResultNull").hide();
                        $("#recordNum").html(count);
                        $("#recordTime").html("0.089");

                        $("#pageArea").show();   
                        fakePage();
                    }
                })
            } else if (index == 2) {
                //  选举任免
                RssApi.Table.List("releasum").condition({ "classifyid": 10 ,"state":1}).keyvalue({ "pagesize": 100 }).getJson(function (data) {
                    var liStr = "";
                    for (var i = 0; i < data.length; i++) {
                        var title = data[i].title;
                        if (title.indexOf(searchInput) != -1) {
                            count++;
                            flag = true;
                            liStr = liStr + "<li class='font_micro'>";
                            liStr = liStr + "<h2><a  target='_blank'>";
                            liStr = liStr + title;
                            liStr = liStr + "</a>";
                            liStr = liStr + "</h2>";
                            liStr = liStr + "<span class='data'>";
                            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                            liStr = liStr + "</span>";
                            liStr = liStr + "</li>";
                        }
                    }
                    $("#contentList").append(liStr);

                    if (flag == false) {
                        $("#nosearchDiv").hide();
                        $("#searchResultNull").show();
                        $("#recordNum").html("0");
                        $("#recordTime").html("0.02");
                    } else {
                        $("#nosearchDiv").show();
                        $("#searchResultNull").hide();
                        $("#recordNum").html(count);
                        $("#recordTime").html("0.089");

                        $("#pageArea").show();   
                        fakePage();
                    }
                });
            } else if (index == 3) {
                //  代表工作
                RssApi.Table.List("releasum").condition({ "classifyid": 7 ,"state":1}).keyvalue({ "pagesize": 100 }).getJson(function (data) {
                    var liStr = "";
                    for (var i = 0; i < data.length; i++) {
                        var title = data[i].title;
                        if (title.indexOf(searchInput) != -1) {
                            count++;
                            flag = true;
                            liStr = liStr + "<li class='font_micro'>";
                            liStr = liStr + "<h2><a  target='_blank'>";
                            liStr = liStr + title;
                            liStr = liStr + "</a>";
                            liStr = liStr + "</h2>";
                            liStr = liStr + "<span class='data'>";
                            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                            liStr = liStr + "</span>";
                            liStr = liStr + "</li>";
                        }
                    }
                    $("#contentList").append(liStr);

                    if (flag == false) {
                        $("#nosearchDiv").hide();
                        $("#searchResultNull").show();
                        $("#recordNum").html("0");
                        $("#recordTime").html("0.02");
                    } else {
                        $("#nosearchDiv").show();
                        $("#searchResultNull").hide();
                        $("#recordNum").html(count);
                        $("#recordTime").html("0.089");

                        $("#pageArea").show();   
                        fakePage();
   
                    }
                });
            } else if (index == 4) {
                //  决议决定
                RssApi.Table.List("releasum").condition({ "classifyid": 9 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
                    var liStr = "";
                    for (var i = 0; i < data.length; i++) {
                        var title = data[i].title;
                        if (title.indexOf(searchInput) != -1) {
                            count++;
                            flag = true;
                            liStr = liStr + "<li class='font_micro'>";
                            liStr = liStr + "<h2><a  target='_blank'>";
                            liStr = liStr + title;
                            liStr = liStr + "</a>";
                            liStr = liStr + "</h2>";
                            liStr = liStr + "<span class='data'>";
                            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                            liStr = liStr + "</span>";
                            liStr = liStr + "</li>";
                        }
                    }
                    $("#contentList").append(liStr);

                    if (flag == false) {
                        $("#nosearchDiv").hide();
                        $("#searchResultNull").show();
                        $("#recordNum").html("0");
                        $("#recordTime").html("0.02");
                    } else {
                        $("#nosearchDiv").show();
                        $("#searchResultNull").hide();
                        $("#recordNum").html(count);
                        $("#recordTime").html("0.089");

                        $("#pageArea").show();   
                        fakePage();

                    }
                });
            } else if (index == 5) {
                //  议案建议
                RssApi.Table.List("releasum").condition({ "classifyid": 16 ,"state":1}).keyvalue({ "pagesize": 100}).getJson(function (data) {
                    var liStr = "";
                    for (var i = 0; i < data.length; i++) {
                        var title = data[i].title;
                        if (title.indexOf(searchInput) != -1) {
                            count++;
                            flag = true;
                            liStr = liStr + "<li class='font_micro'>";
                            liStr = liStr + "<h2><a  target='_blank'>";
                            liStr = liStr + title;
                            liStr = liStr + "</a>";
                            liStr = liStr + "</h2>";
                            liStr = liStr + "<span class='data'>";
                            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                            liStr = liStr + "</span>";
                            liStr = liStr + "</li>";
                        }
                    }
                    $("#contentList").append(liStr);

                    if (flag == false) {
                        $("#nosearchDiv").hide();
                        $("#searchResultNull").show();
                        $("#recordNum").html("0");
                        $("#recordTime").html("0.02");
                    } else {
                        $("#nosearchDiv").show();
                        $("#searchResultNull").hide();
                        $("#recordNum").html(count);
                        $("#recordTime").html("0.089");

                        $("#pageArea").show();   
                        fakePage();

                    }

                });
            } 
            
        } else {
            $("#nosearchDiv").hide();
            $("#searchResultNull").hide();
        }
        
        
    }

    
    
})

function enterDetailPage(rssid) {
    location.href = "News_show.htm?id=" + rssid + "";
}

var pageNum = 5; 
var outlines;
var pageCount = 0; 
var CP = document.getElementById("pageJump");
var FileBody = document.getElementById("content");
var pageCounttext = document.getElementById("pageCount");    

function fakePage() {
        outlines = document.getElementById("contentList").getElementsByTagName("li"); 
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
            pL += "<a href='javascript:void(0);'  onclick='toPage(" + (CP.value - 1) + ")'>上一页</a>";
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
            pL += "<a href='javascript:void(0);' onclick='toPage(" + ((CP.value) * 1 + 1) + ")'>下一页</a>";
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

            

        });