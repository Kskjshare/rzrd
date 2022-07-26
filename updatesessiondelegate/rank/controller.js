
transadapter["delete"] = function (t)
{
    var tid=[],rid="";
     $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
          tid.push($(this).attr("value"));
        }
    });
    rid=tid.join(",");
    popuplayer.display("/updatesessiondelegate/rank/delete.jsp?id=" +rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
