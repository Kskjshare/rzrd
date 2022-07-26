transadapter["append"] = function (t)
{
    popuplayer.display("/scoringrules/edit.jsp?TB_iframe=true", '评分规则', {width: 790, height: 530});
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
    popuplayer.display("/scoringrules/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 530});
}
transadapter["delete"] = function (t)
{
    var tid=[],rid="";
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    rid=tid.join(",");
    popuplayer.display("/scoringrules/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/scoringrules/quicksearch.jsp", '查询', {width: 450, height:150});
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
    popuplayer.display("/scoringrules/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height:400});
}
transadapter["json"] = function (t)
{
    popuplayer.display("/scoringrules/json.jsp?TB_iframe=true", '创建JSON', {width: 300, height:80});
}