﻿transadapter["append"] = function (t)
{
    popuplayer.display("/staff/meeting/edit.jsp?TB_iframe=true", '新增', {width: 500, height: 280});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/staff/meeting/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 500, height: 280});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/staff/meeting/delete.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/staff/meeting/quicksearch.jsp", '快速查询', {width: 550, height:200});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/staff/meeting/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height:80});
}