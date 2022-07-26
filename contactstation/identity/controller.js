transadapter["append"] = function (t)
{
    popuplayer.display("/contactstation/identity/edit.jsp?TB_iframe=true", '新增', {width: 460, height: 160});
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
    popuplayer.display("/contactstation/identity/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 360, height: 160});
}
transadapter["delete"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/contactstation/identity/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}


transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/contactstation/identity/quicksearch.jsp", '查询', {width: 450, height: 150});
}
