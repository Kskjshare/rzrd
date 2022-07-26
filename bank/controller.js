transadapter["append"] = function (t)
{
    popuplayer.display("/bank/edit.jsp?TB_iframe=true", '增加', {width: 500, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/bank/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 500, height: 500});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/bank/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}