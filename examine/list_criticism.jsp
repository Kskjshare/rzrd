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
                        if (cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("16")) {//账号是代表团或系统管理员
                            if (req.get("examination").equals("1")) {
                %>
                <!--button type="button" transadapter="butreview" class="butreview">审查</button-->
                <!--<button type="button" transadapter="butreturn" class="butreturn">撤销置回</button>-->
                <%
                    }
                } else {
//out.print("bb");
                %>
                <!--button type="button" transadapter="butreview" class="butreview">审查</button-->
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
                    <li><label><input type="checkbox" name="field">标题</label></li>
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
                    <li><label><input type="checkbox" name="field">进度</label></li>
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
 	            <th>类型</th>
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
                            <!--<th>办理方式</th>-->

	            <!--add new colums by ding -->
	             <th>进度</th>
	             <th>操作</th>
		
                     
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            String rwhere = "";
                            String view = "";
                            if (cookie.Get("powergroupid").equals("16")) {//系统管理员
                                rwhere = "";
                                view = "sort";
                            } else {
                                if (cookie.Get("powergroupid").equals("7")) {//选工委或代表联络科
                                    rwhere = " and isysw=21 and fsrID=" + UserList.MyID(request);// + UserList.MyID(request);//大会期间
                                    //added by ding for records
                                   // rwhere =    " and isysw=21" + " and "+UserList.MyID(request);
                                     rwhere =   " and "+UserList.MyID(request);
                                    
                                     //added by ding 汝州项目选工委只能审批市级代表，所以加一个level条件查找记录
                                    //rwhere += " and level=1 ";
                                    rwhere += " and level=1";
                                    view = "scr_suggest";
                                }
                                else if (cookie.Get("powergroupid").equals("23")) {//督察局
                                    rwhere = " and isysw=21 and fsrID=" + UserList.MyID(request);// + UserList.MyID(request);//大会期间
                                    //added by ding for records
                                    rwhere =    " and "+UserList.MyID(request);
                                    
                                     //added by ding 汝州项目督察局只能审批市级代表，所以加一个level条件查找记录
                                    rwhere += " and level=1";
                                    
                                    view = "scr_suggest";
                                }
                                else if (cookie.Get("powergroupid").equals("8")) {//议审委:8
                                    rwhere = " and fsrID=" + UserList.MyID(request);
                                    view = "scr_suggest";
                                } 
                                else if (cookie.Get("powergroupid").equals("25")) {//乡镇代表主席团
                                    rwhere = " and xzscID=" + UserList.MyID(request);
                                    view = "scr_suggest";
                                    
                                    
                                     //打个补丁,开会期间 乡镇流程主席团登录以后，在统计界面不应该看到被代表团置回的记录。
                                    if ( meetingTime.equals("1")  ) {
                                         rwhere += " and examination= 2 "; // ding change 2 to 5 2021.3.31
                                    }
                                } else {//add by Wel_D: 22:代表团
//                                    rwhere = " and userid=" + UserList.MyID(request);
                                  //rwhere = UserList.MyID(request);
                                   // view = "scr_suggest";
                                   if ( req.get("examination").isEmpty() ) {
//                                       rwhere += " and examination=" + req.get("examination");
                                   }
                                   else
                                   rwhere += " and examination=" + req.get("examination");
                                   view = "sort";
                                     
                                }
                            }
                            
                            
                            
                            //RssListView list = new RssListView(pageContext, view);
                            
                            RssList list = new RssList(pageContext, "suggest");


                            list.request();
                            
        
                        
                        int isMeeting = 0 ;
                        if ( meetingTime.equals("1")){
                            rwhere += " and ismeet=1";
                            isMeeting = 1;
                         }
                        else {
                            rwhere += " and ismeet=0";
                         }
                            
                        
                            
                            int a = 1;
                            list.pagesize = 30;
                            
                            
//                            if (!(list.get("examination").isEmpty())) {
//                                if (list.get("isdbtshenhe").equals("1")) {
//                                    
//                                    //打个补丁,闭会期间，主席团登录的时候在查看界面看不到已经提交的记录
//                                    if ( isMeeting == 0 && (cookie.Get("powergroupid").equals("25"))){
//                                      list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" +
//                                            URLDecoder.decode(req.get("title"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") +
//                                            "%' and lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + " and examination=" + URLDecoder.decode(list.get("examination"), "utf-8") + 
//                                            " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + 
//                                            "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=2" + rwhere).get_page_desc("realid");
//                                    }
//                                    else{
//                                    
//                                         //修改乡镇开会期间，主席团登录以后看不到记录
//                                         list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" +
//                                            URLDecoder.decode(req.get("title"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") +
//                                            "%' and lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") +
//                                            " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + 
//                                            "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=1" + rwhere).get_page_desc("realid");
//
//                                    }
//                                } else {
//                                    
//                                     view = "sort";
//                                     rwhere ="";
////                                    list.select().where("title like '%" + URLDecoder.decode(req.get("title"), "utf-8") +
////                                            "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and  lwstate=" + URLDecoder.decode(list.get("lwstate"), "utf-8") + " and examination=" + 
////                                            URLDecoder.decode(list.get("examination"), "utf-8") + " and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and isxzsc like '%" + 
////                                            URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and iscs like '%" +
////                                            URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and draft=2 and isdbtshenhe=2" + rwhere).get_page_desc("realid");
//                                    
//                        //list.select().where("lwstate=" + req.get("lwstate") +" and examination="+req.get("examination") + " and isdbtshenhe="+req.get("isdbtshenhe") ).get_page_desc("id");
//                        
//                        
//                        if ( req.get("all").equals("1")){
////                            list.select().where("lwstate=" + req.get("lwstate") ).get_page_desc("id");            
//
//                        }
//                        else {
//                            list.select().where("lwstate=" + req.get("lwstate") + " and examination=" + req.get("examination") + " and isdbtshenhe="+req.get("isdbtshenhe") ).get_page_desc("id");            
//                        }
//                                   
//                                    
//                                }
//                            } else {
//                               //list.select().where("realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and  title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(list.get("realid"), "utf-8") + "%' and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and draft=2 " + rwhere).get_page_desc("realid");
//                               
//                            //打个补丁,开会期间 乡镇流程主席团登录以后，在统计界面不应该看到被代表团置回的记录。
//                               if ( isMeeting == 1 && cookie.Get("powergroupid").equals("25") ) {
//                                  // rwhere
//                                 
//                               }
//                               list.select().where("title like '%" + 
//                                       URLDecoder.decode(list.get("title"), "utf-8") +
//                                       "%' and realid like '%" + URLDecoder.decode(list.get("realid"), "utf-8") + "%' and lwstate like '%" + URLDecoder.decode(list.get("lwstate"), "utf-8") + 
//                                       "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") +
//                                       "%' and iscs like '%" + URLDecoder.decode(req.get("iscs"), "utf-8") + "%' and isxzsc like '%" + URLDecoder.decode(req.get("isxzsc"), "utf-8") + "%' and draft=2 " +
//                                       rwhere).get_page_desc("realid");
//                           
//                
//                             
//                            }
//                          
//                    
                       
                        
                        if ( req.get("all").equals("1")){
                         list.select().where("lwstate=" + req.get("lwstate") ).get_page_desc("id");            
                        }
                        else {
                           list.select().where("lwstate=" + req.get("lwstate") + " and examination=" + req.get("examination") + " and isdbtshenhe="+req.get("isdbtshenhe") ).get_page_desc("id");            
                        }
                       
//                                   
                          
                          int aaa = 0 ;           
                          while (list.for_in_rows()) {
//                          while ( aaa > 1 ) {
                        %>
                        <tr ondblclick="ck_dbaddlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--
                            <td>lw<% out.print(list.get("lwid")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
	           <td>
		<% 
		if ( list.get("lwstate").equals("1") ) {
		out.print("建议"); 
		}
                else if (  list.get("lwstate").equals("2") ){
		out.print("议案"); 
		}
                else if (  list.get("lwstate").equals("3") ){
		out.print("批评"); 
		}
                else if (  list.get("lwstate").equals("4") ){
		out.print("意见"); 
		}
                else if (  list.get("lwstate").equals("5") ){
		out.print("质询"); 
		}
		%>
	            </td>

                            <td><% out.print(list.get("title")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <!--<td registertype="<% list.write("registertype"); %>"></td>-->
                            <td companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <%
                                if (cookie.Get("powergroupid").equals("8")) {
                            %>
                            <td>
		<%
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
                                %>
	           </td>
                                <%
                                    }
                                %>
                                <!--<td methoded="<% list.write("methoded"); %>">办理方式</td>-->

	            <!--add new colums by ding -->
 		<% //examination:    审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查
                                    //draft:起草1草稿2已提交    待初审    待交办         待复审
                                    //deal:是否已交办 //iscs初审状态（0否 1是)//isxzsc：乡镇政府办审查状态(0否 1是）
                                    //handlestate:（确定办理单位）建议议案办理状态1:未确定,2待确定,3已确定,4申退中//resume:是否办复(0否 1是）
                                    //resume ： 1表示已经办复
                                    String handle = "";
                                    int showAudetBtn = 0 ;
                                    if (list.get("examination").equals("1")) {
                                        handle = "<td class='handle no' style='color:red;font-weight:bold;'>未审查</td>";//待初审21
                                         if ( cookie.Get("powergroupid").equals("22") ){
                                            showAudetBtn =  1 ;
                                         }
                                    }
                                    if (list.get("iscs").equals("1")) {
                                        handle = "<td class='handle no' style='color:IndianRed;font-weight:bold;'>待复审</td>";//待复审31
                                        //showAudetBtn =  1 ;
                                        //ding 如果开会(通过代表团审核）并且代表团账号登录并且
                                        if (  list.get("isdbtshenhe").equals("1") && cookie.Get("powergroupid").equals("22") ){
                                            handle = "<td class='handle no' style='color:IndianRed;font-weight:bold;'>待复审</td>";//待复审31
                                        }
                                        
                                        //ding 2021.3.31
                                         if ( cookie.Get("powergroupid").equals("25") && list.get("examination").equals("5")){
                                            handle = "<td class='handle no' style='color:IndianRed;font-weight:bold;'>待复审</td>";//待复审31
                                        }
                                    }
                                    if (list.get("examination").equals("2")) {
                                        handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待交办</td>";//待交办41
                                        if ( list.get("handlestate").equals("2") || list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                           handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                    } 
                                    if (list.get("handlestate").equals("3")) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待交办</td>";//51
                                        if ( list.get("deal").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                           handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待办复</td>";
                                        }
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        handle = "<td class='handle no' style='color:Olive;font-weight:bold;'>已办复</td>";//151
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "<td class='handle no' style='color:CadetBlue;font-weight:bold;'>已置回</td>";//121
                                    }
                                    out.print(handle);
                                %>
	             

	            <td>
                            <%  //操作列
                            String pid = cookie.Get("powergroupid");
                            if (pid != null && (("8").equals(pid) || ("7").equals(pid) || ("22").equals(pid) || ("7").equals(pid) || ("25").equals(pid) ) && (showAudetBtn == 1)){
                            %>
                 	   
	             <span class="ys shencha" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight:bold;" >审查</span> | 
                            <%
                             }
                            %>

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
                                
                                settimeout(function(){
                                        location.reload();
                                        console.log()
                                },1000)
                            });

 //添加审查 查看 查看流程按钮响应
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



        </script>
    </body>
</html>