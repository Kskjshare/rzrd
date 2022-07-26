<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<script>
    function getUrlParam(name) {
                //构造一个含有目标参数的正则表达式对象
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                //匹配目标参数
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                } else {
                    //返回参数值
                    return "";
                }
            }
    alert(flag);
</script>-->
<%
   // popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true&flag="+flag, '填写审核结果说明', {width: 600, height: 330});
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "activities");
    entity.request();
    if (req.get("action").equals("update")) {
        entity.remove("id");
//        entity.remove("flag");//sql语句会自动加入url传入的参数字段与值,移除sql语句中的url传参中的字段
//        entity.keyvalue("state",Integer.parseInt(req.get("flag"))+1);
        entity.update().where("id in(" + req.get("id") + ")").submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select("id,closenote").where("id=?",entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 tollbor">
<!--                    <tr>
                        <td colspan="2" class="institle dce">活动审核</td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">审核结论：<em class="red">*</em></td>
<!--                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>-->
                        <td>
                            <input type="radio" id="pid1" name="state" value="2" >
                            <label for="pid1">通过</label>
                            
                            <input type="radio" id="pid2" name="state" value="3" >
                            <label for="pid2">不通过</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <span>(如审核不通过请写明原因)</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">审核意见：<em class="red">*</em></td>
                        <td class="dec"><textarea type="text" class="wp98 h250" name="closenote"><% entity.write("closenote"); %></textarea></td>
                    </tr>

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
