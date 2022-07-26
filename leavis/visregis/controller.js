transadapter["append"] = function (t)
{

    popuplayer.display("/leavis/visregis/edit.jsp?&TB_iframe=true", '新增来访登记', {width: 1248, height: 740});
//        popuplayer.display("/leavis/visregis/edit.jsp?&TB_iframe=true", '新增来访登记', {width: 830, height: 550});

}
﻿transadapter["edit"] = function (t)
{
    var tid = [], rid = "", account1 = [], account2 = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
            account1.push($(this).parent().next().next().next().text());
        }
    });
    rid = tid.join(",");
    popuplayer.display("/leavis/visregis/edit.jsp?id=" + rid + "&TB_iframe=true", '编辑', {width: 1248, height: 740});
}

transadapter["delete"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/leavis/visregis/delete.jsp?relationid=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    
    popuplayer.display("/leavis/visregis/quicksearch.jsp", '查询', {width: 450, height:250});
//    popuplayer.display("/leavis/letregtion/quicksearch.jsp", '快速查询', {width: 500, height: 200});
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
    popuplayer.display("/leavis/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
function ck_dbablclick(){
       
       $('tbody tr').dblclick(function (){
           
            popuplayer.display("/leavis/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
       })
       
       
   }
//导出
transadapter["export"] = function (t)
{
    var tid = [], relationid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    relationid = tid.join(",")
    location.href = "/leavis/visregis/companylist.jsp?relationid=" + relationid;
}