transadapter["append"] = function (t)
{
    popuplayer.display("/user/sonaccount/edit.jsp?TB_iframe=true", '增加用户', {width: 400, height: 500});
}﻿
﻿transadapter["edit"] = function (t)
{
    popuplayer.display("/user/sonaccount/edit.jsp?myid=" + transadapter.id + "&TB_iframe=true", '编辑用户', {width: 400, height: 500});
}﻿
transadapter["repwd"] = function (t)
{
    popuplayer.display("/user/sonaccount/repwd.jsp?myid=" + transadapter.id + "&TB_iframe=true", '重置密码', {width: 300, height: 80});
}
﻿transadapter["delete"] = function (t)
{
    popuplayer.display("/user/sonaccount/delete.jsp?myid=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}