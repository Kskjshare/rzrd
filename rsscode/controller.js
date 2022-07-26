transadapter["append"] = function (t)
{
    popuplayer.display("/rsscode/edit.jsp?TB_iframe=true", '增加', {width: 500, height: 200});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/rsscode/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 500, height: 200});
}