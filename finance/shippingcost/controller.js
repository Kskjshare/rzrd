transadapter["audit"] = function (t)
{
    popuplayer.display("/finance/withdraw/audit.jsp?id=" + transadapter.id + "&TB_iframe=true", '审核', {width: 300, height: 80});
}
﻿transadapter["pay"] = function (t)
{
    popuplayer.display("/finance/withdraw/pay.jsp?id=" + transadapter.id + "&TB_iframe=true", '支付', {width: 300, height: 200});
}
transadapter["delete"] = function (t)
{
    popuplayer.display("/finance/withdraw/delete.jsp?id=" + transadapter.id + "&TB_iframe=true", '删除', {width: 300, height: 80});
}