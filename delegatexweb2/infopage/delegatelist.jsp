<%-- 
    Document   : delegatelist
    Created on : 2018-7-16, 16:31:38
    Author     : Administrator
--%>

<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RssListView list = new RssListView(pageContext, "userrole");
    list.request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            li{list-style-type: none;}
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }   
            #webbody{margin: 10px;border: #cccccc solid thin; padding: 0;}
            #webbody h1{line-height: 39px;color:#039f62;font-size: 15px;;background:linear-gradient(#e2fffc,#fff); font-weight: 400;margin: 0; }
            #webbody h1>span{display: block;margin: 0 10px;border-bottom: #a3dbd3 solid 2px;}
            #webbody ul{margin: 0 0 0 10px;padding: 0;}
            #webbody ul>li{}
            #webbody ul>li h2{background:url(../img/rddb.png) no-repeat 0 10px;background-size:21px;font-size: 14px;padding-left:25px;margin: 0;line-height: 42px; }
            #webbody ul>li ol{padding: 0 20px;}
            #webbody ul>li>ol>li{width: 138px; height: 184px;display: inline-block; text-align: center;border: #cccccc solid thin;background: #f3f3f3;margin:5px}
            #webbody ul>li ol>li>div{width: 96px;height: 122px;margin: 10px auto;overflow: hidden;}
            #webbody ul>li ol>li>div>img{width: 96px;}
            #webbody ul>li ol>li>p{text-align: center;}
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1054px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            .popuplayer,.calendarwrap{display: none;}
            a{color: #039f62 ;cursor: pointer;  text-decoration: none; }
            a:hover{border-bottom:#039f62 solid 1px; }
        </style>
    </head>
    <body>
        <div>
            <div id="header"></div>
            <div id="webbody">
                <h1><span>当前位置：<a href="/delegatexweb/infopage/delegationinfo.jsp?myid=<% out.print(list.get("myid"));%>">首页</a> > 我们的代表</span></h1>
                <ul>
                    <%
                        list.select().where("state=2 and mission=" + list.get("myid")).query();
//                        String a = "<li><h2>全国人大代表</h2><ol>", b = "<li><h2>河南省人大代表</h2><ol>", c = "<li><h2>平顶山市人大代表</h2><ol>", d = "<li><h2>汝州市人大代表</h2><ol>", e = "<li><h2>乡镇人大代表</h2><ol>";
                        String a = "<li><h2>人大代表</h2><ol>", b = "<li><h2>人大代表</h2><ol>", c = "<li><h2>人大代表</h2><ol>", d = "<li><h2>人大代表</h2><ol>", e = "<li><h2>人大代表</h2><ol>";

                        
                        int A = 1, B = 1, C = 1, D = 1, E = 1;
                        while (list.for_in_rows()) {
                            String[] num = list.get("circleslist").split(",");
                            String ix = "";
                            for (int idx = 0; idx < num.length; idx++) {
                                System.out.println(num[idx]);
//                                 System.out.println("-!!-------!!-----");
                                ix = num[idx];
                                
                                //汝州项目，把县级代表改为市代表（由于修改数据太多了，在这里打个补丁)
                                if ( ix.equals("1") ) {
                                    ix = "2" ;
                                }
                                switch (ix) {
                                    case "0":
                                        e += "<li myid='" + list.get("myid") + "'><div><img src='/upfile/" + list.get("avatar") + "'/></div><p>" + list.get("realname") + "</p></li>";
                                        E++;
                                        break;
                                    case "1":
                                        d += "<li myid='" + list.get("myid") + "'><div><img src='/upfile/" + list.get("avatar") + "'/></div><p>" + list.get("realname") + "</p></li>";
                                        D++;
                                        break;
                                    case "2":
                                        c += "<li myid='" + list.get("myid") + "'><div><img src='/upfile/" + list.get("avatar") + "'/></div><p>" + list.get("realname") + "</p></li>";
                                        C++;
                                        break;
                                    case "3":
                                        b += "<li myid='" + list.get("myid") + "'><div><img src='/upfile/" + list.get("avatar") + "'/></div><p>" + list.get("realname") + "</p></li>";
                                        B++;
                                        break;
                                    case "4":
                                        a += "<li myid='" + list.get("myid") + "'><div><img src='/upfile/" + list.get("avatar") + "'/></div><p>" + list.get("realname") + "</p></li>";
                                        A++;
                                        break;
                                }
                            }
                        }
                        a += "</ol></li>";
                        b += "</ol></li>";
                        c += "</ol></li>";
                        d += "</ol></li>";
                        e += "</ol></li>";
                        if (A != 1) {
                            out.print(a);
                        }
                        if (B != 1) {
                            out.print(b);
                        }
                        if (C != 1) {
                            out.print(c);
                        }
                        if (D != 1) {
                            out.print(d);
                        }
                        if (E != 1) {
                            out.print(e);
                        }
                    %>
                    <!--                    <li>
                                            <h2>全国人大代表</h2>
                                            <ol><li><div><img src="../img/defaultimg.png" alt=""/></div><p>邓贺颖</p></li></ol>
                                        </li>
                                        <li>
                                            <h2>省(自治区)人大代表</h2>
                                            <ol><li><div><img src="../img/defaultimg.png" alt=""/></div><p>邓贺颖</p></li></ol>
                                        </li>
                                        <li>
                                            <h2>市人大代表</h2>
                                            <ol><li><div><img src="../img/defaultimg.png" alt=""/></div><p>邓贺颖</p></li></ol>
                                        </li>
                                        <li>
                                            <h2>县级人大代表</h2>
                                            <ol>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                            </ol>
                                        </li>
                                        <li>
                                            <h2>乡镇人大代表</h2>
                                            <ol>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                                <li myid="894"><div><img src="../img/ceshihead.png" alt=""/></div><p>邓贺颖</p></li>
                                            </ol>
                                        </li>-->
                </ul>
            </div>
            <div id="footer">
                <p>汝州市人大常委会主办</p>
                <!--<p>技术支持：汝州市人大常委会办公厅信息中心</p>-->
            </div>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>
            $("ol>li").click(function () {
                var relationid = $(this).attr("myid");
                location.href = "/delegatexweb/infopage/delegateinfo.jsp?relationid=" + relationid;
            })
        </script>
    </body>
</html>
