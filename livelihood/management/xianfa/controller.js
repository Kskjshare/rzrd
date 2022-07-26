transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/statute/xianfa/edit.jsp?TB_iframe=true", '新增宪法', {width: 790, height: 475});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/statute/xianfa/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height:475});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/statute/xianfa/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/statute/xianfa/quicksearch.jsp", '查询', {width: 450, height:250});
}

﻿transadapter["butview"] = function (t)
{
   location.href="/makepolicy/statute/xianfa/butview.jsp?id="+transadapter.id ;
}
   function ck_dbAbLlclick(){
       
       $('tbody tr').dblclick(function (){
           
            location.href="/makepolicy/statute/xianfa/butview.jsp?id="+$(this).attr('idd') ;
       })
       
   }