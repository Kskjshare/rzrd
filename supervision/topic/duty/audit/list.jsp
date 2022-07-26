<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            /*.cellbor tbody>.sel>td{background: #dce6f5}*/
            /*             .cellbor thead,.w30{background:#f0f0f0 }
                       .cellbor tbody tr>td:first-child{display: none}
                       .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            tbody tr:hover{background-color: gainsboro;}
            .res{float: right;}

        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" class="res">返回上一级</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th>单位</th>
                            <th>状态</th>
                            <th>回复时间</th>
                            <th>审核时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "supervision_topic_process_report_detail");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("topictitle like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and topicid=" + list.get("topicid") + " and processtypeid=" + list.get("typeid") + " and state<>0 and myid=" + UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("company")); %></td>
                            <td supervisiontopicreceiptstate="<%list.write("state");%>"><% out.print(list.get("meetingname")); %></td>
                            <td rssdate="<% out.print(list.get("returnshijian")); %>,yyyy-MM-dd" ></td>
                            <td rssdate="<% out.print(list.get("auditshijian")); %>,yyyy-MM-dd" ></td>
                            <td>
                                <%
                                    String html = "";
                                    if (list.get("state").equals("1")) {//"1": "待送回", "2": "待审核", "3": "审核通过", "4": "审核未通过"
                                        html += "";
                                    } else if (list.get("state").equals("2")) {
                                        html += "<a style='text-decoration:none;' href='javascript:toAudit(" + list.get("id") + ")' >审核</a>";
                                        html += "&nbsp;&nbsp;|&nbsp;&nbsp;<a style='text-decoration: none;' href='javascript:seeXdth(" + list.get("id") + ",\"" + list.get("topictitle") + "\"," + list.get("processtypeid") + ")' >附件</a> ";
                                    } else if (list.get("state").equals("3")) {
                                        html += "<a style='text-decoration: none;' href='javascript:seeXdth(" + list.get("id") + ",\"" + list.get("topictitle") + "\"," + list.get("processtypeid") + ")' >附件</a> ";
                                        
                                    } else if (list.get("state").equals("4")) {
                                        html += "<a style='text-decoration: none;' href='javascript:seeXdth(" + list.get("id") + ",\"" + list.get("topictitle") + "\"," + list.get("processtypeid") + ")' >附件</a> ";
                                    }
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
        <script src="controller.js"></script>
        <script>
                            $(".res").click(function () {
                                history.go(-1);
                            });
                            //审核页面
                            function toAudit(id,) {
                                popuplayer.display("/supervision/topic/duty/audit/audit.jsp?id=" + id + "&TB_iframe=true", '审核', {width: 600, height: 380});
                            }
                            //查看内容
                            function seeXdth(id, title, typeid) {
                                popuplayer.display("/supervision/topic/duty/audit/seereceipt.jsp?id=" + id + "&title=" + title + "&typeid=" + typeid + "&TB_iframe=true", '查看附件', {width: 600, height: 360});

                            }
        </script>
    </body>
</html>