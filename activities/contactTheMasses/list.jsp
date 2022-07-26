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
    RssListView list = new RssListView(pageContext, "activitiesmy");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    list.request();
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
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">添加活动</button>
                <!--<button type="button" transadapter="doattendance" class="butedit">手动补签</button>-->
                <!--<button type="button" transadapter="attendance" class="butview">述职人员</button>-->
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="export" class="butreports">导出</button>-->
                <input type="hidden" id="classify" value="<%list.write("classify");%>" />
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <!--<th>编号</th>-->
                            <th>标题</th>
                            <!--<th>发布人</th>-->
                            <!--<th>履职类型</th>-->
                            <th>创建时间</th>
                            <th>活动时间</th>
                            <!--<th>结束时间</th>-->
                            <!--<th>审核意见</th>-->
                            <th>审核状态</th>
                            <!--<th>活动内容</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <!--sal>(select SAL from emp where ename='CLARK')-->
                        <%

                            list.pagesize = 30;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 10;
                            }
                            int a = 1;
                            String powergroupid = cookie.Get("powergroupid");
                            String sql = "";
                            if (powergroupid.equals("22")) {
                                sql = "myid =" + UserList.MyID(request);
                            } else {
                                sql = "myid =" + UserList.MyID(request);
                                if (powergroupid.equals("16")) {
                                    sql = "myid <> 0";
                                }
                            }
                            sql += " and classify=" + list.get("classify");
                            sql += " and title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'";
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>"  style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" idState="<%out.print(list.get("state"));%>" /></td>
                            <!--<td><% out.print(list.get("realid")); %></td>-->
                            <td><% out.print(list.get("title")); %></td>
                            <!--<td><% // out.print(list.get("realname")); %></td>-->
                            <!--<td activitiestypeclassify="<%list.write("classify");%>"></td>-->
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                            <!--<td rssdate="<% out.print(list.get("finishshijian")); %>,yyyy-MM-dd" ></td>-->
                            <!--<td><% out.print(list.get("closenote")); %></td>-->
                            <td>
                                <%
                                    String html = "";
                                    if (list.get("state").equals("1")) {//1为待审核，2为通过,3为未通过
//                                        html += "<a style='text-decoration: none;' href='javascript:closeDbLzhd(\"" + list.get("id") + "\",1)'>通过</a>";
//                                        html += "<a style='text-decoration: none;' href='javascript:closeDbLzhd(\"" + list.get("id") + "\",2)'>驳回</a>";
                                          html += "<a style=' text-decoration: none; color:black;' href='javascript:void(0);'>待审核</a>";
                                    } else if(list.get("state").equals("2")) {
                                        html += "<a style=' text-decoration: none; color:#008B45;' href='javascript:void(0);'>通过</a>";
                                    }else{
                                        html += "<a style=' text-decoration: none; color:#CD0000;' href='javascript:void(0);'>驳回</a>";
                                    }
//                                    html += "&nbsp;|&nbsp;<a style=' text-decoration: none;' href='javascript:flowStepRecord(\"" + list.get("id") + "\");'>日志</a>";
                                    out.print(html);
                                %>
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
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script>
            var classify =<%req.write("classify");%>
//            var State = <%list.write("state");%>
//            console.log(State,"vvv")
        </script>
        <script src="controller.js"></script>
        <script>
            function closeDbLzhd(id,flag) {
                //flag为判断点击通过未通过的旗帜
//                if(flag === 1){
//                    popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true" + "&flag=1", '填写关闭原因', {width: 600, height: 330});
//                }else{
//                    popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true" + "&flag=2", '填写关闭原因', {width: 600, height: 330});
//                }
                popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true&flag="+flag, '联系群众活动审核', {width: 600, height: 330});
            }
        </script>
    </body>
</html>