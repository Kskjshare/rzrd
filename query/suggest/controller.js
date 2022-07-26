transadapter["append"] = function (t)
{
    popuplayer.display("/suggest/edit.jsp?TB_iframe=true", '增加', {width: 830, height: 550});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/suggest/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 550});
}
﻿transadapter["butview"] = function (t)
{
    popuplayer.display("/suggest/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}

transadapter["delete"] = function (t)
{
    popuplayer.display("/suggest/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["butimportance"] = function (t)
{
    popuplayer.display("/suggest/butimportance.jsp?id=" + transadapter.id + "&TB_iframe=true", '重点建议设置', {width: 830, height: 290});
}
transadapter["butexcellent"] = function (t)
{
    popuplayer.display("/suggest/butexcellent.jsp?id=" + transadapter.id + "&TB_iframe=true", '优秀建议设置', {width: 830, height: 290});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/suggest/quicksearch.jsp", '快速查询', {width: 500, height: 400});
}
transadapter["supersearch"] = function (t)
{
    popuplayer.display("/suggest/supersearch.jsp", '高级查询', {width: 500, height: 400});
}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/suggest/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '审查', {width: 830, height: 600});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" + transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
function ck_dbAbnlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/suggest/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}