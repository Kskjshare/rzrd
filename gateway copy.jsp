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
        <script type="text/javascript">
            if (self !== top)
            {
                top.location = self.location;
            }

        </script>
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
                        <img class="user_img" src="css/limg/user.png" /><% out.print(name);%><span title=" <% out.print(name);%>"></span>
                    </a>&nbsp;
                    <a href="loginout.jsp">
                        <img src="css/limg/out.png" style="width: 4%;"/>退出&nbsp;
                    </a>
                </div>
            </div>
        </div>
        <div class="Contain">
            <div class="HomeContain">
               <img class="proPage" src="./css/zimg/上一页_03.png" alt="">
               <img class="nextPage" src="./css/zimg/下一页_05.png" alt="">
               <table>
                <tr>
                    <td colspan="2">
                        <a href="index.jsp?pagetype=1#uid:top3"><img src="/css/zimg/人大代表议案建议办理系统_06.png" alt=""></a>
                    </td>
                    <td>
                        <a href="index.jsp?pagetype=2#uid:top2"><img src="/css/zimg/人大代表履职-服务系统_08.png" alt=""></a>
                    </td>
                    <td colspan="3" rowspan="2">
                        <a><img class="slider_img" src="/css/zimg/图片_03.png" alt=""></a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a  href="index.jsp?pagetype=3#uid:top11"><img src="/css/zimg/人大监督工作-管理系统_13.png" alt=""></a>
                    </td>
                    <td>
                        <a href="javascript:void(0);"><img src="/css/zimg/司法监督系统_15.png" alt=""></a>
                    </td>
                    <!--http://47.104.140.240:7001/defaultroot/login.jsp-->
                    <td>
                        <a href="user_md5.jsp" target="_blank"><img src="/css/zimg/机关办公-OA系统_18.png" alt=""></a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="index.jsp?pagetype=6#uid:top14,sid:top14menutop1notice4" ><img src="/css/zimg/信访工作系统_24.png" alt=""></a>
                    </td>
                    <td colspan="2">
                        <a href="index.jsp?pagetype=5#uid:top6,sid:top6menutop1notice1"><img src="/css/zimg/人大代表网上联络站_31.png" alt=""></a>
                    </td>
                    <td>
                        <a href="index.jsp?pagetype=4#uid:my,sid:mywelcomerepresentative"><img class="message" src="/css/zimg/信息管理系统.png" alt=""></a>
                    </td>
                    <td colspan="2">
                        <a href="index.jsp#uid:top13,sid:top13menutop1notice"><img class="message_10" src="/css/zimg/智慧会务管理_28.png" alt=""></a>
                    </td>
                </tr>

                
        
            </table>
              
            </div>
        </div>
        <div class="footer" style="text-align: center">汝州市人大综合服务管理平台</div>
        <script type="text/javascript" src="js/gateway.js"></script>
    </body>
</html>