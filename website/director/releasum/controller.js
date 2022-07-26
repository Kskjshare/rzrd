transadapter["append"] = function (t)
{

    popuplayer.display("/website/director/releasum/edit.jsp?reldirectorid="+reldirectorid+"&TB_iframe=true", '添加', {width: 830, height: 550});
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
    popuplayer.display("/website/director/releasum/delete.jsp?relationid=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
