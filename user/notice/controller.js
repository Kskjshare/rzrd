transadapter["append"] = function (t)
{
    popuplayer.display("/user/notice/edit.jsp?usermyid="+Url['myid']+"&TB_iframe=true", '增加', {width: 310, height: 280});
}
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/user/notice/edit.jsp?id=" + transadapter.id + "&TB_iframe=true", '编辑', {width: 310, height: 280});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/user/notice/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}