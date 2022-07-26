transadapter["append"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/handle/deal.jsp?id=" + rid + "&TB_iframe=true", '交办', {width: 500, height: 250});
}
﻿transadapter["see"] = function (t)
{
    popuplayer.display("/handle/query.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 600});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/handle/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 600});
}
﻿transadapter["modify"] = function (t)
{
    popuplayer.display("/handle/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '重新交办', {width: 500, height: 170});
}
﻿transadapter["resume"] = function (t)
{
    popuplayer.display("/handle/resumeedit.jsp?id=" + transadapter.id + "&TB_iframe=true", '办理回复', {width: 830, height: 550});
}

transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/handle/assign/quicksearch.jsp" + url, '快速查询', {width: 450, height: 300});
}
function ck_dbAbjlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/handle/query.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}
﻿transadapter["butview"] = function (t)
{
    popuplayer.display("/handle/assign/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
function ck_dbMZddlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/handle/assign/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/handle/assign/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '办理回复', {width: 830, height: 630});
}