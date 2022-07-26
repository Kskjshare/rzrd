transadapter["see"] = function (t)
{
    popuplayer.display("/evaluation/mysuggest/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 500});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/evaluation/mysuggest/score.jsp?id=" +transadapter.id + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/evaluation/mysuggest/quicksearch.jsp"+url, '快速查询', {width: 450, height:150});
}

transadapter["mysuggest"] = function (t)
{
   location.href="/evaluation/satisfaction/list.jsp";
}
transadapter["company"] = function (t)
{
   location.href="/evaluation/evaluation/list.jsp";
   }