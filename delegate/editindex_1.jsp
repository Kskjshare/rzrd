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
    RssList entity = new RssList(pageContext, "user");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
                entity.remove("myid").remove("action");
                entity.update().where("myid=?", UserList.MyID(request)).submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
        }
    entity.select().where("myid=?", UserList.MyID(request)).get_first_rows();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>汝州智慧人大服务管理平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="../css/swfupload.css" rel="stylesheet" type="text/css"/>
        <style>
            #headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
            em{font-size: 12px;color: red;margin-left: 2px;}
            .formor td select{width: 206px;}
            .w599{width: 599px;}
            .borderred{border-color:red; }
            #abc{position: absolute;left: -10000px;}
            td>h1{text-align: center;margin: 20px;}
            .formor>tbody>tr>.uetd{text-align: left;}
        </style>
    </head>
    <body>
        <form id="abc" enctype="multipart/form-data" method="post">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form>  
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 formor">
                    <tr><td class="w100">上传头像</td><td colspan="3" id="headimg">
                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity.get("avatar")); %>"></div>
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="avatar" id="avatar" value="<% entity.write("avatar");%>">
                        </td></tr>
                    <tr>
                    <tr class="textal">
                        <td colspan="4" class="marginauto uetd">
                            <h1>代表简历</h1>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">修改</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/staff.js"></script>
        <script src="/data/nationality.js"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                                var imgresult=$("img").attr("src");
                                    if(imgresult!=="/upfile/avatar.png"){
                                        $("#upfiletype").text("已上传");
                                    }
                            function PreviewImage(fileObj, imgPreviewId, divPreviewId) {
                                var allowExtention = ".jpg,.bmp,.gif,.png"; //�����ϴ��ļ��ĺ�׺��document.getElementById("hfAllowPicSuffix").value;
                                var extention = fileObj.value.substring(fileObj.value.lastIndexOf(".") + 1).toLowerCase();
                                var browserVersion = window.navigator.userAgent.toUpperCase();
                                if (allowExtention.indexOf(extention) > -1) {
                                    if (fileObj.files) {//HTML5ʵ��Ԥ��������chrome�����7+��
                                        if (window.FileReader) {
                                            var reader = new FileReader();
                                            reader.onload = function (e) {
                                                document.getElementById(imgPreviewId).setAttribute("src", e.target.result);
                                            }
                                            reader.readAsDataURL(fileObj.files[0]);
                                        } else if (browserVersion.indexOf("SAFARI") > -1) {
                                            alert("��֧��Safari6.0�����������ͼƬԤ��!");
                                        }
                                    } else if (browserVersion.indexOf("MSIE") > -1) {
                                        if (browserVersion.indexOf("MSIE 6") > -1) {//ie6
                                            document.getElementById(imgPreviewId).setAttribute("src", fileObj.value);
                                        } else {//ie[7-9]
                                            fileObj.select();
                                            if (browserVersion.indexOf("MSIE 9") > -1)
//                                                fileObj.blur(); //������document.selection.createRange().text��ie9��
                                                document.getElementById(divPreviewId).focus();
                                            fileObj.blur();
                                            var newPreview = document.getElementById(divPreviewId + "New");
                                            if (newPreview == null) {

                                                newPreview = document.createElement("div");
                                                newPreview.setAttribute("id", divPreviewId + "New");
                                                newPreview.style.border = "solid 1px #d2e2e2";
                                            }
                                            newPreview.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='" + document.selection.createRange().text + "')";
                                            var tempDivPreview = document.getElementById(divPreviewId);
                                            tempDivPreview.parentNode.insertBefore(newPreview, tempDivPreview);
                                            tempDivPreview.style.display = "none";
                                        }
                                    } else if (browserVersion.indexOf("FIREFOX") > -1) {//firefox
                                        var firefoxVersion = parseFloat(browserVersion.toLowerCase().match(/firefox\/([\d.]+)/)[1]);
                                        if (firefoxVersion < 7) {//firefox7���°汾
                                            document.getElementById(imgPreviewId).setAttribute("src", fileObj.files[0].getAsDataURL());
                                        } else {//firefox7.0+                    
                                            document.getElementById(imgPreviewId).setAttribute("src", window.URL.createObjectURL(fileObj.files[0]));
                                        }
                                    } else {
                                        document.getElementById(imgPreviewId).setAttribute("src", fileObj.value);
                                    }
                                } else {
                                    alert("��֧��" + allowExtention + "Ϊ��׺�����ļ�!");
                                    fileObj.value = ""; //���ѡ���ļ�
                                    if (browserVersion.indexOf("MSIE") > -1) {
                                        fileObj.select();
                                        document.selection.clear();
                                    }
                                    fileObj.outerHTML = fileObj.outerHTML;
                                }
                            }
                            $("#submit").click(function () {
                                $("#abc").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        console.log(data)
                                        $("#minhead>img").attr("src", "/upfile/" + data.url);
                                        $("#avatar").val(data.url);
                                        alert("上传成功");
                                        $("#upfiletype").text("(成功上传)")
                                    }});
                                return false;
                            })
                            $('#pbut').click(function () {
                                $("#submit").click();
                            })
                            $("#selbut").click(function () {
                                $("#file").click();
                            })


        </script>
    </body>
</html>
