transadapter["append"] = function (t)
{

    popuplayer.display("/website/resodec/edit.jsp?&TB_iframe=true", '新增', {width: 1248 , height: 740 });
}
﻿transadapter["edit"] = function (t)
{
//    var tid = [], rid = "", account1 = [], account2 = "";
//    $("[name='id']").each(function () {
//        if ($(this).is(":checked")) {
//            tid.push($(this).attr("value"));
//            account1.push($(this).parent().next().next().next().text());
//        }
//    });
//    rid = tid.join(",");
//    popuplayer.display("/website/resodec/edit.jsp?id=" + rid + "&TB_iframe=true", '编辑', {width: 800, height: 550});

 
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条编辑");
        return false;
    }
    popuplayer.display("/website/resodec/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 1248 , height: 740 });
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
    popuplayer.display("/website/resodec/delete.jsp?relationid=" + rid + "&TB_iframe=true", '删除', {width: 360, height: 120});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/website/resodec/quicksearch.jsp", '快速查询', {width: 500, height: 200});
}
﻿transadapter["butview"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条查看");
        return false;
    }
    popuplayer.display("/website/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
﻿transadapter["toexamine"] = function (t)
{
//    var tid = [], rid = "", account1 = [], account2 = "";
//    $("[name='id']").each(function () {
//        if ($(this).is(":checked")) {
//            tid.push($(this).attr("value"));
//            account1.push($(this).parent().next().next().next().text());
//        }
//    });
//    rid = tid.join(",");
//    popuplayer.display("/website/toexamine.jsp?id=" + rid + "&TB_iframe=true", '审核', {width: 800, height: 550});
 var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条审核");
        return false;
    }
     popuplayer.display("/website/toexamine.jsp?id=" +  transadapter.id  + "&TB_iframe=true", '审核', {width: 800, height: 450});
}