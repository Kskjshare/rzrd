transadapter["append"] = function (t)
{
    popuplayer.display("/handle/deal.jsp?id=" + transadapter.id + "&TB_iframe=true", '交办', {width: 500, height: 250});
}
﻿transadapter["see"] = function (t)
{
    popuplayer.display("/handle/query.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 600});
}
﻿transadapter["edit"] = function (t)
{
     var tid=[]
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    if (tid.length>1) {
        alert("每次只能选择一条")   
        return false;
    }
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
    popuplayer.display("/handle/confirm/quicksearch.jsp" + url, '快速查询', {width: 550, height: 300});
}
function ck_dbAbelclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/handle/query.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}