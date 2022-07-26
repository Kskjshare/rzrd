transadapter["append"] = function (t)
{
    popuplayer.display("/company/edit.jsp?TB_iframe=true", '新增承办单位', {width: 830, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/company/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/company/delete.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["release"] = function (t)
{
    popuplayer.display("/company/release.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '发布', {width: 300, height: 80});
}
transadapter["hot"] = function (t)
{
    popuplayer.display("/company/hot.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '增加到热门', {width: 300, height: 80});
}
transadapter["top"] = function (t)
{
    popuplayer.display("/company/top.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '增加到置顶', {width: 300, height: 80});
}
transadapter["audit"] = function (t)
{
    popuplayer.display("/company/audit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '审核', {width: 300, height: 170});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/company/quicksearch.jsp", '快速查询', {width: 550, height: 450});
}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/company/butreview.jsp", '审查', {width: 830, height: 400});
}
﻿transadapter["butview"] = function (t)
{
    popuplayer.display("/company/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
function ck_dbAbalclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/company/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}