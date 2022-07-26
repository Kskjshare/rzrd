transadapter["append"] = function (t)
{
    popuplayer.display("/activities/evaluation/edit.jsp?TB_iframe=true", '发起考核', {width: 800, height: 550});  
}
transadapter["scorequicksearch"] = function (t)
{   
    popuplayer.display("/activities/evaluation/scorequicksearch.jsp?batchid="+batchid, '查询', {width: 450, height:350});
}