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
    RssList entity = new RssList(pageContext, "vote_activity"); // 
    CookieHelper cookie = new CookieHelper(request, response);
    entity.request();
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
                entity.keymyid(cookie.Get("myid"));
                entity.timestamp();                        
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
            .b99{width:99%;}
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
                <table class="wp100 cellbor">
                  <tr><td style="font-size:20px;font-family: 微软雅黑" colspan="7" id="tabheader">发起投票</td></tr>
                    <tr>
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    
<!--                    <tr>
                        
                        <td class="dce w100" style="font-size:16px;font-family: 微软雅黑">通知内容</td>
                        <td colspan="5" ><input style="font-size:16px;font-family: 微软雅黑;width:99%;" type="text" class="w98" name="notice" value="<% entity.write("notice"); %>" /><label class="labtitle"></label></td>
                    </tr>-->
               
                    
                    <tr>
                        <td  class="dce">投票范围</td>
                        <td colspan="5" id="needpreview">
                        <label><input type="radio" value="1" name="votetype" checked="cheched" >全体投票</label>
                        <label style="margin-left:7%;"><input type="radio" value="2" name="votetype">指定投票</label>                        
                        </td>
                    </tr>
                    
                    <tr class="votemember">
                        <td class="dce" style="width:110px;">投票成员<em class="red">*</em></td>
                        <td id="selpreviewsend" colspan="5"><em selectpreviewuser>点击添加投票人员</em>                
                        </td>
                    </tr>
                    <tr class="meeting">                     
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑" >会议时间<em class="red">*</em>
                      </td>
                      
                      <td colspan="2" style="font-size:16px">
                        <input type="text" class="b99 Wdate" name="meetingshijian"  rssdate="<% out.print(entity.get("meetingshijian")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                      </td>
                      
                    
                      <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">会议届次<em class="red">*</em></td>
                      <td colspan="2"><input style="font-size:16px;font-family: 微软雅黑;" type="text" maxlength="100" class="b99" name="session" value="<% entity.write("session"); %>" /><label class="labtitle"></label></td>

                    </tr>
                    
                    
                     <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel" style="font-size:16px;font-family: 微软雅黑">投票内容</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="opinion" class="w750" type="text/plain"></script>
                        </td>
                    </tr>
                    
  
    

                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <!--<input type="hidden" name="objid" >-->
                <input type="hidden" id="rid" name="objid" value="">

                <input type="hidden" id="voterids" name="voterids" value="">
                <!--<input type="hidden" id="previewLeaderRealName" name="previewLeaderRealName" value="<% entity.write("previewLeaderRealName"); %>">-->
                
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".votemember").hide();
            $("input[name='votetype']").click(function () {
                if ( $(this).val() == 2 ) {
                    $(".votemember").show();
                } else{
                    $(".votemember").hide();
                } 
            });
            
            
            
            $(".footer>button").click(function () {
                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
                    alert("请填写标题");
                    $("[name='title']").focus();
                    return false;
                } 
               
               
            //zyx 添加需要预审时，预审人员为必选项，不需要预审人员时，主任会议时间、届次为必填项。
            if($("input[name='votetype']:checked").val() == "2" ){
                if ($("#selpreviewsend em").length == 1) {
                    alert("请填写投票人员");
                    $("[name='leaderid']").focus();
                    return false;
                }   
            }
            if ( $("[name='meetingshijian']").val() == undefined || $("[name='meetingshijian']").val() == "") {
                    alert("请填写会议时间");
                    $("[name='meetingshijian']").focus();
                    return false;
                }
                if ( $("[name='session']").val() == undefined || $("[name='session']").val() == "") {
                    alert("请填写会议届次");
                    $("[name='session']").focus();
                    return false;
                }   
                
                if ($("[name='meetingshijian']").val() != undefined && $("[name='meetingshijian']").val() != "") {
                   var timestamp = new Date($("[name='meetingshijian']").val());
                   $("[name='meetingshijian']").val(timestamp / 1000);
            }
         //zyx  end          
             //添加预审领导到 leaderid
            var arry4 = [];
            var arry5 = [];
            $("#selpreviewsend>em[leaderid]").each(function () {
                arry4.push($(this).attr("leaderid"))
                arry5.push($(this).attr("realname"))        

            })
            var str4 = arry4.join(",");
            var str5 = arry5.join(",");

            $("#voterids").val( str4 );
//            $("#previewLeaderRealName").val( str5);

            
            
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
//                     t.append("<em leaderid='" + v.myid + "'>" + v.realname + "<i>×</i></em>")
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
