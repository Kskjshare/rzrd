transadapter["append"] = function (t)
{
    popuplayer.display("/bill/classify/edit.jsp?TB_iframe=true", '增加', {width: 700, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/bill/classify/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 700, height: 500});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/bill/classify/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
﻿transadapter["view"] = function (t)
{
    popuplayer.display("/bill/classify/view.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 300, height: 300});
}
﻿transadapter["json"] = function (t)
{
    popuplayer.display("/bill/classify/json.jsp?id=" + transadapter.id + "&TB_iframe=true", '生成JSON', {width: 300, height: 80});
}