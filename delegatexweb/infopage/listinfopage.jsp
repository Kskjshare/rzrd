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
            body>div img{display:flex;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #webbody{margin: 10px;border: #cccccc solid thin; padding: 0;}
            #webbody h1{line-height: 39px;color:#039f62;font-size: 15px;;background:linear-gradient(#e2fffc,#fff); font-weight: 400;margin: 0;text-align: left;text-indent: 10px; }
            #webbody h1>span{font-size: 24px;display: block;margin: 0 10px;border-bottom: #a3dbd3 solid 1px;}
            #webbody h2{font-size: 26px;text-align: center;}
            #webbody h3{font-size: 24x;font-weight: 400;text-align: center;color: #333333}
            #webbody>div{margin: 0 23px;}
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1096px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{width: 100%;text-align: center;line-height: 22px;font-size: 14px; margin: 0;}
            h1{text-align: center;}
            #webbody img{max-width: 80%;max-height: 580px;text-align:center;}
            /*#webbody>img{}*/
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            .popuplayer,.calendarwrap{display: none;}
            #ico{text-align: center;}
            
            .footerDiv {
              width:180%;
              min-width:1200px; 
              height:130px; 
              /*background-color: #1c92cf;*/
              background-color: #0078cd;
              font-size: 14px;
              color: #ffffff;
              display: flex; 
              justify-content: center;
              margin-left: -40%;
            }
        </style>
    </head>
    <body>
        <%
            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
            String view = "workdynamics";
            //if (req.get("cla").isEmpty()) {
            if ( req.get("cla").equals("2") ) {
                view = "stationcontent";
            }
            view = "stationcontent";
            RssListView entity = new RssListView(pageContext, view);
            entity.select().where("id=?", req.get("ind")).get_first_rows();
        %>
        <div>
            <div id="header"></div>
            <div id="webbody">
                <!--<h1><span><% // out.print( req.get("contacttype").equals("2") ? "工作动态" : "通知公告");%></span></h1>-->
                <h1><span><% 
                    if (  req.get("cla").equals("2") ) {
                         out.print("工作动态");
                    }
                    else if (  req.get("cla").equals("3") ) {
                         out.print("通知公告");
                    }
                    else if (  req.get("cla").equals("4") ) {
                         out.print("代表履职");
                    }
//                    out.print( req.get("cla").equals("2") ? "工作动态" : "通知公告");
                %></span></h1>

                <h2><% out.print(entity.get("title"));%></h2>
                <!--<h3 rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd hh:mm:ss"></h3>-->
                <h3  rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd hh:mm:ss"></h3>
                <%
                if (!entity.get("ico").equals("") ){
                %>
                <!--<div id="ico"><img src="<%out.print(entity.get("ico"));%>"></div>-->
                 <div id="ico"><img src="/upfile/<% out.print(entity.get("ico"));%>"></div>
                <%
                };
                %>
                <div><% out.print(entity.get("matter"));%></div>
               
            </div>
                
            <div style="width:98.0%" id="footer">
                <p style="width:95.6%;">主办：汝州市人大常委会办公室</p>
                <p style="width:81.6%;">协办：</p>
                <p style="width:90%;">电话：03756862978</p>
                <p>地址：平顶山市汝州市丹阳中路268号&nbsp&nbsp&nbsp</p>
            </div>
                
<!--        <div class="footerDiv" style="position: relative;margin-bottom: -60px">
        <img  style="height:70px;width:70px;position: relative;margin-top: 35px;left: -70px;" src="https://uploads.dahe.cn/rdq/srd/img/red.png" alt="">
        <div >
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
            <p style="height:24px;">主办：汝州市人大常委会办公室&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;豫ICP备17035523号</p>
            <p style="height:24px;">电话：0375-6862978&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮编：467500</p>
            <p style="height:24px;">地址：平顶山市汝州市丹阳中路268号</p>
        </div>
        </div>        -->
                
                
        </div>
        <%@include  file="/inc/js.html" %>
        <script>

        </script>
    </body>
</html>
