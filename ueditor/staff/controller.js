transadapter["edit"] = function (t)
{
    popuplayer.display("/staff/edit.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 500, height: 500});
}
﻿transadapter["append"] = function (t)
{
    popuplayer.display("/staff/append.jsp?TB_iframe=true", '增加', {width: 300, height: 300});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/staff/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["power"] = function (t)
{
    popuplayer.display("/staff/power.jsp?id=" + transadapter.id + "&TB_iframe=true", '权限设置', {width: 400, height: 500});
}
$("#selectall").click(function ()
{
    $("[name='myid']").prop("checked", this.checked);
});