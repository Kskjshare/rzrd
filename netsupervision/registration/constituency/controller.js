transadapter["append"] = function (t)
{
//    alert(t)
    popuplayer.display("/netsupervision/registration/constituency/edit.jsp", '新增', {width: 830, height: 160});
}
﻿transadapter["edit"] = function (t)
{
    var tid = [], lid = "", account1 = [];//, account2 = "";
    //选中所有的多选框
    $("[name='id']").each(function () {
        //看选中的哪个多选框
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().text());
        }
    });
    lid = tid.join(",");
    popuplayer.display("/netsupervision/registration/constituency/edit.jsp?id=" + lid, '修改', {width: 320, height: 260});
}

transadapter["delete"] = function (t)
{
    var tid = [], lid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    lid = tid.join(",");
    popuplayer.display("/netsupervision/registration/constituency/delete.jsp?id=" + lid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{

    popuplayer.display("/netsupervision/registration/constituency/quicksearch.jsp", '查询', {width: 450, height: 250});
//    popuplayer.display("/legislative/Legislativeplanning/quicksearch.jsp", '快速查询', {width: 500, height: 200});
}
﻿transadapter["butview"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条查看")
        return false;
    }
    popuplayer.display("/netsupervision/registration/constituency/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
function ck_dbablclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/netsupervision/registration/constituency/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
    })


}
//导出
transadapter["export"] = function (t)
{
    var tid = [], legislativeid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    legislativeid = tid.join(",")
    location.href = "/netsupervision/registration/constituency/companylist.jsp?legislativeid=" + legislativeid;
}