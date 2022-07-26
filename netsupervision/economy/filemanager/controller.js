transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/courseware/edit.jsp?TB_iframe=true", '新增学习课件', {width: 790, height: 600});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/courseware/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 600});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/courseware/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/courseware/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/makepolicy/courseware/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbFlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/makepolicy/courseware/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}