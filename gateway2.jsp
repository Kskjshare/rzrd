<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>智慧人大综合服务管理平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="apple-touch-icon" href="touch-icon-iphone.png" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/gateway.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
          <%
                    CookieHelper cookie = new CookieHelper(request, response);
                    RssList list = new RssList(pageContext, "user");
                    list.select().where("myid=?", UserList.MyID(request)).get_first_rows();
                    String name = null;
                    String idd = null;
                    if (cookie.Get("powergroupid").equals("18")) {
                        name = list.get("account");
                    } else if (cookie.Get("powergroupid").equals("22")) {
                        name = list.get("allname");
                    } else {
                        name = UserList.RealName(request);

                        if (name.equals("匿名")) {
                            name = list.get("account");
                        }

                    }

                    idd = UserList.MyID(request);
                %>
        <div class="header">
            <div class="headerList">
                <div class="headerL">
                    <img src="/css/zimg/智慧人大综合服务管理平台.png"/>
                </div>
                <div class="headerR">
                    
                    <a href="javascript:;">
                        <img class="user_img" src="css/limg/user.png" /> <% out.print(name);%><span title=" <% out.print(name);%>"></span>
                    </a>&nbsp;
                    <a href="loginout.jsp">
                        <img src="css/limg/out.png" style="width: 7%;"/>退出&nbsp;
                    </a>
                </div>
            </div>
        </div>
        <div class="Contain">
            <div class="HomeContain">
                 <div class="Box-left">
                    <div class="galleryImage Box1 boxinfo">
                        <a id="dbjybl" class="post-img internal" href="index.jsp?pagetype=1#uid:top3">
                            <div>
                                <img src="/css/zimg/人大代表议案建议办理系统_06.png" /></div>
                        </a>
                    </div>
                    <div class="galleryImage Box2 boxinfo">
                        <a id="dblzgl" class="post-img internal"  href="index.jsp?pagetype=2#uid:top2">
                            <div>
                                <img src="/css/zimg/人大代表履职-服务系统_08.png" /></div>
                        </a>
                    </div>
                    <div class="galleryImage Box3 boxinfo">
                        <a id="nswgzgl"  class="post-img internal" href="index.jsp?pagetype=3#uid:top11" >
                            <div>
                                <img src="/css/zimg/人大监督工作-管理系统_13.png" /></div>
                        </a>
                    </div>
                    <div class="galleryImage Box4 boxinfo">
                        <a id="zhhwpt"  class="post-img internal" href="javascript:void(0);">
                            <div>
                                <img src="/css/zimg/司法监督系统_15.png" /></div>
                        </a>
                    </div>
                    <div class="galleryImage Box5 boxinfo">
                        <a class="post-img" href="http://47.104.140.240:7001/defaultroot/login.jsp" target="_blank">
                            <div>
                                <img src="/css/zimg/机关办公-OA系统_18.png" /></div>
                        </a>
                    </div>
                    <div class="galleryImage Box6 boxinfo">
                        <a id="llzgl" class="post-img internal"  href="javascript:void(0);" >
                            <div>
                                <img src="/css/zimg/信访工作系统_24.png" /></div>
                        </a>
                    </div>
                     <div class="galleryImage Box7 boxinfo">
                        <a id="zhhwpt"  class="post-img internal" href="index.jsp?pagetype=5#uid:top6,sid:top6menutop1notice1">
                            <div>
                                <img src="/css/zimg/人大代表网上联络站_31.png" /></div>
                        </a>
                    </div>
                  
                </div>
                <div class="Box-right">
                    <div class="Box10 boxinfo">
                        <div class="banner">
                            <div id="JINGDONGBox">
                                <div id="JINGDONGContentID">
                                    <ul>
                                        <li>
                                            <img src="/css/zimg/图片_03.png"/>
                                        </li>
                                      
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="galleryImage Box8 boxinfo">
                        <a class="post-img internal"  href="index.jsp?pagetype=4#uid:my,sid:mywelcomerepresentative">
                            <div>
                                <img src="/css/zimg/信息管理系统.png" alt="" />
                            </div>
                        </a>
                    </div>
                    <div class="galleryImage Box9 boxinfo">
                        <a class="post-img" target="_blank">
                            <div>
                                <img src="/css/zimg/智慧会务管理_28.png" /></div>
                        </a>
                    </div>
                </div> 
            </div>
        </div>
        <div class="footer"></div>
        <script type="text/javascript" src="js/gateway.js"></script>
    </body>
</html>