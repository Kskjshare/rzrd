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
     
    RssList entity = new RssList(pageContext, "legislativeprocess");
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
   RssList legislation_classify = new RssList(pageContext, "legislation_classify");
    
  
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();
               
//                entity.keyvalue("initiator", user.get("realname"));//方案制定者
//                entity.keyvalue("state", 1);
//               
                entity.append().submit();
                //out.print("<script>alert('append')</script>");
                break;
            case "update":
                //entity.remove("relationid","objid");
//                entity.remove("objid");
//                entity.keyvalue("state", 2);
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
                <table class="wp100 cellbor">
                   <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">立法过程</td></tr>
                    <tr>
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑">法规名称<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
        
                    
                 <tr>
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">起草部门<em class="red">*</em></td>                      
                        <td colspan="2"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="department" value="<% entity.write("department"); %>" /><label class="labtitle"></label></td>
                       
<!--                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑" >起草部门<em class="red">*</em></td>
                      
                        <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="department" value="<% entity.write("department"); %>" /><label class="labtitle"></label></td>-->

                        
                        
                    <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">类别</td>           
                        <td colspan="5" selradio>
                        <select style="width:206px;font-size:16px" value="<% legislation_classify.write("name"); %>" name="classificationname"  def="<% entity.write("classificationname"); %>">
                                 
                                <%      
                                     legislation_classify.select().where("name like '%" + 
                                            URLDecoder.decode(req.get("name"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                         while (legislation_classify.for_in_rows()) {
                                %>
                                <option><% legislation_classify.write("name"); %></option>
                                <%
                                }
                                %>
                            </select>                           
                        </td>    
                        
                    </tr>
                      
                                    
                    <tr>
                        <td class="dce w120" style="font-size:15px;font-family: 微软雅黑">起草联系人<em class="red">*</em></td>                      
                        <td colspan="2"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="drafter" value="<% entity.write("drafter"); %>" /><label class="labtitle"></label></td>
                       
                        <td class="dce w100" style="font-size:15px;font-family: 微软雅黑" >联系电话<em class="red">*</em></td>
                      
                        <td colspan="5"><input style="font-size:15px;font-family: 微软雅黑;width:99%;" type="text" maxlength="100" class="w98" name="telephone" value="<% entity.write("telephone"); %>" /><label class="labtitle"></label></td>

                    </tr>
                        


                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel" style="font-size:16px;font-family: 微软雅黑">法规正文</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                   
  

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>            
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".footer>button").click(function () {
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写法律法规名称");
                    $("[name='title']").focus();
                    return false;
                }
                
                
                 if ($("[name='issuingathority']").val() == undefined || $("[name='issuingathority']").val() == "") {
                    alert("请填写发布机关");
                    $("[name='issuingathority']").focus();
                    return false;
                }
               
     
                if ($("[name='distributeshijian']").val() != undefined && $("[name='distributeshijian']").val() != "") {
                    var timestamp = new Date($("[name='distributeshijian']").val());
                    $("[name='distributeshijian']").val(timestamp / 1000);
                }else {
                    alert("请选择发布日期");
                    $("[name='distributeshijian']").focus();
                    return false;
                }
                
                 if ($("[name='implementationshijian']").val() != undefined && $("[name='implementationshijian']").val() != "") {
                    var timestamp = new Date($("[name='implementationshijian']").val());
                    $("[name='implementationshijian']").val(timestamp / 1000);
                }else {
                    alert("实施日期");
                    $("[name='implementationshijian']").focus();
                    return false;
                }
                
      
                
            })                           
   
//            $("#inspecttype select").change(function () {//选择了类别//added by jackie
//            var v_type = '';
//
//           if ($("#inspecttype select").val() == 1) {// 听取和审议专项工作报告
//                v_type = 'specialReport/editSpecialreport';
//            }
//            self.location = "/supervision/" + v_type + ".jsp";
//            return false;
//            })

        </script>
    </body>
</html>
