<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>


<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>

<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
//      RssList entity = new RssList(pageContext, "suggest");
//    RssListView list = new RssListView(pageContext, "sort");

    //增加闭会 开会 条件过滤 
    String meetingTime="0";
    int isMeeting = 0 ;
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
    if ( meetingTime.equals("1")) {
        isMeeting =  1 ;
    }
    
   String powerid = cookie.Get("powergroupid");
    
    
   
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
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .no{display: none}
            tbody tr:hover{background-color: gainsboro;}
            .ys{
                color: blue;
            }

        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch" powerid="145">快速查询</button>
                <!--<button type="button" transadapter="supersearch" select="false" class="supersearch" powerid="145">高级查询</button>-->
                <!--<button type="button" transadapter="append" select="false" class="butadd" powerid="146">增加</button>-->
                <%
                    RssListView entity = new RssListView(pageContext, "sort");
                    entity.select().where("myid=?", UserList.MyID(request)).get_first_rows();
                  
                    if (!(entity.get("draft").equals("2")) || !(powerid.equals("18") )  ) {
                   
                %>
                <button type="button" transadapter="edit" class="butedit" powerid="147">编辑</button>
                
                <%
                    }
                %>
                
             
                <!--removed by ding -->
                <!--button type="button" transadapter="butreview" class="butreview" powerid="150">审查</button-->
<!--                <button type="button" transadapter="butview" class="butview" powerid="149">查看</button>-->
                <!--<button type="button" transadapter="butimportance" class="butimportance" powerid="151">重点议案</button>-->
                <!--<button type="button" transadapter="importancelist" select="false" class="butexcellent" powerid="152"><% out.print(URLDecoder.decode(req.get("importance"), "utf-8").equals("2") ? "展示全部议案" : "罗列重点议案");%></button>-->
                <button type="button" transadapter="butreports" select="false" class="butreports" powerid="153">报表</button>
                <button type="button" transadapter="print" class="butimportance" powerid="">打印</button>
                <button type="button" id="prints" transadapter="prints" class="butimportance">导出</button>
                <button type="button" class="setup" style="display: none;">设置</button>
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <ul wz="0">
                    <li><label><input type="checkbox" name="field" sel="title" checked="checked">标题</label></li>
                    <li><label><input type="checkbox" name="field" sel="myid" checked="checked">领衔代表</label></li>
                    <li><label><input type="checkbox" name="field" sel="numpeople" checked="checked">提出人数</label></li>
                    <li><label><input type="checkbox" name="field" sel="lwstate">类型</label></li>
                    <li><label><input type="checkbox" name="field" sel="">提交状态</label></li>
                    <li><label><input type="checkbox" name="field" sel="registertype">立案形式</label></li>
                    <li><label><input type="checkbox" name="field" sel="">开案案号</label></li>
                    <li><label><input type="checkbox" name="field" sel="permission">可否网上公开</label></li>
                    <li><label><input type="checkbox" name="field" sel="seconded">可否联名提出</label></li>
                    <li><label><input type="checkbox" name="field" sel="opinioned">征求意见方式</label></li>
                    <li><label><input type="checkbox" name="field" sel="meet">是否会上</label></li>
                    <li><label><input type="checkbox" name="field" sel="methoded">处理方式</label></li>
                    <li><label><input type="checkbox" name="field" sel="shijian">提交日期</label></li>
                    <li><label><input type="checkbox" name="field" sel="reviewclass" checked="checked">审查分类</label></li>
                    <li><label><input type="checkbox" name="field" sel="handle" checked="checked">进度</label></li>
                    <li><label><input type="checkbox" name="field" sel="degree">解决程度</label></li>
                    <li><label><input type="checkbox" name="field" sel="realcompanyname" checked="checked">主办单位</label></li>
                </ul>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w40">序号</th>
                            <th class="w30"><input name="all" type="checkbox" name="id"></th>
                            <!--<th>来文号</th>
                            <th class="w60">编号</th>
                            -->
                            <th class="title no">标题</th>
                            <th class="myid">领衔代表</th>
                            <th>人数</th>
                            <th class="lwstate no">立案形式</th>
                            <th class="permission no">可否网上公开</th>
                            <th class="seconded no">可否联名提出</th>
                            <th class="opinioned no">征求意见方式</th>
                            <th class="meet no">是否会上</th>
                            <th class="methoded no">处理方式</th>
                            <th class="shijian no">提交日期</th>
                            <th class="registertype no">立案形式</th>
                            <th class="reviewclass no">审查分类</th>
                            <th class="handle no">进度</th>
                                <%
                                    if (cookie.Get("powergroupid").equals("8")) {
                                %>
                            <th class="realcompanyname no">交办单位</th>
                            <th class="realcompanyname no">重点议案</th>
                            <!--zyx增加重点议案列-->
                                <%
                                } else {
                                %>
                            <th class="realcompanyname no">主办单位</th>
                            <th class="importance">重点议案</th>
                                <%
                                    }
                                %>
                            <!--                            <th>代表团</th>
                                                        <th>联系电话</th>-->
                            
                            <th class="handle no">操作</th>
                            
                            

                        </tr>
                    </thead>
                    <tbody>
                    <%
                       
                        String keywhere = "";
                        String view = "sort";
                        switch ( powerid ) {
                            case "5":    //代表
                        
                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" 
                                        + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + 
                                        URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" +
                                        URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + 
                                        URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + 
                                        URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and myid=" + cookie.Get("myid");
                                break;
                            case "38": //人大常委會
                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" 
                                  + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + 
                                  URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" +
                                  URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + 
                                  URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + 
                                  URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and myid=" + cookie.Get("myid");
                                break;    
                            case "7": //added by jackie  ding 选联委
                                view = "sort";
                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + 
                                        URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" +
                                        URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" +
                                    URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + 
                                    URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" + 
                                        URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" +
                                        URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" +
                                        URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" +
                                        URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and isysw=21";// removed  condition sql by ding  :     and isysw=21
                                    break;
                            case "22": //代表团(审查)
                                //view = "scr_suggest";
                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" +
                                        URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + 
                                        URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" +
                                        URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" +
                                        URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + 
                                        URLDecoder.decode(req.get("importance"), "utf-8") + "%' and realid like '%" +
                                        URLDecoder.decode(req.get("realid"), "utf-8") + "%' and allname like '%" + 
                                        URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + 
                                        URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" +
                                        URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" +
                                        URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" +
                                        URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and mission=" + cookie.Get("myid");
                                break;
                            case "8": //  ding:议审委
                                view = "scr_suggest";
                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + 
                                        URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
                                        "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" +
                                        URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") +
                                        "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and sessionid like '%" + 
                                        URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and telphone like '%" +
                                        URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + 
                                        URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and iscs=1 and isysw=0";
                                 //打个补丁大会期间议审委账号登录看不到记录
                                if ( meetingTime.equals("1")) 
                                {
                                   view = "sort"; //added by ding for 议审委登录，议案看不到数据
                                   keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + 
                                        URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
                                        "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" +
                                        URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") +
                                        "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and sessionid like '%" + 
                                        URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and telphone like '%" +
                                        URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + 
                                        URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2 and iscs=1 and isysw=21";
                                }
                                break;
                            case "25": //乡镇(审查) 主席团
                                view = "scr_suggest";
                                view = "sort";
                                
//                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + 
//                                        "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + 
//                                        "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
//                                        "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + 
//                                        "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
//                                        "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + 
//                                        "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + 
//                                        "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + 
//                                        "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + 
//                                        "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + 
//                                        "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + 
//                                        "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
//                                        "%' and lwstate=2 and draft=2";
                                
//                                 keywhere = "title like '%" + URLDecoder.decode(req.get("title"), "utf-8") +                                   
//                                        "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + 
//                                        "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
//                                        "%' and lwstate=2 and draft=2";
                                 
                                  keywhere = "lwstate=2 and draft=2";
                                
                                  //"%' and lwstate=2 and draft=2 and (fsrID=" + cookie.Get("myid")+" or xzscID=" + cookie.Get("myid")+")";
                                 //added by ding 汝州项目乡镇人大主席团只能审批乡镇代表，所以加一个level条件查找记录
                                keywhere += " and level=0";
                                if ( meetingTime.equals("1") ) 
                                {
                                  
                                    keywhere += " and examination= 2 "; // ding change 2 to 5 2021.3.31
                                   
                                }
                                break;
                            case "23": //政府(交办)  督察局
                                keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and lwstate=2 and draft=2 and examination =2 and level=1";
                                    //added by ding 汝州项目督察局只能审批市级代表，所以加一个level条件查找记录
                                keywhere += " and level=1";
                                break;
                            case "18": //办理单位(办理)
                                    view = "company_sug";
//                                    String rid = cookie.Get("parentid");
//                                    if (rid.equals("0")) {
//                                        rid = cookie.Get("myid");
//                                    }
                            keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + 
                                    URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") 
                                    + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" +
                                    URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") +
                                    "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8")
                                    + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and lwstate=2 and draft=2 and deal =1 and companyid=" + cookie.Get("myid");
                            break;
                        default:
                            keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and lwstate=2 and draft=2";
                            break;
                    }
                    RssListView list = new RssListView(pageContext, view);
                    list.request();

                        int ismeeting = 0 ;
                        if ( meetingTime.equals("1")){
//                            keywhere += " and ismeet=1";
                            ismeeting = 1 ;
                         }
                        else {
//                            keywhere += " and ismeet=0";
                         }
                            
                            
                            
                            
                            
                            
                            int a = 1;
                            list.pagesize = 30;
                            if ((cookie.Get("powergroupid")).equals("5") || (cookie.Get("powergroupid")).equals("22")) {
                               
                                if ( meetingTime.equals("1"))
                                list.select().where(keywhere).get_page_desc("shijian");
                                else {
                                 //闭会期间，用代表团账号登录的时候，不应该看到任何记录
                                 if ( (cookie.Get("powergroupid")).equals("5") )
                                      list.select().where(keywhere).get_page_desc("realid");
                                 else
                                    list.select().where("draft=1").get_page_desc("realid");
                                }
                                
                            } else {
                                list.select().where(keywhere).get_page_desc("realid");
                            }
                            
                            
                            //是否显示删除按钮
                            while (list.for_in_rows()) {
                               
                               
                               boolean isShowDeleteBtn = false ;
                               if ( powerid.equals("7") || list.get("myid").equals( UserList.MyID(request) )) {
                                   isShowDeleteBtn = true ;
                               }      
                                
                              //处理汝州特殊要求，议案联名的议审委流程
                              boolean isbill_yishenwei = false ;
                              boolean isbill_zhuxituan = false;
                              String class_name ="ys shencha" ;
                              
                        %>
                        <tr ondblclick="ck_dbaclclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td  class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <td class="title no"><% out.print(list.get("title")); %>
                             <%
                               if (list.get("importance").equals("2")) {
                                  %> 
                                <em style="color:red;">*</em>
                                  <%
                                  }
                               %>
<!--                        zyx 当建议为重点议案时编号后增加红色*点缀。        --></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("numpeople")); %></td>
                            <td class="lwstate no" lwstate="<% list.write("lwstate"); %>"></td>
                            <td class="permission no" judgment="<% list.write("permission"); %>"></td>
                            <td class="seconded no" seconded="<% list.write("seconded"); %>"></td>
                            <td class="opinioned no" opinioned="<% list.write("opinioned"); %>"></td>
                            <td class="meet no" judgment="<% list.write("meet"); %>"></td>
                            <td class="methoded no" methoded="<% list.write("methoded"); %>"></td>
                            <td class="shijian no" registertype="<% list.write("registertype"); %>"></td>
                            <td class="registertype no" registertype="<% list.write("registertype"); %>"></td>
                            <td class="reviewclass no" companytypeeclassify="<% list.write("reviewclass"); %>"></td>
                            <!--<td class="handle no">-->
                                <%
                                    String handle = "";
                                    int showAudit = 0 ;
                                  
                                    if (list.get("examination").equals("1")) {
                                        handle = "<td class='handle no' style='color:red;font-weight:bold;'>未审查</td>";
                                        showAudit = 1 ;
                                       
                                    }
                                    if (list.get("iscs").equals("1")) {
                                        handle = "<td class='handle no' style='color:IndianRed;font-weight:bold;'>待复审</td>";//待复审31
                                      
                                         if ( ((cookie.Get("powergroupid")).equals("8") && ismeeting ==1) && list.get("examination").equals("5")) {
                                             //这个补丁条件为了解决议审委账号登录议案列表界面初审查状态时，没有审查按钮。
                                             showAudit = 1 ;
                                         }
                                    }
                                    if ( list.get("examination").equals("2") ) {
                                        handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待交办</td>";
                                         if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                            handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                        if ( list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                          showAudit = 1;
                                        }
                                        
                                         
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        //修改闭会乡镇代表流程，提示状态
                                        // handle = "<td class='handle no' style='color:Green'>乡镇政府办已答复</td>";
                                        handle = "<td class='handle no' style='color:DarkOrange;font-weight:bold;'>待交办</td>";
                                        if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                            handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                    }
                                    if (list.get("handlestate").equals("3")) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待交办</td>";
                                        
                                         if ( list.get("deal").equals("1") ) {
                                            handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待办复</td>";//51
                                        }
                                    }

                                    if (list.get("handlestate").equals("4")) {
                                        handle = "<td class='handle no' style='color:red;font-weight:bold;'>已驳回</td>";
                                    }   
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        handle = "<td class='handle no' style='color:Olive;font-weight:bold;'>已办复</td>";
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "<td class='handle no' style='color:CadetBlue;font-weight:bold;'>已置回</td> ";
                                    }
                                    
                                    if ( list.get("workflow").equals("0") ) {
                                         handle = "<td class='handle no'style='color:red;font-weight:bold;' >未审查</td>";
                                         showAudit =  0 ;
                                         if ( list.get("examination").equals("1") ){
                                             showAudit = 1 ;
                                         }
                                    }
                                    else if ( list.get("workflow").equals("1") ) { //代表团处理过，下一步是议审委
                                        handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        showAudit =  0 ;
                                        if ( cookie.Get("powergroupid").equals("8") && list.get("lwstate").equals("2")) {
                                            showAudit = 1 ;
                                            isbill_yishenwei = true ;
                                            class_name ="ys bill_yishenwei_shencha" ;
                                        }
                                    }
                                    else if ( list.get("workflow").equals("2") ) { //议审委已审查过
                                        
                                        handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待大会主席团表决</td>";
                                       showAudit =  0 ;
                                     if ( cookie.Get("powergroupid").equals("25") && list.get("lwstate").equals("2")) {
                                        showAudit = 1 ;
                                        isbill_zhuxituan = true ;
                                        class_name ="ys bill_zhuxituan_shencha" ;
                                     }
                                  }
                                  else if ( list.get("workflow").equals("3") ) { //议审委已审查过
                                        
                                    handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待办理</td>";
                                    showAudit =  0 ;
//                                    if ( cookie.Get("powergroupid").equals("25") && list.get("lwstate").equals("2")) {
//                                        showAudit = 1 ;
//                                        isbill_zhuxituan = true ;
//                                        class_name ="ys bill_zhuxituan_shencha" ;
//                                     }
                                  }
                                    
                                    
                                    
                                    out.print(handle);
                                    
                                %>
                            <!--</td>-->
                            <td class="realcompanyname">
                                <%
                                    RssListView company = new RssListView(pageContext, "company_sug");
                                    String companyname = "";
                                    company.select().where("id=" + list.get("id")).query();
                                    while (company.for_in_rows()) {
                                        companyname += company.get("allname") + ",";
                                    }
                                    if (!companyname.equals("")) {
                                        companyname = companyname.substring(0, companyname.length() - 1);
                                    }
                                    if (companyname.equals("")) {
                                        companyname = "暂无";
                                    }
                                    out.print(companyname);
                                %>
                            </td>
<!--                            <td><% out.print(list.get("allname")); %></td>
                            <td><% out.print(list.get("dbtdh")); %></td>-->
                             <%
                                    if (cookie.Get("powergroupid").equals("8")) {
                                %>
<!--                             zyx.   重点议案列，只有仪申委登录的时候才显示 -->
                            <td>
                               <%
                               if (list.get("importance").equals("1")) { 
                                  %>
                                 是<input class="shi" id="<% out.print(list.get("id")); %>" name="<% out.print(list.get("id")); %>"  type="radio" type="button" value="1">
                              <button style="width:6px;"></button>
                               否<input class="fou" id="<% out.print(list.get("id")); %>" name="<% out.print(list.get("id")); %>"  checked="checked" type="radio" value="2">
                               <%
                               }else{
                                   %>
                               是<input class="shi" id="<% out.print(list.get("id")); %>" name="<% out.print(list.get("id")); %>" checked="checked" type="radio" value="1" >
                              <button style="width:6px;"></button>
                               否<input  class="fou" id="<% out.print(list.get("id")); %>" name="<% out.print(list.get("id")); %>"  type="radio" value="2">
                                  <%
                                  }
                               %>
                            </td>
                             <%
                                }else{
                                %>
                                <td style="font-size:14px;"> <% 
                                    if ( list.get("importance").equals("1" ))
                                    out.print("<em style='color:green;font-weight:bold;'>否</em>"); 
                                    else
                                    out.print("<em style='color:red;font-weight:bold;'>是</em>"); 
                                %>
                            </td>
                            <%
                             }
                            %>
<!--                            zyx修改，当importance=1默认否，如果importance=2是就会点亮-->               
                            <td>
                              <%                                   
                                if( powerid != null && ("8".equals( powerid ) || ("7").equals( powerid ) || ("22").equals( powerid ) || ("25").equals( powerid ) ) && (showAudit==1) ){
                                    %>
                                        <span class="<%out.print(class_name);%>" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">审查</span> | 
                                        
                                         <!--<span class="ys shencha" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">审查</span> |--> 
                                        <!--<span class="ys shencha" id="<% out.print(list.get("id")); %>" style="color: blue;">审查</span><span class="shencha1"> | </span>-->
                                <%
                                    }
                                %>
                         <span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看内容</span> 
                        <% 
                            if (("5").equals( powerid )){
                            %> 
                            | <span class="ys bianji" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">编辑</span>
                            <%
                               };
                            %> 
                            <!--zyx增加，只有个人代表需要编辑-->
                        <%   
                         if( isShowDeleteBtn ){
                        %>
                        |<span class="ys delete" style="font-weight:bold;" id="<% out.print(list.get("id")); %>" myid="<% out.print(list.get("myid")); %>">删除</span> 
                        <%
                        }
                        %>
                        |<span class="ys liucheng" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看流程</span> 
		</td>
                        </tr>
                        <%
                                a++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="footer">
                每页条数<select id="footerpagesize" dict-select="pagesize" def="<% out.print(list.get("pagesize"));%>"></select>
                <%
                    Pagination pagination = new Pagination(list, request);
                    pagination.pageinfo().firstpage().looppage().lastpage().display(out);
                %>
            </div>
        </form>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="controller.js"></script>
        <script src="/liuChengSwitch.js"></script>
        <script>
           
//          判断
            $(function(){
                if(shenchaanniu !== 1){
                    $(".shencha").remove();
                    $(".shencha1").remove();
                }
            });
            
            $(function(){
                ﻿$(".shencha").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/examine/butreview.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 830, height: 600});
                })
            });
            $(function(){
                ﻿$(".bill_yishenwei_shencha").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/examine/butreview_yishenwei.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 830, height: 600});
                })
            });
            
            $(function(){
                ﻿$(".bill_zhuxituan_shencha").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/examine/butreview_zhuxituan.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 830, height: 600});
                })
            });
            
            
            
            
            $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/billlist/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 830, height: 560});
                })
            });
            $(function(){
                ﻿$(".bianji").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/billlist/editupdate.jsp?id=" + id + "&TB_iframe=true", '编辑', {width: 832, height: 560});
                })
            });
            $(function(){
                ﻿$(".delete").click(function(){
                    let id = $(this).attr("id");
                    let myid = $(this).attr("myid");
                    popuplayer.display("/billlist/delete.jsp?id=" + id + "&myid="+myid, '删除', {width: 300, height: 80});
                })
            });
            $(function(){
                ﻿$(".liucheng").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                })
            });
		transadapter["prints"] = function (t)
		{
			location.href="/report/print.jsp?id=" + transadapter.id
			//popuplayer.display("/report/print.jsp?id=" + transadapter.id + "&TB_iframe=true", '导出', {width: 550, height: 550});
		}
                            $(".setup").click(function () {
                                if ($(".toolbar>ul").attr("wz") == "0") {
                                    $(".toolbar>ul").attr("wz", "1")
                                    $(".toolbar>ul").animate({"right": 0}, 500);
                                } else {
                                    $(".toolbar>ul").attr("wz", "0")
                                    $(".toolbar>ul").animate({"right": -180}, 500);
                                }
                            })
                            $(".toolbar ul>li").click(function () {
                                $(".no").hide();
                                listshow();
                            })
                            listshow();
                            function listshow() {
                                $("[name='field']").each(function () {
                                    if ($(this).is(":checked")) {
                                        var sel = $(this).attr("sel");
                                        if (sel != undefined && sel != "") {
                                            $("." + sel).show();
                                        }
                                    }
                                })
                            }
                           
                            
                            
                        
                             $(".shi").click(function () {
                                  let id = $(this).attr("id");
                          popuplayer.display("/billlist/butimportance_2.jsp?id=" + id + "&TB_iframe=true" );
                            })   
                              $(".fou").click(function () {
                         let idd = $(this).attr("id");
                          popuplayer.display("/billlist/butimportance_1.jsp?id=" + idd + "&TB_iframe=true");
                            })   
                             var value = $('input:radio[name="importance"]:checked').val();
//                             zyx importance的值传入数据库
        </script>
