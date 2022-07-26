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
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="butview" class="butview">查看</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>限办时间</th>
                            <th>审核状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "supervision_topic_process_report_detail");
                            list.request();
                            list.pagesize = 30;
                            list.select().where("topictitle like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%' and topicstate=1 and state<>0 and processtypeid=" + list.get("typeid") + " and userroleid=" + UserList.MyID(request)).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><a href="../duty/list.jsp?id=<% out.print(list.get("topicid")); %>"><% out.print(list.get("topictitle")); %></a></td>
                            <td rssdate="<% out.print(list.get("deadline")); %>,yyyy-MM-dd" ></td>
                            <td supervisiontopicreceiptstate="<% out.print(list.get("state")); %>" ></td>
                            <td>
                                <%
                                    String html = "";
                                    if (list.get("state").equals("1") || list.get("state").equals("4")) {//"1": "待送回", "2": "待审核", "3": "审核通过", "4": "审核未通过"
                                        html += "<a style='text-decoration:none;' href='javascript:toReceipt(" + list.get("id") + ",\"" + list.get("topictitle") + "\")' >附件</a>";
                                        if (list.get("state").equals("4")) {
                                            html += "&nbsp;&nbsp;|&nbsp;&nbsp;<a style='text-decoration:none;' href='javascript:openAudit(" + list.get("id") + ")' >审核记录</a>";
                                        }
                                    } else {
                                        html += "<a style='text-decoration: none;' href='javascript:seeXdth(" + list.get("id") + ",\"" + list.get("topictitle") + "\")' >查看附件</a> ";
                                    }
                                    out.print(html);
                                %>
                            </td>
                        </tr>
                        <%
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

                            //送回审核页面
                            function toReceipt(id, title) {
                                popuplayer.display("/supervision/topic/receipt/receipt.jsp?id=" + id + "&title=" + title + "&TB_iframe=true", '送回审核', {width: 600, height: 360});
                            }
                            //查看内容
                            function seeXdth(id, title) {
                                popuplayer.display("/supervision/topic/receipt/seereceipt.jsp?id=" + id + "&title=" + title + "&TB_iframe=true", '查看附件', {width: 600, height: 360});
                            }
                            //查看审核记录
                            function openAudit(id) {
                                popuplayer.display("/supervision/topic/receipt/seeaudit.jsp?id=" + id + "&TB_iframe=true", '审核记录', {width: 1000, height: 550});
                            }

        </script>
    </body>
</html>