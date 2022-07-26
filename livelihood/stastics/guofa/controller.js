transadapter["append"] = function (t)
{
    popuplayer.display("/makepolicy/statute/guofa/edit.jsp?TB_iframe=true", '新增国家法律', {width: 790, height: 475});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/makepolicy/statute/guofa/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 790, height:475});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/makepolicy/statute/guofa/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/makepolicy/statute/guofa/quicksearch.jsp", '查询', {width: 450, height:250});
}

﻿transadapter["butview"] = function (t)
{
   location.href="/makepolicy/statute/guofa/butview.jsp?id="+transadapter.id ;
}
   function ck_dbAbKlclick(){
       
       $('tbody tr').dblclick(function (){
           
            location.href="/makepolicy/statute/guofa/butview.jsp?id="+$(this).attr('idd');
       })
       
   }