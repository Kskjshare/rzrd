<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
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
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssListView users = new RssListView(pageContext, "user_delegation");
    users.request();
    int totalDelegate = 0;
    users.pagesize = 30;
    users.select().where("code like '%" + URLDecoder.decode(users.get("code"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(users.get("realname"), "utf-8") + "%' and state=2").get_page_desc("myid");
    totalDelegate = users.totalrows ;
    
  
   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="http://at.alicdn.com/t/font_2302402_bg6iekzy8yi.css" rel="stylesheet" />
        <script src="./api/ch.js"></script>
        <style>
            .cellbor tbody>.sel>td{background: #dce6f5}
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .no{display: none}
            tbody tr:hover{background-color: gainsboro;}
            /*.zhongdian{float: right; margin-right: 20px;}*/
            .ys{
                color: blue;
            }
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch" powerid="145">快速查询</button>
                <!--<button type="button" transadapter="supersearch" select="false" class="supersearch" powerid="145">高级查询</button>-->
                <!--<button type="button" transadapter="append" select="false" class="butadd" powerid="146">增加</button>-->
                <%
                    RssListView entity = new RssListView(pageContext, "sort");
                    entity.select().where("myid=?", UserList.MyID(request)).get_first_rows();
                    if (!(entity.get("draft").equals("1"))) {
                %>
                <!--<button type="button" transadapter="edit" class="butedit" powerid="147">编辑</button>-->
                <!--<button type="button" transadapter="delete" class="butdelect" powerid="148">删除</button>-->
                <%
                    }
                %>
                <!-- removed by ding --->
                <!--button type="button" transadapter="butreview" class="butreview" powerid="150">审查</button-->
                <!--<button type="button" transadapter="butview" class="butview" powerid="149">查看</button>-->
                <!--button type="button" transadapter="butimportance" class="butimportance" powerid="142">重点建议</button-->
                <!--                
                <button type="button" transadapter="butexcellent" class="butexcellent" powerid="152">优秀建议</button>
                <button type="button" transadapter="importancelist" select="false" class="butexcellent" powerid="143"><% out.print(URLDecoder.decode(req.get("importance"), "utf-8").equals("2") ? "展示全部建议" : "罗列重点建议");%></button>
                <button type="button" transadapter="butreports" select="false" class="butreports" powerid="153">报表</button>
                <button type="button" transadapter="print" class="butimportance" powerid="">打印</button>
               
                <button type="button" id="prints" transadapter="prints" class="butimportance">导出</button>
                -->
                <button type="button" class="setup" style="display: none;">设置</button>
                <!--<div style="display: inline; position: relative;"><i onclick="reload()" class="iconfont iconshuaxin" style="cursor: pointer; font-size:18px; color:#56c21e; position: relative; top: 4px; right:2px;"></i></div><input onclick="reload()" type="button" value="刷新" style="cursor: pointer; border:none; background-color: #ffffff; color: #2d6c86;" />-->
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
                    <li><label><input type="checkbox" name="field" sel="handle" checked="checked">进度</label></li>
                    <li><label><input type="checkbox" name="field" sel="degree">解决程度</label></li>
                    <li><label><input type="checkbox" name="field" sel="realcompanyname" checked="checked">主办单位</label></li>
                </ul>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w50">序号</th>
                            <!--<th class="w30"><input name="all" type="checkbox"></th>-->
                            <!--<th class="w60">来文号</th>
                            <th class="w60">编号</th>
                            -->
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
                            <!--<th class="handle no">进度</th>-->
                          
                            <th class="realcompanyname no">满意率</th>
                            <th class="realcompanyname no">基本满意率</th>
                            <th class="realcompanyname no">不满意率</th>
                            
                            <th class="handle no">操作</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String powerid = cookie.Get("powergroupid");
                            String keywhere = "";
                            String view = "sort";
                    

                            
                          keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" +
                                            URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + 
                                            URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" +
                                            URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + 
                                            URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + 
                                            URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" + 
                                            URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" +
                                            URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + 
                                            URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + 
                                            URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" +
                                            URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" +
                                            URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" +
                                            URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and draft=2" ;    
                            
                            RssListView list = new RssListView(pageContext, view); 
                            list.request();
 
                            int a = 1;
                            list.pagesize = 1000;
                            
                            list.select().where(keywhere).get_page_desc("shijian");
                            //list.select().where(keywhere).get_page_desc("realid");
                            
                           
                             
                     
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbdmlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td  class="w30"><% out.print(a); %></td>
                            <!--<td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>-->
                            <!--
                            <td>lw<% // out.print(list.get("lwid")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
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
                            <!--<td class="handle no">-->
                                <% //examination:    审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查
                                    //draft:起草1草稿2已提交    待初审    待交办         待复审
                                    //deal:是否已交办 //iscs初审状态（0否 1是)//isxzsc：乡镇政府办审查状态(0否 1是）
                                    //handlestate:（确定办理单位）建议议案办理状态1:未确定,2待确定,3已确定,4申退中//resume:是否办复(0否 1是）
                                    String handle = "";
                                    
                                    //added by ding
                                    int btnAuditShow = 1 ; // 审查按钮
                                  
                                    if (list.get("examination").equals("1")) {
                                        handle = "<td class='handle no' style='color:red'>未审查</td>";//待初审21
                                       
                                    }
                                    if (list.get("iscs").equals("1")) {
                                        handle = "<td class='handle no' style='color:IndianRed'>待复审</td>";//待复审31
                                       
                                      
                                    }
                                    if (list.get("examination").equals("2")) {
                                        handle = "<td class='handle no'style='color:DarkOrange' >待交办</td>";//待交办41
                                        btnAuditShow = 0 ;
                                         if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                           handle = "<td class='handle no'style='color:DarkOrange' >待复审</td>";
                                        }
                                         if ( list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                          btnAuditShow = 1;
                                         }
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        //修改闭会乡镇代表流程，提示状态
                                        //handle = "<td class='handle no' style='color:Green'>乡镇政府办已答复</td>";//141
                                        handle = "<td class='handle no' style='color:DarkOrange'>待交办</td>";//141
                                        btnAuditShow = 0 ;
                                           if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                            handle = "<td class='handle no'style='color:DarkOrange' >待复审</td>";
                                        }
                                    }
                                    if (list.get("handlestate").equals("3")) {
                                        handle = "<td class='handle no' style='color:Chocolate'>待交办</td>";//51
                                        btnAuditShow = 0 ;
                                        if ( list.get("deal").equals("1") ) {
                                            handle = "<td class='handle no' style='color:Chocolate'>待办复</td>";//51
                                        }
                                    }
                                    if (list.get("handlestate").equals("4")) {
                                        handle = "<td class='handle no' style='color:Chocolate'>已驳回</td>";//51
                                        btnAuditShow = 0 ;
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        handle = "<td class='handle no' style='color:Olive'>已办复</td>";//151
                                        btnAuditShow = 0 ;
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "<td class='handle no' style='color:CadetBlue'>已置回</td>";//121
                                        btnAuditShow = 0 ;
                                    }
//                                    out.print(handle);
                                %>
                                <!--</td>-->
                                
                              <td class="realcompanyname no">
                                <%
                                RssList sentity1 = new RssList(pageContext, "overall_satisfaction");
                                sentity1.request();
                                sentity1.select().where( "evaluation=1 and proposal="+ list.get("id") ).get_page_desc("id");
                                         
                                float totaldelegagte1 = totalDelegate;  
                                float satisfaction = sentity1.totalrows ;
                                out.print( satisfaction/totaldelegagte1 );
                                out.print("%");   
                                    
                                %>
                            </td>
                            
                              <td class="realcompanyname no">
                                <%
                                RssList sentity2 = new RssList(pageContext, "overall_satisfaction");
                                sentity2.request();
                                sentity2.select().where( "evaluation=2 and proposal="+ list.get("id") ).get_page_desc("id");
                                         
                                float totaldelegagte2 = totalDelegate;  
                                float basicsatisfaction = sentity2.totalrows ;
                                out.print( basicsatisfaction/totaldelegagte2 );
                                out.print("%");   
                                    
                                %>
                            </td>
                            <td class="realcompanyname no">
                                <%
                                                                                     
                                RssList sentity3 = new RssList(pageContext, "overall_satisfaction");
                                sentity3.request();
                                sentity3.select().where( "evaluation=3 and proposal="+ list.get("id") ).get_page_desc("id");
                                   
//                              float dissatisfaction = counter3 ;        
                                float totaldelegagte3 = totalDelegate;  
                                float dissatisfaction = sentity3.totalrows ;
                                out.print( dissatisfaction/totaldelegagte3 );
                                out.print("%");   
                                %>
                            </td>

                            <td>
                            <span class="ys chakan" id="<% out.print(list.get("id")); %>" style='font-weight:bold;'>查看内容</span> | 
                            <span class="ys detail" id="<% out.print(list.get("id")); %>" style='font-weight:bold;'>查看测评详情</span>       
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
                popuplayer.display("/suggest/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".detail").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/opinion/evaluation/evaluationview.jsp?id=" + id + "&TB_iframe=true", '测评详情', {width: 830, height: 360});
                })
            });
            $(function(){
                ﻿$(".liucheng").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                popuplayer.display("/opinion/evaluation.jsp?id=" + id + "&TB_iframe=true", '满意度测评', {width: 830, height:280});
     
                })
            });
            
             $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                popuplayer.display("/opinion/evaluationEdit.jsp?id=" + id + "&TB_iframe=true", '进行测评', {width: 830, height: 360});
     
                })
            });
            
            
            
		transadapter["prints"] = function (t)
		{
			location.href="/report/print.jsp?id=" + transadapter.id
			//popuplayer.display("/report/print.jsp?id=" + transadapter.id + "&TB_iframe=true", '导出', {width: 550, height: 550});
		}
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
//            $("#footerpagesize").change(function () {
//                location.href="?curpage1&pagesize="+$(this).val();
//            })

transadapter["delete"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/suggest/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}


transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/opinion/evaluation/quicksearch.jsp", '快速查询', {width: 500, height:100});
}

        </script>
    </body>
</html>
