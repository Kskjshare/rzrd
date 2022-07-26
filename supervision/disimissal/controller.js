transadapter["append"] = function (t)
{

    //popuplayer.display("/supervision/topic/editInvestigatioN.jsp?typeid="+typeid+"&TB_iframe=true", '特定问题调查', {width: 830, height: 550});
     popuplayer.display("/supervision/disimissal/editDismissal.jsp?typeid="+typeid+"&TB_iframe=true", '撤职案的审议和决定', {width: 1024, height: 620});
    // popuplayer.display("/supervision/topic/specialReport.jsp?typeid="+typeid+"&TB_iframe=true", '特定问题调查', {width: 830, height: 550});
}

transadapter["file"] = function (t)
{
    popuplayer.display("/supervision/disimissal/file.jsp?id=" + transadapter.id + "&TB_iframe=true", '提交', {width: 300, height: 80});
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
    popuplayer.display("/supervision/disimissal/delete.jsp?relationid=" + rid + "&account=" +account2 + "&rolelist=" +rolelist2 + "&typeid="+typeid+"&TB_iframe=true", '删除', {width: 300, height: 80});
}
function ck_dbAbTlclick() {

    $('tbody tr').dblclick(function () {
        popuplayer.display("/supervision/disimissal/disimissalview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 560});
    })

}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/supervision/disimissal/quicksearch.jsp?typeid="+typeid, '快速查询', {width: 500, height: 200});
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
    popuplayer.display("/supervision/disimissal/disimissalview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}