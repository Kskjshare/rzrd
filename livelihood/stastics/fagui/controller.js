transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/statute/fagui/edit.jsp?TB_iframe=true", '新增相关法规', {width: 790, height: 475});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/statute/fagui/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height:475});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/statute/fagui/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/statute/fagui/quicksearch.jsp", '查询', {width: 450, height:250});
}

﻿transadapter["butview"] = function (t)
{
   location.href="/makepolicy/statute/fagui/butview.jsp?id="+transadapter.id ;
}
   function ck_dbAbJlclick(){
       
       $('tbody tr').dblclick(function (){
           
            location.href="/makepolicy/statute/fagui/butview.jsp?id="+$(this).attr('idd') ;
       })
       
   }