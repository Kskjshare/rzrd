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
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();

    RssListView entity = new RssListView(pageContext, "contactstation_sub");

    RssList editentity = new RssList(pageContext, "contactstation_sub");
    CookieHelper cookie = new CookieHelper(request, response);
    editentity.request();
    entity.request();
    String rdId= req.get("mission");
    
    RssList contactstation_new = new RssList(pageContext, "contactstation_new");
    contactstation_new.request();
    
    
    RssList userlist = new RssList(pageContext, "user");
    userlist.request();
//    userlist.select().where("myid=?", req.get("id")).get_first_rows();


    if (!editentity.get("action").isEmpty()) {
        switch (editentity.get("action")) {
            case "append":
//                editentity.timestamp();
//                editentity.keymyid(cookie.Get("myid"));
                
//                
//                contactstation_new.select().where("id=?", entity.get("stationid")).get_first_rows();
//
//                editentity.keyvalue("myid",contactstation_new.get("myid"));
//                editentity.keyvalue("stationid",entity.get("stationid"));
//                editentity.append().submit();
                break;
            case "update":

//                editentity.remove("id");
//                editentity.update().where("id=?", entity.get("id")).submit();
                
                
                userlist.remove("id");
                userlist.remove("name");
                userlist.update().where("myid=?", "1655").submit();
               
                

                break;
        }
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
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
            .cellbor>tbody>tr>td>input{width: 98%;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .popupwrap>div:first-child{height: 100%;}
            
            .b95{width: 100%;height:36px;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                  
                    <tr>
                        <td class="dce w100 ">选择站点名称</td>
                        <td id="stationsel">
                            <input class="b95" readonly="readonly" value="<% entity.write("name"); %>"/>
                            <input type="hidden" name="divisionname" id="divisionname" value="<% userlist.write("divisionname"); %>"/>
                        </td>
                    </tr>
                   
                </table>
            </div>
            <div class="footer">
                <input type="hidden" name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update"); %>" />
                <button type="submit"><% out.print(entity.get("id").isEmpty() ? "增加" : "修改");%></button>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/street.js"></script>
        <script>
           var rdId ="<%=rdId%>";
            $("#stationsel>input").click(function () {
                RssWin.onwinreceivemsg = function (dict) {
                    var userrolename = [], userroleval = [];
                    $.each(dict, function (k, v) {
                        userrolename.push(v.name)
                        userroleval.push(v.id)  
                    })
                    $("#stationsel").find("input:first").val(userrolename)
//                    alert(userrolename)
                    
//                    $("#stationid").val(userroleval)
                    $("#divisionname").val( userrolename )


                }
                RssWin.open("/contactstation/representative/selectsubstation.jsp?mission="+ rdId, 700, 650);

//              RssWin.open("/contactstation/representative/selectsubstation.jsp?mission=1043", 700, 650);
            });
            
            $(".footer>button").click(function () {
               
            })
             
        </script>
    </body>
</html>
