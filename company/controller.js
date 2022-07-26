transadapter["append"] = function (t)
{
    popuplayer.display("/company/edit.jsp?TB_iframe=true", '新增办理单位', {width: 830, height: 380});
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
    popuplayer.display("/company/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 380});
}
transadapter["delete"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().next().next().next().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    popuplayer.display("/company/delete.jsp?relationid=" + rid + "&account=" + account2 + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/company/quicksearch.jsp", '快速查询', {width: 450, height: 350});
}
function ck_dblclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/company/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 310});
    })

}
transadapter["butview"] = function (t)
{
    popuplayer.display("/company/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 310});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
transadapter["apd"] = function (t)
{
    popuplayer.display("/company/apd.jsp", '导入', {width: 550, height: 200});
}
transadapter["export"] = function (t)
{
    var tid = [], relationid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    relationid = tid.join(",")
    location.href = "companylist.jsp?relationid=" + relationid;
}
//transadapter["join"] = function (t)
//{
//    popuplayer.display("/company/companyuser/edit.jsp?parent=" + transadapter.id + "&TB_iframe=true", '新增工作人员', {width: 830, height:550});
//}