transadapter["append"] = function (t)
{
    popuplayer.display("/logistics/driver/edit.jsp?TB_iframe=true", '增加司机', {width: 400, height: 500});
}﻿
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/logistics/driver/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑司机', {width: 400, height: 500});
}﻿
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/logistics/driver/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}