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
                
                
                entity.keyvalue("typeid", 8);
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
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">视察</td></tr>
                    <tr>
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
                    <tr>
                        
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">通知内容<em class="red">*</em></td>
                        <td colspan="5" ><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="notice" value="<% entity.write("notice"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
                  
                    
                    <tr>
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">类别</td>
                        
                        <td  colspan="2">
                        <div id="inspecttype">
                        <select style="width:206px;font-size:15px;font-family: 微软雅黑" name="lwstate">
                            <option value="8" style="font-size:15px;font-family: 微软雅黑">视察</option>
                            <option value="1" style="font-size:15px;font-family: 微软雅黑">听取和审议专题报告</option>                                
                            <option value="2" style="font-size:15px;font-family: 微软雅黑">财政监督</option>
                            <option value="3" style="font-size:15px;font-family: 微软雅黑">法律法规实施情况的检查</option>
                            <option value="4" style="font-size:15px;font-family: 微软雅黑">规范性文件的备案审查</option>
                            <option value="5" style="font-size:15px;font-family: 微软雅黑">专题询问</option>
                            <option value="6" style="font-size:15px;font-family: 微软雅黑">特定问题调查</option>
                            <option value="7" style="font-size:15px;font-family: 微软雅黑">撤职案的审议和决定</option>
                            <option value="9" style="font-size:15px;font-family: 微软雅黑">调研</option>
                        </select>
                        </div>
                        </td>
                        
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">主题</td>           
                        <td colspan="2" selradio>
                            <select style="width:206px;font-size:15px" value="<% entity1.write("name"); %>" name="reviewclass" dict-select="companytypeeclassify" def="<% entity.write("reviewclass"); %>">
                                 
                                <%
                                    
                                      HttpRequestHelper req1 = new HttpRequestHelper(pageContext).request();
                                     entity1.select().where("name like '%" + 
                                            URLDecoder.decode(req1.get("name"), "utf-8") 
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
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">方案发起单位</td>
                        <td  colspan="2" style="font-size:15px;font-family: 微软雅黑"> <% user.write("realname"); %></td>   
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑" >视察时间<em class="red">*</em>
                        </td>
                        <td colspan="2" style="font-size:15px">
                            <input type="text" class="w200 Wdate" name="inspecttime"  rssdate="<% out.print(entity.get("inspecttime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                        </td>
                        
<!--                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">听取审议地点<em class="red">*</em></td>
                        <td colspan="2">
                            <input style="font-size:16px;font-family: 微软雅黑;" type="text"  name="place" value="<% entity.write("place"); %>" />
                            <label class="labtitle"></label>
                        </td>-->
                    </tr>  
                    
                    <tr>
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">视察方案<em class="red">*</em></td>
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
                        
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">视察地点</td>
                        <td  colspan="2">
                            <input class="w200" style="font-size:15px;font-family: 微软雅黑;" type="text"  name="place" value="<% entity.write("place"); %>" />
                            <label class="labtitle"></label>
                        </td>
                    </tr>
                    
                 
                   
                     <tr>                     
                      <td class="dce w100" style="font-size:15px;font-family: 微软雅黑" >主任会议时间<em class="red">*</em>
                      </td>
                      
                      <td colspan="2" style="font-size:15px">
                        <input type="text" class="w200 Wdate" name="meetingshijian"  rssdate="<% out.print(entity.get("meetingshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                      </td>
                      
                    
                      <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">主任会议届次<em class="red">*</em></td>
                      <td colspan="2"><input style="font-size:15px;font-family: 微软雅黑;width:200px;" type="text" maxlength="100" class="w98" name="directormeetingnum" value="<% entity.write("directormeetingnum"); %>" /><label class="labtitle"></label></td>

                    </tr>
                  
                    
                <!--  
                  <tr>
                        <td class="dce"><b class="selectuser" style="color:blue;font-size:16px;font-family: 微软雅黑;cursor:pointer;">添加参与人<em class="red">*</em></b></td>
                        <td colspan="5">
                            <ul style="font-size:16px;font-family: 微软雅黑" id="blfyr" class="lianmingren">
                                <li>
                                    <em  style='display: inline;font-size:16px;width: 65.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;font-family: 微软雅黑'>
                                         姓名                                    </em>
                                    <em style='display: inline;font-size:16px;font-family: 微软雅黑;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;操作
                                    </em>
                                </li>
                            </ul></td>

                    </tr>
                    -->
                  
                    <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">视察组成员</td></tr>
                    <tr class="inspectmember" >
                        <td class="dce" style="width:110px;">常委会成员<em class="red">*</em></td>
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
                        <td class="dce" style="width:110px;">人大代表<em class="red">*</em></td>
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
                    
<!--                     <tr>
                        <td class="dce w100 " style="color:blue;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;" >参加单位<em class="red">*</em></td>
                        <td  colspan="5" id="userrolesel">
                            <textarea  style="width:99%;" readonly="readonly" value="<% req.write("company"); %>"><% entity.get("company"); %></textarea>
                            <input type="hidden" name="company" id="userroleid" value="<% entity.write("company"); %>"/>
                        </td>
                    </tr>-->
                    
                     <tr class="inspectmember" >
                        <td class="dce" style="width:110px;">其他人员</td>
                        <td id="parttimecommitteesend" colspan="5"><em parttimecommitteeuser>点击选择其他</em>                
                        </td>
                           <%
                               RssListView parttime = new RssListView(pageContext, "user_delegation");
                               parttime.request();
                               if (entity.get("id").isEmpty()) {
                                parttime.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                               } else {
                                parttime.select().where("myid=" + entity.get("myid")).get_first_rows();
                               }
                           %>
                    </tr>
  
<!-- 
                    <tr class="inspectmember" >
                        <td class="dce" style="width:110px;">专家<em class="red">*</em></td>
                        <td id="expert" colspan="5"><em expertid>点击选择专家人员</em>                
                        </td>
                           <%
                               RssListView userrole = new RssListView(pageContext, "user_delegation");
                               userrole.request();
                               if (entity.get("id").isEmpty()) {
                                userrole.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                               } else {
                                userrole.select().where("myid=" + entity.get("myid")).get_first_rows();
                               }
                           %>
                    </tr>
                    
          
                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel" style="font-size:16px;font-family: 微软雅黑">内容</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                   
                    <tr>
                        <td style="font-size:16px;font-family: 微软雅黑">方案文件</td>
                        <td colspan="5">
                            <div><span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑">点击选择方案文件</span><input type="hidden" id="enclosure" ></div>
                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑">点击选择文件</span><input type="hidden" id="enclosure2" ></div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑">点击选择文件</span><input type="hidden" id="enclosure3" ></div>
                        </td>
                    </tr>
                    -->
                    
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
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <!--<input type="hidden" name="objid" >-->
                <input type="hidden" id="rid" name="objid" value="">
                 <input type="hidden" id="committeerid" name="committeeobjid" value="">
                 <input type="hidden" id="parttimecommitid" name="parttimemember" value="">
                 <input type="hidden" id="expertmemberid" name="expertmemberid" value="">
                 <input type="hidden" id="company" name="company" value="">
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                }
               
                
                
                
              
                
                
                if ($("[name='enclosure']").val() == undefined || $("[name='enclosure']").val() == "") {
                    alert("请添加方案文件");
                    $("[name='enclosure']").focus();
                    return false;
                }
             
                
                 if ($("[name='directormeetingnum']").val() == undefined || $("[name='directormeetingnum']").val() == "") {
                    alert("请填写主任会议届次");
                    $("[name='directormeetingnum']").focus();
                    return false;
                }
                
         
              
//            if ($("#expert em").length == 1) {
//                alert("请选择专家人员");
//                return false;
//              }
                
                
                
            if ($("#selcommitteesend em").length == 1) {
                alert("请选择常委会成员");
                return false;
            }
            if ($("#selsend em").length == 1) {
                alert("请选择代表");
                return false;
            }
            
            if ($("#parttimecommitteesend em").length == 1) {
            alert("请选择其他人员");
            return false;
              }
//            if ($("[name='company']").val() == undefined || $("[name='company']").val() == "") {
//                    alert("请填写参加单位");
//                    $("[name='company']").focus();
//                    return false;
//            }


            if ($("[name='inspecttime']").val() == undefined || $("[name='inspecttime']").val() == "") {
                    alert("请填写视察时间");
                    $("[name='inspecttime']").focus();
                    
                    //
                    $("[name='meetingshijian']").val("");
                    return false;
                }
                else {
                     if ($("[name='inspecttime']").val() != undefined && $("[name='inspecttime']").val() != "") {
                    var timestamp = new Date($("[name='inspecttime']").val());
                    $("[name='inspecttime']").val(timestamp / 1000);
                }
               }
                
               if ($("[name='meetingshijian']").val() == undefined || $("[name='meetingshijian']").val() == "") {
                    alert("请填写主任会议时间");
                    $("[name='meetingshijian']").focus();
                    
                      //
                    $("[name='inspecttime']").val("");
                    return false;
                }else {
                    if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
                        var timestamp = new Date($("[name='meetingshijian']").val());
                        $("[name='meetingshijian']").val(timestamp / 1000);
                    }        
                }
                
                
 
                 
                 


            //添加人大代表id到objid
            var arry = [];
            $("#selsend>em[myid]").each(function () {
                arry.push($(this).attr("myid"))        
            })
            var str = arry.join(",");
            $("#rid").val(str);
            // alert(str);
          
            
            //添加常委委员id到committeeobjid
            var arry1 = [];
            $("#selcommitteesend>em[committeemyid]").each(function () {
                arry1.push($(this).attr("committeemyid"))        
            })
            var str1 = arry1.join(",");
            $("#committeerid").val( str1 );
            //alert(str1);
            
            
            //添加兼职委员id到parttimemember
            var arry2 = [];
            $("#parttimecommitteesend>em[parttimecommitteeid]").each(function () {
                arry2.push($(this).attr("parttimecommitteeid"))        
            })
            var str2 = arry2.join(",");
            $("#parttimecommitid").val( str2 );
            
             var arry3 = [];
            $("#expert>em[experttid]").each(function () {
                arry3.push($(this).attr("experttid"))        
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

           if ($("#inspecttype select").val() == 1) {// 听取和审议专题报告
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


        $('[selectuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
                $.each(dict, function (k, v) {
                if ($("em[myid='" + v.myid + "']").length == "0") {
                    t.append("<em myid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")

//                  t.append("<em myid='" + v.myid + "' sellzstate='" + v.sellzstate + "'>" + v.realname + "<i>×</i></em>")
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
                RssWin.open("/activities/selectuser_2.jsp?mission=<%=user1.get("mission")%>", 500, 600);
            }
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
    
    
    
    //常委会人员
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
            var coo =<%=cookie.Get("powergroupid")%>;
            if (coo == "22") {
                RssWin.open("/activities/selectuser_2.jsp?mission=<%=cookie.Get("myid")%>", 500, 600);
            } else {
               // RssWin.open("/activities/selectuser_2.jsp?mission=<%=user1.get("mission")%>", 500, 600);
                 RssWin.open("/supervision/selctcommitteemember.jsp", 500, 600);
            }
        });
        
         //兼职委员
        $('[parttimecommitteeuser]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
            $.each(dict, function (k, v) {
                if ($("em[parttimecommitteeid='" + v.myid + "']").length == "0") {
                     t.append("<em parttimecommitteeid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                     
                }
                })
                $("#parttimecommitteesend i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
           
            RssWin.open("/supervision/selectuserroles.jsp", 500, 600);
          
        });
        
         //专家
        $('[expertid]').click(function () {
            var t = $(this).parent();
            RssWin.onwinreceivemsg = function (dict) {
            $.each(dict, function (k, v) {
                if ($("em[experttid='" + v.myid + "']").length == "0") {
                     t.append("<em experttid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
                     
                }
                })
                $("#expert i").off("click").click(function () {
                    $(this).parent().remove();
                })
            }
           
            RssWin.open("/supervision/selectexpert.jsp", 500, 600);
          
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
