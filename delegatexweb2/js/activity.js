function compare(p){ //这是比较函数
    return function(m,n){
        var a = m[p];
        var b = n[p];
        return b - a; //升序
    }
}
$(function () {
    // console.log(window.location.href)
    var myid = window.location.href.split("myid=")[1];
//    var state = window.location.href.split("state=")[1];
    var substationid = window.location.href.split("substationid=")[1];
    var realname = "";
    myid = myid.replace("#","");
    substationid = substationid.replace("#","");

    console.log(" _______ myid is ",myid )
    console.log(" _______  substationid=", +substationid)
    RssApi.View.List("user_delegation").condition( { "myid": myid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
           realname = data[i].realname ;  
           $("#station_subtitle").html( data[i].divisionname)
        }
        
    myid = 1311 ;
    
    RssApi.View.List("activities").condition( { "myid": myid   } ).keyvalue({ "pagesize": 1000 }).getJson(function (data) {
        var liStr = "";
        data.sort(compare("shijian"));
        console.log(data)
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li><h4><a onclick='newsShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a><span class='time'>";
            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
            liStr = liStr + "</span></h4></li>";
           
        }
        $("#contentListul").append(liStr);
        realname = "&nbsp;&nbsp;" + realname + "-履职情况"
        $("#activity_currentPositionH3").html( realname )
        fakePage();

    })
    
    })
   
  
  //获取代表团名
    RssApi.Table.List("station_sub_id").condition( { "myid": substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
            console.log("____ home_subtitle is : " +  data[i].name );
           $("#home_subtitle").html( data[i].name )
        }
    })

})

function newsShowContent(rssid) {
        console.log(" _______ activity.js newsShowContent ")

    location.href = "News_show.htm?id=" + rssid + "&channel=98";
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
            pL += "<a href='javascript:void(0);' style='background:#1c92cf;' onclick='toPage(" + (CP.value - 1) + ")'>上一页</a>";
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
    
         
            $("#firstPage").click(function(){ //点击首页
            location.href = "contactstation.htm";
            });
            $("#workdynamics_contactstation").click(function(){ //点击联络站概况
                location.href = "contactstationDetail.htm";
            });

            $("#workdynamics_organization").click(function(){//组织机构
                location.href = "organization.htm";
            });
            $("#workdynamics_workdynamics").click(function(){//工作动态
//                location.href = "workdynamics.htm?classify=1&state=2";           
            });
            $("#workdynamics_delegate").click(function(){//人大代表
               location.href = "representative.htm";           
            });
            $("#workdynamics_institution").click(function(){//工作制度
               location.href = "institution.htm";           
            });
            $("#workdynamics_notice").click(function(){//通知公告
               location.href = "notice.htm?classify=3&state=2";           
            });
            $("#workdynamics_allstation").click(function(){//联络总站
               location.href = "/delegatexweb/bmweb.jsp";      
            })
        

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