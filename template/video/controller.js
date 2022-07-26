transadapter["append"] = function (t)
{
    popuplayer.display("/template/video/edit.jsp?relationid=" + Url["relationid"] + "&TB_iframe=true", '增加视频', {width: 750, height: 500});
}
transadapter["edit"] = function (t)
{
    popuplayer.display("/template/video/edit.jsp?relationid=" + Url["relationid"] + "&id=" + transadapter.id + "&TB_iframe=true", '编辑视频', {width: 750, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/template/video/delete.jsp?relationid=" + Url["relationid"] + "&id=" + transadapter.id + "&TB_iframe=true", '删除视频', {width: 750, height: 500});
}