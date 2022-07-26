
<%@page import="java.net.URLDecoder"%>
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
        <link href="http://at.alicdn.com/t/font_2302402_0b3gu6zsq0t.css" rel="stylesheet" />
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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="422">编辑</button>
<!--                <button type="button" transadapter="demonstration1" class="butedit">设为规范化联络站</button>
                <button type="button" transadapter="demonstration" class="butedit">设为示范联络站</button>
                <button type="button" transadapter="demonstration2" class="butedit">设为明星联络站</button>
                <button type="button" transadapter="demonstration3" class="butdelect">恢复</button>-->
                <button type="button" transadapter="delete" class="butdelect" powerid="421">删除</button>
                <button type="button" transadapter="butview" class="butview">查看</button>
                <!--<button type="button" transadapter="json" select="false">创建JSON</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>联络站名称</th>
<!--                            <th>所属行政村</th>-->
                            <th>代表团</th>
<!--                            <th>管理员</th>-->
<!--                            <th>状态</th>-->
                            <!--<th>规范化等级</th>-->
                            <!--<th>市直代表入驻情况</th>-->
<!--                            <th>市直属代表入驻信息</th>-->
                            <th>代表入驻信息</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssListView list = new RssListView(pageContext, "contactstation");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            list.select().where("linkman like '%" + URLDecoder.decode(list.get("linkman"), "utf-8") + "%' and name like '%" + URLDecoder.decode(list.get("name"), "utf-8") + "%' ").get_page_asc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbAbRlclick();" idd="<% out.print(list.get("id")); %>" myid="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
<!--                            <td><% out.print(list.get("name")); %></td>-->
                            <%
                                if("1".equals(list.get("demonstration"))){
                            %>
                            <td><% out.print(list.get("name")); %></td>
                            <%
                                }else if("2".equals(list.get("demonstration"))){
                            %>
                            <!--<td><i style="margin: 0 5px; color: red;" class="iconfont iconhongqi"></i><% out.print(list.get("name")); %></td>-->
                             <td><% out.print(list.get("name")); %></td>
                            <%
                                }else if("3".equals(list.get("demonstration"))){
                            %>
                            <!--<td><i style="margin: 0 5px; color: green;" class="iconfont iconhongqi"></i><% out.print(list.get("name")); %></td>-->
                             <td><% out.print(list.get("name")); %></td>
                            <%
                                }else if("4".equals(list.get("demonstration"))){
                            %>
                            <!--<td><i style="margin: 0 5px; color: orange;" class="iconfont iconhongqi"></i><% out.print(list.get("name")); %></td>-->
                             <td><% out.print(list.get("name")); %></td>
                             <%
                                }
                            %> 
  
<!--                            <td ssxarea="<% out.print(list.get("street")); %>"></td>-->
                            <td><% out.print(list.get("allname")); %></td>
<!--                            <td><% out.print(list.get("linkman")); %></td>-->
                            <%
                                if("1".equals(list.get("demonstration"))){
                            %>
                            <!--<td class="zhuangtai" demonstration="<% out.print(list.get("demonstration")); %>"></td>-->
                            <%
                                }else if("2".equals(list.get("demonstration"))){
                            %>
                                <!--<td class="zhuangtai" style="color:red;font-weight:bold;" demonstration="<% out.print(list.get("demonstration")); %>"></td>-->
                            <%
                                } else if("3".equals(list.get("demonstration"))){
                            %>
                                <!--<td class="zhuangtai" style="color:green;font-weight:bold;" demonstration="<% out.print("规范化联络站"); %>"></td>-->
                            <%
                                }else if("4".equals(list.get("demonstration"))){
                            %>
                             <!--<td class="zhuangtai" style="color:orange;font-weight:bold;" demonstration="<% out.print("明星联络站"); %>"></td>-->
                            <%
                                }
                            %>                     
                            <td>
                                <%
                                    String html = "";
                                    //html += "<a style='font-weight:bold;' href='score_list.jsp?myid=" + list.get("myid") + "'>查看入驻信息</a>";
                                    html += "<a style='font-weight:bold;' href='score_list.jsp?myid=" + list.get("myid") + "&name=" + list.get("name") + "&allname="+  list.get("allname")  + "'>查看入驻信息</a>";
                                    //                                    html += "&nbsp;|&nbsp;<a style=' text-decoration: none;' href='javascript:flowStepRecord(\"" + list.get("id") + "\");'>日志</a>";
                                    out.print(html);
                                %>
                            </td>
<!--                            <td>
                                <%
//                                    html = "";
//                                    html += "<a style='text-decoration: none;' href='javascript:showLevelEdit("+list.get("id")+")'>编辑入驻</a>";
////                                    html += "&nbsp;|&nbsp;<a style=' text-decoration: none;' href='javascript:flowStepRecord(\"" + list.get("id") + "\");'>日志</a>";
//                                    out.print(html);
                                %>
                            </td>-->
                            <td style="display: none;"><% out.print(list.get("myid")); %></td>
                            
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
//            function showLevel(id) {
////                alert(flag);
//                //flag为判断点击通过未通过的旗帜
////                if(flag === 1){
////                    popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true" + "&flag=1", '填写关闭原因', {width: 600, height: 330});
////                }else{
////                    popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true" + "&flag=2", '填写关闭原因', {width: 600, height: 330});
////                }
////                alert(id);
//                popuplayer.display("/contactstation/showLevel.jsp?cid=" + id + "&TB_iframe=true", '查看市直代表入驻情况', {width: 600, height: 330});
//            }
//            function showLevelEdit(id) {
////                alert(flag);
//                //flag为判断点击通过未通过的旗帜
////                if(flag === 1){
////                    popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true" + "&flag=1", '填写关闭原因', {width: 600, height: 330});
////                }else{
////                    popuplayer.display("/activities/v2/admin/close.jsp?id=" + id + "&TB_iframe=true" + "&flag=2", '填写关闭原因', {width: 600, height: 330});
////                }
////                alert(id);
//                popuplayer.display("/contactstation/showLevelEdit.jsp?cid=" + id + "&TB_iframe=true", '市直代表入驻编辑', {width: 600, height: 500});
//            }
        </script>
        <script>
            //ch
        </script>
    </body>
</html>