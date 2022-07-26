
// 通知公告2 改人大要闻1
RssApi.Table.List("releasum").condition({ "classifyid": 1 ,"state":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
    // $(".notice").mapview(data, {});
    // console.log(data)
    // $(".notice p").click(function () {
    //     console.log($(this).find("span").attr("rssid"))
    //     var rssid = $(this).find("span").attr("rssid");
    //     location.href = "News_show.htm?id=" + rssid + "";
    // })
    $(".notice p").each(function(){
       var index = $(this).index();
       console.log('title is:', data[index].title);
      $(this).find("span").text(data[index].title);
      $(this).attr("rssid", data[index].id);
    });

    $(".notice p").click(function () {
        var rssid = $(this).attr("rssid");
        location.href = "News_show.htm?id=" + rssid + "";
    });
});

$(function () {
    // RssApi.Table.Details("releasum").getJson(function (data) {
    //     console.log(data);
    //     $(".artcont").mapview(data);
    // })


    //大会会议
RssApi.Table.List("releasum").condition({ "meetid":1 ,"classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
       // var liStr = "";
       // for (var i = 0; i < data.length; i++) {
       //     liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
       //     liStr = liStr + data[i].title;
       //     liStr = liStr + "</a><span class='time'>";
       //     liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
       //     liStr = liStr + "</span></h4></li>";
       // }
       // $("#rendahuiyiul").append(liStr);
       // $(".super").mapview(data, {
       //     "shijian": function (val) {
       //         return new Date(val * 1000).toString("MM-dd")
       //     }
       // });

       // $(".super tr").click(function () {
       //     console.log($(this).attr("rssid"))
       //     var rssid = $(this).attr("rssid");
       //     location.href = "News_show.htm?id=" + rssid + "";
       // })
        // $(".rendahuiyiLi").mapview(data, {
        //     "shijian": function (val) {
        //        return new Date(val * 1000).toString("yyyy-MM-dd")
        //    }
        // });

        $(".rendahuiyiLi").each(function(){
          var index = $(this).index();
          $(this).find(".idSpan").text(data[index].id);
          $(this).find(".zhurenA").text(data[index].title);
          $(this).find(".time").text(new Date(data[index].shijian * 1000).toString("yyyy-MM-dd"));
        });

        $(".zhurenA").click(function(){
            var rssid = $(this).parent().find(".idSpan").html();
            location.href = "News_show.htm?id=" + rssid + "";
        });
   });
   //常委会议
   RssApi.Table.List("releasum").condition({ "meetid": 2 ,"classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

       // var liStr = "";
       // for (var i = 0; i < data.length; i++) {
       //     liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
       //     liStr = liStr + data[i].title;
       //     liStr = liStr + "</a><span class='time'>";
       //     liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
       //     liStr = liStr + "</span></h4></li>";
       // }
       // $("#changweihuiyiul").append(liStr);

       // $(".docurel").mapview(data, {
       //     "shijian": function (val) {
       //         return new Date(val * 1000).toString("MM-dd")
       //     }
       // });

       // $(".docurel tr").click(function () {
       //     console.log($(this).attr("rssid"))
       //     var rssid = $(this).attr("rssid");
       //     location.href = "News_show.htm?id=" + rssid + "";
       // })
//        $(".changweihuiyiLi").mapview(data, {
//            "shijian": function (val) {
//               return new Date(val * 1000).toString("yyyy-MM-dd")
//           }
//        });
//
//        $(".zhurenA").click(function(){
//            var rssid = $(this).parent().find(".idSpan").html();
//            location.href = "News_show.htm?id=" + rssid + "";
//        });
        
        
         $(".changweihuiyiLi").each(function(){
          var index = $(this).index();
          $(this).find(".idSpan").text(data[index].id);
          $(this).find(".zhurenA").text(data[index].title);
          $(this).find(".time").text(new Date(data[index].shijian * 1000).toString("yyyy-MM-dd"));
        });

        $(".zhurenA").click(function(){
            var rssid = $(this).parent().find(".idSpan").html();
            location.href = "News_show.htm?id=" + rssid + "";
        });
        
        
   });
  //主任会议 
RssApi.Table.List("releasum").condition({ "meetid": 3 ,"classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

       // var liStr = "";
       // for (var i = 0; i < data.length; i++) {
       //     liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
       //     liStr = liStr + data[i].title;
       //     liStr = liStr + "</a><span class='time'>";
       //     liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
       //     liStr = liStr + "</span></h4></li>";
       // }
       // $("#zhurenhuiyiul").append(liStr);
       // $(".remper").mapview(data, {
       //     "shijian": function (val) {
       //         return new Date(val * 1000).toString("MM-dd")
       //     }
       // });

       // $(".remper tr").click(function () {
       //     console.log($(this).attr("rssid"))
       //     var rssid = $(this).attr("rssid");
       //     location.href = "News_show.htm?id=" + rssid + "";
       // })

        $(".zhurenhuiyiLi").mapview(data, {
            "shijian": function (val) {
               return new Date(val * 1000).toString("yyyy-MM-dd");
           }
        });

        $(".zhurenA").click(function(){
            var rssid = $(this).parent().find(".idSpan").html();
            location.href = "News_show.htm?id=" + rssid + "";
        });
   });

    
});
// RssApi.Table.List("releasum").condition({ "classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

//         var liStr = "";
//         var liStr_committee = "";
//         var liStr_director = "";
//         for (var i = 0; i < data.length; i++) {
//             var meetid = data[i].meetid + "";
//             if ( meetid =="1"  ) {
//             liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
//             liStr = liStr + data[i].title;
//             liStr = liStr + "</a><span class='time'>";
//             liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
//             liStr = liStr + "</span></h4></li>";
//             }
            
//             else if ( meetid == "2" ) {
//             liStr_committee = liStr_committee + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
//             liStr_committee = liStr_committee + data[i].title;
//             liStr_committee = liStr_committee + "</a><span class='time'>";
//             liStr_committee = liStr_committee + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
//             liStr_committee = liStr_committee + "</span></h4></li>";
//             }
//             else if ( meetid == "3") {
//             liStr_director = liStr_director + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
//             liStr_director = liStr_director + data[i].title;
//             liStr_director = liStr_director + "</a><span class='time'>";
//             liStr_director = liStr_director + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
//             liStr_director = liStr_director + "</span></h4></li>";
//             }
//         }
//          $(".rendahuiyiLi").mapview(data);
//         $(".changweihuiyiLi").mapview(data);

//          $(".zhurenhuiyiLi").mapview(data);

// //        $("#rendahuiyiul").append(liStr);    
// //        $("#changweihuiyiul").append(liStr_committee);      
// //
// //        $("#zhurenhuiyiul").append(liStr_director);      

// })



//
////大会会议
// RssApi.Table.List("releasum").condition({ "meetid":1 ,"classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
//
//        var liStr = "";
//        for (var i = 0; i < data.length; i++) {
//            liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
//            liStr = liStr + data[i].title;
//            liStr = liStr + "</a><span class='time'>";
//            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
//            liStr = liStr + "</span></h4></li>";
//        }
//        $("#rendahuiyiul").append(liStr);
//        // $(".super").mapview(data, {
//        //     "shijian": function (val) {
//        //         return new Date(val * 1000).toString("MM-dd")
//        //     }
//        // });
//
//        // $(".super tr").click(function () {
//        //     console.log($(this).attr("rssid"))
//        //     var rssid = $(this).attr("rssid");
//        //     location.href = "News_show.htm?id=" + rssid + "";
//        // })
//    })
//    //常委会议
//    RssApi.Table.List("releasum").condition({ "meetid": 2 ,"classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
//
//        var liStr = "";
//        for (var i = 0; i < data.length; i++) {
//            liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
//            liStr = liStr + data[i].title;
//            liStr = liStr + "</a><span class='time'>";
//            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
//            liStr = liStr + "</span></h4></li>";
//        }
//        $("#changweihuiyiul").append(liStr);
//
//        // $(".docurel").mapview(data, {
//        //     "shijian": function (val) {
//        //         return new Date(val * 1000).toString("MM-dd")
//        //     }
//        // });
//
//        // $(".docurel tr").click(function () {
//        //     console.log($(this).attr("rssid"))
//        //     var rssid = $(this).attr("rssid");
//        //     location.href = "News_show.htm?id=" + rssid + "";
//        // })
//    })
//   //主任会议 
//RssApi.Table.List("releasum").condition({ "meetid": 3 ,"classifyid": 3 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
//
//        var liStr = "";
//        for (var i = 0; i < data.length; i++) {
//            liStr = liStr + "<li><h4><a onclick='rendaShowContent("+data[i].id+")' title='"+data[i].title+"' target='_blank'>";
//            liStr = liStr + data[i].title;
//            liStr = liStr + "</a><span class='time'>";
//            liStr = liStr + new Date(data[i].shijian * 1000).toString("yyyy-MM-dd");
//            liStr = liStr + "</span></h4></li>";
//        }
//        $("#zhurenhuiyiul").append(liStr);
//        // $(".remper").mapview(data, {
//        //     "shijian": function (val) {
//        //         return new Date(val * 1000).toString("MM-dd")
//        //     }
//        // });
//
//        // $(".remper tr").click(function () {
//        //     console.log($(this).attr("rssid"))
//        //     var rssid = $(this).attr("rssid");
//        //     location.href = "News_show.htm?id=" + rssid + "";
//        // })
//    })
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
            });

        }); 

function rendaShowContent(rssid) {
    location.href = "News_show.htm?id=" + rssid + "";
}