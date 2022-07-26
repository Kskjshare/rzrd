
//权限
transadapter["append"]=function(t)
{
    popuplayer.display("/staff/department/edit.jsp&TB_iframe=true",'增加',{ width: 400,height: 150 });
}
transadapter["edit"]=function(t)
{
    popuplayer.display("/staff/department/edit.jsp?id="+transadapter.id+"&TB_iframe=true",'编辑',{ width: 400,height: 150 });
}
transadapter["delete"]=function(t)
{
    popuplayer.display("/staff/department/delete.jsp?id="+transadapter.id+"&TB_iframe=true",'删除',{ width: 300,height: 80 });
}
transadapter["power"]=function(t)
{
    popuplayer.display("/staff/department/power.jsp?id="+transadapter.id+"&TB_iframe=true",'设置权限',{ width: 400,height: 500 });
}
transadapter["json"]=function(t)
{
    popuplayer.display("/staff/json.jsp?TB_iframe=true",'创建JSON',{ width: 300,height: 80 });
}
transadapter["edita"]=function(t)
{
    alert("222");
    popuplayer.display("/staff/department/edit.jsp?id="+transadapter.id+"&TB_iframe=true",'编辑',{ width: 850,height: 500 });
}