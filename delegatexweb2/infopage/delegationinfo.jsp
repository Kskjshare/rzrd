<%-- 
    Document   : newjsp
    Created on : 2018-7-16, 21:21:12
    Author     : Administrator
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1054px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            #webbody{margin: 10px 23px;}
            #webbody>#left{ height: 300px;width: 500px;overflow: hidden;display: inline-block;margin-right: 20px;}
            #webbody>div{display: inline-block;width: 525px;vertical-align: top}
            #webbody>div>ul{margin: 0; background: #cef5f2;line-height: 35px;padding: 0}/*tab非高亮背景颜色#cef5f2改为#ffffff*/
            #webbody>div>ul>li{display: inline-block;list-style-type: none; width: 49.8%; text-align: center;cursor: pointer;}
            #webbody>div>ul>.sel{background: linear-gradient(#d1f7f4,#fff);border: #bdd8d4 solid thin;border-bottom: 0;color: #039f62;}
            /*#webbody>div>ul>.sel{background: linear-gradient(#ffffff,#ffffff);border: #ffffff solid thin;border-bottom: 0;color: #337cdc;font-size: 24px;}*/

            #webbody>div>ol{padding: 10px 0;margin: 0;display: none;}
            #webbody>div>.selshow{display: block;}
            #webbody>div>ol>li{background: url(../img/bluedian.png) no-repeat 7px 13px;font-size: 18px; margin: 0 10px;text-indent: 20px;cursor: pointer; overflow: hidden;text-overflow: ellipsis; white-space: nowrap;height: 32px;line-height: 32px;}
            
            #bottom{background:linear-gradient(to right, #d0ebf9, #f8fdff, #d0ebf9);margin: 10px 23px;border: #7ebeb3 solid thin;padding:0 115px;position: relative;}
            /*#description{background:url(../img/description.png);position: relative;;margin: 10px 23px;width: 96%;height: 115px;}*/
            #description{background:linear-gradient(to right, #d0ebf9, #f8fdff, #d0ebf9);margin: 10px 23px;border: #7ebeb3 solid thin;padding:0 115px;position: relative;}

            #bottom>img{position: absolute;left:25px ;top:11px;}
            #bottom>h2{font-size: 28px;color: #3c629b;font-family: 隶书;margin: 0; line-height: 48px;margin-bottom: 10px;}
            #bottom>p{font-size: 14px;text-indent: 2em;line-height: 24px;margin: 0;letter-spacing: 2px;font-weight: 500}
            /*            #bottom>a{height: 45px; line-height: 45px; font-size: 22px; font-family: 隶书; color: #C66C20;  display: inline-block;  padding-left: 50px;margin: 15px 100px 15px 0;cursor: pointer; }*/
            #bottom>a{height: 45px; line-height: 45px; font-size: 22px; font-family: 隶书; color: #C66C20;  display: inline-block;  padding-left: 50px;margin: 15px 100px 15px 0;cursor: pointer; }
          
            #descriptionTitle{
              font-size: 22px;
              color:#337cdc;
              text-align: left;
              margin-left: 20px;
              margin-top:30px;
            }
            #descriptionContent{
              font-size: 18px;
              color:#333333; 
              text-align: left;
              margin-left: 20px;
              margin-top:10px;
            }
           
            
            #textarea_demo{
                width: 100%;
                height: 260px;
                padding: 0;
                border: #7ebeb3 solid thin;
                display: flex;
                flex-wrap: wrap;
                overflow-y: scroll;
                background-color: #f3f3f3;/*联络站具体信息背景颜色*/
            }
            #textarea_demo p{
                color: #d3813b;
            }
            #textarea_demo li{
                list-style: none;
                width: 49.7%; 
                /* float: left; */
                display: inline-block;
                text-align: left;
                padding-left: 10px;
                box-sizing: border-box;
                /* border: 1px solid #000; */
            }
            #textarea_demo li text{
                padding-left: 10px;
                box-sizing: border-box;
                display: block;
                font-size: 13px;
                font-family: "宋体", "Times New Roman";
                line-height: 22px;
            }
            #mydelegate{background: url(../img/daibiaohead.png) no-repeat 0px 0px;}
            #suggest{background: url(../img/suggestimg.png) no-repeat 0px 0px;background-size: 45px;}
            #write_back{background: url(../img/write_back.png) no-repeat 0px 0px;background-size: 45px;}
            #bottom #stop_distribution{background: url(../img/stop11.png) no-repeat 0px 0px;background-size: 45px;
                                       font-size: 20px;
                                       color: #3c629b;/*"站点分布"的字体颜色*/
                                       margin: 15px 100px 0px 0;
            }
            #bottom #stop_distribution:hover{
                cursor: default;
            }
            #bottom>a>span{color:#486ba1; }
            .popuplayer,.calendarwrap{display: none;}
        </style>
    </head>
    <body>
        <div>
            <div id="header"></div>
            <div id="webbody">
                <!--<img id="left" src="../img/backgroundleft.png" alt=""/>-->
                
                <%
                boolean isLeftImg = false ;
                String imgName = "";
                RssListView list_contactstation = new RssListView(pageContext, "contactstation");
                list_contactstation.request();
                list_contactstation.select().where("street="+ list_contactstation.get("stationid")).get_first_rows();



                List<String> list_array = new ArrayList();
                while (list_contactstation.for_in_rows()) {
                    if(list_contactstation.get("myid") != null && !list_contactstation.get("myid").equals("")){
                        list_array.add(list_contactstation.get("myid"));
                    }
                }
                String myids1 = "";

                if(list_array.size() > 0){
                    myids1 = String.join(",", list_array);
                }
                RssList list_stationcontent = new RssList(pageContext, "stationcontent");
                list_stationcontent.request();
                list_stationcontent.pagesize = 8;
                list_stationcontent.select().where("stationid=" + list_contactstation.get("stationid") + " and classify=1" + " and state=2").get_page_desc("id");

                while (list_stationcontent.for_in_rows()) {   
                    if ( !list_stationcontent.get("ico").isEmpty()) {
                        imgName =  list_stationcontent.get("ico");  
                        isLeftImg = true;
                        break;
                    }
                }
                %>
                  
                <%
                if ( !isLeftImg ) {
                %> 
                  <img id="left" src="../img/backgroundleft.png" alt=""/> 
                               

               <%
                }else {
                %>  
                <img id="left" src="/upfile/<% out.print( imgName );%>" alt=""/> 
               
                <%
                }
                %>  

                
                
                
                
                
                
                <div>

                    <ul><li class="sel">工作动态</li><li>其他动态</li></ul>
<!--                    <div  style="margin-top:10px; margin-left:16px;margin-bottom:-4px;border-top:1px #E7E7E9 solid;width:80.8%;">                       
                    </div> -->
                    <ol class="selshow">
                        <%
                            
                            
                            RssListView list = new RssListView(pageContext, "contactstation");
//                            list.pagesize = 8;
                            list.request();
                            list.select().where("street="+ list.get("stationid")).get_first_rows();
                           
//                            HttpRequestHelper req = new HttpRequestHelper(pageContext).request();


                                List<String> list11 = new ArrayList();
                                while (list.for_in_rows()) {
                                    if(list.get("myid") != null && !list.get("myid").equals("")){
                                        list11.add(list.get("myid"));
                                    }
                                }
                                String myids = "";
                             
                                if(list11.size() > 0){
                                    myids = String.join(",", list11);
//                                  sql += " and myid in ( " + myids + " )";
//                                  System.out.println(myids);
                                }
                                RssList list1 = new RssList(pageContext, "stationcontent");
                                list1.request();
                                list1.pagesize = 8;
//                                list1.select().where("myid=" + list.get("myid") + " and classify=1").get_page_desc("id");
                              list1.select().where("stationid=" + list.get("stationid") + " and classify=1" + " and state=2").get_page_desc("id");
                               
                                while (list1.for_in_rows()) {   
                        %>
                        <li ind="<% out.print(list1.get("id"));%>" contacttype="<% out.print(list1.get("classify"));%>"><% out.print(list1.get("title"));%></li>
                            <%
                                };
                            %>
                    </ol>
                    <ol>
                        <%
                                                  
                            RssListView list3 = new RssListView(pageContext, "contactstation");
//                            list.pagesize = 8;
                            list3.request();
                            list3.select().where("street="+ list3.get("stationid")).get_first_rows();


//                                List<String> list3_1 = new ArrayList();
//                                while (list3.for_in_rows()) {
//                                    if(list3.get("myid") != null && !list3.get("myid").equals("")){
//                                        list3_1.add(list3.get("myid"));
//                                    }
//                                }
                              
                                RssList list4 = new RssList(pageContext, "stationcontent");
                                list4.request();
                                list4.pagesize = 8;
                              list4.select().where("stationid=" + list3.get("stationid")  + " and state=2").get_page_desc("id");
                               
                                while (list4.for_in_rows()) {   
                                if ( list4.get("classify").equals("1")){
                                    continue;
                                }
                        %>
                        
                        <li ind="<% out.print(list4.get("id"));%>" contacttype="<% out.print(list4.get("classify"));%>"><% out.print(list4.get("title"));%></li>
                        
                        <%
                        };
                        %>
                    </ol>  
                </div>
            </div>
                    
<!--            <div id="description">
              <p id ="descriptionTitle">欢迎访问云上人大代表联络站</p>
              <p id ="descriptionContent" >群众（选民）对于政府机关、部门和单位工作的建议、批评和意见，可以向人大代表反映：受理发生在本选区范围内的反应...</p>           
            </div>      -->
                    
            <div id="bottom">
                <img src="../img/bluebuild.png" alt=""/>
                <h2>欢迎访问人大代表云上联络站</h2>
                <p>群众（选民）对于政府机关、部门和单位工作的建议、批评和意见，可以向人大代表反映：受理发生在本选区范围内的反应...</p>
                <a id="mydelegate" myid="<% out.print(list.get("myid"));%>">我们的代表<span>(点击查看)</span></a>
                <a id="suggest" myid="<% out.print(list.get("myid"));%>">反映你的意见<span>(点击留言)</span></a>
                <a id="write_back" myid="<% out.print(list.get("myid"));%>">公众留言<span>(点击展开)</span></a><br>
                <a disabled="true" id="stop_distribution" myid="<% out.print(list.get("myid"));%>">站点分布</a><br>
                <ul id="textarea_demo">
                    <%
                        
                        
                        RssList list5 = new RssList(pageContext, "contactstation");
                        list5.request();
                        list5.select("id").where("myid=" + list5.get("stationid")).get_first_rows();
                        RssListView substation = new RssListView(pageContext, "contactstation_sub");
                        substation.request();
                        substation.select().where("stationid=" + list5.get("stationid")).get_page_asc("id");
                        while (substation.for_in_rows()) {
                    %>
                    <li>
                        <p><%substation.write("title");%></p>
                        <text>开放时间：<%substation.write("opentime");%></text>
                        <text>站长：<%substation.write("master");%></text>
                        <text>站长电话：<%substation.write("mastertelephone");%></text>                   
                        <text>联络员:<%substation.write("linkman");%></text>
                        <text>联系电话:<%substation.write("linkmantelephone");%></text>
                        <text>地址：<%substation.write("address");%></text>
                    </li>
                    <%}%>


                </ul>
            </div>
            <div id="footer">
                <p>汝州市人大常委会主办</p>
<!--                <p>汝州市人大常委会办公厅信息中心承办</p>
                <p>技术支持：汝州市人大常委会办公厅信息中心</p>-->
            </div>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#mydelegate").click(function () {
                var myid = $(this).attr("myid");
                location.href = "/delegatexweb/infopage/delegatelist.jsp?myid=" + myid;
            })
            $("#suggest").click(function () {
                var myid = $(this).attr("myid");
                location.href = "/delegatexweb/infopage/suggestsubmit.jsp?myid=" + myid;
            })
            $("#write_back").click(function () {
                var myid = $(this).attr("myid");
                location.href = "/delegatexweb/infopage/suggestsubmit_1.jsp?myid=" + myid;
            })
            $("#webbody>div>ul>li").click(function () {
                $(this).addClass("sel").siblings().removeClass("sel");
                $("#webbody>div>ol").eq($(this).index()).addClass("selshow").siblings("ol").removeClass("selshow");
            })
            $("ol>li").click(function () {
                var ind = $(this).attr("ind");
                var contacttype = $(this).attr("contacttype");
                location.href = "/delegatexweb/infopage/listinfopage.jsp?ind=" + ind + "&contacttype=" + contacttype;
            })

        </script>
    </body>
</html>
