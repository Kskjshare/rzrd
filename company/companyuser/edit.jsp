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
    RssList entity = new RssList(pageContext, "user");
    RssList entity3 = new RssList(pageContext, "user");
    RssListView entity2 = new RssListView(pageContext, "company_user");
    RssList user1 = new RssList(pageContext, "userrole");
    RssList user4 = new RssList(pageContext, "userrole");
    RssList entity6 = new RssList(pageContext, "user");
    RssListView userrole = new RssListView(pageContext, "userrole");
    StaffList Staff = new StaffList(pageContext);
    entity.request();
    entity2.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("relationid");
        entity.remove("parent");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
                if (userrole.select().where("account='" + entity.get("account") + "' and state like '%5%'").get_first_rows()) {
                    out.print("<script>console.log(('该单位联系人登录账号已经注册过了！'));</script>");
                    out.print("<script>alert('该单位联系人登录账号已经注册过了！');</script>");
                } else {
                    if (entity3.select().where("lianxirenCode=" + entity.get("lianxirenCode") + "").get_first_rows()) {
                        out.print("<script>alert('该单位联系人编号已存在！');</script>");
                        break;
                    } else {
                        if (entity.get("account").isEmpty() && !entity.get("telphone").isEmpty()) {
                            out.print("<script>console.log('登录名为空，电话不为空！');</script>");
                            if (entity3.select().where("account='" + entity.get("telphone") + "'").get_first_rows()) {
                                out.print("<script>alert('该手机号码已经注册过了！');</script>");
                                break;
                            } else {
                                entity.timestamp();
                                entity.remove("account");
                                entity.remove("myid");
                                entity.remove("login");
                                if (entity3.select().where("account='" + entity.get("telphone") + "'").get_first_rows()) {
                                    user1.keyvalue("account", entity.get("telphone"));
                                } else {
                                    entity.keyvalue("loginNameDw", entity.get("telphone"));
                                    entity.keyvalue("account", entity.get("telphone"));
                                    user1.keyvalue("account", entity.get("telphone"));
                                    entity.keyvalue("pwd", Encrypt.Md532(entity.get("telphone") + entity.get("passwordNO")));
                                }
                            }
                        } else {
                            entity.remove("account");
                            entity.remove("myid");
                            entity.remove("login");
                            if (entity3.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                                user1.keyvalue("account", entity.get("account"));
                            } else {
                                entity.keyvalue("loginNameDw", entity.get("account"));
                                entity.keyvalue("account", entity.get("account"));
                                user1.keyvalue("account", entity.get("account"));
                                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
                            }
                        }
                        entity.timestamp();
                        user1.keyvalue("state", 5);
                        if (entity6.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                            if (entity6.get("rolelist").indexOf(",24,") != 1) {
                                entity.keyvalue("rolelist", entity6.get("rolelist") + ",24,");
                            }
                        } else {
                            entity.keyvalue("rolelist", ",24,");
                        }

                        if (entity.get("account").isEmpty() && !entity.get("telphone").isEmpty()) {
                            // 查找相同登录账号的行数
                            user4.select("count(*) as n").where("account='" + entity.get("telphone") + "'").get_first_rows();
                            // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
                            if (Integer.parseInt(user4.get("n")) != 1) {
                                entity.keyvalue("powergroupid", 5);
                            } else {
                                entity.keyvalue("powergroupid", 24);
                            }

                            if (entity3.select().where("account='" + entity.get("telphone") + "'").get_first_rows()) {
                                entity.update().where("account=?", entity.get("telphone")).submit();
                            } else {
                                entity.append().submit();
                            }
                            user1.append().submit();
                        } else {
                            user4.select("count(*) as n").where("account='" + entity.get("account") + "'").get_first_rows();
                            // 不等于1则默认权限为代表 3   等于1则设当前角色为默认角色
                            if (Integer.parseInt(user4.get("n")) != 1) {
                                entity.keyvalue("powergroupid", 5);
                            } else {
                                entity.keyvalue("powergroupid", 24);
                            }

                            if (entity3.select().where("account='" + entity.get("account") + "'").get_first_rows()) {
                                entity.update().where("account=?", entity.get("account")).submit();
                            } else {
                                entity.append().submit();
                            }
                            user1.append().submit();
                        }
                        if (!Staff.select().where("myid=?", String.valueOf(entity.autoid)).get_first_rows()) {
                            Staff.keyvalue("myid", entity.autoid);
                            Staff.append().submit();
                        }
                        PoPupHelper.adapter(out).iframereload();
                        PoPupHelper.adapter(out).showSucceed();
                    }
                }

//                    if (userrole.select().where("account='" + entity.get("telphone") + "' and role like '%22%'").get_first_rows()) {
//                        out.print("<script>alert('该单位联系人已经注册过了！');</script>");
//                    } else {
//                        if (entity3.select().where("lianxirenCode=" + entity.get("lianxirenCode") + "").get_first_rows()) {
//                            out.print("<script>alert('该单位编号已存在！');</script>");
//                            break;
//                        }
//                        entity.timestamp();
//                        entity.remove("myid");
//                        entity.remove("account");
//                        if (entity.get("account").isEmpty() && !entity.get("telphone").isEmpty()) {
//                            entity.keyvalue("account", entity.get("telphone"));
//                        } else {
//                            entity.keyvalue("account", entity.get("account"));
//                        }
//                        //                       entity.keyvalue("account", entity.get("telphone"));
//                        entity.keyvalue("state", 5);
//                        entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
//                        entity.append().submit();
//                        Staff.keyvalue("myid", entity.autoid);
//                        Staff.append().submit();
//                        PoPupHelper.adapter(out).iframereload();
//                        PoPupHelper.adapter(out).showSucceed();
//                    }
                break;
            case "update":
//                entity.remove("myid");
//                entity.remove("account");
//                entity.keyvalue("account", entity.get("account"));
//                entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));
//                entity.update().where("myid=?", entity.get("relationid")).submit();
//                PoPupHelper.adapter(out).iframereload();
//                PoPupHelper.adapter(out).showSucceed();
                if (entity3.select().where("lianxirenCode=" + entity.get("lianxirenCode") + " and myid<>" + entity.get("relationid") + "").get_first_rows()) {
                    out.print("<script>alert('该单位编号已存在！');</script>");
                    break;
                } else {
                    if (entity3.select().where("account='" + entity.get("account") + "' and myid <> " + entity.get("relationid") + "").get_first_rows()) {
                        out.print("<script>alert('该登录账号已存在！');</script>");
                        break;
                    } else {
                        entity.remove("myid");
                        user4.remove("n");
                        entity.remove("account");
                        entity.keyvalue("loginNameDw", entity.get("account"));
                        entity.keyvalue("account", entity.get("account"));
                        entity.keyvalue("pwd", Encrypt.Md532(entity.get("account") + entity.get("passwordNO")));

                        user4.keyvalue("account", entity.get("account"));
                        user4.update().where("account ='" + entity.get("login") + "'").submit();

                        entity.remove("login");
                        entity.update().where("myid=?", entity.get("relationid")).submit();
                        PoPupHelper.adapter(out).iframereload();
                        PoPupHelper.adapter(out).showSucceed();
                    }
                }
                break;
        }
    }
    if (!entity.get("parent").isEmpty()) {
    } else {
        entity2.select().where("myid=?", entity2.get("relationid")).get_first_rows();
    }
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
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form>  
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 formor">
                    <tr><td>头像</td><td colspan="3" id="headimg">
                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity2.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity2.get("avatar")); %>"></div>
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="avatar" id="avatar" value="<% entity2.write("avatar");%>">
                        </td></tr>
                    <tr>
                        <td class="tr w100 ">编号：</td>
                        <td><input type="text" maxlength="80" class="w200" name="lianxirenCode" value="<% entity2.write("lianxirenCode"); %>" /></td>
                        <td class="tr w100 ">姓名：</td>
                        <td><input type="text" maxlength="80" class="w200" name="realname" value="<% entity2.write("realname"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">性别：</td>
                        <td><select class="w206" name="sex" dict-select="sex" def="<% entity2.write("sex"); %>"></select></td>
                        <td class="tr w100 ">民族：</td>
                        <td><select class="w206" name="nationid" dict-select="nationid" def="<% entity2.write("nationid"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">学历：</td>
                        <td><select class="w206" name="eduid" dict-select="eduid" def="<% entity2.write("eduid"); %>"></select></td>
                        <td class="tr w100 ">学位：</td>
                        <td><select class="w206" name="degree" dict-select="degree" def="<% entity2.write("degree"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">职业：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w599" name="profession" value="<% entity2.write("profession"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">单位：</td>
                        <td><input type="text" id="companyallname" readonly="readonly" maxlength="80" class="w200" value="<% entity2.write("companyallname"); %>" /></td>
                        <td class="tr w100 ">角色：</td>
                        <td> <select name="powergroupid" dict-select="powergroup" def="<% entity2.write("powergroupid"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">电子邮箱：</td>
                        <td><input type="text" maxlength="80" class="w200" name="email" value="<% entity2.write("email"); %>" /></td>
                        <td class="tr w100 ">出生年月：</td>
                        <td><input type="text" class="w200 Wdate" name="birthday"  rssdate="<% out.print(entity2.get("birthday")); %>,yyyy-MM"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">登录账号：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w599" name="account" value="<% entity2.write("account"); %>" /><input type="hidden" maxlength="80" class="w200" name="login" value="<% entity2.write("account"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">手机号码：</td>
                        <td><input type="number" maxlength="80" class="w200 jynum" name="telphone" value="<% entity2.write("telphone"); %>" /><em>*</em></td>
                        <td class="tr w100 ">登录密码：</td>
                        <td><input type="text" maxlength="80" class="w200" name="passwordNO" value="<% out.print(entity2.get("passwordNO")); %>"/><em>*</em></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">职务：</td>
                        <td colspan="3"><textarea maxlength="88" class="w599 h60" name="job"><% entity2.write("job"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">家庭地址：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w599" name="homeaddress" value="<% entity2.write("homeaddress"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">家庭电话：</td>
                        <td><input class="w200" type="text" maxlength="80" class="" name="hometel" value="<% entity2.write("hometel"); %>" /></td>
                        <td class="tr w100 ">家庭邮编：</td>
                        <td><input class="jynum w200" maxlength="80" name="homecode" value="<% entity2.write("homecode"); %>" /></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity2.get("relationid").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity2.get("relationid").isEmpty() ? "增加" : "修改");%></button>
                <input type="hidden" name="parentid" value="<% out.print(entity2.get("parent").isEmpty() ? entity2.get("parentid") : entity2.get("parent"));%>">
                <!--<input type="hidden" name="account" value="<% out.print(entity2.get("account"));%>">-->
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/nationality.js"></script>
        <script>
                            var imgresult = $("img").attr("src");
                            if (imgresult !== "/upfile/avatar.png") {
                                $("#upfiletype").text("已上传");
                            }
                            $(".footer>button").click(function () {
//                                console.log($('[name=account]').val());
//                                return false;
                                if ($("[name='lianxirenCode']").val() == undefined || $("[name='lianxirenCode']").val() == "") {
                                    alert("请填写单位联系人编号");
                                    $("[name='lianxirenCode']").focus();
                                    return false;
                                }
                                if ($("[name='birthday']").val() != undefined && $("[name='birthday']").val() != "") {
                                    var timestamp = new Date($("[name='birthday']").val());
                                    $("[name='birthday']").val(timestamp / 1000);
                                }
                                if ($("[name='passwordNO']").val() == "" && $("[name='action']").val() == "append") {
                                    alert("请填写登录密码");
                                    $("[name='passwordNO']").focus();
                                    return false;
                                }
                                if ($("[name='account']").val() == undefined || $("[name='account']").val() == "") {
                                    alert("请填写登录账号");
                                    $("[name='account']").focus();
                                    return false;
                                }
                                if ($("[name='telphone']").val() == undefined || $("[name='telphone']").val() == "") {
                                    alert("请填写手机号");
                                    $("[name='telphone']").focus();
                                    return false;
                                } else {
                                    var str = $("[name='telphone']").val()
                                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
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
//                            $.each(dictdata["nationalityid"], function (k, v) {
//                                var kk = "<% entity.write("nationid");%>"
//                                if (k == kk) {
//                                    $("select[name='nationid']").append("<option selected='selected' value=" + k + ">" + v[0] + "</option>")
//                                } else {
//                                    $("select[name='nationid']").append("<option value=" + k + ">" + v[0] + "</option>")
//                                }
//                            })
                            $("#companyallname").click(function () {
                                RssWin.onwinreceivemsg = function (dict) {
                                    $("#companyallname").val(dict.myname)
                                    $("[name='parentid']").val(dict.myid)
                                }
                                RssWin.open("/selectwin/selectoneuser.jsp?state=4", 700, 650);
                            })


        </script>
    </body>
</html>
