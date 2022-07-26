transadapter["append"] = function (t)
{
    popuplayer.display("/suggest/edit_1.jsp?TB_iframe=true", '新增议案建议', {width: 830, height: 550});
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
    popuplayer.display("/examine/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 550});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/examine/delete.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["butreturn"] = function (t)
{
    popuplayer.display("/examine/return.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '撤销置回', {width: 550, height: 150});
}

transadapter["quicksearch"] = function (t)
{
    var lwstate = $("[name='lwstate']").val();
    var iscs = $("[name='iscs']").val();
    var examination = $("[name='examination']").val();
    var isxzsc = $("[name='isxzsc']").val();
    var isdbtshenhe = $("[name='isdbtshenhe']").val();
    popuplayer.display("/examine/quicksearch.jsp?lwstate=" + lwstate + "&iscs=" + iscs + "&examination=" + examination + "&isxzsc=" + isxzsc + "&isdbtshenhe=" + isdbtshenhe + "&TB_iframe=true", '快速查询', {width: 550, height: 250});
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
        alert("每次只能选择一条")
        return false;
    }
    popuplayer.display("/examine/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '审查', {width: 830, height: 630});
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
        alert("每次只能选择一条")
        return false;
    }
    popuplayer.display("/examine/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
function ck_dbaddlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/examine/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}