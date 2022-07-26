<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
    RssList entity = new RssList(pageContext, "evaluation_batch");
    RssList standard = new RssList(pageContext, "evaluation_standard");
    RssListView user_delegation = new RssListView(pageContext, "user_delegation");
    RssList scores = new RssList(pageContext, "evaluation_score");
    entity.request();
    if (entity.get("action").equals("append")) {
        entity.timestamp();
        entity.keymyid(UserList.MyID(request));
        entity.append().submit();

        //开始 考核分数表
        user_delegation.select("myid").where("state=2").query();
        while (user_delegation.for_in_rows()) {
            if (!user_delegation.get("myid").isEmpty()) {
                scores.timestamp();
                scores.keymyid(user_delegation.get("myid"));
                scores.keyvalue("batchid", entity.autoid).keyvalue("standardid", entity.get("standardid"));
                scores.append().submit();
            }

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
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            .w630{width:630px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--
                    <tr>
                        <td colspan="4" id="tabheader">计分标准</td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce w100 ">考核名称：</td>
                        <td colspan="2"><input type="text" maxlength="80" class="w250" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>

                    <tr>
                        <td class="dce w100 ">开始时间：</td>
                        <td ><input type="text" class="w250 Wdate" id="beginshijian" name="beginshijian"  rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd HH:mm:ss" onFocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss', startDate: '%y-%M-%d 00:00:00', maxDate: '#F{$dp.$D(\'finishshijian\')}'})" readonly="readonly"></td>
                        <td class="w350 " rowspan="2">考核会在对应的时间自动开始与结束。</td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间：</td>
                        <td><input type="text" class="w250 Wdate" id="finishshijian" name="finishshijian"  rssdate="<% out.print(entity.get("finishshijian")); %>,yyyy-MM-dd hh:mm:ss" onFocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss', startDate: '%y-%M-%d 23:59:59', minDate: '#F{$dp.$D(\'beginshijian\')}'})" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">计分标准</td>
                        <td colspan="2">
                            <select id="level" type="text" name="standardid" class="w400">
                                <%
                                    standard.select("id,title").query();
                                    while (standard.for_in_rows()) {
                                %>
                                <option value="<%standard.write("id");%>"><%standard.write("title");%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" class="red" style="text-align:center"><b>注意：发起考核前请确保上一次考核已经结束。</b></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

                            $(".footer button").click(function () {
                                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                                    alert("请填写名称");
                                    $("[name='title']").focus();
                                    return false;
                                }

                                if ($("[name='beginshijian']").val() == undefined || $("[name='beginshijian']").val() == "") {
                                    alert("请填写开始日期");
                                    $("[name='beginshijian']").focus();
                                    return false;
                                }
                                if ($("[name='finishshijian']").val() == undefined || $("[name='finishshijian']").val() == "") {
                                    alert("请填写结束日期");
                                    $("[name='finishshijian']").focus();
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
