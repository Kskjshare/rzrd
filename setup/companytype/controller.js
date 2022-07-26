transadapter["append"] = function (t)
{
    popuplayer.display("/setup/companytype/edit.jsp?TB_iframe=true", '新增', {width: 400, height: 200});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/setup/companytype/edit.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 200});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/setup/companytype/delete.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/setup/companytype/quicksearch.jsp", '快速查询', {width: 550, height:200});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/setup/companytype/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height:80});
}
