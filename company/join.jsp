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
    StaffList Staff = new StaffList(pageContext);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("relationid");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
                if (!entity.get("telphone").isEmpty()) {
                    if (entity.select().where("account=" + entity.get("telphone")).get_first_rows()) {
                        out.print("<script>alert('该手机号已经注册过了！');</script>");
                    } else {
                        entity.timestamp();
                        entity.remove("myid");
                        entity.keyvalue("account", entity.get("telphone"));
                        entity.keyvalue("pwd", Encrypt.Md532(entity.get("telphone") + "123456"));
                        entity.append().submit();
                        Staff.keyvalue("myid", entity.autoid);
                        Staff.append().submit();
                        PoPupHelper.adapter(out).iframereload();
                        PoPupHelper.adapter(out).showSucceed();
                    }
                } else {
                    out.print("<script>alert('请填写手机号！');</script>");
                }
                break;
            case "update":
                entity.remove("myid");
//                entity.remove("telphone");
                entity.update().where("myid=?", entity.get("relationid")).submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                break;
        }
    }
    entity.select().where("myid=?", entity.get("relationid")).get_first_rows();
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
        </style>
    </head>
    <body>
        <form id="abc" enctype="multipart/form-data" method="post">  
<!--            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity.get("avatar")); %>"></div>-->
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <!--<input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>-->
            <input id="submit" type="submit"/>  
        </form>  
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 formor">
                    <tr><td>头像</td><td colspan="3" id="headimg">
                            <!--                            <ul id="icourlwrap" class="swfuploadwrap">
                                                            <li><div class="swfuploadimg"><div><img src="/upfile/<% entity.write("avatar"); %>"></div></div></li>
                                                        </ul>
                                                        <div>
                                                            <span swfupload="icourlswf" config="{multimode:0,fileType: [['图形图像(*.jpg;*.png;*jpeg;*gif)','*.jpg;*.png;*jpeg']]}"></span>
                                                            <br/>
                            
                                                        </div>-->
<!--                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity.get("avatar")); %>"></div>
                             <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>-->
                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity.get("avatar")); %>"></div>
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="avatar" id="avatar" value="<% entity.write("avatar");%>">
                        </td></tr>
                    <tr>
                        <td class="tr w100 ">代表证号：</td>
                        <td><input type="text" maxlength="80" class="w200" name="code" value="<% entity.write("code"); %>" /></td>
                        <td class="tr w100 ">姓名：</td>
                        <td><input type="text" maxlength="80" class="w200" name="realname" value="<% entity.write("realname"); %>" /></td>
                    </tr><tr>
                        <td class="tr w100 ">性别：</td>
                        <td><select class="w206" name="sex" dict-select="sex" def="<% entity.write("sex"); %>"></select></td>
                        <td class="tr w100 ">民族：</td>
                        <td><select class="w206" name="nationid"></select></td>
                    </tr><tr>
                        <td class="tr w100 ">学历：</td>
                        <td><select class="w206" name="eduid" dict-select="eduid" def="<% entity.write("eduid"); %>"></select></td>
                        <td class="tr w100 ">学位：</td>
                        <td><select class="w206" name="degree" dict-select="degree" def="<% entity.write("degree"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">职业：</td>
                        <td><input type="text" maxlength="80" class="w200" name="profession" value="<% entity.write("profession"); %>" /></td>
                        <td class="tr w100 ">职称：</td>
                        <td><input type="text" maxlength="80" class="w200" name="worktitle" value="<% entity.write("worktitle"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">电子邮箱：</td>
                        <td><input type="text" maxlength="80" class="w200" name="email" value="<% entity.write("email"); %>" /></td>
                        <td class="tr w100 ">出生年月：</td>
                        <td><input type="text" class="w200 Wdate" name="birthday"  rssdate="<% out.print(entity.get("birthday")); %>,yyyy-MM"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">手机号码：</td>
                        <td colspan="3"><input type="number" maxlength="80" class="w200 jynum" name="telphone" value="<% entity.write("telphone"); %>" /><em>*</em></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">职务：</td>
                        <td colspan="3"><textarea maxlength="88" class="w599 h60" name="job"><% entity.write("job"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位名称：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w599" name="company" value="<% entity.write("company"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位地址：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w599" name="workaddress" value="<% entity.write("workaddress"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位电话：</td>
                        <td><input class="jynum w200" maxlength="80" name="worktel" value="<% entity.write("worktel"); %>" /></td>
                        <td class="tr w100 ">单位邮编：</td>
                        <td><input class="w200" maxlength="80" name="postcode" value="<% entity.write("postcode"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">家庭地址：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w599" name="homeaddress" value="<% entity.write("homeaddress"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">家庭电话：</td>
                        <td><input class="w200" type="text" maxlength="80" class="" name="hometel" value="<% entity.write("hometel"); %>" /></td>
                        <td class="tr w100 ">家庭邮编：</td>
                        <td><input class="jynum w200" maxlength="80" name="homecode" value="<% entity.write("homecode"); %>" /></td>
                    </tr>
                    <!--                    <tr class="thismyid">
                                            <td class="tr">作者ID：</td>
                                            <td colspan="3"><input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/> <label><% out.print(UserList.MyID(request)); %></label></td>
                                        </tr>   -->
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("relationid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("relationid").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="../js/lvzhi/jquery.form.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/nationality.js"></script>
        <script>
                            $(".footer>button").click(function () {
                                if ($("[name='birthday']").val() != undefined && $("[name='birthday']").val() != "") {
                                    var timestamp = new Date($("[name='birthday']").val());
                                    $("[name='birthday']").val(timestamp / 1000);
                                }
                                if ($("[name='telphone']").val() == undefined || $("[name='telphone']").val() == "") {
                                    alert("请填写手机号");
                                    $("[name='telphone']").focus();
                                    return false;
                                } else {
                                    var str = $("[name='telphone']").val()
                                    if (!str.match(/^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/)) {
                                        alert("请填写正确的手机号");
                                        return false;
                                    }
                                }
                                if ($("[name='telphone']").val().length > 11) {
                                    alert("手机号格式不正确");
                                    $("[name='telphone']").focus();
                                    return false;
                                }
                                var tf = "0";
                                var editdata = {"telphone": "手机号码", "worktel": "单位电话", "codepost": "单位邮编", "hometel": "家庭号码", "homecode": "家庭邮编"};
                                $(".jynum").each(function () {
                                    var val = $(this).val();
                                    var e = $(this).attr("name");
                                    if (val) {
                                        var patrn = /^[0-9]*$/;
                                        if (!patrn.test(val)) {
                                            alert('邮编应是纯数字');
                                            $("[name='" + e + "']").focus();
                                            tf = "1"
                                        }
                                    }
                                })
                                if (tf == "1") {
                                    return false;
                                }
                            })
//                            $("#file").change(function () {
//                                var file = document.getElementById("file");
//                                PreviewImage(file,"minihead","minhead")
//                            })

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
//                                                newPreview.style.width = document.getElementById(imgPreviewId).width + "px";
//                                                newPreview.style.height = document.getElementById(imgPreviewId).height + "px";
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
                            $.each(dictdata["nationalityid"], function (k, v) {
                                var kk = "<% entity.write("nationid");%>"
                                if (k == kk) {
                                    $("select[name='nationid']").append("<option selected='selected' value=" + k + ">" + v[0] + "</option>")
                                } else {
                                    $("select[name='nationid']").append("<option value=" + k + ">" + v[0] + "</option>")
                                }
                            })


        </script>
    </body>
</html>
