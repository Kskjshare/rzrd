﻿transadapter["append"] = function (t)
{
    popuplayer.display("/nationality/edit.jsp?TB_iframe=true", '增加', {width: 800, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/nationality/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 800, height: 500});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/nationality/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
﻿transadapter["json"] = function (t)
{
    popuplayer.display("/nationality/json.jsp?id=" + transadapter.id + "&TB_iframe=true", '创建JSON', {width: 300, height: 80});
}