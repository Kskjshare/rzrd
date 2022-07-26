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
    RssList list = new RssList(pageContext, "suggest");
    RssListView entity = new RssListView(pageContext, "sort");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    list.request();
    entity.request();
    if (!list.get("action").isEmpty()) {
        list.remove("id");
        list.keyvalue("examination", 2);
        usercomp.delete().where("suggestid=" + list.get("id")).submit();
        if (!list.get("realcompanyid").equals(",")) {
            String[] bb = list.get("realcompanyid").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    usercomp.keyvalue("suggestid", list.get("id"));
                    usercomp.keyvalue("companyid", bb[i]);
                    usercomp.append().submit();
                }
            }
        }
        list.remove("realcompanyid");
        list.update().where("id=?", entity.get("id")).submit();
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
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .sel{background:#dce6f5; }
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #selalert{margin: 100px auto;;width: 400px;background: #dce6f5;line-height: 34px;display: none}
            #selalert #alerthead{color: #fff}
            #selalert>table{margin: 0 auto 5px;background:#fff;line-height: 34px;width: 97%;color: #666; }
            #selalert>table td{position: relative;}
            #selalert>table td input{height: 28px;}
            #selalert>table span{padding: 5px 10px;margin: 0 20px;background: #a79012;color: #fff;border-radius: 5px;cursor: pointer}
            #selalert>table span:first-child{background: #186aa3;margin-left: 100px}
            #selalert .w100{text-align:right;}
            #selalert .alerthead{text-align: center;background: #82bee9;color: black;}
            #selalert ul{position: absolute;left:3px ;top: 30px;background: #fff;z-index: 99;border: #666 solid 1px;border-radius: 5px;color: #000;overflow-x:hidden;overflow-y:auto; display: none;max-height: 110px;}
            #selalert ul li{text-indent: 5px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #selalert ul li:hover{background:#dce6f5; }
            .disnone{display: none}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
                    <tr><td class="w120 dce">序号</td><td class="w261"><% entity.write("lwid"); %></td><td class="w120 dce">届次</td><td class="w261" name="sessionid" sessionclassify="<% entity.write("sessionid"); %>"></td></tr>
                    <tr><td class="w120 dce">建议编号</td><td class="w261"><% entity.write("realid"); %></td><td class="w120 dce">提交类型</td><td class="w261" lwstate="<% entity.write("lwstate"); %>"></td></tr>
                    <tr><td class="w120 dce">建议题目</td><td colspan="3"><% entity.write("title"); %></td></tr>
                    <tr><td class="w120 dce">领衔代表</td><td colspan="3"><% entity.write("realname"); %></td></tr>
                    <tr><td colspan="4" id="tabheader">建议审查</td></tr>
                    <tr><td class="w120 dce">建议承办单位</td><td colspan="3"><% entity.write("organizer"); %></td></tr>
                    <tr><td class="w120 dce">立案形式</td><td colspan="3"><select class="w206" name="registertype" dict-select="registertype" def="<% entity.write("registertype"); %>"></select></td></tr>
                    <tr><td class="w120 dce">办理方式</td><td><select class="w206" name="handle" dict-select="handle" def="<% entity.write("handle"); %>"></select></td><td class="w120 dce">审查分类</td><td><select class="w206" name="reviewclass" dict-select="reviewclass" def="<% entity.write("reviewclass"); %>"></select></td></tr>
                    <tr class="h210"><td class="w120 dce">主办单位</td><td colspan="3" class="vertop">
                            <table id="smalltab">
                                <tr><td colspan="6" class="tdleft"><span tradd>增加</span><span trdel>删除</span><input class="disnone" name="realcompanyid"><input class="disnone" name="realcompanyname"></td></tr>
                                <tr><td></td><td>单位编号</td><td>单位名称</td><td>办理类型</td><td>单位类别</td><td></td></tr>
                                <% 
                                 RssListView companylist = new RssListView(pageContext, "suggest_company");
                                 companylist.select().where("suggestid in (" + entity.get("id") + ")").get_page_desc("suggestid");
                                 int nuu = 1;
                               while (companylist.for_in_rows()) {
                                   %>
                                <tr class="sellist" allname="<% out.print(companylist.get("allname"));%>" realid="<% out.print(companylist.get("companyid"));%>"><td><% out.print(nuu);%></td><td><% out.print(companylist.get("code"));%></td><td class="tdleft"><% out.print(companylist.get("allname"));%></td><td handle="<% out.print(companylist.get("handle"));%>"></td><td class="tdleft" companytypeclassify="<% out.print(companylist.get("comtype"));%>"></td><td></td></tr>
                                <%
                               }
                                %>
                            </table>
                        </td></tr>
                    <tr><td class="w120 dce">审查人员</td><td><% out.print(UserList.RealName(request));%></td><td class="w120 dce">审查时间</td><td rssdata="<% entity.write("shijian");%>,yyyy-MM-dd"></td></tr>
                </table>
            </div>
            <div id="selalert">
                <table>
                    <tr><td class="alerthead" colspan="2">增加承办单位</td></tr>
                    <tr><td class="w100">单位编号：</td><td><input autocomplete="off" class="w200" id="comcode"><ul class="w200" id="com1"></ul></td></tr>
                    <tr><td class="w100">单位名称：</td><td><input autocomplete="off" class="w200" id="comname"><ul class="w200" id="com2"></ul></td></tr>
                    <tr><td class="w100">办理类型：</td><td id="handle"></td></tr>
                    <tr><td class="w100">单位类别：</td><td id="comtype"></td></tr>
                    <tr><td></td><td><span>确定</span><span>取消</span></td></tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <button type="submit">确定</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytype.js" type="text/javascript"></script>
        <script>
            var comlist = [];
            var html1 = "";
            var html2 = "";
           
            <%
                RssList all = new RssList(pageContext, "user");
                all.select().where("state like '%3%'").get_page_desc("myid");
                while (all.for_in_rows()) {
            %>
            comlist.push({'realid': '<% out.print(all.get("myid"));%>', 'code': '<% out.print(all.get("code"));%>', 'allname': '<% out.print(all.get("allname"));%>', 'handle': '<% out.print(all.get("handle"));%>', 'comtype': '<% out.print(all.get("comtype"));%>'})
            html1 += "<li realid='<% out.print(all.get("myid"));%>' code='<% out.print(all.get("code"));%>' allname='<% out.print(all.get("allname"));%>' handleid='<% out.print(all.get("handle"));%>' comtypeid='<% out.print(all.get("comtype"));%>'><% out.print(all.get("code"));%></li>"
            html2 += "<li realid='<% out.print(all.get("myid"));%>' allname='<% out.print(all.get("allname"));%>' code='<% out.print(all.get("code"));%>' handleid='<% out.print(all.get("handle"));%>' comtypeid='<% out.print(all.get("comtype"));%>'><% out.print(all.get("allname"));%></li>"
            tabsel()
            <%
                }
            %>
            $("#selalert input").click(function () {
                $(this).siblings("ul").show();
                var mycode = $(this).val();
            })
            function liclick() {
                $("#selalert li").off("click").click(function () {
                    $(this).parent().prev().val($(this).text());
                    $(this).parent().hide();
                    var code = $(this).attr("code");
                    var allname = $(this).attr("allname");
                    var handleid = $(this).attr("handleid");
                    var comtypeid = $(this).attr("comtypeid");
                    var realid = $(this).attr("realid")
                    $("#comcode").val(code);
                    $("#comcode").attr("code", code).attr("realid", realid).attr("allname", allname).attr("handleid", dictdata["handle"][handleid]).attr("comtypeid", dictdata["comtype"][comtypeid]);
                    $("#comname").val(allname);
                    $("#handle").text(dictdata["handle"][handleid]);
                    $("#comtype").text(dictdata["companytypeclassify"][comtypeid]);
                })
            }
            $("#comcode").bind('input propertychange', function () {
                $("#selalert").find("li").remove();
                $(this).siblings("ul").show();
                var code = $(this).val()
                $.each(comlist, function (k, v) {
                    if (v.code.indexOf(code) != "-1") {
                        $("#comcode").show();
                        $("#com1").append("<li realid=" + v.realid + " code=" + v.code + " allname=" + v.allname + " handleid=" + v.handle + " comtypeid=" + v.comtype + ">" + v.code + "</li>")
                        $("#com2").append("<li realid=" + v.realid + " allname=" + v.allname + " code=" + v.code + " handleid=" + v.handle + " comtypeid=" + v.comtype + ">" + v.allname + "</li>")
                    }
                })
                liclick();
            });
            $("#comname").bind('input propertychange', function () {
                $("#selalert").find("li").remove();
                $(this).siblings("ul").show();
                var allname = $(this).val()
                $.each(comlist, function (k, v) {
                    if (v.allname.indexOf(allname) != "-1") {
                        $("#comname").show();
                        $("#com1").append("<li realid=" + v.realid + " code=" + v.code + " allname=" + v.allname + " handleid=" + v.handle + " comtypeid=" + v.comtype + ">" + v.code + "</li>")
                        $("#com2").append("<li realid=" + v.realid + " allname=" + v.allname + " code=" + v.code + " handleid=" + v.handle + " comtypeid=" + v.comtype + ">" + v.allname + "</li>")
                    }
                })
                liclick();
            });
            $("#selalert table span").eq(0).click(function () {
                if ($("#comcode").attr("code")) {
                    var num = parseInt($(".sellist").length) + 1
                    $("#smalltab tbody").append('<tr class="sellist" allname="' + $("#comcode").attr("allname") + '" realid="' + $("#comcode").attr("realid") + '"><td>' + num + '</td><td>' + $("#comcode").attr("code") + '</td><td class="tdleft">' + $("#comcode").attr("allname") + '</td><td>' + $("#comcode").attr("handleid") + '</td><td class="tdleft">' + $("#comcode").attr("comtypeid") + '</td><td></td></tr>')
                    tabsel()
                    alclear()
                } else {
                    alert("请填写正确的单位")
                }
            })
            $("#selalert table span").eq(1).click(function () {
                alclear()
            })
            $("#smalltab span").eq(0).click(function () {
                $("#selalert ul").empty();
                $("#selalert").show();
                $("#com1").append(html1)
                $("#com2").append(html2)
                liclick()
            })
            $("#smalltab span").eq(1).click(function () {
                $(".sel").remove();
                $(".sellist").each(function () {
                    $(this).children("td").eq(0).text($(this).index() - 1)
                })
            })
            $(".footer>button").click(function () {
                var realcompanyid = [],realcompanyname=[];
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
            })
            function tabsel() {
                $(".sellist").off("click").click(function () {
                    $(this).addClass("sel").siblings().removeClass("sel");
                })
            }
            function alclear() {
                $("#selalert").hide();
                $("#comcode").removeAttr("code")
                $("#selalert input").val("");
                $("#selalert").hide();
                $("#handle").text("");
                $("#comtype").text("");
            }
        </script>
    </body>
</html>