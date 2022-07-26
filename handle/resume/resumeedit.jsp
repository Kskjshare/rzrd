<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="java.util.Collection"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="java.util.ArrayList"%>
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
    String type = "";
    int isRuzhouFeature = 1 ; // 1: 代表汝州项目 
    StaffList.IsLogin(request, response);
    //推送接口
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    //创建推送的人员范围
    Map<String, String> map = new HashMap<String, String>();
    RssList senduser = new RssList(pageContext, "userdeviceid");
    RssList duser = new RssList(pageContext, "secondeduser");
    RssList entity = new RssList(pageContext, "suggest");
    RssListView entity1 = new RssListView(pageContext, "sort");
    RssListView list = new RssListView(pageContext, "sort");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    list.request();
    entity.request();
    
    //为了获取协办单位增加这个语句
   // entity.select().where("id=?", entity.get("id")).get_first_rows();
    
   
    if (!entity.get("action").isEmpty()) {
        entity.remove("id");
        entity.remove("myid");
        switch (entity.get("action")) {
            case "append":         
             
                //added by ding for writing informations of persons to table
                entity.keyvalue("firstperson", entity.get("firstperson"));
                entity.keyvalue("firstpost", entity.get("firstpost"));
                entity.keyvalue("firstphone", entity.get("firstphone"));
                entity.keyvalue("secondperson", entity.get("secondperson"));
                entity.keyvalue("secondpost", entity.get("secondpost"));
                entity.keyvalue("secondphone", entity.get("secondphone"));
                entity.keyvalue("resumeinfo",entity.get("resumeinfo"));
                entity.keyvalue("comments",entity.get("comments"));
                //end
                //foreced to be written time of responce by ding 
               
                entity.keyvalue("ResponseTime",System.currentTimeMillis() / 1000); 
                entity.keyvalue("discussinspecttime",System.currentTimeMillis() / 1000);
               
                //end
                
                entity.keyvalue("resume", 1);
                entity.update().where("id=?", list.get("id")).submit();
                lzmessage.keyvalue("realid", list.get("id"));
                lzmessage.keyvalue("classify", 5);
                lzmessage.timestamp();
                lzmessage.append().submit();
                read.keyvalue("messageid", lzmessage.autoid);
                read.keyvalue("objid", entity.get("myid"));
                read.keyvalue("type", 1);
                read.append().submit();
                String[] arr = {"8", "16"};
                for (int idx = 0; idx < arr.length; idx++) {
                    read.keyvalue("messageid", lzmessage.autoid);
                    read.keyvalue("groupid", arr[idx]);
                    read.keyvalue("type", 1);
                    read.append().submit();
                }
//                out.print(list.get("id"));
                entity1.select().where("id=?", list.get("id")).get_first_rows();
                
                if (entity1.get("lwstate").equals("1")) {
                    type = "建议";
                    map.put("key", "2");
                }
                else if ( entity1.get("lwstate").equals("2") ){
                    type = "议案";
                    map.put("key", "3");
                }
                else if ( entity1.get("lwstate").equals("3") ){
                    type = "批评";
                    map.put("key", "4");
                }
                 else if ( entity1.get("lwstate").equals("4") ){
                    type = "意见";
                    map.put("key", "5");
                }
                  else if ( entity1.get("lwstate").equals("5") ){
                    type = "质询";
                    map.put("key", "6");
                }
                
              
                
                //推送人员
//                out.print("---" + entity1.get("id") + "---entity1");
                duser.pagesize = 10000000;
                duser.select().where("suggestid=?", entity1.get("id")).get_page_desc("id");
                while (duser.for_in_rows()) {
                    if (!(duser.get("userid").isEmpty())) {
                        //推送的关键,构造一个payload 
                        senduser.pagesize = 10000000;
                        senduser.select().where("state=1 and myid=?", duser.get("userid")).get_page_desc("id");
                        String bt = entity1.get("title");
                        while (senduser.for_in_rows()) {
                            if (!(senduser.get("deviceid").isEmpty())) {
                                jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 承办单位 正式办复！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条办复的" + type + "")).build());
                            }
                        }
                    }
                }
                if (!(entity1.get("myid").isEmpty())) {
                    senduser.pagesize = 10000000;
                    senduser.select().where("state=1 and myid=?", entity1.get("myid")).get_page_desc("id");
                    String bt = entity1.get("title");
                    while (senduser.for_in_rows()) {
                        if (!(senduser.get("deviceid").isEmpty())) {
                            //jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 承办单位 正式办复！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条办复的" + type + "")).build());
                            //commented by jackie
                        }
                    }
                }
                break;
            case "update":
                //entity.keyvalue("firstperson", entity.get("firstperson"));
                //entity.keyvalue("secondperson", entity.get("secondperson"));
                 //entity.update().where("id=?", entity.get("id")).submit();
                entity.keyvalue("resume", 1);
                entity.update().where("id=?", list.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    list.select().where("id=?", list.get("id")).get_first_rows();
    String[] arry = {"", "", ""};
    if (!entity.get("dfenclosure").isEmpty()) {
        String[] str = entity.get("dfenclosure").split(",");
        for (int idx = 0; idx < str.length; idx++) {
            arry[idx] = str[idx];
        }
    }
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
            .popupwrap{width: 98%}
            .left_op{width: 30px}
            .mui-input-row span{display: none}
            .mui-input-range input[type=range]{background-color: #dce6f5;height: 6px;border: 1px solid #cbcbcb;width: 90%;margin: 0}
            .mui-input-row.mui-input-range{float: left;width: 90%;padding: 0;}
            .tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 36px;}
            .cellbor{width: 100%}
            .fileeform{position: absolute;left: -10000px;}
            #fileeform1{position: absolute;left: -10000px;}
            #fileeform2{position: absolute;left: -10000px;}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;width: 92%}
            .cellbor>tbody>tr>.marginauto>#matter{line-height: 14px;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;}
            .h210{height: 210px}
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            #baidubjq td{line-height: 17px;background: #dce6f5}
            #baidubjq td ul{width: 798px;margin-top: 5px;border-top: 1px solid #6caddc;border-left: 1px solid #6caddc;border-right: 1px solid #6caddc}
            #baidubjq td div{border-left: 1px solid #6caddc;border-right: 1px solid #6caddc;border-bottom: 1px solid #6caddc;margin-bottom: 5px;width: 778px;padding: 10px;background: #fff}
            .shu{line-height: 15px;text-align: center;}
            .uetd>ul{left: 0}
            .cellbor>tbody>tr .line{line-height: 24px}
            textarea{width: 99%;height: 60px;margin: 5px 0;}
            .red{color: red;}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            #fjfile1{cursor: pointer;}
        </style>
    </head>
    <body>
        <form id="fileeform1" enctype="multipart/form-data" method="post">
            <input type="file" id="filee1" accept="." name="file" multiple>
        </form>
        
         <form id="fileeform2" enctype="multipart/form-data" method="post">
            <input type="file" id="filee2" accept="." name="file" multiple>
        </form>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
                    <tr>
                        <td colspan="4" class="tabheader">具体信息</td>
                    </tr>
                        <!--
                    <tr>
                    
                        <td class="dce">编号：</td>
                        <td class="w261"><% out.print(list.get("realid")); %></td>
	       
                        <td class="dce">层次：</td>
                        <td class="w261" circles="<% list.write("level"); %>"></td>
	

                    </tr>

                    <tr>
                        <td class="dce">届次：</td>
                        <td colspan="3" sessionclassify="<% list.write("sessionid"); %>"></td>
                    </tr>
                    <tr><td class="dce">会议次数</td>
                        <td colspan="3" companytypeeeclassify="<% list.write("meetingnum"); %>"></td>
                    </tr>
                    <tr>
 -->

                        <td class="dce">类型</td>
<!--
                        <td class="w261" classify="<% out.print(list.get("type")); %>"></td>
-->
	        <td class="w261" classify="
		<%   
		 
                        
                           if (list.get("lwstate").equals("1")) {
                                 out.print("建议");
                             }
                else if ( list.get("lwstate").equals("2") ){
                   
                    out.print("议案");
                }
                else if ( list.get("lwstate").equals("3") ){
                
                    out.print("批评");
                }
                 else if ( list.get("lwstate").equals("4") ){
                    
                    out.print("意见");
                }
                  else if ( list.get("lwstate").equals("5") ){
     
                    out.print("质询");
                }

		%>
		">
	   </td>
   



                        <td class="dce">提交日期</td>
                        <td rssdate="<% list.write("shijian"); %>,yyyy-MM-dd"></td>
                    </tr>
                    <tr>
                        <td class="dce">标题</td>
                        <td colspan="3"><% list.write("title"); %></td>
                    </tr>
 	  <tr>
                        <td class="dce">内容摘要</td>
                        <td colspan="3"><% list.write("matter"); %></td>
                    </tr>


<!---added by ding -->
                    <tr><td class="w120 dce">领衔代表</td><td colspan="3"><% list.write("realname"); %></td></tr>


	<tr><td class="w120 dce">附议代表</td>
			<td colspan="3">
                                                  <%
                                                        if (!list.get("id").isEmpty()) {
                                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                                            while (secondlist.for_in_rows()) {
                                                    %>
                                                     
			    <% out.print(secondlist.get("realname"));%>
			    <% out.print("    ");%>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                               </td>
			</tr>
<!---added end -->




                    <tr>
                        <td class="dce">交办日期</td>
                        <td class="w261" rssdate="<% list.write("start"); %>,yyyy-MM-dd HH:mm:ss"></td>
                        <td class="dce">审核状态</td>
                        <td class="w261" examination="<% out.print(list.get("examination")); %>"></td>
                    </tr>
                    <tr>
                        <td colspan="4" class="tabheader">办复信息</td>
                    </tr>
                    <tr>
                        <td class="dce">承办单位</td>
                        <td colspan="3"><% out.print(list.get("realcompanyname")); %></td>
                        <!--                        <td class="dce">办理类型：</td>
                                                <td class="w261" registertype="<% out.print(list.get("registertype")); %>"></td>-->
                    </tr>
                    <tr>
                        <td class="dce">协办单位</td>
                        <td colspan="3"><% out.print(entity.get("coorganisername")); %></td>                  
                    </tr>
                    <tr>
                        <td class="dce">办理方式</td>
                        <td>
                            <select class="w206" name="way" dict-select="way" def="<% list.write("way"); %>">
                                <option value="4">面商</option>
                            </select>
                        </td>
                        <td class="dce">办理情况</td>
                        <td class="w261"><select class="w206" name="degree" dict-select="degreea" def="<% list.write("degree"); %>"></select></td>
                    </tr>
                    <!--                    <tr>
                                            <td class="dce">办复密级：</td>
                                            <td><select class="w206" name="rank" dict-select="rank" def="<% list.write("rank"); %>"></select></td>
                                            <td class="dce">是否落实：</td>
                                            <td class="w261"><select class="w206" name="implement" dict-select="state" def="<% list.write("implement"); %>"></select></td>
                                        </tr>-->
 <!--                        
		<tr>
                                           <td class="dce">代表意见：</td>
                                                <td><select class="w206" name="representative" dict-select="representative" def="<% list.write("representative"); %>"></select></td>
                        <td class="dce">答复期限：<em class="red">*</em></td>
		
                        <td class="w261" colspan="3"><input type="text" class="w200 Wdate" name="organize" rssdate="<% list.write("organize"); %>,yyyy-MM-dd"  onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly"></td>
                    </tr>

                    <tr>
                        <td class="dce">办复人：<em class="red">*</em></td>
                        <td><input type="text" class="yincang" name="BanFuName" value="<% list.write("BanFuName"); %>"></td>
                        <td class="dce">办复人电话：</td>
                        <td class="w261"><input type="text" class="yincang" name="BanFutel" placeholder="请输入电话" value="<% list.write("BanFutel"); %>"></td>
                    </tr>
-->
	<!--
                    <tr>
                        <td class="dce">意见说明：<em class="red">*</em></td>
                        <td colspan="3"><textarea name="comments"><% out.print(list.get("comments")); %></textarea></td>
                    </tr>
	
 	<tr>
                        <td colspan="4" class="tabheader">承办单位</td>
	    <tr>
                        <td colspan="4"><% out.print(list.get("realcompanyname")); %></td>
                    </tr>
                </tr>
-->
<!--zyx 增加面商功能-->
                <tr id="biaoti"><td colspan="4" class="tabheader">面商回复信息</td></tr>
                <tr  id="didian">
                    <td class="dce">面商地点<em class="red">*</em></td>
                    <td><input type="text"  name="discussbank" value="<% entity.write("discussbank"); %>"></td>        
                    <td class="dce">面商时间<em class="red">*</em></td>
                    <td >
                        <input type="text" class="w200 Wdate" name="discussinspecttime"  rssdate="<% out.print(entity.get("discussinspecttime")); %>,yyyy-MM-dd"   onFocus="WdatePicker({lang: 'zh-cn'})" readonly="readonly">
                    </td>
                </tr>
               <tr id="fujian">
	    <td class="dce">面商附件<em class="red">*</em></td>
                    <td colspan="5">
                            <div>
                                <span id="fjfile1" rid="1" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                                <input type="hidden" name="discussenclosure" value="<% entity.write("discussenclosure"); %>" >
                                <input type="hidden" name="discussenclosurename"  value="<% entity.write("discussenclosurename"); %>" >
                            </div>
                    </td>
               </tr>

<!--zyx  end-->
	<tr>
	<td colspan="4" class="tabheader">分管负责人信息</td>
        </tr>
                <tr>
                        <td class="dce">负责人姓名<em class="red">*</em></td>
                        <td><input type="text"  name="firstperson" value="<% entity.write("firstperson"); %>"></td>        
                        <td class="dce">负责人职务<em class="red">*</em></td>
                        <td class="w261"><input type="text"  name="firstpost" placeholder="请输入负责人职务" value="<% entity.write("firstpost"); %>"></td>
                    </tr>
               <tr>
	    <td class="dce">负责人电话<em class="red">*</em></td>
                    <td><input type="text"  name="firstphone" value="<% entity.write("firstphone"); %>"></td>
               </tr>

                </tr>

	<tr>

	<td colspan="4" class="tabheader">具体承办人信息</td>
        </tr>
  	<tr>
                        <td class="dce">承办人姓名<em class="red">*</em></td>
                        <td><input type="text"  name="secondperson" value="<% entity.write("secondperson"); %>"></td>
                        <td class="dce">承办人职务<em class="red">*</em></td>
                        <td class="w261"><input type="text"  name="secondpost" placeholder="请输入承办人职务" value="<% entity.write("secondpost"); %>"></td>
                    </tr>
               <tr>
	    <td class="dce">承办人电话<em class="red">*</em></td>
                    <td><input type="text"  name="secondphone" value="<% entity.write("secondphone"); %>"></td>
               </tr>

                </tr>

                    <tr><td class="dce">答复文件</td>
                        <td colspan="5">
                            <div>
                                <span id="fjfile2" rid="2" style="color:blue ;font-size:15px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">点击选择文件</span>
                                <input type="hidden" name="dfenclosure" value="<% entity.write("dfenclosure"); %>" >
                                <input type="hidden" name="dfenclosurename"  value="<% entity.write("dfenclosurename"); %>" >
                            </div>
<!--                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                </div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                </div>-->
                        </td>
                  
                    </tr>
                    <tr>


                        <td class="dce"> 
		<% 
 		 entity1.select().where("id=?", list.get("id")).get_first_rows();      
		if (entity1.get("lwstate").equals("1")) {
                  
		out.print("建议办理报告");
                 
                } else if (entity1.get("lwstate").equals("2")){
                  out.print("议案办理报告");
                  
                }
               else if (entity1.get("lwstate").equals("3")) {
                  
		out.print("批评办理报告");
                 
                }
                else if (entity1.get("lwstate").equals("4")) {
                  
		out.print("意见办理报告");
                 
                } 
               else if (entity1.get("lwstate").equals("5")){
                  out.print("质询办理报告");
                  
                };
	        %></td>
		
	       <!--
                        <td class="dce">办复报告：<em class="red">*</em></td>
	       -->
                        <td colspan="3">请在下面输入框输入办理报告</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="marginauto"><script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="resumeinfo" class="w750" type="text/plain"></script></td>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">提交</button>
<!--                <input name="dfenclosure" type="hidden">-->
<!--                <input name="discussinspecttime" type="hidden">-->
                <input name="myid" type="hidden" value="<% out.print(entity.get("myid"));%>">
            </div>
        </form>
        <!--<script src="/data/bill.js" type="text/javascript"></script>-->
        <script src="../../data/session.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script src="../../data/dictdata.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>
 //zyx  面商的显示与隐藏                           
   $("select[name='way']").click(function () {
                if ($(this).val() == 4) {
                    $("#biaoti").show();
                    $("#didian").show();
                    $("#fujian").show();
                } else {
                    $("#biaoti").hide();
                    $("#didian").hide();
                    $("#fujian").hide();
                } 
            });
  // end 
  // 弹窗
                        $(".footer>button").click(function () {   
                            //判断是否为面商，如果是则要求必选项。
                           if( $("[name='way']").val() == "4"){
                                 if ($("[name='discussbank']").val() == undefined || $("[name='discussbank']").val() == "") {
                                    alert("请填写面商地点");
                                    $("[name='discussbank']").focus();
                                    return false;
                                }
                                if ($("[name='discussinspecttime']").val() == undefined || $("[name='discussinspecttime']").val() == "") {
                                    alert("请填写面商时间");
                                    $("[name='discussinspecttime']").focus();
                                    return false;
                                }
                                if ($("[name='discussenclosure']").val() == undefined || $("[name='discussenclosure']").val() == "") {
                                    alert("请添加面商报告");
                                    $("[name='discussenclosure']").focus();
                                    return false;
                                }
                            }
                            // 判断面商  end
                                if ($("[name='firstperson']").val() == undefined || $("[name='firstperson']").val() == "") {
                                    alert("请填写负责人姓名");
                                    $("[name='firstperson']").focus();
                                    return false;
                                }
                                if ($("[name='firstpost']").val() == undefined || $("[name='firstpost']").val() == "") {
                                    alert("请填写负责人职务");
                                    $("[name='firstpost']").focus();
                                    return false;
                                }
                                if ($("[name='firstphone']").val() == undefined || $("[name='firstphone']").val() == "") {
                                    alert("请填写负责人电话");
                                    $("[name='firstphone']").focus();
                                    return false;
                                }
                                if ($("[name='secondperson']").val() == undefined || $("[name='secondperson']").val() == "") {
                                    alert("请填写承办人姓名");
                                    $("[name='secondperson']").focus();
                                    return false;
                                }
                                if ($("[name='secondpost']").val() == undefined || $("[name='secondpost']").val() == "") {
                                    alert("请填写承办人职务");
                                    $("[name='secondpost']").focus();
                                    return false;
                                }
                                if ($("[name='secondphone']").val() == undefined || $("[name='secondphone']").val() == "") {
                                    alert("请填写承办人电话");
                                    $("[name='secondphone']").focus();
                                    return false;
                                }
                                if ($("[name='dfenclosure']").val() == undefined || $("[name='dfenclosure']").val() == "") {
//                                    alert("请上传附件");
//                                    $("[name='dfenclosure']").focus();
//                                    return false;
                                }
// 弹窗 end
//                                if ( isRuzhouFeature == 1 ){
////                                 var timestamp = Date.parse(new Date());
////                                console.log(timestamp / 1000);
////                                $('[name=ResponseTime]').val(timestamp / 1000);
//                                }else {
////                                    var enc = $("#enclosure1").val() + "," + $("#enclosure2").val() + "," + $("#enclosure3").val();
////                                    $("input[name='dfenclosure']").val(enc);
//                                    if ($("[name='organize']").val() == undefined || $("[name='organize']").val() == "") {
//                                        alert("请填写办理期限");
//                                        $("[name='organize']").focus();
//                                        return false;
//                                    }
//                               
//                                    if ($("[name='BanFuName']").val() == undefined || $("[name='BanFuName']").val() == "") {
//                                        alert("请填写办理人");
//                                         $("[name='BanFuName']").focus();
//                                          return false;
//                                    }
//                                    if ($("[name='comments']").val() == undefined || $("[name='comments']").val() == "") {
//                                        alert("请填写办理说明");
//                                        $("[name='comments']").focus();
//                                        return false;
//                                    }
//                                 }                                                              
                                var timestamp = Date.parse(new Date());
                                console.log(timestamp / 1000);
                                $('[name=ResponseTime]').val(timestamp / 1000);
                                if ($("[name='organize']").val() != "" && $("[name='organize']").val() != undefined) {
                                    var timestamp = new Date($("[name='organize']").val());
                                    $("[name='organize']").val(timestamp / 1000);
                                }
                            //面商时间    
                            var discusstimestamp = Date.parse(new Date());
                            console.log(discusstimestamp / 1000);
                            $('[name=discussinspecttime]').val(discusstimestamp / 1000);
                            console.log($("[name='discussinspecttime']").val())
                            var discusstimestamp = new Date($("[name='discusstimestamp']").val());
                            $("[name='discusstimestamp']").val(discusstimestamp / 1000);
                            //end    
                            })
                            $(".cellbor").click(function () {
                                $("#dblist").hide();
                            })
                            //zyx 面商上传附件
                            $("#fjfile1").click(function () {
                                $("#filee1").click();
                            })
                           // ms  end
                            // zyx 答复附件
                            $("#fjfile2").click(function () {
                                $("#filee2").click();
                            })
                            // df  end
                            
                            //  面商
                            $("#filee1").change(function () {
                            var str = $(this).val(); //开始获取文件名
                            var filename = str.substring(str.lastIndexOf("\\") + 1);
                            $("#fileeform1").ajaxSubmit({
                                url: "/widget/upload.jsp?",
                                type: "post",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                            if(data.url !== null && "" !== data.url){

                                    $("#fjfile1").text(filename)
                                    $("input[name='discussenclosure']").val(data.url);
                                    $("input[name='discussenclosurename']").val(filename);              
                                    //alert("上传成功");
                                    }
                                    else{
                                    $("#fjfile1").text("点击选择文件")
                                    alert("未上传")
                                }

                                }});
                            return false;
                        })
// 面商  end
 
//答复附件上传
                        $("#filee2").change(function () {
                            var str = $(this).val(); //开始获取文件名
                            var filename = str.substring(str.lastIndexOf("\\") + 1);
                            $("#fileeform2").ajaxSubmit({
                                url: "/widget/upload.jsp?",
                                type: "post",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                            if(data.url !== null && "" !== data.url){

                                    $("#fjfile2").text(filename)
                                    $("input[name='dfenclosure']").val(data.url);
                                    $("input[name='dfenclosurename']").val(filename);
                                    //alert("上传成功");
                                    }
                                    else{
                                    $("#fjfile2").text("点击选择文件")
                                    alert("未上传")
                                }

                                }});
                            return false;
                        })
 //答复  end                                
        </script>
    </body>
</html>
