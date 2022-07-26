transadapter["append"] = function (t)
{
    popuplayer.display("/activities/sign/edit.jsp?TB_iframe=true", '发起活动', {width: 500, height: 550});
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
    popuplayer.display("/activities/sign/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '手动报名', {width: 500, height: 550});
}
transadapter["delete"] = function (t)
{
    var tid=[],rid="";
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    rid=tid.join(",");
    popuplayer.display("/activities/sign/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/activities/sign/quicksearch.jsp", '查询', {width: 450, height:250});
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
    popuplayer.display("/activities/sign/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看',{width: 500, height: 550});
}
   function ck_dbchlclick(){
       
       $('tbody tr').dblclick(function (){
           
            popuplayer.display("/activities/sign/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
       })
       
   }