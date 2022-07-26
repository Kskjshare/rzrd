transadapter["append"] = function (t)
{
    popuplayer.display("/training/statute/xianfa/edit.jsp?TB_iframe=true", '新增', {width: 960, height: 600});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/training/statute/xianfa/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 960, height: 600});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/training/statute/xianfa/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 400, height: 120});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/training/statute/xianfa/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/training/statute/xianfa/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbFlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/training/statute/xianfa/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}