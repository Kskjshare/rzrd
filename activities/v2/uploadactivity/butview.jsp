<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.Core.StringExtend"%>
<%@page import="RssEasy.Core.Encrypt"%>
<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.DateTimeExtend"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
//    String uids = req.get("userid");
    
    RssList entity = new RssList(pageContext, "activities");// activities_upload
    entity.request();
    entity.select().where("id="+ req.get("id")).get_first_rows();
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
            .cellbor{border: 0}
            .dce{text-indent: 10px}
            .cellbor td{padding: 0 6px}
            .cellbor>tbody>tr>td{line-height: 34px;position: relative;}
            /*.cellbor>tbody>tr>td>p{border: #eee solid 2px;padding: 0 5px;}*/
            .cellbor .textareadiv{height: 120px;margin-top: 5px;padding: 0 3px;border: #ffffff solid 2px;}
            .cellbor{width: 100%}
            .cellbor select,.cellbor input{height: 28px;border: #d0d0d0 solid thin }
            .cellbor select{width: 256px;height: 32px;} 
            .cellbor textarea{height: 205px;margin-top: 5px;width: 89%;font-size: 14px;} 
            .cellbor .textareadiv{height: 100%;margin-top: 5px}
            .cellbor input{height: 24px;border: #d0d0d0 solid thin;}
            .cellbor .institle{text-align: center;}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            #matter{line-height: 12px;}
            .left>span{
/*                position: absolute;top: 10px;left: 6px;*/
                line-height:50px;
            }
            .w630{width:630px;}
            #seluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
            #unseluserlist em{background:rgb(101, 113, 128);padding: 1px 2px;color: #fff; border-radius: 5px;margin: 0 2px;cursor: pointer;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr>
                        <td class="dce w100 ">标题</td>
                        <td><% entity.write("title"); %></td>
                    </tr>
                    
                    <tr>
                        <td class="dce w100 ">类型</td>
                        <td activitiestypeclassify="<% entity.write("classify"); %>"></td>
                    </tr>
                   
                     <tr>
                        <td class="dce w100 ">活动地址</td>
                        <td><% entity.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">发起时间</td>
                        <td rssdate="<% out.print(entity.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                     <tr>
                        <td class="dce w100 ">履职时间</td>
                        <td rssdate="<% out.print(entity.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                   
                    <tr>
                        <td class="dce w100 ">参与代表</td>
                        <td id="unseluserlist">
                            <%
 
                                RssList list_user = new RssList(pageContext, "user");
                                String realname = "";
                                String uids = entity.get("userid");
                                if ( !uids.isEmpty() ) {
                                String datasplit [] = uids.split(",");
                                
                                for ( int i = 0 ; i < datasplit.length ; i ++ ) {                                 
                                    list_user.remove( );
                                    list_user.select().where("myid=" + datasplit[i] ).get_first_rows(); 
                                    realname += list_user.get("realname") + "  ";
                                }    
                                out.print(realname);
                                }else {
                                    list_user.select().where("myid=" + entity.get("myid")).get_first_rows(); 
                                    realname += list_user.get("realname") + "  ";
                                }
                            %>

                        </td>
                    </tr>
                   
                    <tr>
                        <td class="dce w100 left"><span>活动内容</span></td>
                        <td><div class="textareadiv"><% entity.write("note"); %></div></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件</td>
                        <td>

                            <%
                                
                                System.out.println(entity.get("enclosure"));
                                System.out.println(entity.get("enclosurename"));
                                System.out.println("00000000000");
                                String[] arry1 = {"", "", ""};
                                String[] arry2 = {"", "", ""};
                                if (!entity.get("enclosure").isEmpty()) {
                                    String[] str1 = entity.get("enclosure").split(",");
                                    String[] str2 = entity.get("enclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                                        arry2[idx] = str2[idx];
                            %>
                            
                            <input readonly="true" class="xz"  style="border:none" value="<% out.print(arry2[idx]); %>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="/upfile/<% out.print(arry1[idx]); %>" style="cursor: pointer;color: blue;font-weight: bold;">点击查看</a>
                            <%
                                    }
                                }
                            %>
                        </td>
                    <tr>
                        
                  <tr>
                        <td class="dce w100 ">审核状态</td>
                      
                        <td><%
                                if ( entity.get("privateaudit").equals("1") ) {
                                    out.print("<b style='color:green;font-size:14px;' >已审核通过</b>") ;
                                }
                                else if ( entity.get("privateaudit").equals("2") ) {                                
                                    out.print("<b style='color:red;font-size:14px;' >审核未通过</b>") ;
                                }
                                else {                           
                                  out.print("<b style='color:orange;font-size:14px;' >未审核</b>") ;
                                }
                                %></td>                           
                             
                             <td>                 
                    </tr>
                        

                    <tr class="thismyid">
                        <td class="tr">作者ID</td>
                        <td colspan="3"><input type="hidden" name="action" value="append" /><input type="text" name="myid" class="w50" value="<% out.print(UserList.MyID(request));%>" selectuser=""/> <label></label></td>
                    </tr>
                </table>
            </div>

        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
    </body>
</html>
