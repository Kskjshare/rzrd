transadapter["see"] = function (t)
{
    popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 300});
}
//function ck_MdbBlclick() {
//
//    $('tbody tr').dblclick(function () {
//
//        popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
////            popuplayer.display("/evaluation/evaluation/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 500});
//    })
//
//}
//transadapter["delete"] = function (t)
//{
//    popuplayer.display("/opinion/evaluation/score.jsp?id=" +transadapter.id + "&TB_iframe=true", '测评打分', {width: 300, height: 80});
//}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/evaluation/evaluation/quicksearch.jsp" + url, '快速查询', {width: 450, height: 150});
}
transadapter["mysuggest"] = function (t)
{
    location.href = "/evaluation/mysuggest/list.jsp";
}
transadapter["company"] = function (t)
{
    location.href = "/evaluation/satisfaction/list.jsp";
}

﻿transadapter["append"] = function (t)
{
    popuplayer.display("/evaluation/evaluation/append.jsp?id=" + transadapter.id + "&TB_iframe=true", '评分', {width: 520, height: 180});
}
//﻿transadapter["append"] = function (t)
//{
//    popuplayer.display("/evaluation/evaluation/edit.jsp?TB_iframe=true", '"新增', {width: 790, height: 500});
//}
//﻿transadapter["edit"] = function (t)
//{
//    var tid=[]
//     $("[name='id']").each(function () {
//        if ($(this).is(":checked")) {
//          tid.push($(this).attr("value"));
//        }
//    });
//    if (tid.length>1) {
//        alert("每次只能选择一条编辑")   
//        return false;
//    }
//    popuplayer.display("/evaluation/evaluation/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 580});
//}
//transadapter["delete"] = function (t)
//{
//    var tid=[],rid="";
//     $("[name='id']").each(function () {
//        if ($(this).is(":checked")) {
//          tid.push($(this).attr("value"));
//        }
//    });
//    rid=tid.join(",");
//    popuplayer.display("/evaluation/evaluation/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
//}
//transadapter["apd"] = function (t)
//{
//    popuplayer.display("/evaluation/evaluation/apd.jsp", '导入', {width: 550, height: 200});
//}
