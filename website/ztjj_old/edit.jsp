<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.JPushClient"%>
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
    RssList entity = new RssList(pageContext, "special");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid");
                entity.update().where("id=?", entity.get("id")).submit();
                break;
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
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}#headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
            #abc{display:none;}
            .bulletin{display: none;}
            
        </style>
    </head>
    <body>
        <form id="abc" enctype="multipart/form-data" method="post" style="display:none;">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form> 
        <form class="abc" enctype="multipart/form-data" method="post" style="display:none;">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" class="file" name="file" multiple>
            <input class="submit" type="submit"/>  
        </form> 
        <form method="post" class="popupwrap">        
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">添加专题集锦</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">标题：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="subject" value="<% entity.write("subject"); %>" /></td>
                    </tr>
                    
                    <tr>
                        <td class="dce w100 ">上传图片</td>
                        <td colspan="2">
                            <div style="display:flex">
                                <div id="divPreview" style="display:none;">
                                        <img id="imgHeadPhoto" src="/upfile/<% entity.write("subjectpicture"); %>">
                            </div>
                            <p id="selbut" style="color:blue; cursor: pointer;font-weight: bold;cursor:pointer;">选择图片</p>&nbsp;&nbsp;
                            <p id="pbut" style="color:blue;cursor: pointer;font-weight: bold;cursor:pointer;">上传图片</p>
                            <span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="subjectpicture" id="ico" value="<% entity.write("subjectpicture"); %>">
                            </div>
                  </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4">
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="content" style="width:100%;"  type="text/plain"><% entity.write("matter"); %>
                            </script>
                        </td>
                    </tr>
                    <tr>
                        <td>上传封面</td>
                        <td colspan="">
                            <div style="display:flex"> 
                                <div class="divPreview" style="display:none;">
                                        <img id="imgHeadPhoto" src="/upfile/<% entity.write("additionalpicture"); %>">
                            </div>
                            <p class="selbut" style="color:blue; cursor: pointer;font-weight: bold;cursor:pointer;">选择图片</p>&nbsp;&nbsp;
                            <p class="pbut" style="color:blue;cursor: pointer;font-weight: bold;cursor:pointer;">上传图片</p>
                            <span class="upfiletype">(未上传)</span>
                            <input type="hidden" name="additionalpicture" class="ico" value="<% entity.write("additionalpicture"); %>">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="w261" colspan="3">
                            <input style="display:none" id="time" style="text-align: center;" class="w200 Wdate" name="date" rssdate="<% entity.write("date"); %>"  onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly" />
                        </td>
                    </tr>
                </table>

            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                if ($("[name='subject']").val() == undefined || $("[name='subject']").val() == "") {
                    alert("请填写标题");
                    $("[name='subject']").focus();
                    return false;
                }
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
        </script>
        <script>
                            $(".footer>button").click(function () {
                                var myDate = new Date();
                                var s = myDate.getHours(); //获取当前小时数(0-23)
                                var f = myDate.getMinutes(); //获取当前分钟数(0-59)
                                var m = myDate.getSeconds(); //获取当前秒数(0-59)
//                                alert(s+"--"+f+"--"+m)
                                var timestamp = Date.parse(new Date());
//                                console.log(timestamp / 1000);
//                                $('[name=ResponseTime]').val(timestamp / 1000);
//                                if ($("[name='xzReviewTime']").val() != "" && $("[name='xzReviewTime']").val() != undefined) {
//                                    var timestamp = new Date($("[name='xzReviewTime']").val() + " " + s + ":" + f + ":" + m);
//                                    $("[name='xzReviewTime']").val(timestamp / 1000);
//                                }
                                console.log(timestamp / 1000);
                                $('[name=xzReviewTime]').val(timestamp / 1000);

                            })
                            //系统时间获取   李铭修改
                            function datetime() {
		 var now = new Date();
		 document.getElementById("time").value = now.getFullYear() + "-"
		 + (now.getMonth() + 1) + "-" + now.getDate();
		 document.getElementById("time").value += " " + now.getHours() + ":"
		 + now.getMinutes() + ":" + now.getSeconds();
		 }
		 window.setInterval("datetime()", 1000);
        </script>
        <script>

            //单选多选赋值
            var json = {};
            json.reviewopinion =<% out.print(entity.get("reviewopinion"));%>
            json.permission =<% out.print(entity.get("permission"));%>
            json.sugformation =<% out.print(entity.get("sugformation"));%>
            json.sugyears =<% out.print(entity.get("sugyears"));%>
            json.communicate =<% out.print(entity.get("communicate"));%>
            json.written =<% out.print(entity.get("written"));%>
            json.handle =<% out.print(entity.get("handle"));%>
            $.each(json, function (k, v) {
                $("input[name='" + k + "']").val(v);
                if (k == "written" || k == "communicate") {
                    if (v == "1") {
                        $("input[name='" + k + "']").parent().find("input").eq(0).click();
                    }
                } else {
                    var ind = parseInt(v) - 1
//                    console.log(v + "+" + ind)
                    $("input[name='" + k + "']").parent().find("label").eq(ind).click();
                }
            })
            //办理单位,联系人,联名人赋值
            $(".footer>button").click(function () {
                
                //梁小竹修改
                if($(".shencha").length > 0){
                    if($("#jyscr>li").length <= 0){
//                        alert("请选择审查人员");
                    let text = "请选择审查人员";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                    popuplayer.display( window.location.href='/showalert.jsp?text ='+encodeURI(encodeURI(text)), '提示', {width: 300, height: 100});
                        return false;
                    }
                }
                
                /*
                 * 梁小竹修改
                 * 修复联名人可以多次添加同一个人并提交的bug
                 * @type Date
                 */
                var mid = new Map();
                //做一个标志位，循环里面return false没有用，要在外面return false才不会提交
                var flog = 0;
                //选中所有的多选框
                $("#blfyr>li").each(function () {
//                    alert("1");
                    let lii = $(this);
                    let val = lii.attr("myid");
                    if(mid.get(val)){  
//                        说明联名人有重复
//                        alert("有");
//let text = "有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                        flog = 1;
//                        lii.remove();
//                        return false;
                    }else{
//                        说明联名人没有重复
//                        alert("没有");
//let text = "没有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                        mid.set(val,1);
                    }
                });
                if(flog === 1){
//                    alert("建议联名人有重复，已为您自动删除重复人员，请查看无误后再次提交");
                    let text = "附议人有重复，已为您自动删除重复人员，请查看无误后再次提交";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    return false;
                }
                /*
                 * 梁小竹修改结束
                 */




                var date = new Date;
                var year = date.getFullYear();
                var mydate = year.toString();
//                console.log(mydate);
                $('[name=year]').val(mydate);

                var timestamp = Date.parse(new Date());
//                console.log(timestamp / 1000);
                $('[name=ProposedBill]').val(timestamp / 1000);
                $('[name=draft]').val("2");
//                alert($('[name=draft]').val());
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
//                        alert("请填写完整数据")
                        let text = "请填写完整数据";
                        popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
                        return false;
                    }
                })
//                console.log($("#suggesttype select").val());

                if ($("#level option:selected").attr("circles") == 2) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 1)
                } else if ($("#level option:selected").attr("circles") == 3) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 2)
                } else if ($("#level option:selected").attr("circles") == 4) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 3)
                } else {
                    $("input[name='level']").val($("#level option:selected").attr("circles"))
                }
                if ($("#suggesttype select").val() == 2) {//如果选的类型为议案
                    if ($("#blfyr>li").length < 11) {//因为列名也占了一行
//                        alert("议案的联名人数得大于等于10人");
                        let text = "议案的附议人数得大于等于10人";
                        popuplayer.display("/showalert.jsp?text=" + text, '提示', {width: 300, height: 100});
                        return false;
                    }
                }
                var secound = [], secoundsp = "", contacts = [], contactsp = "", usercomp = [], usercompsp = "", scr = [], scrsp = "";
                $("#blfyr>li").each(function () {
                    secound.push($(this).attr("myid"));
                })
                $("#jylxr>li").each(function () {
                    contacts.push($(this).attr("myid"));
                })
                $("#bldw>li").each(function () {
                    usercomp.push($(this).attr("myid"));
                })
                scr.push($("#scrid").attr("myid"));
                secoundsp = secound.join(",");
                contactsp = contacts.join(",");
                usercompsp = usercomp.join(",");
                scrsp = scr.join(",");
                $("input[name='secound']").val(secoundsp);
                $("input[name='contacts']").val(contactsp);
                $("input[name='usercomp']").val(usercompsp);
                $("input[name='scr']").val(scrsp);
                $("input[name='numpeople']").val($("#blfyr>li").length);
                var enc = $("#enclosure1").val() + "," + $("#enclosure2").val() + "," + $("#enclosure3").val()
                var enc1 = $("#enclosure11").val() + "," + $("#enclosure22").val() + "," + $("#enclosure33").val()
                $("input[name='enclosure']").val(enc);
                $("input[name='fileName']").val(enc1);
                $("[selradio]").each(function () {
                    var num = $(this).find("input:checked").parent().index() + 1;
                    $(this).find("input[type='hidden']").val(num);
                })
                $("[selbox]").each(function () {
                    if ($(this).is(":checked")) {
                        $(this).parent().find("input[type='hidden']").val("1")
                    } else {
                        $(this).parent().find("input[type='hidden']").val("2")
                    }
                })
//                var matter = UE.getEditor('matter').getContent();
//                for (var i = 0; i < MGC.length; i++) {
//                    if (matter.indexOf(MGC[i]) > 1) {
//                        alert("发表内容包含敏感词");
//                        return false;
//                    }
//                }
            })//$(".footer>button").click(function () {
            $(".cellbor").click(function () {
                $("#dblist").hide();
            })
            //上传附件
            $("span[rid]").click(function () {
                var rid = $(this).attr("rid")
                $("#file" + rid).click();
            })
            
           
            $("#suggesttype select").change(function () {//选择了类别//added by jackie
                var v_type = '';
                if ($("#suggesttype select").val() == 2) {//如果选择了议案类别
                    v_type = 'editya';
                } else {
                    v_type = 'edit';
                }
                // alert(v_type);
                self.location = "/bill/" + v_type + ".jsp";
                return false;
            })
            $('.selectscr').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.linkman + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser.jsp", 700, 650);
            });
            $('.selectuser').click(function () {
                var t = $(this).parents("tr").find("ul");
//                console.log(t)
                RssWin.onwinreceivemsg = function (dict) {
//                    console.log(dict);
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 16.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em><em style='inline block;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.telphone + "</em><em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.daibiaoDWaddress + "</em><em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.code + "</em><em class='blue'>删除</em></li>")
                            //t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>" + v.realname +"</em><em style='inline block;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.code+"</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.homeaddress+ "</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.telphone+ "</em><em class='red'>删除</em></li>")
                            //t.append("<li myid='" + v.myid + "'><em style='margin-left: 10px;'>&nbsp;" + v.realname + "</em><em style='margin-left: 85px;'>&nbsp;"+v.code+"</em><em style='margin-left: 200px;'>&nbsp;"+v.homeaddress+"</em><em style='margin-left: 85px;'>&nbsp;"+v.telphone+"</em><em class='red'>删除</em></li>")
                            // t.append("<li style='border: 1px #dce6f5 solid;margin-top: 2px;' myid='" + v.myid + "'>" +v.realname +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.code + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.homeaddress +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.telphone +"<em class='red'>删除</em></li>")
                        }
                    })
                    // t.find("em").off("click").click(function () {
                    $('.blue').click(function () {
                        $(this).parent().remove();
                    })
                }
            });
            $('.selectcompany').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 700, 650);
            });
            $("li").find(".red").off("click").click(function () {
                $(this).parent().remove();
            })
            

            $('.selectscr22').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_p7.jsp", 700, 650);
            });
            $('.selectscra22').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='xzscID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_1_1.jsp", 700, 650);
            });
            var one ;
            $(".yi").val(one)
          $(".ceshi").click(() => {
              if($(".ceshi").is(":checked") == true) {
                  one = "√";
              }else{
                  one = "";
              }
              $(".yi").val(one)
          });
          var er ;
           $(".er").val(er)
           $(".ceshi1").click(() => {
              if($(".ceshi1").is(":checked") == true) {
                  er = "√";
              }else{
                  er = "";
              }
        $(".er").val(er)
             
          });
          var san ;
          $(".san").val(san)
           $(".ceshi2").click(() => {
              if($(".ceshi2").is(":checked") == true) {
                  san = "√";
              }else{
                  san = "";
              }
              $(".san").val(san)
          }); 
          var si ;
          $(".si").val(si)
          $(".ceshi3").click(() => {
              if($(".ceshi3").is(":checked") == true) {
                  si = "√";
              }else{
                  si = "";
              }
              $(".si").val(si)
          }); 
          var wu ;
          $(".wu").val(wu)
          $(".ceshi4").click(() => {
              if($(".ceshi4").is(":checked") == true) {
                  wu = "√";
              }else{
                  wu = "";
              }
              $(".wu").val(wu)
          });
          
          
        </script>
        <!--正则-->
        <script>
            function checkPhone(){ 
                var phone = $(".dianhua").val()
                var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
                if(!phone){ 
//                        alert("手机号码有误，请重填");  
                         popuplayer.display("/showalert.jsp?text=" + "输入为空", '提示', {width: 300, height: 100});
                         return false; 
                 } else if(!(myreg.test(phone))) {
                         popuplayer.display("/showalert.jsp?text=" + "输入有误", '提示', {width: 300, height: 100});
                         return false; 
                 }
            }
            
             $("#submit").click(function () {
                                $("#abc").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                         if(data.url !== null && "" !== data.url){
                                        console.log(data)
                                        $("#minhead>img").attr("src", "/upfile/" + data.url);
                                        $("#ico").val(data.url);
                                        alert("上传成功");
                                        $("#upfiletype").text("(成功上传)")
                                         } else {
                                        alert("未上传");
                                        $("#upfiletype").text("(未上传)")  
                                    }
                                    }});
                                return false;
                            })
                            $('#pbut').click(function () {
                                $("#submit").click();
                            })
                            
                            $("#selbut").click(function () {
                                $("#file").click();
                            })
                            
                            
                             $(".submit").click(function () {
                                $(".abc").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        console.log(data)
                                         if(data.url !== null && "" !== data.url){
                                        $("#minhead>img").attr("src", "/upfile/" + data.url);
                                        $(".ico").val(data.url);
                                        alert("上传成功");
                                        $(".upfiletype").text("(成功上传)")
                                         } else {
                                        alert("未上传");
                                        $("#upfiletype").text("(未上传)")  
                                    }
                                    }});
                                return false;
                            })
                            $('.pbut').click(function () {
                                $(".submit").click();
                            })
                            
                            $(".selbut").click(function () {
                                $(".file").click();
                            })
        </script>
    </body>
</html>