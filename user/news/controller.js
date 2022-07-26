transadapter["append"] = function (t)
{
    popuplayer.display("/user/news/edit.jsp?usermyid="+Url['myid']+"&TB_iframe=true", '增加', {width: 750, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/user/news/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 750, height: 500});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/user/news/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}