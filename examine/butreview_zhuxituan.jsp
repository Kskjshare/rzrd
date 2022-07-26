<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="cn.jpush.api.push.model.Message"%>
<%@page import="cn.jiguang.common.ServiceHelper"%>
<%@page import="cn.jpush.api.push.model.Options"%>
<%@page import="cn.jpush.api.push.model.notification.Notification"%>
<%@page import="cn.jpush.api.push.model.audience.Audience"%>
<%@page import="cn.jpush.api.push.model.Platform"%>
<%@page import="cn.jpush.api.push.model.PushPayload"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cn.jpush.api.JPushClient"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.Date"%>
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
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>


<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLDecoder"%>

<%
   
  //增加闭会 开会 条件过滤 
   String meetingTime="0";
   
   try {
       String propertiesFileName = this.getClass().getResource("/flowtype.properties").getPath();
       Properties properties = new Properties();
       InputStream is = new FileInputStream(propertiesFileName);
       properties.load(is);
       is.close();
       meetingTime = properties.get("meetingtime").toString();
   } catch (Exception e) {
       e.printStackTrace();
   }
    
    
    StaffList.IsLogin(request, response);
    //推送接口
    JPushClient jpushClient = new JPushClient("0462731b97b63172720421c5", "66c3aba5754290cd2d80ab78");
    //创建推送的人员范围
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    CookieHelper cookies = new CookieHelper(request, response);
    // zyx 增加审查分类表
    RssList entity2 = new RssList(pageContext, "companytypee_classify");
    HttpRequestHelper req1 = new HttpRequestHelper(pageContext).request();
    //zyx 增加结束
    RssList senduser = new RssList(pageContext, "userDeviceid");
    RssList duser = new RssList(pageContext, "secondeduser");
    RssList list = new RssList(pageContext, "suggest");
    RssList sort = new RssList(pageContext, "sort");
    RssListView entity1 = new RssListView(pageContext, "sort");
    RssList user = new RssList(pageContext, "user");
    RssListView entity = new RssListView(pageContext, "sort");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    list.request();
    user.request();
    entity.request();
    user.select().where("myid=?", cookies.Get("myid")).get_first_rows();
    String urlid = list.get("id");
    if (!list.get("action").isEmpty()) {
        
        if ( list.get("action").equals("disagree")) { //代表团不同意的时候，把议案当作建议处理
           //out.print("<script>alert('disagree')</script>");
            entity1.select().where("id=?", entity.get("id")).get_first_rows();
            if ( entity1.get("lwstate").equals("2")) { //如果是议案
                //out.print("<script>alert('22222')</script>");
                list.keyvalue("lwstate", 1 );
                //当作建议处理，需要回复初始化状态
                list.keyvalue("workflow", 0 );
//                zyx 添加，原因议案不同意后，还是作为议案的分类，给改为建议的分类，才可以进行确认单位和交办
                 sort.keyvalue("type", 1 );
                 list.keyvalue("level", 1 );
//                 zyx 增加结束
                list.keyvalue("examination", 1 );
                list.keyvalue("handlestate", 1 );

                list.remove("realid");
                list.remove("myid");
                list.remove("realcompanyid");
                list.update().where("id=" + req.get("id") + "").submit();
                PoPupHelper.adapter(out).iframereload();
                PoPupHelper.adapter(out).showSucceed();
                return ;
            }
             
        }
       
        
        list.remove("id");
        list.remove("realid");
        list.remove("myid");
        //list.remove("realcompanyid"); //ding removed it
        list.remove("zhTime");
        if (cookies.Get("powergroupid").equals("25")) {//如果是乡镇政府办
            Map<String, String> map = new HashMap<String, String>();
            if (list.get("reviewopinion").equals("2")) {
                list.keyvalue("examination", 3);
                list.keyvalue("zhName", user.get("realname"));
                list.keyvalue("zhTime", list.get("zhTime"));
            } else {
                list.keyvalue("examination", 2);
                list.keyvalue("isxzsc", 1);
            }
           
            //乡镇主席团 汝州议案特殊流程
            list.keyvalue("workflow", 3 ); //为了汝州新需求增加处理。议审委处理过
            list.keyvalue("deal", 1 ); 
            list.keyvalue("handlestate", 3 ); 
            //乡镇主席团 汝州议案特殊流程
             
             
             
//            list.keyvalue("isdbtshenhe", 1);
//            list.keyvalue("xzscID", UserList.MyID(request));
            usercomp.delete().where("suggestid=" + list.get("id") + " and type = 2").submit();
            if (!list.get("realcompanyid").equals(",")) {
                String[] bb = list.get("realcompanyid").split(",");
                for (int i = 0; i < bb.length; i++) {
                    if (!bb[i].isEmpty()) {
                        usercomp.keyvalue("suggestid", list.get("id"));
                        usercomp.keyvalue("companyid", bb[i]);
                        usercomp.keyvalue("type", 2);
                        usercomp.append().submit();
                    }
                }
            }
            list.update().where("id=" + req.get("id") + "").submit();

            //推送人员
            duser.pagesize = 10000000;
            duser.select().where("suggestid=?", entity.get("id")).get_page_desc("id");
            entity1.select().where("id=?", entity.get("id")).get_first_rows();
            String type = "";

            
             if (entity1.get("lwstate").equals("1")) {
                type = "建议";
                map.put("key", "2");
            } 
             else if( entity1.get("lwstate").equals("2") ){
                type = "议案";
                map.put("key", "3");
            }
             else if( entity1.get("lwstate").equals("3")){
                type = "批评";
                map.put("key", "4");
            }
             else if( entity1.get("lwstate").equals("4") ){
                type = "意见";
                map.put("key", "5");
            }
              else if( entity1.get("lwstate").equals("5") ){
                type = "质询";
                map.put("key", "6");
            };
            while (duser.for_in_rows()) {
                if (!(duser.get("userid").isEmpty())) {
                    senduser.pagesize = 10000000;
                    senduser.select().where("state=1 and myid=?", duser.get("userid")).get_page_desc("id");
                    String bt = entity1.get("title");
                    while (senduser.for_in_rows()) {
                        if (!(senduser.get("deviceid").isEmpty())) {
                            jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 乡镇政府办 审查！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条被审查" + type + "")).build());
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
                        jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 乡镇政府办 审查！《" + bt + "》", "审查通知", map)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条被审查的" + type + "")).build());
                    }
                }
            }
        } 
        else if (!(cookies.Get("powergroupid").equals("7") || cookies.Get("powergroupid").equals("8"))) {//如果不是乡镇政府办和人代委（比如说代表团）
         
            //out.print("<script>alert('3333')</script>");
            Map<String, String> map1 = new HashMap<String, String>();
            list.remove("handlestate");
            if (list.get("reviewopinion").equals("2")) {
                list.keyvalue("zhName", user.get("linkman"));
                list.keyvalue("examination", 3);
                list.keyvalue("zhTime", list.get("zhTime"));
            } else {
                list.keyvalue("examination", 5);
                //开会乡镇流程代表团审核以后examination状态有误，added by ding 2021.4.11
                 list.keyvalue("examination", 2);
                 
                list.keyvalue("iscs", 1);
            }
            list.keyvalue("isdbtshenhe", 1);
            
            list.keyvalue("workflow", 1 ); //为了汝州新需求增加处理。代表团处理过
            
              list.keyvalue("isysw", 21);
             //开会期间，议审委账号登录能看到被置回的记录。在这个地方，代表团不同意的时候，改变isysw的状态值。
            if (list.get("reviewopinion").equals("2")) {
                if ( meetingTime.equals("1")  && cookies.Get("powergroupid").equals("22") ) {
                    list.keyvalue("isysw", 0);
                }
            }
             
        
           
            
            list.keyvalue("scid", UserList.MyID(request));
            list.update().where("id=" + req.get("id") + "").submit();
            duser.pagesize = 10000000;
            duser.select().where("suggestid=?", entity.get("id")).get_page_desc("id");
            entity1.select().where("id=?", entity.get("id")).get_first_rows();
            String type = "";

            
            if (entity1.get("lwstate").equals("1")) {
                type = "建议";
                map1.put("key", "2");
            } 
             else if( entity1.get("lwstate").equals("2") ){
                type = "议案";
                map1.put("key", "3");
            }
             else if( entity1.get("lwstate").equals("3")){
                type = "批评";
                map1.put("key", "4");
            }
             else if( entity1.get("lwstate").equals("4") ){
                type = "意见";
                map1.put("key", "5");
            }
              else if( entity1.get("lwstate").equals("5") ){
                type = "质询";
                map1.put("key", "6");
            };
            
            while (duser.for_in_rows()) {
                if (!(duser.get("userid").isEmpty())) {
                    senduser.pagesize = 10000000;
                    senduser.select().where("state=1 and myid=?", duser.get("userid")).get_page_desc("id");
                    String bt = entity1.get("title");
                    while (senduser.for_in_rows()) {
                        if (!(senduser.get("deviceid").isEmpty())) {
                            jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 代表团 审查！《" + bt + "》", "审查通知", map1)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条被审查的" + type + "")).build());
                        }
                    }
                }
            }
            if (!(entity1.get("myid").isEmpty())) {
                senduser.pagesize = 10000000;
                senduser.select().where("state=1 and myid=?", entity.get("myid")).get_page_desc("id");
                //out.print("<script>alert('hello');</script>");//jackie debug
                System.out.println("myid==" + entity1.get("myid"));//jackie debug
                String bt = entity1.get("title");
                while (senduser.for_in_rows()) {
                    System.out.println("deviceid==" + senduser.get("deviceid"));//jackie debug
                    if (!(senduser.get("deviceid").isEmpty())) {
                        jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 代表团 审查！《" + bt + "》", "审查通知", map1)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条被审查的" + type + "")).build());
                        //commented by jackie
                    }
                }
            }
        } else {//当前用户是7或8 
            //out.print("<script>alert('4444')</script>");
            Map<String, String> map2 = new HashMap<String, String>();
            if (list.get("reviewopinion").equals("2")) {
                list.keyvalue("zhName", list.get("realname"));
                list.keyvalue("examination", 3);
                list.keyvalue("zhTime", list.get("zhTime"));
            } else {
                list.keyvalue("examination", 2);
                list.keyvalue("iscs", 1);
            }
            
             list.keyvalue("workflow", 2 ); //为了汝州新需求增加处理。议审委处理过
           
            
            //如果是闭会期间市级代表
            if ( meetingTime.equals("0")) {
                if ( cookies.Get("powergroupid").equals("7") ) {                  
                list.keyvalue("isxzsc", 0);
                list.keyvalue("iscs", 0);
                list.keyvalue("examination", 2);
                if (list.get("reviewopinion").equals("2")) {
                    list.keyvalue("examination", 3);
                }
                }
                
            }
            else {
                
            }
            
            // list.keyvalue("handlestate", 2);
            
          
            
            usercomp.delete().where("suggestid=" + list.get("id") + " and type=2").submit();
            if (!list.get("realcompanyid").equals(",")) {
                String[] bb = list.get("realcompanyid").split(",");
                for (int i = 0; i < bb.length; i++) {
                    if (!bb[i].isEmpty()) {
                        usercomp.keyvalue("suggestid", list.get("id"));
                        usercomp.keyvalue("companyid", bb[i]);
                        usercomp.keyvalue("type", 2);
                        usercomp.append().submit();
                    }
                }
            }
            long shijian = new Date().getTime() / 1000;
            list.keyvalue("scshijian", String.valueOf(shijian));
            list.update().where("id=?", entity.get("id")).submit();
            duser.pagesize = 10000000;
            duser.select().where("suggestid=?", entity.get("id")).get_page_desc("id");
            entity1.select().where("id=?", entity.get("id")).get_first_rows();
            String type = "";
 
                if (entity1.get("lwstate").equals("1")) {
                type = "建议";
                map2.put("key", "2");
            } 
             else if( entity1.get("lwstate").equals("2") ){
                type = "议案";
                map2.put("key", "3");
            }
             else if( entity1.get("lwstate").equals("3")){
                type = "批评";
                map2.put("key", "4");
            }
             else if( entity1.get("lwstate").equals("4") ){
                type = "意见";
                map2.put("key", "5");
            }
              else if( entity1.get("lwstate").equals("5") ){
                type = "质询";
                map2.put("key", "6");
            };
            
            
            
            while (duser.for_in_rows()) {
                if (!(duser.get("userid").isEmpty())) {
                    senduser.pagesize = 10000000;
                    senduser.select().where("state=1 and myid=?", duser.get("userid")).get_page_desc("id");
                    String bt = entity1.get("title");
                    while (senduser.for_in_rows()) {
                        if (!(senduser.get("deviceid").isEmpty())) {
                            jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 选联委 审查！《" + bt + "》", "审查通知", map2)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条被审查的" + type + "")).build());
                        }
                    }
                }
            }
            if (!(entity1.get("myid").isEmpty())) {
                senduser.pagesize = 10000000;
                senduser.select().where("state=1 and myid=?", entity.get("myid")).get_page_desc("id");
                String bt = entity1.get("title");
                while (senduser.for_in_rows()) {
                    if (!(senduser.get("deviceid").isEmpty())) {
                        jpushClient.sendPush(PushPayload.newBuilder().setPlatform(Platform.android()).setAudience(Audience.registrationId(senduser.get("deviceid"))).setNotification(Notification.android("您有一条" + type + "已被 选联委 审查！《" + bt + "》", "审查通知", map2)).setOptions(Options.newBuilder().setApnsProduction(false).setSendno(ServiceHelper.generateSendno()).setTimeToLive(86400).build()).setMessage(Message.content("您收到一条被审查的" + type + "")).build());
                    }
                }
            }
        }
        lzmessage.keyvalue("realid", entity.get("id"));
        if (list.get("reviewopinion").equals("2")) {
            lzmessage.keyvalue("classify", 11);
            lzmessage.delete().where("classify=7 and realid=?", entity.get("id")).submit();
        } else {
            if (cookies.Get("powergroupid").equals("25")) {
                lzmessage.keyvalue("classify", 14);
                lzmessage.delete().where("classify=7 and realid=?", entity.get("id")).submit();
            } else if (!(cookies.Get("powergroupid").equals("8"))) {
                lzmessage.keyvalue("classify", 15);
                lzmessage.delete().where("realid=?", entity.get("id")).submit();
            } else {
                lzmessage.keyvalue("classify", 8);
            }

        }
        lzmessage.timestamp();;
        lzmessage.append().submit();
        String[] arr = {"8", "16"};
        if (list.get("reviewopinion").equals("2")) {
            read.keyvalue("messageid", lzmessage.autoid);
            if (cookies.Get("powergroupid").equals("22")) {
                read.keyvalue("objid", list.get("myid"));
            }
            read.keyvalue("type", 1);
            read.append().submit();
        } else {
//        String[] bb = entity.get("tcr").split(",");
            if (cookies.Get("powergroupid").equals("22")) {
                read.keyvalue("messageid", lzmessage.autoid);
                if (cookies.Get("powergroupid").equals("22")) {
                    read.keyvalue("objid", list.get("fsrID"));
                }
                read.keyvalue("type", 1);
                read.append().submit();
                
          
                
            }
            for (int idx = 0; idx < arr.length; idx++) {
                read.keyvalue("messageid", lzmessage.autoid);
                read.keyvalue("groupid", arr[idx]);
                read.keyvalue("type", 1);
                read.append().submit();
            }
        }
        if (!(list.get("realid").isEmpty())) {
            sort.keyvalue("realid", list.get("realid"));
            sort.update().where("sortid=?", entity.get("id")).submit();
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
            tr>td .xzz{width: 70%;height: 100%;border: 0px;}
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin;}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            #smalltab{width: 100%;line-height: 26px;text-align: center;cursor: default}
            #smalltab .tdleft{text-align: left;}
            #smalltab span{color: #186aa3;margin: 0 10px;font-weight:bold;}
            .h210{height: 210px}
            .sel{background:#dce6f5; }
            .cellbor .vertop{vertical-align: top;padding-top: 5px;}
            .disnone{display: none}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .butreturn{border: 1px yellow solid;border-radius: 28%;padding: 3px;font-size: x-small;background-color: darkgray;}
            .scyj em{margin-left: 10%}
            .scsm input{width: 99%;border: 0px;};
            .fsry .selectscr{cursor: pointer}
            .fsry .selectscra{cursor: pointer;}
            .red{
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp120 cellbor">
	<!--
                    <tr><td class="w120 dce">序号</td><td class="w261"><% entity.write("lwid"); %></td><td class="w120 dce">层次</td><td class="w261"  circles="<% entity.write("level"); %>"></td></tr>
                    <tr><td class="w120 dce">届次</td><td colspan="3" sessionclassify="<% entity.write("sessionid"); %>"></td></tr>
                    <tr><td class="w120 dce">会议次数</td><td colspan="3" companytypeeeclassify="<% entity.write("meetingnum"); %>"></td></tr>
	   -->

 	

                    <tr>
		<td class="w120 dce">
			<%
			//建议编号  
  			entity1.select().where("id=?", entity.get("id")).get_first_rows();
 			if (entity1.get("lwstate").equals("1")) {
               			out.print("编号");
            			} else {
               			
         			out.print("编号");
           			 };
 			 %>
	                </td>

	    <td class="w261">
                            <%
                                if (cookies.Get("powergroupid").equals("8")) {
                            %>
                            <input name="realid" class="yincang" type="text" value="<% entity.write("realid"); %>" >
                            <%
                            } else {
                            %>
                            <% out.print(entity.get("realid")); %>
                            <%
                                }
                            %>
                        </td><td class="w120 dce">类型</td><td class="w261" lwstate="<% 
                                                      
                            if (entity1.get("lwstate").equals("1")) {
                                      
                                      out.print("建议");
                                   } 
                                    else if( entity1.get("lwstate").equals("2") ){
                                      
                                         out.print("议案");
                                   }
                                    else if( entity1.get("lwstate").equals("3")){
                                     
                                        out.print("批评");
                                   }
                                    else if( entity1.get("lwstate").equals("4") ){
                                       
                                         out.print("意见");
                                   }
                                     else if( entity1.get("lwstate").equals("5") ){
                                       
                                          out.print("质询");
                                   };


                        %>"></td></tr>
                        <tr>
                        <td class="w120 dce">标题</td>
                        
                        <td colspan="3">
                            <!--zyx  注销，注销原因审查的标题不可修改，所以不能用input标签，直接显示即可 -->
                            <!--<input style="width:99%;" name="title" type="text" value="<% entity.write("title"); %>" > -->
                            <% entity.write("title"); %>
                            <!--zyx 修改结束 -->
                        </td>
                        </tr>
                    
                        <tr>
                            <td class="w120 dce">内容</td>
                            

                            <td colspan="3"><% entity.write("matter"); %></td>
                        </tr>

                    <tr><td class="w120 dce">领衔代表</td><td colspan="3"><% entity.write("realname"); %></td></tr>

	<!-- 增加联名人信息--->
	   <tr>
		<td class="w120 dce" style="width:200px;">附议代表</td>
		<td colspan="3">
		
 		<%
                                                if (!entity.get("id").isEmpty()) {
                                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                                            while (secondlist.for_in_rows()) {
                                                    %>
                                                        <% entity.write(secondlist.get("realname"));%>
			    <% out.print(secondlist.get("realname"));%>
			    <% out.print("    ");%>
                                                            <%
                                                                    }
                                                                }
                                %>
		</td>
	</tr>


                    <tr>
		<td class="w120 dce">
		 附件
		</td>
	<td colspan="3" style="font-weight:bold;">
                            <%
                                RssList user1 = new RssList(pageContext, "suggest");
                                user1.select().where("id=?", entity.get("id")).get_first_rows();
                                String[] arry1 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str = entity.get("enclosure").split(",");
                                    for (int idx = 0; idx < str.length; idx++) {
                                        arry1[idx] = str[idx];
                            %>
                            <%  user1.write("enclosurename"); %>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color:blue;font-weight: bold;">点击下载</a>
                            <!--zyx添加，查看页面显示附件文件名称。-->
                            <%
                                    }
                                }
                            %>
                    </tr>
                    <tr>
	            <td colspan="4" id="tabheader">
		              
			<%
			//建议审查  
			entity1.select().where("id=?", entity.get("id")).get_first_rows();
 			
                          if (entity1.get("lwstate").equals("1")) {
                                      
                                      out.print("建议审查");
                                   } 
                                    else if( entity1.get("lwstate").equals("2") ){
                                      
                                         out.print("议案表决");
                                   }
                                    else if( entity1.get("lwstate").equals("3")){
                                     
                                        out.print("批评审查");
                                   }
                                    else if( entity1.get("lwstate").equals("4") ){
                                       
                                         out.print("意见审查");
                                   }
                                     else if( entity1.get("lwstate").equals("5") ){
                                       
                                          out.print("质询审查");
                                   };         



 			 %>
	            </td>
	    </tr>
                    <tr  style="display: none;"><td class="w120 dce">建议承办单位</td><td colspan="3" id="sugcompany">
                            <%
                                if (!entity.get("id").isEmpty()) {
                                    RssListView usercomplist = new RssListView(pageContext, "suggest_company");
                                    usercomplist.select().where("suggestid=" + entity.get("id") + " and type is null").query();
                                    while (usercomplist.for_in_rows()) {
                            %>
                            <b>"<% out.print(usercomplist.get("allname"));%>"</b>
                            <%
                                    }
                                }
                            %>
                        </td></tr>
                    <tr>
                        <td class="w120 dce">类别</td>
                        <td colspan="3">
                        <select style="width:200px;font-size:16px" value="<% entity2.write("name"); %>" name="reviewclass" companytypeeclassify="<% entity.write("reviewclass"); %>">
                       <!-- zyx  增加companytypeeclassify="<% entity.write("reviewclass"); %>"用于审查分类默认显示的值   -->      
                                <%
                                    entity2.select().where("name like '%" + 
                                    URLDecoder.decode(req1.get("name"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                    int a=1;
                                         while (entity2.for_in_rows()) {
                                %>
                                <option><% entity2.write("name"); %></option>
                                <%
                                   a++;
                                }
                                %>
                            </select>
<!--                            zyx修改，解决议案建议审查分类默认为空的bug -->
                        </td>
                    </tr>
                    <tr>
                    <tr style="display: none;"><td>审查单位</td>
                        <% RssListView user11 = new RssListView(pageContext, "user_delegation");
                            user11.request();
                            if (entity.get("id").isEmpty()) {
                                user11.select().where("myid=" + cookies.Get("myid")).get_first_rows();
                            } else {
                                user11.select().where("myid=" + entity.get("myid")).get_first_rows();
                            }
                        %>
                        <td colspan="5">
                            <input class="yincang" id="scrid" type="text" myid="<% user11.write("mission"); %>" value="<% user11.write("linkmanmission"); %>" >
                        </td>
                    </tr>
                    <td class="w120 dce">人大主席团表决</td><td colspan="3" class="scyj">
                        <input id="tongyi" name="reviewopinion" checked="checked" type="radio" value="1">通过<em></em>
                        <input name="reviewopinion" type="radio" value="2">不通过</td>
                    </tr>
                    <tr class="yjsm" style="display: none;">
                        <td  class="w120 dce">意见说明<em class="red">*</em></td><td colspan="3" class="scsm">
                            <textarea id="textarea" style="height:60px;width:99%;" placeholder="（如果不同意提交，请这里说明理由作为置回的原由）" type="text" name="buyBack"></textarea></td>
                        <!--张迎新修改-->
                    </tr>
                    <%
                        if (!(entity.get("level").equals("0"))) {
                    %>

                    <%
                        }
                    %>
                    <%
                        //如果是代表团和乡镇政府办和议审委      Wel_D：代码实际为：如果不是以上三个角色 20/12/11：条件中删去了乡镇政府办
                        if (!(cookies.Get("powergroupid").equals("22"))) {
                    %>
                    <tr class="h210 cb">

                        <%
                            if (cookies.Get("powergroupid").equals("7") || cookies.Get("powergroupid").equals("8")) {//8：人代委用户
                        %>
                        <td class="w120 dce flog">拟主办单位</td>
                        <%
                        } else {
                        %>
                        <!-- 梁小竹添加class flog,用来在js中判断承办单位是否有此选项,代码改了这个东西没有使用 -->
                        <td class="w120 dce flog">主办单位</td>
                        <%
                            }
                        %>
                        <td colspan="6" class="vertop">
                            <table id="smalltab" align="center">
                                <tr>
                                    <td colspan="6" class="tdleft">
                                        <span tradd>增加</span>
                                        <span trdel>删除</span>
                                        <input class="disnone" name="realcompanyid">
                                        <input class="disnone" name="realcompanyname">
                                    </td>
                                </tr>
                                <tr >
                                    <td ><input type="checkbox" id="checkboxall"></td>
                                    <!--
                                    <td>单位编号</td>
                                    
                                    <td>单位类别</td>
                                    --->
                                    <td colspan="6">单位名称</td>
                                    <td></td>
                                </tr>
                                        <%
                                            RssListView companylist = new RssListView(pageContext, "suggest_company");
                                            companylist.select().where("suggestid in (" + entity.get("id") + ") and type is null").get_page_desc("suggestid");
                                            int nuu = 1;
                                            while (companylist.for_in_rows()) {
                                        %>
                                <tr  class="sellist" allname="<% out.print(companylist.get("allname"));%>">
                                    <td><input type="checkbox" class="checksel"></td>
                                   
                                    <td colspan="6"><% out.print(companylist.get("allname"));%></td>
                                   
                                </tr>
                                        <%
                                            }
                                        %>
                            </table>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td class="w120 dce">审查单位</td><td colspan="3">
                             <%
                         
                          if (meetingTime.equals("0")) {
                              //闭会流程
                            if ((entity.get("level").equals("0"))) { //乡镇代表
                                out.print("乡镇人大主席团");
                            }
                            else{
                                out.print(UserList.RealName(request));
                            }
                          }
                          else {
                              //开会流程
                              if ( cookies.Get("powergroupid").equals("7") ){
                                  out.print("选联委");
                              }
                              else if ( cookies.Get("powergroupid").equals("8") ){
                                   out.print("议审委");
                              }
                              else if ( cookies.Get("powergroupid").equals("23") ){
                                   out.print("督察局");
                              }
                              else
                              out.print("代表团");
                          }
                             %>
                            <!--% out.print(UserList.RealName(request));%-->
                        </td>
                    </tr>
                        <%
                            CookieHelper cookie = new CookieHelper(request, response);
                            if (!(cookie.Get("powergroupid").equals("7") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("25"))) {//NOT 8:人代委   或  25:乡镇政府办
                        %>
                    <tr  class="fsry">
                        <%
                            if (!(entity.get("level").equals("0"))) {
                        %>
                        <td class="w120 dce">复审单位</td>
                        <%
                        } else {
                        %>
                        <td class="w120 dce">复审单位</td>
                        <%
                            }
                        %>
                        <td colspan="3">议审委
                            
       
                            <!-- 汝州项目删除复审人的选择，直接显示复审人-->
                            <ul id="jyscr">
                                <%
                                    if (!entity.get("id").isEmpty()) {
                                        list.select().where("id=? ", urlid).get_first_rows();
                                        RssListView secondlist = new RssListView(pageContext, "scr_suggest");
//                                       secondlist.select().where("id="+list.get("id")+" and fsrID="+list.get("")+" ").get_page_desc("myid");
                                        secondlist.select().where("id=? and fsrID=?", urlid, list.get("fsrID")).get_page_desc("myid");
                                        while (secondlist.for_in_rows()) {
                                %>
                                <!--
                               <li myid='<% out.print(secondlist.get("fsrID"));%>'><% out.print(secondlist.get("Fsrrealname"));%><em class='red'> 删除 </em></li>
                                -->

                                <%
                                        }
                                    }
                                %>
                            </ul>
 
                        </td>
                            
                           <!-- 汝州项目删除复审人的选择，直接显示复审人-->
                        <!--td colspan="3">
                            <%
                                if (!(entity.get("level").equals("0"))) {
                            %>
                            <b class="selectscr" style="cursor: pointer;color: blue;">添加复审人</b>
                            <%
                            } else {
                            %>
                            <b class="selectscr"  style="cursor: pointer;color: blue;">添加复审人</b>
                            <%
                                }
                            %></td-->
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="update" />
                <%--                <span type="button" class="butreturn">不提交</span>--%>
                <button type="submit" class="sub">确定</button>
                <%
                    if (cookie.Get("powergroupid").equals("8")) {//人代委
                %>
                <input name="ReviewTime" type="hidden">
                <%
                } else if (cookie.Get("powergroupid").equals("25")) {//政府办
                %>
                <input name="xzReviewTime" type="hidden">
                <%
                } else {//其他
                %>
                <input name="InitialReviewTime" type="hidden">
                <%
                    }
                %>
                <input name="zhTime" type="hidden">
                <input type="hidden" name="handlestate">
                <input type="hidden" name="myid" value="<% out.print(list.get("myid"));%>">
                <!--<input type="hidden" name="myid" value="<% %>">-->
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <script>
//            var aa =<% out.print(entity.get("id"));%>;
//            console.log(aa);
            $('input[name="reviewopinion"]').click(function () {
                //alert($(this).val());
                if ($(this).val() == 2) {
                    $(".fsry").hide();
                    $(".yjsm").show();
                    $(".cb").hide();
                    
                    $("input[name='action']").val("disagree");//ding
                    //alert( $(this).val() ) ;
                } else {
                    $(".fsry").show();
                    $(".yjsm").hide();
                    $(".cb").show();
                    
                    $("input[name='action']").val("submit");//ding
                    //alert( $(this).val() ) ;
                }
            });
            $('.butreturn').click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                    })
                }
                location.href = "/selectwin/return.jsp?id=<% out.print(entity.get("id"));%>";
//                RssWin.open("/selectwin/return.jsp?id=<% out.print(entity.get("id"));%>", 400, 500);
            });

            $('.selectscr').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'> 删除 </em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_1.jsp", 700, 650);
            });
            $('.selectscra').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'> 删除 </em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_1_1.jsp", 700, 650);
            });

            //增加
            $('[tradd]').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("tr[realid='" + v.myid + "']").length == "0") {
                        $("#smalltab tbody").append('<tr  class="sellist" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td>' + '<td colspan="6" class="tdleft">' + v.realname + '</td>'+ '</tr>')

                        //$("#smalltab tbody").append('<tr class="sellist" allname="' + v.realname + '" realid="' + v.myid + '"><td><input type="checkbox" class="checksel"></td><td>' + v.code + '</td><td class="tdleft">' + v.realname + '</td><td class="tdleft">' + v.comtype + '</td><td></td></tr>')
                        }
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 500, 600);
            });
            //删除
            $("[trdel]").click(function () {
                $("#smalltab .sellist").find("input:checked").parent().parent().remove();
            })
            //全选
            $("#checkboxall").change(function () {
                if ($(this).is(":checked")) {
                    $(".checksel").each(function () {
                        $(this).prop("checked", true)
                    })
                } else {
                    $(".checksel").each(function () {
                        $(this).prop("checked", false)
                    })
                }
            })

            $(".footer>.sub").click(function () {
                //梁小竹修改
                if($("#tongyi").is(":checked")){
                    if($(".flog").length > 0){
                        if($(".sellist").length <= 0){
                            alert("请选择承办单位！");
                            return false;
                        }
                    }
                }
//                }else{
//                    alert("不存在");
//                }
            <%
                if (!(cookie.Get("powergroupid").equals("7") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("25"))) {
            %>
//                console.log($("#jyscr>li").length + "!!!");
//zyx
        var value = $('input:radio[name="reviewopinion"]:checked').val();
        if (value == "2") {
                if ($("#textarea").val()=="") {
                    alert("请填写不同意的原因！");
                    return false;
                }
            };
//                zyx end
            <%}%>
                var value = $('input:radio[name="reviewopinion"]:checked').val();
                var timestamp = Date.parse(new Date());
                $('[name=ReviewTime]').val(timestamp / 1000);
                $('[name=zhTime]').val(timestamp / 1000);
                $('[name=xzReviewTime]').val(timestamp / 1000);
                $('[name=InitialReviewTime]').val(timestamp / 1000);
                if ($("#sugcompany").find("b").length == "0") {
                    $("input[name='handlestate']").val("1")
                } else {
                    $("input[name='handlestate']").val("2")
                }
                var realcompanyid = [], realcompanyname = [];
                $(".sellist").each(function () {
                    realcompanyid.push($(this).attr("realid"));
                    realcompanyname.push($(this).attr("allname"))
                })
                realcompanyid = jQuery.unique(realcompanyid)
                //alert("realcompanyid"+realcompanyid);
                realcompanyname = jQuery.unique(realcompanyname)
                //alert("realcompanyname"+realcompanyname);
                var realcompany = realcompanyid.join(",")
                var realcompanyname = realcompanyname.join(",")
//                $("input[name='realcompanyid']").val("," + realcompany)
                // alert("value::"+value);//jackie调试
                if (value == "2") {
                    $("input[name='realcompanyname']").val("无");
                } else {
                    $("input[name='realcompanyname']").val(realcompanyname)
                    $("input[name='realcompanyid']").val(realcompanyid)
                }
                //    alert("realcompanyname.length::"+realcompanyname.length);//jackie调试
                if (realcompanyname.length != 0) {
                    $("input[name='handlestate']").val("2")
                }
            })
            function tabsel() {
                $(".sellist").off("click").click(function () {
                    $(this).addClass("sel").siblings().removeClass("sel");
                })
            }
            function alclear() {
                $("#selalert").hide();
                $("#comcode").removeAttr("code")
                $("#selalert input").val("");
                $("#selalert").hide();
                $("#handle").text("");
                $("#comtype").text("");
            }
//            $('.nobutton').click(function () {
//                RssWin.onwinreceivemsg = function (dict) {}
//                RssWin.open("/examine/return.jsp?id=<% out.print(entity.get("id"));%>", 400, 500);
//            }


        </script>
    </body>
</html>
