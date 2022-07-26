<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="data/staff.js" type="text/javascript"></script>
<%
    StaffList.IsLogin(request, response);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>乌兰浩特市人大代表履职服务平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="apple-touch-icon" href="touch-icon-iphone.png" />
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/index.css" rel="stylesheet" type="text/css" />
        <style>
            #nav>#top4,#nav>#top5,#nav>#top6,#nav>#top7{display: none;}
            #imgHeadPhoto{    }
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
            <img src="css/limg/topleft.png" alt=""/>
            <ul id="nav">
            </ul>
            <div>
                <!--<span id="controlbtn">菜单</span>-->
                <%
                    CookieHelper cookie = new CookieHelper(request, response);
                    RssList list = new RssList(pageContext, "user");
                    list.select().where("myid=?", UserList.MyID(request)).get_first_rows();
                    String name = null;
                    String idd = null;
                  //  String pwgroupid =cookie.Get("powergroupid");
                  //  out.print("pwgroupidfromcookie="+cookie.Get("powergroupid")+":account::"+list.get("account"));//李小东调试加的//powergroupid为角色，5为代办，18为
                    if (cookie.Get("powergroupid").equals("18")) {
                        name = list.get("account");
                    } else if (cookie.Get("powergroupid").equals("22")) {
                        name = list.get("allname");
                    } else {
                        name = UserList.RealName(request);
                        
                        if(name.equals("匿名")){
                            name=list.get("account");
                        }
                       // String str_name = list.get("account");
                        //out.print("：name="+name+":str_name="+str_name);//李小东调试加的
                    }
                    
                    idd = UserList.MyID(request);
                %>
                <span> 
                    <img width="50px" height="50px" src="<% out.print(list.get("avatar").equals("avatar.png") ? "/css/limg/mytop.png" : "/upfile/" + list.get("avatar")); %>">
                    <!--<img src="../css/limg/mytop.png"/>-->

                    你好，<% out.print(name);%></span>
                <em><a powerid="189" id="edituser"><img src="css/limg/user.png" /></a><a id="editindex"><img src="css/limg/editset.png" /></a><a id="editpassword"><img src="css/limg/pwd.png" /></a><a href="loginout.jsp"><img src="css/limg/out.png" /></a></em>
            </div>
        </div>
        <div id="content">
            <div id="left">
                <ul id="leftMenus">
                </ul>
            </div>
            <div id="right">
                <ul></ul>
                <div>
                </div>
            </div>
            <div>
            </div>
        </div>
        <div id="footer">
            乌兰浩特市人大代表履职服务平台
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
                jsp=jsp + <%out.print(idd);%>;//added by jackie
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



        </script>
    </body>
</html>
