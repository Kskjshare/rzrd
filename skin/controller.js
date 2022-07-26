transadapter["append"] = function (t)
{
    popuplayer.display("/skin/edit.jsp?TB_iframe=true", '增加', {width: 300, height: 280});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/skin/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 300, height: 280});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/skin/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

﻿transadapter["select"] = function (t)
{
    popuplayer.display("/skin/select.jsp?id=" + transadapter.id + "&TB_iframe=true", '使用', {width: 300, height: 80});
}