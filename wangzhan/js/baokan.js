$(function () {

    var rssid = window.location.href.split("=")[1];
    console.log(rssid)
    RssApi.Table.Details("releasum").condition({ "id": rssid }).getJson(function (data) {
        console.log(rssid)
        console.log(data.organize)
        $(".n01").html("当前位置 >> <a href='index.htm'>网站首页</a> >> " + data.organize);
        $(".n02").html(data.organize);
        RssApi.Table.List("releasum").condition({ "organize": data.organize }).getJson(function (data) {
            console.log(data)
            $(".macont").mapview(data, {
                "shijian": function (val) {
                    return new Date(val * 1000).toString("yyyy-MM-dd");
                }
            })
            $(".macont table").click(function () {
                console.log($(this).find("tr").attr("rssid"))
                var rssid = $(this).find("tr").attr("rssid");
                location.href = "News_show.htm?id=" + rssid + "";

            })
        })
    })


       // 分页
    var pageParam = {
        next: '.next',//下一页按钮jq选择器
        prev: '.prev',//上一页按钮jq选择器
        // nextMore: '.nextMore',//下n页按钮jq选择器
        // prevMore: '.prevMore',//上n页按钮jq选择器
        totalEl: '.total',//总页数jq元素  元素内包含 eq:“共n页”
        curPageEl: '.cur_page',//当前页数jq元素  元素内包含 eq:“当前第n页”
        perPageCount: 15//每页显示数量
        // morePage: 5//上、下n页跳转数
    }
    //demo为包裹列表的容器
    $(".macont").page(pageParam);

})