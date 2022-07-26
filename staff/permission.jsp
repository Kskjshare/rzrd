<%-- 
    Document   : tianjiafenlei
    Created on : 2021-3-27, 21:05:46
    Author     : Administrator
--%>
<%@page import="java.text.SimpleDateFormat"%>
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
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "permission");
    RssListView user = new RssListView(pageContext, "user_delegation");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    entity.select().where("switch=1").for_in_rows();
    
    if (!entity.get("action").isEmpty()) {
        entity.keyvalue("switch",entity.get("switch"));
        
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(entity.get("startTime"));
        String strTime = date.getTime() + "";
        strTime = strTime.substring(0, 10);
        int time = Integer.parseInt(strTime);
        entity.keyvalue("startTime",time);
        
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
        Date d = sdf1.parse(entity.get("endTime"));
        String str = d.getTime() + "";
        str = str.substring(0, 10);
        int t = Integer.parseInt(str);
        entity.keyvalue("endTime",t);
        entity.append().submit();
        out.print("<script>alert('操作成功！');</script>");
    }
    if(entity.get("switch").equals("0")){
        entity.keyvalue("switch",entity.get("switch"));
        entity.update().where("switch=1").get_first_rows();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>添加记录</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
      <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px;font-size: 12px;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 35px;font-size:14px;font-family: 微软雅黑}
            .cellbor{width: 770px}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 20px;border: #d0d0d0 solid thin;font-size:15px}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:10px 0;background: #dce6f5}
            .uetd>p{height: 180px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .uetd>#tczxx{height: 180px;background: #FFF;margin: 0 auto;width: 740px;;padding: 3px;border: #6caddc solid thin;display: none}
            .uetd>#tczxx>table{width: 100%}
            #edui2{width: 100%;line-height: 14px}
            .popupwrap>div:first-child{width: 800px;margin: 0 auto; margin-bottom: 50px; height: auto;}
            .fileeform{position: absolute;left: -10000px;}
            .cellbor td>span{cursor: pointer;}
            #suggesttype{text-align: right;margin-top: 5px;}
            #suggesttype>select{margin: -5px 5px 0;}
            .popupwrap{overflow: auto}
            .popupwrap table td>b{cursor: pointer;}
            .popupwrap>div>h1{text-align: center; margin: 10px 0 20px 0;}
            .popupwrap table td>.lxrlist>input{width: 100px;margin: 0 10px;}
            .popupwrap table td>label{margin: 0 3px;}
            .popupwrap table td>ul>li>.red{margin-left: 5px;font-size: 10px;cursor: pointer;}
            .popupwrap table td>input[type='checkbox']{margin: 0 3px;}
            span[rid]{cursor: pointer}
            /*.popupwrap .footer>button{ font-size: 99px;}*/
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .popupwrap>.footer{top: auto;bottom: 0;right: 24px;border-top: solid 1px #e6e6e6; padding-top: 5px;position: fixed;}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .w498{width: 99%;}
            #suggesttype{
                font-size: 14px;
            }
            .w98{width: 98%;}
            .meetingtime{color: red}
            /*撑下边按钮*/
            .chengyemian{

                height: 50px;
            }
            .yanse{
                color: blue;
                font-weight: 600;
            }
            

        </style>
    </head>
    <body>

        
       <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form id="fileeform3" class="fileeform" ridform="3" enctype="multipart/form-data" method="post">
            <input type="file" id="file3" ridform="3"  name="file3" multiple>
        </form>
        <form method="post" class="popupwrap"> 
            <div>
                <h1>测评开关设置</h1>
                <table class="wp100 cellbor">
                    <tr>
                        <td style="font-weight:bold" class="dce">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;开关</td>
                        <% entity.select().where("switch=1").get_first_rows();
                        if(!entity.get("switch").isEmpty()){%>
                        <td>开启&nbsp;<input style="cursor:pointer;" id="open"  type="radio" name="switch" checked="cheched" value="1"></td>
                        <form>
                            <td>关闭&nbsp;<input style="cursor:pointer;" id="off"  type="radio"  name="switch" value="0"></td>
                        </form>
                         <tr>
                             <td style="font-weight:bold"class="dce">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时间</td>
                        <td>开始时间：<input id="start" type="text" class="w200 Wdate" name="startTime" value="<%out.print(entity.get("startTime"));%>"  rssdate="<% out.print(entity.get("startTime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                        <td>结束时间：<input id="end" type="text" class="w200 Wdate" name="endTime" value="<% out.print(entity.get("endTime")); %>"  rssdate="<% out.print(entity.get("endTime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                        </tr>
                       <% }else{%>
                        <td>开<input style="cursor:pointer;"  type="radio" name="switch" value="1"></td>
                         
                        <%}
                        if(entity.get("switch").isEmpty()){%>
                       <td>关<input style="cursor:pointer;"  type="radio" name="switch" checked="cheched" value="0"></td>
                       <tr>
                        <td style="font-weight:bold;" class="dce">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时间</td>
                        <td>开始时间：<input type="text" class="w200 Wdate" name="startTime" value="<%out.print(entity.get("startTime"));%>"  rssdate="<% out.print(entity.get("startTime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                       <td>结束时间：<input type="text" class="w200 Wdate" name="endTime" value="<% out.print(entity.get("endTime")); %>"  rssdate="<% out.print(entity.get("endTime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                        </tr>
                        <%}%>
                    </tr>
                   
                  <tr>
                        <td class="dce"><span style="font-weight: bold;color: blue" class="selectuser" style="cursor:pointer;">添加人员</span></td>
                      
                        <td colspan="5">
                            <ul id="blfyr" class="lianmingren">
                                <li>
                                    <em  style='display: inline;width: 50%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px'>姓名</em>
                                    <em style='display: inline;width: 49.5%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>操作</em>
                                </li>
                            </ul></td>
                    </tr>
                   
                </table>
             </div>     
                   
                   <div class="footer" hidden>
                   <input type="hidden"  name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                   <button  type="hidden" type="submit" style="border-radius: 12px; width: 80px; height: 20px; background-color: #808080;margin-left:86%;margin-top: 5px"><% out.print(entity.get("topic").isEmpty() ? "提交" : "修改");%></button></td>
                    </div>
                   
              
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                        $('.selectuser').click(function () {
                var t = $(this).parents("tr").find("ul");
                console.log(t);
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                     $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {                                      
             t.append("<li myid='" + v.myid + "'>\n\
                            <em  style='display: inline;width: 50%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em>\n\
                            \n\
                            <em class='blue'style='display: inline;width: 50%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;color:blue;cursor:pointer;'>删除</em></li>"
                    )                            
                        }
                    })
                    $('.blue').click(function () {
                        $(this).parent().remove();
                    })
                }
                if (Cookie.Get("powergroupid") == "22") {
                    RssWin.open("/selectwin/selectuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>", 700, 650);
                } else {
                    RssWin.open("/selectwin/selectuser.jsp?mission=<% out.print(user.get("mission"));%>", 700, 650);
                }
            });
                 $("#userrolesel>input").click(function () {
                                RssWin.onwinreceivemsg = function (dict) {
                                    var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                                    $.each(dict, function (k, v) {
                                        userrolename.push(v.myname);
                                        userroleval.push(v.myid);
                                        //userroleval.push(v.fjfile);
                                    });
                                    userrolenamesp = userrolename.join(",");
                                    userrolevalsp = userroleval.join(",");
                                    $("#userrolesel").find("input:first").val(userrolenamesp);
                                    $("#userroleid").val(userrolevalsp);
                                };
                                RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
                            });

            $("#off").click(function(){
                $("#start").val("");
                $("#end").val("");
                $(".footer").hide();
               // alert("您已关闭测评权限...");
            });
             $("#open").click(function(){
                $(".footer").show();
               // alert("您已开启测评权限...");
            });
        </script>
    </body>
</html>