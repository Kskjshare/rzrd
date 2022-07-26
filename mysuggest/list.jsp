<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.User.UserList"%>
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
            .cellbor tbody>.sel>td{background: #dce6f5}
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
                <!--                <button type="button" transadapter="supersearch" select="false" class="supersearch" powerid="145">高级查询</button>
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
                <button type="button" transadapter="butreview" class="butreview" powerid="150">审查</button>-->
                <button type="button" transadapter="butview" class="butview" powerid="149">查看</button>
                <!--                <button type="button" transadapter="butimportance" class="butimportance" powerid="151">重点建议</button>
                                <button type="button" transadapter="butexcellent" class="butexcellent" powerid="152">优秀建议</button>-->
                <!--                <button type="button" transadapter="importancelist" select="false" class="butexcellent" powerid="149"><% out.print(URLDecoder.decode(req.get("importance"), "utf-8").equals("2") ? "展示全部建议" : "罗列重点建议");%></button>
                                <button type="button" transadapter="butreports" select="false" class="butreports" powerid="153">报表</button>-->
                <button type="button" class="setup" style="display: none;">设置</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <ul wz="0">
                    <li><label><input type="checkbox" name="field" sel="title" checked="checked">标题</label></li>
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
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            <!--<th class="w60">来文号</th>
                            <th class="w60">编号</th>
                            -->
	            <th class="w60">类型</th>
                            <th class="title no">标题</th>
                            <th class="myid">领衔代表</th>
                            <th>人数</th>
                            <th class="lwstate no">类型</th>
                            <th class="permission no">可否网上公开</th>
                            <th class="seconded no">可否联名提出</th>
                            <th class="opinioned no">征求意见方式</th>
                            <th class="meet no">是否会上</th>
                            <th class="methoded no">处理方式</th>
                            <th class="shijian no">提交日期</th>
                            <th class="registertype no">立案形式</th>
                            <th class="reviewclass no">审查分类</th>
                            <th class="handle no">办理情况</th>
                            <th class="realcompanyname no">主办单位</th>
                            <th class="operation">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "sort");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            String keywhere = "title like '%" + list.get("title") + "%' and methoded like '%" + list.get("methoded") + "%' and organizer like '%" + list.get("organizer") + "%' and lwid like '%" + list.get("lwid") + "%' and realid like '%" + list.get("realid") + "%' and draft=2 and myid=" + UserList.MyID(request);
                           
                             //增加闭会 开会 条件过滤
                            //if ( list.get("ismeet").equals("1")){
                             //keywhere += " and ismeet=1";
                            //}
                            //else {
                             //    keywhere += " and ismeet=0";
                          //  }
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
                            keywhere += " and ismeet=1";
                         }
                        else {
                            keywhere += " and ismeet=0";
                         }
                            
                            if ((cookie.Get("powergroupid")).equals("5") || (cookie.Get("powergroupid")).equals("22")) {
                                list.select().where(keywhere).get_page_desc("shijian");
                            } else {
                                list.select().where(keywhere).get_page_desc("realid");
                            }
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbxlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td  class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td>lw<% out.print(list.get("lwid")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
	            <td><% 
		if ( list.get("lwstate").equals("1" )) {
 			out.print( "建议"); 
		} 
                else if ( list.get("lwstate").equals("2" )){
 			out.print("议案"); 
		}
                else if ( list.get("lwstate").equals("3" )){
 			out.print("批评"); 
		}
                else if ( list.get("lwstate").equals("4" )){
 			out.print("意见"); 
		}
                else if ( list.get("lwstate").equals("5" )){
 			out.print("质询"); 
		}
	            %>
	           </td>
                            <td class="title no"><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <!--<td class="lwstate no" lwstate="<% list.write("lwstate"); %>"></td-->
                            <td class="permission no" judgment="<% list.write("permission"); %>"></td>
                            <td class="seconded no" seconded="<% list.write("seconded"); %>"></td>
                            <td class="opinioned no" opinioned="<% list.write("opinioned"); %>"></td>
                            <td class="meet no" judgment="<% list.write("meet"); %>"></td>
                            <td class="methoded no" methoded="<% list.write("methoded"); %>"></td>
                            <td class="shijian no" registertype="<% list.write("registertype"); %>"></td>
                            <!--<td class="registertype no" registertype="<% list.write("registertype"); %>"></td>-->
                            <td class="reviewclass no" companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <!--td class="handle no"-->
                                <%
                                    String handle = "";
                                    if (list.get("examination").equals("1")) {
                                       // handle = "未审查";
                                        handle = "<td class='handle no' style='color:red;font-weight:bold;'>未审查</td>";
                                    }
                                    if (list.get("iscs").equals("1")) {
                                       // handle = "初审核";
                                         handle = "<td class='handle no' style='color:IndianRed;font-weight:bold;'>待复审</td>";
                                    }
                                    if (list.get("examination").equals("2")) {
                                        //handle = "待交办";
                                          handle = "<td class='handle no' style='color:DarkOrange;font-weight:bold;'>待交办</td>";
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        handle = "乡镇政府办已审查";
                                    }
                                    if (list.get("handlestate").equals("3")) {
                                       // handle = "待办复";
                                         handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待办复</td>";
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        //handle = "已办复";
                                         handle = "<td class='handle no' style='color:Olive;font-weight:bold;'>已办复</td>";
                                    }
                                    if (list.get("examination").equals("3")) {
                                        //handle = "已置回";
                                        handle = "<td class='handle no' style='color:CadetBlue;font-weight:bold;'>已置回</td>";
                                    }
                                    out.print(handle);
                                %>
                            </td>
                            <td class="realcompanyname no"><%
                                RssListView company = new RssListView(pageContext, "company_sug");
                                String companyname = "";
                                company.select().where("id=" + list.get("id")).query();
                                while (company.for_in_rows()) {
                                    companyname += company.get("allname") + ",";
                                }
                                if (!companyname.equals("")) {
                                    companyname = companyname.substring(0, companyname.length() - 1);
                                }
                                if (companyname.equals("")) {
                                        companyname = "暂无";
                                    }
                                out.print(companyname);
                                %></td>
                            
                             <td>
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;">查看内容</span> | 
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
                            
            $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".liucheng").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                })
            });
        </script>
    </body>
</html>
