
//权限
transadapter["append"] = function (t)
{
    popuplayer.display("/user/power/edit.jsp&TB_iframe=true", '增加权限', {width: 400, height: 500});
}
transadapter["update"] = function (t)
{
    popuplayer.display("/user/power/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑权限', {width: 400, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/user/power/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除权限', {width: 300, height: 80});
}
