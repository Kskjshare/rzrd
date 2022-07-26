transadapter["see"] = function (t)
{
    popuplayer.display("/evaluation/government/butview.jsp?relationid=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 500});
}
transadapter["quicksearch"] = function (t)
{
    var url = window.location.search;
    popuplayer.display("/evaluation/government/quicksearch.jsp"+url, '快速查询', {width: 450, height:150});
}
﻿transadapter["append"] = function (t)
{
    popuplayer.display("/evaluation/government/edit.jsp?TB_iframe=true", '"一府一委两院"专项工作满意度测评', {width: 790, height: 500});
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
    popuplayer.display("/evaluation/government/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 580});
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
    popuplayer.display("/evaluation/government/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["apd"] = function (t)
{
    popuplayer.display("/evaluation/government/apd.jsp", '导入', {width: 550, height: 200});
}

