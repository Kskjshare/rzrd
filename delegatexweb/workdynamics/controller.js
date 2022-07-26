transadapter["append"] = function (t)
{
    popuplayer.display("/delegatexweb/workdynamics/edit.jsp?TB_iframe=true", '新增记录', {width: 780, height: 600});
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
    popuplayer.display("/delegatexweb/workdynamics/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 780, height: 640});
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
    popuplayer.display("/delegatexweb/workdynamics/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/delegatexweb/workdynamics/quicksearch.jsp", '查询', {width: 450, height: 250});
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
    popuplayer.display("/delegatexweb/workdynamics/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height: 350});
}
function ck_dbAbTlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/delegatexweb/workdynamics/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 350});
    })

}