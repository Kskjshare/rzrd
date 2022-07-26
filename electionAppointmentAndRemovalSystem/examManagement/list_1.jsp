<%@page import="java.text.ParsePosition"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.util.IntegerArray"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Data"%>
<%@page import="java.net.URLDecoder"%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
//    RssList entity = new RssList(pageContext, "legislative_planning");
//    entity.request();
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
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="examnee" select="false" class="butadd">考生</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>标题</th>
                            <th>开考时间</th>
                            <th>考试时长</th>
                            <th>考试地点</th>
                            <th>状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  
                            RssList list = new RssList(pageContext, "question_exam");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            String sql =  "title like '%" + URLDecoder.decode(list.get("title"), "utf-8") + "%'";
                            String beTime = list.get("beginTime");
                            String timelen = list.get("examTime");
                            if(!beTime.isEmpty()){
                                long time0 = (new SimpleDateFormat("yyyy-MM-dd HH:mm")).parse(beTime).getTime() / 1000;
                                sql+= "and beginTime = " + time0;
                            }
                             if(!timelen.isEmpty()){
                                    sql+= "and examTime = " + timelen;
                             }
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
                            <td rssdate="<% out.print(list.get("beginTime")); %>,yyyy-MM-dd hh:mm"></td>
                            <!--<td rssdate="<% // out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td> 显示格式化后的时间 -->
                            <td><% out.print(list.get("examTime")); %></td>
                            <td><% out.print(list.get("examAddress")); %></td>
                            <td><% 
                                long Nowtime =System.currentTimeMillis()/1000; //返回得是一个long类型
                                long time= new Long(list.get("beginTime")); //转成long类型
                                Long.getLong(list.get("beginTime"));
                                if(time >Nowtime){
                                   out.print("<em style='color:green;'>未开始</em>"); 
                                }else{
                                   out.print("<em style='color:#aaa;'>已结束</em>"); 
                                }
                            
                            %></td>
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

        <script src="./controller.js">
        </script>

        <script>

        </script>

    </body>
</html>