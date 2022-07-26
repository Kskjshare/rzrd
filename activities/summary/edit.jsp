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
    RssList entity2 = new RssList(pageContext, "activities");
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();
    if (!entity.get("action").isEmpty()) {
        String str = entity.get("action");
        entity2.keyvalue(str, entity.get(str));
        entity2.update().where("id=" + entity.get("id")).submit();
        out.print("<script>alert('保存成功')</script>");
        //  PoPupHelper.adapter(out).iframereload();
        //  PoPupHelper.adapter(out).showSucceed();
    }
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
            .cellbor{border: 0}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: 0;line-height: 34px;position: relative; font-size: 12px;padding:1px;border: #d0d0d0 solid thin}
            .cellbor>tbody>tr>.normalline{line-height: 12px;}
            .cellbor>tbody>tr>td>.w750{margin: 3px auto}
            .cellbor>tbody>tr>.savedata{text-align: right;margin-right: 10px;}
            .cellbor>tbody>tr>td>a{ border-radius: 15px; padding: 3px 20px; margin: 0 5px;font-size: 12px; word-spacing: 10px;line-height: 1em; font-family: 微软雅黑;vertical-align: middle;display: inline-block;color: ButtonFace;background: rgb(101, 113, 128);}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 150px;margin-top: 5px}
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;border: #eee solid 2px;}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .left>span{position: absolute;top: 10px;left: 6px;}
            .w630{width:630px;}
            #unseluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #unseluserlist #sdsign{background: #82bee9}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动类型</td>
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td><% entity.write("department"); %></td>
                    </tr>
<!--            //         <tr>
                        <td class="dce w100 ">报名截止日期</td>
                        <td rssdate="<% out.print(entity.get("endshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>-->
<!--zyx注销暂时不需要-->
                    <tr>
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动地点</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">未考勤代表</td>
                        <td id="unseluserlist">
                            <!--<em id="sdsign">点击手动考勤</em>-->
                            <%
                                RssListView entity4 = new RssListView(pageContext, "activities_realname");
                                entity4.select().where("activitiesid=" + entity.get("id") + " and attendancetype=1 and jointype=2").query();
                                while (entity4.for_in_rows()) {
                            %>
                            <em><% out.print(entity4.get("realname"));%></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">已考勤代表</td>
                        <td id="seluserlist">
                            <%
                                RssListView entity3 = new RssListView(pageContext, "activities_realname");
                                entity3.select().where("activitiesid=" + entity.get("id") + " and attendancetype=2").query();
                                while (entity3.for_in_rows()) {
                            %>
                            <em><% out.print(entity3.get("realname"));%></em>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 "><span>活动安排</span></td>
                        <td><% entity.write("note"); %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100">活动报告提纲</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="savetg" name="savetg" class="w750" type="text/plain"><% entity.write("savetg"); %></script></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 savedata"><a val="savetg">保存</a></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 ">活动报告草案</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="saveca" name="saveca" class="w750" type="text/plain"><% entity.write("saveca"); %></script></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 savedata"><a val="saveca">保存</a></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 ">活动正式报告</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="normalline"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="savezs" name="savezs" class="w750" type="text/plain"><% entity.write("savezs"); %></script></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="dce w100 savedata"><a val="savezs">保存</a></td>
                    </tr>
                    <tr class="thismyid">
                        <td class="tr">作者ID</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                </table>
            </div>
            <!--            <div class="footer">
                            <input type="hidden" name="action" value="append" />
                            <button type="submit">确定</button>
                        </div>-->
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/activitiestype.js" type="text/javascript"></script>
        <script>
            $(".savedata>a").click(function () {
                var action = $(this).attr("val");
                var matter = UE.getEditor(action).getContent();
                var key = {'action': action, 'id': "<% out.print(entity.get("id"));%>"};
                key[action] = matter
                $.get("/activities/summary/summary.jsp", key, function (json) {
                    json = JSON.parse(json)
                    if (json.state == "ok") {
                        alert("保存成功")
                    }
                })
                return false;
            })
        </script>
    </body>
</html>
