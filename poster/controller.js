transadapter["append"] = function (t)
{
    popuplayer.display("/poster/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 830, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/poster/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/poster/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}