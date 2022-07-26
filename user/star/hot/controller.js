transadapter["edit"] = function (t)
{
    popuplayer.display("/user/star/edit.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 300, height: 400});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/user/star/hot/delete.jsp?myid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}