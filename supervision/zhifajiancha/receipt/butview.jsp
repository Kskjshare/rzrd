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
    RssList entity = new RssList(pageContext, "supervision_inspection");
    entity.request();
    entity.select().where("id=?", entity.get("relationid")).get_first_rows();
    RssListView user_delegation = new RssListView(pageContext, "user_delegation");
    user_delegation.select("company").where("myid=?", entity.get("myid")).get_first_rows();
    if (!user_delegation.isEmpty("company")) {
        entity.keyvalue("myidcompany", user_delegation.get("company"));
    }
    user_delegation.select("company").where("myid=?", entity.get("organizationid")).get_first_rows();
    if (!user_delegation.isEmpty("company")) {
        entity.keyvalue("company", user_delegation.get("company"));
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{height: 100%;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 100%;background: #FFF;margin: 0 auto;width: 97.4%;;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx>table{width: 100%}
            .uetd>#tczxx>.textarea_demo{ min-height: 250px; width:100%; transform: translateX(-3px); border:none;}
            .popupwrap>div:first-child{height: 100%;}
            #resumeinfo{display: none;}
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{height: 100%;}
            .xz{width: 70%;border: 0px;}
            .zuo{margin-left: 24%;}
            .span{position: absolute;left: 28em;}
            .popupwrap div>tr:last-of-type{height: 297px;}
            .iframe{height: 90%;height: 245px;}
            /*.iframe p{height: 100%;background-color: white;}*/
            .bg{font-size:14px;height:100%;background:#FFF;margin:0 .9%;padding:3px;border:#6caddc solid thin;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader"  supervisioninspectiontype="<% entity.write("typeid"); %>"></td></tr>
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">发布时间：</td>
                        <td colspan="3" rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100"><span>状态：</span></td>
                        <td colspan="3" supervisioninspectionstate="<%entity.write("state");%>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">下发单位：</td>
                        <td><% entity.write("myidcompany"); %></td>
                        <td class="dce w100 ">主办单位：</td>
                        <td><% entity.write("company"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">下发单位附件：</td>
                        <td>
                            <%
                                String[] arry1 = {"", "", ""};
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity.get("enclosure").split(",");
                                    String[] str2 = entity.get("enclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                                        arry2[idx] = str2[idx];
                            %>
                            <input readonly="true" class="xz" value="<% out.print(arry2[idx]); %>"/><a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: red;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                        <td class="dce w100 ">承办单位附件：</td>
                        <td>
                            <%
                                String[] arry3 = {"", "", ""};
                                String[] arry4 = {"", "", ""};
                                if (!entity.get("reenclosure").isEmpty()) {
                                    String[] str1 = entity.get("reenclosure").split(",");
                                    String[] str2 = entity.get("reenclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry3[idx] = str1[idx];
                                        arry4[idx] = str2[idx];
                            %>
                            <input readonly="true" class="xz" value="<% out.print(arry4[idx]); %>"/><a href="/upfile/<% out.print(arry3[idx]); %>" style="cursor: pointer;color: red;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">承办单位备注</li></ul>
                            <div id="tczxx">
                                <textarea class="textarea_demo"><% entity.write("rematter");%></textarea>
                            </div>
                        </td>
                    </tr>

                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".uetd>ul>li").click(function () {

                $(this).addClass("sel").siblings("li").removeClass("sel");
                $(".uetd>div").eq($(this).index()).show().siblings("div").hide();
            })

            // alert("contextPath::"+pageContext.request.contextPath);//jackie debug
        </script>
    </body>
</html>
