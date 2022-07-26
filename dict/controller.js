transadapter["append"] = function (t)
{
    popuplayer.display("/dict/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 730, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/dict/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 730, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/dict/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["view"] = function (t)
{
    popuplayer.display("/dict/view.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 500, height: 500});
}