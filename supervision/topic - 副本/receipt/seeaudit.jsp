<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity = new RssList(pageContext, "supervision_topic_process_report_audit");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            /*.popupwrap>div:first-child{height: 100%;}*/
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{height: 100%;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 100%;background: #FFF;margin: 0 auto;width: 97.3%;;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx>table{width: 100%}
            #matter{line-height: 12px;}
            .b95{width:95%;}
            .xz{width: 70%;border: 0px;}
            .shyj{height:100px;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        <form method="post" class="popupwrap">
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader">审核记录</td></tr>
                    <tr>
                        <td class="dce">审核结论：</td>
                        <td><sapn class="shjl" id="audit1" supervisiontopicreceiptstate=""></sapn></td>
                    </tr>
                    <tr>
                        <td class="dce">审核意见：</td>
                        <td  class="shyj"><sapn id="audit2"></sapn></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件：</td>
                        <td colspan="3">

                            <input readonly="true" class="xz" id="audit3" value=""/><a id="audit4" style="cursor: pointer;color: red;">点击下载</a>
</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">审核记录</li></ul>
                            <div id="tczxx">
                                <table class="wp100 tc cellbor" id="section">
                                    <thead>
                                        <tr>
                                            <th>审核状态</th>
                                            <th>审核时间</th>
                                            <th>审核单位</th>
                                            <th>操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            RssListView list = new RssListView(pageContext, "supervision_topic_process_report_audit");
                                            list.request();
                                            list.pagesize = 30;
                                            list.select().where("reportid=" + list.get("id")).get_page_desc("id");
                                            while (list.for_in_rows()) {
                                        %>
                                        <tr ondblclick="ck_dbAbTlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">

                                            <td supervisiontopicreceiptstate="<% out.print(list.get("state")); %>"></td>
                                            <td rssdate="<% out.print(list.get("shijian")); %>,yyyy-MM-dd  hh:mm:ss" ></td>
                                            <td ><%list.write("company");%></td>
                                            <td>
                                                <%
                                                    String html = "";
                                                    html += "<a style='text-decoration: none;' href='javascript:seeAudit(" + list.get("state") + ",\"" + list.get("matter") + "\",\""+list.get("enclosure")+"\",\""+list.get("enclosurename")+"\")' >查看</a> ";
                                                    out.print(html);
                                                %>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>

                            </div>

                        </td>
                    </tr>

                </table>
            </div>
            <div class="footer">
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            function seeAudit(state,matter,enclosure,enclosurename) {
                $("#audit1").text(dictdata["supervisiontopicreceiptstate"][state])
                $("#audit2").text(matter)
                $("#audit3").val(enclosurename)
                $("#audit4").attr("href","/upfile/"+enclosure)
            }
        </script>
    </body>
</html>
