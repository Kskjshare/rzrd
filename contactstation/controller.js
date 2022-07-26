transadapter["append"] = function (t)
{
    popuplayer.display("/contactstation/edit.jsp?TB_iframe=true", '新增网上联络站', {width: 680, height: 270});
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
    popuplayer.display("/contactstation/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 680, height: 270});
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
    popuplayer.display("/contactstation/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
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
    popuplayer.display("/contactstation/demonstration.jsp?id=" + rid + "&TB_iframe=true", '设为规范化联络站', {width: 300, height: 80});
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
    popuplayer.display("/contactstation/demonstration_1.jsp?id=" + rid + "&TB_iframe=true", '设为明星联络站', {width: 300, height: 80});
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
    popuplayer.display("/contactstation/demonstration_2.jsp?id=" + rid + "&TB_iframe=true", '设为示范联络站', {width: 300, height: 80});
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
    popuplayer.display("/contactstation/demonstration_3.jsp?id=" + rid + "&TB_iframe=true", '恢复', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/contactstation/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{
    var tid = [], myid = [];
    mid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            myid.push($(this).parent().next().next().next().next().next().next().text());
        }
    });
    mid = tid.join(",");
    if (tid.length > 1) {
        alert("每次只能选择一条预览")
        return false;
    }
    popuplayer.display("/delegatexweb/infopage/delegationinfo.jsp?myid=" + mid + "&id=" + transadapter.id + "&TB_iframe=true", '预览', {width: 1200, height: 400});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/contactstation/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height: 80});
}

//function ck_dbAbRlclick() {
//
//    $('tbody tr').dblclick(function () {
//        var tid = [], myid = [];
//        mid = "", tidd = "";
//        tid.push($(this).attr("idd"));
//        myid.push($(this).attr("myid"));
//        mid = myid.join("','");
//        tidd = tid.join("','");
//        if (tid.length > 1) {
//            alert("每次只能选择一条预览")
//            return false;
//        }
//        popuplayer.display("/delegatexweb/infopage/delegationinfo.jsp?myid=" + mid + "&id=" + tidd + "&TB_iframe=true", '预览', {width: 1200, height: 400});
//    })
//}