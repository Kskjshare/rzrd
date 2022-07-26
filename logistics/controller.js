transadapter["append"] = function (t)
{
    popuplayer.display("/logistics/edit.jsp?TB_iframe=true", '增加物流', {width: 400, height: 500});
}﻿
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/logistics/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑物流', {width: 400, height: 500});
}﻿
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/logistics/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}