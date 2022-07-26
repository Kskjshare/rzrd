transadapter["append"] = function (t)
{
    if ( typeid == 3 ){
         popuplayer.display("/supervision/finance/public.jsp?typeid="+typeid, '预算公开', {width: 830, height: 460});
    }
    else 
     popuplayer.display("/supervision/finance/edit.jsp?typeid="+typeid, '财经工委', {width: 830, height: 360});
 
}

transadapter["file"] = function (t)
{
    popuplayer.display("/supervision/finance/file.jsp?id=" + transadapter.id + "&TB_iframe=true", '提交', {width: 300, height: 80});
}
transadapter["delete"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "", rolelist1 = [], rolelist2 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().next().next().next().next().next().next().next().text());
            rolelist1.push($(this).parent().next().next().next().next().next().next().next().next().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    rolelist2 = rolelist1.join("','");
    popuplayer.display("/supervision/finance/delete.jsp?relationid=" + rid + "&account=" +account2 + "&rolelist=" +rolelist2 + "&typeid="+typeid+"&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["delete_1"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "", rolelist1 = [], rolelist2 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().next().next().next().next().next().next().next().text());
            rolelist1.push($(this).parent().next().next().next().next().next().next().next().next().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    rolelist2 = rolelist1.join("','");
    popuplayer.display("/supervision/finance/publicdelete.jsp?relationid=" + rid + "&account=" +account2 + "&rolelist=" +rolelist2 + "&typeid="+typeid+"&TB_iframe=true", '删除', {width: 300, height: 80});
}
function ck_dbAbTlclick() {

    $('tbody tr').dblclick(function () {
        popuplayer.display("/supervision/finance/detailview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
    })

}
function ck_ClIck() {

    $('tbody tr').dblclick(function () {
        popuplayer.display("/supervision/finance/publicbutview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看内容', {width: 830, height: 270});
    })

}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/supervision/finance/quicksearch.jsp?typeid="+typeid, '快速查询', {width: 500, height: 320});
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
        alert("每次只能选择一条查看")
        return false;
    }
    popuplayer.display("/supervision/finance/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
}
transadapter["publicquicksearch"] = function (t)
{
    popuplayer.display("/supervision/finance/publicquicksearch.jsp?typeid="+typeid, '快速查询', {width: 500, height: 80});
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
        alert("每次只能选择一条查看")
        return false;
    }
    popuplayer.display("/supervision/finance/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看内容', {width: 830, height: 560});
}