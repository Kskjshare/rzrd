transadapter["append"] = function (t)
{
    popuplayer.display("/module/edit.jsp?TB_iframe=true", '增加', {width: 350, height: 300});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/module/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '修改', {width: 300, height: 300});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/module/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
﻿transadapter["reset"] = function (t)
{
    popuplayer.display("/module/reset.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
﻿transadapter["core"] = function (t)
{
    popuplayer.display("/setup/webcore.jsp?TB_iframe=true", '安装核心模块', {width: 300, height: 80});
}