﻿transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/international/edit.jsp?TB_iframe=true", '新增', {width: 1248, height: 740});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/international/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 1248, height: 740});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/international/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/international/quicksearch.jsp", '查询', {width: 450, height: 150});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/makepolicy/international/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbFlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/makepolicy/international/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}