<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList list = new RssList(pageContext, "supervision_topic");
    RssList process = new RssList(pageContext, "supervision_topic_process");
    list.request();
    list.select().where("id=" + list.get("id") + "").get_first_rows();
    process.select().where("topicid=" + list.get("id") + "").get_page_desc("id");
    String a1 = "0", a2 = "0", a3 = "0", a4 = "0", b1 = "0", b2 = "0", b3 = "0", b4 = "0";
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
            .tabheader{background: #82bee9;text-align: center; color: #fff;line-height: 30px}
            .cellbor>tbody>tr>td,.cellbor>tbody>tr>th{border: #6caddc solid thin;line-height: 20px;}
            .dce{background: #dce6f5}
            .indent{text-indent: 10px}
            .res{float: right;}
        </style>
    </head>
    <body>
        <div>
            <div class="toolbar">
                <button type="button" class="res">返回上一级</button>
            </div>
            <table class="cellbor auto margintop"style="font-size:15px;font-family: 微软雅黑">
                <input type="hidden" id="transadapter" find="[name='id']" value="<%list.write("id");%>" />
                <input type="hidden" id="topicid" value="<%list.write("id");%>" />
                <tr>
                    <td colspan="5" class="tabheader"><%list.write("title");%></td>
                </tr>
                <tr class="dce">
                    <th class="w30"></th>
                    <th class="w100" style="font-size:15px;font-family: 微软雅黑" >查看</th>
                    <!--<th class="w100">内容</th>-->
                    <th class="w100" style="font-size:15px;font-family: 微软雅黑" >说明</th>
                    <th class="w100">状态</th>
                    <%if (req.get("status").equals("1")) {%><th class="w100" style="font-size:15px;font-family: 微软雅黑">操作</th><%}%>
                </tr>
                <%
                    String state = "0";
                    String processid="0";
                    for (int i = 1; i <= 10; i++) {
                        while (process.for_in_rows()) {
                            if (process.get("typeid").equals(i + "")) {
                                state = process.get("state");
                                processid = process.get("id");
                            }
                        }
                %>
                <tr align="center">
                    <td class="w30"><% out.print(i); %></td>
                    <td><a supervisiontopicduty="<%out.print(i);%>" <%if((!processid.equals("0"))&&i!=2&&i!=7&&i!=8){%> href="javascript:dutyview(<%out.print(processid);%>,<%out.print(i);%>) "<%}else{%>style="color: #000;"<%}%>  ></a></td>
                    <!--<td></td>-->
                    <td align="left" class="w400 indent"  ></td>
                    <td suptopicstate="<%out.print(state);%>"></td>
                   <%if (req.get("status").equals("1")) {%> <td><a transadapter="dytz<%out.print(i);%>" select="false"><%out.print(i == 2 || i == 7 || i == 8 ? "查看审核列表" : "添加");%></a></td><%}%>
                </tr>
                <%
                        state = "0";
                        processid="0";
                    }
                %>

            </table>
        </div>
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            $(".res").click(function () {
              history.go(-1)
            });
            function dutyview(id,typeid){ 
                popuplayer.display("/supervision/topic/duty/dutyview.jsp?processid=" + id + "&typeid="+typeid+"&TB_iframe=true", '查看', {width: 830, height: 500});
            }
        </script>
    </body>
</html>