<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
    Properties properties = new Properties();
    InputStream is = new FileInputStream(propertiesFileName);
    properties.load(is);
    is.close();
    String meetingTime = properties.get("meetingtime").toString();
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
            .a{display: none}
                        .ys{
                color: blue;
            }
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
                    if (!(req.get("examination").equals("2") || req.get("examination").equals("3"))) {
                        if (cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("16")) {
//                            out.print("aa");
                            if (req.get("examination").equals("1")) {
                %>
                <button type="button" transadapter="butreview" class="butreview">审查</button>
                <!--<button type="button" transadapter="butreturn" class="butreturn">撤销置回</button>-->
                <%
                    }
                } else {
//out.print("bb");
                %>
                <button type="button" transadapter="butreview" class="butreview">审查</button>
                <!--<button type="button" transadapter="butreturn" class="butreturn">撤销置回</button>-->
                <%
                        }
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
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            <!--<th>序号</th>
                            <th>编号</th>
                            -->
                            <th>标题</th>
                            <th>提出人</th>
                            <th>人数</th>
                            <!--<th>立案形式</th>-->
                            <th>审查分类</th>
                                <%
                                    if (cookie.Get("powergroupid").equals("8")) {
                                %>
                            <th>拟主办单位</th>
                                <%
                                    }
                                %>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String rwhere = "";
                            String view = "";
                            if (cookie.Get("powergroupid").equals("16")) {//16：系统管理员
                                rwhere = "";
                                view = "sort";
                            } else {
                                if (cookie.Get("powergroupid").equals("8")) {//8：议审委（原人代委）
                                    //rwhere = " and fsrID=" + UserList.MyID(request);
                                    //view = "scr_suggest";
                                      //iscs:初审状态（0否 1是）   //isysw: 是否提交给选工委或代表联络科(其他都否 21是)  //isdbtshenhe 是否通过代表团审查 （2 否  1是）
                                      rwhere = " and iscs=1 and isysw =0";                              
                                      view = "sort";
                                       if ( meetingTime.equals("1")){
                                          //ADDED by ding
                                          rwhere = " and iscs= 1 and isysw=21";
                                      }
                                }
                            }
                            RssListView list = new RssListView(pageContext, view);
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            if (!(list.get("examination").isEmpty())) {
                                if (meetingTime.equals("1")) {// 大会期间 走代表团初审流程
                                    if (list.get("isdbtshenhe").equals("1")) {//1：已经通过代表团审核
                                        list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"),
                                                "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + 
                                                " and examination=" + URLDecoder.decode(list.get("examination"), "utf-8") + " and meetingnum like '%" +
                                                URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and iscs like '%" +
                                                URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=1" + rwhere).get_page_desc("realid");
                                    } else {
                                        list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and  lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + " and examination=" + URLDecoder.decode(list.get("examination"), "utf-8") + " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=2" + rwhere).get_page_desc("realid");
                                    }
                                } else if (meetingTime.equals("0")) {//闭会期间 不走代表团
                                    String str_sql = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and  lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + " and examination=" + URLDecoder.decode(list.get("examination"), "utf-8") + " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and draft=2" + rwhere;
                                    System.out.println("str_sql::" + str_sql);
                                    list.select().where(str_sql).get_page_asc("realid");
                                }

                            } else {
                                list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and  title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + 
                                        "%' and realid like '%" + URLDecoder.decode(list.get("realid"), "utf-8") + "%' and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8") + 
                                        "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and meetingnum like '%" + 
                                        URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and isxzsc like '%" +
                                        URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and draft=2 and examination not in(1,6) " + rwhere).get_page_desc("realid");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbaddlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td>lw<% out.print(list.get("lwid")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
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
                                String companyname = "暂无,";
                                //companyname = ",";
                                companyname = "";
                                company.select().where("id=" + list.get("id")).query();
                                while (company.for_in_rows()) {
                                    companyname += company.get("allname") + ",";
                                }
                                if (!companyname.equals("")) {
                                    companyname = companyname.substring(0, companyname.length() - 1 );//截取去掉最后一个，
                                }
//                                System.out.println(companyname+"-------------------------");
                                out.print(companyname);
                                %></td>
                                <%
                                    }
                                %>
                                <!--<td methoded="<% list.write("methoded"); %>">办理方式</td>-->
                            <td>
                                <%
                                    String powerid = cookie.Get("powergroupid");
                                    String examination = req.get("examination");
                                    if(powerid != null && "8".equals(powerid) && examination != null && "5".equals(examination)){
                                        %>
                                        <span class="ys shencha" id="<% out.print(list.get("id")); %>" style="color: blue;font-weight:bold;">审查</span><span class="shencha1"> </span> |
                                <%
                                    }
                                %>
                                <span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span>|                                                          
                                <span class="ys liucheng" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看流程</span> 
                                 </td>
                        </tr>
                        <%
                                a++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                <input class="a" name="lwstate" value="<%out.print(req.get("lwstate"));%>" />
                <input class="a" name="iscs" value="<%out.print(req.get("iscs"));%>" />
                <input class="a" name="examination" value="<%out.print(req.get("examination"));%>" />
                <input class="a" name="isdbtshenhe" value="<%out.print(req.get("isdbtshenhe"));%>" />
                <input class="a" name="isxzsc" value="<%out.print(req.get("isxzsc"));%>" />
                <input class="a" name="draft" value="<%out.print(req.get("draft"));%>" />
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
        <script src="controller.js"></script>
        <script src="/liuChengSwitch.js"></script>
        <script>
            $(function(){
                if(shenchaanniu !== 1){
                    $(".shencha").remove();
                    $(".shencha1").remove();
                }
            });
            
            $(function(){
                ﻿$(".shencha").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/examine/butreview.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 830, height: 630});
                })
            });
            $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/examine/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".liucheng").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                })
            });
            
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