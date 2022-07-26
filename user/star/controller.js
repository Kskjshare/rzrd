transadapter["append"] = function (t)
{
    popuplayer.display("/user/star/edit.jsp?TB_iframe=true", '增加', {width: 650, height: 500});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/user/star/edit.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 650, height: 500});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/user/star/delete.jsp?myid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}
﻿transadapter["hot"] = function (t)
{
    popuplayer.display("/user/star/hot.jsp?myid=" + transadapter.id + "&TB_iframe=true", '增加到热门', {width: 300, height: 80});
}