transadapter["append"] = function (t)
{
    popuplayer.display("/examine/edit.jsp?TB_iframe=true", '新增议案建议', {width: 830, height: 550});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/examine/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 550});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/examine/delete.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["butreturn"] = function (t)
{
    popuplayer.display("/examine/return.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '撤销置回', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/examine/quicksearch.jsp", '快速查询', {width: 550, height:450});
}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/examine/butreview.jsp?id=" +transadapter.id + "&TB_iframe=true", '审查', {width: 830, height: 300});
}
﻿transadapter["butview"] = function (t)
{
    popuplayer.display("/examine/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" +transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}