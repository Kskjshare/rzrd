transadapter["append"] = function (t)
{
    popuplayer.display("/contactstation/substation/edit.jsp?TB_iframe=true", '新增网上联络站', {width: 460, height: 360});
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
    popuplayer.display("/contactstation/substation/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 700, height: 500});
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
    popuplayer.display("/contactstation/substation/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}


transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/contactstation/substation/quicksearch.jsp", '查询', {width: 450, height: 150});
}


transadapter["demonstration"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/contactstation/substation/demonstration.jsp?id=" + rid + "&TB_iframe=true", '设为规范化联络站', {width: 380, height: 80});
}
transadapter["demonstration1"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/contactstation/substation/demonstration_1.jsp?id=" + rid + "&TB_iframe=true", '设为明星联络站', {width: 380, height: 80});
}
transadapter["demonstration2"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/contactstation/substation/demonstration_2.jsp?id=" + rid + "&TB_iframe=true", '设为示范联络站', {width: 380, height: 80});
}
transadapter["demonstration3"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/contactstation/substation/demonstration_3.jsp?id=" + rid + "&TB_iframe=true", '恢复', {width: 300, height: 80});
}
