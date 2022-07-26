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
    RssList entity = new RssList(pageContext, "question_exam");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keyvalue("title",entity.get("title"));
                entity.keyvalue("beginTime",entity.get("beginTime"));
                entity.keyvalue("examTime",entity.get("examTime"));
                entity.keyvalue("examAddress",entity.get("examAddress"));
                entity.append().submit();
                break;
            case "update":
                entity.keyvalue("title",entity.get("title"));
                entity.keyvalue("beginTime",entity.get("beginTime"));
                entity.keyvalue("examTime",entity.get("examTime"));
                entity.keyvalue("examAddress",entity.get("examAddress"));
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();//刷新查询页
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", req.get("id")).get_first_rows();

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
                        <td class="dce w100 ">标题：</td>
                        <td><input type="text" maxlength="80" class="b95" name="title" value="<% entity.write("title"); %>" /></td>
<!--                         <td><select style="width:100%;border: none;" class="w260" name="title" dict-select="category"  def="<% entity.write("title"); %>"></select></td>-->
                    </tr>
                    <tr>
                        <td class="dce w100 ">开考时间：</td>
                         <!--<td rssdate="<% out.print(entity.get("beginTime")); %>,yyyy-MM-dd hh:mm:ss"></td>-->
                        <td><input type="text" class="w200 Wdate" name="beginTime"  rssdate="<% out.print(entity.get("beginTime")); %>,yyyy-MM-dd HH:mm"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd HH:mm'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">考试时长：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="examTime" value="<% entity.write("examTime"); %>" /></td>
                    </tr>
                    <tr >
                        <td class="dce w100 ">考试地点：</td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="examAddress" value="<% entity.write("examAddress"); %>" /></td>
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
                                if ($("[name='beginTime']").val() == undefined || $("[name='beginTime']").val() == "") {
                                    alert("请选择考试时间");
                                    $("[name='beginTime']").focus();
                                    return false;
                                }
                                if ($("[name='examTime']").val() == undefined || $("[name='examTime']").val() == "") {
                                    alert("请填写考试时长");
                                    $("[name='examTime']").focus();
                                    return false;
                                }
                                if ($("[name='examAddress']").val() == undefined || $("[name='examAddress']").val() == "") {
                                    alert("请填写考试地址");
                                    $("[name='examAddress']").focus();
                                    return false;
                                }
                                  $(".Wdate").each(function () {
                                    if ($(this).val() != undefined && $(this).val() != "") {
                                        var timestamp = new Date($(this).val());
                                        $(this).val(timestamp / 1000);
                                    }
                                })
                            })
                          


        </script>
    </body>
</html>
