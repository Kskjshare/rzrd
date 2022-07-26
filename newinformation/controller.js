transadapter["append"] = function (t)
{
    popuplayer.display("/newinformation/edit.jsp?TB_iframe=true", '新增最新资讯', {width: 790, height: 580});
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
    popuplayer.display("/newinformation/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 580});
}
function ck_dbcclclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/newinformation/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
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
    popuplayer.display("/newinformation/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/newinformation/quicksearch.jsp", '查询', {width: 450, height: 150});
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
    popuplayer.display("/newinformation/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height: 400});
}
﻿transadapter["butviewstate"] = function (t)
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
    popuplayer.display("/newinformation/readstate.jsp?realid=" + transadapter.id + "&TB_iframe=true", '已读人员列表', {width: 500, height: 400});
}

transadapter["json"] = function (t)
{
    popuplayer.display("/contactstation/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height: 80});
}

