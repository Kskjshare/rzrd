<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.Core.RssTable"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

  <%
 StaffList.IsLogin(request, response);
        RssList entity = new RssList(pageContext, "supervision_topic");
       // RssList entity1 = new RssList(pageContext, "zhuangtai");
        CookieHelper cookies = new CookieHelper(request, response);
        HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
        entity.request();
     if(!entity.get("action").isEmpty()){
         
           entity.keyvalue("assignedOpinion",entity.get("assignedOpinion"));
           entity.keyvalue("progress","2"); 
           entity.update().where("id=?",entity.get("id")).submit();
           PoPupHelper.adapter(out).iframereload();
           PoPupHelper.adapter(out).showSucceed();
          
        }
        entity.select().where("id=?", req.get("id")).get_first_rows();
        //entity.select().where("id=?", entity.get("id")).get_first_rows();
        //entity.select().where("id=?", cookies.Get("id")).get_first_rows();
            
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            #matter{line-height: 12px;}
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        <form method="post" class="popupwrap">           
         
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <!--td colspan="4" class="institle dce" supervisiontopicduty="<%out.print(entity.get("typeid"));%>"></td-->
                        <!-- <td style="color:white" colspan="4" class="institle dce" supervisiontopicduty="<%out.print("视察调研报告和交办意见");%>"></td> -->
                        <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="4" id="tabheader">视察调研报告和交办意见</td></tr>
                    </tr>

                    <tr>
                        <td class="dce w150 ">交办意见：<em class="red">*</em></td>
                        <!--td colspan="3"><textarea type="text" class="b95 h100" name="matter"><% entity.write("matter"); %></textarea></td-->
                        <td colspan="3"> <textarea style="height:60px;width:98%;" type="text" name="assignedOpinion"></textarea></td>

                    </tr>
                    <%
                        if (entity.get("typeid").equals("1") || entity.get("typeid").equals("6")) {
                    %>

                    <tr>
                        <td class="dce w100 ">选择主送单位<em class="red">*</em></td>
                        <td colspan="2" id="userrolesel">
                            <input class="w600" readonly="readonly" value="<% req.write("company"); %>"/>
                            <input type="hidden" name="userroleid" id="userroleid" value="<% entity.write("userroleid"); %>"/>
                        </td>
                    </tr>
<!--                    <tr>
                        <td class="dce w100 ">选择抄送单位</td>
                        <td colspan="2" id="userrolese2">
                            <input class="w200" readonly="readonly" value="<% req.write("subcompany"); %>">
                            <input type="hidden" name="subuserroleid" id="subuserroleid" value="<% entity.write("userroleid"); %>"/>
                        </td>
                    </tr>-->
                    <tr>
                        <td class="dce w100 ">限办时间：<em class="red">*</em></td>
                        <td><input type="text" class="w200 Wdate" name="deadline"  rssdate="<% out.print(entity.get("deadline")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                    </tr>
                    <%}%>
                    <td class="dce w100 ">视察调研报告：</td>
                    <td colspan="3">
                        <span  id="fjfile" style="color:blue;font-weight:bold;" ><strong><%out.print(entity.get("Reportenclosurename").isEmpty() ? "点击选择报告文件" : entity.get("Reportenclosurename")); %></strong></span>
                        <input  type="hidden" name="Reportenclosure" value="<% entity.write("Reportenclosure"); %>" >
                        <input type="hidden" name="Reportenclosurename" value="<% entity.write("Reportenclosurename"); %>" >
                    </td>
                    </tr>
                </table>
            </div>
            <div class="footer">
             <input type="hidden" name="action" value="update" />
                <button type="submit" class="sub">确定</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
                            $(".footer>button").click(function () {
                                if ($("[name='assignedOpinion']").val() == undefined || $("[name='assignedOpinion']").val() == "") {
                                    alert("请填写交办意见");
                                    //let text = "请填写交办意见";
                                    //popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                                    $("[name='matter']").focus();
                                    return false;
                                }
                                if ($("[name='userroleid']").val() == "") {
                                    alert("请选择主办单位");
                                    $("[name='userroleid']").focus();
                                    return false;
                                }
                                if ($("[name='deadline']").val() == "") {
                                    alert("请选择限办时间");
                                    $("[name='deadline']").focus();
                                    return false;
                                }
                                if ($("[name='deadline']").val() != undefined && $("[name='deadline']").val() != "") {
                                    var timestamp = new Date($("[name='deadline']").val());
                                    $("[name='deadline']").val(timestamp / 1000);
                                }
                            })

                            $("#fjfile").click(function () {
                                $("#filee").click();
                            })
                            $("#filee").change(function () {
                                var str = $(this).val(); //开始获取文件名
                                var filename = str.substring(str.lastIndexOf("\\") + 1);
                                $("#fileeform").ajaxSubmit({
                                    url: "/widget/upload.jsp?",
                                    type: "post",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                if(data.url !== null && "" !== data.url){
                                    $("#fjfile").text(filename)
                                        $("input[name='Reportenclosure']").val(data.url);
                                        $("input[name='Reportenclosurename']").val(filename);
                                        alert("上传成功");
                                        }else{
                                        $("#fjfile").text("点击选择文件")
                                        $("input[name='Reportenclosure']").val(data.url);
                                        $("input[name='Reportenclosurename']").val(filename);
                                        alert("未上传")
                                    }
                                       // let text = "上传成功";
                                       // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                                    }});
                                return false;
                            })
//                            $("#filee").change(function () {
//                                var str = $(this).val(); //开始获取文件名
//                                var filename = str.substring(str.lastIndexOf("\\") + 1);
//                                $("#fileeform").ajaxSubmit({
//                                    url: "/widget/upload.jsp?",
//                                    type: "post",
//                                    dataType: "json",
//                                    async: false,
//                                    success: function (data) {
//                                        $("#fjfile").text(filename)
//                                        $("input[name='Reportenclosure']").val(data.url);
//                                        $("input[name='Reportenclosurename']").val(filename);
//                                        alert("上传成功");
//                                    }});
//                                return false;
//                            })
//zyx 注销原有附件，解决附件消失的bug
                            $("#userrolesel>input").click(function () {
                                RssWin.onwinreceivemsg = function (dict) {
                                    var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                                    $.each(dict, function (k, v) {
                                        userrolename.push(v.myname)
                                        userroleval.push(v.myid)
                                    })
                                    userrolenamesp = userrolename.join(",");
                                    userrolevalsp = userroleval.join(",");
                                    $("#userrolesel").find("input:first").val(userrolenamesp)
                                    $("#userroleid").val(userrolevalsp)
                                }
                                RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
                            });

                            $("#userrolese2>input").click(function () {
                                RssWin.onwinreceivemsg = function (dict) {
                                    var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                                    $.each(dict, function (k, v) {
                                        userrolename.push(v.myname)
                                        userroleval.push(v.myid)
                                    })
                                    userrolenamesp = userrolename.join(",");
                                    userrolevalsp = userroleval.join(",");
                                    $("#userrolese2").find("input:first").val(userrolenamesp)
                                    $("#subuserroleid").val(userrolevalsp)
                                }
                                RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
                            });
        </script>
    </body>
</html>
