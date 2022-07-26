<%-- 
    Document   : delegateinfo
    Created on : 2018-7-16, 17:58:04
    Author     : Administrator
--%>

<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RssListView list = new RssListView(pageContext, "leaveword");
    list.request();
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <title>云上人大代表联络站</title>
        <style>
            html,body{overflow: auto}
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #webbody {margin: 10px 23px; border: #ccc solid thin;padding-bottom: 10px;}
            #webbody h1{line-height: 39px;color:#039f62;font-size: 15px;;background:linear-gradient(#e2fffc,#fff); font-weight: 400;margin: 0; }
            #webbody h1>span{display: block;margin: 0 10px;border-bottom: #a3dbd3 solid 2px;}
            #webbody table{border: #ccc solid thin;width: 945px;margin: 39px auto;
                           /*height: 429px;*/
                  overflow: auto;}
            #webbody table td{padding: 8px;font-size: 14px;}
            #webbody table td input[type='text']{ height: 24px;padding: 0 2px;}
            #webbody table #tabhead{text-align: center;background:#f6f6f6;font-size: 16px;font-weight: 600;letter-spacing: 1px; }
            #webbody table td>div{width: 96px;height: 122px;margin: 10px auto;overflow: hidden;}
            #webbody  table td>div>img{width: 96px;}
            #webbody  table td>p{width: 95px;height: 24px;line-height: 24px;text-align: center;color:#fff;background: #52b4bb;border:#95c2c9 solid thin;margin: 0 auto;margin-top: 65px;
            }
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1086px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            #webbody  table td textarea{ padding: 3px; margin: 0; list-style: none; font-family: Arial,Helvetica,sans-serif,宋体; text-indent: 0px; outline: none; border-radius: 3px; vertical-align: middle;resize: none; height: 110px;}
            .txtright{text-align: right;}
            .red{color: red}
            .w630{width: 630px;}
            .w150{width: 150px;}
            #webbody  table td button{width: 95px;height: 24px;line-height: 24px;text-align: center;color:#fff;background: #52b4bb;border:#95c2c9 solid thin;margin: 0 30px;}
            .popuplayer,.calendarwrap{display: none;}

            a{color: #039f62 ;cursor: pointer;  text-decoration: none; }
            a:hover{border-bottom:#039f62 solid 1px; }
            .cellbor tbody>.sel>td{background: #dce6f5}
            td{text-align: center}
            .w86{width: 86px;}
            .w110{width: 110px;}
            .w50{width: 86px;}
            .fy{margin: 22px 0px 0px 51px;}
            .cellbor td, .cellbor th {padding: 3px 2px;font-size: 13px;}
            #gao{height: 650px;overflow: auto;}
            tbody tr:hover{background-color: gainsboro;cursor: pointer}
            /*            tbody tr td{white-space: nowrap;
                                    overflow: hidden;
                                    text-overflow: ellipsis;
                                    color: #000;    padding-right: 2.2rem;}*/
        </style>
    </head>
    <body>
        <div>
            <form>
                <div id="header"></div>
                <div id="webbody">
                    <h1><span>当前位置：<a href="/delegatexweb/infopage/delegationinfo.jsp?myid=<% out.print(list.get("myid"));%>">首页</a> > 公众留言</span></h1>
                    <input style="display:none" name="myid" value="<% out.print(list.get("myid"));%>">
                    <div id="gao">
                        <table cellspacing="0" class="cellbor">
                            <thead>
                                <tr><td colspan="9" id="tabhead">公众留言列表展示</td></tr>
                                <tr><th class="w86">提出者姓名</th><th class="w110">标题</th><th class="w86">创建时间</th><th class="w50">状态</th><th class="w86">代表</th><th class="w86">操作</th></tr>
                            </thead>
                            <tbody>
                                <%
                                    list.pagesize = 30;
                                    list.select().where("objid="+list.get("myid")).get_page_desc("id");
                                    while (list.for_in_rows()) {
                                %>
                                <tr  ondblclick="ck_liudbcilclick();" idd="<% out.print(list.get("id")); %>" style="height:20px;" >
                                    <td><%out.print(list.get("myname"));%></td>
                                    <td><%out.print(list.get("title"));%></td>
                                    <td rssdate="<% list.write("shijian");%>"></td>
                                       <!--zyx 增加状态字体不同颜色的显示-->
                                    <td><%
                                        String handle = "";
                                        if (list.get("objstate").equals("1")) {
                                            handle = "<em style='color:green;font-weight:bold'>已回复</em>";
                                        } else if (list.get("state").equals("0")) {
                                            handle = "<em style='color:DodgerBlue;font-weight:bold'>初发布</em>";
                                        } else {
                                            handle = "<em style='color:orange;font-weight:bold'>审核中</em>";
                                        }
                                        if (list.get("returnuser").equals("1")) {
                                            handle = "<em style='color:red;font-weight:bold'>不予接收</em>";
                                        }
                                        if (list.get("returnobj").equals("1")) {
                                            handle = "<em style='color:red;font-weight:bold'>不予接收</em>";
                                        }
                                        out.print(handle);
                                        %>
                                    </td>
                                      <!--zyx end--> 
                                    <td><%out.print(list.get("allname"));%></td>
                                    <td>
                                    <span class="ys view" id="<% out.print(list.get("id")); %>" style="color:blue;font-weight: bold" >查看内容</span>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                            <div class="fy">
                                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                                <%
                                    Pagination pagination = new Pagination(list, request);
                                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                                %>
                            </div>
                        </table>
                    </div>
                </div>
                <div id="footer">
                    <!--<p>汝州市人大常委会主办</p>-->
                      <p style="margin-top:-10px;">&nbsp;&nbsp;&nbsp;</p>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主办：汝州市人大常委会办公室&nbsp;&nbsp;<a class="ml80" href="https://beian.miit.gov.cn/" target="_blank">豫ICP备17035523号</a></p>
                    <p>电话：0375-6862978&nbsp;&nbsp;&nbsp;&nbsp;<span class="ml144">邮编：467500</span></p>
                    <p>地址：平顶山市汝州市丹阳中路268号</p>
                </div>
            </form>
        </div>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js" type="text/javascript"></script>
        <script>
                                    $("#history").click(function () {
                                        history.go(-1);
                                    })
                                    $("button[type='submit']").click(function () {
                                        if ($("input[type='checkbox']").is(":checked")) {
                                        } else {
                                            alert("请先阅读留言须知")
                                            return false;
                                        }
                                    })
                                    
                 $(function(){
                ﻿$(".view").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/delegatexweb/infopage/butview.jsp?id=" + id + "&TB_iframe=true", '查看内容', {width: 830, height: 240});
                })
            });
        </script>
    </body>
</html>
