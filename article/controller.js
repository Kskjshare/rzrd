﻿transadapter["append"] = function (t)
{
    popuplayer.display("/article/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '增加', {width: 830, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/article/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}
transadapter["ico"] = function (t)
{
    popuplayer.display("/article/ico.jsp?id=" +transadapter.id + "&TB_iframe=true", '设置标题图', {width: 200, height: 210});
}
transadapter["classify"] = function (t)
{
    popuplayer.display("/article/classify.jsp?id=" +transadapter.id + "&TB_iframe=true", '设置分类', {width: 300, height: 500});
}
transadapter["slide"] = function (t)
{
    popuplayer.display("/article/slide.jsp?id=" +transadapter.id + "&TB_iframe=true", '管理展示图', {width: 730, height: 400});
}
transadapter["media"] = function (t)
{
    popuplayer.display("/article/media.jsp?id=" +transadapter.id + "&TB_iframe=true", '单一媒体', {width: 730, height: 280});
}
transadapter["video"] = function (t)
{
    popuplayer.display("/article/video/list.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '多视频管理', {width: 750, height: 500});
}
transadapter["sell"] = function (t)
{
    popuplayer.display("/article/sell.jsp?id=" +transadapter.id + "&TB_iframe=true", '设置价格', {width: 300, height: 200});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/article/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["release"] = function (t)
{
    popuplayer.display("/article/release.jsp?id=" +transadapter.id + "&TB_iframe=true", '发布', {width: 300, height: 80});
}
transadapter["hot"] = function (t)
{
    popuplayer.display("/article/hot.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '增加到热门', {width: 300, height: 80});
}
transadapter["top"] = function (t)
{
    popuplayer.display("/article/top.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '增加到置顶', {width: 300, height: 80});
}
transadapter["audit"] = function (t)
{
    popuplayer.display("/article/audit.jsp?id=" +transadapter.id + "&TB_iframe=true", '审核', {width: 300, height: 170});
}