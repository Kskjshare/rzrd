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
    
    RssListView entity = new RssListView(pageContext, "activities");
    entity.request();

    entity.select().where("id="+entity.get("id")).get_first_rows();
    
    RssList entity1 = new RssList(pageContext, "activities");
    entity1.request();
    entity1.select().where("id=?",req.get("id") ).get_first_rows();
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
            .b80{width:80%}
            
            .popuplayer img{width:50%; height: 50%;}

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
                        <td><% entity1.write("title"); %></td>
                    </tr>
                    <!--
                    <tr>
                        <td class="dce w100 ">编号：</td>
                        <td><% entity1.write("realid"); %></td>
                    </tr>
                    -->
                    <tr>
                        <td class="dce w100 ">活动类型</td>
                        <td activitiestypeclassify="<% entity1.write("classify"); %>"></td>
                    </tr>
                    <%
                    if (entity1.get("enroll").equals("1") ){
                    %>
                    <tr>
                        <td class="dce w100 ">限额报名人数</td>
                        <td><% entity.write("maxperson"); %></td>
                    </tr>
                    
                     
                    <tr>
                        <td class="dce w100 ">已报名人数</td>
                        <td><% entity1.write("currentperson"); %></td>                      
                    </tr>
                    
                     <%
                    }
                    %>
                    <tr>
                        <td class="dce w100 ">组织部门</td>
                        <td><% entity1.write("department"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">发起时间</td>
                        <td rssdate="<% out.print(entity1.get("shijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">开始时间</td>
                        <td rssdate="<% out.print(entity1.get("beginshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">结束时间</td>
                        <td rssdate="<% out.print(entity1.get("finishshijian")); %>,yyyy-MM-dd" ></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">活动地址</td>
                        <td><% entity1.write("place"); %></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">未考勤代表</td>
                        <td id="unseluserlist">
                        <% if ( entity1.get("userid").isEmpty( ) || entity1.get("private").equals("3") ||  entity1.get("enroll").equals("3")){  
                        %>   
                         <% out.print("无");%>  
                        <% 
                        }else {
                        %>
                        
                        <%
                          String participants = "";
                          String uids[] = entity1.get("userid").split(","); 
                          RssList user = new RssList(pageContext, "user");
                          user.request();
                          for ( int i = 0 ; i < uids.length ; i ++ ) {
                            user.remove();
                             if ( !uids[i].isEmpty() ){
                            user.select().where("myid= "+ uids[i] ).get_first_rows();  
                            participants += user.get("realname");
                            participants += " ";
                            }
                          }
                        %>
                        <% out.print(participants);%>
                        
                        <%
                        }
                        %>
                     
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">已考勤代表</td>
                        <td id="seluserlist">
                        <% 
                            if ( entity1.get("userid").isEmpty( ) ){  
                        %>   
                         <% out.print("无");%>  
                        <% 
                        }else {
                        %>
                        
                        <%
                          String participants = "";
                          String uids[] = entity1.get("userid").split(","); 
                          RssList user = new RssList(pageContext, "user");
                          user.request();
                          
                          String aaa = "";
                          for ( int i = 0 ; i < uids.length ; i ++ ) {
                            user.remove();
                             
                             if ( uids[i] == "") {
                                 aaa = "空白";
                             }
                              if ( uids[i].isEmpty()) {
                                 aaa = "空白";
                             }
                            if ( !uids[i].isEmpty() ){
                            user.select().where("myid= "+ uids[i] ).get_first_rows();  
                            participants += user.get("realname");
                            participants += " ";
                            }
                          }
                        %>
                        <% out.print(participants);%>
                        
                        <%
                        }
                        %>
                     
                        </td>
                    </tr>
                    <tr>
                        <td class="dce w100 left"><span>活动安排</span></td>
                        <td><div class="textareadiv"><% entity1.write("note"); %></div></td>
                    </tr>
                    <tr>
                        <td class="dce w100 ">附件</td>
                        <td>
                            

                            <%
                                
                               
                                String[] arry1 = {"", "", ""};
                                String[] arry2 = {"", "", ""};
                                if ( !entity1.get("enclosure").isEmpty() ) {
                                    String[] str1 = entity1.get("enclosure").split(",");
                                    String[] str2 = entity1.get("enclosurename").split(",");
                                    for (int idx = 0; idx < str1.length; idx++) {
                                        arry1[idx] = str1[idx];
                                        arry2[idx] = str2[idx];
                            %>
                            
                            <input readonly="true" class="b80"  style="border:none;background: #fbfbfb;" value="<% out.print(arry2[idx]); %>"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="preview('/upfile/<% out.print(arry1[idx]); %>')" href="javascript:void(0)" style="cursor: pointer;color: blue;font-weight: bold;">点击查看</a>
                            
                            
                            
                            <div id="prev" style="
                                position: fixed;
                                left: 0;
                                right: 0;
                                top: 0;
                                bottom: 0;
                                /*overflow: scroll;*/
                                display: none;
                                justify-content: center;
                                align-items: center;
/*                                left: 50%;
                                top: 50%;
                                transform: translate(-50%, -50%);*/
                            "></div>
                            
                            <script>
                                function preview(src) {
                                    var prev = document.getElementById('prev')
                                    prev.style.display = 'flex'
                                    prev.innerHTML = '<img src="' + src + '" style="width: 80%;height:90%">'
                                    prev.onclick = function() {
                                        prev.innerHTML = ''
                                        prev.style.display = 'none'
                                    }
                                }
                            </script>
                            
                            
                            <%
                                    }
                                }
                            %>
                        </td>
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
        
        <script>
//            let iframeDocument = document.getElementsByClassName(".popuplayer > div > iframe")[0].contentDocument;
//            iframeDocument.img.width = '100%'
            var t = $(this).parent();
            $(".popuplayer > div > iframe").find("img").css('width','100%');
            t.css('width','100%');
        </script>
    </body>
</html>
