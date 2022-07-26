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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);

    
    RssList contactstation = new RssList(pageContext, "contactstation");
    contactstation.request();
    
    RssList entity = new RssList(pageContext, "contactstation_sub");
    //CookieHelper cookie = new CookieHelper(request, response);
    //editentity.request();
    
    entity.request();
    
    
    //RssList contactstation_new = new RssList(pageContext, "contactstation_new");
   // contactstation_new.request();
    if (!entity.get("action").isEmpty()) {
        switch (entity.get("action")) {
            case "append":
//                entity.timestamp();
//                editentity.keymyid(cookie.Get("myid"));
                
                
               // contactstation_new.select().where("id=?", entity.get("stationid")).get_first_rows();

                //entity.keyvalue("myid",contactstation_new.get("myid"));
                //entity.keyvalue("stationid",entity.get("stationid"));
                entity.append().submit();
                break;
            case "update":
                //editentity.remove("id");
               // editentity.update().where("id=?", entity.get("id")).submit();
                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    contactstation.select().where("id=?", contactstation.get("stationid")).get_first_rows();
    //entity.select().where("id=?", entity.get("id")).get_first_rows();


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
            .cellbor>tbody>tr>td>textarea{height: 30px; margin: 3px 0;width: 98%;}
            .cellbor>tbody>tr>td>input{height:24px;width: 98%;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">站点名称</td>
                        <td><input type="text" maxlength="80" name="title" value="<% entity.write("title"); %>" /></td>
                    </tr>
                  
                    
                      
                    <!--
                    <tr>
                        <td class="dce w100 ">所属联络站</td>
                        <td id="stationsel">
                            <input class="b95" readonly="readonly" value="<% entity.write("name"); %>"/>
                            <input type="hidden" name="stationid" id="stationid" value="<% entity.write("stationid"); %>"/>
                        </td>
                    </tr>
                   
                    
                    
                     -->
                     
<!--                     <tr>
                        <td class="dce w100 ">开放时间</td>
                        <td><input type="text" maxlength="80"  name="opentime" onFocus="WdatePicker({lang: 'zh-cn'})" value="<% entity.write("opentime"); %>" /></td>
                    </tr>
                   -->
                    
                     <tr>
                        <td class="dce w100 ">地址</td>
                        <td><textarea type="text"  name="address"><% entity.write("address"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">站长</td>
                        <td><textarea type="text"  name="master"><% entity.write("master"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">站长电话</td>
                        <td><textarea type="text"  name="mastertelephone"><% entity.write("mastertelephone"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">联络员</td>
                        <td><textarea type="text"  name="linkman"><% entity.write("linkman"); %></textarea></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">联络员电话</td>
                        <td><textarea type="text"  name="linkmantelephone"><% entity.write("linkmantelephone"); %></textarea></td>
                    </tr>
                    
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "append"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "增加");%></button>
            </div>
        </form>

         <%@include  file="/inc/js.html" %>
        <script src="/data/street.js"></script>
        <script>
            $("#myid").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    alert(dict.myid)
                    console.log(dict);
                    $("#myid").val(dict.myname)
                    $("[name='myid']").val(dict.myid)
                }
                RssWin.open("/selectwin/selectoneuser_1.jsp?state=4", 600, 500);
            })
            $("#stationsel>input").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    var userrolename = [], userroleval = [];
                    $.each(dict, function (k, v) {
                        userrolename.push(v.name)
                        userroleval.push(v.id)                  
                    })
                    $("#stationsel").find("input:first").val(userrolename)
                    $("#stationid").val(userroleval)

                }
                RssWin.open("/contactstation/substation/selectstation.jsp", 700, 650);
            });
            
            $(".footer>button").click(function () {
                if ($("[name='opentime']").val() != undefined && $("[name='opentime']").val() != "") {
                   var timestamp = new Date($("[name='opentime']").val());
                   $("[name='opentime']").val(timestamp / 1000);
                }  
                if ($("[name='opentime']").val() == undefined || $("[name='opentime']").val() == "") {
                   $("[name='opentime']").focus();
//                   var timestamp = new Date( System. ).val());
                   var timestamp = new Date(System.currentTimeMillis());

                   $("[name='opentime']").val(timestamp / 1000);
               }
                
//                if ($("[name='stationid']").val() == undefined || $("[name='stationid']").val() == "") {
//                   alert("先选择所属乡镇(街道)");
//                   $("[name='stationid']").focus();
//                    $("[name='stationid']").val("");
//                   return false;
//               }
            })
             
        </script>
    </body>
</html>
