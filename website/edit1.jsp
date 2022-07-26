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
    RssList entity = new RssList(pageContext, "releasum");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    
    
    //强行把要闻记录插入到通知表格
    RssList newinformation = new RssList(pageContext, "newinformation");
    newinformation.request();
    RssList notify_messages = new RssList(pageContext, "notify_messages");
    notify_messages.request();
    newinformation.select().where("id=?", newinformation.get("id")).get_first_rows();
    notify_messages.select().where("id=?", notify_messages.get("id")).get_first_rows();
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity.keymyid(cookie.Get("myid"));
//                entity.timestamp();
                entity.append().submit();
                
                //为了处理把网站发布的人大要闻添加到通知公告
                //第一步：先读出刚添加的记录
                RssList entity1 = new RssList(pageContext, "releasum");
                entity1.request();
                entity1.select().where("id=?", entity1.get("id")).get_first_rows();
                //判断是否是人大要闻
                if ( entity1.get("newsid").equals("1") ){
                    
                    newinformation.timestamp();
                    newinformation.remove( "classifyid", "meetid", "keywords", "summary", "ico", "picture", "organize", "leader", "enclosure", "enclosurename", "publiclassifyid", "typeid", "newsid", "origin", "classification");                                  
                    newinformation.keyvalue( "title" , entity1.get("title") );
                    newinformation.keyvalue( "isFromwebsite" , "1" );
                    newinformation.keyvalue( "infotype" , 3 );
                    newinformation.keyvalue( "myid" , UserList.MyID(request) ); 
                    newinformation.keyvalue( "matter" , entity1.get("matter") ); 
                    newinformation.keyvalue( "relationid" , entity.autoid ); 

                    newinformation.append().submit();
                    
                    
                    notify_messages.timestamp();
                    notify_messages.remove("relationid", "classifyid", "meetid", "keywords", "summary", "ico", "picture", "organize", "leader", "enclosure", "enclosurename", "publiclassifyid", "typeid", "newsid", "origin", "classification");                                  
                    notify_messages.keyvalue( "title" , entity1.get("title") );
                    notify_messages.keyvalue( "isFromwebsite" , "1" );
                    notify_messages.keyvalue( "infotype" , 3 );
                    notify_messages.keyvalue( "relationid" , newinformation.autoid );

                    
                    notify_messages.keyvalue( "myid" , UserList.MyID(request) ); 
                    notify_messages.keyvalue( "matter" , entity1.get("matter") ); 
                    notify_messages.append().submit();
                    
                    
                }
                
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
            .cellbor textarea{height: 205px;margin-top: 5px;width: 98%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b99{width:99%;}
            
            
            .w960 { width: 1198px; }
            
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
<!--        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>-->
        <form id="abc" enctype="multipart/form-data" method="post">  
            <input size="20" onchange="PreviewImage(this, 'imgHeadPhoto', 'divPreview')" type="file" id="file" name="file" multiple>
            <input id="submit" type="submit"/>  
        </form> 

        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
<!--                    <tr>
                        <td colspan="4" class="institle dce">信息处理</td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">标题<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b99" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    
                    <tr><td class="dce w100 ">图片</td>
                        <td colspan="3" id="headimg">
                            <div id="divPreview"><img id="imgHeadPhoto" src="/upfile/<% entity.write("ico"); %>"></div>
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="ico" id="ico" value="<% entity.write("ico"); %>">
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <td class="dce w100 ">分类<em class="red">*</em></td>
                        <td><select class="b99 classify" name="classifyid" dict-select="releasumclassifys" def="1"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">是否发布</td>
                        <td><select class="b99" name="state" dict-select="releasumstate" def="1"></select></td>
                        
                        <td class="dce w100 mettcls">新闻分类</td>
                        <td class="mettcls"><select class="b99" name="newsid" dict-select="newsid" def="<% entity.write("newsid"); %>"></select></td>                      
                        
                    </tr>
                    
                     <tr>
                        <td class="dce" style="width:110px;">发布时间</td>
                        <td><input type="text" class="b99 Wdate" name="shijian"  rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                        
                        <td class="dce w100 mettcls">新闻来源</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b99" name="origin" value="<% entity.write("origin"); %>" /></td>
                     </tr>
                    
<!--                    <tr>
                        <td class="dce w100 mettcls">会议分类：</td>
                        <td class="mettcls"><select class="w250" name="meetid" dict-select="releasummeetid" def="<% entity.write("meetid"); %>"></select></td>
                        <td class="dce w100 offpu">刊号：<em class="red">*</em></td>
                        <td class="offpu"><input type="text" maxlength="180" class="w254" name="organize" value="<% entity.write("organize"); %>" /></td>
                        
                    </tr>-->

                   
                    
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:480" id="matter" name="matter" class="w960"  type="text/plain"><% entity.write("matter"); %></script></td>
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
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                }
                
                   if ($("[name='shijian']").val() == undefined || $("[name='shijian']").val() == "") {
                        alert("请填写新闻发布时间");
                        $("[name='shijian']").focus();
                        return false;
                    }
                    if ($("[name='shijian']").val() != undefined && $("[name='shijian']").val() != "") {
                        var timestamp = new Date($("[name='shijian']").val());
                        $("[name='shijian']").val(timestamp / 1000);
                    }    
                    
                    
//                if ($("[name='organize']").val() == undefined || $("[name='organize']").val() == "") {
//                    alert("请填写刊号");
//                    $("[name='organize']").focus();
//                    return false;
//                }

                if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
                    var timestamp = new Date($("[name='meetingshijian']").val());
                    $("[name='meetingshijian']").val(timestamp / 1000);
                }
            })


            $("#fjfile").click(function () {
                $("#filee").click();
            })
            $("#filee").change(function () {
                var str = $(this).val(); //开始获取文件名
                var filename = str.substring(str.lastIndexOf("\\") + 1);
                $("#fileeform").ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#fjfile").text(filename)
                        $("input[name='enclosure']").val(data.url);
                        $("input[name='enclosurename']").val(filename);
                        alert("上传成功");
                    }});
                return false;
            })
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
                            
                            
//                    $(".offpu").hide()
//                    $(".mettcls").hide()
//            $(".classify").bind("change",function(){
//                if($(this).val() == 3){
//                    $(".mettcls").show()
//                }else{
//                    $(".mettcls").hide()
//                }
//                if($(this).val() == 13){
//                    $(".offpu").show()
//                }else{
//                    $(".offpu").hide()
//                }
//            })
                    
        </script>
    </body>
</html>
