transadapter["append"] = function (t)
{
    popuplayer.display("/billlist/edit.jsp?TB_iframe=true", '增加', {width: 830, height: 550});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/billlist/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 830, height: 550});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/billlist/delete.jsp?id=" +transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
transadapter["hot"] = function (t)
{
    popuplayer.display("/billlist/hot.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '增加到热门', {width: 300, height: 80});
}
transadapter["top"] = function (t)
{
    popuplayer.display("/billlist/top.jsp?relationid=" +transadapter.id + "&TB_iframe=true", '增加到置顶', {width: 300, height: 80});
}
transadapter["audit"] = function (t)
{
    popuplayer.display("/billlist/audit.jsp?id=" +transadapter.id + "&TB_iframe=true", '审核', {width: 300, height: 170});
}
transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/billlist/quicksearch.jsp", '快速查询', {width: 500, height: 400});
}
transadapter["supersearch"] = function (t)
{
    popuplayer.display("/billlist/supersearch.jsp", '高级查询', {width: 500, height: 400});
}

transadapter["butreview"] = function (t)
{
    popuplayer.display("/billlist/butreview.jsp?id=" +transadapter.id + "&TB_iframe=true", '审查', {width: 830, height: 600});
}
transadapter["butimportance"] = function (t)
{
    popuplayer.display("/billlist/butimportance.jsp?id=" +transadapter.id + "&TB_iframe=true", '重点建议设置', {width:830 , height: 290});
}
transadapter["butexcellent"] = function (t)
{
    popuplayer.display("/billlist/butexcellent.jsp?id=" +transadapter.id + "&TB_iframe=true", '优秀建议设置', {width: 830, height: 290});
    
}
﻿transadapter["butview"] = function (t)
{
    popuplayer.display("/billlist/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看', {width: 830, height: 560});
}
transadapter["butreports"] = function (t)
{
    popuplayer.display("/suggest/butreports.jsp?id=" +transadapter.id + "&TB_iframe=true", '报表', {width: 550, height: 550});
}
   function ck_dbAbmlclick(){
       
       $('tbody tr').dblclick(function (){
           
            popuplayer.display("/billlist/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
       })
       
   }