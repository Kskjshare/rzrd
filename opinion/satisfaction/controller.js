transadapter["see"] = function (t)
{
    popuplayer.display("/opinion/evaluation/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 500});
}
//transadapter["delete"] = function (t)
//{
//    popuplayer.display("/opinion/evaluation/score.jsp?id=" +transadapter.id + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
//}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/opinion/evaluation/quicksearch.jsp"+url, '快速查询', {width: 450, height:150});
}
