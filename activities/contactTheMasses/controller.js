transadapter["append"] = function (t)
{
    popuplayer.display("/activities/contactTheMasses/edit.jsp?classify="+$("#classify").val()+"&TB_iframe=true", '发起活动', {width: 500, height: 550});
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
    popuplayer.display("/activities/contactTheMasses/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑活动', {width: 500, height: 550});
}
﻿transadapter["doattendance"] = function (t)
{
     var tid = []
     var state =[];
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
                  console.log(tid,"tid")
                   state.push($(this).attr('idState'));      
        }
    });
 
     if (tid.length > 1) {
            alert("每次只能选择一条编辑")
            return false;
      }
     if(state[0]==2 && tid.length==1){
         alert("活动已关闭")
     }
     if(state[0]==1 && tid.length==1){
               popuplayer.display("/activities/contactTheMasses/doattendance.jsp?id=" + transadapter.id + "&TB_iframe=true", '手动补签', {width: 600, height: 650});
     }
}

transadapter["delete"] = function (t)
{
    var tid=[],rid="";
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
          console.log($(this).attr("idState"),"00000")
        }
    });
    rid=tid.join(",");
    popuplayer.display("/activities/contactTheMasses/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}

transadapter["quicksearch"] = function (t)
{
    
    popuplayer.display("/activities/contactTheMasses/quicksearch.jsp?classify="+classify, '查询', {width: 450, height:250});
}
transadapter["attendance"] = function (t)
{
    var tid = []
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    if (tid.length > 1) {
        alert("每次只能选择一条编辑")
        return false;
    }
    popuplayer.display("/activities/contactTheMasses/attendance.jsp?id=" +transadapter.id+ "&TB_iframe=true", '履职人员', {width: 800, height:500});
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
    popuplayer.display("/activities/contactTheMasses/butview.jsp?id=" + transadapter.id + "&TB_iframe=true", '查看',{width: 600, height: 650});
}
   function ck_dbablclick(){
       
       $('tbody tr').dblclick(function (){
           
            popuplayer.display("/activities/contactTheMasses/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 550});
       })
       
       
   }