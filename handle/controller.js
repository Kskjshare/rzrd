transadapter["append"] = function (t)
{
    popuplayer.display("/handle/deal.jsp?id=" + transadapter.id + "&TB_iframe=true", '交办', {width: 500, height: 250});
}
﻿transadapter["see"] = function (t)
{
    popuplayer.display("/handle/query.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 600});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/handle/butreview.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 600});
}
﻿transadapter["modify"] = function (t)
{
    popuplayer.display("/handle/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '重新交办', {width: 500, height: 170});
}
﻿transadapter["resume"] = function (t)
{
    popuplayer.display("/handle/resumeedit.jsp?id=" + transadapter.id + "&TB_iframe=true", '办理回复', {width: 830, height: 550});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/bill/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["release"] = function (t)
{
    popuplayer.display("/bill/release.jsp?id=" +transadapter.id + "&TB_iframe=true", '发布', {width: 300, height: 80});
}

transadapter["audit"] = function (t)
{
    popuplayer.display("/bill/audit.jsp?id=" +transadapter.id + "&TB_iframe=true", '审核', {width: 300, height: 170});
}
   function ck_dbAbglclick(){
       
       $('tbody tr').dblclick(function (){
           
            popuplayer.display("/handle/query.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
       })
       
   }