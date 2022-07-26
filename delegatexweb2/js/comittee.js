$(function () {
    var worktitle = window.location.href.split("=")[1];
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
        $("#rendadaibiao").html("汝州市人大代表");
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
    
   RssApi.Table.List("user_committee").setLoading(true).keyvalue("pagesize", "500").condition(new RssDict().keyvalue({
//                      "state": 2,
                    }).getDict()).getJson(function(data) {
        $("#mdRight1_committee").empty();
        var divStr = "";
        console.log(" _____________ aaaaa")

           console.log(data);
        for (var i = 0; i< data.length; i++) {
            var worktitleData = data[i];
//            console.log(" _____________ worktitleData",worktitleData)
//            data[i].ico= 'http://117.158.113.36:80/upfile/'+worktitleData.ico;
           // if (worktitleData.worktitle == 2 ) 
            // {
//                 if (worktitle != 3) {
//                     divStr = divStr + "<div class='itm'>";
//                     divStr = divStr + "<img src='http://117.158.113.36:80/upfile/"+worktitleData.avatar+"' onerror='this.src=\"\images/avatar.png\"\;'>";
// //                    divStr = divStr + "<img src='../images/avatar.png"+"'>";

                    
//                     divStr = divStr + "<p class='daibiaoStyle'>"+worktitleData.realname+"</p>";
//                     if (worktitleData.job != '无') {
//                         divStr = divStr + "<span class='jobStyle'>"+worktitleData.job+"</span>";
//                     }
//                     divStr = divStr + "</div>";
//                 } else {
//                     getdownTown(JSON.stringify(worktitleData));
//                 }
                
            // };

            if (worktitle == 3) {
                getdownTown(JSON.stringify(worktitleData));
            }
            

        }
        if (worktitle != 3) {
            $("#mdRight1_committee").show();
            $("#mdRight2").hide();
            //$("#mdRight1_committee").append(divStr); 
            otherData = data;
            getOtherData(data, 0);
        } else {
            var index = 1;
            getRuZhouData(index);
        }
                                           
    })
//    
//    RssApi.Table.List("deputy_member").keyvalue({"worktitle": worktitle}).getJson(function (data) {
//        console.log(data);
//        $("#mdRight1_committee").empty();
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
//        $("#mdRight1_committee").append(divStr);
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


var currentPage = 0 ;
var datalength = 0 ;

function getdownTown (worktitleDataStr) {
    var worktitleData = JSON.parse(worktitleDataStr);
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
    var array = [];
    if (index == 1) {
        array = array1;
    } else if (index == 2) {
        array = array2;
    } else if (index == 3) {
        array = array3;
    } else if (index == 4) {
        array = array4;
    } else if (index == 5) {
        array = array5;
    } else if (index == 6) {
        array = array6;
    } else if (index == 7) {
        array = array7;
    } else if (index == 8) {
        array = array8;
    } else if (index == 9) {
        array = array9;
    } else if (index == 10) {
        array = array10;
    } else if (index == 11) {
        array = array11;
    } else if (index == 12) {
        array = array12;
    } else if (index == 13) {
        array = array13;
    } else if (index == 14) {
        array = array14;
    } else if (index == 15) {
        array = array15;
    } else if (index == 16) {
        array = array16;
    } else if (index == 17) {
        array = array17;
    } else if (index == 18) {
        array = array18;
    } else if (index == 19) {
        array = array19;
    } else if (index == 20) {
        array = array20;
    } else if (index == 21) {
        array = array21;
    }
    if ( array.length > 0) {
        
        /*注释选择对应乡镇时显示乡镇的title*/
//        divStr1 = divStr1 + "<div class='contit'>";
//        divStr1 = divStr1 + "<h3>" + array[0].downtown + "</h3>";
//        divStr1 = divStr1 + "</div>";

        datalength = array.length ;

        for (var i = 0; i< array.length; i++) {
            var worktitleData = array[i];
            divStr1 = divStr1 + "<div class='itm itm2'>";
            divStr1 = divStr1 + "<img src='http://117.158.113.36:9002/upfile/"+ worktitleData.ico +"' onerror='this.src=\"\images/avatar.png\"\;'>";
            divStr1 = divStr1 + "<p class='daibiaoStyle'>"+worktitleData.realname+"</p>";
            if (worktitleData.job != '无') {
                divStr1 = divStr1 + "<span class='jobStyle'>"+worktitleData.job+"</span>";
            }
            divStr1 = divStr1 + "</div>";

        }
        
        
        divStr1 = divStr1 + "<div id='pageDiv' style='clear:both;text-align:center;'>";
        divStr1 = divStr1 + "<span style='color:#5497e2;cursor: pointer;' onclick='prev("+(index)+")'>上一页</span>";
        divStr1 = divStr1 + "<span style='margin-left:20px;color:#5497e2;cursor: pointer;' onclick='nextPage("+( index )+")'>下一页</span>";

        
        divStr1 = divStr1 + "</div>";
        $(".contit").remove();
        $(".itm2").remove();
        $("#pageDiv").remove();
        $("#mdRight2").show();
        $("#mdRight1_committee").hide();
        $("#downtowmname").after(divStr1);
    }            
}

function nextPage( index ) {
    index++;
    if (index < 21) {
        getRuZhouData(index);
    }
  

    
}

function prev(index) {
    index--;
    if (index > 0) {
        getRuZhouData(index);
    }
}

function nextPage1(index) {
//    index++;
//    var endIndex = Math.ceil( otherData.length / 15);
//    if (index > endIndex) {
//        index = endIndex;
//        return;
//    }
//    getOtherData(otherData, index);

    
    currentPage ++ ;
    getOtherData( otherData, currentPage*15 );
}

function prev1(index) {
//    index--;
//    if (index < 0) {
//        index = 0;
//        return;
//    }
//    getOtherData(otherData, index);

    currentPage -- ;
    getOtherData( otherData, currentPage*15 );
}


function getOtherData(data, index) {
    datalength = data.length ;

    var endIndex = index + 15;
    if (endIndex > data.length) {
        endIndex = data.length;
    }
    var divStr1 = "";
    for (var i = index; i < endIndex; i++) {
        var worktitleData = data[i];
        divStr1 = divStr1 + "<div class='itm itm2'>";
        divStr1 = divStr1 + "<img src='http://117.158.113.36:80/upfile/"+worktitleData.ico+"' onerror='this.src=\"\images/avatar.png\"\;'>";
        divStr1 = divStr1 + "<p class='daibiaoStyle'>"+worktitleData.realname+"</p>";
//        if (worktitleData.job != '无') {
//            divStr1 = divStr1 + "<span class='jobStyle'>"+worktitleData.job+"</span>";
//        }
        divStr1 = divStr1 + "</div>";
    }
    divStr1 = divStr1 + "<div id='pageDiv1' style='clear:both;text-align:center;'>";
//    divStr1 = divStr1 + "<span style='color:#5497e2;cursor: pointer;' onclick='prev1("+( index )+")'>上一页</span>";
//    divStr1 = divStr1 + "<span style='margin-left:20px;color:#5497e2;cursor: pointer;' onclick='nextPage1("+( index )+")'>下一页</span>";
    
    
    if (  currentPage == 0 ) {
        divStr1 = divStr1 + "<span style='margin-left:20px;color:grey;' >上一页</span>";
    } 
    else {
        divStr1 = divStr1 + "<span style='color:#5497e2;cursor: pointer;' onclick='prev1("+( currentPage )+")'>上一页</span>";
    }
    if ( ( currentPage + 1 )*15 < datalength ) {
        divStr1 = divStr1 + "<span style='margin-left:20px;color:#5497e2;cursor: pointer;' onclick='nextPage1("+( currentPage )+")'>下一页</span>";
    }  
    else {
       
        divStr1 = divStr1 + "<span style='margin-left:20px;color:grey;' >下一页</span>";
   
    }
    
    divStr1 = divStr1 + "</div>";
    $("#mdRight1_committee").empty();
    $("#mdRight1_committee").append(divStr1); 

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
                location.href = "searchResult.htm";
            }
        });

        });