<%@page import="RssEasy.Core.CookieHelper"%>
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
<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
     
    RssList entity = new RssList(pageContext, "supervision_finance");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
   
    
    RssListView user = new RssListView(pageContext, "user_delegation");
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
    
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
               
               
               
                entity.keyvalue("initiator",cookie.Get("myid"));//方案制定者
                //entity.keyvalue("initiator", user.get("realname"));//方案制定者
                
                entity.keyvalue("state", 1);
                entity.keyvalue("typeid", 2 );
                entity.append().submit();
//                out.print("<script>alert('append')</script>");
                break;
            case "update":
                //entity.remove("relationid","objid");
                entity.remove("objid");
                //entity.keyvalue("state", 2);
                //entity.update().where("id=?", entity.get("relationid")).submit();
                entity.update().where("id=?", req.get("id")).submit();
                //out.print("<script>alert('update')</script>");
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", req.get("id")).get_first_rows();
    //entity.select().where("id=?", entity.get("relationid")).get_first_rows();
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
            .dce{background: #dce6f5;text-indent: 0px}
            .cellbor td{padding: 0 6px}
            .cellbor td>span{cursor: pointer;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            /*.popupwrap>div:first-child{height: 100%;}*/
            /*#matter{line-height: 12px;}*/
            .b95{width:95%;}
            #fileeform{position: absolute;left: -10000px;}
            #fileicoform{position: absolute;left: -10000px;}
            #selsend em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #selcommitteesend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #selcocommitteesend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #selparttimecommitteesend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #selexpertsend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            
            #selcompanysend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
             
        </style>
    </head>
    <body>
        <form id="fileeform" enctype="multipart/form-data" method="post">
            <input type="file" id="filee" accept="." name="file" multiple>
        </form>
        <form id="fileicoform" enctype="multipart/form-data" method="post">
            <!--<input type="file" id="filee" name="file" multiple>-->
            <input type="file" id="fileico" name="file2" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <!--<h1 style="margin-top:3px;margin-bottom:10px;font-size:22px;font-family: 微软雅黑;text-align: center; ">听取和审议专项工作报告</h1>-->
                <table class="wp100 cellbor">
                   <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">财经工委每年度上半年听取国民经济和社会发展计划、财政预算执行及审计工作流程</td></tr>
                   <tr>
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99.5%;" type="text" class="w98" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
                     
<!--                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">通知内容<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="notice" value="<% entity.write("notice"); %>" /><label class="labtitle"></label></td>
                    </tr>-->
                    
                  
                    
                    <tr>
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">监督类别</td>
                        <td colspan="3">
                        <div id="inspecttype">
                        <select style="font-size:15px;font-family: 微软雅黑" name="lwstate">
                            <option value="2" style="font-size:15px;font-family: 微软雅黑">财政监督</option>
                            <option value="1" style="font-size:15px;font-family: 微软雅黑">听取和审议专项工作报告</option>                                                           
                            <option value="3" style="font-size:15px;font-family: 微软雅黑">法律法规实施情况的检查</option>
                            <option value="4" style="font-size:15px;font-family: 微软雅黑">规范性文件的备案审查</option>
                            <option value="5" style="font-size:15px;font-family: 微软雅黑">专题询问</option>
                            <option value="6" style="font-size:15px;font-family: 微软雅黑">特定问题调查</option>
                            <option value="7" style="font-size:15px;font-family: 微软雅黑">撤职案的审议和决定</option>
                            <option value="8" style="font-size:15px;font-family: 微软雅黑">视察</option>
                            <option value="9" style="font-size:15px;font-family: 微软雅黑">调研</option>
                        </select>
                        </div>
                        </td>
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">方案发起单位</td>
                        <td  colspan="1" style="font-size:15px;font-family: 微软雅黑"> <% user.write("realname"); %></td>   

                    </tr>  
  
                    
                    <tr>
                        <td class="dce" style="width:140px;font-size:15px;font-family: 微软雅黑">通知文件<em class="red">*</em></td>
                        <td colspan="5">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">
                                    <%
                                    if (entity.get("enclosure") == "") {
                                    %>
                                    点击选择文件
                                    <%
                                    }else{
                                    %>
                                    <% entity.write("enclosurename"); %>
                                    <%
                                    };
                                    %>
                                </span>
                                <input type="hidden" name="enclosure" id="enclosure" value="<% entity.write("enclosure"); %>" >
                                <input type="hidden" name="enclosurename" id="enclosurename" value="<% entity.write("enclosurename"); %>" >
                            </div>
                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:15px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                <input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:15px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                <input type="hidden"id="enclosure3" ></div>
                        </td>
                    </tr>
 
                    
                    <tr>
                    <td class="dce" >通知单位<em class="red">*</em></td>
                    <td id="selcompanysend" colspan="5"><em selectcompanyuser>点击添加单位</em>                
                    </td>                 
                    </tr>    
                    
                    
                   
<!--                     <tr class="directormeeting">                     
                      <td class="dce" style="font-size:15px;font-family: 微软雅黑" >主任会议时间<em class="red">*</em>
                      </td>
                      <td colspan="3" style="font-size:15px">
                        <input type="text"  style="width:98%;" class=" Wdate" name="directorshijian"  rssdate="<% out.print(entity.get("directorshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                      </td>
 
                      <td class="dce" style="font-size:15px;font-family: 微软雅黑">主任会议届次<em class="red">*</em></td>
                      <td colspan="5"><input  style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="directormeetingnum" value="<% entity.write("directormeetingnum"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    -->
 
                    
                 
<!--            <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">专题询问成员</td></tr>
            <tr>
                <td class="dce" >常委会成员<em class="red">*</em></td>
                <td id="selcommitteesend" colspan="5"><em selectcommitteeuser>点击选择常委会成员</em>                
                </td>                 
            </tr>     
            
           <tr class="canyu" >
               <td class="dce" >人大代表<em class="red">*</em></td>
               <td id="selsend" colspan="5"><em selectuser>点击选择人大代表</em>              
               </td>             
           </tr>
                    
            
            <tr>
                <td class="dce" >兼职委员<em class="red">*</em></td>
                <td id="selparttimecommitteesend" colspan="5"><em selectparttimecommitteeuser>点击选择兼职委员</em>                
                </td>                 
            </tr>    
            
            <tr>
                <td class="dce" >专家<em class="red">*</em></td>
                <td id="selexpertsend" colspan="5"><em selectexpertuser>点击选择专家</em>                
                </td>                 
            </tr>     -->
            

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <!--<input type="hidden" name="objid" >-->
                <!--<input type="hidden"  name //="initiator" value="<% entity.write("initiator");%>">-->
<!--                <input type="hidden" id="rid" name="objid" value="">
                
                 <input type="hidden" id="committeerid" name="committeeobjid" value="">
                 <input type="hidden" id="co-committeerid" name="cocommittee" value="">
                 <input type="hidden" id="parttimememberid" name="parttimemember" value="">
                 <input type="hidden" id="expertmemberid" name="expertmember" value="">-->
                 <input type="hidden" id="company" name="company" value="">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
//         zyx 增加显示隐藏   
//            $(".directormeeting").hide();
//            $(".co-committee-member").hide();  
            //默认的时候隐藏
             $('input[name="initiator"]').click(function () {
                    if ($(this).val() == 3){
                    $(".directormeeting").show();
                    $(".co-committee-member").show();
                    
                    $(".committeemetting").hide();
                    
                } else{
                    $(".directormeeting").hide();
                    $(".co-committee-member").hide();   
                    
                     $(".committeemetting").show();  
                    
                }
            });
            
//        zyx  end    
            
            $(".footer>button").click(function () {
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                }
               
                
                if ($("[name='enclosure']").val() == undefined || $("[name='enclosure']").val() == "") {
                    alert("请添加文件");
                    $("[name='enclosure']").focus();
                    return false;
                }

//                var val=$('input:radio[name="initiator"]:checked').val();
//                if(val == 3){
//                    if ($("[name='directorshijian']").val() != undefined && $("[name='directorshijian']").val() != "") {
//                        var timestamp = new Date($("[name='directorshijian']").val());
//                        $("[name='directorshijian']").val(timestamp / 1000);
//                    }
//                    else {
//                        alert("请添加主任会议时间");
//                        $("[name='directorshijian']").focus();
//                        return false;
//                    }
//                    
//                    //常委会联名成员
//                    if ($("#selcocommitteesend em").length == 1) {
//                        alert("请添加常委会联名成员");
//                        return false;
//                    }
//                     //添加常委会联名成员id到co-committee
//                    var arry1 = [];
//                    $("#selcocommitteesend>em[committeemyid]").each(function () {
//                        arry1.push($(this).attr("committeemyid"))        
//                    })
//                    var str1 = arry1.join(",");
//                    $("#co-committeerid").val( str1 );
// 
//                    
//                    
//               }
//               

                
 
//                
//                if ($("[name='directorshijian']").val() != undefined && $("[name='directorshijian']").val() != "") {
//                    var timestamp = new Date($("[name='directorshijian']").val());
//                    $("[name='directorshijian']").val(timestamp / 1000);
//                }
//                else {
//                    alert("请添加主任会议时间");
//                    $("[name='directorshijian']").focus();
//                    return false;
//                } 
                
                //添加人大代表id到objid
                var arry = [];
                $("#selsend>em[myid]").each(function () {
                    arry.push($(this).attr("myid"))        
                })
                var str = arry.join(",");
                $("#rid").val(str);
                
                 //添加常委委员id到committeeobjid
                var arry1 = [];
                $("#selcommitteesend>em[committeemyid]").each(function () {
                    arry1.push($(this).attr("committeemyid"))        
                })
                var str1 = arry1.join(",");
                $("#committeerid").val( str1 );
                
                //兼职委员
                var arry2 = [];
                $("#selparttimecommitteesend>em[committeemyid]").each(function () {
                    arry2.push($(this).attr("committeemyid"))        
                })
                var str2 = arry2.join(",");
                $("#parttimememberid").val( str2 );
                
                
                //专家
                var arry3 = [];
                $("#selexpertsend>em[committeemyid]").each(function () {
                    arry3.push($(this).attr("committeemyid"))        
                })
                var str3 = arry3.join(",");
                $("#expertmemberid").val( str3 );
                
                
                 //添加单位
                var arrycompany = [];              
                $("#selcompanysend>em[companyid]").each(function () {
                    arrycompany.push($(this).attr("companyid"))        
                })
                var strcompany = arrycompany.join(",");
                $("#company").val( strcompany );
                
                
 
              

            })                           
   
            $("#inspecttype select").change(function () {//选择了类别//added by jackie
            var v_type = '';

           if ($("#inspecttype select").val() == 1) {// 听取和审议专项工作报告
                v_type = 'specialReport/editSpecialreport';
            }
            else if ($("#inspecttype select").val() == 2){ //财政监督...
                v_type = 'topic/editEnforcemenT';
            }
            else if ($("#inspecttype select").val() == 3){ //法律法规实施情况的检查
               v_type = 'zhifajiancha/edit';
           }
           else if ($("#inspecttype select").val() == 4){ //规范性文件的备案审查
               v_type = 'topic/editInquerY';
           }
           else if ($("#inspecttype select").val() == 5){ //专题询问
               v_type = 'specialinquery/edit';
           }
            else if ($("#inspecttype select").val() == 6 ){ //特定问题调查
               v_type = 'specialproblem/edit';
           }
           else if ($("#inspecttype select").val() == 7 ){ //撤职案的审议和决定
               v_type = 'disimissal/editDismissal';
           }
           else if ($("#inspecttype select").val() == 8 ){ //视察
               v_type = 'inspection/edit';
           }
           else if ($("#inspecttype select").val() == 9 ){ //调研
               v_type = 'investigation/edit';
           }
                
             
                
                // alert(v_type);
                self.location = "/supervision/" + v_type + ".jsp";
                return false;
            })
          
        $("#fjfile").click(function () {
            $("#filee").click();
        })
        $("#icofile").click(function () {
            $("#fileico").click();
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
                    $("input[name='enclosure']").val(data.url);
                    $("input[name='enclosurename']").val(filename);
                    //alert("上传成功");
                    }else{
                    $("#fjfile").text("点击选择文件")
                    $("input[name='enclosure']").val(data.url);
                    $("input[name='enclosurename']").val(filename);
                    alert("未上传")
                }
                   // let text = "上传成功";
                   // popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                }});
            return false;
        })
        $("#fileico").change(function () {
            $("#fileicoform").ajaxSubmit({
                url: "/widget/upload.jsp?",
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#icofile").text(data.url)
                    $("input[name='ico']").val(data.url);
                    alert("上传成功");
                }});
            return false;
        })


        $('[selectuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[myid='" + v.myid + "']").length == "0") {
                        t.append("<em myid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")

//                                            t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")

                    }
                })
                $("#selsend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
            var coo =<%=cookie.Get("powergroupid")%>;
            if (coo == "22") {
                RssWin.open("/activities/selectuser_2.jsp?mission=<%=cookie.Get("myid")%>", 500, 600);
            } else {
                RssWin.open("/activities/selectuser_2.jsp?mission=<%=user.get("mission")%>", 500, 600);
            }
        });
                 
        $("#selsend i").off("click").click(function () {
            $(this).parent().remove();
        })
        
        
        
        
        $('[selectcommitteeuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[committeemyid='" + v.myid + "']").length == "0") {
                        t.append("<em committeemyid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                    }
                })
                $("#selcommitteesend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/selctcommitteemember.jsp", 500, 600);
        });

        //常委会联名成员
        $('[selectcocommitteeuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[committeemyid='" + v.myid + "']").length == "0") {
                        t.append("<em committeemyid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                    }
                })
                $("#selcocommitteesend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/selctcommitteemember.jsp", 500, 600);
        });
        
        //兼职委员
          $('[selectparttimecommitteeuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[committeemyid='" + v.myid + "']").length == "0") {
                        t.append("<em committeemyid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                    }
                })
                $("#selparttimecommitteesend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/selectuserroles.jsp", 500, 600);
        });
        
        //专家
         $('[selectexpertuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[committeemyid='" + v.myid + "']").length == "0") {
                        t.append("<em committeemyid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                    }
                })
                $("#selexpertsend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/selectexpert.jsp", 620, 480);
        });
        
        
         //单位
          $('[selectcompanyuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[companyid='" + v.myid + "']").length == "0") {
                        t.append("<em companyid='" + v.myid + "'>" + v.myname + "<i>×</i></em>")
                    }
                })
                $("#selcompanysend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
        });

        </script>
    </body>
</html>
