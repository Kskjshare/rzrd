<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "courseware");
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
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}    
            .cellbor>tbody>tr>td>img{max-width: 150px; max-height: 170px;}
            .cellbor{width: 100%}
            .uetd>ul{ background: #82bee9;border: #6caddc solid 1px;height: 28px;margin: 0px auto; width: 98%;;padding: 3px 0px; position: relative;left: 0;border-radius: 2px;cursor: default;}
            .uetd>ul>li{ float: left;color: #FFF;display: inline;padding: 6px 20px;; margin: 0 10px;border-radius: 4px;line-height: 14px}
            .uetd>ul>.sel{color: #186aa3;background: #FFF}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;height: 278px;}
            .popupwrap>div:first-child{height: 100%;}
            #resumeinfo{display: none;}
            #resumeinfo>h6{margin:0 auto;text-align: center;font-size: 14px;}
            #resumeinfo>.yjsm{height: 80px;}
            #headxq{height: 28px;padding:0 3px;position: relative;border: #e9e9e9 solid thin;background: #f0f0f0;}
            #headxq>span{color: #fff;background:#539314;width: 20px;height: 20px;border-radius: 5px;line-height: 20px;position: absolute;right: 4px;top: 4px;text-align: center;cursor: pointer;font-size: 22px;}
            #headxq>em{padding-left:30px; background: url(../../img/soft/zip.png) no-repeat 5px 4px;background-size: 18px;line-height: 28px;display: inline-block; }
            span[video]{color: blue}
            .popupwrap div table tr:last-of-type{height: 337px;}
            .iframe{height: 90%;height: 284px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <div id="headxq"><em>课件详情</em><span>×</span></div>
                <table class="wp100 cellbor">
                    <tr><td colspan="4" id="tabheader">查看详情</td></tr>
                    <tr><td class="w120 dce">课件名称</td><td colspan="3"><% out.print(entity.get("title"));%></td></tr>
                    <tr><td class="w120 dce">下载附件</td><td colspan="3"><a href="/upfile/<% entity.write("enclosure");%>" download="附件"><% entity.write("enclosure");%></a></td></tr>
                    <tr><td class="w120 dce">播放视频</td><td colspan="3"><span <% out.print(entity.get("videosrc").isEmpty() ? "" : "video='" + entity.get("id") + "'"); %>><% out.print(entity.get("videosrc").isEmpty() ? "暂无视频" : "点击播放"); %></span></td></tr>
                    <tr><td class="w120 dce">外部链接</td><td colspan="3"><a href="<% out.print(entity.get("links"));%>"><% out.print(entity.get("links"));%></a></td></tr>
                    <tr>
                        <td colspan="4" class="marginauto uetd">
                            <ul><li class="sel">课题内容</li></ul>
                            <div class="iframe"><p><iframe src="butview_1.jsp?id=<% out.print(entity.get("id"));%>"></iframe></p></div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script>
            $("#headxq>span").click(function () {
                history.go(-1);
            })
            $("span[video]").click(function () {
                var video = $(this).attr("video")
                popuplayer.display("/makepolicy/courseware/video.jsp?id=" + video, '视频播放', {width: 1000, height: 600});
            })
        </script>
    </body>
</html>
