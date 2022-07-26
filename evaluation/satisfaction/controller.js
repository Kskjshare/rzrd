transadapter["see"] = function (t)
{
    popuplayer.display("/evaluation/evaluation/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 500});
}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/evaluation/evaluation/quicksearch.jsp"+url, '快速查询', {width: 450, height:150});
}
transadapter["mysuggest"] = function (t)
{
   location.href="/evaluation/mysuggest/list.jsp";
}
transadapter["company"] = function (t)
{
   location.href="/evaluation/evaluation/list.jsp";
}
