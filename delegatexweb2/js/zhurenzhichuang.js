$(function () {
     RssApi.Table.Details("reldirector").condition({ "worktitle": 1 }).getJson(function (data) {
     	console.log(data.ico);
     	$("#zhurenImg").attr("src", "http://117.158.113.36:80/upfile/" + data.ico);
     	$("#zhurenName").text(data.nickname);
     	$("#zhurenJob").text(data.job);
     	$("#zhurenCareer").text(data.branch);
     });

     RssApi.Table.List("reldirector").condition({ "worktitle": 2 }).keyvalue({ "pagesize": 6 }).getJson(function (data) {
     	 data=  data.sort(function(a, b) { return a.id > b.id ? 1 : -1;} );
     	 var liStr = "";
         for (var i = 0; i < data.length; i++) {
         	liStr = liStr + "<li>";
         	liStr = liStr + "<a onclick='enterPage("+data[i].id+")'>";
         	liStr = liStr + "<div class='leader-pic'>";
         	liStr = liStr + "<img src='http://117.158.113.36:80/upfile/"+data[i].ico+"'  />";
         	liStr = liStr + "</div>";
         	liStr = liStr + "<div class='linfo'><i class='name'>"+data[i].nickname+"</i>"+data[i].job+"</div>"
         	liStr = liStr + "</a>";
         	liStr = liStr + "</li>";
         }
         $(".leader-group").append(liStr);
     });

     RssApi.Table.List("reldirector").condition({ "worktitle": 3 }).keyvalue({ "pagesize": 6 }).getJson(function (data) {
        data=  data.sort(function(a, b) { return a.id > b.id ? 1 : -1;} );
     	 var liStr = "";
         for (var i = 0; i < data.length; i++) {
            liStr = liStr + "<li>";
            liStr = liStr + "<a onclick='enterPage("+data[i].id+")'>";
            liStr = liStr + "<div class='leader-pic'>";
            liStr = liStr + "<img src='http://117.158.113.36:80/upfile/"+data[i].ico+"'  />";
            liStr = liStr + "</div>";
            liStr = liStr + "<div class='linfo'><i class='name'>"+data[i].nickname+"</i>"+data[i].job+"</div>"
            liStr = liStr + "</a>";
            liStr = liStr + "</li>";
         }
         $(".leader-group").append(liStr);
    })

    //  RssApi.Table.List("reldirector").condition({ "worktitle": 4 }).keyvalue({ "pagesize": 6 }).getJson(function (data) {
    //     data=  data.sort(function(a, b) { return a.id > b.id ? 1 : -1;} );
    //  	 var liStr = "";
    //      for (var i = 0; i < data.length; i++) {
    //      	liStr = liStr + "<li>";
    //      	liStr = liStr + "<a onclick='enterPage("+data[i].id+")'>";
    //      	liStr = liStr + "<div class='leader-pic'>";
    //      	liStr = liStr + "<img src='http://117.158.113.36:80/upfile/"+data[i].ico+"'  />";
    //      	liStr = liStr + "</div>";
    //      	liStr = liStr + "<div class='linfo'><i class='name'>"+data[i].nickname+"</i>"+data[i].job+"</div>"
    //      	liStr = liStr + "</a>";
    //      	liStr = liStr + "</li>";
    //      }
    //      $(".leader-group").append(liStr);
    // })

     $("#zhurenLi").click(function(){
     	location.href = "zhuren_show.htm?id=1";
     })

     $("#rendayaowen").click(function(){
            location.href = "News.htm?classifyid=1&newsid=1";
        });
        $("#shizhengxinwen").click(function(){
            location.href = "News.htm?classifyid=1&newsid=2";
        });
        $("#zhongyaohuiyi").click(function(){
            location.href = "News.htm?classifyid=9";
        });
        $("#legislation").click(function(){
            location.href = "News.htm?classifyid=2";
        });
        $("#yianjianyi").click(function(){
            location.href = "News.htm?classifyid=16";
        });
        $("#townCongress").click(function(){
            location.href = "News.htm?classifyid=5";
        });
        $("#zuixingonggao").click(function(){
            location.href = "News.htm?classifyid=8";
        });
        $("#jiandugongzuo").click(function(){
            location.href = "News.htm?classifyid=6";
        });
        $("#daibiaogongzuo").click(function(){
            location.href = "News.htm?classifyid=7";
        });
        $("#huiyijueding").click(function(){
            location.href = "News.htm?classifyid=9";
        });
        $("#baogao").click(function(){
            location.href = "News.htm?classifyid=14&publiclassifyid=1";
        });
        $("#yusuangongkai").click(function(){
            location.href = "News.htm?classifyid=14&publiclassifyid=2";
        });
        $("#yusuantiaozheng").click(function(){
            location.href = "News.htm?classifyid=14&publiclassifyid=3";
        });
        $("#shichadiaoyan").click(function(){
            location.href = "News.htm?classifyid=14&publiclassifyid=4";
        });
        $("#newsTongzhi").parent().click(function(){
            location.href = "News.htm?classifyid=8";
        });
        
        $("#election").click(function(){
            location.href = "News.htm?classifyid=10";
        });
        
        $("#daibiaogongzuo1").click(function(){
            location.href = "News.htm?classifyid=7";
        });
        $("#diaochayanjiu").click(function(){
            location.href = "News.htm?classifyid=15";
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
        // $("#shizhengxinwen").click(function(){
        //     location.href = "News.htm?classifyid=17";
        // });
        $("#huiyibaodao").click(function(){
            location.href = "huiyibaodao.htm";
        });
        $("#zhuantijijin").click(function(){
            location.href = "zhuantijijin.htm";
        });
        $("#jiguanjianshe").click(function(){
            location.href = "News.htm?classifyid=11";
        });

        $("#nav li:has(ul)").mouseover(function(){
            $(this).children("ul").stop(true,true).slideDown(400);
	    });
	    $("#nav li:has(ul)").mouseleave(function(){
	            // $(this).stop(true,true).slideUp("fast");
	        $(this).children("ul").stop(true,true).slideUp('fast');
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
})

function enterPage(rssid) {
    location.href = "zhuren_show.htm?id=" + rssid + "";
}