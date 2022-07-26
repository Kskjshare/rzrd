transadapter["append"] = function (t)
{
    popuplayer.display("/delegation/edit.jsp?TB_iframe=true", '新增代表团信息', {width: 830, height: 380});
}
﻿transadapter["edit"] = function (t)
{
    var tid=[]
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    if (tid.length>1) {
        alert("每次只能选择一条编辑")   
        return false;
    }
    popuplayer.display("/delegation/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 460});
}
transadapter["delete"] = function (t)
{
    var tid=[],rid="",account1=[],account2="";
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
          account1.push($(this).parent().next().next().next().text());
        }
    });
    rid=tid.join(",");
    account2=account1.join("','");
    popuplayer.display("/delegation/delete.jsp?id=" +rid + "&account=" +account2 + "&TB_iframe=true", '删除', {width: 300, height: 80});
}


transadapter["transfer"] = function (t)
{
    if($("[name='id']:checked").length == 1){
    var retitle =$("[name='id']:checked").first().parents("tr").find("td").eq(3).text()
    popuplayer.display("/delegation/transfer.jsp?relationid=" +transadapter.id + "&TB_iframe=true", retitle+"人大代表团人员调动", {width: 500, height: 500});    
    }else {
        alert("一次只能选择一条");
    }
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/delegation/quicksearch.jsp", '查询', {width: 450, height:250});
}
transadapter["butreview"] = function (t)
{
    popuplayer.display("/delegation/butreview.jsp", '审查', {width: 830, height: 400});
}
function ck_dbtdblclick(){
       
       $('tbody tr').dblclick(function (){
            popuplayer.display("/delegation/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height:220});
       })
       
   }
﻿transadapter["butview"] = function (t)
{
    var tid=[]
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    if (tid.length>1) {
        alert("每次只能选择一条查看")   
        return false;
    }
    popuplayer.display("/delegation/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height:220});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" +transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
transadapter["apd"] = function (t)
{
    popuplayer.display("/delegation/apd.jsp", '导入', {width: 550, height: 200});
}
transadapter["export"] = function (t)
{
     location.href="delegationlist.jsp?relationid=" +transadapter.id
}