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
            
            <img class="proPage" src="./css/zimg/上一页_03.png" alt="" >
             <img class="nextPage" src="./css/zimg/下一页_05.png" alt="">
            <div class="HomeContain">
                
               <div class="Contain_Msk">
                <table id="mainTable">
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
                            <a href="index.jsp?pagetype=11#uid:top16,sid:top16menutop1notice1"><img src="/css/zimg/司法监督系统_15.png" alt=""></a>
                        </td>
                        <td>
                            <a href="index.jsp?pagetype=18#uid:top18"><img src="/css/zimg/人大代表履职-测评系统.png" alt=""></a> 
                        </td>
<!--                        <td>
                            <a href="index.jsp?pagetype=11#uid:top16,sid:top16menutop1notice"><img src="/css/zimg/司法监督系统_15.png" alt=""></a>
                        </td>-->
                        <!--http://47.104.140.240:7001/defaultroot/login.jsp-->
<!--                        <td>
                            <a href="user_md5.jsp" target="_blank"><img src="/css/zimg/机关办公-OA系统_18.png" alt=""></a>
                        </td>-->
                    </tr>
                    <tr>
                        <td>
                            <a href="user_md5.jsp" target="_blank"><img src="/css/zimg/机关办公-OA系统_18.png" alt=""></a>
                        </td>
<!--                        <td>
                            <a href="index.jsp?pagetype=6#uid:top14,sid:top14menutop1notice4" ><img src="/css/zimg/信访工作系统_24.png" alt=""></a>
                        </td>-->
                        <td colspan="2">
                            <a href="index.jsp?pagetype=5#uid:top6,sid:top6menutop1notice2"><img src="/css/zimg/人大代表网上联络站_31.png" alt=""></a>
                        </td>
                        <td>
                            <a href="index.jsp?pagetype=4#uid:my,sid:mywelcomerepresentative"><img class="message" src="/css/zimg/信息管理系统.png" alt=""></a>
                        </td>
                        <td colspan="2">
<!--                            <a href="index.jsp?pagetype=10#uid:top13,sid:top13menutop1notice1"><img class="message_10" src="/css/zimg/信息发布管理.png" alt=""></a>-->
                            <a href="index.jsp#uid:top13,sid:top13menutop1notice1"><img class="message_10" src="/css/zimg/信息发布管理.png" alt=""></a>
                         
                        </td>
                    </tr>
                   </table>
                   
                   <table id="mainTable">
                    <tr>
                        <td colspan="2">
                            <a href="user_md5tohuiwupc.jsp"><img src="/css/zimg/智慧会务管理_28.png" alt=""></a>
                                                        <!--<a  href="visualdata/twopage.html"><img src="/css/zimg/大数据系统.png" alt=""></a>-->

                        </td>                        
                        <td>
                            <a href="index.jsp?pagetype=15#uid:top5,sid:top5menutop1notice">                              
                                <img src="/css/zimg/交流互动.png" alt="">
                            </a>
                        </td>                        
                        <td colspan="3" rowspan="2">
                            <a><img class="slider_img" src="/css/zimg/图片_03.png" alt=""></a>
                        </td> 
                    </tr>
                    <tr>
                        
                        
                        <td>
                            <!--<a  href="visualdata/twopage.html"><img src="/css/zimg/大数据系统.png" alt=""></a>-->
                             <a href="index.jsp?pagetype=13#uid:top42,sid:top42menutop1monitor">                                
                                <img src="/css/zimg/大数据系统.png" alt="">
                            </a>
                        </td>
                        
                        
                         <td>
                            <!--<a href="javaScript:void;"><img src="/css/zimg/表决系统.png" alt=""></a>-->
                            <a href="index.jsp?pagetype=14#uid:top19,sid:menutop1monitor"><img src="/css/zimg/人大决策库.png" alt=""></a>                             
                        </td>
                        <td>
                            <!--<a href="index.jsp?pagetype=4#uid:my,sid:mywelcomerepresentative"><img class="message" src="/css/zimg/信息管理系统.png" alt=""></a>-->
                             <a href="index.jsp?pagetype=20#uid:top12,sid:top12menutop1notice" target="_blank"><img src="/css/zimg/规范性审查.png" alt=""></a>
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <a href="index.jsp?pagetype=6#uid:top14,sid:top14menutop1monitor" ><img src="/css/zimg/信访工作系统_24.png" alt=""></a>
                        </td>
                        <td colspan="2">
                             <a href="user_md5toereader.jsp"><img src="/css/zimg/电子会议阅文系统.png" alt=""></a>
                        </td>
<!--                        <td>
                            <a href="index.jsp?pagetype=4#uid:my,sid:mywelcomerepresentative"><img class="message" src="/css/zimg/信息管理系统.png" alt=""></a>
                            <a href="index.jsp?pagetype=10#uid:top13,sid:top13menutop1notice1"><img class="message" src="/css/zimg/规范性审查.png" alt=""></a>
                        </td>-->
                         <td>
                            <a href="index.jsp?pagetype=19#uid:top4,sid:menutop1monitor" ><img src="/css/zimg/学习培训.png" alt=""></a>
                        </td>
                        <td colspan="2">
                            <!--<a href="index.jsp#uid:top13,sid:top13menutop1notice"><img class="message_10" src="/css/zimg/智慧会务管理_28.png" alt=""></a>-->
                            <a href="index.jsp?pagetype=12#uid:top17,sid:top17menutop1notice">
                            <!--<a href="index.jsp?pagetype=12#uid:top15,sid:top15menutop">-->
    
                                <img class="message_10" src="/css/zimg/选举任免.png" alt=""></a>
                        </td>
                    </tr>
                   </table>
                   
                   
                   
           
                   
                   
                   
                   
                   
               
                   <table id="mainTable">
                    <tr>
                        <td colspan="2">
                            <!--<a href="user_md5tohuiwupc.jsp"><img src="/css/zimg/智慧会务管理_28.png" alt=""></a>-->
                            <a href="index.jsp?pagetype=16#uid:top30,sid:top30menutop1notice">
                                <img src="/css/zimg/民族侨外监督.png" alt=""></a>  
                        </td>                        
                        <td>
                            <a href="index.jsp?pagetype=13#uid:top15,sid:top15menutop0notice">                                
                                <img src="/css/zimg/立法系统.png" alt="">
                            </a>
                        </td>                        
                        <td colspan="3" rowspan="2">
                            <a><img class="slider_img" src="/css/zimg/图片_03.png" alt=""></a>
                        </td> 
                    </tr>
                    <tr>
                        <td>
                             <a href="index.jsp?pagetype=26#uid:top27,sid:top27menutop1notice">
                                <img src="/css/zimg/经济运行监督.png" alt="">
                            </a>

                        </td>
                         <td>                       
                            <a href="index.jsp?pagetype=17#uid:top31,sid:top31menutop1notice"><img src="/css/zimg/农业农村监督.png" alt=""></a>                             
                        </td>
                        <td>                     
                             <a href="index.jsp?pagetype=22#uid:top32,sid:top32menutop1notice"><img src="/css/zimg/城乡建设监督.png" alt=""></a>
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <a href="index.jsp?pagetype=23#uid:top29,sid:top29menutop1monitor" ><img src="/css/zimg/科教文卫监督.png" alt=""></a>
                        </td>
                        <td colspan="2">
                            <!--<a href="user_md5toereader.jsp"><img src="/css/zimg/电子会议阅文系统.png" alt=""></a>-->
                            <a href="index.jsp?pagetype=24#uid:top20,sid:top20menutop0monitor"><img src="/css/zimg/司法监督.png" alt=""></a>

                        </td>
                         <td>
                            <!--<a href="index.jsp?pagetype=25#uid:top4,sid:menutop1monitor" ><img src="/css/zimg/学习培训.png" alt=""></a>-->
                            <a href="index.jsp?pagetype=25#uid:top21,sid:top21menutop1monitor" ><img src="/css/zimg/重大决定系统.png" alt=""></a>

                        </td>
                        <td colspan="2">                        
                            <a href="index.jsp?pagetype=28#uid:top28,sid:top28menutop1notice">     
                            <img class="message_10" src="/css/zimg/民生实事票决系统.png" alt=""></a>
                        </td>
                        
     
                        
                    </tr>
                   </table>      
         
                   
                   
                   
                   <!-- 第四页-->
                   <table id="mainTable">
                    <tr>
                        <td colspan="2">
                            <!--<a href="user_md5tohuiwupc.jsp"><img src="/css/zimg/智慧会务管理_28.png" alt=""></a>-->
                            <a href="index.jsp?pagetype=35#uid:top33,sid:top33menutop1notice">
                                <img src="/css/zimg/选民登记系统.png" alt=""></a>  
                        </td>                        
                        <td>
                            <a href="index.jsp?pagetype=34#uid:top34,sid:top34menutop1notice">                                
                                <img src="/css/zimg/代表选举系统.png" alt="">
                            </a>
                        </td>                        
                        <td colspan="3" rowspan="2">
                            <a><img class="slider_img" src="/css/zimg/图片_03.png" alt=""></a>
                        </td> 
                    </tr>
                    <tr>
                        <td>
                            <!--<a  href="visualdata/twopage.html"><img src="/css/zimg/经济运行监督.png" alt=""></a>-->
                             <a href="index.jsp?pagetype=29#uid:top35,sid:top35menutop1notice">
                                <img src="/css/zimg/矛调中心系统.png" alt="">
                            </a>

                        </td>
                         <td>                       
                            <!--<a href="index.jsp?pagetype=27#uid:top36,sid:top36menutop1notice"><img src="/css/zimg/智慧党建.png" alt=""></a>-->    
                              <a href="partybuilding.jsp"><img src="/css/zimg/智慧党建.png" alt=""></a>
                        </td>
                        <td>                     
                             <a href="index.jsp?pagetype=30#uid:top37,sid:top37menutop1notice"><img src="/css/zimg/评议监督系统.png" alt=""></a>
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <a href="index.jsp?pagetype=31#uid:top38,sid:top38menutop1notice" ><img src="/css/zimg/表决系统.png" alt=""></a>
                        </td>
                        <td colspan="2">
                            <a href="index.jsp?pagetype=32#uid:top39,sid:top39menutop1notice">
                                
                                <img src="/css/zimg/政府债务监督系统.png" alt="">
                            </a>

                        </td>
                         <td>
                            <a href="index.jsp?pagetype=33#uid:top40,sid:top40menutop1notice" ><img src="/css/zimg/知情知政.png" alt=""></a>

                        </td>
                        <td colspan="2">                        
                            <a href="index.jsp?pagetype=36#uid:top41,sid:top41menutop1notice">     
                            <img class="message_10" src="/css/zimg/食品安全监督系统.png" alt=""></a>
                        </td>
                             
                    </tr>
                   </table>      
                   
                </div>
            </div>
        </div>
        <div class="footer" style="text-align: center">汝州市智慧人大综合服务管理平台</div>
        <!-- <script type="text/javascript" src="js/gateway.js"></script> -->
        <script src="./js/jquery.min.js"></script>
        <script>
            var index = 1;
   
              
            $(".proPage").click(function() {

                if ( index == 3 ) {
                    $(".Contain_Msk").css({
                    "transform": "translateX(-100vw)",
                    "transition-duration": "700ms"
                    }) 
                    index -- ;
                }
                else if ( index == 2 ) {
                     $(".Contain_Msk").css({
                    "transform": "translateX(0vw)",
                    "transition-duration": "700ms"
                    }) 
                    index -- ;
                }
                 else if ( index == 4 ) {
                     $(".Contain_Msk").css({
                    "transform": "translateX(-200vw)",
                    "transition-duration": "700ms"
                    }) 
                    index -- ;
                }
//                $(".Contain_Msk").css({
//                "transform": "translateX(0vw)",
//                "transition-duration": "700ms"
//                })
//                if(index%3==0){
//                    $(".nextPage").css({"display":"block"})
//                }

                //index--;
            })
            $(".nextPage").click(function() {
                // $(".Contain_Msk").fadeOut(700);
                // $(".Contain_Msk").fadeIn(700);
                if ( index == 1 ) {
                    $(".Contain_Msk").css({
                    "transform": "translateX(-100vw)",
                    "transition-duration": "700ms"
                    })
                    index ++ ;
                }
                else  if ( index == 2 ){
                    $(".Contain_Msk").css({
                    "transform": "translateX(-200vw)",
                    "transition-duration": "700ms"
                    })
                    index ++ ; 
                }
                 else  if ( index == 3 ){
                    $(".Contain_Msk").css({
                    "transform": "translateX(-300vw)",
                    "transition-duration": "700ms"
                    })
                    index ++ ; 
                }
                if(index%3==1){
//                    $(".proPage").css({"display":"block"})

                }
               // index++;
            })

        </script>
    </body>
</html>