transadapter["append"] = function (t)
{
    popuplayer.display("/staff/power/group/edit.jsp?TB_iframe=true", '增加', {width: 400, height:200});
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
        alert("每次只能选择一条编辑");
        return false;
    }
    popuplayer.display("/staff/power/group/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 200});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/staff/power/group/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
﻿transadapter["power"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条权限设置");
        return false;
    } 
    popuplayer.display("/staff/power/group/power.jsp?id=" + transadapter.id + "&TB_iframe=true", '权限设置', {width: 400, height: 500});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/staff/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height:80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/staff/power/group/quicksearch.jsp", '查询', {width: 450, height:100});
}