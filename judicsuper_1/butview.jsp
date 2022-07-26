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
    RssList entity = new RssList(pageContext, "petition");
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
                        <td class="dce w100 ">姓名：</td>
                        <td><% entity.write("petitioner"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">性别：</td>
                        <td sex="<% entity.write("sex"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">证件号码：</td>
                        <td><% entity.write("idcard"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">手机号码：</td>
                        <td><% entity.write("telphone"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">涉及人数：</td>
                        <td><% entity.write("numpeinv"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访主题：</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">概况信息：</td>
                        <td><% entity.write("matter"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访日期：</td>
                        <td rssdate="<% out.print(entity.get("datapetition")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">登记时间：</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访形式：</td>
                        <td petitionclassify="<% entity.write("petitionclassify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">信访原因：</td>
                        <td reapetitionclassify="<% entity.write("reapetition"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">问题属地：</td>
                        <td><% entity.write("problemter"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">登记人：</td>
                        <td><% entity.write("petitioner"); %></td>
                    </tr>

                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                    </tr>
                </table>
                    
                    <table class="wp100 cellbor">
                        <p style="text-align: center;padding: .5rem;">流程轨迹</p>
                        <tr>
                            <td class="dce w100 ">办理时间：</td>
                        <td rssdate="<% out.print(entity.get("procestime")); %>,yyyy-MM-dd" ></td>
                        </tr>
                        <tr>
                            <td class="dce w100 ">办理部门：</td>
                            <td petitiongtdeparclassify="<% entity.write("gtdepar"); %>"></td>
                        </tr>
                        <tr>
                            <td class="dce w100 ">经办人：</td>
                            <td><% entity.write("agent"); %></td>
                        </tr>
                        <tr>
                            <td class="dce w100 ">流程类型：</td>
                            <td petitiongtdeparclassify="<% entity.write("handle"); %>"></td>
                        </tr>
                        <tr>
                            <td class="dce w100 ">去向部门：</td>
                            <td petitiongtdeparclassify="<% entity.write("gtdepar"); %>"></td>
                        </tr>
                        <tr>
                            <td class="dce w100 ">备注：</td>
                            <td><% entity.write("remarks"); %></td>
                        </tr>
                    </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
