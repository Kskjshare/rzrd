transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/reference/edit.jsp?TB_iframe=true", '新增履职参考', {width: 790, height: 555});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/reference/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 555});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/reference/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/reference/quicksearch.jsp", '查询', {width: 450, height: 250});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/makepolicy/reference/butview.jsp?id=" + transadapter.id;
}
function ck_dbAbHlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/makepolicy/reference/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}