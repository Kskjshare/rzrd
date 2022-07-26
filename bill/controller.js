transadapter["append"] = function (t)
{
    popuplayer.display("/suggest/edit_1.jsp?TB_iframe=true", '增加', {width: 830, height: 570});
}
﻿transadapter["see"] = function (t)
{
    popuplayer.display("/suggest/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 570});
}
﻿transadapter["edit"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条编辑")
        return false;
    }
    popuplayer.display("/suggest/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 570});
}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/bill/quicksearch.jsp" + url, '快速查询', {width: 500, height: 400});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/bill/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["subedit"] = function (t)
{
    popuplayer.display("/bill/subedit.jsp?id=" + transadapter.id + "&TB_iframe=true", '提交', {width: 300, height: 80});
}
function ck_dbabdlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}