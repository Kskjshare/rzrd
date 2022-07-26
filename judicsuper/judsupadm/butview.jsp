<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.JPushClient"%>
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
    RssList entity = new RssList(pageContext, "judsupadm");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid");
                entity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
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
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .cellbor>tbody>tr>.uetd ul{width: 800px}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}#headimg label>input{display: none}    
            #headimg >div{width: 140px;height: 100px;text-align: center;margin-bottom: 5px;}
            #headimg >div>img{height: 100%}
            #headimg p {display: inline-block;width: 70px;height: 25px; margin: 0 2px;border-radius:5px;background: #00a2d4;text-align: center;color: #fff;line-height:25px; }

            
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>

        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题：<em class="red">*</em></td>
                        <td colspan="3"><% entity.write("title"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">检查组人员：<em class="red">*</em></td>
                        <td colspan="3"><% entity.write("instmem"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">相关文件：</td>
                         <td style="font-weight: bold;" colspan="8">
                            <%
                                RssList user1 = new RssList(pageContext, "judicsup");
                                user1.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                             <% out.print(entity.get("enclosurename")); %>
                            <a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;cursor:pointer;font-weight:bold;">
                                &nbsp;&nbsp;&nbsp;点击下载
                            </a>
                            <%
                                    }
                                }
                            %></td>
                    </tr>
<!--           //          <tr style="display:none;">
                        <td class="dce w100 ">添加时间：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="shijian"  rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd HH:mm:ss"   onFocus="WdatePicker({lang: 'zh-cn', dateFmt: 'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"></td>
                        <td colspan="3"><input type="text" maxlength="80" class="b95" name="addshijian" value="<% entity.write("addshijian"); %>" /></td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">专委会：<em class="red">*</em></td>
                        <td colspan="3"><% entity.write("specom"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">承办部门：<em class="red">*</em></td>
                        <td colspan="3"><% entity.write("undertaker"); %></td>
                    </tr>


                </table>

            </div>
           
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
       
    </body>
</html>