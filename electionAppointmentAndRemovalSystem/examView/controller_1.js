transadapter["append"] = function (t)
{  
    var examid = $("#examtr").attr("shijuanid");
    popuplayer.display("/electionAppointmentAndRemovalSystem/examView/edit.jsp?examid="+examid , '添加', {width: 800, height: 550});
}
transadapter["quicksearch"] = function (t)
{    var examid = $("#examtr").attr("shijuanid");
    console.log("examid===============================================",examid)
    popuplayer.display("/electionAppointmentAndRemovalSystem/examView/quicksearch.jsp?examid="+ examid , '查询', {width: 450, height: 250});
}