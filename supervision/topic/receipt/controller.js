
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/supervision/zhifajiancha/file/quicksearch.jsp?typeid="+typeid, '快速查询', {width: 500, height: 200});
}
﻿transadapter["butview"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条查看")
        return false;
    }
    popuplayer.display("/supervision/topic/receipt/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
