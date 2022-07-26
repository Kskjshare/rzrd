transadapter["append"] = function (t)
{
    popuplayer.display("/training/lecture/edit.jsp?TB_iframe=true", '新增专题讲座', {width: 790, height: 650});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/training/lecture/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height: 650});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/training/lecture/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 400, height: 120});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/training/lecture/quicksearch.jsp", '查询', {width: 450, height: 250});
}

﻿transadapter["butview"] = function (t)
{
    location.href = "/training/lecture/butview.jsp?id=" + transadapter.id;
}

function ck_dbAbGlclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/training/lecture/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })

}