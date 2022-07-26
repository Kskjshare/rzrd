$(function () {

    RssApi.Table.List("releasum").condition({"classifyid":13,"state":1}).keyvalue({ "pagesize": 100 }).getJson(function (data) {
        var obj = {};
        arrays = data.reduce(function (item, next) {
            obj[next.organize] ? '' : obj[next.organize] = true && item.push(next);
            return item;

        }, []);
        $(".macont").mapview(arrays, {
            "shijian": function (val) {
                return new Date(val * 1000).toString("yyyy-MM-dd");
            }
        });

        $(".macont table").click(function () {
            console.log($(this).find("tr").attr("rssid"))
            var rssid = $(this).find("tr").attr("rssid");
            location.href = "baokan.htm?rssid=" + rssid + "";

        })
        console.log(arrays)
    })



    // ��ҳ
    var pageParam = {
        next: '.next',//��һҳ��ťjqѡ����
        prev: '.prev',//��һҳ��ťjqѡ����
        // nextMore: '.nextMore',//��nҳ��ťjqѡ����
        // prevMore: '.prevMore',//��nҳ��ťjqѡ����
        totalEl: '.total',//��ҳ��jqԪ��  Ԫ���ڰ��� eq:����nҳ��
        curPageEl: '.cur_page',//��ǰҳ��jqԪ��  Ԫ���ڰ��� eq:����ǰ��nҳ��
        perPageCount: 15//ÿҳ��ʾ����
        // morePage: 5//�ϡ���nҳ��ת��
    }
    //demoΪ�����б�������
    $(".macont").page(pageParam);
})