﻿transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/topics/topics7/edit.jsp?TB_iframe=true", '新增', {width: 1248, height: 740});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/topics/topics7/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 1248, height: 740});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/topics/topics7/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/topics/topics7/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/makepolicy/topics/topics7/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbFlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/makepolicy/topics/topics7/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}