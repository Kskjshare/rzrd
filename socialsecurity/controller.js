transadapter["append"] = function (t)
{
    popuplayer.display("/socialsecurity/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 400, height: 200});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/socialsecurity/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 200});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/socialsecurity/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}