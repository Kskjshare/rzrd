<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
 <%@page import="java.net.URLDecoder"%>
 <%@page import="RssEasy.Core.CookieHelper"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssListView entity = new RssListView(pageContext, "workdynamics");
    entity.request();
    
    RssList entity2 = new RssList(pageContext, "workdynamics");
    entity2.request();
    entity2.select().where("id=?", req.get("id") ).get_first_rows();

    
    //ding
    RssList stationcontent = new RssList(pageContext, "stationcontent");
    stationcontent.request();

    RssList contactstation_sub = new RssList(pageContext, "contactstation_sub");
    contactstation_sub.request();
    contactstation_sub.select().where("myid=?", UserList.MyID(request)).get_first_rows();


    
     RssList listContactstation_sub = new RssList(pageContext, "contactstation_sub");
     listContactstation_sub.request();         
     listContactstation_sub.pagesize = 100;
     listContactstation_sub.select().where("1=1").get_page_desc("id");
 
    
    if (!entity2.get("action").isEmpty()) {
        switch (entity2.get("action")) {
            case "append":

                //added begin
                RssList userlist = new RssList(pageContext, "user");
                userlist.request();           
               
                //判断是否是 站长或者联络员
                boolean appendCheck = true ;
                //out.print("<script>alert('aaaaa')</script>");
                while ( listContactstation_sub.for_in_rows()) {
                    appendCheck = true ;
                    userlist.select().where("telphone like '%" + URLDecoder.decode( listContactstation_sub.get("mastertelephone"), "utf-8") + "%'").get_first_rows( );
                    //userlist.select().where("telphone=" +listContactstation_sub.get("mastertelephone")).get_first_rows( );
                    
                    if ( userlist.get("myid").equals( UserList.MyID(request) ) ) {
                         appendCheck = true ;
                         //out.print("<script>alert('aaaaa')</script>");
                         break;
                    }
                    else {
                        appendCheck = false ;                      
                        userlist.select().where("telphone like '%" + URLDecoder.decode( listContactstation_sub.get("linkmantelephone"), "utf-8") + "%'").get_first_rows();
                        //userlist.select().where("telphone=" +listContactstation_sub.get("linkmantelephone")).get_first_rows( );
                        if ( userlist.get("myid").equals( UserList.MyID(request) ) ) {
                            appendCheck = true ;
                            //out.print("<script>alert('cccc')</script>");
                            break;
                        }
                    }
                }
                              
                //added end

            if ( appendCheck ) {   
                entity2.timestamp();
                List<String> imageSrcList = new ArrayList<String>();
                Pattern p = Pattern.compile("<img\\b[^>]*\\bsrc\\b\\s*=\\s*('|\")?([^'\"\n\r\f>]+(\\.jpg|\\.bmp|\\.eps|\\.gif|\\.mif|\\.miff|\\.png|\\.tif|\\.tiff|\\.svg|\\.wmf|\\.jpe|\\.jpeg|\\.dib|\\.ico|\\.tga|\\.cut|\\.pic)\\b)[^>]*>", Pattern.CASE_INSENSITIVE);
                Matcher m = p.matcher(entity2.get("matter"));
                String quote = null;
                String src = null;
                while (m.find()) {
                    quote = m.group(1);
                    src = (quote == null || quote.trim().length() == 0) ? m.group(2).split("\\s+")[0] : m.group(2);
                    imageSrcList.add(src);
                }
                if(imageSrcList != null && !imageSrcList.isEmpty()){
                entity2.keyvalue("ico", imageSrcList.get(0));
                }
                

                entity2.keymyid(UserList.MyID(request));
                entity2.keyvalue("ico", entity.get("ico")); 
                entity2.keyvalue("stationid", contactstation_sub.get("stationid")); 
                entity2.append().submit();
                
                
                //ding
                stationcontent.keymyid(UserList.MyID(request));

                stationcontent.keyvalue("title", entity.get("title"));
                stationcontent.keyvalue("matter", entity.get("matter"));
                stationcontent.timestamp();
                stationcontent.keyvalue("classify", entity.get("classify"));
//                stationcontent.keyvalue("myid", entity.get("myid"));  
                stationcontent.keyvalue("myid", UserList.MyID(request ));  


                stationcontent.keyvalue("ico", entity.get("ico")); 
                stationcontent.keyvalue("stationid", contactstation_sub.get("stationid")); 
                stationcontent.keyvalue("relationid", entity.autoid ); 
                stationcontent.append().submit();
            }
            else {
                
            }
                               
                break;
            case "update":    
                //out.print("<script>alert('update')</script>");
//                entity.remove("id");
//                entity.remove("myid");
//                entity.remove("shijian");
//                entity2.remove("id,myid");
               
                
                entity2.keyvalue("state", entity.get("state")); 
                entity2.keyvalue("stationid", entity.get("stationid")); 
                entity2.keyvalue("classify", entity.get("classify"));  
                entity2.keyvalue("matter", entity.get("matter")); 
//                entity2.keyvalue("shijian", entity.get("shijian")); 
                entity2.keyvalue("title", entity.get("title")); 
                entity2.keyvalue("enclosure", entity.get("enclosure")); 
//                entity2.keyvalue("matter", entity.get("matter")); 

                entity2.keyvalue("ico", entity.get("ico")); 

                entity2.update().where("id=?", req.get("id")).submit();
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
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 740px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            #edui2{width: 100%;line-height: 14px}
            
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;}
            .w630{width:630px;}
            
            #abc{position: absolute;left: -10000px;} #headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }
        </style>
    </head>
    <body>
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

                    <tr><td class="dce w120 ">标题图片</td><td colspan="3" id="headimg">                          
                            <div id="divPreview"><img id="imgHeadPhoto" src="<% out.print(entity.get("ico").isEmpty() ? "/upfile/avatar.png" : "/upfile/" + entity.get("ico")); %>"></div>
                            <p id="selbut">选择图片</p><p id="pbut">上传图片</p><span id="upfiletype">(未上传)</span>
                            <input type="hidden" name="ico" id="avatar" value="<% entity.write("ico");%>">
                        </td></tr>
                    <tr>

                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w630" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">分类</td>
                        <td><select class="w250" name="classify" dict-select="dynamicclass" def="<% entity.write("classify"); %>"></select></td>
                        <td class="dce w100 ">是否发布</td>
                        <td><select class="w250" name="state" dict-select="noticestate" def="<% entity.write("state"); %>"></select></td>
                    </tr>
<!--                    <tr>
                        <td class="dce w100 ">发布者：</td>
                        <td><% entity.write("realname"); %></td>
                        <td class="dce w100 ">录入日期：</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr>
                        <td class="dce w100 " colspan="4"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspanbgmjhv="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="myid" class="w50" value="<% out.print(!entity.get("myid").isEmpty()?entity.get("myid"):UserList.MyID(request)); %>" />              
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
           
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        
        
         <script>
            function PreviewImage(fileObj, imgPreviewId, divPreviewId) {
                                var allowExtention = ".jpg,.bmp,.gif,.png,.jpeg"; //�����ϴ��ļ��ĺ�׺��document.getElementById("hfAllowPicSuffix").value;
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
//                                        $("#minhead>img").attr("src", "/upfile/" + data.url);
                                        $("#avatar").val(data.url);
                                        
//                                        $("input[name='ico']").val( data.url );
                                        alert(data.url);
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
