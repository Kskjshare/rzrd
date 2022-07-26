transadapter["append"] = function (t)
{
//    alert(t)
    popuplayer.display("/electionAppointmentAndRemovalSystem/candidateManagement/edit.jsp", '添加', {width: 800, height: 550});
}
﻿transadapter["edit"] = function (t)
{
    var tid = [], lid = "", account1 = [];//, account2 = "";
    //选中所有的多选框
    $("[name='id']").each(function () {
        //看选中的哪个多选框
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().text());
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条")
        return false;
    }
    lid = tid.join(",");
    popuplayer.display("/electionAppointmentAndRemovalSystem/candidateManagement/edit.jsp?id=" + lid, '编辑', {width: 800, height: 550});
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
    popuplayer.display("/electionAppointmentAndRemovalSystem/candidateManagement/delete.jsp?id=" + lid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/electionAppointmentAndRemovalSystem/candidateManagement/quicksearch.jsp", '查询', {width: 450, height: 250});
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
    id = tid.join(",")
    location.href = "/electionAppointmentAndRemovalSystem/candidateManagement/companylist.jsp?id=" + id;
}