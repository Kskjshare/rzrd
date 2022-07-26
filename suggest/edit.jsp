<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.ResourceBundle"%>
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

<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    //below added by jackie/


    //String flowtype = "2";
    //1:代表团初审;2:议审委初审21:议审委初审且在人大会议期间;22:议审委初审且不在会议期间
//    if (flowtype.equals("2")) {//议审委流程
////        String str_sessionid=entity.get("sessionid");
////        String str_companytypeeeid=entity.get("meetingnum");
//        RssListView meeting_list = new RssListView(pageContext, "meeting");
//        meeting_list.request();
//        meeting_list.select().where("1=1").get_page_desc("id");//commented by jackie
//        Date date = new Date();
//        long l_now = date.getTime() / 1000;
//        // System.out.println("date/1000::"+l_now); 
//        //list.select().where("1=1").get_page_desc("id");//added by jackie
//        while (meeting_list.for_in_rows()) {//每笔都核对一遍是否在人大会议期间            
//            Long l_startdate = Long.parseLong(meeting_list.get("startdate"));
//            Long l_enddate = Long.parseLong(meeting_list.get("enddate"));
//            if (l_now < l_enddate && l_now > l_startdate) {
//                flowtype_ysw = "21";//3:议审委初审且在会议期间
//            } else {
//                flowtype_ysw = "22";//3:议审委初审且不在会议期间
//            }
//        }
//    }
    //up added by jackie 
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
    RssList entity = new RssList(pageContext, "suggest");
    RssList sort = new RssList(pageContext, "sort");
    RssList second = new RssList(pageContext, "secondeduser");
    RssList contacts = new RssList(pageContext, "suggestlxr");
    RssList usercomp = new RssList(pageContext, "suggest_company");
    RssList scr = new RssList(pageContext, "suggestscr");
    RssList read = new RssList(pageContext, "lzmessage_read");
    RssList lzmessage = new RssList(pageContext, "lzmessage");
    CookieHelper cookie = new CookieHelper(request, response);
    RssList entity1 = new RssList(pageContext, "companytypee_classify");
    sort.pagesize = 100000;
    entity.request();
    if (!entity.get("action").isEmpty()) {
        entity.remove("scyj", "realid", "perm", "type1", "type2", "type3", "type4", "blfs", "secound", "contacts", "usercomp", "scr");
        entity.remove("id");
        entity.remove("secound");
        if (entity.get("summary").isEmpty()) {
            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 120));
        }

        if (entity.get("myid").isEmpty()) {
            entity.keymyid(UserList.MyID(request));
        }
        if (meetingTime.equals("1")) {
            entity.keyvalue("isysw", "0");//不经过选工委或代表联络科
            //预留空位，此处应为大会期间的其他处理
        } else {
            
            //ding删除下面梁涛改的代码（此代码引起闭会期间，代表提交议案的时候，状态显示错误，但是不知道会不会引起其他问题。
            
//            if ((entity.get("level").equals("0"))) {// 此处注释错误  ，     0为乡镇，examination设为5；   1为市级，examination设为1（默认为1，不动即可）    注：因乡镇路线无初审流程，故设为5
                //梁小竹修改下一行原本为entity.keyvalue("examination", 5);
//                entity.keyvalue("examination", 5);//examination为1则未审查，审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查  注：因乡镇路线无初审流程，故设为5
//                entity.keyvalue("iscs", 1);//0为未审核，1为初审核
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
        //梁小竹添加，添加乡镇政府办的id结束
        
        //梁小竹添加，原因，标识此建议议案是开会时提出还是闭会时提出，用来判断流程的显示
        entity.keyvalue("ismeet", meetingTime);
        
        entity.append().submit();
        sort.pagesize = 100000000;
        sort.select().where("type=" + entity.get("lwstate")).get_page_desc("realid");
//        int a = sort.totalrows + 1;
        sort.keyvalue("sortid", entity.autoid);
        sort.keyvalue("type", entity.get("lwstate"));

        //处理编号 开始
        String a = "J";
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        RssList sequence = new RssList(pageContext, "sort_sequence");
        sequence.select().where("seq_name=" + year).get_first_rows();
        a += year;
        a += sequence.get("jianyi_val");
        sort.keyvalue("realid", a);
        sequence.keyvalue("jianyi_val", Integer.valueOf(sequence.get("jianyi_val")) + 1);
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
                    if (meetingTime.equals("1")) {
                        scr.keyvalue("userid", bb[i]);
                    } else {//闭会期间不经过代表团，userid设为0
                        scr.keyvalue("userid", "0");
                    }
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
        out.print("<script>alert('操作成功！');</script>");
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
            .popupwrap table td>ul>li>.red{margin-left: 5px;font-size: 10px;cursor: pointer;}/*虎鹏明*/
            .popupwrap table td>input[type='checkbox']{margin: 0 3px;}
            span[rid]{cursor: pointer}
            /*.popupwrap .footer>button{ font-size: 99px;}*/
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .popupwrap>.footer{top: auto;bottom: 0;right: 24px;border-top: solid 1px #e6e6e6; padding-top: 5px;position: fixed;}
            td .yincang{border: 0px;outline:none;cursor: pointer; }
            .w498{width: 99%;}
            #suggesttype{
                font-size: 16px;
                font-family: 微软雅黑;
            }
            .w99{width: 99%;}
            .meetingtime{color: red}
 /*撑下边按钮*/
            .chengyemian{
               
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
<!--                <div id="suggesttype">
                    类&nbsp;&nbsp;别：
                    <select style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                        <option value="1" style="font-size:16px;font-family: 微软雅黑">建议</option>
                        <option value="2" style="font-size:16px;font-family: 微软雅黑">议案</option>
                        <option value="3" style="font-size:16px;font-family: 微软雅黑">批评</option>
                        <option value="4" style="font-size:16px;font-family: 微软雅黑">意见</option>
                        <option value="5" style="font-size:16px;font-family: 微软雅黑">质询</option>
                    </select>
                </div>
-->
                <!--调用display: none为了隐藏，否则level不能写到数据库，导致选工委查询条件出错-->
                <div id="suggesttype"  style="display: none;"><span class="meetingtime" meetingtime="<%out.print(meetingTime);%>"></span></div>

                <h1 style="font-size:22px;font-family: 微软雅黑">人大代表建议、议案</h1>
                <table class="wp100 cellbor">
                    <%
                        RssListView user = new RssListView(pageContext, "user_delegation");
                        user.request();
                        //user.select().where("myid=" + cookie.Get("myid")).get_first_rows();
                        user.select().where("myid=" + entity.get("myid")).get_first_rows();
                        
                    %>
                    <tr>
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑" >届次<em class="red">*</em></td>
                        <td colspan="2" style="font-size:16px"><select style="font-size:16px;font-family: 微软雅黑" class="w99" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">会议次数<em class="red">*</em></td>
                        <td colspan="2" style="font-size:16px;font-family: 微软雅黑"><select style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="80" class="w99" name="meetingnum" dict-select="companytypeeeclassify" def="<% entity.write("meetingnum"); %>" ></select></td>
                    </tr>
                    <tr>
                        <td class="dce w120" style="font-size:16px;font-family: 微软雅黑">类别<em class="red">*</em></td>
                        <%
                            String userLevel = "";
                            if (cookie.Get("powergroupid").equals("22") || cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("16")) {
                        %>
                        <td id="suggesttype" style="text-align:left;"  colspan="2">
<!--                            <select style="font-size:16px;font-family: 微软雅黑" type="text" maxlength="80" class="w260" name="level" dict-select="circles" def="<% entity.write("level"); %>" >
                            </select>-->
                            <select class="w99"  style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                                <option value="1" style="font-size:16px;font-family: 微软雅黑">建议</option>
                                <option value="2" style="font-size:16px;font-family: 微软雅黑">议案</option>
                                <option value="3" style="font-size:16px;font-family: 微软雅黑">批评</option>
                                <option value="4" style="font-size:16px;font-family: 微软雅黑">意见</option>
                                <option value="5" style="font-size:16px;font-family: 微软雅黑">质询</option>
                            </select>
                        </td>
                            <%
                            } else {
                            %>
                        <td id="suggesttype" style="text-align:left;" colspan="2">
                            <select class="w99" style="font-size:16px;font-family: 微软雅黑" name="lwstate">
                                <option value="1" style="font-size:16px;font-family: 微软雅黑">建议</option>
                                <option value="2" style="font-size:16px;font-family: 微软雅黑">议案</option>
                                <option value="3" style="font-size:16px;font-family: 微软雅黑">批评</option>
                                <option value="4" style="font-size:16px;font-family: 微软雅黑">意见</option>
                                <option value="5" style="font-size:16px;font-family: 微软雅黑">质询</option>
                            </select>
                            <!--调用display: none为了隐藏，否则level不能写到数据库，导致选工委查询条件出错-->
                            <select class="w99" style="display: none;" id="level" type="text" maxlength="80" >
                                <%
                                    String arr[] = user.get("circleslist").split(",");
                                    for (int idx = 1; idx < arr.length; idx++) {
                                %>
                                <option circles="<% out.print(arr[idx]);%>"></option>
                                <%
                                        userLevel = arr[idx];
                                    }
                                %>
                            </select>
                        </td>
                        <%
                            }
                        %>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">代表团</td>
                        <td colspan="2" id="parentname" style="font-size:16px"><input style="font-size:16px;font-family: 微软雅黑" class="w99" type="text" value="<% user.write("delegationname"); %>" ></td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">标题<em class="red">*</em></td>
                        <td colspan="5"><input style="font-size:16px;font-family: 微软雅黑" type="text" class="w99" name="title" value="<% entity.write("title"); %>" /><label class="labtitle"></label></td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">领衔代表姓名<em class="red">*</em></td>
                        <td  colspan="5" style="font-size:16px;font-family: 微软雅黑"> <% user.write("realname"); %></td>
                    
                        <!--
                        <td colspan="2" <% out.print(entity.get("id").isEmpty() ? "id='adminsel'" : "");%> >
                            <input class="w200" readonly="readonly" value="<% user.write("realname"); %>"></td>
                      
                        <td>编号</td>
                        <td colspan="2"><input readonly="true" name="realid" class="yincang" type="text" value="<% user.write("realid"); %>" ></td>
                        -->
                        
                    </tr>
                    
                    <!--
                    <tr>

                        <td>代表证号</td>
                        <td colspan="2" id="codenum"><% user.write("code"); %></td>
                        <td>联系电话</td>
                        <td colspan="2" id="telphone"><% user.write("telphone"); %></td>
                    </tr>
                   
                    <tr>
                        <td>通讯地址</td>
                        <td colspan="2" id="homeaddress"><% user.write("daibiaoDWaddress"); %></td>
                        <td>邮政编号</td>
                        <td colspan="2" id="postcode"><% user.write("postcode"); %></td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce"><b class="selectuser" style="color:blue;font-size:16px;font-family: 微软雅黑">添加联名人</b></td>
                        <td colspan="5"><ul style="font-size:16px;font-family: 微软雅黑" id="blfyr" class="lianmingren">
                                <li>
                                    <em  style='display: inline;font-size:16px;width: 65.2%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;font-family: 微软雅黑'>
                                         联名人姓名                                    </em>
<!--                                    <em style='display: inline;width: 33%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;联系电话
                                    </em>-->
                                    
                                    <!--
                                    <em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;通讯地址
                                    </em>
                                    <em style='display: inline;width: 22%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;代表证号码</em>
                                     <em >操作</em>
                                    -->
                                   
                                    <em style='display: inline;font-size:16px;font-family: 微软雅黑;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>
                                        &nbsp;操作
                                    </em>
                                </li>
                                    <%
                                        if (!entity.get("id").isEmpty()) {
                                            RssListView secondlist = new RssListView(pageContext, "second_user");
                                            secondlist.select().where("suggestid=" + entity.get("id")).query();
                                            while (secondlist.for_in_rows()) {
                                    %>
                                <li  myid='<% out.print(secondlist.get("userid"));%>'>
                                    <% out.print(secondlist.get("realname"));%><em style="float: right;margin-right:210px;font-size:16px;font-weight:bold;" class='red'>删除</em></li>
                                    <%
                                            }
                                        }
                                    %>

                            </ul></td>

                    </tr>
                    <tr class="dce">
                        <td colspan="6" class="marginauto uetd">
                            <ul><li class="sel" style="font-size:16px;font-family: 微软雅黑">内容</li></ul>
                            <script ueditor="toolbars: [['fullscreen','undo','redo','|','bold','italic','underline','fontborder','strikethrough','superscript','subscript','removeformat','formatmatch','autotypeset','pasteplain','|','forecolor','backcolor','insertorderedlist','insertunorderedlist','|','rowspacingtop','rowspacingbottom','lineheight','|','fontfamily','fontsize','|','justifyleft','justifycenter','justifyright','justifyjustify','indent','|','link','unlink','anchor','|','imagenone','imageleft','imageright','imagecenter','|','insertimage','emotion','spechars','insertvideo']],initialFrameHeight:200" id="matter" name="matter" class="w750" type="text/plain">
                                <% entity.write("matter"); %>
                            </script>
                        </td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px;font-family: 微软雅黑">附件</td>
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
                                </span>
                                <input type="hidden" name="enclosure" value="<% entity.write("enclosure"); %>" >
                                <input type="hidden" name="enclosurename"  value="<% entity.write("enclosurename"); %>" >
                                <%
                                    };
                                %>
                            </div>
<!--                            <div style="display: none;"><span id="fjfile2" rid="2" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                </div>
                            <div style="display: none;"><span id="fjfile3" rid="3" style="color:blue;font-size:16px;font-family: 微软雅黑;font-weight: bold;">点击选择文件</span>
                                </div>-->
                        </td>
                    </tr>
                    <tr>
                        <td class="dce" style="font-size:16px" >类别<em class="red">*</em></td>
                        <td colspan="5" selradio>
<!--                            <select type="text" maxlength="80" class="w260" name="reviewclass" dict-select="companytypeeclassify" def="<% entity.write("reviewclass"); %>" ></select>-->
                           
                            <!--<label><input name="scyj" type="radio">参阅件</label><label><input name="scyj" type="radio">撤案</label><label><input name="scyj" type="radio">并案</label> -->

<!-- dict-select="companytypeeclassify" 这个属性默认值
                             <select style="width:200px;font-size:16px" value="<% entity.write("reviewclass"); %>" name="reviewclass" companytypeeclassify="<% entity.write("reviewclass"); %>">
 -->                           
                             <select style="width:200px;font-size:16px" name="reviewclass"  def="<% entity1.write("reviewclass"); %>">
                                <%
                                    
                                    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                                    entity1.select().where("name like '%" + URLDecoder.decode(req.get("name"), "utf-8") + "%'").get_page_desc("id");
                                    int a=1;
                                    while (entity1.for_in_rows()) {       
                                %>
                                <option><% entity1.write("name"); %></option>
                                <%
                                   a++;
                                }
                                %>
                            </select>
                        </td>
                    </tr>
                    <!-- below added by jackie  //-->
                    <%
                        if (!(cookie.Get("powergroupid").equals("8") || cookie.Get("powergroupid").equals("25"))//不为政府办和乡镇政府办且
                                && meetingTime.equals("0")//议审委流程且不在大会期间//added by jackie
                                //                                && flowtype_ysw.equals("22")//议审委流程且不在大会期间//added by jackie
                                ) {
                    %>
                    <tr  class="fsry">

                        <td class="dce"  style="font-size:16px;font-family: 微软雅黑">审查单位</td>
                        <!--td class="w120 dce shencha" style="font-size:18px">审查单位</td-->
                        <td colspan="2" style="font-size:14px"><ul id="jyscr">

		<!------- added by ding for ruzhou's project ----->
		<%
		 if (meetingTime.equals("0")) {
		%>

  		<%                                //        if (!(entity.get("level").equals("0"))) {//选择人代委（powergroupid=8）
                                if (!(userLevel.equals("0"))) {
                                %>
                                <b style='font-size:16px;font-family: 微软雅黑' >选工委</b>
                           <%
                            } else {//选择乡镇政府办（powergroupid=25）
                           %>
                            <b style='font-size:16px;font-family: 微软雅黑' >乡镇人大主席团</b>
                            <%
                                }
                            %>

	           <%    //else meeting = 1
	           } else {
	          %>
		 <b style='font-size:16px;font-family: 微软雅黑' >代表团</b>
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
                                <b class="selectscr22" style="cursor: pointer ">添加建议审查人（选工委与代表联络科）</b>
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
                    <!-- up added by jackie  //-->
                    <tr style="display: none;"><td rowspan="6">相关情况</td><td colspan="5" selradio>代表对公开此建议有关情况的意见<label><input type="radio" name="perm">同意全文公开</label><label><input type="radio" name="perm">仅同意公开标题</label><input type="hidden" name="permission"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>此由代表通过调查研究形成<label><input type="radio" name="type1">专题调研</label><label><input type="radio" name="type1">座谈</label><label><input type="radio" name="type1">走访等其他形式</label><input type="hidden" name="sugformation"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>属于多年多次提出,尚未解决的事项<label><input type="radio" name="type2">两年</label><label><input type="radio" name="type2">三年</label><label><input type="radio" name="type2">三年以上</label><input type="hidden" name="sugyears"></td></tr>
                    <tr style="display: none;"><td colspan="5" >希望承办单位在办理过程中加强与代表的联系沟通<input selbox type="checkbox" name="type3"><input type="hidden" name="communicate"></td></tr>
                    <tr style="display: none;"><td colspan="5" selbox>请承办单位在工作中研究参考,不需要书面答复<input selbox type="checkbox" name="type4"><input type="hidden" name="written"></td></tr>
                    <tr style="display: none;"><td colspan="5" selradio>可否联名提出<label><input type="radio" name="type1">可以</label><label><input type="radio" name="type1">不可以</label><input type="hidden" name="seconded"></td></tr> <!--<tr><td>办理方式</td><td colspan="5" selradio><label><input type="radio" name="blfs">主办/协办</label><label><input type="radio" name="blfs">分办</label><input type="hidden" name="handle"></td></tr>-->
                    <!--                    <td>有效届次：</td>
                                        <td colspan="5"><select class="w260" name="sessionid" dict-select="sessionclassify" def="<% entity.write("sessionid"); %>"></select></td>-->
                    <tr style="display: none;"><td>办理单位</td><td colspan="4"><ul id="bldw"></ul></td><td><b class="selectcompany">选择主/分办单位</b></td></tr>
                    <tr style="display: none;"><td>联系人</td><td colspan="4"><ul id="jylxr"></ul></td><td><b class="selectuser">添加联系人</b></td></tr>
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
                            <input class="yincang" id="scrid" type="text" myid="<% user1.write("mission"); %>" value="<% user1.write("delegationname"); %>" >
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
                        </td>
                    </tr>   

                </table>

<div class="chengyemian ">
                        
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


//<!--  removed by ding for ruzhou's project  ----> 
            $(".footer>button").click(function () {
               

                //梁小竹修改
                if($(".shencha").length > 0){
                    if($("#jyscr>li").length <= 0){
//                        alert("请选择审查人员");
  //////                  let text = "请选择审查人员";
 //////                   popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
//                    popuplayer.display( window.location.href='/showalert.jsp?text ='+encodeURI(encodeURI(text)), '提示', {width: 300, height: 100});
                  //////      return false;
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
//let text = "有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        flog = 1;
                        lii.remove();
//                        return false;
                    }else{
//                        说明联名人没有重复
//                        alert("没有");
//let text = "没有";
//                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        mid.set(val,1);
                    }
                });
                if(flog === 1){
                    let text = "联名人有重复，已为您自动删除重复人员，请查看无误后再次提交";
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
                } else 
                {
                    $("input[name='level']").val($("#level option:selected").attr("circles"))
                }
                if ($("#suggesttype select").val() == 2) {//如果选的类型为议案
                    if ($("#blfyr>li").length < 11) {//因为列名也占了一行
//                        alert("议案的联名人数得大于等于10人");
                    let text = "议案的附议人数得大于等于10人";
                    popuplayer.display("/showalert.jsp?text="+text, '提示', {width: 300, height: 100});
                        return false;
                    }
                }

                if ($("[name='title']").val() == undefined || $("[name='title']").val() == "") {
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
//                zyx注销，用其他方法存储附件
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
            })//$(".footer>button").click(function () {
            $(".cellbor").click(function () {
                $("#dblist").hide();
            })
            //上传附件
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
            
//            梁小竹修改 覆盖默认alert，
//            window.alert = function (txt) {
//                navigator.notification.alert(txt, null, "Alert", "Close");
//            }
            //梁小竹修改结束
            $("#suggesttype select").change(function () {//选择了类别//added by jackie
                var v_type = '';
                //if ($("#suggesttype select").val() == 2) {//如果选择了议案类别
                  //  v_type = 'editya';
               // } else {
                //    v_type = 'edit';
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
             
                
                // alert(v_type);
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
                            t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 16%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;border-left: 0px;'>" + v.realname + "</em><em style='inline block;width: 33%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.telphone + "</em><em style='display: inline;width: 34%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.homeaddress + "</em><em style='display: inline;width: 12%;height: 100%;border: 1px #dce6f5 dashed;float: left;border-top: 0px;border-right: 0px;'>&nbsp;" + v.code + "</em><em class='red'>删除</em></li>")
                            //t.append("<li myid='" + v.myid + "'><em  style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>" + v.realname +"</em><em style='inline block;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.code+"</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.homeaddress+ "</em><em style='display: inline;width: 19%;height: 100%;border: 1px #dce6f5 solid;float: left;'>&nbsp;"+v.telphone+ "</em><em class='red'>删除</em></li>")
                            //t.append("<li myid='" + v.myid + "'><em style='margin-left: 10px;'>&nbsp;" + v.realname + "</em><em style='margin-left: 85px;'>&nbsp;"+v.code+"</em><em style='margin-left: 200px;'>&nbsp;"+v.homeaddress+"</em><em style='margin-left: 85px;'>&nbsp;"+v.telphone+"</em><em class='red'>删除</em></li>")
                            // t.append("<li style='border: 1px #dce6f5 solid;margin-top: 2px;' myid='" + v.myid + "'>" +v.realname +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.code + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.homeaddress +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+v.telphone +"<em class='red'>删除</em></li>")
                        }
                    })
                    t.find("em").off("click").click(function () {
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
                            t.append("<li class='abc' myid='" + v.myid + "'>" + v.realname + "<em class='red'>删除</em><input type='hidden' name='fsrID' value='" + v.myid + "' /></li>")
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
