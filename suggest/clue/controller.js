transadapter["append"] = function (t)
{
    popuplayer.display("/suggest/clue/edit.jsp?TB_iframe=true", '新增建议线索', {width: 790, height: 490});
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
    popuplayer.display("/suggest/clue/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 490});
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
    popuplayer.display("/suggest/clue/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/suggest/clue/quicksearch.jsp", '查询', {width: 450, height: 250});
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
    popuplayer.display("/suggest/clue/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height: 400});
}
function ck_dbAbFlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/clue/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}