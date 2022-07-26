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
<%@page import="java.net.URLDecoder"%>

<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();

    RssList entity = new RssList(pageContext, "constituency_classify");  
    entity.request();
    CookieHelper cookie = new CookieHelper(request, response);

    if (!entity.get("action").isEmpty()) {
       
        switch (entity.get("action")) {
            case "append":
            
//                entity.keymyid(cookie.Get("myid"));
//                entity.timestamp();
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
                  
          
                    <tr>
                        <td class="tr w100 ">选区名称</td>
                        <td colspan="3"><input type="text" maxlength="80" class="w656" name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                   
 
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "确认" : "修改");%></button>
            </div>
        </form>
        <script src="../data/partytype.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <!--<script src="/data/session.js"></script>-->
        <!--<script src="/data/staff.js"></script>-->
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
//                if ($("[name='birthday']").val() == undefined || $("[name='birthday']").val() == "") {
//                    alert("请填写出生日期");
//                    $("[name='birthday']").focus();
//                    return false;
//                } 
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
               
                timestamp = new Date($("[name='appointshijian']").val());
                $("[name='appointshijian']").val(timestamp / 1000);
 
            })

            function PreviewImage(fileObj, imgPreviewId, divPreviewId) {
               
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
