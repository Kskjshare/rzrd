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
//    System.out.println(entity.get("rids")+"123");
                if(entity.get("rids") != null && !"".equals(entity.get("rids"))){
                    String rids = entity.get("rids");
                    String[] srids = rids.split(",");
                    entity2.remove();
                    for (int i = 0; i < srids.length; i++) {
                        if (!srids[i].isEmpty()) {
                            RssList user1 = new RssList(pageContext, "user");
//                            user1.pagesize = 500;
                            user1.select().where(" myid = "+ srids[i]).get_first_rows();
                            
                            entity2.keyvalue("myid", srids[i]);//
                            entity2.keyvalue("myidname", user1.get("realname"));//
                            
                            //根据lianluozhanid获取联络站id和name
                            RssList lianLuoZhan = new RssList(pageContext, "contactstation");
                            lianLuoZhan.select().where(" id = "+ entity2.get("cid")).get_first_rows();
                            
                            entity2.keyvalue("contactstationid", lianLuoZhan.get("id"));//
                            entity2.keyvalue("contactstationname", lianLuoZhan.get("name"));//
                            //获取代表团信息
                            RssList daiBiaoTuan = new RssList(pageContext, "user");
                            daiBiaoTuan.select().where(" myid = "+ user1.get("mission")).get_first_rows();
                            
                            entity2.keyvalue("accountid", user1.get("mission"));//
                            entity2.keyvalue("accountname", daiBiaoTuan.get("allname"));//
//                            entity2.append().submit();
                            entity2.remove("rids");
                            entity2.remove("cid");
                            entity2.append().submit();
                            
                        }
                        
                    }
                    PoPupHelper.adapter(out).iframereload();
                            PoPupHelper.adapter(out).showSucceed();
//                    entity2.append().submit();
                }
                
//            case "update":
//                entity2.remove("id");
//                entity2.update().where("id=?", entity2.get("id")).submit();
//                break;
        
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
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <thead>
                        <tr>
                            <th style="border:#6caddc solid thin" class="w30"></th>
                            <th style="border:#6caddc solid thin" class="w30"><input name="all"  type="checkbox"></th>
                            <th style="border:#6caddc solid thin">代表姓名</th>
                            <th style="border:#6caddc solid thin">代表团</th>
                            <!--<th>所属行政村</th>-->
                            <!--<th>代表团</th>-->
                            <!--<th>管理员</th>-->
                            <!--<th>状态</th>-->
                            <!--<th>市直代表入驻情况</th>-->
                            <!--<th>市直属代表入驻信息</th>-->
                        </tr>
                    </thead>
                    <tbody>
                    <%
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
                                    RssList user = new RssList(pageContext, "user");
                                    user.pagesize = 500;
                                    
                                    //查询已加入的
                                    //
                                    entity.pagesize = 5000000;
                                    entity.select().get_page_asc("myid");
                                    List<String> list111 = new ArrayList();
                                    while (entity.for_in_rows()) {
    //                                    if(user.get("myid") != null && !user.get("myid").equals("")){
                                            list111.add(entity.get("myid"));
                                            System.out.println(entity.get("myid")+"每一个");
    //                                    }
                                    }
                                    String myids = "";
    //                                System.out.println("123");
    //                                System.out.println(URLDecoder.decode(list.get("inputname"),"utf-8").equals("管理"));
    //                                System.out.println("456");
                                    if(list111.size() > 0){
    //                                    System.out.println(list11.get(0) + "***");
                                        myids = String.join(",", list111);
    //                                    sql += " and myid in ( " + myids + " )";
    //                                    System.out.println(myids);
                                    }
                                    
                                    System.out.println(myids+" myids");
                                    //结束
                                    
                                    
                                    user.select().where(" mission in ("+ accountids +") and myid not in ("+myids+")").get_page_asc("myid");
                                    int a = 1;
                                    while (user.for_in_rows()) {
                                        %>
                                        <tr ondblclick="ck_dbAbRlclick();" idd="<% out.print(user.get("myid")); %>" myid="<% out.print(user.get("myid")); %>" style="cursor:pointer; text-align: center;">
                                            <td class="w30"><% out.print(a); %></td>
                                            <td class="w30"><input type="checkbox" name="id" value="<% out.print(user.get("myid")); %>"/></td>
                                            <td name="name"><% out.print(user.get("realname")); %></td>
                                            <%
                                                //获取代表团信息
                                                RssList daiBiaoTuan1 = new RssList(pageContext, "user");
                                                daiBiaoTuan1.select().where(" myid = "+ user.get("mission")).get_first_rows();
                                            %>
                                            <td><% out.print(daiBiaoTuan1.get("allname")); %></td>
                                            <!--<td><input type="text" class="w200 Wdate" name="myid" value="<% out.print(user.get("myid")); %>"></td>-->
<!--                                            <td><input type="text" class="w200 Wdate" name="myid" value="<% out.print(user.get("myid")); %>"></td>
                                            <td><input type="text" class="w200 Wdate" name="myid" value="<% out.print(user.get("myid")); %>"></td>-->
                                        </tr>
                                        <%
                                            a++;
                                    }
                                }
//                            }
                            
                            //到此结束
                    %>
                    
                        
                    </tbody>                 
<!--                    <tr>
                        <td class="dce w100 ">联络站名称：</td>
                        <td><input type="text" maxlength="80"  name="name" value="<% entity.write("name"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">行政村：</td>
                        <td><select id="street" name="street" dict-select="ssxarea" def="<% entity.write("street");%>"></select></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">地址：</td>
                        <td><textarea type="text"  name="address" ><% entity.write("address"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">开放时间：</td>
                        <td><input type="text" maxlength="80"  name="opentime" onFocus="WdatePicker({lang: 'zh-cn'})" value="<% entity.write("opentime"); %>" /></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">代表团：</td>
                        <td><input readonly="readonly" id="myid" value="<% entity.write("allname"); %>"><input type="hidden" name="myid" value="<% entity.write("myid"); %>"></td>
                    </tr>-->
                </table>
            </div>
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
//            RssWin.winsendmsg(e);
//            window.close();
            popuplayer.display("/contactstation/append.jsp?rids="+rid+"&cid=<% entity2.write("cid"); %>", '新增入驻代表', {width: 600, height: 400});
//            popuplayer.close();
        });
        </script>
    </body>
</html>
