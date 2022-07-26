

function compare(p){ //这是比较函数
    return function(m,n){
        var a = m[p];
        var b = n[p];
        return b - a; //升序
    }
}

$(function () {
    // console.log(window.location.href)
    var classify = window.location.href.split("classifyid=")[1];
    var meetid = window.location.href.split("meetid=")[1];
    // var dataLength = window.location.href.split("dataLength=")[1];
    var publiclassifyid = "";
    var newsid = "";
    console.log(meetid)
    console.log(classify)
    if (classify != null && classify != undefined && classify.indexOf('14') != -1) {
        publiclassifyid = window.location.href.split("publiclassifyid=")[1];
        if (publiclassifyid.indexOf('#') != -1) {
            publiclassifyid = publiclassifyid.replace("#", "");
        }
        console.log("publiclassifyid is:", publiclassifyid);
    }
    if (classify != null && classify != undefined && classify.indexOf('1&') != -1) {
        classify = classify.split("&")[0];
        newsid = window.location.href.split("newsid=")[1];
        if (newsid.indexOf('#') != -1) {
            newsid = newsid.replace("#", "");
        }
        console.log("classify is:", classify);
        console.log("newsid is:", newsid);
    }
    var classifytype = ["人大要闻", "通知公告", "重要会议", "立法工作", "乡镇人大", "监督工作", "代表工作", "头条", "决议决定", "选举任免", "机关建设", "汝州人大电子版","","预算公开","调查研究","议案建议","时政新闻"];

    var meetstype = ["人民代表大会会议", "常委会会议", "主任会议"];


    if (meetid != undefined) {
        $(".n01").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p>当前位置 >> <a style='color:white;' href='index.htm'>网站首页</a> >> " + meetstype[parseInt(meetid) - 1]);
//        $("#currentPosition").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p>当前位置 >> <a style='font-size:18px' href='index.htm'>网站首页</a> >> " + meetstype[parseInt(meetid) - 1]);
        $("#currentPosition").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p>会议报道 > " + meetstype[parseInt(meetid) - 1]);

        $("#currentPositionH3").html( "&nbsp" + meetstype[parseInt(meetid) - 1]);
          
    } else {
        //$(".n01").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p>当前位置 >> <a style='color:white;' href='index.htm'>网站首页</a> >> " + classifytype[parseInt(classify) - 1]);
        if (classify == '19') {
            $("#currentPosition").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p><a style='font-size:18px' href='index.htm'></a>人大杂志");
            $("#currentPositionH3").html( "&nbsp;人大杂志" );
        } else {
            if (classify == '1') {
                if (newsid == '1') {
                    $("#currentPosition").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p><a style='font-size:18px' href='index.htm'></a>" + "人大要闻");
                    $("#currentPositionH3").html("&nbsp;人大要闻");
                } else {
                    $("#currentPosition").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p><a style='font-size:18px' href='index.htm'></a>" + "时政新闻");
                    $("#currentPositionH3").html("&nbsp;时政新闻");
                }
            } else {
                $("#currentPosition").html(" <p style='font-weight:bolder;color:white;float: left;padding-left:15px;'>|</p><a style='font-size:18px' href='index.htm'></a>" + classifytype[parseInt(classify) - 1]);
                var caption = "&nbsp;" + classifytype[parseInt(classify) - 1] ;
                caption =
                $("#currentPositionH3").html( caption );
            }
           
        }
       
    }
    console.log(classifytype[parseInt(classify) - 1]);

    // 2通知公告 改人大要闻1
    RssApi.Table.List("releasum").condition( { "classifyid": 1 ,"state":1 } ).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        
        data.sort(compare("shijian"));

        $(".notice").mapview(data, {});
        console.log(data)
        $(".notice p").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })



    // 图片内容
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
        $(".imgcont").mapview(arrays, {});
        $(".imgcont center").click(function () {
            console.log($(this).find("a").attr("rssid"))
            var rssid = $(this).find("a").attr("rssid");
            location.href = "News_show.htm?id=" + rssid + "";
        })
    })


    // 主内容
    var contype = { "classifyid": classify ,"state":1};
    if (meetid != undefined) {
        contype = { "classifyid": 3, "meetid": meetid ,"state":1}
    }
    if (classify == '1') {
        contype = { "classifyid": 1, "newsid": newsid ,"state":1}
    }



    if (classify == '19') {
        // 人大杂志
        RssApi.Table.List("magazine").keyvalue({ "classifyid": 19, "state": 1}).keyvalue({ "pagesize": 1000 }).getJson(function (data) {
            console.log("magazine data is:" + data);
            if (data) {
                var liStr = "";
                for (var i = 0; i < data.length; i++) {
                    var imgcont = data[i];
                    liStr = liStr + "<li><h4><a href='http://117.158.113.36:80/upfile/"+imgcont.enclosure+"' target='_blank'>";
                    liStr = liStr + data[i].title;
                    liStr = liStr + "</a><span class='time'>";
                    liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                    liStr = liStr + "</span></h4></li>";
                } 
                $("#contentListul").append(liStr);
                fakePage();
            }
            
        });
    } else {
        RssApi.Table.List("releasum").condition(contype).keyvalue({ "pagesize": 1000 }).getJson(function ( data ) {
        var liStr = "";
        console.log( "data____________________" );
        console.log( classify );


        if ( classify == '5' ) { //乡镇人大
                    
            //添加工作动态
            RssApi.Table.List("stationcontent").condition( { "classify": 1 ,"state": 2 } ).keyvalue({ "pagesize": 1000 }).getJson(function ( data1 ) {
                var liStr = "";
                data1.concat(data)
                data1=  data1.sort(function( a, b ) { return a.shijian < b.shijian ? 1 : -1;} ); //按时间排序

                for ( var i = 0; i < data1.length; i++ ) {
                   liStr = liStr + "<li><h4><a onclick='newsShowClassifyContent("+ data1[i].id+")' title='"+ data1[i].title+"' target='_blank'>";
                   liStr = liStr + data1[i].title;
                   liStr = liStr + "</a><span class='time'>";
                   liStr = liStr + new Date( data1[i].shijian * 1000).toString("yyyy-MM-dd");
                   liStr = liStr + "</span></h4></li>";
                };
                $("#contentListul").append(liStr);   
            })
        
        
        
        }
        else 
        {
             data.sort(compare("shijian"));
            for (var i = 0; i < data.length; i++) {
                liStr = liStr + "<li><h4><a onclick='newsShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
                liStr = liStr + data[i].title;
                liStr = liStr + "</a><span class='time'>";
                liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
                liStr = liStr + "</span></h4></li>";
            }
            $("#contentListul").append(liStr);
        }
        
       
        

        
        
        
        fakePage();
        // $(".macont").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("yyyy-MM-dd")
        //     }
        // });
        // console.log(data)
        // $(".macont table").click(function () {
        //     console.log($(this).find("tr").attr("rssid"))
        //     var rssid = $(this).find("tr").attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";

        // })

        })
    }
    
   

    // // 分页
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

function newsShowContent( rssid) {
    location.href = "News_show.htm?id=" + rssid + "";
}


function newsShowClassifyContent( rssid   ) {
    
    
    location.href = "News_classification_show.htm?id=" + rssid;
    
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