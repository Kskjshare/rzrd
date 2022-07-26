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
    RssList entity2 = new RssList(pageContext, "emaillist");
    RssListView entity = new RssListView(pageContext, "emaillist");
    entity2.request();
    entity.request();
    if (!entity2.get("action").isEmpty()) {
        entity2.remove("id");
        entity2.remove("action");
        entity2.timestamp();
        entity2.append().submit();
        out.print("<script>alert('操作成功！');</script>");
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
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 770px;margin: 20px auto;}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;}
            .w630{width:630px;}
            .fileeform{position: absolute;left: -10000px;}
        </style>
    </head>
    <body>
        <form id="fileeform1" class="fileeform"enctype="multipart/form-data" method="post">
            <input type="file" id="file1" ridform="1"  name="file1" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">邮件信息</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">邮件题目：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w630" name="title" value="" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">收件人：</td>
                        <td><% out.print(entity.get("fastate").equals("2") ? entity.get("faname") : entity.get("faallname"));%></td>
                        <td class="dce w100 ">添加附件：</td>
                        <td> <div><span id="fjfile1">点击选择文件</span><input type="hidden" id="enclosure1" name="enclosure" value="" ></div></td>
                    <tr>
                        <td class="dce w100 ">邮件内容</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"></script></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <input name="sendid" value="<% out.print(entity.get("myid"));%>"></td>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="state" value="2">
                <input type="hidden" name="action" value="append" />
                <button type="submit" id="draft">保存</button>
                <button type="submit" id="addsub">发送</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#fjfile1").click(function () {
                $("#file1").click();
            })
            $(".fileeform>input").change(function () {
                $(this).parent().ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#fjfile1").text(data.url)
                        $("#enclosure1").val(data.url);
                        alert("上传成功");
                    }});
                return false;
            })
            $("#draft").click(function () {
                $("[name='state']").val("1")
            })
            $("#addsub").click(function () {
                $("[name='state']").val("2")
            })
        </script>
    </body>
</html>
