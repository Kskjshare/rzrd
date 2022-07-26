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
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
                entity.keyvalue("typeid", 9 );
                
                entity.keyvalue("initiator", user.get("realname"));//方案制定者
                //entity.keyvalue("progress", "待视察调研");//方案制定者等
                entity.append().submit();
                break;
            case "update":
                entity.remove("relationid","objid");
                entity.update().where("id=?", entity.get("relationid")).submit();
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
                <!--<h1 style="margin-top:3px;margin-bottom:10px;font-size:22px;font-family: 微软雅黑;text-align: center; ">视察调研</h1>-->
                <table class="wp100 cellbor">
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">调研</td></tr>
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
                    <tr>
                        
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">通知内容</td>
                        <td colspan="5" ><input style="font-size:16px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="notice" value="<% entity.write("notice"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
                  
                    
                    <tr>
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">类别</td>
                        
                        <td  colspan="2">
                        <div id="inspecttype">
                        <select style="width:206px;font-size:16px;font-family: 微软雅黑" name="lwstate">
                            <option value="9" style="font-size:15px;font-family: 微软雅黑">调研</option>
                            <option value="1" style="font-size:15px;font-family: 微软雅黑">听取和审议专项工作报告</option>                                
                            <option value="2" style="font-size:15px;font-family: 微软雅黑">财政监督</option>
                            <option value="3" style="font-size:15px;font-family: 微软雅黑">法律法规实施情况的检查</option>
                            <option value="4" style="font-size:15px;font-family: 微软雅黑">规范性文件的备案审查</option>
                            <option value="5" style="font-size:15px;font-family: 微软雅黑">专题询问</option>
                            <option value="6" style="font-size:15px;font-family: 微软雅黑">特定问题调查</option>
                            <option value="7" style="font-size:15px;font-family: 微软雅黑">撤职案的审议和决定</option>
                            <option value="8" style="font-size:15px;font-family: 微软雅黑">视察</option>
                            
                        </select>
                        </div>
                        </td>
                        
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">主题</td>           
                        <td colspan="2" selradio>
                        <select style="width:206px;font-size:16px" value="<% entity1.write("name"); %>" name="reviewclass" dict-select="companytypeeclassify" def="<% entity.write("reviewclass"); %>">
                                 
                                <%      
                                     entity1.select().where("name like '%" + 
                                            URLDecoder.decode(req.get("name"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                    int a=1;
                                         while (entity1.for_in_rows()) {
                                %>
                                <option><% entity1.write("name"); %></option>
                                <%
                                }
                                %>
                            </select>
                            
                            
                        </td>
                        
  
                    </tr>
                    
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">方案发起单位</td>
                        <td  colspan="2" style="font-size:16px;font-family: 微软雅黑"> <% user.write("realname"); %></td>   
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑" >调研时间<em class="red">*</em>
                        </td>
                        <td colspan="2" style="font-size:16px">
                            <input type="text" class="w200 Wdate" name="inspecttime"  rssdate="<% out.print(entity.get("inspecttime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                        
<!--                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">听取审议地点<em class="red">*</em></td>
                        <td colspan="2">
                            <input style="font-size:16px;font-family: 微软雅黑;" type="text"  name="place" value="<% entity.write("place"); %>" />
                            <label class="labtitle"></label>
                        </td>-->
                    </tr>  
                    
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">调研方案<em class="red">*</em></td>
                        <td colspan="2">
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
                        
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">调研地点</td>
                        <td  colspan="2">
                            <input class="w200" style="font-size:16px;font-family: 微软雅黑;" type="text"  name="place" value="<% entity.write("place"); %>" />
                            <label class="labtitle"></label>
                        </td>
                    </tr>
                    
                 
                  
                    
                    <tr>
                        <td  class="dce">领导预审</td>
                        <td colspan="5" id="needpreview">
                        <label><input type="radio" value="1" name="leaderpreview" checked="cheched" >需要预审</label>
                        <label style="margin-left:7%;"><input type="radio" value="2" name="leaderpreview">不需要预审</label>                        
                        </td>
                    </tr>
                    
                    <tr class="previewmember">
                        <td class="dce" style="width:110px;">预审成员<em class="red">*</em></td>
                        <td id="selpreviewsend" colspan="5"><em selectpreviewuser>点击添加预审人员</em>                
                        </td>
                    </tr>
                    <tr class="meeting">                     
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑" >主任会议时间<em class="red">*</em>
                      </td>
                      
                      <td colspan="2" style="font-size:16px">
                        <input type="text" class="w200 Wdate" name="meetingshijian"  rssdate="<% out.print(entity.get("meetingshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                      </td>
                      
                    
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">主任会议届次<em class="red">*</em></td>
                      <td colspan="2"><input style="font-size:16px;font-family: 微软雅黑;width:200px;" type="text" maxlength="100" class="w98" name="directormeetingnum" value="<% entity.write("directormeetingnum"); %>" /><label class="labtitle"></label></td>

                    </tr>
                    
  
    

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <!--<input type="hidden" name="objid" >-->
                <input type="hidden" id="rid" name="objid" value="">

                <input type="hidden" id="previewleadername" name="previewleadername" value="">
                <input type="hidden" id="previewLeaderRealName" name="previewLeaderRealName" value="<% entity.write("previewLeaderRealName"); %>">

            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            
            //主任会审议     
                    $(".meeting").hide();
           $("input[name='leaderpreview']").click(function () {
                if ($(this).val() == 1) {
                    $(".previewmember").show();
                    $(".meeting").hide();
                } else{
                    $(".previewmember").hide();
                    $(".meeting").show();
                } 
            });
            
            
            
            $(".footer>button").click(function () {
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                } 
                if ($("[name='inspecttime']").val() == undefined || $("[name='inspecttime']").val() == "") {
                   alert("请填写调研时间");
                   $("[name='inspecttime']").focus();
                   
                   //
                    $("[name='meetingshijian']").val("");
                   return false;
               }
                
                if ($("[name='enclosure']").val() == undefined || $("[name='enclosure']").val() == "") {
                    alert("请添加方案文件");
                    $("[name='enclosure']").focus();
                    return false;
                }
                
              
                   
                                            
               
               
            //zyx 添加需要预审时，预审人员为必选项，不需要预审人员时，主任会议时间、届次为必填项。
            if($("input[name='leaderpreview']:checked").val() == "1" ){
                if ($("#selpreviewsend em").length == 1) {
                    alert("请填写预审人员");
                    $("[name='leaderid']").focus();
                    return false;
                }   
            }else if($("input[name='leaderpreview']:checked").val() == "2" ){
                if ( $("[name='meetingshijian']").val() == undefined || $("[name='meetingshijian']").val() == "") {
                    alert("请填写主任会议时间");
                    $("[name='meetingshijian']").focus();
                    return false;
                }
                if ( $("[name='directormeetingnum']").val() == undefined || $("[name='directormeetingnum']").val() == "") {
                    alert("请填写主任会议届次");
                    $("[name='directormeetingnum']").focus();
                    return false;
                }   
                
                    if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
                   var timestamp = new Date($("[name='meetingshijian']").val());
                   $("[name='meetingshijian']").val(timestamp / 1000);
               }
               
            }
              if ($("[name='inspecttime']").val() != undefined && $("[name='inspecttime']").val() != "") {
                   var timestamp = new Date($("[name='inspecttime']").val());
                   $("[name='inspecttime']").val(timestamp / 1000);
               }
         //zyx  end          
             //添加预审领导到 leaderid
             var arry4 = [];
             var arry4_name = [];
            $("#selpreviewsend>em[leaderid]").each(function () {
                arry4.push($(this).attr("leaderid"))    
                arry4_name.push($(this).attr("realname"))        

            })
            var str4 = arry4.join(",");
            var str4_name = arry4_name.join(",");
            $("#previewleadername").val( str4 );
            $("#previewLeaderRealName").val( str4_name );

            
            
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
               v_type = 'topic/editNormativeDocumenT';
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
                        //alert("上传成功");
                    }});
                return false;
            })


        
        //预审领导
        $('[selectpreviewuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
            $.each(dict, function (k, v) {
                if ($("em[leaderid='" + v.myid + "']").length == "0") {
                    //t.append("<em leaderid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                    t.append("<em leaderid='" + v.myid + "' + realname='" + v.realname + "'>" + v.realname + "<i>×</i></em>")

                }
                })
                $("#selpreviewsend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
             RssWin.open("/supervision/selctcommitteemember.jsp", 600, 650);
        });
        
    
  
        </script>
    </body>
</html>
