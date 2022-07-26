transadapter["append"] = function (t)
{
//    alert(t)
    popuplayer.display("/electionAppointmentAndRemovalSystem/examStatistics/edit.jsp", '添加', {width: 800, height: 550});
}
﻿transadapter["edit"] = function (t)
{
    var tid = [], lid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条")
        return false;
    }
    lid = tid.join(",");
//    console.log(lid,"xxxxxxxxxxxxx")
    popuplayer.display("/electionAppointmentAndRemovalSystem/examStatistics/edit111.jsp?id=" + lid, '编辑', {width: 800, height: 550});
}

transadapter["delete"] = function (t)
{
    var tid = [], lid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    lid = tid.join(",");
    popuplayer.display("/electionAppointmentAndRemovalSystem/examStatistics/delete.jsp?legislativeId=" + lid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{

    popuplayer.display("/electionAppointmentAndRemovalSystem/examStatistics/quicksearch.jsp", '查询', {width: 450, height: 250});
}

//导出
transadapter["export"] = function (t)
{
    var tid = [], legislativeid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    legislativeid = tid.join(",")
    location.href = "/electionAppointmentAndRemovalSystem/examStatistics/companylist.jsp?id=" + legislativeid;
}