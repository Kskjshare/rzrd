transadapter["append"] = function (t)
{  
    var examid = $("#examtr").attr("shijuanid");
    popuplayer.display("/electionAppointmentAndRemovalSystem/examView/edit.jsp?examid="+examid , '添加', {width: 800, height: 550});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/electionAppointmentAndRemovalSystem/examView/quicksearch.jsp", '查询', {width: 450, height: 250});
}