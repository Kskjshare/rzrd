<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
    StaffList.IsLogin(request, response);
    RssList entity2 = new RssList(pageContext, "contactstationcityrepresentative");
    RssList entity = new RssList(pageContext, "contactstationcityrepresentative");
    entity.request();
    entity2.request();
    if (!entity2.get("action").isEmpty()) {
        if("append".equals(entity2.get("action"))) {
                if(entity.get("myid") != null && !"".equals(entity.get("myid"))){
                    
                    entity2.append().submit();
                }
                
//            case "update":
//                entity2.remove("id");
//                entity2.update().where("id=?", entity2.get("id")).submit();
//                break;
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
            #tabheader{background: #82bee9;text-align: center; color: #fff;}
            .dce{background: #dce6f5;text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor>tbody>tr>td>textarea{height: 50px; margin: 3px 0;width: 170px;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
        </style>
    </head>
    <body>
                <form method="post" id="mainwrap">
            <div class="toolbar">
                <input type="text" name="searchkey"><button class="quicksearch">查询</button>
            </div>
            <div class="bodywrap">
                <table class="wp100 tc cellbor" id="section">
                    <thead>
                        <tr>
                            <th class="w30"></th>
                            <th class="w30"><input name="all"  type="checkbox"></th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>代表团</th>
                            <th>职务</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
  //                          CookieHelper cookie = new CookieHelper(request, response);
  //                          HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
  //                          RssListView list = new RssListView(pageContext, "user_delegation");
  //                          list.request();
  //                          int a = 1;
  //                          list.pagesize = 30;
  //                          list.select().where("state=2 and (realname like '%" + list.get("searchkey") + "%' or code like '%" + list.get("searchkey") + "%') and mission like '%" + req.get("mission") + "%' and myid<>" + cookie.Get("myid")).get_page_desc("myid");
  //                          while (list.for_in_rows()) {
                     //开始获取realname满足的myid
//                                RssList user = new RssList(pageContext, "user");
                                RssList delegationids = new RssList(pageContext, "delegationlevel");
                                delegationids.select().get_page_asc("id");
                                List<String> list11 = new ArrayList();
                                while (delegationids.for_in_rows()) {
//                                    if(delegationids.get("myid") != null && !delegationids.get("myid").equals("")){
                                        list11.add(delegationids.get("accountid"));
//                                        System.out.println("123");
//                                    }
                                }
                                String accountids = "";
                                if(list11.size() > 0){
//                                    System.out.println("456");
                                    accountids = String.join(",", list11);
//                                    sql += " and myid in ( " + myids + " )";
//                                    System.out.println(accountids);
                                    RssList list = new RssList(pageContext, "user");
                                    list.pagesize = 500;
                                    list.select().where(" mission in ("+ accountids +")").get_page_asc("myid");
                                    int a = 1;
                                    while (list.for_in_rows()) {
                        %>
                        <tr>
                            <td class="w30"><% out.print(a); %></td>
                            <td><input type="checkbox" name="id" value="<% out.print(list.get("myid")); %>" /></td>
                            <td><% out.print(list.get("code")); %></td>
                            <td><% out.print(list.get("realname")); %></td>
                            <td><% out.print(list.get("delegationname")); %></td>
                            <td><% out.print(list.get("daibiaoDWjob")); %></td>
                            <td style="display: none;"><% out.print(list.get("daibiaoDWaddress")); %></td>
                            <td style="display: none;"><% out.print(list.get("telphone")); %></td>
                        </tr>
                        <%
                                a++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
  <!--          <div class="footer">
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
            </div>
        </div>
    </form> -->
            <div class="footer">
                <input type="hidden" name="action" value="append"/>
                <button type="submit">增加</button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/street.js"></script>
        <script>
//            $("#myid").click(function () {
//                RssWin.onwinreceivemsg = function (dict) {
//                    console.log(dict);
//                    $("#myid").val(dict.myname)
//                    $("[name='myid']").val(dict.myid)
//                }
//                RssWin.open("/selectwin/selectoneuser_1.jsp?state=4", 600, 500);
//            })
//            var selected = $("[name='street']").val()
//            $.each(dictdata["ssxarea"], function (k, v) {
//                if (v[1] != "0") {
//                    if (selected == k) {
//                        $("#street").append("<option selected='selected' value='" + k + "' pid='" + v[1] + "'>" + v[0] + "</option>")
//                    } else {
//                        $("#street").append("<option value='" + k + "' pid='" + v[1] + "'>" + v[0] + "</option>")
//                    }
//                }
//            })
//            $("#street").change(function () {
//                $("[name='street']").val($("#street").val());
//            })


        $('.footer>button').click(function () {
            var tid = [], rid = "";
            $("[name='id']").each(function () {
                if ($(this).is(":checked")) {
                    tid.push($(this).attr("value"));
                }
            });
            rid = tid.join(",");
            RssWin.winsendmsg(e);
            window.close();
        });
        </script>
    </body>
</html>
