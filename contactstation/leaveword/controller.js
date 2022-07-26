transadapter["edit"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条交接")
        return false;
    }
    popuplayer.display("/contactstation/leaveword/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '交接', {width: 300, height: 150});
}
transadapter["editt"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条交接")
        return false;
    }
    popuplayer.display("/contactstation/leaveword/editt.jsp?id=" + transadapter.id + "&TB_iframe=true", '交接', {width: 300, height: 150});
}
transadapter["edittt"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条交接")
        return false;
    }
    popuplayer.display("/contactstation/leaveword/edittt.jsp?id=" + transadapter.id + "&TB_iframe=true", '交接', {width: 300, height: 350});
}
transadapter["return"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条不予接受")
        return false;
    }
    popuplayer.display("/contactstation/leaveword/return.jsp?id=" + transadapter.id + "&TB_iframe=true", '不予接受', {width: 300, height: 150});
}
transadapter["returnn"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条")
        return false;
    }
    popuplayer.display("/contactstation/leaveword/returnn.jsp?id=" + transadapter.id + "&TB_iframe=true", '驳回代表', {width: 300, height: 150});
}
transadapter["returnnn"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条不予接受")
        return false;
    }
    popuplayer.display("/contactstation/leaveword/returnnn.jsp?id=" + transadapter.id + "&TB_iframe=true", '不予接受', {width: 300, height: 150});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/contactstation/leaveword/quicksearch.jsp", '查询', {width: 450, height: 150});
}
transadapter["quicksearchh"] = function (t)
{
    popuplayer.display("/contactstation/leaveword/quicksearchh.jsp", '查询', {width: 450, height: 150});
}
transadapter["quicksearchhh"] = function (t)
{
    popuplayer.display("/contactstation/leaveword/quicksearchhh.jsp", '查询', {width: 450, height: 150});
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
    popuplayer.display("/contactstation/leaveword/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 1200, height: 240});
}
function ck_dbfgflclick() {

    $('tbody tr').dblclick(function () {
        var tid = [], myid = [];
        mid = "";
        $("[name='id']").each(function () {
            if ($(this).is(":checked")) {
                tid.push($(this).attr("value"));
                myid.push($(this).parent().next().next().next().next().next().next().text());
            }
        });
        mid = myid.join("','");
        if (tid.length > 1) {
            alert("每次只能选择一条查看")
            return false;
        }
        popuplayer.display("/contactstation/leaveword/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 1200, height: 200});
//            popuplayer.display("/company/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}