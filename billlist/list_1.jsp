<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
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
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .no{display: none}
            tbody tr:hover{background-color: gainsboro;}

        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch" powerid="145">快速查询</button>
                <!--<button type="button" transadapter="supersearch" select="false" class="supersearch" powerid="145">高级查询</button>-->
                <button type="button" transadapter="append" select="false" class="butadd" powerid="146">增加</button>
                <%
                    RssListView entity = new RssListView(pageContext, "sort");
                    entity.select().where("myid=?", UserList.MyID(request)).get_first_rows();
                    if (!(entity.get("draft").equals("2"))) {
                %>
                <button type="button" transadapter="edit" class="butedit" powerid="147">编辑</button>
                <button type="button" transadapter="delete" class="butdelect" powerid="148">删除</button>
                <%
                    }
                %>
                <button type="button" transadapter="butreview" class="butreview" powerid="150">审查</button>
                <button type="button" transadapter="butview" class="butview" powerid="149">查看</button>
                <button type="button" transadapter="importancelist" select="false" class="butexcellent" powerid="152"><% out.print(URLDecoder.decode(req.get("importance"), "utf-8").equals("2") ? "展示全部议案" : "罗列重点议案");%></button>
                <button type="button" transadapter="butreports" select="false" class="butreports" powerid="153">报表</button>
                <button type="button" class="setup" style="display: none;">设置</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <ul wz="0">
                    <li><label><input type="checkbox" name="field" sel="title" checked="checked">议案标题</label></li>
                    <li><label><input type="checkbox" name="field" sel="myid" checked="checked">领衔代表</label></li>
                    <li><label><input type="checkbox" name="field" sel="numpeople" checked="checked">提出人数</label></li>
                    <li><label><input type="checkbox" name="field" sel="lwstate">类型</label></li>
                    <li><label><input type="checkbox" name="field" sel="">提交状态</label></li>
                    <li><label><input type="checkbox" name="field" sel="registertype">立案形式</label></li>
                    <li><label><input type="checkbox" name="field" sel="">开案案号</label></li>
                    <li><label><input type="checkbox" name="field" sel="permission">可否网上公开</label></li>
                    <li><label><input type="checkbox" name="field" sel="seconded">可否联名提出</label></li>
                    <li><label><input type="checkbox" name="field" sel="opinioned">征求意见方式</label></li>
                    <li><label><input type="checkbox" name="field" sel="meet">是否会上</label></li>
                    <li><label><input type="checkbox" name="field" sel="methoded">处理方式</label></li>
                    <li><label><input type="checkbox" name="field" sel="shijian">提交日期</label></li>
                    <li><label><input type="checkbox" name="field" sel="reviewclass" checked="checked">审查分类</label></li>
                    <li><label><input type="checkbox" name="field" sel="handle" checked="checked">办理情况</label></li>
                    <li><label><input type="checkbox" name="field" sel="degree">解决程度</label></li>
                    <li><label><input type="checkbox" name="field" sel="realcompanyname" checked="checked">主办单位</label></li>
                </ul>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30">序号</th>
                            <th class="w30"><input name="all" type="checkbox" name="id"></th>
                            <!--<th>来文号</th>-->
                            <th>议案编号</th>
                            <th class="title no">议案标题</th>
                            <th class="myid">领衔代表</th>
                            <th>议案人数</th>
                            <th class="lwstate no">立案形式</th>
                            <th class="permission no">可否网上公开</th>
                            <th class="seconded no">可否联名提出</th>
                            <th class="opinioned no">征求意见方式</th>
                            <th class="meet no">是否会上</th>
                            <th class="methoded no">处理方式</th>
                            <th class="shijian no">提交日期</th>
                            <th class="registertype no">立案形式</th>
                            <th class="reviewclass no">审查分类</th>
                            <th class="handle no">办理情况</th>
                                <%
                                        if (cookie.Get("powergroupid").equals("8")) {
                                %>
                            <th class="realcompanyname no">拟主办单位</th>
                                <%
                                } else {
                                %>
                            <th class="realcompanyname no">主办单位</th>
                                <%
                                    }
                                %>
                            <th class="handle no">督办领导</th>
                            <!--                            <th>代表团</th>
                                                        <th>联系电话</th>-->

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String powerid = cookie.Get("powergroupid");
                            String keywhere = "";
                            String view = "sort";
                            switch (powerid) {
                                case "5":    //代表
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and myid=" + cookie.Get("myid");
                                    break;
                                case "22": //代表团(审查)
                                    view = "scr_suggest";
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and mission=" + cookie.Get("myid");
                                    break;
                                case "8": //选联委(审查)
                                    view = "scr_suggest";
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and fsrID=" + cookie.Get("myid");
                                    break;
                                case "25": //乡镇(审查)
                                    view = "scr_suggest";
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and fsrID=" + cookie.Get("myid");
                                    break;
                                case "23": //政府(交办)
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and lwstate=2 and draft=2 and examination =2";
                                    break;
                                case "18": //办理单位(办理)
                                    view = "company_sug";
//                                    String rid = cookie.Get("parentid");
//                                    if (rid.equals("0")) {
//                                        rid = cookie.Get("myid");
//                                    }
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and lwstate=2 and draft=2 and deal =1 and companyid=" + cookie.Get("myid");
                                    break;
                                default:
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2";
                                    break;
                            }
                            RssListView list = new RssListView(pageContext, view);
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            if ((cookie.Get("powergroupid")).equals("5") || (cookie.Get("powergroupid")).equals("22")) {
                                list.select().where(keywhere).get_page_desc("shijian");
                            } else {
                                list.select().where(keywhere).get_page_desc("realid");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbaclclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td  class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td>lw<% // out.print(list.get("lwid")); %></td>-->
                            <td><% out.print(list.get("realid")); %></td>
                            <td class="title no"><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <td class="lwstate no" lwstate="<% list.write("lwstate"); %>"></td>
                            <td class="permission no" judgment="<% list.write("permission"); %>"></td>
                            <td class="seconded no" seconded="<% list.write("seconded"); %>"></td>
                            <td class="opinioned no" opinioned="<% list.write("opinioned"); %>"></td>
                            <td class="meet no" judgment="<% list.write("meet"); %>"></td>
                            <td class="methoded no" methoded="<% list.write("methoded"); %>"></td>
                            <td class="shijian no" registertype="<% list.write("registertype"); %>"></td>
                            <td class="registertype no" registertype="<% list.write("registertype"); %>"></td>
                            <td class="reviewclass no" companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <td class="handle no">
                                <%
                                    String handle = "";
                                    if (list.get("examination").equals("1")) {
                                        handle = "未审查";
                                    }
                                    if (list.get("iscs").equals("1")) {
                                        handle = "初审核";
                                    }
                                    if (list.get("examination").equals("2")) {
                                        handle = "待交办";
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        handle = "乡镇政府办已答复";
                                    }
                                    if (list.get("handlestate").equals("3")) {
                                        handle = "待办复";
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        handle = "已办复";
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "已置回";
                                    }
                                    out.print(handle);
                                %>
                            </td>
                            <td class="realcompanyname">
                                <%
                                    RssListView company = new RssListView(pageContext, "company_sug");
                                    String companyname = "";
                                    company.select().where("id=" + list.get("id")).query();
                                    while (company.for_in_rows()) {
                                        companyname += company.get("account") + ",";
                                    }
                                    if (!companyname.equals("")) {
                                        companyname = companyname.substring(0, companyname.length() - 1);
                                    }
                                     if (companyname.equals("")) {
                                        companyname = "暂无";
                                    }
                                    out.print(companyname);
                                %>
                            </td>
                            <td class="handle no"><% out.print(list.get("leader")); %></td>
<!--                            <td><% out.print(list.get("allname")); %></td>
                            <td><% out.print(list.get("dbtdh")); %></td>-->
                        </tr>
                        <%
                                a++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
                            $(".setup").click(function () {
                                if ($(".toolbar>ul").attr("wz") == "0") {
                                    $(".toolbar>ul").attr("wz", "1")
                                    $(".toolbar>ul").animate({"right": 0}, 500);
                                } else {
                                    $(".toolbar>ul").attr("wz", "0")
                                    $(".toolbar>ul").animate({"right": -180}, 500);
                                }
                            })
                            $(".toolbar ul>li").click(function () {
                                $(".no").hide();
                                listshow();
                            })
                            listshow();
                            function listshow() {
                                $("[name='field']").each(function () {
                                    if ($(this).is(":checked")) {
                                        var sel = $(this).attr("sel");
                                        if (sel != undefined && sel != "") {
                                            $("." + sel).show();
                                        }
                                    }
                                })
                            }
        </script>
