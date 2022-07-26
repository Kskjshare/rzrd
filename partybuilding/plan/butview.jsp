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
<%@page import="RssEasy.Core.CookieHelper"%>

<%
    StaffList.IsLogin(request, response);
  
    RssList entity = new RssList(pageContext, "party_member");  
    entity.request();
    CookieHelper cookie = new CookieHelper(request, response);

    if (!entity.get("action").isEmpty()) {
       
        switch (entity.get("action")) {
            case "append":
            
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":


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
        <title>汝州市人大代表履职服务平台</title>
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
            .w656{width: 649px;}
            /*.w656{width: 100%;}*/
            .borderred{border-color:red; }
            #abc{position: absolute;left: -10000px;}
            td>h1{text-align: center;margin: 20px;}
            .w254{width: 254px;}
            .w260{width: 260px;}
            .w258{width: 258px;}
            .checksel{height: 32px;}
            .checksel>p{min-height: 26px; border: solid 1px #cbcbcb;padding: 0 2px;border-radius: 3px;line-height: 26px;background: #fff;background:url("/css/limg/mnselect.png") no-repeat 245px 10px; }
            /*#sessionlist>p>span{display: block;}*/
            .checksel ul{position: relative;z-index: 9999;display: none;background: #fff;border: #cbcbcb solid 1px;}
            .checksel li{line-height: 32px;font-size: 12px;padding: 0 3px;}
            .popupwrap>div:first-child {
                height: 90%;
            }
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
                    <tr><td>头像</td>
                        <td colspan="3" id="headimg">
                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity.get("avatar").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity.get("avatar")); %>"></div>
                            <!--
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="avatar" id="avatar" value="<% entity.write("avatar");%>">
                            -->
                        </td>
                    </tr>
                    <tr>
                        <td class="tr w100 ">姓名</td>
                        <td><input type="text" maxlength="80" class="w254" name="realname" value="<% entity.write("realname"); %>" readonly="readonly"/></td>
                        <td class="tr w100 ">性别</td>
                        <td><input type="text" maxlength="80" class="w254" name="gender" value="<% 
                            
                                if ( entity.get("sex").equals("2") ) {
                                   out.print( "男" );
                                }
                                else if ( entity.get("sex").equals("3") ) {
                                     out.print( "女" );
                                }
                                else {
                                    out.print( "未知" );
                                }
                         
                            %>" readonly="readonly"/></td>
                        
                    </tr>
                    <tr>
                        <td class="tr w100 ">出生年月</td>
                        <td><input type="text" class="w254 Wdate" name="birthday"  rssdate="<% out.print(entity.get("birthday")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd'})" readonly="readonly"></td>
                        <td class="tr w100 ">民族</td>
                         <td><input type="text" maxlength="80" class="w254" name="nationid" value="<% entity.write("nationid"); %>" readonly="readonly"/></td>

                    </tr>

                   
                    <tr>
                        <td class="tr w100 ">学历</td>
                        <!--<td><select class="w260" name="eduid" dict-select="eduid" def="<% entity.write("eduid"); %>"></select></td>-->
                        
                        <td><input type="text" maxlength="80" class="w254" name="eduid" value="<% 
                            if ( entity.get("eduid").equals("1") ) {
                                   out.print( "小学" );
                                }
                                else if ( entity.get("eduid").equals("2") ) {
                                     out.print( "初中" );
                                }
                                else if ( entity.get("eduid").equals("3") ) {
                                     out.print( "高中" );
                                }
                                else if ( entity.get("eduid").equals("4") ) {
                                     out.print( "大专" );
                                }
                                else if ( entity.get("eduid").equals("5") ) {
                                     out.print( "本科" );
                                }
                                else if ( entity.get("eduid").equals("6") ) {
                                     out.print( "硕士" );
                                }
                                else if ( entity.get("eduid").equals("7") ) {
                                     out.print( "博士" );
                                }
                                else {
                                    out.print( "文盲" );
                                } 
                         
                            %>" readonly="readonly"/></td> 
                        
                        
                        
                        <td class="tr w100 ">类别</td>
                         <td><input type="text" maxlength="80" class="w254" name="membertype" value="<% 
                            if ( entity.get("membertype").equals("0") ) {
                                   out.print( "正式党员" );
                                }
                                else if ( entity.get("membertype").equals("2") ) {
                                     out.print( "预备党员" );
                                }
                                else if ( entity.get("membertype").equals("3") ) {
                                     out.print( "发展对象" );
                                }
                                else if ( entity.get("membertype").equals("4") ) {
                                     out.print( "退党" );
                                }
                               
                         
                            %>" readonly="readonly"/></td>  
                    </tr>                  

                    <tr>
                        <td class="tr w100 ">电子邮箱</td>
                        <td><input type="text" maxlength="80" class="w254" name="email" value="<% entity.write("email"); %>" readonly="readonly"/></td>

                        <td class="tr w100 ">电话号码</td>
                        <td><input type="text" maxlength="80" class="w254" name="telphone" value="<% entity.write("telphone"); %>" readonly="readonly"/></td>
                   
                    </tr>
                   

                    
                    <tr>
                        <td class="tr w100 ">单位名称</td>
                        <td><input type="text" maxlength="80" class="w254" name="unit" value="<% entity.write("unit"); %>" readonly="readonly"/></td>
          
                        <td class="tr w100 ">通讯地址</td>
                        <td><input type="text" maxlength="80" class="w254" name="address" value="<% entity.write("address"); %>" readonly="readonly"/></td>
                    </tr>

                    
                    
                    <tr>
                        <td class="tr w100 ">入党时间</td>
                        <td><input type="text" class="w254 Wdate" name="joinshijian"  rssdate="<% out.print(entity.get("joinshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd'})" readonly="readonly"></td>
                        <td class="tr w100 ">退党时间</td>
                        <td><input type="text" class="w254 Wdate" name="quitshijian"  rssdate="<% out.print(entity.get("quitshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd'})" readonly="readonly"></td>
                    </tr>    
                    
                    
                    
                    <tr class="">
                        <td colspan="4" class="marginauto uetd">
                            <h1>个人履历</h1>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script>
                        </td>
                    </tr>
                </table>
            </div>
<!--            <div class="footer">

            </div>-->
        </form>
        <script src="../data/partytype.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <!--<script src="/data/session.js"></script>-->
        <!--<script src="/data/staff.js"></script>-->
        <script src="/data/partymember.js"></script>
        <script src="/data/constituency.js"></script>

        <%@include  file="/inc/js.html" %>     
        <script>
            var imgresult = $("#divPreview>img").attr("src");
             if (imgresult !== "/upfile/avatar.png") {
                 $("#upfiletype").text("已上传");
             }
             $(".footer>button").click(function () {
                 
//                if ($("[name='realname']").val() == undefined || $("[name='realname']").val() == "") {
//                    alert("请填写姓名");
//                    $("[name='realname']").focus();
//                    return false;
//                } 
                if ($("[name='birthday']").val() == undefined || $("[name='birthday']").val() == "") {
                    alert("请填写出生日期");
                    $("[name='birthday']").focus();
                    return false;
                } 
//                if ($("[name='appointshijian']").val() == undefined || $("[name='appointshijian']").val() == "") {
//                    alert("请填写任免日期");
//                    $("[name='appointshijian']").focus();
//                    return false;
//                } 
//                
               
                
//                if ($("[name='telphone']").val() == undefined || $("[name='telphone']").val() == "") {
//                    alert("请填写电话号码");
//                    $("[name='telphone']").focus();
//                    return false;
//                } else 
//                {
//                    var str = $("[name='telphone']").val()
//                    if (!str.match(/^([0-9]|[._-]){4,19}$/)) {
//                        alert("请填写正确的电话号码");
//                        $("[name='telphone']").focus();
//                        return false;
//                    }
//                }
                
                var timestamp = new Date($("[name='birthday']").val());
                $("[name='birthday']").val(timestamp / 1000);
               
                //timestamp = new Date($("[name='appointshijian']").val());
                //$("[name='appointshijian']").val(timestamp / 1000);
                
                
                if ($("[name='joinshijian']").val() != undefined || $("[name='joinshijian']").val() != "") {
                    var timestamp = new Date($("[name='joinshijian']").val());
                    $("[name='joinshijian']").val(timestamp / 1000);
  
                } 
                
                if ($("[name='quitshijian']").val() != undefined || $("[name='quitshijian']").val() != "") {
                    var timestamp = new Date($("[name='quitshijian']").val());
                    $("[name='quitshijian']").val(timestamp / 1000);
  
                }     
 
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
         
            checksel();
            $(".popupwrap").click(function () {
                $(".checksel").find("ul").hide();
            })


        </script>
    </body>
</html>
