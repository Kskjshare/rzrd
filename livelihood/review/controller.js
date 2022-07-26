transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/lecture/edit.jsp?TB_iframe=true", '新增专题讲座', {width: 790, height: 650});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/lecture/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 650});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/lecture/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/lecture/quicksearch.jsp", '查询', {width: 450, height: 250});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/makepolicy/lecture/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbGlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/makepolicy/lecture/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}