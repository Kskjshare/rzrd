<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList list2 = new RssList(pageContext, "exaninee_and_exam");
    list2.request(); //接收传来的值
    if(!list2.get("kaoshengid").isEmpty()){
        String[]  dsList = list2.get("kaoshengid").split("/./");
        list2.remove("examid");
        for (int i = 0; i < dsList.length; i++) {
              System.out.println(dsList[i]+"for ----i");
                 
                 list2.keyvalue("kaoshengid",dsList[i]);
                 list2.keyvalue("shijuanid",list2.get("examid"));
               list2.append().submit();
               
        }
      
        
        
    }
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
            .res{float: right;}
            tbody tr:hover{background-color: gainsboro;}
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" class="res">返回上一级</button>
                <!--<button type="button" transadapter="examnee" select="false" class="butadd">考生</button>-->
                <!--<button type="button" transadapter="edit" class="butedit">编辑</button>-->
                <!--<button type="button" transadapter="delete" class="butdelect">删除</button>-->
                <!--<button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <!--tr 存入当前试卷id-->
                        <tr  id="examtr" shijuanid="<% out.print(list2.get("examid")); %>">  
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>姓名</th>
                            <th>身份证号</th>
                            <th>手机号</th>
                            <th>考生类别</th>
                            <th>分数</th>
                            <th>考卷状况</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%  
                            RssListView list = new RssListView(pageContext, "create_examtable");
                            list.request();
                            
                            int a = 1;
                            list.pagesize = 30;
                            String sql ="";
                            
                            if(list.get("name")== null || list.get("name").equals("") ){
                                 sql = " shijuanid =" + list.get("examid");
                                 System.out.println("aaaaa");
                            }else{
                                 sql = " shijuanid =" + list.get("examid") + "and name like '%" + list.get("name") + "%'";
                                 System.out.println(sql+"bbbb");
                            }
                           
                            list.select().where(sql).get_page_desc("id");
                            System.out.println(sql+"111111111111111111111111");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("examid")); %>" style="cursor:pointer;">
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="examid" value="<% out.print(list.get("examid")); %>" /></td>
                            <td><% out.print(list.get("name")); %></td>
                            <td><% out.print(list.get("idCard")); %></td>
                            <td><% out.print(list.get("tel")); %></td>
                            <td category="<% out.print(list.get("category")); %>"></td>
                            <td><% %></td>
                            <td><% %></td>
                            <td><% %></td>
                        </tr>
                        <tr id="examid" examid="<% out.print(list.get("examid")); %>" ></tr>
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
             $(".res").click(function () {
                history.go(-1);
            });
            
             
        </script>
        <script src="./controller.js">
        </script>
         
    </body>
</html>