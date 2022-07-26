transadapter["append"] = function (t)
{
    popuplayer.display("/delegate/edit.jsp?TB_iframe=true", '新增代表', {width: 830, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/delegate/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/delegate/delete.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["release"] = function (t)
{
    popuplayer.display("/delegate/release.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '发布', {width: 300, height: 80});
}
transadapter["hot"] = function (t)
{
    popuplayer.display("/delegate/hot.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '增加到热门', {width: 300, height: 80});
}
transadapter["top"] = function (t)
{
    popuplayer.display("/delegate/top.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '增加到置顶', {width: 300, height: 80});
}
transadapter["audit"] = function (t)
{
    popuplayer.display("/delegate/audit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '审核', {width: 300, height: 170});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/delegate/quicksearch.jsp", '查询', {width: 550, height: 300});
}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/delegate/butreview.jsp", '审查', {width: 830, height: 400});
}
﻿transadapter["butview"] = function (t)
{
    popuplayer.display("/delegate/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
function ck_dbAbBlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/delegate/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}