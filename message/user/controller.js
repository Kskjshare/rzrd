transadapter["append"] = function (t)
{
    popuplayer.display("/message/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 700, height: 400});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/message/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 700, height: 400});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/message/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}