<%-- 
    Document   : listinfopage
    Created on : 2018-7-20, 21:26:46
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(/delegatexweb/img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #webbody{margin: 10px;border: #cccccc solid thin; padding: 0;}
            #webbody h1{line-height: 39px;color:#039f62;font-size: 15px;;background:linear-gradient(#e2fffc,#fff); font-weight: 400;margin: 0;text-align: left;text-indent: 10px; }
            #webbody h1>span{display: block;margin: 0 10px;border-bottom: #a3dbd3 solid 1px;}
            #webbody h2{font-size: 14px;text-align: center;}
            #webbody h3{font-size: 12px;font-weight: 400;text-align: center;}
            #webbody>div{margin: 0 23px;}
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1096px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            h1{text-align: center;}
            #webbody img{max-width: 80%;max-height: 580px;text-align:center;}
            /*#webbody>img{}*/
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            .popuplayer,.calendarwrap{display: none;}
            #newlist{padding: 0;height: 100%;overflow: auto;}
            #newlist li{list-style-type: none; width: 535px; display: inline-block; line-height: 30px; border: #cacaca solid 2px; padding: 4px; padding-bottom: 9px;margin-bottom: 10px;vertical-align: top}
            #newlist li>p{background: url(img/blueright.png) no-repeat 4px 11px; font-size: 14px;margin:0 10px;text-indent: 20px;border-bottom: #cacaca dashed 1px;cursor: pointer;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #newlist li:last-of-type{list-style-type: none; width:1032px; display: inline-block; line-height: 30px; border: #cacaca solid 1px; padding: 4px; padding-bottom: 9px;margin-bottom: 10px;vertical-align: top;margin-left: 17px;}
        </style>
    </head>
    <body>
        <%
            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
        %>
        <div>
            <div id="header"></div>
            <div id="webbody">
                <h1><span><% String show = "", view = "workdynamics", where = "";
                    if (req.get("gd").equals("1")) {
                        show = "工作动态";
                        where = "classify=1";
                    }
                    if (req.get("gd").equals("2")) {
                        show = "活动预告";
                        where = "classify=3";
                    }
                    if (req.get("gd").equals("3")) {
                        show = "活动预告";
                        where = "classify=3";
                    }
                    if (req.get("gd").equals("4")) {
                        show = "示范联络站";
                        view = "stationcontent";
                        where = "demonstration=2";
                    }
                    if (req.get("gd").equals("5")) {
                        show = "人大代表制度";
                        view = "personsystem";
                        where = "state=1";
                    }
                    RssListView entity = new RssListView(pageContext, view);
                    entity.select().where(where).get_page_desc("id");
                    out.print(show);
                %></span></h1>
                <ul id="newlist">
                    <li>
                        <%
                            while (entity.for_in_rows()) {
                        %>
                        <p ind="<% out.print(entity.get("id"));%>" cla="<% out.print(req.get("gd"));%>"><% out.print(entity.get("title"));%></p>
                        <%
                            }
                        %>
                    </li>
                </ul>
            </div>
            <div id="footer">              
                <p style="margin-top:-10px;">&nbsp;&nbsp;&nbsp;</p>
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主办：汝州市人大常委会办公室&nbsp;&nbsp;<a class="ml80" href="https://beian.miit.gov.cn/" target="_blank">豫ICP备17035523号</a></p>
                <p>电话：0375-6862978<span class="ml144">邮编：467500</span></p>
                <p>地址：平顶山市汝州市丹阳中路268号</p>
            </div>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>
            $("[cla]").click(function () {
                var ind = $(this).attr("ind");
                var cla = $(this).attr("cla");
                switch (cla) {
                    case "1":
                        window.open("/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla)
//                        location.href = "/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla;
                        return false
                        break;
                    case "2":
                        window.open("/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla)
//                        location.href = "/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla;
                        return false
                        break;
                    case "3":
                        window.open("/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla)
//                        location.href = "/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla;
                        return false
                        break;
                    case "4":
                        window.open("/delegatexweb/infopage/listinfopage_1.jsp?ind=" + ind + "&cla=" + cla)
//                        location.href = "/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla;
                        return false
                        break;
                    case "5":
                        window.open("/delegatexweb/infopage/delegationinfo.jsp?myid=" + ind)
//                        location.href = "/delegatexweb/infopage/delegationinfo.jsp?myid=" + ind;
                        return false
                        break;
                }
            })
        </script>
    </body>
</html>
