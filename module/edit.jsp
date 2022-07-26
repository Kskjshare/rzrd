<%@page import="RssEasy.MySql.RssSetup"%>
<%@page import="RssEasy.Core.FileExtend"%>
<%@page import="RssEasy.MySql.RssModuleList"%>
<%@page import="java.io.File"%>
<%@page import="RssEasy.Core.DirectoryExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.HttpExtend"%>
<%@page import="RssEasy.MySql.Staff.StaffPowerList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssModuleList entity = new RssModuleList(req.pageContext);
    entity.request();
    if (!req.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                RssSetup.Setup(req);
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("id");
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        if (!req.has("isvirtual")) {
            File file = new File(DirectoryExtend.Root(request).replace("\\build", "") + req.get("module"));
            DirectoryExtend.Copy(new File(DirectoryExtend.Root(request) + "rssframe"), file);
            FileExtend.replacedir(file, "rssframe", req.get("module"));
            FileExtend.replacedir(file, req.get("module") + "classify", req.get("module").replace("_", "") + "classify");
            FileExtend.replacedir(file, req.get("module") + ".js", req.get("module").replace("_", "") + ".js");
        }

        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="tr w60">名称：
                        </td>
                        <td>
                            <input type="text" name="name" class="w100"  maxlength="50" value="<% entity.write("name"); %>"/><label for="name"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">模块：
                        </td>
                        <td>
                            <input type="text" name="module" class="w100"  maxlength="50" value="<% entity.write("module");%>"/><label for="module"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tr">虚拟：</td>
                        <td class="tr"><input type="checkbox" name="isvirtual" value="1"/></td>
                    </tr>
                    <tr>
                        <td class="tr">功能：</td>
                        <td class="labelright">
                            <label><input type="checkbox" name="attention" value="1"/> 关注</label>
                            <label><input type="checkbox" name="buy" value="1" /> 购买</label>
                            <label><input type="checkbox" name="praise"  value="1"/> 点赞</label>
                            <label><input type="checkbox" name="visit" value="1" /> 访问记录</label>
                            <label><input type="checkbox" name="comment"  value="1"/> 评论</label>
                            <label><input type="checkbox" name="hot"  value="1"/> 热门</label>
                            <label><input type="checkbox" name="top"  value="1"/> 置顶</label>   
                            <label><input type="checkbox" name="userconfig"  value="1"/> 用户配置</label>                     
                            <label><input type="checkbox" name="video"  value="1"/> 视频</label>
                            <label><input type="checkbox" name="audio"  value="1"/> 音频</label>
                            <label><input type="checkbox" name="grade"  value="1"/> 评分</label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
