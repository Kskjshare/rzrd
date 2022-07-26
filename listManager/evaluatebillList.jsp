<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>


<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    
    RssList permission = new RssList(pageContext, "permission");
    permission.request();
    //String sql = "title like '%" + URLDecoder.decode(permission.get("title"), "utf-8") + "%'";
    //permission.select().where(sql).get_page_desc("id");
    String sql = "switch=1 and state=1";
    permission.select().where(sql).get_first_rows();
    String swtich = permission.get("switch");
    
    
      //时间判断

    Date nowTime = new Date(System.currentTimeMillis());
    //SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
    SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
    String retStrFormatNowDate = sdFormatter.format(nowTime);

    String datasplit [] = retStrFormatNowDate.split("-");                 
    int sysYear = Integer.valueOf( datasplit[0]).intValue();
    int sysMonth = Integer.valueOf( datasplit[1]).intValue();
    int sysDay = Integer.valueOf( datasplit[2]).intValue();

    nowTime = new Date(Long.parseLong( permission.get("beginshijian") )*1000);
    sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
    retStrFormatNowDate = sdFormatter.format(nowTime);
    String datasplit1 [] = retStrFormatNowDate.split("-");          
    int beginYear = Integer.valueOf( datasplit1[0]).intValue();
    int beginMonth = Integer.valueOf( datasplit1[1]).intValue();
    int beginDay = Integer.valueOf( datasplit1[2]).intValue();

    nowTime = new Date(Long.parseLong( permission.get("finishshijian") )*1000);
    sdFormatter = new SimpleDateFormat("yyyy-MM-dd");
    retStrFormatNowDate = sdFormatter.format(nowTime);
    String datasplit2 [] = retStrFormatNowDate.split("-");          
    int finishYear = Integer.valueOf( datasplit2[0]).intValue();
    int finishMonth = Integer.valueOf( datasplit2[1]).intValue();
    int finishDay = Integer.valueOf( datasplit2[2]).intValue();

    int showWarningBar = 0;
    String warningText = "测评进行中";
    if ( sysYear >=  beginYear && sysYear <=  finishYear ) {
         if ( sysMonth ==  beginMonth && sysMonth ==  finishMonth ) {
             if ( sysDay >= beginDay && sysDay <= finishDay  ) {
                 //state = "测评进行中";
                
             }
             else if (  sysDay < beginDay ) {
                  warningText = "测评未开始，目前不能进行测评。";

             }
             else if (  sysDay > finishDay ) {
                  //out.print("活动已结束");
                   warningText = "测评已结束，目前不能进行测评。";
                   showWarningBar = 1 ;
             }
         }
         else if ( sysMonth >  finishMonth ) {

              warningText = "测评已结束，目前不能进行测评。";
              showWarningBar =  1;

        }
        else if ( sysMonth <  beginMonth ) {

              warningText = "测评未开始，目前不能进行测评。";
              showWarningBar =  1;

        }
    }
    else if ( sysYear  >  finishYear ) {

         warningText = "测评已结束，目前不能进行测评。";
         showWarningBar = 1 ;
    }

    if ( swtich.equals("0")) {
         warningText = "测评已关闭，目前不能进行测评。";
         showWarningBar = 1 ;
    }
    
    
     //判断是否测评过
    RssList overall_satisfaction = new RssList(pageContext, "overall_satisfaction");
    overall_satisfaction.request();

    
    
    
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="http://at.alicdn.com/t/font_2302402_bg6iekzy8yi.css" rel="stylesheet" />
        <script src="./api/ch.js"></script>
        <style>
            .cellbor tbody>.sel>td{background: #dce6f5}
            .toolbar>ul{position: absolute;right: -180px ;top:33px; z-index: 2;width: 170px;line-height: 26px;font-size: 14px;background: #FFF;border: #cbcbcb solid thin;border-radius: 5px}
            .toolbar>ul input{margin: 0 5px}
            .no{display: none}
            tbody tr:hover{background-color: gainsboro;}
            /*.zhongdian{float: right; margin-right: 20px;}*/
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
                    if (!(entity.get("draft").equals("1"))) {
                %>
                <!--<button type="button" transadapter="edit" class="butedit" powerid="147">编辑</button>-->
                <button type="button" transadapter="delete" class="butdelect" powerid="148">删除</button>
                <%
                    }
                %>
                <!-- removed by ding --->
                <!--button type="button" transadapter="butreview" class="butreview" powerid="150">审查</button-->
                <!--<button type="button" transadapter="butview" class="butview" powerid="149">查看</button>-->
                <!--button type="button" transadapter="butimportance" class="butimportance" powerid="142">重点建议</button-->
                <!--                
                <button type="button" transadapter="butexcellent" class="butexcellent" powerid="152">优秀建议</button>
                <button type="button" transadapter="importancelist" select="false" class="butexcellent" powerid="143"><% out.print(URLDecoder.decode(req.get("importance"), "utf-8").equals("2") ? "展示全部建议" : "罗列重点建议");%></button>
                <button type="button" transadapter="butreports" select="false" class="butreports" powerid="153">报表</button>
                <button type="button" transadapter="print" class="butimportance" powerid="">打印</button>
               
                <button type="button" id="prints" transadapter="prints" class="butimportance">导出</button>
                -->
                <button type="button" class="setup" style="display: none;">设置</button>
                <!--<div style="display: inline; position: relative;"><i onclick="reload()" class="iconfont iconshuaxin" style="cursor: pointer; font-size:18px; color:#56c21e; position: relative; top: 4px; right:2px;"></i></div><input onclick="reload()" type="button" value="刷新" style="cursor: pointer; border:none; background-color: #ffffff; color: #2d6c86;" />-->
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
                        
                        <%
                        if ( cookie.Get("powergroupid").equals("5") && ( showWarningBar == 1 )){                          
                        %>
                        <tr>                  
                        <td colspan="20" class="tabheader" style="font-size:22px;font-weight: bold"><%out.print(warningText);%></td>                        
                        </tr>
                         <%
                        }  
                        %>
                        
                        <tr>
                            <th class="w50">序号</th>
                            <th class="w30"><input name="all" type="checkbox"></th>
                            <!--<th class="w60">来文号</th>
                            <th class="w60">编号</th>
                            -->
                            <th class="title no">标题</th>
                            <th class="myid">领衔代表</th>
                            <th>人数</th>
                            <th class="lwstate no">类型</th>
                            <th class="permission no">可否网上公开</th>
                            <th class="seconded no">可否联名提出</th>
                            <th class="opinioned no">征求意见方式</th>
                            <th class="meet no">是否会上</th>
                            <th class="methoded no">处理方式</th>
                            <th class="shijian no">提交日期</th>
                            <th class="registertype no">立案形式</th>
                            <th class="reviewclass no">审查分类</th>
                            <th class="handle no">进度</th>
                          
                            <!--<th class="realcompanyname no">测评结果</th>-->
                            
                            <th class="handle no">操作</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String powerid = cookie.Get("powergroupid");
                            String keywhere = "";
                            String view = "sort";
                            switch (powerid) {
                                case "5":    //代表//环节1                           
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
                                            URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" +
                                            URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and lwstate=5 and draft=2 and myid=" + cookie.Get("myid");
                                    break;
                                case "7": //议审委//added by jackie  ding 选工委
                                          //在flowtype为1代表团初审流程且代表层次为县级层次选时不出现//环节0
                                          //在flowtype为1代表团初审流程时且代表层次为乡镇层次不出现////环节0
                                          //在flowtype为2//flowtype_ysw21议审委初审在大会期间流程时出现//环节2
                                          //在flowtype为2//flowtype_ysw22议审委初审不在大会期间流程时不出现//环节0
                                    view = "sort";
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + 
                                            "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + 
//                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
//                                            "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + 
//                                            "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            
                                            
                                            //梁小竹修改
                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' ";
                                    
                                     //added by ding 汝州项目选工委只能审批市代表，所以加一个level条件查找记录
                                   
                          
                                    keywhere += " and level=1";
                                    if(req.get("realcompanyname") != null && !"".equals(req.get("realcompanyname"))){
                                        keywhere += " and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' ";
                                    }
                                    keywhere += 
                                            " and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + 
                                            "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + 
                                            "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + 
                                            "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + 
                                            "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + 
                                            "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + 
                                            "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
                                            "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=2 and isysw=21";
//                                    System.out.println("1------------------------------------" + keywhere);
                                    break;
                                case "22": //代表团(审查)
                                           //在flowtype为1代表团初审流程且代表层次为县级层次时出现//环节2
                                          //在flowtype为1代表团初审流程时且代表层次为乡镇层次出现////环节2
                                          //在flowtype为2//flowtype_ysw21议审委初审在大会期间流程时不出现//环节0
                                          //在flowtype为2//flowtype_ysw22议审委初审不在大会期间流程时不出现//环节0
                                    //view = "scr_suggest";
                                      if ( meetingTime.equals("1")) {
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + //---------------
                                            "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + //------------
                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
                                            "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + 
                                            "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + 
                                            "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + 
                                            "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + 
                                            "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + 
                                            "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + 
                                            "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + 
                                            "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
                                            "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=2 and ismeet=1 and mission=" + cookie.Get("myid");
                                      }else{
                                           keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + //---------------
                                            "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + //------------
                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
                                            "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + 
                                            "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + 
                                            "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + 
                                            "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + 
                                            "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + 
                                            "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + 
                                            "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + 
                                            "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
                                            "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=1 and ismeet=0 and mission=" + cookie.Get("myid");
                                      }
                                    //梁小竹注释
//                                    System.out.println("11111111111111111111"+keywhere);
                                    break;
                                case "8": //选联委(审查)或人代委  ding:议审委
                                          //在flowtype为1代表团初审流程时且代表层次为县级层次选联委出现//环节3
                                          //在flowtype为1代表团初审流程时且代表层次为乡镇层次选联委不出现////环节0
                                          //在flowtype为2//flowtype_ysw21议审委初审在大会期间流程时出现//环节3
                                          //在flowtype为2//flowtype_ysw22议审委初审不在大会期间流程时出现//环节3，议审委环节为还为2不出现
                                    view = "sort";
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + 
                                            URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + 
                                            URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" +
                                            URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and allname like '%" +
                                            URLDecoder.decode(req.get("allname"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and sessionid like '%" + 
                                            URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and telphone like '%" +
                                            URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" +
                                            URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=2 and  isysw=0";
                                    
                                    //打个补丁大会期间议审委账号登录看不到记录
                                    if ( meetingTime.equals("1")) {
                                         keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + 
                                            URLDecoder.decode(req.get("title"), "utf-8") + "%' and methoded like '%" + 
                                            URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" +
                                            URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and allname like '%" +
                                            URLDecoder.decode(req.get("allname"), "utf-8") + "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and sessionid like '%" + 
                                            URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and telphone like '%" +
                                            URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" +
                                            URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=2 and  isysw=21";
                                    }
                                    break;
                                case "25": //乡镇(审查)//环节3/在flowtype为1代表团初审时流程，乡镇层次支流程
                                          //在flowtype为1代表团初审流程时且代表层次为县级层次选联委不出现//环节0
                                          //在flowtype为1代表团初审流程时且代表层次为乡镇层次选联委出现////环节3
                                          //在flowtype为2//flowtype_ysw21议审委初审在大会期间流程时不出现//环节0
                                          //在flowtype为2//flowtype_ysw22议审委初审不在大会期间流程时不出现//环节0
                                    view = "scr_suggest";
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + 
                                            "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + 
                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
                                            "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + 
                                            "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + 
                                            "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + 
                                            "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + 
                                            "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + 
                                            "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + 
                                            "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + 
                                            "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
                                            "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=2 ";
                                     //"%' and lwstate=1 and draft=2 and (fsrID=" + cookie.Get("myid")+" or xzscID=" + cookie.Get("myid")+")";
                                    //added by ding 汝州项目乡镇人大主席团只能审批乡镇代表，所以加一个level条件查找记录
                                    keywhere += " and level=0";
                                    if ( meetingTime.equals("1") ) {
                                        keywhere += " and examination= 2";// ding change 2 to 5 2021.3.31
                                    }
                                    
                                    //梁小竹注释 xzscID 乡镇政府办id    ，fsrID 选联委id
//                                    System.out.println("11111111111111111111"+keywhere);
                                    break;
                                case "23": //政府(交办)//环节4   //ding督察局
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + 
                                            "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + 
                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' ";
//                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + 
//                                            "%' and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + 
//                                            "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                   //added by ding 汝州项目督察局只能审批市级代表，所以加一个level条件查找记录  
                                     keywhere += " and level=1";
                                            //梁小竹修改
                                    if(req.get("realcompanyname") != null && !"".equals(req.get("realcompanyname"))){
                                        keywhere += " and realcompanyname like '%" + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' ";
                                    }
                                    keywhere += 
                                            " and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + 
                                            "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + 
                                            "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + 
                                            "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + 
                                            "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + 
                                            "%' and lwstate=5 and draft=2 and examination =2";
                                    
//                                    System.out.println("2------------------------------------" + keywhere);
                                    break;
                                case "18": //办理单位(办理)//环节5
                                    view = "company_sug";
//                                    String rid = cookie.Get("parentid");
//                                    if (rid.equals("0")) {
//                                        rid = cookie.Get("myid");
//                                    }
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") + 
                                            "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" + 
                                            URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + 
                                            "%' and importance like '%" + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8")
                                            + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and realid like '%" 
                                            + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8")
                                            + "%' and lwstate=5 and draft=2 and deal =1";// and companyid=" + cookie.Get("myid");
                                    
                                    if ( meetingTime.equals("1") ) {
                                        keywhere += " and ismeet= 1";
                                    }
                                    else {
                                        keywhere += " and ismeet= 0";
                                    }
                                    break;
                                default://commented by jackie
                                    keywhere = "realname like '%" + URLDecoder.decode(req.get("realname"), "utf-8") + "%' and title like '%" + URLDecoder.decode(req.get("title"), "utf-8") 
                                            + "%' and methoded like '%" + URLDecoder.decode(req.get("methoded"), "utf-8") + "%' and realcompanyname like '%" 
                                            + URLDecoder.decode(req.get("realcompanyname"), "utf-8") + "%' and lwid like '%" + URLDecoder.decode(req.get("lwid"), "utf-8") + "%' and importance like '%" 
                                            + URLDecoder.decode(req.get("importance"), "utf-8") + "%' and allname like '%" + URLDecoder.decode(req.get("allname"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(req.get("sessionid"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(req.get("telphone"), "utf-8") + "%' and realid like '%" + URLDecoder.decode(req.get("realid"), "utf-8") + "%' and ProposedBill like '%" + URLDecoder.decode(req.get("ProposedBill"), "utf-8") + "%' and year like '%" + URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" + URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and lwstate=5 and draft=2";
                                    break;
                            }
                            
                            
                            
                            
                            
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
                                            URLDecoder.decode(req.get("year"), "utf-8") + "%' and meetingnum like '%" +
                                            URLDecoder.decode(req.get("meetingnum"), "utf-8") + "%' and draft=2 and lwstate=2" ;    
                            
//                            System.out.println("表是这个表--------------------------------" + view);
                            RssListView list = new RssListView(pageContext, view); 
                            list.request();
 
//                        if ( meetingTime.equals("1")){
//                            keywhere += " and ismeet=1";
//                         }
//                        else {
//                            keywhere += " and ismeet=0";
//                         }
                               
                            
//                            if (!list.get("pagesize").isEmpty()) {
//                            list.pagesize = Integer.valueOf(list.get("pagesize"));       
//                                }else{
//                            list.pagesize =10;
//                            }
                            int a = 1;
                            list.pagesize = 30;
//                            System.out.println("keywhere::"+keywhere);
                            if ((cookie.Get("powergroupid")).equals("5") || (cookie.Get("powergroupid")).equals("22")  ) {
                                list.select().where(keywhere).get_page_desc("shijian");
                            } else {
                                list.select().where(keywhere).get_page_desc("realid");
                                
                            }
                            
                            
                    //RssList permission = new RssList(pageContext, "permission");
                    //permission.select().where(sql).get_first_rows();
                    int ismyEvaluation = 0 ;
                    int evaluationDone = 0 ;
                    
 
                    if (!permission.get("objid").equals(",")) {
                        String[] bb = permission.get("objid").split(",");
                         for (int i = 0; i < bb.length; i++) {
                            if (!bb[i].isEmpty())
                            {
                                // out.print("<script>alert('审核通过333')</script>");
                                if (bb[i].equals(UserList.MyID(request)) ){
                                    ismyEvaluation = 1;                                    
                                    break;
                                }
                            }
                        }
                    }
                    
//                    if ( permission.get("objid").contains(",") ) {                        
//                        String[] bb = permission.get("objid").split(",");                             
//                        for (int i = 0; i < bb.length; i++) {
//                            if (!bb[i].isEmpty()) {
//                                if (bb[i].equals(UserList.MyID(request)) ){
//                                    ismyEvaluation = 1;                                    
//                                    break;
//                                }
//                            }
//                        }
//                    }
                    
                    
                    if ( cookie.Get("powergroupid").equals("7") ){
                         ismyEvaluation = 1 ;
                         evaluationDone = 1 ;
                    }
                    else if ( cookie.Get("powergroupid").equals("5") ) {
                        if ( permission.get("switch").equals("0")) {
                            ismyEvaluation = 0 ;
                        }
                        else if ( permission.get("switch").equals("1") &&  permission.get("participate").equals("1")) {
                            ismyEvaluation = 1 ;
                        }
                    }
   
                    
                            
                    
                        int UnitevaluationDone = 0 ;
                        while (list.for_in_rows() ) {

                        evaluationDone =  0 ; 
                        UnitevaluationDone = 0 ;
                        //added by ding
                        if ( ismyEvaluation == 0 ) {
                            break;
                        }
                            


                        //判断用户是否测评过
                        overall_satisfaction.select().where("proposal="+ list.get("id") + " and myid=" + UserList.MyID(request) ).get_first_rows();
                        overall_satisfaction.select().where("proposal="+ list.get("id") ).get_page_desc( "id" );
                        while ( overall_satisfaction.for_in_rows() ) {
                            if ( overall_satisfaction.get( "myid").equals(UserList.MyID(request))){
                               if ( overall_satisfaction.get("evaluationDone").equals("1") ) {
                                
                                if ( overall_satisfaction.get("evaluteType").equals("1") ) {
                                    evaluationDone  = 1 ;
                                }
                                else {
                                   UnitevaluationDone = 1 ;
                                }
                                //evaluationDone = 1 ;
                            }
                            else{
                                if ( overall_satisfaction.get("evaluteType").equals("1") ) {
                                    evaluationDone = 0 ;
                                }
                                else {
                                   UnitevaluationDone = 0 ;
                                }
                                //evaluationDone = 0 ; 
                            }
                                break;
                            }
                        }
                    
                        %>
                        <tr ondblclick="ck_dbdmlclick();" idd="<% out.print(list.get("id")); %>" style="cursor:pointer;">
                            <td  class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("id")); %>" /></td>
                            <!--<td>lw<% // out.print(list.get("lwid")); %></td>
                            <td><% out.print(list.get("realid")); %></td>
                            -->
                            <td class="title no"><% out.print(list.get("title"));%></td>
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
                                <% //examination:    审查状态 1:未审查,2:已审查,3:置回,5:待审查,6:乡镇已审查
                                    //draft:起草1草稿2已提交    待初审    待交办         待复审
                                    //deal:是否已交办 //iscs初审状态（0否 1是)//isxzsc：乡镇政府办审查状态(0否 1是）
                                    //handlestate:（确定办理单位）建议议案办理状态1:未确定,2待确定,3已确定,4申退中//resume:是否办复(0否 1是）
                                    String handle = "";
                                    
                                    //added by ding
                                    int btnAuditShow = 1 ; // 审查按钮
                                  
                                    if (list.get("examination").equals("1")) {
                                        handle = "<td class='handle no' style='color:red;font-weight:bold;'>未审查</td>";//待初审21
                                       
                                    }
                                    if (list.get("iscs").equals("1")) {
                                        handle = "<td class='handle no' style='color:IndianRed;font-weight:bold;'>待复审</td>";//待复审31
                                        if ( meetingTime.equals("1") && powerid.equals("22")){
                                          btnAuditShow =  0 ;
                                         }
                                      
                                    }
                                    if (list.get("examination").equals("2")) {
                                        handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待交办</td>";//待交办41
                                        btnAuditShow = 0 ;
                                         if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                           handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                         if ( list.get("handlestate").equals("1") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                          btnAuditShow = 1;
                                         }
                                    }
                                    if (list.get("isxzsc").equals("1")) {
                                        //修改闭会乡镇代表流程，提示状态
                                        //handle = "<td class='handle no' style='color:Green'>乡镇政府办已答复</td>";//141
                                        handle = "<td class='handle no' style='color:DarkOrange;font-weight:bold;'>待交办</td>";//141
                                        btnAuditShow = 0 ;
                                           if ( list.get("handlestate").equals("2") ){ //建议议案办理状态1:未确定,2待确定,3已确定,4申退中
                                            handle = "<td class='handle no'style='color:DarkOrange;font-weight:bold;' >待复审</td>";
                                        }
                                    }
                                    if (list.get("handlestate").equals("3")) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待交办</td>";//51
                                        btnAuditShow = 0 ;
                                        if ( list.get("deal").equals("1") ) {
                                            handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>待办复</td>";//51
                                        }
                                    }
                                    if (list.get("handlestate").equals("4")) {
                                        handle = "<td class='handle no' style='color:Chocolate;font-weight:bold;'>已驳回</td>";//51
                                        btnAuditShow = 0 ;
                                    }
                                    if (list.get("resume").equals("1") && list.get("examination").equals("2")) {
                                        handle = "<td class='handle no' style='color:Olive;font-weight:bold;'>已办复</td>";//151
                                        btnAuditShow = 0 ;
                                    }
                                    if (list.get("examination").equals("3")) {
                                        handle = "<td class='handle no' style='color:CadetBlue;font-weight:bold;'>已置回</td>";//121
                                        btnAuditShow = 0 ;
                                    }
                                    out.print(handle);
                                %>
                                <!--</td>-->
                            <!--<td class="realcompanyname no">-->
                                <% 
//                                    RssList sentity = new RssList(pageContext, "overall_satisfaction");
//                                    sentity.request();
//                                    sentity.select().where("myid="+UserList.MyID(request) + " and proposal="+list.get("id") ).get_first_rows();
//                                   
//                                    if ( sentity.get("evaluationDone").equals("1") ){
//                                        String str = sentity.get("evalutaion");
//                                        
//                                        evaluationDone = 1;
//                                        if (str.equals("2")) {
//                                           
//                                             out.print("基本满意");
//                                        }
//                                        else if (str.equals("3")) {
//                                             out.print("不满意");
//                                        }
//                                        else{
//                                          
//                                             out.print("满意");
//                                        }
//                                    }
//                                    else {
//                                        evaluationDone = 0 ;
//                                        out.print("未测评");
//                                                                                
//                                    }
//                                   
//                                    if ( cookie.Get("powergroupid").equals("7")) { //选工委
//                                        evaluationDone = 1;
//                                    }
                                %>
                            <!--</td>-->

                            <td>
                            <span class="ys chakan" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看内容</span>
                            
                             <%
                            if  ( UnitevaluationDone == 0 && showWarningBar == 0 ){
                            %>                         
                             | <span class="ys hanleQuality" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">办理质量</span> 
                            <%
                            }                          
                            %>
                            
                            
                            <%
//                            String pid = cookie.Get("powergroupid");
                            if  ( evaluationDone == 0 && showWarningBar == 0 ){
                            %>
                          
                             | <span class="ys billQuality" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">议案质量</span> 
                             <%
                           }                          
                            %>
                            
                             <%
                            if ( cookie.Get("powergroupid").equals("7") ){
                            %>
                            <!--| <span class="ys detail" style="font-weight:bold;" id="<% out.print(list.get("id")); %>">查看测评详情</span>--> 
                            <%
                            }
                            %>
                            
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
            $(function(){
                if(shenchaanniu !== 1){
                    $(".shencha").remove();
                    $(".shencha1").remove();
                }
            });
            
            $(function(){
                ﻿$(".shencha").click(function(){
                    let id = $(this).attr("id");
                    popuplayer.display("/examine/butreview.jsp?id=" + id + "&TB_iframe=true", '审查', {width: 830, height: 630});
                })
            });
            
            $(function(){
                ﻿$(".chakan").click(function(){
                    let id = $(this).attr("id");
                popuplayer.display("/suggest/butview.jsp?id=" + id + "&TB_iframe=true", '查看', {width: 860, height: 640});
                })
            });
            $(function(){
                ﻿$(".hanleQuality").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                popuplayer.display("/opinion/handleQulity.jsp?id=" + id + "&TB_iframe=true", '办理质量', {width: 830, height:280});
     
                })
            });
             $(function(){
                ﻿$(".billQuality").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                popuplayer.display("/opinion/billQuality.jsp?id=" + id + "&TB_iframe=true", '议案质量', {width: 830, height:280});
     
                })
            });
             $(function(){
                ﻿$(".evaluate").click(function(){
                    let id = $(this).attr("id");
                //popuplayer.display("/suggest/chakanliucheng.jsp?id=" + id + "&TB_iframe=true", '查看流程', {width: 830, height: 560});
                popuplayer.display("/opinion/evaluation.jsp?id=" + id + "&TB_iframe=true", '进行测评', {width: 830, height: 360});
     
                })
            });
            
             $(function(){
                ﻿$(".detail").click(function(){
                    let id = $(this).attr("id");
               
                popuplayer.display("/opinion/evaluation/evaluationview.jsp?id=" + id + "&TB_iframe=true", '查看测评详情', {width: 830, height: 360});
     
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
//            $("#footerpagesize").change(function () {
//                location.href="?curpage1&pagesize="+$(this).val();
//            })

transadapter["delete"] = function (t)
{
    var tid = [], rid = "";
    $("[name='id']").each(function () {
        if ($(this).is(":checked")) {
            tid.push($(this).attr("value"));
        }
    });
    rid = tid.join(",");
    popuplayer.display("/suggest/delete.jsp?id=" + rid + "&TB_iframe=true", '删除', {width: 300, height: 80});
}


transadapter["quicksearch"] = function (t)
{
    popuplayer.display("/listManager/quicksearch_2.jsp", '快速查询', {width: 500, height: 100});
}

        </script>
    </body>
</html>
