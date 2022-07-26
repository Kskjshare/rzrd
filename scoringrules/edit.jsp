<%@page import="RssEasy.MySql.RssClassifyList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "activitiestype_classify");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("id,myid");
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        new RssClassifyList(pageContext, "activitiestype").createclassifyjson();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;}
            .w630{width:630px;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">评分规则信息</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">编码：</td>
                        <td><input type="text" maxlength="10" class="w200" name="code" value="<% entity.write("code"); %>" /></td>
                        <td class="dce w100 ">标题：</td>
                        <td><input type="text" maxlength="70" class="w200" name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        
                        <td class="dce w100 ">基础分：</td>
                        <td><input type="number" maxlength="3" class="w200" name="basescore" value="<% entity.write("basescore"); %>" /></td>
                        <td class="dce w100 ">最高分：</td>
                        <td><input type="number" maxlength="3" class="w200" name="maxscore" value="<% entity.write("maxscore"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考勤加分：</td>
                        <td><input type="number" maxlength="3" class="w200" name="speakscore" value="<% entity.write("speakscore"); %>" /></td>
                        <td class="dce w100 ">最低分：</td>
                        <td><input type="number" maxlength="3" class="w200" name="minscore" value="<% entity.write("minscore"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">缺勤扣分：</td>
                        <td><input type="number" maxlength="3" class="w200" name="absence" value="<% entity.write("absence"); %>" /></td>
<!--                        <td class="dce w100 ">请假扣分：</td>
                        <td><input type="number" maxlength="3" class="w200" name="leavescore" value="<% entity.write("leavescore"); %>" /></td>-->
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        

    </body>
</html>
