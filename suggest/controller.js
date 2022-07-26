transadapter["append"] = function (t)
{
    popuplayer.display("/suggest/edit.jsp?TB_iframe=true", '增加', {width: 910, height: 550});
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
    popuplayer.display("/suggest/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 910, height: 550});
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
function ck_dbdmlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

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
    popuplayer.display("/suggest/bardelete.jsp?id=" + rid + "&TB_iframe=true&lwstate=1", '删除', {width: 380, height: 120});
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
    popuplayer.display("/suggest/butimportance.jsp?id=" + transadapter.id + "&TB_iframe=true", '重点建议设置', {width: 830, height: 290});
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
    popuplayer.display("/suggest/butexcellent.jsp?id=" + transadapter.id + "&TB_iframe=true", '优秀建议设置', {width: 830, height: 290});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/suggest/quicksearch.jsp", '快速查询', {width: 840, height: 560});
}
transadapter["supersearch"] = function (t)
{
    popuplayer.display("/suggest/supersearch.jsp", '高级查询', {width: 500, height: 400});
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
    popuplayer.display("/examine/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '审查', {width: 830, height: 630});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
transadapter["print"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条打印")
        return false;
    }
    popuplayer.display("/suggest/print.jsp?id=" + transadapter.id + "&TB_iframe=true", '打印', {width: 830, height: 500});
}
//transadapter["print"] = function (t)
//{
//    var tid = [], relationid = "";
//    $("[name='id']").each(function () {
//        if ($(this).is(":checked")) {
//            tid.push($(this).attr("value"));
//        }
//    });
//    relationid = tid.join(",")
//    location.href = "companylist.jsp?relationid=" + relationid;
//}
transadapter["importancelist"] = function (t)
{
    var imptype = "2";
    if (t.text() == "罗列重点建议") {
        t.text("展示全部建议")
        var str = "/suggest/list_1.jsp?importance=" + imptype;
    } else {
        imptype = "";
        t.text("罗列重点议案")
        var str = "/suggest/list.jsp?importance=" + imptype;
    }
    var urla = encodeURI(str)
    parent.quicksearch(urla)
//    popuplayer.display("/suggest/butreports.jsp?id=" +transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
