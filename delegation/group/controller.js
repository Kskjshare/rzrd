﻿transadapter["append"] = function (t)
{
    popuplayer.display("/delegation/group/edit.jsp?TB_iframe=true", '新增小组信息', {width: 830, height: 270});
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
        alert("每次只能选择一条编辑")   
        return false;
    }
    popuplayer.display("/delegation/group/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 270});
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
    popuplayer.display("/delegation/group/delete.jsp?id=" +rid + "&account=" +account2 + "&TB_iframe=true", '删除', {width: 300, height: 80});
}



transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/delegation/group/quicksearch.jsp", '查询', {width: 450, height:250});
}


﻿transadapter["butview"] = function (t)
{
    var tid=[]
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    if (tid.length>1) {
        alert("每次只能选择一条查看")   
        return false;
    }
    popuplayer.display("/delegation/group/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height:220});
}