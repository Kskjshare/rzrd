transadapter["append"] = function (t)
{
    popuplayer.display("/version/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 730, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/version/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 730, height: 500});
}