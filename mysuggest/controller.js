﻿transadapter["append"] = function (t)
{
    popuplayer.display("/mysuggest/edit.jsp?TB_iframe=true", '增加', {width: 830, height: 550});
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
    popuplayer.display("/mysuggest/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 550});
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
    popuplayer.display("/suggest/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
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
    popuplayer.display("/mysuggest/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["butimportance"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条设置")
        return false;
    }
    popuplayer.display("/mysuggest/butimportance.jsp?id=" + transadapter.id + "&TB_iframe=true", '重点建议设置', {width: 830, height: 290});
}
transadapter["butexcellent"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条设")
        return false;
    }
    popuplayer.display("/mysuggest/butexcellent.jsp?id=" + transadapter.id + "&TB_iframe=true", '优秀建议设置', {width: 830, height: 290});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/mysuggest/quicksearch.jsp", '快速查询', {width: 500, height:100});
}
transadapter["supersearch"] = function (t)
{
    popuplayer.display("/mysuggest/supersearch.jsp", '高级查询', {width: 500, height: 400});
}
transadapter["butreview"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条审查")
        return false;
    }
    popuplayer.display("/mysuggest/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '审查', {width: 830, height: 600});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/mysuggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}

function ck_dbAbxlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}