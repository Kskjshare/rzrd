<%@page import="java.util.Calendar"%>
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
    RssList entity = new RssList(pageContext, "question_bank");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity.keymyid(cookie.Get("myid"));
//                entity.timestamp();//添加当前时间到数据库
//                entity.append().submit();
                break;
            case "update":
//                entity.remove("legislativeId");
//                entity.update().where("id=?", entity.get("legislativeId")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();//刷新查询页
        PoPupHelper.adapter(out).showSucceed();
    }
//    entity.select().where("id=?", entity.get("legislativeId")).get_first_rows();

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


        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>

        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td colspan="4" class="institle dce">添加题库</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考题类别：<em class="red">*</em></td>
<!--                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>-->
                        <td><select style="width:100%;border: none;" class="w260" name="questionCategory" dict-select="questionCategory1"  def="<% entity.write("type"); %>"></select>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考题类型</td>
                        <td><select style="width:100%;border: none;" class="w260" name="questiontype" dict-select="questionType1" def="<% entity.write("questiontype"); %>"></select>
                    </tr>
                    <tr>
                        <td class="dce w100 ">题目：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
    <!-- 单选 -->
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项1：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="alright"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项2：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="alright"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项2：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="alright"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class="duoyu2">
                        <td class="dce w100 ">选项2：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="alright"/>&nbsp;</span><input type="text" maxlength="80" class="b95" name="d" value="<% entity.write("d"); %>" /></td>
                    </tr>
     <!-- 多选 -->
                    <tr class="Duo">
                        <td class="dce w100 ">选项A：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="a" value="<% entity.write("a"); %>" /></td>
                    </tr>
                    <tr class="Duo">
                        <td class="dce w100 ">选项B：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="b" value="<% entity.write("b"); %>" /></td>
                    </tr>
                    <tr class="Duo">
                        <td class="dce w100 ">选项C：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="c" value="<% entity.write("c"); %>" /></td>
                    </tr>
                    <tr class="Duo">
                        <td class="dce w100 ">选项D：<em class="red">*</em></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="d" value="<% entity.write("d"); %>" /></td>
                    </tr>
                    <tr class=".zengjia Duo" style="text-align: center;"> 
                        <td class=".zengjia1" colspan="2" style="color:blue;font-size: 15px;font-weight: bold;  cursor:pointer; width: 50%;">增加选项</td>
                        <td class=".zengjia1" colspan="2" style="color:blue;font-size: 15px;font-weight: bold;  cursor:pointer;  width: 50%;">删除选项</td>
                    </tr>
    <!-- 判断 -->   
                    <tr class="ISTure">
                        <td class="dce w100 ">选项A：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="alright"/>&nbsp;</span> 正确</td>
                    </tr>
                    <tr class="ISTure">
                        <td class="dce w100 ">选项B：<em class="red">*</em></td>
                        <td colspan="3"><span>&nbsp;<input type="radio" name="alright"/>&nbsp;</span> 错误</td>
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
            $(function(){
            $(".Duo").hide()
            $(".ISTure").hide()
            $("[name='questiontype']").change(function () {
            
            var iteValue = $("[name='questiontype']").val();
            console.log(iteValue)
                if(iteValue==1){
                    $(".Duo").hide()
                    $(".ISTure").hide()
                    $(".duoyu2").show()
                }else if(iteValue==2){
                     $(".duoyu2").hide()
                     $(".ISTure").hide()
                     $(".Duo").show()
                }else{
                    $(".duoyu2").hide()
                    $(".Duo").hide()
                     $(".ISTure").show()
                }
            
            });
            });

              


        </script>
    </body>
</html>
