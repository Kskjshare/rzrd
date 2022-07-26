<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <style>
            .cellbor span{color:#186aa3 ;cursor: default;}
            .bodywrap.nofooter {
                bottom: 29px;
            }
            span:nth-child(1){font-weight:bold;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch" powerid="113">查询</button>
                <button type="button" transadapter="edit" powerid="132">编辑</button>
                <button type="button" transadapter="append" select="false" powerid="131">添加</button>
                <button type="button" transadapter="delete" powerid="133">删除</button>
                <!--                <button type="button" transadapter="power">权限</button>-->
                <button type="button" transadapter="apd" select="false" class="butreports" powerid="135">导入</button>
                <button type="button" transadapter="export" class="butreports" powerid="134">导出</button>
                <button type="button" transadapter="piliangLX" class="butreports" powerid="156">用户类型批量管理</button>
                <button type="button" transadapter="piliangYH" class="butreports" powerid="157">用户组别批量管理</button>
                <button type="button" transadapter="piliang" class="butreports" powerid="155">角色组别批量管理</button>
                <input type="hidden" id="transadapter" find="[name='myid']:checked" />
            </div>
            <div class="bodywrap nofooter">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input type="checkbox" name="all"></th>
                            <th class="w50">序号</th>
                            <th class="w50">操作</th>
                            <th>登录名</th>
                            <th>用户姓名</th>
                         <!--   <th>用户组别</th> //-->
                            <th>角色组别</th>
                            <th>注册日期</th>
                            <th>启用状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "userrole");
                            list.request();
                            list.pagesize = 30;
                            if (cookie.Get("powergroupid").equals("16") || cookie.Get("powergroupid").equals("8")) {//16系统管理员8选联委
                                int my = Integer.parseInt(cookie.Get("myid"));
                                list.select().where("realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and rolelist like '%" + URLDecoder.decode(list.get("rolelist"), "utf-8") + "%' and departmentid like '%" + URLDecoder.decode(list.get("departmentid"), "utf-8") + "%' and myid <>1 and myid <>" + my + " and powergroupid<>5 and powergroupid<>18 and powergroupid<>22 and powergroupid<>16").get_page_desc("myid");//16系统管理员23区县政府办25乡镇政府办5代表18承办单位22代表团不显示
                            } else {
                                list.select().where("realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and rolelist like '%" + URLDecoder.decode(list.get("rolelist"), "utf-8") + "%' and departmentid like '%" + URLDecoder.decode(list.get("departmentid"), "utf-8") + "%' and myid <>1 and powergroupid<>5 and powergroupid<>18 and powergroupid<>22").get_page_desc("myid");////5代表18承办单位22代表团不显示
                            }

                            int a = 1;
                           // String str_pgid="";//added by jackie
                            while (list.for_in_rows()) {                               
                               // str_pgid = list.get("powergroupid");
                              //   System.out.println("str_pgid=="+str_pgid);
                               // if(!str_pgid.equals("5")&&!str_pgid.equals("18")&&!str_pgid.equals("22")){ //added by jackie/5代表18承办单位22代表团
                        %>
                        <tr>
                            <td><input type="checkbox" name="myid" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(a++);%></td>
                            <td><span tid="<% out.print(list.get("myid")); %>">编辑</span></td>
                            <td><% out.print(list.get("account")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <%
                         //       if (list.get("departmentid").equals("0")) {
                            %>
                      <!--      <td>暂无</td>//-->
                            <%
                          //  } else {
                            %>
                         <!--      <td department="<% out.print(list.get("departmentid")); %>"></td>-->
                            <%
                       //         }
                            %>

                            <td id="jse"><input type="hidden" name="rolelist" value="<% out.print(list.get("rolelist")); %>"></td>
                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd,hh:mm:ss"></td>
                            <td enabled="<% out.print(list.get("enabled")); %>"></td>
                        </tr>
                        <%
                               // }
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
        <script src="/data/staff.js"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script>
            for (var iii = 0; iii < $("tbody tr").length; iii++) {
                var circleslist = $("tbody tr").eq(iii).find("input[name='rolelist']").val().split(",");
                $.each(dictdata["powergroup"], function (k, v) {
                    if (circleslist != "0") {
                        if (circleslist.indexOf(k) != "-1") {
                            $("tbody tr").eq(iii).find("#jse").append("<span sesid=" + k + ">" + v + "</span>&nbsp;&nbsp;");
                        }
                    } else {
                        $("tbody tr").eq(iii).find("#jse").append("<span>" + 0 + "</span>");
                        return false;
                    }
                });
            }

            $("span[tid]").click(function () {

                var tid = $(this).attr("tid")
                var account = $(this).parent().next().text();
                console.log(account);
                popuplayer.display("/staff/edit.jsp?myid=" + tid + "&account=" + account + "&TB_iframe=true", '编辑', {width: 500, height: 330});
            })
        </script>
    </body>
</html>
