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
    RssList scr = new RssList(pageContext, "suggestscr");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    CookieHelper cookie = new CookieHelper(request, response);
    sort.pagesize = 100000;
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("scyj", "perm", "type1", "type2", "type3", "type4", "blfs", "secound", "contacts", "usercomp", "usercomp", "scr");
        entity.remove("id");
        entity.remove("classify");
        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        entity.timestamp();
        entity.append().submit();
        sort.pagesize = 100000000;
        sort.select().where("type=" + entity.get("lwstate")).get_page_desc("realid");
        int a = sort.totalrows + 1;
        sort.keyvalue("sortid", entity.autoid);
        sort.keyvalue("type", entity.get("lwstate"));
        sort.keyvalue("realid", a);
        sort.append().submit();
        if (entity.get("draft").equals("2")) {
            lzmessage.keyvalue("realid", entity.autoid);
            lzmessage.keyvalue("classify", 7);
            lzmessage.timestamp();
            lzmessage.append().submit();
        }
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
        if (!entity.get("scr").equals(",")) {
            String[] bb = entity.get("scr").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    scr.keyvalue("suggestid", entity.autoid);
                    scr.keyvalue("userid", bb[i]);
                    scr.append().submit();
                    if (entity.get("draft").equals("2")) {
                        read.keyvalue("messageid", lzmessage.autoid);
                        read.keyvalue("objid", bb[i]);
                        read.keyvalue("type", 1);
                        read.append().submit();
                    }
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
        out.print("<script>alert('操作成功！');</script>");
//        PoPupHelper.adapter(out).iframereload();
//        PoPupHelper.adapter(out).showSucceed();
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
            .cellbor td{padding: 0 6px;font-size: 12px;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 770px}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 740px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            #edui2{width: 100%;line-height: 14px}
            .popupwrap>div:first-child{width: 800px;margin: 0 auto; margin-bottom: 50px; height: auto;}
            .fileeform{position: absolute;left: -10000px;}
            .cellbor td>span{cursor: pointer;}
            #suggesttype{text-align: right;margin-top: 5px;}
            #suggesttype>select{margin: -5px 5px 0;}
            .popupwrap{overflow: auto}
            .popupwrap table td>b{cursor: pointer;}
            .popupwrap>div>h1{text-align: center; margin: 10px 0 20px 0;}
            .popupwrap table td>.lxrlist>input{width: 100px;margin: 0 10px;}
            .popupwrap table td>label{margin: 0 3px;}
            .popupwrap table td>ul>li>.red{margin-left: 5px;font-size: 10px;cursor: pointer;}
            .popupwrap table td>input[type='checkbox']{margin: 0 3px;}
            span[rid]{cursor: pointer}
            /*.popupwrap .footer>button{ font-size: 99px;}*/
            .popupwrap>.footer{top: auto;bottom: 0;right: 24px;border-top: solid 1px #e6e6e6; padding-top: 5px;position: fixed;}
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
                <h1>人民代表大会代表议案</h1>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="w150 dce">议案标题：</td>
                        <td colspan="5"><input type="text" class="w400" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                    <tr>
                        <td>代表姓名<em class="red">*</em></td><td colspan="3" <% out.print(entity.get("id").isEmpty() ? "id='adminsel'" : "");%> ><% user.write("realname"); %></td><td>代表团</td><td id="parentname"><% user.write("delegationname"); %></td>
                    </tr>
                    <tr><td>代表证号<em class="red">*</em></td><td id="codenum"><% user.write("code"); %></td><td>邮政编号</td><td id="postcode"><% user.write("postcode"); %></td><td>联系电话</td><td id="telphone"><% user.write("telphone"); %></td></tr>
                    <tr><td>通讯地址</td><td colspan="5" id="homeaddress"><% user.write("homeaddress"); %></td></tr>
                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel">建议内容</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                    <tr><td>附件</td><td colspan="5">
                            <div><span id="fjfile1" rid="1">点击选择文件</span><input type="hidden" id="enclosure1" ></div>
                            <div><span id="fjfile2" rid="2">点击选择文件</span><input type="hidden" id="enclosure2" ></div>
                            <div><span id="fjfile3" rid="3">点击选择文件</span><input type="hidden" id="enclosure3" ></div>
                        </td></tr>
                    <tr><td>审查意见</td><td colspan="5" selradio><label><input name="scyj" type="radio">接收</label><label><input name="scyj" type="radio">不予接收</label><label><input name="scyj" type="radio">参阅件</label><label><input name="scyj" type="radio">撤案</label><label><input name="scyj" type="radio">并案</label><input type="hidden" name="reviewopinion"></td></tr>
                    <tr><td rowspan="5">相关情况</td><td colspan="5" selradio>代表对公开此建议有关情况的意见<label><input type="radio" name="perm">同意全文公开</label><label><input type="radio" name="perm">仅同意公开标题</label><input type="hidden" name="permission"></td></tr>
                    <tr><td colspan="5" selradio>此建议由代表通过调查研究形成<label><input type="radio" name="type1">专题调研</label><label><input type="radio" name="type1">座谈</label><label><input type="radio" name="type1">走访等其他形式</label><input type="hidden" name="sugformation"></td></tr>
                    <tr><td colspan="5" selradio>属于多年多次提出,尚未解决的事项<label><input type="radio" name="type2">两年</label><label><input type="radio" name="type2">三年</label><label><input type="radio" name="type2">三年以上</label><input type="hidden" name="sugyears"></td></tr>
                    <tr><td colspan="5" >希望主办单位在办理过程中加强与代表的联系沟通<input selbox type="checkbox" name="type3"><input type="hidden" name="communicate"></td></tr>
                    <tr><td colspan="5" selbox>此建议请主办单位在工作中研究参考,不需要书面答复<input selbox type="checkbox" name="type4"><input type="hidden" name="written"></td></tr>
                    <tr><td>办理方式</td><td colspan="5" selradio><label><input type="radio" name="blfs">主办/协办</label><label><input type="radio" name="blfs">分办</label><input type="hidden" name="handle"></td></tr>
                    <td>有效届次：</td>
                    <td colspan="5"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>
                    <tr><td>办理单位</td><td colspan="4"><ul id="bldw"></ul></td><td><b class="selectcompany">选择主/分办单位</b></td></tr>
                    <tr><td>建议联系人</td><td colspan="4"><ul id="jylxr"></ul></td><td><b class="selectuser">添加建议联系人</b></td></tr>
                    <tr><td>审查人</td><td colspan="4"><ul id="jyscr"></ul></td><td><b class="selectscr">添加建议审查人</b></td></tr>
                    <tr><td>建议附议人</td><td colspan="4"><ul id="blfyr"></ul></td><td><b class="selectuser">添加建议附议人</b></td></tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/> <label>默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %></label><input name="secound"><input name="contacts"><input name="scr"><input name="usercomp"><input name="numpeople"><input name="enclosure"></td>
                    </tr>   
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <button type="submit">保存</button>
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <input name="draft" type="hidden">
            </div>
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <%@include  file="/inc/js.html" %>
        <script>
//            $('.footer button:first').click(function () {
//                $('[name=draft]').val(1);
//            });
//            $('.footer button:last').click(function () {
//                $('[name=draft]').val(2);
//            });
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })

            $(".footer>button").click(function () {
                $('[name=draft]').val($(this).index());
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
                        alert("请填写完整数据")
                        return false;
                    }
                })
                var secound = [], secoundsp = "", contacts = [], contactsp = "", usercomp = [], usercompsp = "", scr = [], scrsp = "";
                $("#blfyr>li").each(function () {
                    secound.push($(this).attr("myid"));
                })
                $("#jylxr>li").each(function () {
                    contacts.push($(this).attr("myid"));
                })
                $("#bldw>li").each(function () {
                    usercomp.push($(this).attr("myid"));
                })
                $("#jyscr>li").each(function () {
                    scr.push($(this).attr("myid"));
                })
                secoundsp = secound.join(",");
                contactsp = contacts.join(",");
                usercompsp = usercomp.join(",");
                scrsp = scr.join(",");
                $("input[name='secound']").val(secoundsp);
                $("input[name='contacts']").val(contactsp);
                $("input[name='usercomp']").val(usercompsp);
                $("input[name='scr']").val(scrsp);
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
            $('.selectscr').click(function () {
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
                RssWin.open("/selectwin/selectscuser.jsp", 400, 500);
            });
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
                RssWin.open("/selectwin/selectuser.jsp", 600, 450);
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
                RssWin.open("/selectwin/selectcompany.jsp", 600, 450);
            });
            $("li").find(".red").off("click").click(function () {
                $(this).parent().remove();
            })
            if (Cookie.Get("powergroupid") == "16") {
                $("#adminsel").click(function () {
                    RssWin.onwinreceivemsg = function (dict) {
                        console.log(dict);
                        $("#adminsel").text(dict.myname)
                        $("#parentname").text(dict.delegationname)
                        $("#codenum").text(dict.code)
                        $("#postcode").text(dict.postcode)
                        $("#telphone").text(dict.telphone)
                        $("#homeaddress").text(dict.homeaddress)
                        $("[name='myid']").val(dict.myid)
                    }
                    RssWin.open("/selectwin/selectoneuser.jsp?state=2", 600, 500);
                })
            }
        </script>
    </body>
</html>
