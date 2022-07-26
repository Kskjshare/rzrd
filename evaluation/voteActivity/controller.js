transadapter["edit"] = function (t)
{
    popuplayer.display("/evaluation/voteActivity/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 500});
}

﻿transadapter["append"] = function (t)
{
    popuplayer.display("/evaluation/voteActivity/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '新增', {width: 830, height: 500});
}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/evaluation/evaluation/quicksearch.jsp"+url, '快速查询', {width: 450, height:150});
}

transadapter["company"] = function (t)
{
   location.href="/evaluation/evaluation/list.jsp";
}
