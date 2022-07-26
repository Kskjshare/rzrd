<%-- 
    Document   : tianjiafenlei
    Created on : 2021-3-27, 21:05:46
    Author     : Administrator
--%>
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
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>

<%    

    StaffList.IsLogin(request, response);
    RssList entity = new RssList(pageContext, "companytypee_classify");
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
    entity.request();
//    String keywhere = "name like '%" + URLDecoder.decode( entity.get("name"), "utf-8") + "%'";  
//    entity.select().where( keywhere ).get_page_desc("pid");
//    int total = entity.totalrows + 1 ;
    
    if (!entity.get("action").isEmpty()) {
        //entity.remove("id");
       
       // entity.remove("secound");
//        if (entity.get("summary").isEmpty()) {
//            entity.keyvalue("summary", StringExtend.substr(StringExtend.delHtmlTag(entity.get("matter")), 120));
//        }
        
        //entity.keyvalue("id", total );
        //entity.timestamp();
        entity.append().submit();

        out.print("<script>alert('操作成功！');</script>");
    }
    entity.select().where("id=?", entity.get("id")).get_first_rows();
   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>添加记录</title>
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
            .w498{width: 99%;}
            #suggesttype{
                font-size: 14px;
            }
            .w98{width: 98%;}
            .meetingtime{color: red}
            /*撑下边按钮*/
            .chengyemian{

                height: 50px;
            }
            .yanse{
                color: blue;
                font-weight: 600;
            }
            

        </style>
    </head>
    <body>
        <form id="fileeform2" class="fileeform" ridform="2" enctype="multipart/form-data" method="post">
            <input type="file" id="file2" ridform="2"  name="file2" multiple>
        </form>
        <form id="fileeform3" class="fileeform" ridform="3" enctype="multipart/form-data" method="post">
            <input type="file" id="file3" ridform="3"  name="file3" multiple>
        </form>
        <form method="post" class="popupwrap"> 
            <div>
                <h1>添加审查类别</h1>
                <table class="wp100 cellbor">
                    <tr>
                        <td>类别</td>
                        <td >
                            <input class="w98" placeholder="输入审查类别" type="text" name="name" value="<% entity.write("name"); %>"  ></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="">
                            <input type="hidden"  name="action" value="<% out.print(entity.get("id").isEmpty() ? "append" : "update");%>" />
                <button type="submit" style="border-radius: 12px; width: 80px; height: 20px; background-color: #808080;margin-left:40%;  "><% out.print(entity.get("topic").isEmpty() ? "提交" : "修改");%></button></td>
                    </tr>
                </table>
                    
            </div>
        </form>
        <script src="/data/bill.js" type="text/javascript"></script>
        <script src="/data/session.js"></script>
        <script src="/data/companytypee.js" type="text/javascript"></script>
        <script src="/data/companytypeee.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        
          
     
    </body>
</html>