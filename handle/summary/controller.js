transadapter["append"] = function (t)
{
    popuplayer.display("/handle/summary/edit.jsp?TB_iframe=true", '办理总结报告', {width: 830, height: 400});
}
transadapter["edit"] = function (t)
{
    popuplayer.display("/handle/summary/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 400});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/handle/summary/delete.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/handle/summary/quicksearch.jsp", '快速查询', {width: 450, height: 150});
}
transadapter["butview"] = function (t)
{
    popuplayer.display("/handle/summary/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 400});
}
function ck_dbAbzlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/company/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}