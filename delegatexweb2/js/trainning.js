function compare(p){ //这是比较函数
    return function(m,n){
        var a = m[p];
        var b = n[p];
        return b - a; //升序
    }
}


function getUrlInfor(url) {
    let startNum = url.indexOf('?')
    if (startNum === -1) {
        console.log('getUrlInfor无法链接获取信息');
        return
    }
    let dataStr = url.substr(startNum + 1)
    let arrs = dataStr.split('&')
    let obj = {}

    arrs.map(item => {
        obj[item.split('=')[0]] = item.split('=')[1]
    })
    return obj
}

var trainning_substationid = "100" ;
$(function () {
    console.log(window.location.href)
    var classify = window.location.href.split("classify=")[1];
    var state = window.location.href.split("state=")[1];
    var substationid = window.location.href.split("substationid=")[1]; 
    trainning_substationid = substationid ;
    var obj = getUrlInfor( window.location.href );
    substationid = obj.substationid ;
    classify = obj.classify ;
    state = 2 ;
    console.log(" ___ substationid ",substationid)
     console.log(" ___ state ",state)
      console.log(" ___ classify ",classify)
    RssApi.Table.List("stationcontent").condition( { "classify": classify  ,"state": state ,"substationid": substationid } ).keyvalue({ "pagesize": 1000 }).getJson(function (data) {
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
        
        
        fakePage();

    })
    
  //获取代表团名
    RssApi.Table.List("station_sub_id").condition( { "myid": substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
            console.log("____ home_subtitle is : " +  data[i].name );
           $("#home_subtitle").html( data[i].name )
        }
    })

})


$("#firstPage").click(function(){ //点击首页
    location.href = "contactstation.htm?substationid=" + trainning_substationid ; 
});
$("#trainning_contactStation").click(function(){ //点击联络站概况
    location.href = "contactstationDetail.htm?substationid=" + trainning_substationid ; 
});

$("#trainning_organization").click(function(){//组织机构
    location.href = "organization.htm?substationid=" + trainning_substationid ; 
});
$("#trainning_workdynamics").click(function(){//工作动态
    location.href = "workdynamics.htm?classify=1&state=2&substationid=" + trainning_substationid ;        
});
$("#trainning_delegate").click(function(){//人大代表
   location.href = "representative.htm?substationid=" + trainning_substationid ;            
});
 $("#trainning_institution").click(function(){//工作制度
    location.href = "institution.htm?substationid=" + trainning_substationid ;         
 });
$("#trainning_notice").click(function(){//通知公告
   location.href = "notice.htm?classify=3&state=2&substationid=" + trainning_substationid ;           
});
$("#trainning_allstation").click(function(){//联络总站
   location.href = "/delegatexweb/bmweb.jsp";      
})
        

function newsShowContent(rssid) {
    location.href = "News_show.htm?id=" + rssid + "&substationid=" + trainning_substationid ; 
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
            $("#notice_contactStation").click(function(){ //点击联络站概况
                location.href = "contactstationDetail.htm";
            });

            $("#notice_organization").click(function(){//组织机构
                location.href = "organization.htm";
            });
            $("#notice_workdynamics").click(function(){//工作动态
                location.href = "workdynamics.htm?classify=1&state=2";           
            });
            $("#notice_delegate").click(function(){//人大代表
               location.href = "representative.htm";           
            });
            $("#notice_notice").click(function(){//通知公告
//               location.href = "notice.htm?classify=3&state=2";           
            });
            $("#notice_allstation").click(function(){//联络总站
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