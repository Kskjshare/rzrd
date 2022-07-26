transadapter["append"] = function (t)
{
//    var mission="",circleslist="";
//    if ($("[missionmyid].sel")) {
//      mission = $("[missionmyid].sel").attr("missionmyid");  
//    }
//    if ($("[circlesnum].sel")) {
//      circleslist = ","+$("[circlesnum].sel").attr("circlesnum")+",";
//    }
    popuplayer.display("/supervision/topic/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 550});
}
transadapter["edit"] = function (t)
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
    popuplayer.display("/supervision/topic/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["file"] = function (t)
{
    popuplayer.display("/supervision/topic/file.jsp?id=" + transadapter.id + "&TB_iframe=true", '提交', {width: 300, height: 80});
}
transadapter["delete"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "", rolelist1 = [], rolelist2 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().next().next().next().next().next().next().next().text());
            rolelist1.push($(this).parent().next().next().next().next().next().next().next().next().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    rolelist2 = rolelist1.join("','");
    popuplayer.display("/supervision/topic/delete.jsp?relationid=" + rid + "&account=" +account2 + "&rolelist=" +rolelist2 + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
function ck_ondblclick() {

    $('tbody tr').dblclick(function () {
        popuplayer.display("/supervision/topic/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_ifram.e=true", '查看', {width: 830, height: 560});
    })

}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/supervision/topic/quicksearch.jsp", '快速查询', {width: 500, height: 400});
}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/supervision/topic/butreview.jsp", '审查', {width: 830, height: 400});
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
    popuplayer.display("/delegate/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
transadapter["apd"] = function (t)
{
    popuplayer.display("/delegate/apd.jsp", '导入', {width: 750, height: 200});
}
transadapter["change"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/delegate/change.jsp?relationid=" + rid + "&TB_iframe=true", '换届', {width: 500, height: 150});
}
transadapter["export"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/delegate/export.jsp?relationid=" + rid + "&TB_iframe=true", '请选择导出字段', {width: 300, height: 450});
}
