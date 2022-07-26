
//权限
transadapter["append"] = function (t)
{
    popuplayer.display("/staff/power/edit.jsp&TB_iframe=true", '增加权限', {width: 850, height: 500});
}
transadapter["update"] = function (t)
{
    popuplayer.display("/staff/power/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑权限', {width: 850, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/staff/power/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除权限', {width: 300, height: 80});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/staff/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height:80});
}