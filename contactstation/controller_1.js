//﻿transadapter["append"] = function (t)
//{
//    popuplayer.display("/activities/evaluation/edit.jsp?TB_iframe=true", '发起考核', {width: 800, height: 550});
//}
transadapter["scorequicksearch"] = function (t)
{
    
    popuplayer.display("/activities/evaluation/scorequicksearch.jsp?batchid="+batchid, '查询', {width: 450, height:350});
}

transadapter["delete"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/contactstation/del.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

﻿transadapter["append"] = function (t)
{
    popuplayer.display("/contactstation/append.jsp?TB_iframe=true", '新增入驻代表', {width: 600, height: 400});
}