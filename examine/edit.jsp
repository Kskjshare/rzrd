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
    RssList entity = new RssList(pageContext, "suggest");
    RssList sort = new RssList(pageContext, "sort");
    RssList second = new RssList(pageContext, "secondeduser");
    RssList contacts = new RssList(pageContext, "suggestlxr");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("scyj", "perm", "type1", "type2", "type3", "type4", "blfs", "secound", "contacts", "usercomp");
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
                            second.keyvalue("myid", bb[i]);
                            second.append().submit();
                        }
                    }
                }
                if (!entity.get("contacts").equals(",")) {
                    String[] bb = entity.get("contacts").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            contacts.keyvalue("suggestid", entity.autoid);
                            contacts.keyvalue("userid", bb[i]);
                            contacts.append().submit();
                        }
                    }
                }
                if (!entity.get("usercomp").equals(",")) {
                    String[] bb = entity.get("usercomp").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            usercomp.keyvalue("suggestid", entity.autoid);
                            usercomp.keyvalue("companyid", bb[i]);
                            usercomp.append().submit();
                        }
                    }
                }
                break;
            case "update":
                entity.remove("sessionid,myid");
                entity.update().where("id=?", entity.get("id")).submit();
                second.delete().where("suggestid=" + entity.get("id")).submit();
                contacts.delete().where("suggestid=" + entity.get("id")).submit();
                usercomp.delete().where("suggestid=" + entity.get("id")).submit();
                if (!entity.get("secound").equals(",")) {
                    String[] bb = entity.get("secound").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            second.keyvalue("suggestid", entity.get("id"));
                            second.keyvalue("userid", bb[i]);
                            second.keyvalue("myid", bb[i]);
                            second.append().submit();
                        }
                    }
                }
                if (!entity.get("contacts").equals(",")) {
                    String[] bb = entity.get("contacts").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            contacts.keyvalue("suggestid", entity.get("id"));
                            contacts.keyvalue("userid", bb[i]);
                            contacts.append().submit();
                        }
                    }
                }
                if (!entity.get("usercomp").equals(",")) {
                    String[] bb = entity.get("usercomp").split(",");
                    for (int i = 0; i < bb.length; i++) {
                        if (!bb[i].isEmpty()) {
                            usercomp.keyvalue("suggestid", entity.get("id"));
                            usercomp.keyvalue("companyid", bb[i]);
                            usercomp.append().submit();
                        }
                    }
                }
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    String[] arry = {"", "", ""};
    if (!entity.get("enclosure").isEmpty()) {
        String[] str = entity.get("enclosure").split(",");
        for (int idx = 0; idx < str.length; idx++) {
            arry[idx] = str[idx];
        }
    }

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
            td .w99{width: 99%;}
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;min-width: 100px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 740px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            #edui2{width: 100%;line-height: 14px}
            .popupwrap>div:first-child{height: 93%;}
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
            .fileeform{position: absolute;left: -10000px;}
            .cellbor td>span{cursor: pointer;}
            #suggesttype{text-align: right;margin-top: 5px;}
            #suggesttype>select{margin: -5px 5px 0;}
            .popupwrap>div>h1{text-align: center;margin:10px 0 20px 0 }
            .popupwrap table td>b{cursor: pointer;}
            .popupwrap table td>.lxrlist>input{width: 100px;margin: 0 10px;}
            .popupwrap table td>label{margin: 0 3px;}
            .popupwrap table td>ul>li>.red{margin-left: 5px;font-size: 10px;cursor: pointer;}
            .popupwrap table td>input[type='checkbox']{margin: 0 3px;}
            span[rid]{cursor: pointer};

        </style>
    </head>
    <body>
        <form id="fileeform1" class="fileeform"enctype="multipart/form-data" method="post">
            <input type="file" id="file1" ridform="1"  name="file1" multiple>
        </form>
        <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form id="fileeform3" class="fileeform" ridform="3" enctype="multipart/form-data" method="post">
            <input type="file" id="file3" ridform="3"  name="file3" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <div id="suggesttype">类&nbsp;&nbsp;&nbsp;别：<select name="lwstate"><option value="1">建议</option><option value="2">议案</option></select></div>
                <h1>人民代表大会代表建议、批评和意见</h1>
                <table class="wp100 cellbor">
                    <tr>
                        <td>届次<em class="red">*</em></td>
                        <td colspan="2"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>
                        <td>会议次数<em class="red">*</em></td>
                        <td colspan="2"><select type="text" maxlength="80" class="w260" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" ></select></td>
                    </tr>
                    <tr>
                        <td>层次<em class="red">*</em></td>
                        <td colspan="5"><select type="text" maxlength="80" class="w260" name="level" dict-select="circles" def="<% entity.write("level"); %>" ></select></td></td>
                    </tr>
                    <tr>
                        <td class="w150 dce">建议标题：</td>
                        <td colspan="5"><input type="text" class="w99" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        if (entity.get("id").isEmpty()) {
                            user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                        } else {
                            user.select().where("myid=" + entity.get("myid")).get_first_rows();
                        }
                    %>
                    <tr>
                        <td>代表姓名<em class="red">*</em></td><td colspan="3"><% user.write("realname"); %></td><td>代表团</td><td><% user.write("delegationname"); %></td>
                    </tr>
                    <tr><td>代表证号<em class="red">*</em></td><td><% user.write("code"); %></td><td>邮政编号</td><td><% user.write("postcode"); %></td><td>联系电话</td><td><% user.write("telphone"); %></td></tr>
                    <tr><td>通讯地址</td><td colspan="5"><% user.write("homeaddress"); %></td></tr>
                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel">建议内容</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"><% entity.write("matter"); %></script>
                        </td>
                    </tr>
                    <tr><td>附件</td><td colspan="5">
                            <div><span id="fjfile1" rid="1"><% out.print(arry[0].isEmpty() ? "点击选择文件" : arry[0]); %></span><input type="hidden" id="enclosure1" value="<% out.print(arry[0]); %>" ></div>
                            <div><span id="fjfile2" rid="2"><% out.print(arry[1].isEmpty() ? "点击选择文件" : arry[1]); %></span><input type="hidden" id="enclosure2" value="<% out.print(arry[1]); %>" ></div>
                            <div><span id="fjfile3" rid="3"><% out.print(arry[2].isEmpty() ? "点击选择文件" : arry[2]); %></span><input type="hidden" id="enclosure3" value="<% out.print(arry[2]); %>" ></div>
                        </td></tr>
                    <tr><td>审查分类<em class="red">*</em></td><td colspan="5" selradio>
                            <select type="text" maxlength="80" class="w260" name="reviewclass" dict-select="companytypeeclassify" def="<% entity.write("reviewclass"); %>" ></select>
                            <!--                            <label><input name="scyj" type="radio">参阅件</label><label><input name="scyj" type="radio">撤案</label><label><input name="scyj" type="radio">并案</label>-->
                            <input type="hidden" name="reviewopinion"></td></tr>
                    <tr><td rowspan="6">相关情况</td><td colspan="5" selradio>代表对公开此建议有关情况的意见<label><input type="radio" name="perm">同意全文公开</label><label><input type="radio" name="perm">仅同意公开标题</label><input type="hidden" name="permission"></td></tr>
                    <tr><td colspan="5" selradio>此建议由代表通过调查研究形成<label><input type="radio" name="type1">专题调研</label><label><input type="radio" name="type1">座谈</label><label><input type="radio" name="type1">走访等其他形式</label><input type="hidden" name="sugformation"></td></tr>
                    <tr><td colspan="5" selradio>属于多年多次提出,尚未解决的事项<label><input type="radio" name="type2">两年</label><label><input type="radio" name="type2">三年</label><label><input type="radio" name="type2">三年以上</label><input type="hidden" name="sugyears"></td></tr>
                    <tr><td colspan="5" >希望承办单位在办理过程中加强与代表的联系沟通<input selbox type="checkbox" name="type3"><input type="hidden" name="communicate"></td></tr>
                    <tr><td colspan="5" selbox>此建议请承办单位在工作中研究参考,不需要书面答复<input selbox type="checkbox" name="type4"><input type="hidden" name="written"></td></tr>
                    <tr><td colspan="5" selradio>可否联名提出<label><input type="radio" name="type1">可以</label><label><input type="radio" name="type1">不可以</label><input type="hidden" name="seconded"></td></tr>
                    <!--                    <tr><td>办理方式</td><td colspan="5" selradio><label><input type="radio" name="blfs">主办/协办</label><label><input type="radio" name="blfs">分办</label><input type="hidden" name="handle"></td></tr>-->
                    <!--                    <td>有效届次：</td>
                                        <td colspan="5"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>-->
                    <tr style="display: none;"><td>办理单位</td><td colspan="4"><ul id="bldw">
                                <%
                                    if (!entity.get("id").isEmpty()) {
                                        RssListView usercomplist = new RssListView(pageContext, "suggest_company");
                                        usercomplist.select().where("suggestid=" + entity.get("id") + " and type =1").query();
                                        while (usercomplist.for_in_rows()) {
                                %>
                                <li myid='<% out.print(usercomplist.get("companyid"));%>'><% out.print(usercomplist.get("allname"));%><em class='red'>删除</em></li>
                                    <%
                                            }
                                        }
                                    %>
                            </ul></td><td><b class="selectcompany">选择主/分办单位</b></td></tr>
                    <tr style="display: none;"><td>建议联系人</td><td colspan="4"><ul id="jylxr">
                                <%
                                    if (!entity.get("id").isEmpty()) {
                                        RssListView contactslist = new RssListView(pageContext, "suggestlxr_user");
                                        contactslist.select().where("suggestid=" + entity.get("id")).query();
                                        while (contactslist.for_in_rows()) {
                                %>
                                <li myid='<% out.print(contactslist.get("userid"));%>'><% out.print(contactslist.get("realname"));%><em class='red'>删除</em></li>
                                    <%
                                            }
                                        }
                                    %>
                            </ul></td><td><b class="selectuser">添加建议联系人</b></td></tr>
                    <tr><td>建议附议人</td><td colspan="4"><ul id="blfyr">
                                <%
                                    if (!entity.get("id").isEmpty()) {
                                        RssListView secondlist = new RssListView(pageContext, "second_user");
                                        secondlist.select().where("suggestid=" + entity.get("id")).query();
                                        while (secondlist.for_in_rows()) {
                                %>
                                <li myid='<% out.print(secondlist.get("userid"));%>'><% out.print(secondlist.get("realname"));%><em class='red'>删除</em></li>
                                    <%
                                            }
                                        }
                                    %>
                            </ul></td><td><b class="selectuser">添加建议附议人</b></td></tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/> <label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label><input name="secound"><input name="contacts"><input name="usercomp"><input name="numpeople"><input name="enclosure"><input name="sessionid" value="<% out.print(cookie.Get("sessionid")); %>"></td>
                    </tr>   
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
                <input name="year" type="hidden">
                <input name="ProposedBill" type="hidden">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

            //单选多选赋值
            var json = {};
            json.reviewopinion =<% out.print(entity.get("reviewopinion"));%>
            json.permission =<% out.print(entity.get("permission"));%>
            json.sugformation =<% out.print(entity.get("sugformation"));%>
            json.sugyears =<% out.print(entity.get("sugyears"));%>
            json.communicate =<% out.print(entity.get("communicate"));%>
            json.written =<% out.print(entity.get("written"));%>
            json.handle =<% out.print(entity.get("handle"));%>
            $.each(json, function (k, v) {
                $("input[name='" + k + "']").val(v);
                if (k == "written" || k == "communicate") {
                    if (v == "1") {
                        $("input[name='" + k + "']").parent().find("input").eq(0).click();
                    }
                } else {
                    var ind = parseInt(v) - 1
                    console.log(v + "+" + ind)
                    $("input[name='" + k + "']").parent().find("label").eq(ind).click();
                }
            })
            //办理单位,联系人,联名人赋值



            $(".footer>button").click(function () {
                var date = new Date;
                var year = date.getFullYear();
                var mydate = year.toString();
                console.log(mydate);
                $('[name=year]').val(mydate);
                var timestamp = Date.parse(new Date());
                console.log(timestamp / 1000);
                $('[name=ProposedBill]').val(timestamp / 1000);
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
                        alert("请填写完整数据")
                        return false;
                    }
                })
                var secound = [], secoundsp = "", contacts = [], contactsp = "", usercomp = [], usercompsp = "";
                $("#blfyr>li").each(function () {
                    secound.push($(this).attr("myid"));
                })
                $("#jylxr>li").each(function () {
                    contacts.push($(this).attr("myid"));
                })
                $("#bldw>li").each(function () {
                    usercomp.push($(this).attr("myid"));
                })
                secoundsp = secound.join(",");
                contactsp = contacts.join(",");
                usercompsp = usercomp.join(",");
                $("input[name='secound']").val(secoundsp);
                $("input[name='contacts']").val(contactsp);
                $("input[name='usercomp']").val(usercompsp);
                $("input[name='numpeople']").val($("#bllxr>li").length + 1);
                var enc = $("#enclosure1").val() + "," + $("#enclosure2").val() + "," + $("#enclosure3").val()
                $("input[name='enclosure']").val(enc);
                $("[selradio]").each(function () {
                    var num = $(this).find("input:checked").parent().index() + 1;
                    $(this).find("input[type='hidden']").val(num);
                })
                $("[selbox]").each(function () {
                    if ($(this).is(":checked")) {
                        $(this).parent().find("input[type='hidden']").val("1")
                    } else {
                        $(this).parent().find("input[type='hidden']").val("2")
                    }
                })
            })
            $(".cellbor").click(function () {
                $("#dblist").hide();
            })
            //上传附件
            $("span[rid]").click(function () {
                var rid = $(this).attr("rid")
                $("#file" + rid).click();
            })
            $(".fileeform>input").change(function () {
                var ridform = $(this).attr("ridform");
                $(this).parent().ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#fjfile" + ridform).text(data.url)
                        $("#enclosure" + ridform).val(data.url);
                        alert("上传成功");
                    }});
                return false;
            })

            $('.selectuser').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectuser.jsp", 700, 650);
            });
            $('.selectcompany').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 700, 650);
            });
            $("li").find(".red").off("click").click(function () {
                $(this).parent().remove();
            })

        </script>
    </body>
</html>
