<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "leaveword");
    list.request();
    list.select().where("id=?", list.get("id")).get_first_rows();
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .cellbor{border: 0}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
             /*zyx 增加边框的显示 border: solid 1px #d4cece;*/
            .cellbor>tbody>tr>td{border: 0;line-height: 34px;position: relative;border: solid 1px #d4cece;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 150px;margin-top: 5px} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            /*zyx 增加边框的显示 padding: 1px #fff 2px;*/
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px #fff 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">提出者姓名：</td>
                        <td><%out.print(list.get("myname"));%></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td><%out.print(list.get("title"));%></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">留言：</td>
                        <td><%out.print(list.get("matter"));%></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">创建时间：</td>
                        <td  rssdate="<% list.write("shijian");%>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">状态：</td>
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
                            <!--zyx end--> 
                        </td>
                    </tr>
                    <!--zyx 增加判断当不予接受原由为空时不显示-->
                        <%
                        if( list.get("buyBack") != "" || list.get("Back") != ""){
                        %>
                    <tr>
                        <td class="dce w120 ">不予接收原由：</td>
                        <%
                            if (list.get("buyBack") != "") {
                        %>
                        <td><%out.print(list.get("buyBack"));%></td>
                        <%
                        } else if (list.get("Back") != "") {
                        %>
                        <td><%out.print(list.get("Back"));%></td>
                        <%
                        } else {
                        %>
                        <td>暂无</td>
                        <%
                            }
                               };
//zyx  end
                        %>
                    </tr>
                    <!--zyx 增加当回复内容为空时不显示的判断-->
                    <%
                    if ( list.get("write_back") !=""){
                    %>
                    <tr>
                        <td class="dce w100 ">回复内容：</td>
                        <td><%out.print(list.get("write_back").equals("") ? "暂无" : list.get("write_back"));%></td>
                    </tr>
                    <%
                    };
                    %>
                    <!--zyx end-->
                    <tr>
                        <td class="dce w100 ">代表</td>
                        <td><% list.write("realname"); %></td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
    </body>
</html>
