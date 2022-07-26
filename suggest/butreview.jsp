<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
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
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookies = new CookieHelper(request, response);
    RssList list = new RssList(pageContext, "suggest");
    RssListView entity = new RssListView(pageContext, "sort");
    RssList sort = new RssList(pageContext, "sort");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    list.request();
    entity.request();
    if (!list.get("action").isEmpty()) {
        list.remove("id");
        list.remove("realid");
        if (!(cookies.Get("powergroupid").equals("8"))) {
            list.remove("handlestate");
            list.keyvalue("examination", 5);
            list.remove("realcompanyid");
            list.keyvalue("isdbtshenhe", 1);
//            list.keyvalue("fsrID", list.get("fsrID"));
            list.update().where("id=?", req.get("id")).submit();
        } else {
            list.keyvalue("examination", 2);
            //   list.keyvalue("handlestate", 2);
            long shijian = new Date().getTime() / 1000;
            list.keyvalue("scshijian", String.valueOf(shijian));
            list.keyvalue("scid", UserList.MyID(request));
            usercomp.delete().where("suggestid=" + list.get("id") + " and type = 2").submit();
            if (!list.get("realcompanyid").equals(",")) {
                String[] bb = list.get("realcompanyid").split(",");
                for (int i = 0; i < bb.length; i++) {
                    if (!bb[i].isEmpty()) {
                        usercomp.keyvalue("suggestid", list.get("id"));
                        usercomp.keyvalue("companyid", bb[i]);
                        usercomp.keyvalue("type", 2);
                        usercomp.append().submit();
                    }
                }
            }
            list.remove("realcompanyid");
            list.update().where("id=?", entity.get("id")).submit();
        }
        if(!(list.get("realid").isEmpty())){
            sort.keyvalue("realid", list.get("realid"));
            sort.update().where("sortid=?", entity.get("id")).submit();
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
            tr>td .xzz{width: 70%;height: 100%;border: 0px;}
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .sel{background:#dce6f5; }
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            .disnone{display: none}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
                    <tr><td class="w120 dce">序号</td><td class="w261"><% entity.write("lwid"); %></td><td class="w120 dce">层次</td><td class="w261"  circles="<% entity.write("level"); %>"></td></tr>
                    <tr><td class="w120 dce">届次</td><td colspan="3" sessionclassify="<% entity.write("sessionid"); %>"></td></tr>
                    <tr><td class="w120 dce">会议次数</td><td colspan="3" companytypeeeclassify="<% entity.write("meetingnum"); %>"></td></tr>
                    <tr><td class="w120 dce">编号</td><td class="w261">
                            <%
                                if (cookies.Get("powergroupid").equals("8")) {
                            %>
                            <input name="realid" class="yincang" type="text" value="<% entity.write("realid"); %>" >
                            <%
                            } else {
                            %>
                            <% out.print(entity.get("realid")); %>
                            <%
                                }
                            %>
                        </td><td class="w120 dce">提交类型</td><td class="w261" lwstate="<% entity.write("lwstate"); %>"></td></tr>
                    <tr><td class="w120 dce">标题</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">领衔代表</td><td colspan="3"><% entity.write("realname"); %></td></tr>
                    <tr><td class="w120 dce">附件</td><td colspan="3">
                            <%
                                RssList user1 = new RssList(pageContext, "suggest");
                                user1.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                            <input class="xzz" value="<% out.print(arry1[idx]); %>"/><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: red;">点击下载</a>
                            <%
                                    }
                                }
                            %>
                    </tr>
                    <tr><td colspan="4" id="tabheader">建议审查</td></tr>
                    <tr><td class="w120 dce">承办单位</td><td colspan="3">
                            <%-- <%
                                if (!entity.get("id").isEmpty()) {
                                    RssListView usercomplist = new RssListView(pageContext, "suggest_company");
                                    usercomplist.select().where("suggestid=" + entity.get("id") + " and type =1").query();
                                    while (usercomplist.for_in_rows()) {
                            %>
                            <b>"<% out.print(usercomplist.get("allname"));%>"</b>
                            <%
                                    }
                                }
%>--%>

                            <%
                                if (!entity.get("id").isEmpty()) {
                                    RssListView usercomplist = new RssListView(pageContext, "suggest_company");
                                    usercomplist.select().where("suggestid=" + entity.get("id") + " and type is null").query();
                                    while (usercomplist.for_in_rows()) {
                            %>
                            <b>"<% out.print(usercomplist.get("allname"));%>"</b>
                            <%
                                    }
                                }
                            %>
                        </td></tr>
                    <tr><td class="w120 dce">类别</td><td colspan="3">
                            <select class="w206" name="reviewclass" dict-select="companytypeeclassify" def="<% entity.write("reviewclass"); %>"></select></td></tr>
                            <%
                                if (!(entity.get("level").equals("0"))) {
                            %>
                    <tr><td class="w120 dce">办理方式</td><td colspan="3"><select class="w206" name="handle" dict-select="handle" def="<% entity.write("handle"); %>"></select></td></tr>
                            <%
                                }
                            %>
                            <%
                                if (!(cookies.Get("powergroupid").equals("22"))) {
                            %>
                    <tr class="h210">
                        <%
                            if (cookies.Get("powergroupid").equals("8")) {
                        %>
                        <td class="w120 dce">拟主办单位</td>
                        <%
                        } else {
                        %>
                        <td class="w120 dce">主办单位</td>
                        <%
                            }
                        %>
                        <td colspan="3" class="vertop">
                            <table id="smalltab">
                                <tr><td colspan="6" class="tdleft"><span tradd>增加</span><span trdel>删除</span><input class="disnone" name="realcompanyid"><input class="disnone" name="realcompanyname"></td></tr>
                                <tr><td><input type="checkbox" id="checkboxall"></td><td>单位编号</td><td>单位名称</td><td>单位类别</td><td></td></tr>
                                        <%
                                            RssListView companylist = new RssListView(pageContext, "suggest_company");
                                            companylist.select().where("suggestid =" + entity.get("id") + " and type is null").get_page_desc("suggestid");
                                            int nuu = 1;
                                            while (companylist.for_in_rows()) {
                                        %>
                                <tr class="sellist" allname="<% out.print(companylist.get("allname"));%>" realid="<% out.print(companylist.get("companyid"));%>"><td><input type="checkbox" class="checksel"></td><td><% out.print(companylist.get("code"));%></td><td class="tdleft"><% out.print(companylist.get("allname"));%></td><td class="tdleft" companytypeclassify="<% out.print(companylist.get("comtype"));%>"></td><td></td></tr>
                                        <%
                                            }
                                        %>
                            </table>
                        </td></tr>
                        <%
                            }
                        %>
                    <tr><td class="w120 dce">审查人员</td><td colspan="3"><% out.print(UserList.RealName(request));%></td></tr>
                    <tr>
                        <%
                            if (!(entity.get("level").equals("0"))) {
                        %>
                        <td class="w120 dce">复审人员</td>
                        <%
                        } else {
                        %>
                        <td class="w120 dce">乡、镇复审人员</td>
                        <%
                            }
                        %>
                        <td colspan="2">
                            <%
                                CookieHelper cookie = new CookieHelper(request, response);
                                if (!(cookie.Get("powergroupid").equals("8"))) {
                                    RssListView delegation = new RssListView(pageContext, "user_delegation");
                                    delegation.select().where("powergroupid=8 and (realname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%')").get_page_desc("myid");
                                    while (delegation.for_in_rows()) {
                            %>

                            <ul id="jyscr"></ul>
                           <!-- <input name="fsrID" value="<% out.print(delegation.get("myid"));%>">-->

                            <%
                                    }
                                }
                            %></td>

                        <td colspan="3">
                            <%
                                if (!(entity.get("level").equals("0"))) {
                            %>
                            <b class="selectscr">添加建议复审人</b>
                            <%
                            } else {
                            %>
                            <b class="selectscra">添加议案复审人</b>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">确定</button>
                <input name="InitialReviewTime" type="hidden">
                <input type="hidden" name="handlestate">
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script>
//             $("#jyscr>li").each(function () {
//                    scr.push($(this).attr("myid"));
//                })
            $('.selectscr').click(function () {
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
                RssWin.open("/selectwin/selectscuser_1.jsp", 700, 650);
            });
            $('.selectscra').click(function () {
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
                RssWin.open("/selectwin/selectscuser_1_1.jsp", 700, 650);
            });
            //增加
            $('[tradd]').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("tr[realid='" + v.myid + "']").length == "0") {
                            $("#smalltab tbody").append('<tr class="sellist" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td><td>' + v.code + '</td><td class="tdleft">' + v.realname + '</td><td class="tdleft">' + v.comtype + '</td><td></td></tr>')
                        }
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 400, 500);
            });
            //删除
            $("[trdel]").click(function () {
                $("#smalltab .sellist").find("input:checked").parent().parent().remove();
            })
            //全选
            $("#checkboxall").change(function () {
                if ($(this).is(":checked")) {
                    $(".checksel").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $(".checksel").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })

            $(".footer>button").click(function () {
                var timestamp = Date.parse(new Date());
                console.log(timestamp / 1000);
                $('[name=InitialReviewTime]').val(timestamp / 1000);
                if ($("#sugcompan y").find("b").length == "0") {
                    $("input[name='handlestate']").val("1")
                } else {
                    $("input[name='handlestate']").val("2")
                }
                var realcompanyid = [], realcompanyname = [];
                $(".sellist").each(function () {
                    realcompanyid.push($(this).attr("realid"));
                    realcompanyname.push($(this).attr("allname"))
                })
                realcompanyid = jQuery.unique(realcompanyid)
                realcompanyname = jQuery.unique(realcompanyname)
                var realcompany = realcompanyid.join(",")
                var realcompanyname = realcompanyname.join(",")
                $("input[name='realcompanyid']").val("," + realcompany)
                $("input[name='realcompanyname']").val(realcompanyname)
                if (realcompanyname.length != 0) {
                    $("input[name='handlestate']").val("3")
                }
            })
//            function tabsel() {
//                $(".sellist").off("click").click(function () {
//                    $(this).addClass("sel").siblings().removeClass("sel");
//                })
//            }
//            function alclear() {
//                $("#selalert").hide();
//                $("#comcode").removeAttr("code")
//                $("#selalert input").val("");
//                $("#selalert").hide();
//                $("#handle").text("");
//                $("#comtype").text("");
//            }
        </script>
    </body>
</html>
