transadapter["append"] = function (t)
{
    popuplayer.display("/workexchange/mailbox/see/edit.jsp?TB_iframe=true", '新增信息', {width: 790, height: 490});
}
﻿transadapter["edit"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条编辑")
        return false;
    }
    popuplayer.display("/workexchange/mailbox/see/write.jsp?id=" + transadapter.id + "&TB_iframe=true", '回复', {width: 790, height: 490});
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
    popuplayer.display("/workexchange/mailbox/see/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/workexchange/mailbox/see/quicksearch.jsp", '查询', {width: 450, height: 250});
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
    location.href = "/workexchange/mailbox/see/butview.jsp?id=" + transadapter.id;
//    popuplayer.display("/workexchange/mailbox/see/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height:400});
}
function ck_dbAbWlclick() {

    $('tbody tr').dblclick(function () {
        location.href = "/workexchange/mailbox/see/butview.jsp?id=" + $(this).attr('idd');
//            popuplayer.display("/company/butview.jsp?relationid=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}