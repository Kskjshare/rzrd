<%-- 
    Document   : bmweb
    Created on : 2018-7-13, 17:00:53
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="java.time.DateTimeException"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>云上人大代表联络站</title>
<!--        <meta charset="UTF-8">-->
        <meta http-equiv=Content-Type content='text/html; charset=utf-8'/>
<!--        <meta name="viewport" content="width=device-width, initial-scale=1.0">-->

        <style>
            body{width: 1100px;margin: 0 auto;letter-spacing:1.2px;font-family: 微软雅黑;}
            #header{
                width: 100%;
                /*background:url(img/header.png) no-repeat;*/
                background-size:100%;
                height:123px;
            }
            
            
            
        .link_url {
            width: 16px;
            height: 6px;
            position: absolute;
            font-size: 12px !important;
            background: red;
            opacity: .3;
        }
        .btn_contactstation {
            position: relative;
        }
            
            nav{height: 60px;width: 100%; background: linear-gradient(#2fb2fa,#006ec8);letter-spacing:2px; font-weight:bold;}      
            nav a{background:url(img/shuxian.png) no-repeat 0 5px;  color: #fff;width: 98px;display:inline-block;line-height: 28px;text-align: center;cursor: pointer;}
            nav a:first-child{border: 0;margin-left: 6px;background:0 ;transform: translateX(10px);}
            nav a:nth-child( 12 ){width: 70px;border: 0;margin-left: 36px;background:0}
 
            
            #webbody {background:url(img/bodybackground.png) no-repeat;background-size: 750px 650px;height:600px;position:relative; }
            #webbody>div{float: right;margin:10px 0 0px 600px;width: 330px;line-height: 30px;border: #cacaca solid 2px;padding: 4px;padding-bottom: 9px;}
           
            
            
            
            
             /*#webbody>a:nth-child(1){height:20px;width:48px;position:absolute;top:128px;left:66px;}*/
              /*#webbody>a:nth-child(2){height:20px;width:48px;position:absolute;top:456px;left:114px;}*/
/*               #webbody>a:nth-child(3){height:20px;width:48px;position:absolute;top:198px;left:128px;}
            #webbody>a:nth-child(4){height:20px;width:48px;position:absolute;top:298px;left:182px;}
            #webbody>a:nth-child(5){height:20px;width:48px;position:absolute;top:126px;left:298px;}
            #webbody>a:nth-child(6){height:20px;width:48px;position:absolute;top:190px;left:194px;}
            #webbody>a:nth-child(7){height:20px;width:48px;position:absolute;top:454px;left:504px;}
            #webbody>a:nth-child(8){height:20px;width:48px;position:absolute;top:154px;left:650px;}
            #webbody>a:nth-child(9){height:20px;width:48px;position:absolute;top:288px;left:584px;}
            #webbody>a:nth-child(10){height:20px;width:48px;position:absolute;top:238px;left:358px;}
            #webbody>a:nth-child(11){height:20px;width:48px;position:absolute;top:346px;left:328px;}*/
            #webbody>a:nth-child(1){height:280px;width:108px;position:absolute;top:8px;left:6px;}/*临汝镇*/
            #webbody>a:nth-child(2){height:180px;width:180px;position:absolute;bottom:8px;left:6px;}  /* 寄料镇*/
            #webbody>a:nth-child( 3 ){height:110px;width:30px;position:absolute;top:148px;left:140px;}/*温泉镇*/
            #webbody>a:nth-child( 4 ){height:100px;width:180px;position:absolute;top:268px;left:120px;}/*杨楼*/
            #webbody>a:nth-child( 5 ){height:210px;width:168px;position:absolute;bottom:8px;left:244px;}  /* 蟒川镇*/
            #webbody>a:nth-child( 6 ){height:240px;width:40px;position:absolute;top:8px;left:180px;}/*庙下*/      
            #webbody>a:nth-child( 7 ){height:180px;width:40px;position:absolute;top:8px;left:240px;}/*夏店镇*/
            #webbody>a:nth-child( 8 ){height:150px;width:120px;position:absolute;top:20px;left:340px;}/*陵头镇*/
            
            #webbody>a:nth-child( 9 ){height:80px;width:120px;position:absolute;top:180px;left:280px;}/*骑领乡????*/
            #webbody>a:nth-child( 10 ){height:60px;width:80px;position:absolute;top:140px;left:400px;}/*骑领乡????*/
            #webbody>a:nth-child( 11 ){height:60px;width:80px;position:absolute;top:240px;left:320px;}/*骑领乡????*/
            
            #webbody>a:nth-child( 12 ){height:140px;width:120px;position:absolute;top:180px;left:460px;}/*米庙镇*/
            #webbody>a:nth-child(13){height:80px;width:98px;position:absolute;top:346px;left:300px;}/*王寨乡*/
            
            #webbody>a:nth-child( 14 ){height:80px;width:180px;position:absolute;top:80px;left:480px;}/*大峪*/
            #webbody>a:nth-child( 15 ){height:40px;width:160px;position:absolute;top:160px;left:580px;}/*大峪*/
            #webbody>a:nth-child( 16 ){height:40px;width:80px;position:absolute;top:200px;left:620px;}/*大峪*/
            
            #webbody>a:nth-child( 17 ){height:40px;width:30px;position:absolute;top:200px;left:580px;}/*焦村*/
            #webbody>a:nth-child( 18 ){height:40px;width:60px;position:absolute;top:240px;left:620px;}/*焦村*/
            #webbody>a:nth-child( 19 ){height:40px;width:140px;position:absolute;top:280px;left:580px;}/*焦村*/
            #webbody>a:nth-child( 20 ){height:40px;width:60px;position:absolute;top:320px;left:580px;}/*焦村*/
            
            #webbody>a:nth-child( 21 ){height:30px;width:140px;position:absolute;top:380px;left:500px;}/*纸坊镇*/
            #webbody>a:nth-child( 22 ){height:30px;width:120px;position:absolute;top:410px;left:520px;}/*纸坊镇*/
            #webbody>a:nth-child( 23 ){height:20px;width:80px;position:absolute;top:440px;left:540px;}/*纸坊镇*/
            #webbody>a:nth-child( 24 ){height:20px;width:30px;position:absolute;top:480px;left:600px;}/*纸坊镇*/
            #webbody>a:nth-child( 25 ){height:30px;width:120px;position:absolute;top:340px;left:460px;}/*纸坊镇*/

            #webbody>a:nth-child( 26 ){height:160px;width:120px;position:absolute;bottom:60px;left:420px;}  /* 小屯镇*/
            #webbody>a:nth-child( 27 ){height:60px;width:140px;position:absolute;bottom:30px;left:420px;}  /* 小屯镇*/
               
            #webbody>div>p{background: url(img/greystar.png) no-repeat 4px 11px; margin: 0;font-size: 14px;margin-left: 10px;text-indent: 20px;border-bottom: #cacaca dashed 1px;cursor: pointer;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #webbody>div>h1{ margin: 0;font-size: 18px;color:#0071d2 ;text-indent: 10px;background: #f5f5f5;margin-bottom: 9px;font-weight: 500 ;font-weight:bold;}
            #webbody>div>h1>span{float: right;color: #333333;font-size: 12px;cursor: pointer;}
            
           
            #webbody>div>h2{margin: 0;font-size: 18px;color:#0071d2 ;text-indent: 10px;background: #f5f5f5;margin-bottom: 9px;font-weight: 500 ;font-weight:bold;}
            #webbody>div>h2>span{float: right;color: #333333;font-size: 12px;cursor: pointer;}
            #webbody>div>h3{margin: 0;font-size: 18px;color:#0071d2 ;text-indent: 10px;background: #f5f5f5;margin-bottom: 9px;font-weight: 500 ;font-weight:bold;}
            #webbody>div>h3>span{float: right;color: #333333;font-size: 12px;cursor: pointer;}
            #webbody>div>h4{margin: 0;font-size: 18px;color:#0071d2 ;text-indent: 10px;background: #f5f5f5;margin-bottom: 9px;font-weight: 500 ;font-weight:bold;}
            #webbody>div>h4>span{float: right;color: #333333;font-size: 12px;cursor: pointer;}
            
            
            
            #webbody>div>div>label{display: inline-block;margin: 0 ;width: 160px;}
            #webbody>div>div{ padding-left: 10px; font-size: 14px;}
            #webbody>div>div>input{ margin: 0 5px;height: 25px; vertical-align: middle; border: #cacaca solid 2px;text-indent: 5px;}
            #webbody>div>div>button{width: 80px;height: 27px; background: #415ef0; color: #fff;border: none; border-radius: 5px;vertical-align: middle;letter-spacing:6px;font-weight:bold;}
            #newlist{padding:0;}
            
            /*把边框*/
            #newlist li{list-style-type: none; width: 530px; display: inline-block; line-height: 30px; border: #cacaca solid 2px; padding: 4px; padding-bottom: 9px;margin-bottom: 10px;vertical-align: top;}
            #newlist li h1{ margin: 0;font-size: 20px;color: #0071d2; text-indent: 10px;background: #f5f5f5;margin-bottom: 9px;font-weight: 500;font-weight:bold; }
            /*#newlist li h_one{background: url(img/greystar.png) no-repeat 4px 11px; font-size: 16px;margin:0 10px;text-indent: 20px;background: #f5f5f5;font-weight: 500;font-weight:bold;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}*/
            #newlist li h_one{background: url(img/greystar.png) no-repeat 4px 11px; font-size: 16px;margin:0 10px;text-indent: 20px;border-bottom: #cacaca dashed 1px;cursor: pointer;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}

            
            #newlist li>div{ height: 120px;margin: 0 10px 5px 0;}
            #newlist li>div>div{float: left; width: 160px;height: 110px;overflow: hidden;margin-right: 10px; }
            #newlist li>div>div>img{width: 160px;cursor: pointer;}
            .imgCls {width: 160px;cursor: pointer;height:80%;}
           .divCls {float: left; width: 160px;height: 140px;overflow: hidden;margin-right: 10px;}

            #newlist li>div>p{text-indent: 2em;line-height: 18px;font-size: 16px;height: 110px;overflow: hidden; font-weight: 500; cursor: pointer; color:gray;}
            /*#newlist li>div>p:hover{color: blue}*/
             /*#newlist li>p img{width: 10px;cursor: pointer;}*/
             
            #newlist li>p{background: url(img/greystar.png) no-repeat 4px 11px; font-size: 16px;margin:0 10px;text-indent: 20px;border-bottom: #cacaca dashed 1px;cursor: pointer;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
            #newlist li>p:hover{color: blue}
            
            #newlist .top2>p{img:url(img/blueright.png); background: url(img/greystar.png) no-repeat 4px 10px;}
            .popuplayer,.calendarwrap{display: none;}
            #newlist li:last-of-type{list-style-type: none; width:1089px; display: inline-block; line-height: 30px; border: #cacaca solid 2px; padding: 4px; padding-bottom: 9px;margin-bottom: 10px;vertical-align: top}
            em{font-size: 12px;
               float: right;
               margin-right: 12px;cursor: pointer}
            em:hover{color: red}
            
  
        </style>
    </head>
    <body>
        <div id="header"></div>
        <nav><a>首页</a></nav>
        <div id="webbody" class="btn_contactstation">
            
            <a class='link_url' href="http://117.158.113.36:80/delegatexweb2/contactstation.htm?myid=103&mission=1027" style='top:503px;left:566px' title='河张人大代表联络站'></a>

            <!--<a href="/delegatexweb2/contactstation.htm?myid=104&mission=1027"></a>-->
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1028&stationid=8"></a>

            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=9"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=10"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=11"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=17"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=13"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=20"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=12"></a>
            
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=21"></a>
             <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=21"></a>
              <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=21"></a>
            
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=14"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=22"></a>
            
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=18"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=18"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=18"></a>
            
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=19"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=19"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=19"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=19"></a>
            
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=16"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=16"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=16"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=16"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=16"></a>
            
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=15"></a>
            <a href="/delegatexweb/infopage/delegationinfo.jsp?myid=1029&stationid=15"></a>
            <div>
                <h1>代表联络站站点<span>更多&nbsp;>></span></h1>
                <%
                    RssListView list = new RssListView(pageContext, "contactstation_sub");
                    list.pagesize = 2;
                    list.select().get_page_asc("id");
                    while (list.for_in_rows()) {
                %>
                <p stationid="<% out.print(list.get("stationid"));%>"><% out.print(list.get("title"));%></p>
                <%
                    }
                %>
            </div>
            
            <div>
                <h2>规范化联络站<span>更多&nbsp;>></span></h2>
                <%
                    RssList list_1 = new RssList(pageContext, "contactstation_sub");
                    list_1.pagesize = 2;
                    list_1.select().where("demonstration=3").get_page_desc("id");
                    while ( list_1.for_in_rows() ) {
                %>
                <p stationid="<% out.print( list_1.get("stationid"));%>"><% out.print( list_1.get("title"));%></p>
                <%
                 }
                %>
            </div>
            <div>
                <h3>示范联络站<span>更多&nbsp;>></span></h3>
                <%
                    RssList list_2 = new RssList(pageContext, "contactstation_sub");
                    list_2.pagesize = 2;
                    list_2.select().where("demonstration=2").get_page_desc("id");
                    while ( list_2.for_in_rows() ) {
                %>
                <p stationid="<% out.print( list_2.get("stationid"));%>"><% out.print( list_2.get("title"));%></p>
                <%
                 }
                %>
            </div>
            <div>
                <h4>明星联络站<span>更多&nbsp;>></span></h4>
                <%
                    RssList list_3 = new RssList(pageContext, "contactstation_sub");
                    list_3.pagesize = 2;
                    list_3.select().where("demonstration=4").get_page_desc("id");
                    while ( list_3.for_in_rows() ) {
                %>
                <p stationid="<% out.print( list_3.get("stationid"));%>"><% out.print( list_3.get("title"));%></p>
                <%
                 }
                %>
            </div>
            
<!--            <div>
                <h1>查询联络站</h1>
                梁小竹修改
                <div>站点名称<input type="text" id="lianluozhan"><button type="button" id="searchllz">查询</button></div>
            </div>-->
           
            <div>
                <h1>查询代表</h1>
                <div><label><input type="radio" name="delegate" circlesid="0">全国人大代表</label><label><input type="radio" name="delegate" circlesid="1">河南省人大代表</label><label><input type="radio" name="delegate" circlesid="2">平顶山市人大代表</label><label><input type="radio" name="delegate" circlesid="3">汝州市人大代表</label><label><input type="radio" name="delegate" circlesid="4">乡镇人大代表</label></div>
                <div>代表姓名<input type="text" id="daibiaoxingming"><button type="button" id="searchuser">查询</button></div>
            </div>
        </div>
        <ul id="newlist">
            <li class="top2" >
<!--                <h1>工作动态<em gd="1" style="display: none">..更多>></em></h1>-->
                    <h1>
                        <img src="img/blueright.png">
                        工作动态<em gd="1" style="display: none">..更多>></em>
                    </h1>
                <%
                    //RssListView list1 = new RssListView(pageContext, "workdynamics");
                    RssList list1 = new RssList(pageContext, "stationcontent");
                    list1.request();
                    
                  
//                    list1.pagesize = 5;
                    int a = 1;
                    list1.select().where("classify=1 and state=2").get_page_desc("id");
                    while (list1.for_in_rows()) {
                        if (a == 1) {
                            if (list1.get("ico") != "") {
                %>
                <div ind="<% out.print( list1.get("id"));%>" cla="2"><div><img src="/upfile/<% out.print(list1.get("ico"));%>" alt=""/></div><p><% out.print( list1.get("title") );%></p></div>
                 <%
                 } else {
                 %>
                <p ind="<% out.print(list1.get("id"));%>" cla="2"><% out.print(list1.get("title"));%></p>        
                <%
                    }
                    a = 2;
                } else {
                %>
                <p ind="<% out.print(list1.get("id"));%>" cla="2"><% out.print(list1.get("title"));%></p>
                <%
                        }
                    }
                %>
            </li>
            <li class="top2">              
                 <h1>通知公告<em gd="2" style="display: none" >..更多>></em></h1>
                <%
//                    RssListView list2 = new RssListView(pageContext, "workdynamics"); // workdynamics
                    RssList list2 = new RssList(pageContext, "stationcontent");

//                    list2.pagesize = 5;
                     int a1 = 1;
                    list2.select().where("classify=3 and state=2").get_page_desc("id");
                    while (list2.for_in_rows()) {
                        if (a1 == 1) {
                           if (list2.get("ico") != "") {
                %>
                 <div ind="<% out.print( list2.get("id"));%>" cla="3"><div><img src="/upfile/<% out.print(list2.get("ico"));%>" alt=""/></div><p><% out.print( list2.get("title") );%></p></div>
                 <%
                     a1 = 2 ;
                 } 
                else {
                %>
                <p ind="<% out.print(list2.get("id"));%>" cla="3"><% out.print(list2.get("title"));%></p>
                <%
                }
                }else {
                 %>
                <p ind="<% out.print(list2.get("id"));%>" cla="3"><% out.print(list2.get("title"));%></p>
                
                
                <%
                }
                }
                %>     
            </li>
            
            
            
            
            
            
            
            
            
            
            
            
         <li>
                <h1>代表履职<em gd="3" style="display: none">..更多>></em></h1>
                <%
                    //RssListView list1 = new RssListView(pageContext, "workdynamics");
                    //RssList list12 = new RssList(pageContext, "workdynamics");
                    RssList list12 = new RssList(pageContext, "stationcontent");

                    list12.request();
                    
                  
//                    list12.pagesize = 5;
                    int a12 = 1;
                    //list12.select().where("classify=1 and state=2").get_page_desc("id");
                    list12.select().where("classify=2 and state=2").get_page_desc("id");

                    while (list12.for_in_rows()) {
                        if (a12 == 1) {
                            if (list12.get("ico") != "") {
                %>
                <div ind="<% out.print( list12.get("id"));%>" cla="3"><div><img src="/upfile/<% out.print(list12.get("ico"));%>" alt=""/></div><p><% out.print( list12.get("title") );%></p></div>
                 <%
                 } else {
                 %>
                <p ind="<% out.print(list12.get("id"));%>" cla="3"><% out.print(list12.get("title"));%></p>        
                <%
                    }
                    a12 = 2;
                } else {
                %>
                <p ind="<% out.print(list12.get("id"));%>" cla="3"><% out.print(list12.get("title"));%></p>
                <%
                        }
                    }
                %>
            </li>
            <li>              
                 <h1>代表风采<em gd="4" style="display: none">..更多>></em></h1>
                <%
                    //RssListView list1 = new RssListView(pageContext, "workdynamics");
//                    RssList list4 = new RssList(pageContext, "workdynamics");
                    RssList list4 = new RssList(pageContext, "stationcontent");

                    list4.request();
                    
                  
//                    list4.pagesize = 5;
                    int a4 = 1;
                    //list12.select().where("classify=1 and state=2").get_page_desc("id");
                    list4.select().where("classify=4 and state=2").get_page_desc("id");

                    while (list4.for_in_rows()) {
                        if (a4 == 1) {
                            if (list4.get("ico") != "") {
                %>
                <div ind="<% out.print( list4.get("id"));%>" cla="4"><div><img src="/upfile/<% out.print(list4.get("ico"));%>" alt=""/></div><p><% out.print( list4.get("title") );%></p></div>
                 <%
                 } else {
                 %>
                <p ind="<% out.print(list4.get("id"));%>" cla="4"><% out.print(list4.get("title"));%></p>        
                <%
                    }
                    a4 = 2;
                } else {
                %>
                <p ind="<% out.print(list4.get("id"));%>" cla="4"><% out.print(list4.get("title"));%></p>
                <%
                        }
                    }
                %>
             
            </li>    
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
          
            
            
            <li class="top2" style="display: none">              
              
            </li>
            
 
      
        </ul>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#webbody>div>p").click(function () {
                var stationid = $(this).attr("stationid")
                window.open("/delegatexweb/infopage/delegationinfo.jsp?stationid=" + stationid)
//                location.href = "/delegatexweb/infopage/delegationinfo.jsp?myid=" + myid;
            })
            $("[gd]").click(function () {
                var gd = $(this).attr("gd");
                switch (gd) {
                    case "1":
                        window.open("/delegatexweb/listinfopage.jsp?gd=" + gd);
                        return false
                        break;
                    case "2":
                        window.open("/delegatexweb/listinfopage.jsp?gd=" + gd);
                        return false
                        break;
                    case "3":
                        window.open("/delegatexweb/listStattionpage.jsp?gd=" + gd);
                        return false
                        break;
                    case "4":
                        window.open("/delegatexweb/listinfopage.jsp?gd=" + gd);
                        return false
                        break;
                    case "5":
                        window.open("/delegatexweb/listStattionpage.jsp?gd=" + gd);
                        return false
                        break;
                }
            })
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
                        window.open("/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla)
//                        location.href = "/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&cla=" + cla;
                        return false
                        break;
                    case "5":
                        window.open("/delegatexweb/infopage/delegationinfo.jsp?stationid=" + ind)
//                        location.href = "/delegatexweb/infopage/delegationinfo.jsp?myid=" + ind;
                        return false
                        break;
                }
            })
            $("#webbody>div>h1>span").click(function () {
                window.open("/delegatexweb/infopage/llzlist.jsp")
            })
            
            $("#webbody>div>h2>span").click(function () {
                window.open("/delegatexweb/infopage/llzlist2.jsp")
            })
            
            $("#webbody>div>h3>span").click(function () {
                window.open("/delegatexweb/infopage/llzlist3.jsp")
            })
            
            $("#webbody>div>h4>span").click(function () {
                window.open("/delegatexweb/infopage/llzlist4.jsp")
            })
            
            
            $("#searchllz").click(function () {
                var searchllz = $(this).siblings("input").val();
                //梁小竹修改
//                var urla = encodeURI(searchllz)
                var urla = $("#lianluozhan").val();
//                alert(urla);
                $.get("/delegatexweb/jsp/searchllz.jsp", {'search': urla}, function (json) {
                    if (json == "no") {
                        alert("该联络站不存在")
                    } else {
//                        window.open("/delegatexweb/infopage/delegationinfo.jsp?myid=" + json)
                        //梁小竹修改
//                        alert(json);
                        window.open("/delegatexweb/infopage/delegationinfo.jsp?stationid=" + json)
//                        location.href = "/delegatexweb/infopage/delegationinfo.jsp?myid=" + json;
                    }
                })
            })
            $("#searchuser").click(function () {
                var searchuser = $(this).siblings("input").val();
                //梁小竹修改
//                var urla = encodeURI(searchuser)
                var urla = $("#daibiaoxingming").val();
                var circles = "";
                $("[name='delegate']").each(function () {
                    if ($(this).is(":checked")) {
                        circles = $(this).attr("circlesid");
                    }
                })
                window.open("/delegatexweb/infopage/searchuser.jsp?realname=" + urla + "&circles=" + circles)
//                location.href = "/delegatexweb/infopage/searchuser.jsp?realname=" + urla + "&circles="+circles;
            })
            //nav 追加
            $.each(dictdata["ssxarea"], function (k, v) {      
                if (v[1] == "0") {                  
                   // $("nav").append("<a cid='" + k + "' myid='"+v[2]+"'>" + v[0] + "</a>");
                }
            })
            
            $("nav").append("<a cid='" + "15"  + "' myid='"+ "1027" +"'>" + "小屯镇" + "</a>");
            $("nav").append("<a cid='" + "8"  + "' myid='"+ "1028" +"'>" + "临汝镇" + "</a>");

            $("nav").append("<a cid='" + "9"  + "' myid='"+ "1029" +"'>" + "寄料镇" + "</a>");
            $("nav").append("<a cid='" + "10"  + "' myid='"+ "1030" +"'>" + "温泉镇" + "</a>");
//            $("nav").append("<a cid='" + "8"  + "' myid='"+ "1028" +"'>" + "临汝镇" + "</a>");
            $("nav").append("<a cid='" + "17"  + "' myid='"+ "1031" +"'>" + "蟒川镇" + "</a>");
            $("nav").append("<a cid='" + "11"  + "' myid='"+ "1032" +"'>" + "杨楼镇" + "</a>");
            $("nav").append("<a cid='" + "13"  + "' myid='"+ "1033" +"'>" + "庙下镇" + "</a>");
            $("nav").append("<a cid='" + "12"  + "' myid='"+ "1034" +"'>" + "陵头镇" + "</a>");
            $("nav").append("<a cid='" + "14"  + "' myid='"+ "1035" +"'>" + "米庙镇" + "</a>");
            $("nav").append("<a cid='" + "16"  + "' myid='"+ "1036" +"'>" + "纸坊镇" + "</a>");
            $("nav").append("<a cid='" + "18"  + "' myid='"+ "1037" +"'>" + "大峪镇" + "</a>");
            $("nav").append("<a cid='" + "20"  + "' myid='"+ "1038" +"'>" + "夏店镇" + "</a>");
            $("nav").append("<a cid='" + "19"  + "' myid='"+ "1039" +"'>" + "焦村镇" + "</a>");
            $("nav").append("<a cid='" + "21"  + "' myid='"+ "1040" +"'>" + "骑岭乡" + "</a>");
            $("nav").append("<a cid='" + "22"  + "' myid='"+ "1041" +"'>" + "王寨乡" + "</a>");        
            $("nav").append("<a cid='" + "5"  + "' myid='"+ "1047" +"'>" + "风穴路街道" + "</a>");
            $("nav").append("<a cid='" + "2"  + "' myid='"+ "1043" +"'>" + "煤山街道" + "</a>");
            $("nav").append("<a cid='" + "3"  + "' myid='"+ "1044" +"'>" + "洗耳河街道" + "</a>");
            $("nav").append("<a cid='" + "4"  + "' myid='"+ "1045" +"'>" + "钟楼街道" + "</a>");
            $("nav").append("<a cid='" + "7"  + "' myid='"+ "1046" +"'>" + "汝南街道" + "</a>");              
            $("nav").append("<a cid='" + "6"  + "' myid='"+ "1047" +"'>" + "紫云路街道" + "</a>");
            
            //nav跳转
            $("nav>a").click(function () {
                var cid = $(this).attr("cid");
                var myid = $(this).attr("myid");
                if (cid) {
                    window.open("/delegatexweb/infopage/delegationinfo.jsp?myid=" + myid + "&stationid=" + cid);
                } else {
                    location.href = "#"
                }

//                        
//                location.href = "/delegatexweb/infopage/llzlist.jsp?pid=" + cid;
            })
        </script>
        <script src="../projectSwitching.js"></script>
        <!--<script src="../js/jQuery.min.js"></script>-->
        <script type="text/javascript">
            $(function(){
//                alert(lianluozhanSrc);
                $("#header").css("background","url(" + lianluozhanSrc + ") 130px no-repeat");
            });
        </script>
    </body>
</html>