/// <reference path="../custom2.js" />
/// <reference path="transadapter.js" />
transadapter["append"]=function(t)
{
    popuplayer.display("/staff/position/edit.jsp&TB_iframe=true",'增加岗位',{ width: 800,height: 550 });
}
transadapter["edit"]=function(t)
{
    popuplayer.display("/staff/position/edit.jsp?id="+transadapter.id+"&TB_iframe=true",'编辑岗位',{ width: 800,height: 550 });
}
transadapter["delete"]=function(t)
{
    popuplayer.display("/staff/position/delete.jsp?id="+transadapter.id+"&TB_iframe=true",'删除岗位',{ width: 300,height: 80 });
}
transadapter["power"]=function(t)
{
    popuplayer.display("/staff/position/power.jsp?id="+transadapter.id+"&TB_iframe=true",'设置权限',{ width: 400,height: 500 });
}
transadapter["json"]=function(t)
{
    popuplayer.display("/staff/json.jsp?TB_iframe=true",'创建JSON',{ width: 300,height: 80 });
}