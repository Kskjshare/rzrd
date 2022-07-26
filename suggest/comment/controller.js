transadapter["append"] = function (t)
{
    popuplayer.display("/suggest/comment/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '新增点评', {width: 790, height: 390});
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
    popuplayer.display("/suggest/comment/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 390});
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
    popuplayer.display("/suggest/comment/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/suggest/comment/quicksearch.jsp", '查询', {width: 450, height: 250});
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
    popuplayer.display("/suggest/comment/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 600, height: 600});
}

function ck_dbAbDlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/comment/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}