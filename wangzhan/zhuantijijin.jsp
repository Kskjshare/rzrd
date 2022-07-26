<%-- 
    Document   : zhuantijijin
    Created on : 2021-4-7, 14:15:11
    Author     : Administrator
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Calendar"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>

<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Date"%>


<%
 RssList entity1 = new RssList(pageContext, "special");
%>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
  <title>汝州人民代表大会常务委员会</title>
  <meta name="keywords" content="">
  <meta name="description" content="">
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="css/nav.css">
                <style>
        #nav .nav-item a {
            padding-bottom: 5px;
            box-sizing: border-box;
        }

        #nav .nav-item a:hover {
            border-bottom: 3px solid #C5E1E4;
        }

        #juedui:hover {
            background: red;
        }
    </style>
</head>
<body>
            <table width="1000" height="102" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr style="height:180px;">
                </tr>
            </table>
            <div style="width:102%; min-width:700px; height:50px;  background-image: url(./images/nav.jpg); background-size:150% 150%; display: flex; justify-content: center">
            <div style="width:70%;min-width:920px; height: 100%;">
                <ul id="nav"style="display: flex; justify-content: space-around; margin-left: -10px; font-family:微软雅黑;font-weight:bold; line-height:50px;letter-spacing:2px;">
                    <li class="nav-item">
                        <a href="index.htm" target="_parent" style="font-size: 20px;color: #fff3f3;">
                            首页
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="about.htm" target="_parent" style="font-size: 20px;color: #fff3f3">
                            人大概况
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="jgsz.htm" target="_parent" style="font-size: 20px;color: #fff3f3">
                            机构设置
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="News.htm?classifyid=11" target="_parent" style="font-size: 20px;color: #fff3f3">
                            机关建设
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="News.htm?classifyid=1" target="_parent" style="font-size: 20px;color: #fff3f3">
                            人大要闻
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="News.htm?classifyid=8" target="_parent" style="font-size: 20px;color: #fff3f3">
                            决议决定
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="News.htm?classifyid=6" target="_parent" style="font-size: 20px;color: #fff3f3">
                            监督工作
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="News.htm?classifyid=10" target="_parent" style="font-size: 20px;color: #fff3f3">
                            选举任免
                        </a>
                    </li>
                    <li class="nav-item"><a href="News.htm?classifyid=9" target="_parent" style="font-size: 20px;color: #fff3f3">
                            最新公告
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="zhuantijijin.jsp" target="_parent"  style="font-size: 20px;color: #fff3f3">
                            专题集锦
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px; margin-bottom:10px;">
            <tr>
                <td height="401" valign="top">
                    <table width="1000" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="235" height="401" valign="top">
                                <table width="235" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="32" background="images/n4.jpg">
                                            <div class="n03">
                                                通知公告
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" background="images/n5.jpg">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td width="4%">
                                                        &nbsp;
                                                    </td>
                                                    <td width="96%" class="notice">
                                                        <p class="i08 curpoi">
                                                            <span bindattr="rssid" title>
                                                            </span>
                                                        </p>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="4" background="images/n6.jpg">
                                        </td>
                                    </tr>
                                </table>
                                <table width="235" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px; margin-bottom:10px;">
                                    <tr>
                                        <td height="32" background="images/n4.jpg">
                               <div class="n03">图片内容</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" background="images/n5.jpg">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <img src="./images/ch/shicha.jpg" style="width:160px; height:120px;display:block; margin: 17px auto;"/>
                                                        <h4 style="text-align:center;">
                                                            代表视察活动
                                                        </h4>
                                                    <img src="./images/ch/zhongyao.jpg" style="width:160px; height:120px;display:block; margin: 20px auto;"/>
                                                        <h4 style="text-align:center;">
                                                            重要
                                                        </h4>
                                                    <img src="./images/ch/jiguandangjian.png" style="width:160px; height:120px;display:block; margin:18px  auto;"/>
                                                        <h4 style="text-align:center;">
                                                            机关建设
                                                        </h4>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="4" background="images/n6.jpg"></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="40" valign="top" background="images/n1.jpg">
                                            <div style="margin-left: .8rem;" class="n01">                                              
                                                <a href="index.htm">
                                                    首页 
                                                </a> 
                                                > 专题集锦
                                            </div>
                                        </td>
                                    </tr>
                                    <tr >
                                        <td height="105" valign="top" background="images/n2.jpg">
                                            <a href="./new_ztjj.jsp"><img src="images/dangshi.jpg" width="755" height="100"></a>
                                        </td>
                                    </tr>
                                 
                                <%
                                    
                                      HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                                     entity1.select().where("subjectpicture like '%" + 
                                            URLDecoder.decode(req.get("subjectpicture"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                    int a=1;
                                         while (entity1.for_in_rows()) {
                                %>
                                <tr >
                                    <td height="105" width="755">
                               <a href="./new_ztjj.jsp"> <img  src="/upfile/<% entity1.write("subjectpicture"); %>" height="105" width="755"></a>
                                    </td>
                                </tr>
                                <%
                                   a++;
                                }
                                %>
                    
                                    <tr>
                                        <td height="8" background="images/n3.jpg"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="1000" height="2" border="0" align="center" cellpadding="0" cellspacing="0" background="images/f.jpg">
            <tr>
            <td></td>
            </tr>
        </table>
        <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="165" height="11"></td>
                <td width="785"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="11%" height="30" align="center">
                                <p class="bai">&nbsp;</p>
                            </td>
                            <td width="79%" align="center">
                                <span class="bai">Copyright 2004-2015 All Rights Reserved 版权所有：汝州人民代表大会常务委员会豫ICP备17035523号 网站管理</span>
                            </td>
                            <td width="10%" rowspan="2" align="center">
                                <script type="text/javascript">
                                    document.write(unescape("%3Cspan id='_ideConac' %3E%3C/span%3E%3Cscript src='../dcs.conac.cn/js/17/254/0000/40669570/CA172540000406695700001.js'/*tpa=http://dcs.conac.cn/js/17/254/0000/40669570/CA172540000406695700001.js*/ type='text/javascript'%3E%3C/script%3E"));
                                </script>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
                </table>
                <script src="js/md5.min.js"></script>
                <script src="data/dictdata.js"></script>
                <script src="data/rsscode.js"></script>
                <script src="js/jquery.min.js"></script>
                <script src="js/jquery.mousewheel.min.js"></script>
                <script src="js/rsseasy.min.js"></script>
                <script src="js/rsseasy/html.min.js"></script>
                <script src="js/rsseasy/adapter.min.js"></script>
                <script src="js/rsseasy/app.js"></script>
                <script src="js/rsseasy/comment.js"></script>
                <script src="js/rsseasy/component.js"></script>
                <script src="js/rsseasy/advert.min.js"></script>
                <script src="js/rsseasy/user.min.js"></script>
                <script src="js/rsseasy/rssapi.min.js"></script>
                <script src="js/rsseasy/progressbar.min.js"></script>
                <script src="js/validated.v2.min.js" type="text/javascript"></script>
                <script src="js/rsseasy/validatedv3.min.js"></script>
                <script src="js/rsseasy/weixin.js" type="text/javascript"></script>
                <script src="js/li/echarts.min.js" type="text/javascript"></script>
                <script src="js/li/clipboard.min.js" type="text/javascript"></script>
                <script src="https://unpkg.com/video.js@6.11.0/dist/video.min.js"></script>
                <script src="js/paging.js"></script>
                <script src="js/News_show.js"></script>
                <script>
                    (function () {
                      var $backToTopEle = $('.wx_backtop > a');
                      $backToTopEle.click(function () {
                        $("html, body").animate({ scrollTop: 0 }, 500);
                      });
                      var $backToTopFun = function () {
                        var st = $(document).scrollTop(), winh = $(window).height();
                        //IE6下的定位


                        if (!window.XMLHttpRequest) {
                          $backToTopEle.css("top", st + winh - 310);
                        }
                      };
                      $(window).bind("scroll", $backToTopFun);
                      $(function () { $backToTopFun(); });
                    })();
                </script>

