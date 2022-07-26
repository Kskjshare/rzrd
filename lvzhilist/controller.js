transadapter["append"] = function (t)
{
    popuplayer.display("/newinformation/edit.jsp?TB_iframe=true", '新增最新资讯', {width: 790, height: 530});
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
    popuplayer.display("/newinformation/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 530});
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
    popuplayer.display("/lvzhilist/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/lvzhilist/quicksearch.jsp", '查询', {width: 520, height:180});
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
    //popuplayer.display("/lvzhilist/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height:400});
    popuplayer.display("/lvzhilist/lzdetail.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 790, height:400});
}
//导出
transadapter["export"] = function (t)
{
     location.href="/lvzhilist/userlist.jsp?relationid=" + transadapter.id
}
//
transadapter["list"] = function (t)
{
     location.href="/evaluation/delegation/list.jsp"
}

