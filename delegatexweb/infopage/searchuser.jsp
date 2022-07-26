<%-- 
    Document   : searchuser
    Created on : 2018-7-23, 10:18:09
    Author     : Administrator
--%>

<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            body>div:first-child{margin-bottom: 100px;}
            #header{width: 98%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }
            nav{margin: 21px 22px 0px 22px;height: 28px;z-index: 2;}
            nav>a{border: #eee solid 2px;padding: 5px 12px; margin-right: 3px;background: #f7f7f7;cursor: pointer;}
            nav>.sel{border-bottom:#f7f7f7 solid 4px;}
            ul{margin: 10px; padding: 0;}
            ul>li{list-style-type: none;display: inline-block; width:100%;line-height: 28px;font-size: 14px;text-align: center;cursor: pointer; background: #e3e3e3;margin: 10px 0}
            ul>li>table{width: 100%;background: #fff; border-bottom: #cccccc solid 1px; border-right: #cccccc solid 1px;}
            ul>li>table td{border-top: #cccccc solid 1px;border-left: #cccccc solid 1px;width: 200px}
            ul>li>h2{ margin: 0; text-align: left; text-indent: 10px;font-size: 14px;background: #cd0100; color: #fff; border-top: #b11308 solid 2px; border-bottom: #b11308 solid 2px}
            #infotable>h1{background: url(../img/h1background.png);line-height: 24px;font-size: 14px; text-align: left;font-weight: 600; color: #bb0000; text-indent: 10px;margin: 0;border-bottom: #ad0101 solid 2px;}
            ul>li img{width: 100px;height: 130px;margin: 10px;}
            .lihead{width: 180px;}
            .selul{display: block;}
            #infotable{margin: 8px 22px;border: #eee solid 2px;padding:0; background: #fffbf1;}
            #footer{ background: #eee; position: fixed;bottom: 0; width: 100%;text-align: center; margin: 0 auto;height: 88px; padding-top: 10px;left:0}
            #footer p{line-height: 22px;font-size: 14px; margin: 0;}
            .popuplayer,.calendarwrap{display: none;}
            .footer{ padding-left: 20px;line-height: 30px;}
            .footer object { vertical-align: middle; }
            .footer button.right{ float:right; margin-top:5px;}
            .pagination a{ margin: 0 2px;}
            .pagination a.selected{ color: red;}
        </style>
    </head>
    <body>
        <div>
            <div id="header"></div>
            <div id="infotable">
                <h1>代表查询</h1>
                <ul>
                    <%
//                        zyx 更换视图，原因查询代表时现实的页面代表团为空。
                        RssListView list = new RssListView(pageContext, "user_delegation");//userrole
                        list.request();
                        int a = 1;
                        list.pagesize = 10;
//                        list.select().where("realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and state=2 and circleslist like '%" + URLDecoder.decode(list.get("circles"), "utf-8") + "%' ").get_page_desc("myid");
                        list.select().where("realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and isdelegate=1 and circleslist like '%" + URLDecoder.decode(list.get("circles"), "utf-8") + "%' ").get_page_desc("myid");

                        //梁小竹修改，注释掉了下一行
//                        list.for_in_rows();
                        while (list.for_in_rows()) {
//                            System.out.println("++++++++++++++++++++++++++");
                            
                    %>
                    <li myid="<% out.print(list.get("myid"));%>">
                        <h2><% out.print(list.get("realname"));%></h2>
                        <table cellspacing="0">
                            <tr>
                                <td class="lihead" rowspan="4"><img src="/upfile/<% out.print(list.get("avatar"));%>" alt=""/></td>
                                <td>姓名</td><td><% out.print(list.get("realname"));%></td><td>性别</td><td sex="<% list.write("sex"); %>"></td>
                            </tr> 
                            <!--<tr><td>选区</td><td>未知</td><td>出生年月</td><td rssdate="<% list.write("birthday"); %>,yyyy-MM"></td></tr>-->
                            <tr><td>民族</td><td nationid="<% list.write("nationid"); %>">汉族</td>
                                <td>代表团</td><td><span><% out.print(list.get("delegationname"));%></span></td>
                            </tr>
                            <tr>
                                <td>职务</td><td><span><% list.write("daibiaoDWjob"); %></span></td>
                                <td>代表级别</td><td colspan=""><p><%
//                                String[] circleslist = {"乡镇人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};//所属层次
                                String[] circleslist = {"全国人大代表", "河南省人大代表", "平顶山市人大代表", "汝州市人大代表", "乡镇人大代表"};//所属层次

                                //String[] circleslist = {"乡镇人大代表", "市人大代表", "盟人大代表", "区人大代表", "全国人大代表"};//所属层次
                                String[] arry = list.get("circleslist").split(",");

                                String arrylist = "";
                                for (int ind = 0; ind < arry.length; ind++) {
                                    if (!arry[ind].equals("") && !arry[ind].equals("undefined")) {
                                        int arryint = Integer.valueOf(arry[ind]);
                                        arrylist += circleslist[arryint] + "，";
                                    }
                                }
                                if (!arrylist.equals("")) {
                                    arrylist = arrylist.substring(0, arrylist.length() - 1);
                                }
                                out.print(arrylist);
                                %></p></td></tr>
                        </table>
                    </li>
                    
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </div>
        <div id="footer">
<!--            <p>汝州市人大常委会主办</p>
            <p>技术支持：汝州市人大常委会信息中心</p>-->
            <p style="margin-top:-10px;">&nbsp;&nbsp;&nbsp;</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主办：汝州市人大常委会办公室&nbsp;&nbsp;<a class="ml80" href="https://beian.miit.gov.cn/" target="_blank">豫ICP备17035523号</a></p>
            <p>电话：0375-6862978<span class="ml144">邮编：467500</span></p>
            <p>地址：平顶山市汝州市丹阳中路268号</p>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>
            window.onscroll = function () {
                if ($(this).scrollTop() >= $(document).height() - $(window).height()) {
                    $("#footer").show();
                } else {
                    $("#footer").hide();
                }
            };
            if ($(document).height() > $(window).height()) {
                $("#footer").hide();
            }
            $("li").click(function () {
                var relationid = $(this).attr("myid");
                location.href = "/delegatexweb/infopage/delegateinfo.jsp?relationid=" + relationid;
            })
        </script>
    </body>
</html>
