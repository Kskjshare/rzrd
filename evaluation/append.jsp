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
    RssListView entity = new RssListView(pageContext, "suggest_opinion");
    RssList entity1 = new RssList(pageContext, "opinion");
    RssList entity2 = new RssList(pageContext, "opinion");
    RssList suggest = new RssList(pageContext, "suggest");
    RssList company = new RssList(pageContext, "suggest_company");
    RssList user = new RssList(pageContext, "user");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    entity1.request();
    if (!entity1.get("action").isEmpty()) {
        entity1.remove("id");
        entity1.remove("summary");
        entity1.remove("ceshi");
        if (entity1.get("myid").isEmpty()) {
            entity1.keymyid(UserList.MyID(request));
        }
//        entity1.delete().where("proposal in(" + entity1.get("id") + ")").submit();
        entity1.keyvalue("proposal", entity1.get("id"));
        entity1.append().submit();
        suggest.keyvalue("consultation", 1);
        suggest.update().where("id=?", entity1.get("id")).submit();
        //计算平均分  
        entity2.select("allscore").where("companyid=" + entity1.get("companyid")).query();
        int allscore = 0;
        int allnum = 0;
        while (entity2.for_in_rows()) {
            allnum++;
            allscore = allscore + Integer.parseInt(entity2.get("allscore"));
        }
        allscore = allscore / allnum;
        user.keyvalue("zxallscore", allscore);
        user.update().where("myid=" + entity1.get("companyid")).submit();
        //提示
        lzmessage.keyvalue("realid", entity1.get("id"));
        lzmessage.keyvalue("classify", 6);
        lzmessage.timestamp();;
        lzmessage.append().submit();
        String[] arr = {"5","8", "16"};
        for (int idx = 0; idx < arr.length; idx++) {
            read.keyvalue("messageid", lzmessage.autoid);
            read.keyvalue("groupid", arr[idx]);
            read.keyvalue("type", 1);
            read.append().submit();
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity1.get("id")).get_first_rows();
    company.select().where("type=2 and suggestid=?", entity1.get("id")).get_page_desc("id");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="mui.min.css" rel="stylesheet" type="text/css"/>
        <style>
            .popupwrap{width: 100%}
            .left_op{width: 30px}
            .mui-input-row span{display: none}
            .mui-input-range input[type=range]{background-color: #dce6f5;height: 6px;border: 1px solid #cbcbcb;width: 90%;margin: 0}
            .mui-input-row.mui-input-range{float: left;width: 90%;padding: 0;}
            .tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 36px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #baidubjq td{line-height: 17px;background: #dce6f5}
            #baidubjq td ul{width: 798px;margin-top: 5px;border-top: 1px solid #6caddc;border-left: 1px solid #6caddc;border-right: 1px solid #6caddc}
            #baidubjq td div{border-left: 1px solid #6caddc;border-right: 1px solid #6caddc;border-bottom: 1px solid #6caddc;margin-bottom: 5px;width: 778px;padding: 10px;background: #fff}
            .shu{line-height: 15px;text-align: center;}
            .uetd>ul{left: 0}
            .cellbor>tbody>tr .line{line-height: 24px}
            textarea{width: 99%;height: 60px;margin: 5px 0;}
            #titlecode{float: right;margin-right: 30px;}
            .startlist em{display: inline-block; ;right:30px; color: #777777;}
            .startlist a { background: url(../css/limg/star1.png) no-repeat; background-size: 25px 25px; display: inline-block; width: 25px; height: 25px; margin: 0 6px;vertical-align: middle;}
            .startlist .sel{background: url(../css/limg/star1s.png) no-repeat; background-size: 25px 25px;}  
            .startlist input{border: 0;width: 15px;}
            #effect label{margin: 0 5px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp120 cellbor">
                    <tr>
                        <td colspan="20" class="tabheader">填写代表意见</td>
                    </tr>
                    <tr><td colspan="10" class="dce">议案(建议)标题</td><td colspan="10"> <% out.print(entity.get("title"));%><span id="titlecode">编号： <% out.print(entity.get("realid"));%></span></td></tr>
                    <tr><td colspan="10" class="dce">主办单位</td><td colspan="10"><span id="cbdw" rid="<%
                        String str = "";
                        while (company.for_in_rows()) {
                            str += "," + company.get("companyid");
                        }
                        out.print(str);
                                                                                     %>">点击选择承办单位</span><input type="hidden" name="companyid"></td></tr>
                    <tr><td colspan="10" class="dce">您是否收到答复函</td><td colspan="10"><select class="w206" name="reply" dict-select="state"></select></td></tr>
                    <tr><td colspan="10" class="dce">收到时间</td><td colspan="10"><input type="text" class="w200 Wdate" name="replyshijian"  rssdate="<% out.print(entity.get("replyshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td></tr>
                    <tr><td colspan="10" class="dce">收到答复函您认为</td><td colspan="10" id="effect"><label><input type="radio" value="1" name="ceshi">满意</label><label><input type="radio" value="2" name="ceshi">基本满意</label><label><input type="radio" value="3" name="ceshi">不满意</label></td></tr>
                    <tr>
                        <td colspan="10" class="dce">您对办理情况意见：</td>
                        <td colspan="10"><textarea name="opinion"><% entity.write("opinion");%></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce" rowspan="6" colspan="1" style="word-wrap:break-word;word-break:break-all"><ul class="shu"><li>建</li><li>议</li><li>办</li><li>理</li><li>质</li><li>量</li><li>评</li><li>价</li><li>指</li><li>标</li></ul></td>
                        <td colspan="9" class="dce">承办人业务能力</td>
                        <td colspan="10" class="startlist">
                            <em name="business"><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a></em>
                            <input type="number" name="business" class="inline-range-val" value="0"/>分
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" class="dce">沟通的主动性</td>
                        <td colspan="10" class="startlist">
                            <em name="business"><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a></em>
                            <input type="number" class='inline-range-val' name="initiative" value="0"/>分
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" class="dce">交流的充分性</td>
                        <td colspan="10" class="startlist">
                            <em name="business"><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a></em>
                            <input type="number" class='inline-range-val' name="communication" value="0"/>分
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" class="dce">办理的针对性</td>
                        <td colspan="10" class="startlist">
                            <em name="business"><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a></em>
                            <input type="number" class='inline-range-val' name="counter" value="0"/>分
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" class="dce">对问题的共识度</td>
                        <td colspan="10" class="startlist">
                            <em name="business"><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a></em>
                            <input type="number" class='inline-range-val' name="consensus" value="0"/>分
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" class="dce">对建议办理的具体评价</td>
                        <td colspan="10" class="startlist">
                            <em name="business"><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a><a></a></em>
                            <input type="number" class='inline-range-val' name="evaluate" value="0"/>分
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="dce">总分：</td>
                        <td colspan="10"> <input readonly="readonly" name="allscore" value="<% out.print(entity.get("allscore").isEmpty()?"0":entity.get("allscore"));%>"></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="effect" value="<% entity.write("effect");%>">
                <input type="hidden" name="action" value="1" />
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <!--<script src="mui.min.js" type="text/javascript"></script>-->
        <script>
            //监听input事件，获取range的value值，也可以直接element.value获取该range的值
//            var rangeList = document.querySelectorAll('input[type="range"]');
//            alert(rangeList.length)
//            for (var i = 0, len = rangeList.length; i < len; i++) {
//                console.log(rangeList[i])
//                rangeList[i].addEventListener('input', function () {
////                    console.log(this.id)
//                    if (this.id.indexOf('field') >= 0) {
//                        document.getElementById(this.id + '-input').value = this.value;
//                    } else {
//                        document.getElementById(this.id + '-val').innerHTML = this.value;
//                    }
//                    rangeList.value = $(this).parent().next().text()
//
//                });
//            }
            $(".startlist a").click(function () {
                var ind = $(this).index();
                $(this).parent().siblings("input").val(ind);
                $(this).parent().find("a").each(function () {
                    if ($(this).index() <= ind) {
                        $(this).addClass("sel")
                    } else {
                        $(this).removeClass("sel")
                    }
                })
                var allscore = 0;
                $('.inline-range-val').each(function () {
                    if ($(this).val() != "" && $(this).val() != undefined) {
                        allscore = allscore + parseInt($(this).val())
                    }
                })
                $("[name='allscore']").val(allscore);
            })
            $('#cbdw').click(function () {
                var t = $(this), n = $(this).attr("rid");
                if (!n) {
                    n = "";
                }
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                    t.text(dict.myname)
                    $("[name='companyid']").val(dict.myid);
                }
                RssWin.open("/selectwin/zhengxuncompany.jsp?relationid=0" + n, 400, 500);
            });
            $('.footer button').unbind().click(function () {
                if ($("[name='companyid']").val() == "" || $("[name='companyid']").val() == undefined) {
                    alert("请选择承办单位");
                }
                $("[name='effect']").val($("#effect").find("input:checked").val());
                if ($("[name='replyshijian']").val() != undefined && $("[name='replyshijian']").val() != "") {
                    var timestamp = new Date($("[name='replyshijian']").val());
                    $("[name='replyshijian']").val(timestamp / 1000);
                }
            })
        </script>
    </body>
</html>
