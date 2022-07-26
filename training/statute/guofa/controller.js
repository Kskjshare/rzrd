transadapter["append"] = function (t)
{
    popuplayer.display("/training/statute/guofa/edit.jsp?TB_iframe=true", '新增法律法规', {width: 960, height: 600});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/training/statute/guofa/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 960, height: 600});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/training/statute/guofa/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 400, height: 120});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/training/statute/guofa/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/training/statute/guofa/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbFlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/training/statute/guofa/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}