<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
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

<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String meetingTime = "0";
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
    //up added by jackie 
    StaffList.IsLogin(request, response);
    //zyx 添加
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    //zyx 添加结束
    RssList entity = new RssList(pageContext, "suggest");
    RssList sort = new RssList(pageContext, "sort");
    RssList second = new RssList(pageContext, "secondeduser");
    RssList contacts = new RssList(pageContext, "suggestlxr");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    RssList scr = new RssList(pageContext, "suggestscr");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    CookieHelper cookie = new CookieHelper(request, response);
    sort.pagesize = 100000;
    entity.request();
    
    int canSubmit = 1 ;
    if (!entity.get("action").isEmpty()) {
         //只有代表才可以提交建议议案
        RssList daibiao = new RssList(pageContext, "user");
        daibiao.request();
        daibiao.select().where("myid=" + UserList.MyID(request) ).get_first_rows();
        if ( !daibiao.get("isdelegate").equals("1")){
            canSubmit =  0 ;
        }
if ( canSubmit == 1 ) {
        
        
        entity.remove("scyj", "realid", "perm", "type1", "type2", "type3", "type4", "blfs", "secound", "contacts", "usercomp", "scr");
        entity.remove("id");
        entity.remove("secound");
        if (entity.get("summary").isEmpty()) {
            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 120));
            //entity.keyvalue("summary", entity.get("matter") );

        }

        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }

        if (meetingTime.equals("1")) {
            entity.keyvalue("isysw", "0");//不经过选工委或代表联络科
            //预留空位，此处应为大会期间的其他处理
        } else {
            
            //ding删除下面梁涛改的代码（此代码引起闭会期间，代表提交议案的时候，状态显示错误，但是不知道会不会引起其他问题。
            
//            if ((entity.get("level").equals("0"))) {//0为乡镇，examination设为5；   1为市级，examination设为1（默认为1，不动即可）    注：因乡镇路线无初审流程，故设为5
//                entity.keyvalue("examination", 5);
//                entity.keyvalue("iscs", 1);
//                 entity.keyvalue("isdbtshenhe", 1);  //设为1：即不经过代表团或选工委代表联络科，
//            }
//            entity.keyvalue("isysw", "21");//闭会市镇，经过选工委或代表联络科

            //addded by ding 
           if ((entity.get("level").equals("0"))) {
                entity.keyvalue("isysw", "0");//闭会镇代表不经过选工委或代表联络科
                entity.keyvalue("iscs", 0);//设置未审查
                entity.keyvalue("isdbtshenhe", 2);//不经过代表团
                entity.keyvalue("examination", 1);
           }
           else {
            entity.keyvalue("isysw", "21");//闭会市代表经过选工委或代表联络科
            entity.keyvalue("iscs", 0);//设置未审查
            entity.keyvalue("isdbtshenhe", 2);//不经过代表团
             entity.keyvalue("examination", 1);
           }
            //end
           
        }
        entity.timestamp();
        //梁小竹添加，添加乡镇政府办的id，也就是人大主席团的id
        RssList user1 = new RssList(pageContext, "user");
        user1.select().where("myid = " + cookie.Get("myid")).get_first_rows();
        String presidium = user1.get("presidium");
        entity.keyvalue("xzscID", presidium);
//        System.out.println(presidium + "-+-+-+-+-+-+-+-+");
        //梁小竹添加，添加乡镇政府办的id   结束
        
        //梁小竹添加，原因，标识此建议议案是开会时提出还是闭会时提出，用来判断流程的显示
        entity.keyvalue("ismeet", meetingTime);
        
        entity.append().submit();
        sort.pagesize = 100000000;
        sort.select().where("type=" + entity.get("lwstate")).get_page_desc("realid");;
//        int a = sort.totalrows + 1;
        sort.keyvalue("sortid", entity.autoid);
        sort.keyvalue("type", entity.get("lwstate"));

        //处理编号 开始
        String a = "Y";
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        RssList sequence = new RssList(pageContext, "sort_sequence");
        sequence.select().where("seq_name=" + year).get_first_rows();
        a += year;
        a += sequence.get("yian_val");
        sort.keyvalue("realid", a);
        sequence.keyvalue("yian_val", Integer.valueOf(sequence.get("yian_val")) + 1);
        sequence.update().where("seq_name=" + year).submit();
        //处理编号 结束

        sort.append().submit();
        if (entity.get("draft").equals("2")) {
            lzmessage.keyvalue("realid", entity.autoid);
            lzmessage.keyvalue("classify", 7);
            lzmessage.timestamp();
            lzmessage.append().submit();
        }
        if (!entity.get("secound").equals(",")) {
            String[] bb = entity.get("secound").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    second.keyvalue("suggestid", entity.autoid);
                    second.keyvalue("userid", bb[i]);
                    second.keyvalue("myid", bb[i]);
                    second.append().submit();
                }
            }
        }
        if (!entity.get("scr").equals(",")) {
            String[] bb = entity.get("scr").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    scr.keyvalue("suggestid", entity.autoid);
                    scr.keyvalue("userid", bb[i]);
                    scr.append().submit();
                    if (entity.get("draft").equals("2")) {
                        read.keyvalue("messageid", lzmessage.autoid);
                        read.keyvalue("objid", bb[i]);
                        read.keyvalue("type", 1);
                        read.append().submit();
                    }
                }
            }
        }
        if (!entity.get("contacts").equals(",")) {
            String[] bb = entity.get("contacts").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    contacts.keyvalue("suggestid", entity.autoid);
                    contacts.keyvalue("userid", bb[i]);
                    contacts.append().submit();
                }
            }
        }
        if (!entity.get("usercomp").equals(",")) {
            String[] bb = entity.get("usercomp").split(",");
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    usercomp.keyvalue("suggestid", entity.autoid);
                    usercomp.keyvalue("companyid", bb[i]);
                    usercomp.append().submit();
                }
            }
        }
        
        
        
           //开始把记录写到通知列表notify_messageslist
        RssList notify_messages = new RssList(pageContext, "notify_messages");
        notify_messages.select().where("id=?", notify_messages.get("id")).get_first_rows();
        notify_messages.keyvalue("infotype", 6 );
        notify_messages.keyvalue("lwstate", 3 );
        notify_messages.keyvalue("title", entity.get("title") );
        notify_messages.timestamp();
        notify_messages.keymyid( UserList.MyID(request) );
        notify_messages.keyvalue("relationid", entity.autoid );
        
         if (!entity.get("secound").equals(",")) {
            String[] bb = entity.get("secound").split(",");
            String userid = "";
            for (int i = 0; i < bb.length; i++) {
                if (!bb[i].isEmpty()) {
                    
                    if ( i > 0 ) {
                       userid += ",";
                    }
                    userid += bb[i] ;
   
                }
                 notify_messages.keyvalue("userid",userid );
            }
        }
       // notify_messages.append().submit();///////////////////////////////20220520 删除
        //结束
        
           //添加到newinformation
        RssList entity3 = new RssList(pageContext, "newinformation");
         if ( entity.get("notice").isEmpty()  )
            entity3.keyvalue("title", entity.get("title") );
         else
           entity3.keyvalue("title", entity.get("notice") );  
         
        if ( !entity.get("matter").isEmpty()  )
          {
//            entity3.keyvalue("matter", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 360));
            entity3.keyvalue("matter", entity.get("matter") );

          } 
                entity3.keyvalue("realname",user1.get("realname"));

        entity3.keyvalue("infotype",  1 );
        entity3.keyvalue("myid", UserList.MyID(request));
        entity3.timestamp();
       // entity3.append().submit();///////////////////////////////20220520 删除
        //结束
        
        out.print("<script>alert('操作成功！');</script>");
}
else{
     out.print("<script>alert('你没有提交权限！');</script>");
}
//        PoPupHelper.adapter(out).iframereload();
//        PoPupHelper.adapter(out).showSucceed();
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px;font-size: 12px;}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 770px}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
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
            .w99{width: 99%;}
            #suggesttype{
                font-size: 16px;
                font-family: 微软雅黑;
            }
            .w98{width: 97%;}
            .meetingtime{color: red}
            
            /**/
            .zhicheng{
                height: 50px;
            }
            .selectscr22{
                color: blue;
            }
        </style>
    </head>
    <body>
        <form id="fileeform1" class="fileeform"enctype="multipart/form-data" method="post">
            <input type="file" id="file1" ridform="1" accept=".pdf"  name="file1" multiple>
        </form>
        <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form id="fileeform3" class="fileeform" ridform="3" enctype="multipart/form-data" method="post">
            <input type="file" id="file3" ridform="3"  name="file3" multiple>
        </form>
        <form method="post" class="popupwrap"> 

            <div>
<!--                <div id="suggesttype">类&nbsp;&nbsp;别：<select style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                        <option value="3" style="font-size:16px;font-family: 微软雅黑">批评</option>
                        <option value="1" style="font-size:16px;font-family: 微软雅黑">建议</option>
                        <option value="2" style="font-size:16px;font-family: 微软雅黑">议案</option>
                        <option value="4" style="font-size:16px;font-family: 微软雅黑">意见</option>
                        <option value="5" style="font-size:16px;font-family: 微软雅黑">质询</option>
                    </select>
                </div>
-->
                <div id="suggesttype" style="display: none;"><span class="meetingtime" meetingtime="<%out.print(meetingTime);%>"></span></div>

                <h1 style="font-size:22px;font-family: 微软雅黑">人民代表大会代表批评</h1>
                <table class="wp100 cellbor">
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                    %>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">届次<em class="red">*</em></td>
                        <td colspan="2"><select style="font-size:16px;font-family: 微软雅黑" class="w99" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>
                        
                        <!--<td colspan="2"><input style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="100" class="w260" name="sessionid" value="<% entity.write("sessionid"); %>" /><label class="labtitle"></label></td>-->

                        
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">会议次数<em class="red">*</em></td>
                        <td colspan="2"><select type="text" style="font-size:16px;font-family: 微软雅黑" maxlength="80" class="w99" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" ></select></td>
                        <!--<td colspan="2"><input style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="80" class="w99" name="meetingnum" value="<% entity.write("meetingnum"); %>" /><label class="labtitle"></label></td>-->

                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">类别<em class="red">*</em></td>
                        <%
                            String userLevel = "";
                            if (cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16")) {
                        %>
                        <td id="suggesttype" style="text-align:left;"  colspan="2">
                           <select style="font-size:16px;font-family: 微软雅黑;display: none;" type="text" maxlength="80" class="w260" name="level" dict-select="circles" def="<% entity.write("level"); %>" >
                            </select>
                            <select class="w99" style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                                <option value="3" style="font-size:16px;font-family: 微软雅黑">批评</option>
                                <option value="1" style="font-size:16px;font-family: 微软雅黑">建议</option>
                                <option value="2" style="font-size:16px;font-family: 微软雅黑">议案</option>
                                <option value="4" style="font-size:16px;font-family: 微软雅黑">意见</option>
                                <option value="5" style="font-size:16px;font-family: 微软雅黑">质询</option>
                            </select>
                        </td>
                            <%
                            } else {
                            %>
                        <td id="suggesttype" style="text-align:left;" colspan="2">
                            <select class="w99" style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                                <option value="3" style="font-size:16px;font-family: 微软雅黑">批评</option>
                                <option value="1" style="font-size:16px;font-family: 微软雅黑">建议</option>
                                <option value="2" style="font-size:16px;font-family: 微软雅黑">议案</option>
                                <option value="4" style="font-size:16px;font-family: 微软雅黑">意见</option>
                                <option value="5" style="font-size:16px;font-family: 微软雅黑">质询</option>
                            </select>
                        <%
                            }
                        %>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">代表团</td>
                        <td colspan="2"  id="parentname"><input style="font-size:16px;font-family: 微软雅黑" class="w99" type="text" value="<% user.write("delegationname"); %>" ></td>
                    </tr>
                    <tr>
                        <td class="dce" class="w150 dce" style="font-size:16px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input type="text" style="font-size:16px;font-family: 微软雅黑" class="w99" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">领衔代表姓名<em class="red">*</em></td>
                         <td style="font-size:16px;font-family: 微软雅黑"  colspan="5"> <% user.write("realname"); %></td>
<!--                        <td colspan="2" <% out.print(entity.get("id").isEmpty() ? "id='adminsel'" : "");%> >
                            <input style="font-size:16px;font-family: 微软雅黑" class="w200" readonly="readonly" value="<% user.write("realname"); %>"></td>-->
<!--                        <td style="font-size:16px;font-family: 微软雅黑">议案编号</td>-->
  <!--                       <td colspan="2"><input readonly="true" style="font-size:16px;font-family: 微软雅黑" name="realid" class="yincang" type="text" value="<% user.write("realid"); %>" ></td>-->
                    </tr>

<!--                    <tr>

                        <td>代表证号</td>
                        <td colspan="2" id="codenum"><% user.write("code"); %></td>
                        <td>联系电话</td>
                        <td colspan="2" id="telphone"><% user.write("telphone"); %></td>
                    </tr>
                    <tr>
                        <td>通讯地址</td>
                        <td colspan="2" id="homeaddress"><% user.write("daibiaoDWaddress"); %></td>
                        <td>邮政编号</td>
                        <td colspan="2" id="postcode"><% user.write("postcode"); %></td></tr>

                    <tr>-->
<!--zyx注销，暂时不需要这个东西-->
                        <td class="dce"><b class="selectuser" style="color:blue;font-size:16px;font-family: 微软雅黑">添加附议人</b></td>
                         <td colspan="5"><ul style="font-size:16px;font-family: 微软雅黑" id="blfyr">
                                <li>
                                    <!--
                                    <em  style='display: inline;width: 16.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>附议代表姓名</em>
                                    <em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;联系电话</em>
                                    <em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;通讯地址</em>
                                    <em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;代表证号码</em>
                                    <em >操作</em></li>
                                    -->
                                
                                    <em  style='display: inline;width: 63.7%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;font-family: 微软雅黑;font-size: 16px'>附议代表姓名</em>
                                    <em style='display: inline;width: 35.5%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;font-family: 微软雅黑;font-size: 16px'>&nbsp;操作</em>                               
                                   </li>
                                   <!--zyx修改新增页面现实问题-->
                                   
                                    <%
                                        if (!entity.get("id").isEmpty()) {
                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                            while (secondlist.for_in_rows()) {
                                    %>
                                <li myid='<% out.print(secondlist.get("userid"));%>'>
                                    <% out.print(secondlist.get("realname"));%><em style="float: right;margin-right:210px;font-size:16px;font-weight:bold;" class='red' >删除</em></li>
                                    <%
                                            }
                                        }
                                    %>
                            </ul></td>

                    </tr>
                    <tr class="">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel" style="font-family: 微软雅黑;font-size: 16px">内容摘要</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain">
                                 <% entity.write("matter"); %>
                            </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-family: 微软雅黑;font-size: 16px">附件</td>
                        <td colspan="5">
                            <div>
                                <span id="fjfile" rid="1" style="color:blue ;font-size:16px;font-family: 微软雅黑;cursor:pointer;font-weight: bold;">
                                    <%
                                    if (entity.get("enclosure")== "") {
                                    %>
                                    点击选择文件
                                    <%
                                        }else{
                                    %>
                                    <%out.print(entity.get("enclosurename")); %>
                                    <%
                                    };
                                    %>
                                </span>
                                <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                                <input type="hidden" name="enclosurename"  value="<% entity.write("enclosurename"); %>" >
                            </div>
<!--                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                </div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                </div>-->
                        </td>
                        <!--zyx修改附件bug-->
                    </tr>
                    <tr>
                        <td class="dce" style="font-family: 微软雅黑;font-size: 16px">审查分类<em class="red">*</em></td>
                        <td colspan="5" selradio>
                            <select style="width:200px;font-size:16px" value="<% entity1.write("name"); %>" name="reviewclass"
                                    <%
                                    if (entity.get("reviewclass")== ""){
                                    %>
                                    <%
                                    }else{
                                    %>
                                    companytypeeclassify="<% entity.write("reviewclass"); %>"
                                    <%
                                    };
                                    %>
                                    >
<!--  zyx增加判断，解决，新增页面审查分类为空的问题-->      
                                 
                                <%
                                     entity1.select().where("name like '%" + 
                                            URLDecoder.decode(req.get("name"), "utf-8") 
                                         + "%' ").get_page_desc("id");
                                    int a=1;
                                         while (entity1.for_in_rows()) {
                                %>
                                <option><% entity1.write("name"); %></option>
                                <%
                                   a++;
                                }
                                %>
                            </select></td>
                    </tr>
                    <%
                        if (!(cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("25"))//不为政府办和乡镇政府办且
                                && meetingTime.equals("0")//议审委流程且不在大会期间//added by jackie
                                //                                && flowtype_ysw.equals("22")//议审委流程且不在大会期间//added by jackie
                                ) {
                    %>
                    <tr  class="fsry">
                        
                        <td class="w120 dce shencha" style="font-family: 微软雅黑;font-size: 16px">审查单位</td>
                        
                        <td colspan="2"><ul id="jyscr">

<!------- added by ding for ruzhou's project ----->
		<%
		 if (meetingTime.equals("0")) {
		%>

  		<%                                //        if (!(entity.get("level").equals("0"))) {//选择人代委（powergroupid=8）
                                if ((userLevel.equals("0"))) {
                                %>
                                <b style="font-size:16px;font-family: 微软雅黑">乡镇人大主席团</b>
                           <%
                            } else {//选择乡镇政府办（powergroupid=25）
                           %>
                            <b style="font-size:16px;font-family: 微软雅黑" >选工委</b>
                            <%
                                }
                            %>

	           <%    //else meeting = 1
	           } else {
	          %>
		 <b style="font-size:16px;font-family: 微软雅黑" >代表团</b>
 	        <%
	           }
	          %>
	





                                <%
                                    //if (!entity.get("id").isEmpty()) {
                                    //list.select().where("id=? ", urlid).get_first_rows();
                                    //  RssListView secondlist = new RssListView(pageContext, "scr_suggest");
//                                       secondlist.select().where("id="+list.get("id")+" and fsrID="+list.get("")+" ").get_page_desc("myid");
                                    //   secondlist.select().where("id=? and fsrID=?", urlid, list.get("fsrID")).get_page_desc("myid");
                                    //   while (secondlist.for_in_rows()) {
                                %>
                              <!--  <li myid='<% //out.print(secondlist.get("fsrID"));%>'><% //out.print(secondlist.get("Fsrrealname"));%><em class='red'>删除</em></li>
                              //-->
                                <%
                                    //}
                                    // }
                                %>
                            </ul></td>
                        <td colspan="3">
                            <%                                //        if (!(entity.get("level").equals("0"))) {//选择人代委（powergroupid=8）
                                if (!(userLevel.equals("0"))) {
                            %>
<!----------------------------- deleted by ding for ruzhou's project------- >
		<!---
                            <b class="selectscr22" style="cursor: pointer">添加建议审查人（选工委与代表联络科）</b>
-->
                            <%
                            } else {//选择乡镇政府办（powergroupid=25）
                            %>


		<!----------------------------- deleted by ding for ruzhou's project------- >
		<!---
                            <b class="selectscra22" style="color:blue">添加建议审查人</b>
		-->

                            <%
                                }
                            %></td>
                    </tr>
                    <%
                        }//22议审委流程且不在大会期间//added by jackie
                    %>
                    <tr style="display: none;"><td rowspan="6">相关情况</td><td colspan="5" selradio>代表对公开此建议有关情况的意见<label><input type="radio" name="perm">同意全文公开</label><label><input type="radio" name="perm">仅同意公开标题</label><input type="hidden" name="permission"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>此建议由代表通过调查研究形成<label><input type="radio" name="type1">专题调研</label><label><input type="radio" name="type1">座谈</label><label><input type="radio" name="type1">走访等其他形式</label><input type="hidden" name="sugformation"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>属于多年多次提出,尚未解决的事项<label><input type="radio" name="type2">两年</label><label><input type="radio" name="type2">三年</label><label><input type="radio" name="type2">三年以上</label><input type="hidden" name="sugyears"></td></tr>
                    <tr style="display: none;"><td colspan="5" >希望主办单位在办理过程中加强与代表的联系沟通<input selbox type="checkbox" name="type3"><input type="hidden" name="communicate"></td></tr>
                    <tr style="display: none;"><td colspan="5" selbox>此建议请主办单位在工作中研究参考,不需要书面答复<input selbox type="checkbox" name="type4"><input type="hidden" name="written"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>可否联名提出<label><input type="radio" name="type1">可以</label><label><input type="radio" name="type1">不可以</label><input type="hidden" name="seconded"></td></tr> <!--<tr><td>办理方式</td><td colspan="5" selradio><label><input type="radio" name="blfs">主办/协办</label><label><input type="radio" name="blfs">分办</label><input type="hidden" name="handle"></td></tr>-->
                    <!--                    <td>有效届次：</td>
                                        <td colspan="5"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>-->
                    <tr style="display: none;"><td>办理单位</td><td colspan="4"><ul id="bldw"></ul></td><td><b class="selectcompany">选择主/分办单位</b></td></tr>
                    <tr style="display: none;"><td>建议联系人</td><td colspan="4"><ul id="jylxr"></ul></td><td><b class="selectuser">添加建议联系人</b></td></tr>
                    <tr style="display: none;"><td>审查人</td>
                        <% RssListView user1 = new RssListView(pageContext, "user_delegation");
                            user1.request();
                            if (entity.get("id").isEmpty()) {
                                user1.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                            } else {
                                user1.select().where("myid=" + entity.get("myid")).get_first_rows();
                            }
                        %>
                        <td colspan="5">
                            <input class="yincang" id="scrid" type="text" myid="<% user1.write("mission"); %>" value="<% user1.write("linkmanmission"); %>" >
                        </td>
                    </tr>

                    <tr class="thismyid">
                        <td class="tr">作者ID：</td>
                        <td colspan="5">
                            <input type="text" name="myid" class="w50" value="<% entity.write("myid"); %>" selectuser=""/>
                            <label>
                                默认当前登陆用户ID：<% out.print(UserList.MyID(request)); %>
                            </label>
                            <input name="secound">
                            <input name="contacts">
                            <input name="scr">
                            <input name="usercomp">
                            <input name="numpeople">
<!--                            <input name="enclosure">-->
<!--zyx注销，原因附件存两次-->
                        </td>
                    </tr> 
                    

                </table>
                    <div class="zhicheng">
                        
                    </div>


            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "提交" : "修改");%></button>
                <%
                    if (!(cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16"))) {
                %>
                <input type="hidden" name="level">
                <%
                    }
                %>
                <input name="year" type="hidden">
                <input name="ProposedBill" type="hidden">
                <input name="draft" type="hidden">
            </div>
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script>

            //单选多选赋值
            var json = {};
            json.reviewopinion =<% out.print(entity.get("reviewopinion"));%>
            json.permission =<% out.print(entity.get("permission"));%>
            json.sugformation =<% out.print(entity.get("sugformation"));%>
            json.sugyears =<% out.print(entity.get("sugyears"));%>
            json.communicate =<% out.print(entity.get("communicate"));%>
            json.written =<% out.print(entity.get("written"));%>
            json.handle =<% out.print(entity.get("handle"));%>
            $.each(json, function (k, v) {
                $("input[name='" + k + "']").val(v);
                if (k == "written" || k == "communicate") {
                    if (v == "1") {
                        $("input[name='" + k + "']").parent().find("input").eq(0).click();
                    }
                } else {
                    var ind = parseInt(v) - 1
                    console.log(v + "+" + ind)
                    $("input[name='" + k + "']").parent().find("label").eq(ind).click();
                }
            })
            //办理单位,联系人,联名人赋值



            $(".footer>button").click(function () {
                
                //梁小竹修改
                if($(".shencha").length > 0){
                    if($("#jyscr>li").length <= 0){
//                        alert("请选择审查人员");
 	    //////let text = "请选择审查人员";
                    //////popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                      /////// return false;
                    }
                }
                
                
                
                
                                /*
                 * 梁小竹修改
                 * 修复联名人可以多次添加同一个人并提交的bug
                 * @type Date
                 */
                var mid = new Map();
                //做一个标志位，循环里面return false没有用，要在外面return false才不会提交
                var flog = 0;
                //选中所有的多选框
                $("#blfyr>li").each(function () {
//                    alert("1");
                    let lii = $(this);
                    let val = lii.attr("myid");
                    if(mid.get(val)){
//                        说明联名人有重复
//                        alert("有");
//                        let text = "有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        flog = 1;
                        lii.remove();
//                        return false;
                    }else{
//                        说明联名人没有重复
//                        alert("没有");
                        mid.set(val,1);
                    }
                });
                if(flog === 1){
//                    alert("建议联名人有重复，已为您自动删除");
//                    alert("建议联名人有重复，已为您自动删除重复人员，请查看无误后再次提交");
let text = "建议附议有重复，已为您自动删除重复人员，请查看无误后再次提交";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    return false;
                }
                /*
                 * 梁小竹修改结束
                 */
                
                
                var date = new Date;
                var year = date.getFullYear();
                var mydate = year.toString();
                console.log(mydate);
                $('[name=year]').val(mydate);

                var timestamp = Date.parse(new Date());
                console.log(timestamp / 1000);
                $('[name=ProposedBill]').val(timestamp / 1000);
                $('[name=draft]').val("2");
//                alert($('[name=draft]').val());
                $("input").each(function () {
                    if ($(this).val() == undefined && $(this).val() == "") {
//                        alert("请填写完整数据")
let text = "请填写完整数据";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        return false;
                    }
                })
                console.log($("#suggesttype select").val());

                if ($("#level option:selected").attr("circles") == 2) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 1)
                } else if ($("#level option:selected").attr("circles") == 3) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 2)
                } else if ($("#level option:selected").attr("circles") == 4) {
                    $("input[name='level']").val($("#level option:selected").attr("circles") - 3)
                } else {
                    $("input[name='level']").val($("#level option:selected").attr("circles"))
                }
                if ($("#suggesttype select").val() == 2) {
                    if ($("#blfyr>li").length < 11) {
//                        alert("议案的联名人数得大于等于10人");
                    let text = "议案的附议人数得大于等于10人";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        return false;
                    }
                }
                
                
              if ($("[name='sessionid']").val() == undefined || $("[name='sessionid']").val() == "") {
                    let text = "请填写会议届次";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='sessionid']").focus();
                    return false;
                }

               if ($("[name='meetingnum']").val() == undefined || $("[name='meetingnum']").val() == "") {
                    let text = "请填写会议次数";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='meetingnum']").focus();
                    return false;
                }

                

                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
//                    alert("请填写标题");
let text = "请填写标题";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='title']").focus();
                    return false;
                }
                if ($("[name='matter']").val() == undefined || $("[name='matter']").val() == "") {
//                    alert("请填写内容");
let text = "请填写内容";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                    $("[name='matter']").focus();
                    return false;
                }
                var secound = [], secoundsp = "", contacts = [], contactsp = "", usercomp = [], usercompsp = "", scr = [], scrsp = "";
                $("#blfyr>li").each(function () {
                    secound.push($(this).attr("myid"));
                })
                $("#jylxr>li").each(function () {
                    contacts.push($(this).attr("myid"));
                })
                $("#bldw>li").each(function () {
                    usercomp.push($(this).attr("myid"));
                })
                scr.push($("#scrid").attr("myid"));
                secoundsp = secound.join(",");
                contactsp = contacts.join(",");
                usercompsp = usercomp.join(",");
                scrsp = scr.join(",");
                $("input[name='secound']").val(secoundsp);
                $("input[name='contacts']").val(contactsp);
                $("input[name='usercomp']").val(usercompsp);
                $("input[name='scr']").val(scrsp);
                $("input[name='numpeople']").val($("#blfyr>li").length);
                 //var enc = $("#enclosure1").val() + "," + $("#enclosure2").val() + "," + $("#enclosure3").val()
                //var enc1 = $("#enclosure11").val() + "," + $("#enclosure22").val() + "," + $("#enclosure33").val()
                //$("input[name='enclosure']").val(enc);
                //$("input[name='fileName']").val(enc1);
//                zyx注销，用其他方法存附件
                $("[selradio]").each(function () {
                    var num = $(this).find("input:checked").parent().index() + 1;
                    $(this).find("input[type='hidden']").val(num);
                })
                $("[selbox]").each(function () {
                    if ($(this).is(":checked")) {
                        $(this).parent().find("input[type='hidden']").val("1")
                    } else {
                        $(this).parent().find("input[type='hidden']").val("2")
                    }
                })
//                var matter = UE.getEditor('matter').getContent();
//                for (var i = 0; i < MGC.length; i++) {
//                    if (matter.indexOf(MGC[i]) > 1) {
//                        alert("发表内容包含敏感词");
//                        return false;
//                    }
//                }
            })
            $(".cellbor").click(function () {
                $("#dblist").hide();
            })
//            //上传附件
//            $("span[rid]").click(function () {
//                var rid = $(this).attr("rid")
//                $("#file" + rid).click();
//            })
//            $(".fileeform>input").change(function () {
//                var ridform = $(this).attr("ridform");
//                $(this).parent().ajaxSubmit({
//                    url: "/widget/upload.jsp?",
//                    type: "post",
//                    dataType: "json",
//                    async: false,
//                    success: function (data) {
//                        $("#fjfile" + ridform).text(data.url)
//                        $("#enclosure" + ridform).val(data.url);
//                        alert("上传成功");
//                    }});
//                return false;
//            })

            /*
             * 梁小竹修改
             * 修改原因为修复二次点击上传附件按钮但取消上传后上传附件按钮消失
             * @type type
             */
            //上传附件
            $("span[rid]").click(function () {
                var rid = $(this).attr("rid")
                $("#file" + rid).click();
            })
            $(".fileeform>input").change(function () {
                var str = $(this).val(); //开始获取文件名
                var filename = str.substring(str.lastIndexOf("\\") + 1);
                //zyx 增加添加附件显示附件文件名称
                $(this).parent().ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if(data.url !== null && "" !== data.url){
                            $("#fjfile").text(filename)
                            $("input[name='enclosure']").val(data.url);
                            $("input[name='enclosurename']").val(filename);
                            alert("上传成功");
                            }else{
                            $("#fjfile").text("点击选择文件")
                            alert("未上传")
                        }
                    }});
                return false;
            })
//            zyx修改附件文件名的bug
            /*
             * 梁小竹修改结束
             */


            $("#suggesttype select").change(function () {//选择了类别//added by jackie
                var v_type = '';
               // if ($("#suggesttype select").val() == 2) {//如果选择了议案类别
                 //   v_type = 'editya';
               // } else {
                 //   v_type = 'edit';
               // }


	if ($("#suggesttype select").val() == 1) {//建议
                    v_type = 'edit';
                }
                else if ($("#suggesttype select").val() == 2){ //议案
                    v_type = 'editya';
                }
                 else if ($("#suggesttype select").val() == 3){ //批评
                    v_type = 'editCriticism';
                }
                else if ($("#suggesttype select").val() == 4){ //意见
                    v_type = 'editOpion';
                }
                else if ($("#suggesttype select").val() == 5){ //质询
                    v_type = 'editInquiry';
                }


                //  alert(v_type);
                self.location = "/bill/" + v_type + ".jsp";
                return false;
            })
            $('.selectscr').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.linkman + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser.jsp", 700, 650);
            });
            $('.selectuser').click(function () {
                var t = $(this).parents("tr").find("ul");
                console.log(t)
                RssWin.onwinreceivemsg = function (dict) {
                    console.log(dict);
                     $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
//                            t.append("<li myid='" + v.myid + "'>\n\
//                            <em  style='display: inline;width: 16.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em>\n\
//                            <em style='inline block;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.telphone + "</em>\n\
//                            <em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.daibiaoDWaddress + "</em>\n\
//                            <em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.code + "</em>\n\
//                            <em class='blue'>删除</em></li>")
            
             t.append("<li myid='" + v.myid + "'>\n\
                            <em  style='display: inline;width: 65.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em>\n\
                            \n\
                            <em class='blue'style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;color:blue;cursor:pointer;font-weight:bold;''>删除</em></li>"
                    )
                            //t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>" + v.realname +"</em><em style='inline block;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.code+"</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.homeaddress+ "</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.telphone+ "</em><em class='red'>删除</em></li>")
                            //t.append("<li myid='" + v.myid + "'><em style='margin-left: 10px;'>&nbsp;" + v.realname + "</em><em style='margin-left: 85px;'>&nbsp;"+v.code+"</em><em style='margin-left: 200px;'>&nbsp;"+v.homeaddress+"</em><em style='margin-left: 85px;'>&nbsp;"+v.telphone+"</em><em class='red'>删除</em></li>")
                            // t.append("<li style='border: 1px #dce6f5 solid;margin-top: 2px;' myid='" + v.myid + "'>" +v.realname +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.code + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.homeaddress +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.telphone +"<em class='red'>删除</em></li>")
                        }
                    })
//                    zyx修改，添加联名人页面显示问题，只显示姓名和删除按钮
                    // t.find("em").off("click").click(function () {
                    $('.blue').click(function () {
                        $(this).parent().remove();
                    })
                }
                if (Cookie.Get("powergroupid") == "22") {
                    RssWin.open("/selectwin/selectuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>", 700, 650);
                } else {
                    RssWin.open("/selectwin/selectuser.jsp?mission=<% out.print(user1.get("mission"));%>", 700, 650);
                }
            });
            $('.selectcompany').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectcompany.jsp", 700, 650);
            });
            $("li").find(".red").off("click").click(function () {
                $(this).parent().remove();
            })
            if (Cookie.Get("powergroupid") == "16" || Cookie.Get("powergroupid") == "22" || Cookie.Get("powergroupid") == "8" || Cookie.Get("powergroupid") == "15" || Cookie.Get("powergroupid") == "0") {
                $("#adminsel>input").click(function () {
                    RssWin.onwinreceivemsg = function (dict) {
                        console.log(dict);
                        $("#adminsel>input").val(dict.myname)
                        $("#parentname").text(dict.delegationname)
                        $("#scrid").attr("myid", dict.mission)
                        $("#codenum").text(dict.code)
                        $("#postcode").text(dict.postcode)
                        $("#telphone").text(dict.telphone)
                        $("#homeaddress").text(dict.daibiaoDWaddress)
                        $("[name='myid']").val(dict.myid)
                    }
                    RssWin.open("/selectwin/selectoneuser_2.jsp?myid=<% out.print(cookie.Get("myid"));%>&mission=<% out.print(user1.get("mission"));%>", 700, 650);
                })
//            }else if(Cookie.Get("powergroupid") == "22"){
//                $("#adminsel>input").click(function () {
//                    RssWin.onwinreceivemsg = function (dict) {
//                        console.log(dict);
//                        $("#adminsel>input").val(dict.myname)
//                        $("#parentname").text(dict.realname)
//                        $("#codenum").text(dict.code)
//                        $("#postcode").text(dict.postcode)
//                        $("#telphone").text(dict.telphone)
//                        $("#homeaddress").text(dict.homeaddress)
//                        $("[name='myid']").val(dict.myid)
//                    }
//                    RssWin.open("/selectwin/selectuser_1.jsp?myidd=<% out.print(cookie.Get("myid"));%>", 700, 650);
//                })
            }
            $('.selectscr22').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_p7.jsp", 700, 650);
            });
            $('.selectscra22').click(function () {
                var t = $(this).parents("tr").find("ul");
                RssWin.onwinreceivemsg = function (dict) {
                    $.each(dict, function (k, v) {
                        if ($("em[myid='" + v.myid + "']").length == "0") {
                            t.append("<li myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='xzscID' value='" + v.myid + "' /></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
                        $(this).parent().remove();
                    })
                }
                RssWin.open("/selectwin/selectscuser_1_1.jsp", 700, 650);
            });
        </script>
    </body>
</html>
