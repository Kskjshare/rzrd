transadapter["append"] = function (t)
{
    popuplayer.display("/opinion/append.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 830, height: 400});
}
﻿transadapter["append_1"] = function (t)
{
    popuplayer.display("/opinion/append_1.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 830, height: 400});
}
﻿transadapter["see"] = function (t)
{
    popuplayer.display("/opinion/query.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 840, height: 550});
}
function ck_dbcdlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}
﻿transadapter["edit"] = function (t)
{
    if ($("[rid]:checked").length != "1") {
        alert("每次只能选择一条");
        return false;
    }
    var opinionid = $("[rid]:checked").attr("rid");
    popuplayer.display("/opinion/edit.jsp?id=" + opinionid + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/opinion/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/opinion/quicksearch.jsp" + url, '快速查询', {width: 450, height: 80});
}