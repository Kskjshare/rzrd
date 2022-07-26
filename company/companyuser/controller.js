transadapter["append"] = function (t)
{
    popuplayer.display("/company/companyuser/edit.jsp?TB_iframe=true", '新增工作人员', {width: 830, height: 500});
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
    popuplayer.display("/company/companyuser/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().next().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    popuplayer.display("/company/companyuser/delete.jsp?relationid=" + rid + "&account=" +account2 + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/company/companyuser/quicksearch.jsp", '查询', {width: 400, height: 250});
}
function ck_rydblclick() {

    $('tbody tr').dblclick(function () {
        popuplayer.display("/company/companyuser/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 450});
    })

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
    popuplayer.display("/company/companyuser/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 450});
}
transadapter["apd"] = function (t)
{
    popuplayer.display("/company/companyuser/apd.jsp", '导入', {width: 550, height: 200});
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
    popuplayer.display("/company/companyuser/export.jsp?relationid=" + rid + "&TB_iframe=true", '请选择导出字段', {width: 300, height: 450});
}
