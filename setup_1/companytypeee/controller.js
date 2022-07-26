transadapter["append"] = function (t)
{
    popuplayer.display("/setup_1/companytypeee/edit.jsp?TB_iframe=true", '新增', {width: 400, height: 200});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/setup_1/companytypeee/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 200});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/setup_1/companytypeee/delete.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/setup_1/companytypeee/quicksearch.jsp", '快速查询', {width: 550, height:200});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/setup_1/companytypeee/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height:80});
}
