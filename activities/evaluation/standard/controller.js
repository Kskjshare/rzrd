transadapter["append"] = function (t)
{
    popuplayer.display("/activities/evaluation/standard/edit.jsp?TB_iframe=true", '考核标准', {width: 1000, height: 550});
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
    popuplayer.display("/activities/evaluation/standard/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 1000, height: 550});
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
    popuplayer.display("/activities/evaluation/standard/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 800, height: 550});
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
    popuplayer.display("/activities/evaluation/standard/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 100});
}
