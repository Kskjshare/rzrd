transadapter["edit"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "";
    $("[name='myid']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    popuplayer.display("/staff/edit.jsp?myid=" + rid + "&account=" + account2 + "&TB_iframe=true", '编辑', {width: 500, height: 450});
}

﻿transadapter["append"] = function (t)
{
    popuplayer.display("/staff/edit.jsp?TB_iframe=true", '增加', {width: 550, height: 450});
}
transadapter["delete"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "";
    $("[name='myid']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().text());
        }
    });
    rid = tid.join(",");
    account2 = account1.join("','");
    popuplayer.display("/staff/delete.jsp?id=" + rid + "&account=" + account2 + "&TB_iframe=true", '删除', {width: 300, height: 80});

//    popuplayer.display("/staff/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["power"] = function (t)
{
    popuplayer.display("/staff/power.jsp?id=" + transadapter.id + "&TB_iframe=true", '权限设置', {width: 400, height: 500});
}
$("#selectall").click(function ()
{
    $("[name='myid']").prop("checked", this.checked);
});
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/staff/quicksearch.jsp", '查询', {width: 450, height: 280});
}

transadapter["apd"] = function (t)
{
    popuplayer.display("/staff/apd.jsp", '导入', {width: 550, height: 200});
}
transadapter["export"] = function (t)
{
    var tid = [], relationid = "";
    $("[name='myid']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    relationid = tid.join(",")
    popuplayer.display("/staff/export.jsp?relationid=" + relationid, '导出', {width: 480, height: 120});
}
﻿transadapter["piliang"] = function (t)
{
    popuplayer.display("/staff/piliang.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 230});
}
﻿transadapter["piliangLX"] = function (t)
{
    popuplayer.display("/staff/piliangLX.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 230});
}
﻿transadapter["piliangYH"] = function (t)
{
    popuplayer.display("/staff/piliangYH.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 400, height: 300});
}