var currentpage = 0 ;//记录翻页

var representative_substationid = "100";
var representative_mission = "1027";



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



$(function () {
    var worktitle = window.location.href.split("=")[1];
    var substationid = window.location.href.split("substationid=")[1]; 
    var mission = window.location.href.split("mission=")[1]; 
    
    var obj = getUrlInfor( window.location.href );
    substationid = obj.substationid ;
    mission = obj.mission ;
    if ( substationid != null ) {
        substationid = substationid.replace("#","");
    }
    
    if ( mission != null ) {
        mission = mission.replace("#","");
    }
    representative_substationid = substationid ;
    representative_mission = mission ;
    
    worktitle = 3 ;//强制为汝州市代表
    console.log(worktitle);
    if (worktitle == 0) {
        // $("#mdlm1").html("全国人大代表");
        $("#rendadaibiao").html("全国人大代表");
        $("#rendadaibiao").attr("href", "representative.htm?worktitle=1");
        $(".itm:eq(0)").addClass("representativeSelected").removeClass("lightBlueColor").siblings().addClass("lightBlueColor").removeClass("representativeSelected");
    } else if (worktitle == 1) {
        // $("#mdlm1").html("河南省人大代表");
        $("#rendadaibiao").html("河南省人大代表");
        $("#rendadaibiao").attr("href", "representative.htm?worktitle=2");
        $(".itm:eq(1)").addClass("representativeSelected").removeClass("lightBlueColor").siblings().addClass("lightBlueColor").removeClass("representativeSelected");
        // $("#itm1").html("省代表");
        // $("#itm1").attr("href", "representative.htm?worktitle=1");
    } else if (worktitle == 2) {
        // $("#mdlm1").html("平顶山市人大代表");
        $("#rendadaibiao").html("平顶山市人大代表");
        $("#rendadaibiao").attr("href", "representative.htm?worktitle=3");
        $(".itm:eq(2)").addClass("representativeSelected").removeClass("lightBlueColor").siblings().addClass("lightBlueColor").removeClass("representativeSelected");
        // $("#itm1").html("市代表");
        // $("#itm1").attr("href", "representative.htm?worktitle=2");
    } else if (worktitle == 3 ) {
        // $("#mdlm1").html("汝州市人大代表");
//        $("#rendadaibiao").html("汝州市人大代表");
        $("#rendadaibiao").attr("href", "representative.htm?worktitle=4");
        $(".itm:eq(3)").addClass("representativeSelected").removeClass("lightBlueColor").siblings().addClass("lightBlueColor").removeClass("representativeSelected");
        // $("#itm1").html("平顶山代表");
        // $("#itm1").attr("href", "representative.htm?worktitle=3");
    } 
//    else if (worktitle == 4) {
//        $("#mdlm1").html("区一代表");
//        $("#rendadaibiao").html("区一人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=4");
//        // $("#itm1").html("乡镇代表");
//        // $("#itm1").attr("href", "representative.htm?worktitle=4");
//    } else if (worktitle == 5) {
//        $("#mdlm1").html("区二代表");
//        $("#rendadaibiao").html("区二人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=5");
//    }
//    else if (worktitle == 6) {
//        $("#mdlm1").html("区三代表");
//        $("#rendadaibiao").html("区三人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=6");
//    } else if (worktitle == 7) {
//        $("#mdlm1").html("区四代表");
//        $("#rendadaibiao").html("区四人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=7");
//    } else if (worktitle == 8) {
//        $("#mdlm1").html("区五代表");
//        $("#rendadaibiao").html("区五人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=8");
//    } else if (worktitle == 9) {
//        $("#mdlm1").html("区六代表");
//        $("#rendadaibiao").html("区六人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=9");
//    } else if (worktitle == 10) {
//        $("#mdlm1").html("区七代表");
//        $("#rendadaibiao").html("区七人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=10");
//    } else if (worktitle == 11) {
//        $("#mdlm1").html("区八代表");
//        $("#rendadaibiao").html("区八人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=11");
//    } else if (worktitle == 12) {
//        $("#mdlm1").html("区九代表");
//        $("#rendadaibiao").html("区九人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=12");
//    } else if (worktitle == 13) {
//        $("#mdlm1").html("区十代表");
//        $("#rendadaibiao").html("区十人大代表");
//        $("#rendadaibiao").attr("href", "representative.htm?worktitle=13");
//    }

    if (worktitle >= 4) {
        worktitle = 4;
    }
    

   RssApi.Table.List("user").setLoading(true).keyvalue("pagesize", "500").condition(new RssDict().keyvalue({
//                      "state": 2,
                        "isdelegate": 1
     }).getDict()).getJson(function( data ) {
         
         
         currentpage = 0 ;
        $("#mdRight1").empty();
        var divStr = "";
        for (var i = 0; i< data.length; i++) {
            var worktitleData = data[i];
            
            ///判断层级
//            var globalLevel = ["全国人大代表", "河南省人大代表", "平顶山市人大代表", "汝州市人大代表", "乡镇人大代表"];
            var circleslist = data[i].circleslist ;
            

            if ( circleslist.indexOf("0") != -1 ) {
                nationData.push( data[i] );
            }
            else if ( circleslist.indexOf("1") != -1 ) {
                provinceData.push( data[i] ); 
            }
            else if ( circleslist.indexOf("2") != -1 ) {
                pingdingshanData.push( data[i] ); 
            }
            else {
                localData.push( data[i] ) ;
            }

            if (worktitle == 3) {
//                getdownTown(JSON.stringify(worktitleData));
//                getdownTown(JSON.stringify(localData));

                
            }
        }
        

        
        //全国代表
        if ( worktitle == 0 ) {
//            getOtherData( nationData, 0 );
            $("#mdRight1").show();
            $("#mdRight2").hide();
            otherData = nationData;
            getOtherData( nationData, 0);
        }
        
        //省代表
        if ( worktitle == 1 ) {
            
//            getOtherData( provinceData, 0 );
            $("#mdRight1").show();
            $("#mdRight2").hide();
            otherData = provinceData;
            getOtherData( provinceData, 0);
        }
        //平顶山代表
        if ( worktitle == 2 ) {
//            getOtherData( pingdingshanData, 0 );
            $("#mdRight1").show();
            $("#mdRight2").hide();
            otherData = pingdingshanData;
            getOtherData( pingdingshanData, 0);
        }
        //汝州
        if ( worktitle == 3 ) {
            var index = 1;
            getRuZhouData(index);
        }
        
    //获取代表团名
    RssApi.Table.List("station_sub_id").condition( { "myid": substationid   } ).keyvalue({ "pagesize": 10 }).getJson(function ( data ) {
        for (var i = 0; i < data.length; i++) {
           $("#home_subtitle").html( data[i].name )
        }
    })
        
//        if ( worktitle != 3 ) {
//            $("#mdRight1").show();
//            $("#mdRight2").hide();
//            //$("#mdRight1").append(divStr); 
//            otherData = data;
//            getOtherData(data, 0);
//        } else {
//            var index = 1;
//            getRuZhouData(index);
//        }
                                           
    })
//    
//    RssApi.Table.List("deputy_member").keyvalue({"worktitle": worktitle}).getJson(function (data) {
//        console.log(data);
//        $("#mdRight1").empty();
//        var divStr = "";
//        for (var i = 0; i< data.length; i++) {
//            var worktitleData = data[i];
//            if (worktitleData.worktitle == worktitle) {
//                divStr = divStr + "<div class='itm'>";
//                divStr = divStr + "<img src='http://117.158.113.36:80/upfile/"+worktitleData.ico+"'>";
//                divStr = divStr + "<p class='daibiaoStyle'>"+worktitleData.nickname+"</p>";
//                if (worktitleData.job != '无') {
//                    divStr = divStr + "<span class='jobStyle'>"+worktitleData.job+"</span>";
//                }
//            };
//        };
//        $("#mdRight1").append(divStr);
//    })

    $(".downtowmline span").click(function(){
        // $(this).css("color","black");
        // $(this).siblings().css("color","white");
        // $(this).parent().siblings().find("span").css("color","white");
        $(this).css("color","white");
        $(this).addClass("daibiaoSelected");
        $(this).siblings().removeClass("daibiaoSelected");
        $(this).siblings().css("color","#B4BCC8");
        $(this).parent().siblings().find("span").removeClass("daibiaoSelected");
        $(this).parent().siblings().find("span").css("color","#B4BCC8");
        var id = $(this).attr("id");
        if (id != "") {
            currentpage = 0 ;
            getRuZhouData(id);
        }
    })
    
})

var array1 = [];
var array2 = [];
var array3 = [];
var array4 = [];
var array5 = [];
var array6 = [];
var array7 = [];
var array8 = [];
var array9 = [];
var array10 = [];
var array11 = [];
var array12 = [];
var array13 = [];
var array14 = [];
var array15 = [];
var array16 = [];
var array17 = [];
var array18 = [];
var array19 = [];
var array20 = [];
var array21 = [];
var otherData = [];

var nationData = [];
var provinceData = [];
var pingdingshanData = [];
var localData = [];


function getdownTown ( worktitleDataStr ) {
    var worktitleData = JSON.parse( worktitleDataStr );
    var mission = worktitleData.mission;
    var downtown = "小屯镇";
    if (mission == '1027') {
        downtown = "小屯镇";
        worktitleData.downtown = downtown;
        array1.push(worktitleData);
    } else if (mission == '1028') {
        downtown = "寄料镇";
        worktitleData.downtown = downtown;
        array2.push(worktitleData);
    } else if (mission == '1029') {
        downtown = "温泉镇";
        worktitleData.downtown = downtown;
        array3.push(worktitleData);
    } else if (mission == '1030') {
        downtown = "临汝镇";
        worktitleData.downtown = downtown;
        array4.push(worktitleData);
    } else if (mission == '1031') {
        downtown = "蟒川镇";
        worktitleData.downtown = downtown;
        array5.push(worktitleData);
    } else if (mission == '1032') {
        downtown = "杨楼镇";
        worktitleData.downtown = downtown;
        array6.push(worktitleData);
    } else if (mission == '1033') {
        downtown = "庙下镇";
        worktitleData.downtown = downtown;
        array7.push(worktitleData);
    } else if (mission == '1034') {
        downtown = "陵头镇";
        worktitleData.downtown = downtown;
        array8.push(worktitleData);
    } else if (mission == '1035') {
        downtown = "米庙镇";
        worktitleData.downtown = downtown;
        array9.push(worktitleData);
    } else if (mission == '1036') {
        downtown = "纸坊镇";
        worktitleData.downtown = downtown;
        array10.push(worktitleData);
    } else if (mission == '1037') {
        downtown = "大峪镇";
        worktitleData.downtown = downtown;
        array11.push(worktitleData);
    } else if (mission == '1038') {
        downtown = "夏店镇";
        worktitleData.downtown = downtown;
        array12.push(worktitleData);
    } else if (mission == '1039') {
        downtown = "焦村镇";
        worktitleData.downtown = downtown;
        array13.push(worktitleData);
    } else if (mission == '1040') {
        downtown = "骑岭乡";
        worktitleData.downtown = downtown;
        array14.push(worktitleData);
    } else if (mission == '1041') {
        downtown = "王寨乡";
        worktitleData.downtown = downtown;
        array15.push(worktitleData);
    } else if (mission == '1042') {
        downtown = "风穴路街道";
        worktitleData.downtown = downtown;
        array16.push(worktitleData);
    } else if (mission == '1043') {
        downtown = "煤山街道";
        worktitleData.downtown = downtown;
        array17.push(worktitleData);
    } else if (mission == '1044') {
        downtown = "洗耳河街道";
        worktitleData.downtown = downtown;
        array18.push(worktitleData);
    } else if (mission == '1045') {
        downtown = "钟楼街道";
        worktitleData.downtown = downtown;
        array19.push(worktitleData);
    } else if (mission == '1046') {
        downtown = "汝南街道";
        worktitleData.downtown = downtown;
        array20.push(worktitleData);
    } else if (mission == '1047') {
        downtown = "紫云路街道";
        worktitleData.downtown = downtown;
        array21.push(worktitleData);
    }
}

function getRuZhouData( index ) {   
    var divStr1 = "";
    var gMission = ["1027","1027", "1028", "1029", "1030", "1031", "1032", "1033", "1034", "1035", "1036", "1037", "1038", "1039", "1040", "1041", "1042", "1043", "1044", "1045", "1046", "1047", "1048"];

//    
//     RssApi.Table.List("user").setLoading(true).keyvalue("pagesize", "500").condition(new RssDict().keyvalue({
//            "mission": gMission[index],
//            "isdelegate": 1
//    }).getDict()).getJson(function( data1 ) {
//        console.log(" __________ aaa getRuZhouData data=",data)
//        
    var data = [];
    for ( var i = 0 ; i < localData.length ; i++ ) {

        if (  representative_substationid == localData[i].divisionid ) {
            data.push( localData[i] ) ;
        }
    }
   
    if ( data.length > 0) {
        var pageCounter = 15 ;
        var showNextbutton = 1 ;
        var showPrevbutton = 1 ;
        var onlyOnepage = 0 ;
        

        var totalPages = data.length/pageCounter ;
        if ( data.length%pageCounter != 0 ) {
            totalPages ++ ;
        }
        totalPages = totalPages + "";
        totalPages = parseInt( totalPages ) ;


//        var endIndex = index + 15;
//        if (endIndex > array.length) {
//            endIndex = array.length;
//        }



        var startindex = currentpage*pageCounter;
        var endIndex = ( currentpage + 1 )*pageCounter;
        if ( endIndex > data.length ) {
            endIndex = data.length ;
        }
        if ( currentpage == 0 ) { //第一页
            showPrevbutton = 0 ;
        }
        if ( currentpage >= ( totalPages - 1 ) ) { //最后一页面
            showNextbutton = 0 ;
            showPrevbutton = 1 ;
        }
        if ( data.length <= pageCounter ) { //小于一页
            showNextbutton = 0 ;
            showPrevbutton = 0 ;
            onlyOnepage = 1 ;
        }

        
        
        
        
        
        

//        for (var i = 0; i< array.length; i++) {
        for (var i = startindex; i< endIndex; i++) {
    
            
            var worktitleData = data[i];
            divStr1 = divStr1 + "<div class='itm itm2'>";
            divStr1 = divStr1 + "<img src='http://117.158.113.36:80/upfile/"+worktitleData.avatar+"' onerror='this.src=\"\images/avatar.png\"\;' onclick='onclickAvatar("+ JSON.stringify(worktitleData.myid)+")'>";
            divStr1 = divStr1 + "<p class='daibiaoStyle'>"+worktitleData.realname+"</p>";
            if (worktitleData.job != '无') {
                divStr1 = divStr1 + "<span class='jobStyle'>"+worktitleData.job+"</span>";
            }
            divStr1 = divStr1 + "</div>";

        }
//        divStr1 = divStr1 + "<div id='pageDiv' style='clear:both;text-align:center;'>";
//        divStr1 = divStr1 + "<span style='color:#5497e2;cursor: pointer;' onclick='prev("+(index)+")'>上一页</span>";
//        divStr1 = divStr1 + "<span style='margin-left:20px;color:#5497e2;cursor: pointer;' onclick='nextPage("+(index)+")'>下一页</span>";
//        divStr1 = divStr1 + "</div>";
//     
 if ( onlyOnepage == 0 ) {
        divStr1 = divStr1 + "<div id='pageDiv' style='clear:both;text-align:center;'>";
        if ( showPrevbutton == 1 ) {
            divStr1 = divStr1 + "<span style='color:#5497e2;cursor: pointer;' onclick='prev("+(index)+")'>上一页</span>";
        }
        else {
            divStr1 = divStr1 + "<span style='color:grey;' >上一页</span>";
        }
        if ( showNextbutton == 1 ) {
            divStr1 = divStr1 + "<span style='margin-left:20px;color:#5497e2;cursor: pointer;' onclick='nextPage("+( index )+")'>下一页</span>";
        }
        else {
            divStr1 = divStr1 + "<span style='margin-left:20px;color:grey;' >下一页</span>";

        }
        divStr1 = divStr1 + "</div>";
    }
        
        
        
        $(".contit").remove();
        $(".itm2").remove();
        $("#pageDiv").remove();
        $("#mdRight2").show();
        $("#mdRight1").hide();
        $("#downtowmname").after(divStr1);
    }   
    
//   }) //结束网络
  
}

function nextPage( index ) {
    currentpage ++ ;
    getRuZhouData( index  ); 
    
//    index++;
//    if (index < 21) {
//        getRuZhouData(index);
//    }
}

function prev(index) {
    currentpage -- ;
    getRuZhouData( index  );
//    index--;
//    if (index > 0) {
//        getRuZhouData(index);
//    }
}

function nextPage1( index ) {  
    currentpage ++ ;
    getOtherData( otherData, currentpage );
    
//    index++;
//    var endIndex = Math.ceil(otherData.length / 15);
//    if (index > endIndex) {
//        index = endIndex;
//        return;
//    }
//    getOtherData( otherData, index);
}

function prev1(index) {
//    index--;
//    if (index < 0) {
//        index = 0;
//        return;
//    }
//    getOtherData(otherData, index);

      currentpage -- ;
      
      getOtherData ( otherData  ) ;
}


function getOtherData( data, index ) {
    var pageCounter = 15 ;
    var showNextbutton = 1 ;
    var showPrevbutton = 1 ;
    var onlyOnepage = 0 ;
    
    var totalPages = data.length/pageCounter ;

    console.log(" __________ total pages",data.length/pageCounter )
    console.log(" __________ currentpage",currentpage)
    console.log(" __________ data.length",data.length)

    var endIndex = index + 15;
    if (endIndex > data.length) {
        endIndex = data.length;
    }
    
    
    
    index = currentpage*pageCounter;
    endIndex = ( currentpage + 1 )*pageCounter;
    if ( endIndex > data.length ) {
        endIndex = data.length ;
    }
    if ( currentpage == 0 ) { //第一页
        showPrevbutton = 0 ;
    }
    if ( currentpage >= ( totalPages - 1 ) ) { //最后一页面
        showNextbutton = 0 ;
        showPrevbutton = 1 ;
    }
    if ( data.length <= pageCounter ) { //小于一页
        showNextbutton = 0 ;
        showPrevbutton = 0 ;
        onlyOnepage = 1 ;
    }

    
    var divStr1 = "";
    for (var i = index; i < endIndex; i++) {
        var worktitleData = data[i];
        divStr1 = divStr1 + "<div class='itm itm2'>";
        divStr1 = divStr1 + "<img src='http://117.158.113.36:80/upfile/"+worktitleData.avatar+"' onerror='this.src=\"\images/avatar.png\"\;'>";
        divStr1 = divStr1 + "<p class='daibiaoStyle'>"+worktitleData.realname+"</p>";
        if (worktitleData.job != '无') {
            divStr1 = divStr1 + "<span class='jobStyle'>"+worktitleData.job+"</span>";
        }
        divStr1 = divStr1 + "</div>";
    }
    
    
    
    if ( onlyOnepage == 0 ) {
    divStr1 = divStr1 + "<div id='pageDiv1' style='clear:both;text-align:center;'>";
    if ( showPrevbutton == 1 ) {
        divStr1 = divStr1 + "<span style='color:#5497e2;cursor: pointer;' onclick='prev1("+(index)+")'>上一页</span>";
    }
    else {
        divStr1 = divStr1 + "<span style='color:grey;' >上一页</span>";
    }
    if ( showNextbutton == 1 ) {
        divStr1 = divStr1 + "<span style='margin-left:20px;color:#5497e2;cursor: pointer;' onclick='nextPage1("+( index )+")'>下一页</span>";
    }
    else {
        divStr1 = divStr1 + "<span style='margin-left:20px;color:grey;' >下一页</span>";

    }
    divStr1 = divStr1 + "</div>";
    }

    
    $("#mdRight1").empty();
    $("#mdRight1").append(divStr1); 

}

function onclickAvatar(myid) {
    console.log(myid)
     location.href = "/delegatexweb/infopage/delegateinfo.jsp?relationid=" +  myid ;
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
            location.href = "contactstation.htm?substationid=" + representative_substationid ;  
            });
            $("#representative_contactStation").click(function(){ //点击联络站概况
                location.href = "contactstationDetail.htm?substationid=" + representative_substationid ;  
            });

            $("#representative_organization").click(function(){//组织机构
                location.href = "organization.htm?substationid=" + representative_substationid ;  
            });
            $("#representative_workdynamics").click(function(){//工作动态
                location.href = "workdynamics.htm?classify=1&state=2&substationid=" + representative_substationid ;             
            });
            $("#representative_delegate").click(function(){//人大代表
//               location.href = "representative.htm";           
            });
            
            $("#representative_institution").click(function(){//工作制度
               location.href = "institution.htm?substationid=" + representative_substationid ;            
            });
            $("#representative_notice").click(function(){//通知公告
               location.href = "notice.htm?classify=3&state=2&substationid=" + representative_substationid ;            
            });
            $("#representative_allstation").click(function(){//联络总站
               location.href = "/delegatexweb/bmweb.jsp";      
            })

            $(document).keydown(function(event){
            if(event.keyCode == 13){ 
                location.href = "searchResult.htm";
            }
        });

        });