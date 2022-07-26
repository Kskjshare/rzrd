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
    RssList entity = new RssList(pageContext, "supervision_inspection"); // supervision_topic
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssListView user = new RssListView(pageContext, "user_delegation");
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    user.request();
    user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
    
    
    RssList entity2 = new RssList(pageContext, "supervision_inspection"); // supervision_topic
    entity2.request();
    
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "update":
                //out.print("<script>alert('update')</script>");
                entity.keyvalue("state",3 );
//                entity.keyvalue("committeeobjid",entity2.get("committeeobjid"));
//                entity.keyvalue("parttimemember",entity2.get("parttimemember"));
//                entity.keyvalue("expertmemberid",entity2.get("expertmemberid"));
//                entity.keyvalue("company",entity2.get("company"));
                
                entity.update().where("id=?", req.get("id")).submit();
                
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
            #parttimecommitteesend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #expert em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #selcompanysend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            
            #selpreviewsend em{background:rgb(0, 128, 225);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
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
                <!--<h1 style="margin-top:3px;margin-bottom:10px;font-size:22px;font-family: 微软雅黑;text-align: center; ">视察</h1>-->
                <table class="wp100 cellbor">
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">视察</td></tr>              
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">视察方案<em class="red">*</em></td>
                        <td colspan="4">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">
                                    <%
                                    if (entity.get("enclosure") == "") {
                                    %>
                                    点击选择方案文件
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
                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择方案文件</span>
                                <input type="hidden"id="enclosure3" ></div>
                        </td>                   
                    </tr>
                    
   
   
                   
                    <tr>                     
                      <td class="dce w100" style="font-size:16px;font-family: 微软雅黑" >主任会议时间<em class="red">*</em>
                      </td>
                      
                      <td colspan="2" style="font-size:16px">
                        <input type="text" class="w200 Wdate" name="meetingshijian"  rssdate="<% out.print(entity.get("meetingshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                      </td>
                      
                    
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">主任会议届次<em class="red">*</em></td>
                      <td colspan="2"><input style="font-size:16px;font-family: 微软雅黑;width:200px;" type="text" maxlength="100" class="w98" name="directormeetingnum" value="<% entity.write("directormeetingnum"); %>" /><label class="labtitle"></label></td>

                    </tr>
                  
          
                  
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">视察组成员</td></tr>
                    <tr class="inspectmember" >
                        <td class="dce" style="width:110px;">常委会成员</td>
                        <td id="selcommitteesend" colspan="5"><em selectcommitteeuser>点击选择常委会成员</em>                
                        </td>
                           <%
                               RssListView committeeUsers = new RssListView(pageContext, "user_delegation");
                               committeeUsers.request();
                               if (entity.get("id").isEmpty()) {
                                committeeUsers.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                               } else {
                                committeeUsers.select().where("myid=" + entity.get("myid")).get_first_rows();
                               }
                           %>
                    </tr>
                    
                    
                    <tr class="canyu" >
                        <td class="dce" style="width:110px;">人大代表</td>
                        <td id="selsend" colspan="5"><em selectuser>点击选择人大代表</em>
                        <!--<td class="dce" id="selsend"><b class="selectuser" style="color:blue;font-size:16px;font-family: 微软雅黑;cursor:pointer;">添加参与人<em class="red">*</em></b></td>-->  
                        </td>
                           <% RssListView user1 = new RssListView(pageContext, "user_delegation");
                            user1.request();
                            if (entity.get("id").isEmpty()) {
                                user1.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                            } else {
                                user1.select().where("myid=" + entity.get("myid")).get_first_rows();
                            }
                        %>
                    </tr>
                    
                   
              
                    

                     <tr class="inspectmember" >
                        <td class="dce" style="width:110px;">其他人员</td>
                        <td id="parttimecommitteesend" colspan="5"><em parttimecommitteeuser>点击选择其他人员</em>                
                        </td>                       
                    </tr>
                
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">参加单位</td></tr>
                    <tr>
                    <td class="dce" >单位名称<em class="red">*</em></td>
                    <td id="selcompanysend" colspan="5"><em selectcompanyuser>点击添加单位</em>    
                    
                    </td>                 
                    </tr>    
                    

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print("提交");%></button>
                <!--<input type="hidden" name="objid" >-->
                <input type="hidden" id="rid" name="objid" value="">
                <input type="hidden" id="committeerid" name="committeeobjid" value="<% entity2.write("committeeobjid"); %>">
                <input type="hidden" id="parttimecommitid" name="parttimemember" value="<% entity2.write("parttimemember"); %>">
                <input type="hidden" id="expertmemberid" name="expertmemberid" value="<% entity2.write("expertmemberid"); %>">
                <!--<input type="hidden" id="company" name="company" value="<% entity2.write("company"); %>">-->
                
                <!--<input type="hidden" id="previewleadername" name="previewleadername" value="<% entity2.write("previewleadername"); %>">-->
                
                <input type="hidden" id="committeeName" name="committeeName" value="<% entity.write("committeeName"); %>">
                <input type="hidden" id="objName" name="objName" value="<% entity.write("objName"); %>">
                <input type="hidden" id="parttimememberName" name="parttimememberName" value="<% entity.write("parttimememberName"); %>">
                <input type="hidden" id="companyName" name="companyName" value="<% entity.write("companyName"); %>">

                
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
  
            
            $(".footer>button").click(function () {
               
                
                if ($("[name='enclosure']").val() == undefined || $("[name='enclosure']").val() == "") {
                    alert("请添加方案文件");
                    $("[name='enclosure']").focus();
                    return false;
                }
               
                
                
                
//            if ($("#selcommitteesend em").length == 1) {
//                alert("请选择常委会成员");
//                return false;
//            }
//            if ($("#selsend em").length == 1) {
//                alert("请选择人大代表");
//                return false;
//            }
                if ($("[name='meetingshijian']").val() == undefined || $("[name='meetingshijian']").val() == "") {
                    alert("请填写主任会议时间");
                    $("[name='meetingshijian']").focus();
                    
                    //
                    $("[name='inspecttime']").val("");
                    return false;
                }

             if ($("[name='directormeetingnum']").val() == undefined || $("[name='directormeetingnum']").val() == "") {
                    alert("请填写主任会议届次");
                    $("[name='directormeetingnum']").focus();
                    return false;
            }
    
                if ($("#selcompanysend em").length == 1) {
                    alert("请添加视察单位");
                    $("[name='companyid']").focus();
                    return false;
                }  
                
                if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
                    var timestamp = new Date($("[name='meetingshijian']").val());
                    $("[name='meetingshijian']").val(timestamp / 1000);
                }

               
                
              


            //添加人大代表id到objid
            var arry = [];
            var arry_name = [];

            
            $("#selsend>em[myid]").each(function () {
                arry.push($(this).attr("myid"))
                arry_name.push($(this).attr("realname"))        
                
            })
            var str = arry.join(",");
            var str_name = arry_name.join(",");
            
            $("#rid").val(str);
             $("#objName").val(str_name);
           
            // alert(str);
          
            
            //添加常委委员id到committeeobjid
            var arry1 = [];
            var arry1_name = [];                       

            $("#selcommitteesend>em[committeemyid]").each(function () {
                arry1.push($(this).attr("committeemyid"))  
                arry1_name.push($(this).attr("realname"))  

            })
            var str1 = arry1.join(",");
            var str1_name = arry1_name.join(",");
            
            $("#committeerid").val( str1 );
            $("#committeeName").val( str1_name );
     
     
       
            
             //添加兼职委员到id是parttimecommitid
            var arry2 = [];
            var arry2_name = [];                       
            
            $("#parttimecommitteesend>em[parttimecommitteeid]").each(function () {
                arry2.push($(this).attr("parttimecommitteeid"))  
                arry2_name.push($(this).attr("realname"))  
                
            })
            var str2 = arry2.join(",");
            var str2_name = arry2_name.join(",");
            
            $("#parttimecommitid").val( str2 );
            $("#parttimememberName").val( str2_name );
        
            //添加专家到id是expertmemberid
             var arry3 = [];
             //var arry3_name = [];                       
             
            $("#expert>em[experttid]").each(function () {
                arry3.push($(this).attr("experttid"))      
                //arry3_name.push($(this).attr("realname"))  
                
            })
            var str3 = arry3.join(",");
            //var str3_name = arry3_name.join(",");
            
            $("#expertmemberid").val( str3 );
            //$("#expertmemberid").val( str3 );
                       
            
            //添加单位
            var arrycompany = [];  
            var arrycompany_name = [];                       
            
            $("#selcompanysend>em[companyid]").each(function () {
                arrycompany.push($(this).attr("companyid"))    
                arrycompany_name.push($(this).attr("realname"))        
                
            })
            var strcompany = arrycompany.join(",");
            var strcompany_name = arrycompany_name.join(",");
            
            $("#company").val( strcompany );
            $("#companyName").val( strcompany_name );
               
            
            
            
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
                        //alert("上传成功");
                    }});
                return false;
            })


        $('[selectuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                if ($("em[myid='" + v.myid + "']").length == "0") {
//                    t.append("<em myid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                    t.append("<em myid='" + v.myid + "' + realname='" + v.realname + "'>" + v.realname + "<i>×</i></em>")

//                  t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
                    }
                })
                $("#selsend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
            RssWin.open("/activities/selectuser_2.jsp?mission=<%=user1.get("mission")%>", 600, 650);
           
        });

        
        $("#userrolesel>textarea ").click(function () {
            RssWin.onwinreceivemsg = function (dict) {
                var userrolename = [], userrolenamesp = "", userroleval = [], userrolevalsp = "";
                $.each(dict, function (k, v) {
                    userrolename.push(v.myname)
                    userroleval.push(v.myid)
                   // userroleval.push(v.fjfile)
                })
                userrolenamesp = userrolename.join(",");
                userrolevalsp = userroleval.join(",");
                $("#userrolesel").find("textarea ").val(userrolenamesp)
                $("#userroleid").val(userrolevalsp)
            }
            RssWin.open("/supervision/topic/duty/selectuserrole.jsp", 700, 650);
    });
    
    
     $('[selectcommitteeuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[committeemyid='" + v.myid + "']").length == "0") {
//                        t.append("<em committeemyid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                        t.append("<em committeemyid='" + v.myid + "' + realname='" + v.realname + "'>" + v.realname + "<i>×</i></em>")
                                             
                    }
                })
                $("#selcommitteesend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/selctcommitteemember.jsp", 600, 650);
        });
        
          //兼职委员
        $('[parttimecommitteeuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
            $.each(dict, function (k, v) {
                if ($("em[parttimecommitteeid='" + v.myid + "']").length == "0") {
//                     t.append("<em parttimecommitteeid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                     t.append("<em parttimecommitteeid='" + v.myid + "' + realname='" + v.realname + "'>" + v.realname + "<i>×</i></em>")
                     
                }
                })
                $("#parttimecommitteesend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
           
            RssWin.open("/supervision/selectuserroles.jsp", 600, 650);
          
        });
        
         //专家
        $('[expertid]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
            $.each(dict, function (k, v) {
                if ($("em[experttid='" + v.myid + "']").length == "0") {
//                     t.append("<em experttid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                     t.append("<em experttid='" + v.myid + "' + realname='" + v.realname + "'>" + v.realname + "<i>×</i></em>")
                    
                }
                })
                $("#expert i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
            RssWin.open("/supervision/selectexpert.jsp", 600, 650);
        });
        
   
        
        
          //单位
          $('[selectcompanyuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                    if ($("em[companyid='" + v.myid + "']").length == "0") {
//                        t.append("<em companyid='" + v.myid + "'>" + v.myname + "<i>×</i></em>")
                        t.append("<em companyid='" + v.myid + "' + realname='" + v.myname + "'>" + v.myname + "<i>×</i></em>")
                        
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
