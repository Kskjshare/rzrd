transadapter["append"] = function (t)
{
    popuplayer.display("/feedback/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 300, height: 400});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/feedback/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 300, height: 400});
}