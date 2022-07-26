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
    RssListView entity = new RssListView(pageContext, "poll");
    RssList entity1 = new RssList(pageContext, "poll");
    entity.request();
    entity.select().where("id=?", entity.get("id")).get_first_rows();
    int a = Integer.valueOf(entity.get("readnum"));
    a++;
    entity1.keyvalue("readnum",a);
    entity1.update().where("id="+ entity.get("id")).submit();
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
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            #matter{line-height: 12px;height: 200px;}
            /*#matter>div{height: 180px;overflow: auto;}*/
            .popupwrap div table tr:last-of-type{height: 248px;}
            .iframe{height: 90%;height: 245px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <!--                    <tr>
                                            <td colspan="4" class="institle dce">信息处理</td>
                                        </tr>-->
                    <tr>
                        <td class="dce w100 ">标题：</td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">发布者：</td>
                        <td><% entity.write("realname"); %></td>
                        <td class="dce w100 ">分类<em class="red">*</em></td>
                        <td  gztype="<% entity.write("type"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">阅读次数：</td>
                        <td><% entity.write("readnum"); %></td>
                        <td class="dce w100 ">录入日期：</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">正文</td>
                        <td colspan="3">【操作提示】为规范信息内容格式,录入完信息内容后,请务必点击排版信息内容</td>
                    </tr>
                    <tr><td colspan="4" id="matter"><div class="iframe"><iframe src="butview_1.jsp?id=<% out.print(entity.get("id"));%>"></iframe></div></td>
                    </tr>
                    <!--                 <tr class="thismyid">
                                            <td class="tr">作者ID：</td>
                                            <td colspan="3"><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request)); %>" selectuser=""/> <label></label></td>
                                    </table>-->
            </div>
            <!--            <div class="footer">
                            <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                            <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
                        </div>-->
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <script src="../data/dictdata.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
