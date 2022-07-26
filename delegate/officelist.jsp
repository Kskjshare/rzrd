<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.User.UserMessageList"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView list = new RssListView(pageContext, "user_delegation");
    list.request();
    boolean myhavexiancircle = false;//当前用户所属层次
    String mymission = "";//当前用户所属的代表团
%>
<%@include file="/data/contants.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>汝州市人大代表履职服务平台</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #mainwrap>ul{overflow: auto;margin: 3px 15px;float: left;width: 100%}
            #mainwrap>ul>li{float: left;padding: 6px 20px; border: #eee solid 1px; margin: 2px 5px; border-radius: 5px; background: #dce6f5;cursor: pointer;background: url("/css/limg/buttonbg.png") no-repeat;background-size: 100% 100%;}
            #mainwrap>ol{overflow: auto;width: 100% ;height: 80%}
            #mainwrap>ol>li{ float: left;width: 100px;margin: 10px; height: 130px;position: relative; border-radius: 5px; border: #eee solid 1px;overflow: hidden;}
            #mainwrap>ol>li>input{display: none;}
            #mainwrap>ol>li.sel{border: #6caddc solid 1px;}
            #mainwrap>ol>li>img{ width: 100%;min-height: 110px;}
            #mainwrap>ol>li>h6{position: absolute;width: 100%;bottom: 0;background: #fff;height: 24px;text-align: center;line-height: 24px;}
            #mainwrap>ul>li.sel{background: url("/css/limg/buttonbg2.png") no-repeat;background-size: 100% 100%;}
            /*#mainwrap{overflow: auto;}*/
            #missionul{display: none;margin: 0 15px; padding: 5px; border-top: #000 solid 1px}
            tbody tr:hover{background-color: gainsboro;}
            #select{
                border: none;
                appearance: none;
                -moz-appearance: none;
                -webkit-appearance: none;
            }
            #select::-ms-expand { display: none; }
        </style>
    </head>
    <body>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="quicksearch" select="false" class="quicksearch">查询</button>
                <button type="button" transadapter="append" select="false" class="butadd"  powerid="114">增加</button>
                <button type="button" transadapter="edit" class="butedit" powerid="115" >编辑</button>
                <button type="button" transadapter="delete" class="butdelect"  powerid="116">删除</button>
                <button type="button" transadapter="butview" class="butview"  powerid="117">查看</button>
                <button type="button" transadapter="change" class="butview"  powerid="118">换届</button>
                <button type="button" transadapter="apd" select="false" class="butreports" powerid="119" >导入</button>
                <button type="button" transadapter="export" class="butreports" powerid="120" >导出</button>
                <!--<button type="button" class="setup">样式切换</button>-->
                <input type="hidden" id="transadapter" find="[name='id']:checked" />
                <input type="hidden" name="listtype" value="<% out.print(list.get("listtype").isEmpty() || list.get("listtype").equals("list") ? "view" : "list"); %>">
            </div>
            <%
                if (list.get("listtype").equals("list") || list.get("listtype").isEmpty()) {
            %>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th class="w50">序号</th>
                            <th>姓名</th>
                            <!--<th>代表证号</th>-->
                            <th>性别</th>
                            <th>民族</th>
                            <!--<th>出生年月</th>-->
                            <th>职务</th>
                            <th>通讯住址</th>
                            <th>手机号码</th>
                            <th>登录账号</th>
                            <!--<th>层次</th>-->
                            <!--<th>代表团</th>-->
                            <!--<th>届次</th>-->

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //取当前用户所属代表团
                            RssListView onedelegation = new RssListView(pageContext, "user_delegation");
                            onedelegation.select().where("myid = " + UserList.MyID(request)).query();
                            while (onedelegation.for_in_rows()) {
                                mymission = onedelegation.get("mission");
                            }
                            //取当前用户所属层次0乡镇1区县2地市3自治区4全国
                            RssListView onecirecles = new RssListView(pageContext, "user_delegation");
                            onecirecles.select().where("myid = " + UserList.MyID(request)).query();

                            while (onecirecles.for_in_rows()) {
                                myhavexiancircle = onecirecles.get("circleslist").contains("1");
                            }

                            //取当前用户所属角色权限
                            //5":"代表","22":"代表团管理员","8":"选联委","18":"主办单位","23":"县政府办",
                            //"24":"单位联系人","25":"乡、镇政府办","15":"维护人员","16":"系统管理员"
                            // String str_test="0";
                            int a = 1;
                            if (!list.get("pagesize").isEmpty()) {
                                list.pagesize = Integer.valueOf(list.get("pagesize"));
                            } else {
                                list.pagesize = 30;
                            }
                            if (!list.get("curpage").isEmpty()) {
                                int cpage = 1;
                                int csixe = list.get("pagesize").isEmpty() ? 30 : Integer.valueOf(list.get("pagesize"));
                                cpage = Integer.valueOf(list.get("curpage")) - 1;
                                a = cpage * csixe + 1;
                            }
                            CookieHelper cookie = new CookieHelper(request, response);
                            String powerid = cookie.Get("powergroupid");
                            String sql = "";

                            //如果是代表则只能看本代表团的所有代表信息
                            //if (powerid.equals("16") || powerid.equals("8") || UserList.MyID(request).equals("1") || powerid.equals("5")) {
                            if (powerid.equals("5")) {
                                //   str_test="1";
                                //if(myhavexiancircle){//不需要判断是否县级代表层次，原需求是县级代表还可以看县级代表信息
                                //sql = "account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and delegationname like '%" + URLDecoder.decode(list.get("delegationname"), "utf-8") + "%' and  telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and sex like '%" + URLDecoder.decode(list.get("sex"), "utf-8") + "%' and nationid like '%" + URLDecoder.decode(list.get("nationid"), "utf-8") + "%' and birthday like '%" + URLDecoder.decode(list.get("birthday"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and state=2 and (mission="+mymission+" or circleslist like '%1%')" ;
                                // }
                                // else{
                                //state用户类型 2:代表 3 单位 4 代表团 5 工作人员//这个视图里的state是userrole表里的，修改后把他取消，用user表里的powergroupid
                                // sql = "account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and delegationname like '%" + URLDecoder.decode(list.get("delegationname"), "utf-8") + "%' and  telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and sex like '%" + URLDecoder.decode(list.get("sex"), "utf-8") + "%' and nationid like '%" + URLDecoder.decode(list.get("nationid"), "utf-8") + "%' and birthday like '%" + URLDecoder.decode(list.get("birthday"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and state=2 and mission="+mymission ;
                                sql = "account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and delegationname like '%" + URLDecoder.decode(list.get("delegationname"), "utf-8") + "%' and  telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and sex like '%" + URLDecoder.decode(list.get("sex"), "utf-8") + "%' and nationid like '%" + URLDecoder.decode(list.get("nationid"), "utf-8") + "%' and birthday like '%" + URLDecoder.decode(list.get("birthday"), "utf-8") + "%' and sessionlist like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and isdelegate=2 and state=2 and mission=" + mymission;
                                // }
                                //否则可以看全部代表信息
                            } else {
                                // str_test="2";
//                                 sql = "account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and delegationname like '%" + URLDecoder.decode(list.get("delegationname"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and sex like '%" + URLDecoder.decode(list.get("sex"), "utf-8") + "%' and nationid like '%" + URLDecoder.decode(list.get("nationid"), "utf-8") + "%' and birthday like '%" + URLDecoder.decode(list.get("birthday"), "utf-8") + "%' and sessionid like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and state=2 and mission like '%" + UserList.MyID(request) +"%'";
                                sql = "account like '%" + URLDecoder.decode(list.get("account"), "utf-8") + "%' and delegationname like '%" + URLDecoder.decode(list.get("delegationname"), "utf-8") + "%' and telphone like '%" + URLDecoder.decode(list.get("telphone"), "utf-8") + "%' and realname like '%" + URLDecoder.decode(list.get("realname"), "utf-8") + "%' and sex like '%" + URLDecoder.decode(list.get("sex"), "utf-8") + "%' and nationid like '%" + URLDecoder.decode(list.get("nationid"), "utf-8") + "%' and birthday like '%" + URLDecoder.decode(list.get("birthday"), "utf-8") + "%' and sessionlist like '%" + URLDecoder.decode(list.get("sessionid"), "utf-8") + "%' and isdelegate=2";
                            }
                            list.select().where(sql).get_page_desc("myid");

                            while (list.for_in_rows()) {
                            
        
                        %>
                        <tr ondblclick="ck_ondblclick();" idd="<% out.print(list.get("myid")); %>" style="cursor:pointer;">
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td class="w30"><% out.print(a); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <!--<td><% out.print(list.get("code")); %></td>-->
                            <td sex="<% out.print(list.get("sex")); %>"></td>
                            <td nationid="<% out.print(list.get("nationid")); %>"></td>
                            <!--<td rssdate="<% out.print(list.get("birthday")); %>,yyyy-MM"></td>-->
                            <td class="tdleft"><% out.print(list.get("daibiaoDWjob")); %></td>
                            <td class="tdleft"><% out.print(list.get("daibiaoDWaddress")); %></td>
                            <td><% out.print(list.get("telphone")); %></td>
                            <td><% out.print(list.get("account")); %></td>

                            <!--<td sessionclassify="<% out.print(list.get("sessionlist")); %>"></td>-->
                                            <!--<td circles="<%  out.print(list.get("circleslist")); %>"></td>-->
                            
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
            <%
            } else {
            %>
            <ul><li circlesnum="4">全国人大代表</li><li circlesnum="3">自治区人大代表</li><li circlesnum="2">市人大代表</li><li circlesnum="1">自治县人大代表</li><li circlesnum="0">乡镇人大代表</li></ul>
            <ul id="missionul">
                <%
                    RssListView delegation = new RssListView(pageContext, "userrole");
                    delegation.select().where("state like '%4%' and level =0").query();
                    while (delegation.for_in_rows()) {
                %>
                <li levelnum="<% out.print(delegation.get("level"));%>" missionmyid="<% out.print(delegation.get("myid"));%>" stringallname="<% out.print(delegation.get("allname"));%>"></li>
                    <%
                        }
                    %>
            </ul>
            <ol></ol>
            <%
                }
            %>
        </form>
        <!--<script src="/data/suggest.js" type="text/javascript"></script>-->
        <%@include  file="/inc/js.html" %>
        <script src="../data/session.js" type="text/javascript"></script>
        <script src="controller.js"></script>
        <script>
                            $(".setup").click(function () {
                                location.href = "/delegate/listpic.jsp"
                            })

        </script>
    </body>
</html>