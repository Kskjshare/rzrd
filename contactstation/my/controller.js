transadapter["append"] = function (t)
{
    popuplayer.display("/contactstation/my/edit.jsp?TB_iframe=true", '发布', {width: 820, height: 620});
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
    popuplayer.display("/contactstation/my/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 820, height: 620});
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
    popuplayer.display("/contactstation/my/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/contactstation/my/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{

    var tid = [], contacttype = [], contacttype1 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            contacttype.push($(this).parent().next().next().next().next().text());
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条预览")
        return false;
    }
    contacttype1 = contacttype.join(",");
    popuplayer.display("/delegatexweb/infopage/listinfopage.jsp?ind=" + tid + "&contacttype=" + contacttype1 + "&TB_iframe=true", '预览', {width: 1200, height: 600});
}
function ck_dbylclick() {

    $('tbody tr').dblclick(function () {
        var tid = [], contacttype = []
        tid.push($(this).attr("idd"));
        contacttype.push($(this).attr("contacttype"));
        popuplayer.display("/delegatexweb/infopage/listinfopage.jsp?ind=" + tid + "&contacttype=" + contacttype + "&TB_iframe=true", '预览', {width: 1200, height: 400});
    });
}
