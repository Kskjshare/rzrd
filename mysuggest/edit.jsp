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
    RssList entity = new RssList(pageContext, "suggest");
    RssList sort = new RssList(pageContext, "sort");
    RssList second = new RssList(pageContext, "secondeduser");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        entity.remove("secound");
        if (entity.get("summary").isEmpty()) {
            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 120));
        }

        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        switch (entity.get("action")) {
            case "append":
                entity.timestamp();
                entity.keyvalue("draft", 2);
                entity.append().submit();
                sort.pagesize = 100000000;
                sort.select().where("type=1").get_page_desc("realid");;
                int a = sort.totalrows + 1;
                sort.keyvalue("sortid", entity.autoid);
                sort.keyvalue("type", 1);
                sort.keyvalue("realid", a);
                sort.append().submit();
                if (!entity.get("secound").equals(",")) {
                    String[] bb = entity.get("secound").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            second.keyvalue("suggestid", entity.autoid);
                            second.keyvalue("userid", bb[i]);
                            second.append().submit();
                        }
                    }
                }
                break;
            case "update":
                entity.update().where("id=?", entity.get("id")).submit();
                second.delete().where("suggestid=" + entity.get("id")).submit();
                if (!entity.get("secound").equals(",")) {
                    String[] bb = entity.get("secound").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            second.keyvalue("suggestid", entity.get("id"));
                            second.keyvalue("userid", bb[i]);
                            second.append().submit();
                        }
                    }
                }
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
            .uetd>#fydb{height: 180px;background: #FFF;margin: 0 auto;width: 740px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#fydb>div>table{width: 100%}
            .uetd>#fydb>div>table th,.uetd>#fydb>div>table td{padding: 0;font-size: 12px;line-height: 24px}
            #dbdiv{height: 34px;}
            #dblist{background: #fff;z-index: 99;border: #666 solid 1px;border-radius: 5px;color: #000;overflow-x:hidden;overflow-y:auto; display: none;max-height: 110px; position: absolute; width: 170px;}
            #dblist li{text-indent: 5px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #dblist li:hover{background:#dce6f5;}
            #dbbut{color: ButtonFace;background: rgb(101, 113, 128);border: solid 1px rgb(101, 113, 128);border-radius: 3px;padding: 3px 6px; padding-bottom: 5px;font-size: 12px;word-spacing: 10px;line-height: 1em;font-family: 微软雅黑;vertical-align: middle;display: inline-block;margin-left: 10px;}
            #fydb tbody{text-align: center;}
            #fydb tbody span{color: red;cursor: pointer;}
            #tabdiv{overflow: auto;height: 140px}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <!--<td></td>-->
                        <td colspan="4" class="institle dce">【建议】涉密建议请采用其他方式提交。</td>
                        <!--<td class="w100"></td>-->
                    </tr>
                    <tr>
                        <td class="w150 dce">建议标题：</td>
                        <td colspan="3"><input type="text" class="w400" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="w150 dce">处理方式：</td>
                        <td colspan="3"><select class="w206" name="methoded" dict-select="methoded" def="<% entity.write("methoded"); %>"></select></td>
                    </tr>
                    <tr>
                        <td class="w150 dce">征求意见方式：</td>
                        <td><select class="w206" name="opinioned" dict-select="opinioned" def="<% entity.write("opinioned"); %>"></select></td>
                        <td class="w150 dce">建议承办单位：</td>
                        <td><input class="w200" type="text" name="organizer" value="<% entity.write("organizer"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="w150 dce">可否联名提出：</td>
                        <td><select class="w206" name="seconded" dict-select="seconded" def="<% entity.write("seconded"); %>"></select></td>
                        <td class="w150 dce">可否网上公开：</td>
                        <td><select class="w206" name="permission" dict-select="judgment" def="<% entity.write("permission"); %>"></select></td>
                    </tr>
                    <tr class="">
                        <!--<td class="tr">内容：</td>-->
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">建议内容</li><li>提出者信息</li><li>联名代表</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script>
                            <div id="tczxx">
                                <%
                                    RssListView user = new RssListView(pageContext, "user_delegation");
                                    if (entity.get("myid").isEmpty()) {
                                        entity.keymyid(UserList.MyID(request));
                                    }
                                    user.select().where("myid=?", entity.get("myid")).get_first_rows();
                                %>   
                                <table>
                                    <tbody>
                                        <tr><td>编号</td><td><% user.write("code"); %></td><td>姓名</td><td><% user.write("realname"); %></td></tr>
                                        <tr><td>性别</td><td sex="<% user.write("sex"); %>"></td><td>民族</td><td><% user.write("nationid"); %></td></tr>
                                        <tr><td>党派</td><td clan="<% user.write("clan"); %>"></td><td>出生年月</td><td rssdate="<% out.print(user.get("birthday")); %>,yyyy-MM"></td></tr>
                                        <tr><td>单位名称</td><td colspan="3"><% user.write("company"); %></td></tr>
                                        <tr><td>代表团</td><td colspan="3"><% user.write("delegationname"); %></td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <div  id="fydb">
                                <div id="dbdiv"><input autocomplete="off" id="dbinput" type="text" placeholder="请添加代表"><ul id="dblist"></ul><button type="button" id="dbbut">添加</button></div>
                                <div id="tabdiv">
                                    <table>
                                        <thead><tr><th class="w50">操作</th><th class="w100">代表证号</th><th>姓名</th><th>单位</th><th>职务</th></tr></thead>
                                        <tbody> <%
                                            RssListView second_user = new RssListView(pageContext, "second_user");
                                            if (!entity.get("id").isEmpty()) {
                                                second_user.select().where("suggestid=" + entity.get("id")).get_page_desc("id");
                                                while (second_user.for_in_rows()) {
                                            %>
                                            <tr realid="<% out.print(second_user.get("userid"));%>"><td><span>删除</span></td><td><% out.print(second_user.get("code"));%></td><td><% out.print(second_user.get("realname"));%></td><td><% out.print(second_user.get("company"));%></td><td><% out.print(second_user.get("job"));%></td></tr>
                                            <%
                                                    };
                                                };
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/> <label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label><input name="secound"><input name="numpeople"></td>
                    </tr>   
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            var comlist = [];
            <%
                RssList all = new RssList(pageContext, "user");
                all.select().where("state=2").get_page_desc("myid");
                while (all.for_in_rows()) {
            %>
            comlist.push({'realid': '<% out.print(all.get("myid"));%>', 'code': '<% out.print(all.get("code"));%>', 'job': '<% out.print(all.get("job"));%>', 'realname': '<% out.print(all.get("realname"));%>', 'company': '<% out.print(all.get("company"));%>'})
            <%
                }
            %>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })
            $(".footer>button").click(function () {
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
                        alert("请填写完整数据")
                        return false;
                    }
                })
                var secound = [], secoundsp = "";
                $("#tabdiv").find("tr").each(function () {
                    secound.push($(this).attr("realid"));
                })
                secoundsp = secound.join(",");
                $("input[name='secound']").val(secoundsp);
                $("input[name='numpeople']").val($("#tabdiv").find("tr").length);
            })
            $("#dbinput").bind('input propertychange', function () {
                $("#dblist").find("li").remove();
                $("#dblist").show();
                $("#dbinput").attr("realid", "");
                var allname = $(this).val();
                $.each(comlist, function (k, v) {
                    if (v.realname.indexOf(allname) != "-1") {
                        $("#dblist").append("<li job=" + v.job + " company=" + v.company + " code=" + v.code + " realname=" + v.realname + " realid=" + v.realid + ">" + v.realname + "</li>")
                    }
                })
                $("#dblist").find("li").click(function () {
                    $("#dbinput").attr("job", $(this).attr("job"))
                    $("#dbinput").attr("code", $(this).attr("code"))
                    $("#dbinput").attr("realname", $(this).attr("realname"))
                    $("#dbinput").attr("realid", $(this).attr("realid"))
                    $("#dbinput").attr("company", $(this).attr("company"))
                    $("#dbinput").val($(this).attr("realname"));
                    $(this).parent().hide();
                })
            });
            $("#dbbut").click(function () {
                var inp = $("#dbinput");
                if ($("#dbinput").attr("realid") == undefined || $("#dbinput").attr("realid") == "") {
                    alert("请选择代表");
                    return false;
                }
                if ($("tr[realid='" + inp.attr("realid") + "']").length == "0") {
                    $("#fydb").find("tbody").append('<tr realid=' + inp.attr("realid") + '><td><span>删除</span></td><td>' + inp.attr("code") + '</td><td>' + inp.attr("realname") + '</td><td>' + inp.attr("company") + '</td><td>' + inp.attr("job") + '</td></tr>');
                    del();
                } else {
                    alert("该代表已经添加过了")
                }
            })
            del();
            function del() {
                $("#fydb tbody span").off("click").click(function () {
                    $(this).parent().parent().remove();
                })
            }
            $(".cellbor").click(function() {
     $("#dblist").hide();
})
        </script>
    </body>
</html>
