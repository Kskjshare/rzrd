<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>

<%
    StaffList.IsLogin(request, response);
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
            tbody tr:hover{background-color: gainsboro;}
            .res{float: right;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <!--<button type="button" transadapter="append" select="false" class="butadd">增加</button>-->
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <%
                    CookieHelper cookie = new CookieHelper(request, response);
                    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                    if (!(req.get("examination").equals("2") || req.get("isxzsc").equals("1"))) {
                %>
                <button type="button" transadapter="butreview" class="butreview">办理回复</button>
                <!--<button type="button" transadapter="butreturn" class="butreturn">撤销置回</button>-->
                <%
                    }
                %>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <button type="button" class="res">返回上一级</button>
                <!--<button type="button" transadapter="butreports" select="false" class="butreports">报表</button>-->
                <!--<button type="button" class="setup">设置</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <ul wz="0">
                    <li><label><input type="checkbox" name="field">建议标题</label></li>
                    <li><label><input type="checkbox" name="field">领衔代表</label></li>
                    <li><label><input type="checkbox" name="field">提出人数</label></li>
                    <li><label><input type="checkbox" name="field">类型</label></li>
                    <li><label><input type="checkbox" name="field">提交状态</label></li>
                    <li><label><input type="checkbox" name="field">立案形式</label></li>
                    <li><label><input type="checkbox" name="field">开案案号</label></li>
                    <li><label><input type="checkbox" name="field">可否网上公开</label></li>
                    <li><label><input type="checkbox" name="field">可否联名提出</label></li>
                    <li><label><input type="checkbox" name="field">征求意见方式</label></li>
                    <li><label><input type="checkbox" name="field">是否会上</label></li>
                    <li><label><input type="checkbox" name="field">处理方式</label></li>
                    <li><label><input type="checkbox" name="field">提交日期</label></li>
                    <li><label><input type="checkbox" name="field">审查分类</label></li>
                    <li><label><input type="checkbox" name="field">办理方式</label></li>
                    <li><label><input type="checkbox" name="field">解决程度</label></li>
                    <li><label><input type="checkbox" name="field">主办单位</label></li>
                </ul>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            <!--<th>序号</th>-->
                            <th>建议编号</th>
                            <th>建议标题</th>
                            <th>提出人</th>
                            <th>建议人数</th>
                            <!--<th>立案形式</th>-->
                            <th>审查分类</th>
                                <%
                                    if (cookie.Get("powergroupid").equals("8")) {
                                %>
                            <th>拟主办单位</th>
                                <%
                                    }
                                %>
                            <!--<th>办理方式</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String rwhere = "";
                            String view = "";
                            if (cookie.Get("powergroupid").equals("16")) {
                                rwhere = "";
                                view = "sort";
                            } else {
                                if (cookie.Get("powergroupid").equals("8")) {
                                    rwhere = " and fsrID=" + UserList.MyID(request);
                                    view = "scr_suggest";
                                } else if (cookie.Get("powergroupid").equals("25")) {
                                    rwhere = " and fsrID=" + UserList.MyID(request);
                                    view = "scr_suggest";
                                } else {
                                    rwhere = " and userid=" + UserList.MyID(request);
                                    view = "scr_suggest";
                                }
                            }
                            RssListView list = new RssListView(pageContext, view);
                            list.request();
                            
                            
                            
                            if (cookie.Get("powergroupid").equals("23") || cookie.Get("powergroupid").equals("7")) {//督察局（市流程）
                                rwhere+=" and level=1";
                            } else if (cookie.Get("powergroupid").equals("25")) {//乡镇主席团
                                rwhere +=" and level=0";
                            }
                    
                                  //增加闭会 开会 条件过滤 
                        String meetingTime="0";
                        try {
                            String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
                            Properties properties = new Properties();
                            InputStream is = new FileInputStream(propertiesFileName);
                            properties.load(is);
                            is.close();
                            meetingTime = properties.get("meetingtime").toString();
                        } catch (Exception e) {
                         e.printStackTrace();
                         }
                        if ( meetingTime.equals("1")){
                            rwhere += " and ismeet=1";
                         }
                        else {
                            rwhere += " and ismeet=0";
                         }
                            
                            
                            int a = 1;
                            list.pagesize = 30;
                            if (!(list.get("examination").isEmpty())) {
                                if (list.get("isdbtshenhe").equals("1")) {
                                    list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + " and examination=" + URLDecoder.decode(list.get("examination"), "utf-8") + " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=1" + rwhere).get_page_desc("realid");
                                } else {
                                    list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and  lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + " and examination=" + URLDecoder.decode(list.get("examination"), "utf-8") + " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=2" + rwhere).get_page_desc("realid");
                                }
                            } else {
                                list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and  title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(list.get("methoded"), "utf-8") + "%' and organizer like '%" + URLDecoder.decode(list.get("organizer"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(list.get("lwid"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(list.get("realid"), "utf-8") + "%' and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8") + "%'  and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and draft=2 " + rwhere).get_page_desc("realid");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbMZddlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td>lw<% out.print(list.get("lwid")); %></td>-->
                            <td><% out.print(list.get("realid")); %></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <!--<td registertype="<% list.write("registertype"); %>"></td>-->
                            <td companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <%
                                if (cookie.Get("powergroupid").equals("8")) {
                            %>
                            <td><%
                                RssListView company = new RssListView(pageContext, "company_sug");
                                String companyname = "";
                                company.select().where("id=" + list.get("id")).query();
                                while (company.for_in_rows()) {
                                    companyname += company.get("allname") + ",";
                                }
                                if (!companyname.equals("")) {
                                    companyname = companyname.substring(0, companyname.length() - 1);
                                }
                                out.print(companyname);
                                %></td>
                                <%
                                    }
                                %>
                                <!--<td methoded="<% list.write("methoded"); %>">办理方式</td>-->
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
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js" type="text/javascript"></script>
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
                            $(".res").click(function () {
                                history.go(-1);
                            });
        </script>
    </body>
</html>