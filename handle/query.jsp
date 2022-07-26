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
    RssListView list = new RssListView(pageContext, "sort");
    list.request();
    list.select().where("id=?", list.get("id")).get_first_rows();
    
    RssList suggestTable = new RssList(pageContext, "suggest");
    suggestTable.request();
    suggestTable.select().where("id=?", suggestTable.get("id")).get_first_rows();
%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>

            .popupwrap{width: 98%}
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
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%}
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{height: 100%;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 790px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            .h210{height: 210px}
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            .shu{line-height: 15px;text-align: center;}
            .uetd>ul{left: 0}
            .cellbor>tbody>tr .line{line-height: 24px}
            textarea{width: 99%;height: 60px;margin: 5px 0;}
            .uetd>div>p{min-height: 100%;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            #resumeinfo{display: none;}
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{min-height: 100%;}
            div .xZz{width: 70%;border: 0px;}
            div .xz{width: 70%;border: 0px;};
            .popupwrap div>tr:last-of-type{height: 297px;}
            .iframe{height: 90%;height: 245px;}
            .bg{font-size:14px;height:100%;background:#FFF;margin:0 .9%;padding:3px;border:#6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
                    <tr>
                        <td colspan="20" class="tabheader"><% list.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">编号：</td>
                        <td class="w261" colspan="16"><% out.print(list.get("realid")); %></td>
                    </tr>
    <!--zyx-->
                     <tr>
                        <td class="dce" colspan="4">标题：</td>
                        <td colspan="16"><% list.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">办理方式：</td>
                        <td class="w261" colspan="6"><% 
                            if( suggestTable.get("way").equals("1")){
                            out.print("书面");
                            }else if( suggestTable.get("way").equals("2")){
                            out.print("平台");
                            }else if( suggestTable.get("way").equals("3")){
                            out.print("其他");
                            }else if( suggestTable.get("way").equals("4")){
                            out.print("面商");
                            }; 
                        %></td>
                        <td class="dce" colspan="4">办理情况：</td>
                        <td class="w261" colspan="6"><%
                           if(suggestTable.get("degree").equals("1")){
                            out.print("已解决");
                            }else if( suggestTable.get("degree").equals("2")){
                            out.print("正在解决");
                            }else if( suggestTable.get("degree").equals("3")){
                            out.print("列入计划解决");
                            }else if( suggestTable.get("degree").equals("4")){
                            out.print("因条件限制无法解决");
                            }; 
                        %></td>
                    </tr>
    <!--end-->
<!--
                    <tr>
                        <td class="dce" colspan="4">届次：</td>
                        <td colspan="16" sessionclassify="<% list.write("sessionid"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">会议次数：</td>
                        <td colspan="16" companytypeeeclassify="<% list.write("meetingnum"); %>"></td>
                    </tr>
 -->                   
                    <tr>
                        <td class="dce" colspan="4">领衔代表：</td>
                        <td class="w261" colspan="6"><% out.print(list.get("realname")); %></td>
                        <td class="dce" colspan="4">类型：</td>
                        <!--td class="w261" colspan="6" classify="<% out.print(list.get("lwstate")); %>"></td> -->
                        <td class="w261" colspan="6" classify="
                            <%   
                                if (list.get("lwstate").equals("1")) {
                                    out.print("建议");
                                } 
                                else if (list.get("lwstate").equals("2")) {
                                    out.print("议案");
                                } 
                                else if (list.get("lwstate").equals("3")) {
                                    out.print("批评");
                                } 
                                else if (list.get("lwstate").equals("4")) {
                                    out.print("意见");
                                } 
                                else if (list.get("lwstate").equals("5")) {
                                    out.print("质询");
                                } 
                            %> "></td>
                    </tr>

<!---added by ding for get co-signer-->
	     <tr>
                        <td class="dce" colspan="4">联名代表：</td>
                        <td colspan="16">                                   
 			<%
                            if (!list.get("id").isEmpty()) {
                                RssListView secondlist = new RssListView(pageContext, "second_user");
                                secondlist.select().where("suggestid=" + list.get("id")).query();
                                
                                while (secondlist.for_in_rows()) {
                        %>
                                             
			    <% out.print(secondlist.get("realname"));%>
			    <% out.print("    ");%>
                            <%
                             }
                              }
                             %>
                        
	       </td>
                    </tr>
<!---added by ding for get co-signer end -->


                    <tr>
                        <td class="dce" colspan="4">主办单位：</td>
                        <td colspan="16"><% list.write("realcompanyname"); %></td>
                        <!--                        <td class="dce" colspan="4">办理类型：</td>
                                                <td class="w261" colspan="6" handle="<% out.print(list.get("handle")); %>"></td>-->
                    </tr>

   	    <tr>
                        <td class="dce" colspan="4">协办单位：</td>                 
                         <td colspan="16"><% suggestTable.write("coorganisername"); %></td>
                    </tr>
                    <tr>
                        <td class="dce" colspan="4">交办日期：</td>
                        <td class="w261" colspan="6" rssdate="<% list.write("shijian"); %>,yyyy-MM-dd HH:mm:ss"></td>
                        <td class="dce" colspan="4">要求办结日期：</td>
                        <td class="w261" colspan="6" rssdate="<% list.write("stop"); %>,yyyy-MM-dd  HH:mm:ss"></td>
                    </tr>
                    <tr>
<!--zyx  面商查看-->
<%
if ( suggestTable.get("way").equals("4")){
    %>

            <tr>
                <td colspan="20" class="tabheader"><% out.print( "面商信息" ); %></td>
            </tr>
            <td class="dce" colspan="4">面商地点：</td>
	<td class="w261" colspan="6"><% out.print(suggestTable.get("discussbank")); %></td>
 	<td class="dce" colspan="4">面商时间：</td>
  	<td class="w261" colspan="6"><input type="text" class="xz" rssdate="<% suggestTable.write("discussinspecttime");%>"></td>
        <tr>
        <td class="dce" colspan="4">面商附件：</td>
  	<td class="w261" colspan="12">
           <%
                                    String[] arry2 = {"", "", ""};
                                    if (!suggestTable.get("discussenclosure").isEmpty()) {
                                        String[] str2 = suggestTable.get("discussenclosure").split(",");
                                        for (int idx = 0; idx < str2.length; idx++) {
                                            arry2[idx] = str2[idx];%>
                                            <p><input class="xZz" style="font-weight: bold" value="<% out.print(suggestTable.get("discussenclosurename")); %>"/><a href="/upfile/<% out.print(arry2[idx]); %>" style="cursor: pointer;color: blue;font-weight: bold">点击下载</a></p>
                               <%
                                             }
                                     }
             %>
        </td>
        </tr>
        <%
        }
        %>
<!--zyx  end-->
	<tr>
                        <td colspan="20" class="tabheader"><% out.print( "负责人信息" ); %></td>
                </tr>
	<td class="dce" colspan="4">承办负责人：</td>
	<td class="w261" colspan="6"><% out.print(suggestTable.get("firstperson")); %></td>
 	<td class="dce" colspan="4">职务：</td>
  	<td class="w261" colspan="6"><% out.print(suggestTable.get("firstpost")); %></td>
	<tr>
                        <td colspan="20" class="tabheader"><% out.print( "承办人信息" ); %></td>
                </tr>
	<td class="dce" colspan="4">具体承办人：</td>
	<td class="w261" colspan="6"><% out.print(suggestTable.get("firstperson")); %></td>
 	<td class="dce" colspan="4">职务：</td>
  	<td class="w261" colspan="6"><% out.print(suggestTable.get("firstpost")); %></td>
<!--
                        <td class="dce" colspan="4">办复人：</td>
                        <%
                            RssListView company = new RssListView(pageContext, "suggest_company");
                            company.select().where("suggestid=" + list.get("id")).get_first_rows();
                            if (list.get("BanFuName").isEmpty() && list.get("BanFutel").isEmpty()) {
                        %>
                        <td class="w261" colspan="6"><% out.print(company.get("linkman")); %></td>
                        <td class="dce" colspan="4">办复人电话：</td>
                        <td class="w261" colspan="6"><% out.print(company.get("worktel")); %></td>
                        <%
                        } else {
                        %>
                        <td class="w261" colspan="6"><% out.print(list.get("BanFuName")); %></td>
                        <td class="dce" colspan="4">办复人电话：</td>
                        <td class="w261" colspan="6"><% out.print(list.get("BanFutel")); %></td>
                        <%
                            }
                        %>
-->
                    </tr>
                    <tr id="baidubjq">
                        <td colspan="20" class="uetd">
                            <ul><li class="sel">内容摘要</li><li>办复信息</li><li>操作日志记录</li></ul>
                            <!--<div class="edui-default">-->
                               <div class="iframe"><p><iframe src="query_1.jsp?id=<% out.print(list.get("id"));%>"></iframe></p></div>
                            <!--</div>-->
                            <div id="resumeinfo">

                                <h6>办复附件</h6>
                                <%
                                    RssList user1 = new RssList(pageContext, "suggest");
                                    user1.select().where("id=?", list.get("id")).get_first_rows();
                                    String[] arry1 = {"", "", ""};
                                    if (!list.get("dfenclosure").isEmpty()) {
                                        String[] str = list.get("dfenclosure").split(",");
                                        for (int idx = 0; idx < str.length; idx++) {
                                            arry1[idx] = str[idx];%>
                                            <p><input class="xZz" style="font-weight: bold" value="<% out.print(user1.get("dfenclosurename")); %>"/><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;font-weight: bold">点击下载</a></p>
                               <%
                                             }
                                     }
                                    %>
<!--                                <h6>意见说明</h6>
                                <p class="yjsm"><% list.write("comments"); %></p>-->
                                <h6>办理报告</h6>
                                <div class="bg"><% list.write("resumeinfo");%></div>
                            </div>
                            <div id="resumeinfo">

                                <p class="yjsm">
                                    <%
                                        if (!(list.get("ProposedBill").isEmpty())) {
                                    %>
                                    提交时间：<input type="text" class="xz" rssdate="<% list.write("ProposedBill");%>"><br>
                                    <%
                                        }
                                        if (!(list.get("InitialReviewTime").isEmpty())) {
                                    %>
                                    初审时间：<input type="text" class="xz" rssdate="<% list.write("InitialReviewTime");%>"><br>
                                    <%
                                        }
                                        if (!(list.get("ReviewTime").isEmpty())) {
                                    %>
                                    复审时间：<input type="text" class="xz" rssdate="<% list.write("ReviewTime");%>"><br>
                                    <%
                                        }
                                        if (!(list.get("xzReviewTime").isEmpty())) {
                                    %>
                                    乡镇人大主席团审查时间：<input type="text" class="xz" rssdate="<% list.write("xzReviewTime");%>"><br>
                                    <%
                                        }
                                        if (!(list.get("AssignedByTime").isEmpty())) {
                                    %>
                                    交办时间：<input type="text" class="xz" rssdate="<% list.write("AssignedByTime");%>"><br>
                                    <%
                                        }
                                        if (!(list.get("ResponseTime").isEmpty())) {
                                    %>
                                    答复时间：<input type="text" class="xz" rssdate="<% list.write("ResponseTime");%>"><br>
                                    <%
                                        }
                                    %>
                                </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <!--<script src="/data/bill.js" type="text/javascript"></script>-->
        <script src="controller.js"></script>
        <script src="../data/session.js" type="text/javascript"></script>
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })
        </script>
    </body>
</html>
