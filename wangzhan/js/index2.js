
// location.reload();
$(document).ready(function () {
    //第一次进入页面刷新一次，仅一次
    //location.href.indexOf("#")获取当前页面地址并在其中查找"#"首次出现位置，找不到就是-1
    if(location.href.indexOf("#")==-1){
        //在当前页面地址加入"#"，使下次不再进入此判断
        location.href=location.href+"#";
        location.reload();
    }
})
$(function () {

    // 人大新闻
    // .condition({"classify":1})
    RssApi.Table.Details("releasum").condition({ "classifyid": 1 }).getJson(function (data) {
        console.log(data);
        $(".journ").mapview(data)

    })
    // 新闻详情
    $(".joudet").click(function () {
        var rssid = $(this).attr("rssid");
        console.log(rssid)
        location.href = "wangzhan/News_show.htm?id=" + rssid + "";

    })



    RssApi.Table.List("releasum").condition({ "classifyid": 1 ,"state":1, "newsid":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("nationNewsLiStr is:", liStr);
        $("#nationalNews").append(liStr);
        // $(".journlist").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("MM-dd")
        //     } 
        // });
        // console.log(data);
        // $(".journlist p").click(function () {
        //     console.log($(this).find("span").attr("rssid"))
        //     var rssid = $(this).find("span").attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";
        // })
    });

    RssApi.Table.List("releasum").condition({ "classifyid": 1 ,"state":1, "newsid":2}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("affairsNews is:", liStr);
        $("#affairsNews").append(liStr);
    });




    // 主任之窗
    RssApi.Table.Details("reldirector").condition({ "worktitle": 1 }).getJson(function (data) {

        console.log("nickname1:", data);
        var aStr = "<a target='_blank' onclick='enterPage("+data.id+")'><img src='http://117.158.113.36:80/upfile/"+data.ico+"' alt='"+data.nickname+"' srcset='' item-img=''>";
        $("#zhurenLi").append(aStr);

        $("#zhurenALink").attr("href", "wangzhan/zhuren_show.htm?id=" + data.id);
        $("#zhurenALink").html(data.nickname);
        $(".director").mapview(data, {
            "nickname": function (val) {
                return "<span class='i11' style='margin-left:10px;'>主任：</span>" + val
            }
        });
        //console.log(data);
        $(".director").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "wangzhan/zhuren_show.htm?id=" + rssid + "";
        })
    })

    RssApi.Table.List("reldirector").condition({ "worktitle": 2 }).keyvalue({ "pagesize": 6 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.id > b.id ? 1 : -1;} );
        console.log("nickname2:", data);

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li class='dh_modular_news'>";
            liStr = liStr + "<a onclick='enterPage("+data[i].id+")' target='_blank' item-title='' item-href=''>";
            liStr = liStr + data[i].nickname + "</a></li>";
        }
        $("#fuzhurenul").append(liStr);

        $(".dedirectors").mapview(data);
        //console.log(data)
        $(".dedirectors a").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "wangzhan/zhuren_show.htm?id=" + rssid + "";
        })
    })
 RssApi.Table.List("reldirector").condition({ "worktitle": 3 }).keyvalue({ "pagesize": 6 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.id > b.id ? 1 : -1;} );
        console.log("nickname3:", data);

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li class='dh_modular_news'>";
            liStr = liStr + "<a onclick='enterPage("+data[i].id+")' target='_blank' item-title='' item-href=''>";
            liStr = liStr + data[i].nickname + "</a></li>";
        }
        $("#dangzhuul").append(liStr);
        $(".dedirectorss").mapview(data);
        //console.log(data)
        $(".dedirectorss a").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "wangzhan/zhuren_show.htm?id=" + rssid + "";
        })
    })


    RssApi.Table.List("reldirector").condition({ "worktitle": 4 }).keyvalue({ "pagesize": 6 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.id > b.id ? 1 : -1;} );
        console.log("nickname4:", data);

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li class='dh_modular_news'>";
            liStr = liStr + "<a onclick='enterPage("+data[i].id+")' target='_blank' item-title='' item-href=''>";
            liStr = liStr + data[i].nickname + "</a></li>";
        }
        $("#mishuzhangul").append(liStr);
        $(".dedirectorsss").mapview(data);
        //console.log(data)
        $(".dedirectorsss a").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "wangzhan/zhuren_show.htm?id=" + rssid + "";
        })
    })




    // 通知公告2 改 人大要闻1
    RssApi.Table.List("releasum").condition({ "classifyid": 1,"state":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {
        $(".notice").mapview(data, {});
        console.log(data)
        $(".notice p").click(function () {
            console.log($(this).find("span").attr("rssid"))
            var rssid = $(this).find("span").attr("rssid");
            location.href = "wangzhan/News_show.htm?id=" + rssid + "";
        })
    })




    //重要发布 
    RssApi.Table.List("releasum").condition({ "classifyid": 9 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
        console.log("importmeeting data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#importantMeeting").append(liStr);
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
    })

    // 乡镇动态
    RssApi.Table.List("releasum").condition({ "classifyid": 5 ,"state":1}).keyvalue({ "pagesize": 6 }).getJson(function (data) {
        console.log("townshipCongress data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#townshipCongress").append(liStr);
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
    })



    // 立法工作  通知公告
    RssApi.Table.List("releasum").condition({ "classifyid": 2 ,"state":1}).keyvalue({ "pagesize": 12}).getJson(function (data) {
        console.log("legislationWork data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#legislationWork").append(liStr);
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
    })

    // 议案建议
    RssApi.Table.List("releasum").condition({ "classifyid": 16 ,"state":1}).keyvalue({ "pagesize": 8}).getJson(function (data) {
        console.log("proposal data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#proposal").append(liStr);
        //$("#jianyiyianul").append(liStr);
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
    })




    // 监督工作
    RssApi.Table.List("releasum").condition({ "classifyid": 6 ,"state":1}).keyvalue({ "pagesize": 14 }).getJson(function (data) {
        console.log("supervision data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#supervision").append(liStr);
        // $(".repwork").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("MM-dd")
        //     }
        // });

        // $(".repwork tr").click(function () {
        //     console.log($(this).attr("rssid"))
        //     var rssid = $(this).attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";
        // })
    })

    // 人大公报
    RssApi.Table.List("releasum").condition({"classifyid":13,"state":1}).keyvalue({ "pagesize": 100 }).getJson(function (data) {
        console.log(data)
        var obj = {};
        arrays = data.reduce(function (item, next) {
            obj[next.organize] ? '' : obj[next.organize] = true && item.push(next);
            return item;

        }, []);
        // console.log(arrays.length)

        $(".conbull").mapview(arrays);
        $(".conbull a").click(function () {
            var rssid = $(this).find("span").attr("rssid");
            location.href = "wangzhan/baokan.htm?rssid=" + rssid + "";
        })
        // console.log(arrays)
    })





    // 代表工作
    RssApi.Table.List("releasum").condition({ "classifyid": 7 ,"state":1}).keyvalue({ "pagesize": 12 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#representativeWork").append(liStr);
        $("#representativeWork4").append(liStr);

        // $(".conrep").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("MM-dd")
        //     }
        // });

        // $(".conrep tr").click(function () {
        //     console.log($(this).attr("rssid"))
        //     var rssid = $(this).attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";
        // })
    })
    // 最新公告
    RssApi.Table.List("releasum").condition({ "classifyid": 8 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        console.log("newsNotice data is:", data);
        var liStr = "";
        var liStr2 = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";

            liStr2 = liStr2 + "<li><a onclick='newsShow("+data[i].id+")' title='"+data[i].title+"'>";
            liStr2 = liStr2 + data[i].title;
            liStr2 = liStr2 + "</a></li>";

        };
        console.log("liStr is:", liStr);
        $("#newsNotice").append(liStr);
        $("#newsTongzhiul").append(liStr2);
        jQuery(".txtMarquee-left").slide({mainCell:".bd ul",autoPlay:true,effect:"leftMarquee",interTime:50,trigger:"click"});
        // $(".orgbuil").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("MM-dd")
        //     }
        // });

        // $(".orgbuil tr").click(function () {
        //     console.log($(this).attr("rssid"))
        //     var rssid = $(this).attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";
        // })
    })

    // 决议决定
    RssApi.Table.List("releasum").condition({ "classifyid": 9 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#meetingDecision").append(liStr);

        // $(".workstudy").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("MM-dd")
        //     }
        // });

        // $(".workstudy tr").click(function () {
        //     console.log($(this).attr("rssid"))
        //     var rssid = $(this).attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";
        // })
    })


    // 选举任免
    RssApi.Table.List("releasum").condition({ "classifyid": 10 ,"state":1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {
        console.log("election data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#appointmentRemoval").append(liStr);
        
        // $(".cdpcongs").mapview(data, {
        //     "shijian": function (val) {
        //         return new Date(val * 1000).toString("MM-dd")
        //     }
        // });

        // $(".cdpcongs tr").click(function () {
        //     console.log($(this).attr("rssid"))
        //     var rssid = $(this).attr("rssid");
        //     location.href = "News_show.htm?id=" + rssid + "";
        // })
    })
    
    // 调查研究
    RssApi.Table.List("releasum").condition({ "classifyid": 15 ,"state":1}).keyvalue({ "pagesize": 14 }).getJson(function (data) {
        console.log("election data is:", data);
        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        $("#investigation").append(liStr);
      
    })


    // 报告
    RssApi.Table.List("releasum").condition({ "classifyid": 14 ,"state":1, "publiclassifyid": 1}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("______ liStr is aaaaa :", liStr);
        //$("#reporting").append(liStr);
        
    });

    // 预算公开
    RssApi.Table.List("releasum").condition({ "classifyid": 14 ,"state":1, "publiclassifyid": 2}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("—————————————————————————— bbb liStr is:", liStr);
        //$("#budgetPublic").append(liStr);
        
    });

    // 预算调整
    RssApi.Table.List("releasum").condition({ "classifyid": 14 ,"state":1, "publiclassifyid": 3}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        //$("#budgetAdjustment").append(liStr);
        
    });

    // 视察调研
    RssApi.Table.List("releasum").condition({ "classifyid": 14 ,"state":1, "publiclassifyid": 4}).keyvalue({ "pagesize": 8 }).getJson(function (data) {

        var liStr = "";
        for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li onclick='newsShow("+data[i].id+")'><div class='dot'></div><a title='"+data[i].title+"'>";
            liStr = liStr + data[i].title;
            liStr = liStr + "</a></li>";
        };
        console.log("liStr is:", liStr);
        //$("#inspectionInvestigation").append(liStr);
        
    });




    // 更多
    $(".more").click(function () {
        var classifyid = $(this).attr("classifyid");

        location.href = "wangzhan/News.htm?classifyid=" + classifyid + "";
        console.log("wangzhan/News.htm?classifyid=" + classifyid + "")

    })

    // 图片内容
    RssApi.Table.List("sceneryimg").keyvalue({ "pagesize": 20 ,"state":1}).getJson(function (data) {
        console.log("data is:" + data);
        //$(".imgcont").mapview(data, {
            // "ico":function(val){
            //     return "upfile/"+val
            // }
        //})
        if (data) {           
            for (var i = 0; i < data.length; i++) {
                var imgcont = data[i];
                console.log(imgcont);
                var liContent = "<ul id='horse-light-list' style='color:black;letter-spacing:2px;'><li class='horse-light-item' onclick='clickImg("+imgcont.id+")'><div><img src='http://117.158.113.36:80/upfile/"+imgcont.ico+"' /><h5>"+imgcont.title+"</h5></div></li></ul>";
                $(".container").append(liContent);
            }            
        }

        //$(".imgcont table").click(function () {
            //console.log("aa is:" + $(this).attr("rssid"))
            //var rssid = $(this).attr("rssid");
            //location.href = "Pro_show.htm?id=" + rssid + "";
        //})
    })
    
    
     // 滚动图片新闻
   RssApi.Table.List("imagin_news").keyvalue({ "pagesize": 6 ,"state":1}).getJson(function (data) {
       //console.log("data333 is:" + data);      
       if (data) {
            var ul = "<ul class='slider' >";
           for (var i = 0; i < data.length; i++) {
               var imgcont = data[i];
               ul = ul + "<li onclick='clickLi("+imgcont.id+")'><img src='http://117.158.113.36:80/upfile/"+imgcont.ico+"'/></li>";
           }
           ul = ul + "</ul>";
           $(".v_content_list").append(ul);

           var titleul = "<ul class='titleul'>";
           if (data.length > 0) {

                for (var i = 0; i < data.length; i++) {
                    var titlecont = data[i];
                    titleul = titleul + "<li><span id='sliderSpan'>" + titlecont.title + "</span></li>";
                }

           };


           var num = "<ul class='num' >";
           for (var i = 0; i < data.length; i++) {
                if (i == 0) {
                    num = num + "<li class='on'>"+(i+1)+"</li>";
                } else {
                    num = num + "<li>"+(i+1)+"</li>";
                }
           }
           num = num + "</ul>";
           $("#sliderDiv").append(titleul);
           $("#sliderDiv").append(num);
       }

         var len = data.length;
         var totalWidth = 564 * len;
         $(".v_content_list").width(totalWidth + "px");
         var ulWidth = 16 * len + 10 * (len - 1);
         $(".num").width(ulWidth + "px");
         $(".num").css("marginLeft", (564 - ulWidth) + "px");
         var index = 0;
         var adTimer;
         $(".num li").mouseover(function(){
            index  =   $(".num li").index(this);
            showImg(data[index].title, index);
         }).eq(0).mouseover();  
         //滑入 停止动画，滑出开始动画.
         $('.v_content_list').hover(function(){
                 clearInterval(adTimer);
             },function(){
                 adTimer = setInterval(function(){
                    showImg(data[index].title, index)
                    index++;
                    if(index==len){index=0;}
                  } , 5000);
         }).trigger("mouseleave");

   })
   
     
     // 首页专题集锦
    RssApi.Table.List("specail_collection").keyvalue({ "pagesize": 6 ,"state":1}).getJson(function (data) {
        console.log("data22 is:" + data);      
        if (data) {
            for (var i = 0; i < data.length; i++) {
                var imgcont = data[i];
                if (imgcont.state == '1') {
                    var ico = imgcont.ico;
                    $("#shangshiImg").attr("src", "http://117.158.113.36:80/upfile/" + ico);
                }
            }
        }
    })
    
    
      // 专题集锦子页图片
    RssApi.Table.List("ztimges").keyvalue({ "pagesize": 6 ,"state":1}).getJson(function (data) {
        console.log("data is:" + data);      
        if (data) {
            for (var i = 0; i < data.length; i++) {
                var imgcont = data[i];
                console.log(imgcont);
//                var liContent = "<li class='horse-light-item' onclick='clickImg("+imgcont.id+")'><div><img src='http://117.158.113.36:80/upfile/"+imgcont.ico+"' /><h5>"+imgcont.title+"</h5></div></li>";
//                $("#horse-light-list").append(liContent);
            }
        }

    })

    // 人大杂志
    RssApi.Table.List("magazine").keyvalue({ "classifyid": 19, "pagesize": 2}).getJson(function (data) {
        console.log("magazine data is:" + data);
        if (data) {
            var liStr = "";
            for (var i = 0; i < data.length; i++) {
                var imgcont = data[i];
                liStr = liStr + "<li><a href='http://117.158.113.36:80/upfile/"+imgcont.enclosure+"' target='_blank'>";
                liStr = liStr + "<img src='http://117.158.113.36:80/upfile/"+imgcont.ico+"' alt=''>";
                liStr = liStr + "</a></li>";
            } 
            $("#journal").append(liStr);
        }
        
    });

    $("#nav li:has(ul)").mouseover(function(){
            $(this).children("ul").stop(true,true).slideDown(400);
    });
    $("#nav li:has(ul)").mouseleave(function(){
            // $(this).stop(true,true).slideUp("fast");
        $(this).children("ul").stop(true,true).slideUp('fast');
    });

    let obj = {
        'nw1':[
            {id:'zhongyaohuiyi',value:'importantMeeting'},
            {id:'legislation',value:'legislationWork'},
            {id:'yianjianyi',value:'proposal'}
        ],
        'nw2':[
            {id:'jiandugongzuo',value:'supervision'},
            {id:'election',value:'appointmentRemoval'},
            {id:'daibiaogongzuo1',value:'representativeWork4'},         
            {id:'diaochayanjiu',value:'investigation'}
        ],
        'nw3':[
            {id:'daibiaogongzuo2',value:'representativeWork'},
            {id:'huiyijueding',value:'meetingDecision'}
        ],
        'nw4' :[
            {id:'baogao',value:'reporting'},
            {id:'yusuangongkai',value:'budgetPublic'},
            {id:'yusuantiaozheng',value:'budgetAdjustment'},
            {id:'shichadiaoyan',value:'inspectionInvestigation'}
        ],
        'nw5':[
            {id:'rendayaowen',value:'nationalNews'},
            {id:'shizhengxinwen',value:'affairsNews'}
        ],
    }

     $(".lmTitle ul li a").mouseover((event)=>{
            event.stopPropagation();
            let id  = event.target.id;
            $("#" + id).parents("li").addClass("on").siblings().removeClass("on");
            let nw = $('#'+id).parents('.newsWrap').attr('class').replace('newsWrap','').replace('tab_box','').replace(' ','').replace(' ','');
            if(obj[nw]&& obj[nw].length){
                obj[nw].forEach(ele => {
                    if(ele.id === id){
                        $('#' + ele.value).parent().addClass("left");
                        $('#' + ele.value).parent().removeClass("right");
                        $('#' + ele.value).parent().show();
                    }else{
                        $('#' + ele.value).parent().hide();
                    }
                });
            }
            // switch(id){
            //     case 'zhongyaohuiyi':
            //         $('.nw1 .zyfb_list .left').show();
            //         $('.nw1 .zyfb_list .right').hide()
            //     break;
            //     case 'legislation':
            //         $('.nw1 .zyfb_list .right').show();
            //         $('.nw1 .zyfb_list .left').hide()
            //     break;
            //     case 'townCongress':
            //         $('.nw2 .zyfb_list .left').show();
            //         $('.nw2 .zyfb_list .right').hide()
            //     break;
            //     case 'zuixingonggao':
            //         $('#newsNotice1').show();
            //         $('.nw2 .zyfb_list .left').hide();
            //         $('#supervision1').hide();
            //     break;
            //     case 'jiandugongzuo':
            //         $('#supervision1').show();
            //         $('.nw2 .zyfb_list .left').hide();
            //         $('#newsNotice1').hide();
            //     break;
            //     case 'daibiaogongzuo':
            //         $('.nw3 .zyfb_list .left').show();
            //         $('.nw3 .zyfb_list .right').hide();
            //     break;
            //     case 'huiyijueding':
            //         $('.nw3 .zyfb_list .right').show();
            //         $('.nw3 .zyfb_list .left').hide();
            //     break;
            //     case 'baogao':
            //         $('#reporting').show();
            //         $('#budgetPublic').hide();
            //         $('#budgetAdjustment').hide();
            //         $('#inspectionInvestigation').hide();
            //     break;
            //     case 'yusuangongkai':
            //         $('#reporting').hide();
            //         $('#budgetPublic').show();
            //         $('#budgetAdjustment').hide();
            //         $('#inspectionInvestigation').hide();
            //     break;
            //     case 'yusuantiaozheng':
            //         $('#reporting').hide();
            //         $('#budgetPublic').hide();
            //         $('#budgetAdjustment').show();
            //         $('#inspectionInvestigation').hide();
            //     break;
            //     case 'shichadiaoyan':
            //         $('#reporting').hide();
            //         $('#budgetPublic').hide();
            //         $('#budgetAdjustment').hide();
            //         $('#inspectionInvestigation').show();
            //     break;
            //     case 'rendayaowen':
            //         $('.nw5 .zyfb_list .left').show();
            //         $('.nw5 .zyfb_list .right').hide()
            //     break;
            //     case 'shizhengxinwen':
            //         $('.nw5 .zyfb_list .right').show();
            //         $('.nw5 .zyfb_list .left').hide();
            //     break;
            // }
           
        });

        $("#rendayaowen").click(function(){
            location.href = "wangzhan/News.htm?classifyid=1&newsid=1";
        });
        $("#shizhengxinwen").click(function(){
            location.href = "wangzhan/News.htm?classifyid=1&newsid=2";
        });
        $("#zhongyaohuiyi").click(function(){
            location.href = "wangzhan/News.htm?classifyid=9";
        });
        $("#legislation").click(function(){
            location.href = "wangzhan/News.htm?classifyid=2";
        });
        $("#yianjianyi").click(function(){
            location.href = "wangzhan/News.htm?classifyid=16";
        });
        $("#townCongress").click(function(){
            location.href = "wangzhan/News.htm?classifyid=5";
        });
        $("#zuixingonggao").click(function(){
            location.href = "wangzhan/News.htm?classifyid=8";
        });
        $("#jiandugongzuo").click(function(){
            location.href = "wangzhan/News.htm?classifyid=6";
        });
        $("#daibiaogongzuo").click(function(){
            location.href = "wangzhan/News.htm?classifyid=7";
        });
        $("#huiyijueding").click(function(){
            location.href = "wangzhan/News.htm?classifyid=9";
        });
        $("#baogao").click(function(){
            location.href = "wangzhan/News.htm?classifyid=14&publiclassifyid=1";
        });
        $("#yusuangongkai").click(function(){
            location.href = "wangzhan/News.htm?classifyid=14&publiclassifyid=2";
        });
        $("#yusuantiaozheng").click(function(){
            location.href = "wangzhan/News.htm?classifyid=14&publiclassifyid=3";
        });
        $("#shichadiaoyan").click(function(){
            location.href = "wangzhan/News.htm?classifyid=14&publiclassifyid=4";
        });
        $("#newsTongzhi").parent().click(function(){
            location.href = "wangzhan/News.htm?classifyid=8";
        });
        
        $("#election").click(function(){
            location.href = "wangzhan/News.htm?classifyid=10";
        });
        
        $("#daibiaogongzuo1").click(function(){
            location.href = "wangzhan/News.htm?classifyid=7";
        });
        $("#diaochayanjiu").click(function(){
            location.href = "wangzhan/News.htm?classifyid=15";
        });

        $("#firstPage").click(function(){
            location.href = "wangzhan/index2.htm";
        });
        // $("#rendagaikuang").click(function(){
        //     location.href = "rendajianjie.htm";
        // });
        $("#rendayaowen2").click(function(){
            location.href = "wangzhan/NewsTop.htm?classifyid=1&newsid=1";
        });
        // $("#shizhengxinwen").click(function(){
        //     location.href = "News.htm?classifyid=17";
        // });
        $("#huiyibaodao").click(function(){
            location.href = "wangzhan/huiyibaodao.htm";
        });
        $("#zhuantijijin").click(function(){
            location.href = "wangzhan/zhuantijijin.htm";
        });
        $("#jiguanjianshe").click(function(){
            location.href = "wangzhan/News.htm?classifyid=11";
        });

         //首页二维码
        $('.right-nav li').hover(function () {
            $(this).find('.show-ewm').animate({ 'left': '-140px', 'opacity': '1' }).show();
        }, function () {
            $(this).find('.show-ewm').animate({ 'left': '-50px', 'opacity': '0' }).hide();
        });

        $(document).keydown(function(event){
            if(event.keyCode == 13){ 
                var searchInput = $("#searchInput").val();
                location.href = "wangzhan/searchResult.htm?searchInput=" + encodeURIComponent(searchInput);
            }
        });

        $("#searchBtn").click(function(){
            var searchInput = $("#searchInput").val();
            location.href = "wangzhan/searchResult.htm?searchInput=" + encodeURIComponent(searchInput);
        })

})

function clickImg(rssid) {
    location.href = "wangzhan/Pro_show.htm?id=" + rssid + "";
}

function clickLi(rssid) {
    location.href = "wangzhan/Slider_show.htm?id=" + rssid + "";
}

function newsShow(rssid) {
    location.href = "wangzhan/News_show.htm?id=" + rssid + "";
}

function enterPage(rssid) {
    location.href = "wangzhan/zhuren_show.htm?id=" + rssid + "";
}

// 通过控制left ，来显示不同的幻灯片
function showImg(spanTitle, index){
        $("#sliderSpan").html(spanTitle);
        var adWidth = $("#sliderDiv").width();
        // $(".slider").stop(true,false).animate({left : -adWidth*index},1000);
        // $(".num li").removeClass("on")
        //     .eq(index).addClass("on");
        $(".v_content_list").animate({left : -adWidth*index},1000);
        $(".titleul li").hide().eq(index).show();
        $(".num li").removeClass("on")
            .eq(index).addClass("on");
}
