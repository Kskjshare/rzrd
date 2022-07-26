transadapter["append"] = function (t)
{
    popuplayer.display("/delegation/group/delegate/edit.jsp?groupid="+groupid+"&dbtid="+dbtid+"&TB_iframe=true", '选择代表', {width: 600, height: 700});
}
transadapter["delete"] = function (t)
{
    var tid=[],rid="",account1=[],account2="";
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
          account1.push($(this).parent().next().text());
        }
    });
    rid=tid.join(",");
    account2=account1.join("','");
    popuplayer.display("/delegation/group/delegate/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}



transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/delegation/group/delegate/quicksearch.jsp?groupid="+groupid+"&dbtid="+dbtid+"&TB_iframe=true", '查询', {width: 450, height:250});
}
