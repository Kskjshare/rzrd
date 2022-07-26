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
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();

    entity.select().where("id="+entity.get("id")).get_first_rows();
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
            .cellbor>tbody>tr>td{line-height: 34px;position: relative;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;border: #ffffff solid 2px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{
/*                position: absolute;top: 10px;left: 6px;*/
                line-height:50px;
            }
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #unseluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">编号：</td>
                        <td><% entity.write("realid"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动类型：</td>
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
<!--                    <tr>
                        <td class="dce w100 ">提交人：</td>
                        <td><% entity.write("department"); %></td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">活动时间：</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">创建时间：</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">审核状态：</td>
                        <td>
                            <%
                                    String html = "";
                                    if (entity.get("state").equals("1")) {//1为待审核，2为通过,3为未通过
//                                        html += "<a style='text-decoration: none;' href='javascript:closeDbLzhd(\"" + list.get("id") + "\",1)'>通过</a>";
//                                        html += "<a style='text-decoration: none;' href='javascript:closeDbLzhd(\"" + list.get("id") + "\",2)'>驳回</a>";
                                          html += "<a style=' text-decoration: none; color:black;' href='javascript:void(0);'>待审核</a>";
                                    } else if(entity.get("state").equals("2")) {
                                        html += "<a style=' text-decoration: none; color:#008B45;' href='javascript:void(0);'>通过</a>";
                                    }else{
                                        html += "<a style=' text-decoration: none; color:#CD0000;' href='javascript:void(0);'>驳回</a>";
                                    }
//                                    html += "&nbsp;|&nbsp;<a style=' text-decoration: none;' href='javascript:flowStepRecord(\"" + list.get("id") + "\");'>日志</a>";
                                    out.print(html);
                                %>
                        </td>
                    </tr>
<!--                    <tr>
                        <td class="dce w100 ">活动地址：</td>
                        <td><% entity.write("place"); %></td>
                    </tr>-->
<!--                    <tr>
                        <td class="dce w100 ">未考勤代表</td>
                        <td id="unseluserlist">
                            <em id="sdsign">点击手动考勤</em>
                            <%
                                RssListView entity4 = new RssListView(pageContext, "activities_realname");
                                entity4.select().where("activitiesid=" + entity.get("id") + " and attendancetype=1").query();
                                while (entity4.for_in_rows()) {
                            %>
                            <em><% out.print(entity4.get("realname"));%></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>-->
<!--                    <tr>
                        <td class="dce w100 ">已考勤代表</td>
                        <td id="seluserlist">
                            <%
                                RssListView entity3 = new RssListView(pageContext, "activities_realname");
                                System.out.println( entity.get("id"));
                                entity3.select().where("activitiesid=" + entity.get("id") + " and attendancetype=2").query();
                                while (entity3.for_in_rows()) {
                            %>
                            <em><% out.print(entity3.get("realname"));%></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 left"><span>活动安排：</span></td>
                        <td><div class="textareadiv"><% entity.write("note"); %></div></td>
                    </tr>
                    <tr>
                        <td class="dce w100 left"><span>审核意见：</span></td>
                        <td><div class="textareadiv"><% entity.write("closenote"); %></div></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件：</td>
                        <td>

                            <%
                                
                                System.out.println(entity.get("enclosure"));
                                System.out.println(entity.get("enclosurename"));
                                System.out.println("00000000000");
                                String[] arry1 = {"", "", ""};
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity.get("enclosure").split(",");
                                    String[] str2 = entity.get("enclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                                        arry2[idx] = str2[idx];
                            %>
                            <input readonly="true" class="xz"  style="border:none" value="<% out.print(arry2[idx]); %>"/><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: red;">点击下载</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    <tr>

                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                    </tr>
                </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
