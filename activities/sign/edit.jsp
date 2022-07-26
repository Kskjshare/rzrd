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
    RssList entity2 = new RssList(pageContext, "activities");
    RssList user = new RssList(pageContext, "activities_userlist");
    RssList user2 = new RssList(pageContext, "activities_userlist");
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();
    entity2.request();
    if (entity2.get("action").equals("append")) {
        String str = entity2.get("userid");
        String[] arry = str.split(",");
        String str2 = entity2.get("unuserid");
        String[] arry2 = str2.split(",");
        user.delete().where("activitiesid=" + entity.get("id")).submit();
        for (int i = 0; i < arry.length; i++) {
            user.timestamp();
            user.keyvalue("activitiesid", entity.get("id"));
            user.keyvalue("userid", arry[i]);
            user.keyvalue("jointype", "2");
            user.keyvalue("myid", entity2.get("myid"));
            user.append().submit();
        }
        for (int i = 0; i < arry2.length; i++) {
            user2.timestamp();
            user2.keyvalue("activitiesid", entity.get("id"));
            user2.keyvalue("userid", arry2[i]);
            user2.keyvalue("jointype", "1");
            user2.keyvalue("myid", entity2.get("myid"));
            user2.append().submit();
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
            .cellbor{border: 0}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{line-height: 34px;position: relative;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{
/*                position: absolute;top: 10px;left: 6px;*/
                line-height:50px;
            }
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #unseluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td>
                            <% entity.write("title"); %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动类型</td>
                        <td>
                            <select class="w250" name="classify" dict-select="activitiestypeclassify" def="<% entity.write("classify"); %>">
                            </select>
                        </td>
                    </tr>
                    
                     <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td>
                            <% entity.write("place"); %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td>
                           
                            <% entity.write("department"); %>
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="dce" style="width:110px;">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd" >
                            <input type="text" class="w200 Wdate" name="endshijian"  rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" >
                            <input type="text" class="w200 Wdate" name="beginshijian"  rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" >
                            <input type="text" class="w200 Wdate" name="shijian"  rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                   
                    <tr>
                        <td class="dce w100 ">未报名代表</td>
                        <td id="unseluserlist">
                            <em id="sdsign">点击手动报名</em>
                            <%
                                CookieHelper cookie = new CookieHelper(request, response);
                                RssListView entity4 = new RssListView(pageContext, "activities_realname");
                                if (cookie.Get("powergroupid").equals("5")) {
                                    entity4.select().where("activitiesid=" + entity.get("id") + " and jointype=1 and userid=" + UserList.MyID(request)).query();
                                } else {
                                    entity4.select().where("activitiesid=" + entity.get("id") + " and jointype=1").query();
                                }
                                while (entity4.for_in_rows()) {

                            %>
                            <em myid='<% out.print(entity4.get("userid"));%>'><input type="checkbox"><% out.print(entity4.get("realname"));%></em>
                                <%
                                    }
                                %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">已报名代表</td>
                        <td id="seluserlist">
                            <%
                                RssListView entity3 = new RssListView(pageContext, "activities_realname");
                                if (cookie.Get("powergroupid").equals("5")) {
                                    entity3.select().where("activitiesid=" + entity.get("id") + " and jointype=2 and userid=" + UserList.MyID(request)).query();
                                } else {
                                    entity3.select().where("activitiesid=" + entity.get("id") + " and jointype=2").query();
                                }
                                while (entity3.for_in_rows()) {
                                    if (cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16")) {
                                    }
                            %>
                            <em myid='<% out.print(entity3.get("userid"));%>'><% out.print(entity3.get("realname"));%><i>×</i></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 left"><span>活动安排</span></td>
                        <td class="textareadiv"><% entity.write("note"); %></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" id="rid" name="userid" value="">
                <input type="hidden" id="unrid" name="unuserid" value="">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <script>

                            $("#sdsign").click(function () {
                                if ($("#unseluserlist input:checked").length == "0") {
                                    alert("请选择要添加的代表")
                                }
                                $("#unseluserlist input:checked").each(function () {
                                    var rid = $(this).parent().attr("myid");
                                    var rname = $(this).parent().text();
                                    $(this).parent().remove();
                                    $("#seluserlist").append("<em myid='" + rid + "'>" + rname + "<i>×</i></em>")
                                })
                                emremove();
                            })
                            emremove();
                            function emremove() {
                                $("#seluserlist i").off("click").click(function () {
                                    var rid = $(this).parent().attr("myid");
                                    var rname = $(this).parent().text().split("×");
//                                    rname = substr("0",rname.length-1);
                                    $("#unseluserlist").append("<em myid='" + rid + "'><input type='checkbox'>" + rname[0] + "</em>")
                                    $(this).parent().remove();
                                })
                            }
                            $(".footer button").click(function () {
                                var arry = [], arry2 = [];
                                $("#seluserlist>em[myid]").each(function () {
                                    arry.push($(this).attr("myid"))
                                })
                                $("#unseluserlist>em[myid]").each(function () {
                                    arry2.push($(this).attr("myid"))
                                })
                                var str = arry.join(",");
                                var str2 = arry2.join(",");
                                $("#rid").val(str);
                                $("#unrid").val(str2);
//                                $(".Wdate").each(function () {
//                                    if ($(this).val() != undefined && $(this).val() != "") {
//                                        var timestamp = new Date($(this).val());
//                                        $(this).val(timestamp / 1000);
//                                    }
//                                })
                            })
        </script>
    </body>
</html>
