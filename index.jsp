<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="data/staff.js" type="text/javascript"></script>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>汝州市人大代表履职服务平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="apple-touch-icon" href="touch-icon-iphone.png" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/index.css" rel="stylesheet" type="text/css" />
        <style>
            #nav>#top4,#nav>#top5,#nav>#top6,#nav>#top7{display: none;}
            /* #imgHeadPhoto{    } */
            #header>a>img{
                margin-left: 5px;
                /* margin-top: 15px; */
            }
            #header>div>em {
                right:7px;
            }
            body #header #header_right{ width: 550px}
        </style>
        <script type="text/javascript">
            if (self !== top)
            {
                top.location = self.location;
            }

        </script>
    </head>
    <body>
        <div id="header">
            <a  href="gateway.jsp">
                <%
                    String a = req.get("pagetype");
                    switch (a) {
                        case "1"://议案建议
                            out.print("<img id='topimg' src='css/topimg/top_yian.png' alt=''/>");
                            break;
                        case "2"://履职服务
                            out.print("<img id='topimg' src='css/topimg/top_lvzhi.png' alt=''/>");
                            break;
                        case "3"://监督工作
                            out.print("<img id='topimg' src='css/topimg/top_jiandu.png' alt=''/>");
                            break;
                        case "4"://信息管理系统
                            out.print("<img id='topimg' src='css/topimg/top_xinxiguanli.png' alt=''/>");
                            break;
                        case "5"://联络站
                            out.print("<img id='topimg' src='css/topimg/top_lianluozhan.png' alt=''/>");
                            break;
                        case "6"://信访工作系统
                            out.print("<img id='topimg' src='css/topimg/top_xinfanggongzuo.png' alt=''/>");
                            break;
                        case "7"://选举任免系统
                            out.print("<img id='topimg' src='css/topimg/top_xinfanggongzuo.png' alt=''/>");
                            break;
                        case "10"://网站发布
                            out.print("<img id='topimg' src='css/topimg/网站发布.png' alt=''/>");
                            break;
                        case "11"://司法系统
                            out.print("<img id='topimg' src='css/topimg/司法系统.png' alt=''/>");
                            break;
                        case "12"://选举任免系统
                            out.print("<img id='topimg' src='css/topimg/top_选举任免系统.png' alt=''/>");
                            break;
                        case "13"://立法系统
                        out.print("<img id='topimg' src='css/topimg/top_bigdata.png' alt=''/>");
                        break;
                        case "14"://人大决策库系统
                        out.print("<img id='topimg' src='css/topimg/top_strategy.png' alt=''/>");
                        break;
                       case "15"://工作交流
                        out.print("<img id='topimg' src='css/topimg/top_work.png' alt=''/>");
                        break;
                        case "16"://民族侨外
                        out.print("<img id='topimg' src='css/topimg/top_nation.png' alt=''/>");
                        break;
                        
                        case "17"://农业农村监督
                        out.print("<img id='topimg' src='css/topimg/top_agriculture.png' alt=''/>");
                        break;  
                       
                        
                         case "18"://测评系统
                            out.print("<img id='topimg' src='css/topimg/top_lvzhiceping.png' alt=''/>");
                            break;
                        case "19"://学习培训
                            out.print("<img id='topimg' src='css/topimg/学习培训.png' alt=''/>");
                            break;
                        case "20"://规范性文件备案审查
                       out.print("<img id='topimg' src='css/topimg/规范性审查.png' alt=''/>");
                        break;
                        case "21"://工作交流
                       out.print("<img id='topimg' src='css/topimg/top_work.png' alt=''/>");
                        break;
                        case "22"://城乡建设
                        out.print("<img id='topimg' src='css/topimg/top_countryside.png' alt=''/>");
                        break;  
                        case "23"://科教文卫监督 ke jiao wen wei jian du  
                        out.print("<img id='topimg' src='css/topimg/top_culture.png' alt=''/>");
                        break;   
                        case "24"://司法监督
                        out.print("<img id='topimg' src='css/topimg/top_justicial.png' alt=''/>");
                        break;
                       case "25"://重大决定系统
                        out.print("<img id='topimg' src='css/topimg/top_decision.png' alt=''/>");

                        break;
                        case "26"://经济运行监督
                        out.print("<img id='topimg' src='css/topimg/top_economy.png' alt=''/>");
                        break; 
                       case "28"://民生实票决系统
                       out.print("<img id='topimg' src='css/topimg/top_livelihood.png' alt=''/>");
                        break;
                       case "27"://智慧党建系统 dangjianxitong
                       out.print("<img id='topimg' src='css/topimg/top_party.png' alt=''/>");
                        break;
                       case "29"://矛调中心系统 
                       out.print("<img id='topimg' src='css/topimg/top_conflict.png' alt=''/>");
                        break;
                       case "30"://评议监督系统 
                       out.print("<img id='topimg' src='css/topimg/top_comment.png' alt=''/>");
                        break; 
                       case "31"://表决系统 
                       out.print("<img id='topimg' src='css/topimg/top_vote.png' alt=''/>");
                        break;     
                     case "32"://政府债务监督系统 
                       out.print("<img id='topimg' src='css/topimg/top_debt.png' alt=''/>");
                        break;   
                     case "33"://知情知政系统
                       out.print("<img id='topimg' src='css/topimg/top_knowother.png' alt=''/>");
                        break;     
                        
                      case "34"://代表选举系统 
                       out.print("<img id='topimg' src='css/topimg/top_election.png' alt=''/>");
                        break;     
                     case "35"://选民登记系统 
                       out.print("<img id='topimg' src='css/topimg/top_registry.png' alt=''/>");
                        break;            
                      case "36"://食品安全监督系统 
                       out.print("<img id='topimg' src='css/topimg/top_food.png' alt=''/>");
                        break;           
                        default:
                            out.print("<img id='topimg' src='css/topimg/top_guanwang.png' alt=''/>");
                    }
                %>
            </a>
            <!-- <img src="css/limg/topleft.png" alt=""/> -->
            <!--<a  href="gateway.html"><img src="css/limg/topleft.png" alt=""/></a>-->

            <ul id="nav" style="display:none;">
            </ul>
            <div id="header_right">
                <!--<span id="controlbtn">菜单</span>-->
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
                <span> 
                    <%-- <img width="50px" height="50px" src="<% out.print(list.get("avatar").equals("avatar.png") ? "/css/limg/mytop.png" : "/upfile/" + list.get("avatar")); %>" --%>
                    <!--<img src="../css/limg/mytop.png"/>-->

                </span>
                <!--                <em><a powerid="189" id="edituser"><img src="css/limg/user.png" /></a><a id="editindex"><img src="css/limg/editset.png" /></a>
                                    <a id="editpassword"><img src="css/limg/pwd.png" /></a><a href="loginout.jsp"><img src="css/limg/out.png" /></a></em>-->
                <em style="font-size:15px;font-family: 微软雅黑;letter-spacing:2px;">
                    <a powerid="189" id="notice"><img src="css/limg/user.png" /><b style="">通知</b>
                        <div id="new_notice">
                            <span class="point"></span>
                            <ul id="shownotice">
                                <li>0条通知</li>
                                <li>0条通知</li>  
                            </ul>
                        </div>
                    </a>
                    <a powerid="189" id="edituser"><img src="css/limg/user.png" /><b>切换</b></a>
                    <a id="editindex"><img src="css/limg/user.png" /><b> <% out.print(name);%></b></a> 
                    <a id="editpassword"><img src="css/limg/pwd.png" /><b> 修改密码</b></a>
                    <a href="loginout.jsp"><img src="css/limg/out.png" /> <b>退出</b></a>
                </em> 


            </div>
        </div>
        <div id="content">
            <div id="left" style="font-size:15px;font-family: 微软雅黑">
                <ul id="leftMenus">
                </ul>
            </div>
            <div id="right">
                <ul style="font-size:15px;font-family: 微软雅黑;letter-spacing:1px" ></ul>
                <div>
                </div>
            </div>
            <div>
            </div>
        </div>
        <div id="footer">
            汝州市智慧人大综合服务管理平台
        </div>        
        <div id="masklayer" class="masklayer"><!--遮罩层--></div>
        <%@include  file="/inc/js.html" %>
        <script src="js/menudata.js?v1.032"></script>
        <script src="js/index.min.js?v1.033"></script>
        <script>
            function quicksearch(e) {
                $("#workspace").attr("src", e)
            }
            function bindli(e) {
                $("#" + e).click();
            }
            function eqli(e) {
                $("#leftMenus>li").eq(e).find("dt").click();
            }
            function leftclick(e) {
                $("#" + e).click()
            }
            function workspacedelete(e) {
                $("#workspace")[0].contentWindow.deleteolli(e)
            }
            var historyts = [];
            var lzmessage = setInterval(function () {
                $.get("/newinformation/lzmessage.jsp", {}, function (json) {
                    var chakan = [];
                    if (json != "]" && json != "") {
                        var data = eval(json);
                        $.each(data, function (k, v) {
                            if (historyts.indexOf(v.messageid) == "-1") {
                                var aa = v.classify;
//                                if (aa == "12") {
//                                    alert("有一条新的" + dictdata["messageclass"][v.classify] + ",请重新确定拟承办单位");
//                                } else {
//                                    alert("有一条新的" + dictdata["messageclass"][v.classify] + ",请注意查看");
//                                }
                                chakan.push(v.messageid)
                                historyts.push(v.messageid);
                            }
                        })
                        var chakanstr = chakan.join(",");
                        $.get("/newinformation/lzmessage_1.jsp", {"messageid": chakanstr}, function (data) {

                        })
                    }
                })
            }, 10000);

            $("#editindex").click(function () {
                var jsp = "/delegate/editindex.jsp?relationid=";
                if (Cookie.Get("powergroupid") == "5") {//代表角色5
                    jsp = jsp;
                }
                if (Cookie.Get("powergroupid") == "18") {//承办单位角色18
                    jsp = "/company/edit.jsp?relationid=";
                }
                if (Cookie.Get("powergroupid") == "22") {//代表团角色22
                    jsp = "/delegation/edit.jsp?id=";
                }
                jsp = jsp + <%out.print(idd);%>;//added by jackie
                // alert("jsp=="+jsp);
                popuplayer.display(jsp + "&TB_iframe=true", '编辑信息', {width: 830, height: 300});
                //系统管理员16//维护人员0//选联委8//县政府办23//乡镇政府办25
            })
            $("#editpassword").click(function () {
                popuplayer.display("/password.jsp?TB_iframe=true", '修改密码', {width: 650, height: 400});
            })
            $("#edituser").click(function () {
                popuplayer.display("/user.jsp?TB_iframe=true", '切换角色', {width: 350, height: 120});
            })
            var workb = "1";
            function workpageload() {
                workb = "2";
            }
            $(function () {
//               $("#nav").css("display","none");
            });
            //zyx添加，如果没有操作权限弹出提示框
//            $(function(){
//                if($("#leftMenus").children("li").length <= 0){
////                    alert("无操作权限！");
//                    popuplayer.display("/showNoPermission.jsp", '权限提示', {width: 300, height: 100});
//                }
//            });
//zyx end
        </script>
    </body>
</html>
