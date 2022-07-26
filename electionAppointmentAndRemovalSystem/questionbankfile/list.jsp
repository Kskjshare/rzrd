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
            /*.cellbor tbody>.sel>td{background: #dce6f5}*/
            /*             .cellbor thead,.w30{background:#f0f0f0 }
                       .cellbor tbody tr>td:first-child{display: none}
                       .cellbor td, .cellbor th { border: solid 1px #cbcbcb; padding: 8px 2px; }*/
            tbody tr:hover{background-color: gainsboro;}
            .yangshi{
               background-color:white;
               border-radius: 5px;
               height:40px;
               width:97%;
               margin:10px auto;
               border: 1px solid #2a81d1;
               padding:7px;
               box-sizing: border-box;
               font-size:14px;
               display:flex;
            }
            .yangshi button{
               height:26px;
               width:60px;
               margin-left: 10px;
               border-radius:25px;
               color:white;
            }
            .sousuo{
               background-color:#1ab394;    
            }
            .chongzhi{
            background-color:#f8ac59;   
            }
            .xin{
               background-color:white;
               border-radius: 5px;
               height:36px;
               width:97%;
               margin:0 auto;
               padding:7px;
               box-sizing: border-box;
               font-size:14px;
               display:flex;
            }
            .xin button{
               height:26px;
               width:60px;
               margin-left: 10px;
               border-radius:25px;
               color:white;
            }
                  
              
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap" style="background-color:#f3f3f4">
            <div class="toolbar">            
<!--                <p style="margin-top:2px;">&nbsp;&nbsp;文件名：</p>
                <input>
                <button class="sousuo">搜&nbsp;索</button>
                <button class="chongzhi">重&nbsp;置</button>-->
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">快速查询</button>
                <button type="button" transadapter="append" select="false" class="butadd">增加</button>
                <button type="button" transadapter="examnee" select="false" class="butadd">考生</button>
                <button type="button" transadapter="edit" class="butedit">编辑</button>
                <button type="button" transadapter="delete" class="butdelect">删除</button>
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
            
            </div>
<!--            style="margin-top:25px;background-color:white;border-radius: 5px;"-->
            <div class="bodywrap" >
<!--                <div class="xin">
                <button style=" background-color:#1c84c6;">添&nbsp;加</button>
                <button style=" background-color:#f59da6;">删&nbsp;除</button>  
            </div>-->
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr style="background-color:#eff3f8;">
<!--                            <th class="w30"></th>-->
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>文件名</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            RssList list = new RssList(pageContext, "questionbankfile");
                            list.request();
                            int a = 1;
                            list.pagesize = 30;
                            String title = URLDecoder.decode(list.get("title"), "utf-8");
                            String type = list.get("type");
                            String questiontype =list.get("questiontype");
//                            String  where = "";
//                             String sql = "";
                            String sql = "title like '%" + title + "%'";
                            if(!type.isEmpty() && !questiontype.isEmpty() ){
//                               
                                sql += " and type =" +type +" and questiontype = " + questiontype;
                            }
                            list.select().where(sql).get_page_desc("id");
                            while (list.for_in_rows()) {
                        %>
                        <tr ondblclick="ck_dbablclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td><% out.print(list.get("title")); %></td>
<!--                            <td><% 
                                String[] answers = list.get("answer").split(".-f/,");
                                String answer = "";
                                
                                    for(String s : answers){
                                        if(s.length() > 0){
                                            answer += s.charAt(0)+" ";
                                        }
                                    }
                                    out.print(answer);
                                %></td>-->
                            <td><% out.print(list.get("creatername")); %></td>
                            <td><% out.print(list.get("time")); %></td>
                        
     
<!--                            <td>
                                <%
//                                    RssList user = new RssList(pageContext, "user");
//                                    user.select().where("myid=?", list.get("myid")).get_first_rows();
//                                    out.print(user.get("realname").isEmpty() ? "无" : user.get("realname"));
                                %>
                            </td>-->
                            <!--<td><% out.print(list.get("shijian")); %></td>-->
                            <!--<td rssdate="<% // out.print(list.get("shijian")); %>,yyyy-MM-dd hh:mm:ss" ></td> 显示格式化后的时间 -->
<!--                            <td questionCategory1="<% out.print(list.get("type")); %>"></td>-->
                            <td ><button style='margin:0 auto; width:50px;height:22px; border-radius:15px; background-color :#ed5565;color:white;'>删&nbsp;除</button></td>
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