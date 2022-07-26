transadapter["append"] = function (t)
{
    popuplayer.display("/advert/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 500, height: 550});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/advert/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 500, height: 550});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/advert/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["release"] = function (t)
{
    popuplayer.display("/advert/release.jsp?id=" + transadapter.id + "&TB_iframe=true", '发布', {width: 300, height: 80});
}
transadapter["stop"] = function (t)
{
    popuplayer.display("/advert/stop.jsp?id=" + transadapter.id + "&TB_iframe=true", '停止', {width: 300, height: 80});
}