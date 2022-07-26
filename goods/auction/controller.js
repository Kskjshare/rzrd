transadapter["append"] = function (t)
{
    popuplayer.display("/goods/auction/edit.jsp?TB_iframe=true", '增加', {width: 830, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/goods/auction/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/goods/auction/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}