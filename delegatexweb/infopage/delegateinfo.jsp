<%-- 
    Document   : delegateinfo
    Created on : 2018-7-16, 17:58:04
    Author     : Administrator
--%>

<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>云上人大代表联络站</title>
        <style>
            body>div{width: 1100px;margin: 0 auto;}
            #header{width: 100%;background:url(../img/tophead.png) no-repeat ;background-size: cover;height:123px;  }  
            #webbody {margin: 10px 23px; border: #ccc solid thin;padding-bottom: 10px;}
            #webbody>h1{background: #f6f6f6;line-height: 42px;text-align: center;margin: 0; font-size: 16px; font-weight: 500;margin-bottom: 15px;}
            #webbody table{margin: 0 93px;border-top: #ccc solid thin;border-right: #ccc solid thin;width: 868px;}
            #webbody table td{border-left: #ccc solid thin;border-bottom: #ccc solid thin;padding: 8px;}
            #webbody table td>div{width: 96px;height: 122px;margin: 10px auto;overflow: hidden;}
            #webbody  table td>div>img{width: 96px;}
            #webbody  table td>p{width: 95px;height: 24px;line-height: 24px;text-align: center;color:#fff;background: #52b4bb;border:#95c2c9 solid thin;margin: 0 auto;margin-top: 65px;
            }
            #footer{background: linear-gradient(to top, #f8fdff, #e2fffc);width: 1054px;text-align: center;margin: 0 auto;height: 88px;border: #95c2c9 solid thin;}
            #footer p{line-height: 22px;font-size: 12px; margin: 0;color: #333333}
            .w200{width: 200px;height: 338px;background:#f3f3f3; }
            #message{cursor: pointer;}
            .popuplayer,.calendarwrap{display: none;}
        </style>
    </head>
    <body>
        <div>
            <div id="header"></div>
            <%
                HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
                RssListView entity = new RssListView(pageContext, "user_delegation");
                entity.request();
                entity.select().where("myid=?",entity.get("relationid")).get_first_rows();
                
                
                 RssList divisionList = new RssList( pageContext, "station_sub_id");
                 divisionList.select().where("myid=?",entity.get("divisionid")).get_first_rows();
                 
                boolean myhavexiancircle = false;//当前用户所属层次
                String mymission = "";//当前用户所属的代表团
            %>`
            <div id="webbody">
                <h1>代表信息</h1>
                <table cellspacing="0">
                    <tr>
                        <td rowspan="8" class="w200">
                        <div><img src="/upfile/<% entity.write("avatar"); %>" alt=""/></div>
                            <p id="message">给代表留言</p>
                            <p id="viewActivity">履职情况</p>
                            <p id="report">我的述职</p>
                        </td>
                        
                        <td width="40%">姓名：<span><% entity.write("realname"); %></span></td>
                        <td width="40%">性别：<span sex="<% entity.write("sex"); %>">男</span></td>
                        <!--<td>出生年月：<span rssdate="<% out.print(entity.get("birthday")); %>,yyyy-MM"></span></td>-->
                    </tr>
                    <tr>
                    </tr>
                    <tr>
<!--                        <td>党派：<span clan="<% entity.write("clan"); %>"></span></td>
                        <td>参加工作时间：<span>1976-04</span></td>-->
                    </tr>
                    <tr>
<!--                        <td>籍贯：<span>浙江绍兴</span></td>
                        <td>学历：<span eduid="<% entity.write("eduid"); %>">大学</span></td>-->
                        <td>民族：<span nationid="<% entity.write("nationid"); %>">汉族</span></td>
                        <td>代表团：<span><% out.print(entity.get("delegationname"));%></span></td>
                    </tr>
                    <tr><td colspan="3">职务：<span><% entity.write("daibiaoDWjob"); %></span></td></tr>
                    
                      <tr><td colspan="3">联络站：<span><% divisionList.write("name"); %></span></td></tr>
                    <!--<tr><td colspan="3">邮政编码：<span><% entity.write("postcode"); %></span></td></tr>-->
                    <tr>
                        <!--<td colspan="3">代表级别：<span>人大代表</span></td>-->
                        <td colspan="3">代表级别：<span><%
                                String[] circleslist = {"全国人大代表", "河南省人大代表", "平顶山市人大代表", "汝州市人大代表", "乡镇人大代表"};//所属层次
                                //String[] circleslist = {"乡镇人大代表", "市人大代表", "盟人大代表", "区人大代表", "全国人大代表"};//所属层次
                                String[] arry = entity.get("circleslist").split(",");

                                String arrylist = "";
                                for (int ind = 0; ind < arry.length; ind++) {
                                    if (!arry[ind].equals("") && !arry[ind].equals("undefined")) {
                                        int arryint = Integer.valueOf(arry[ind]);
                                        //汝州强制把县改为市代表
                                        if ( arryint == 1 ) {
                                            arryint = 2 ;
                                        }
                                        arrylist += circleslist[arryint] + "，";
                                    }
                                }
                                if (!arrylist.equals("")) {
                                    arrylist = arrylist.substring(0, arrylist.length() - 1);
                                }
                                out.print(arrylist);
                                %></span></td>
                    </tr>
                    
                    <!--<tr><td colspan="3">从事职业：<span><% // entity.write("profession"); %></span></td></tr>-->
                    <!--<tr><td colspan="3">个人所在单位网站(微博)：<span></span></td></tr>-->
                </table>
            </div>
            <div id="footer">
                <!--<p>汝州市人大常委会主办</p>-->
                  <p style="margin-top:-10px;">&nbsp;&nbsp;&nbsp;</p>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主办：汝州市人大常委会办公室&nbsp;&nbsp;<a class="ml80" href="https://beian.miit.gov.cn/" target="_blank">豫ICP备17035523号</a></p>
                    <p>电话：0375-6862978<span class="ml144">邮编：467500</span></p>
                    <p>地址：平顶山市汝州市丹阳中路268号</p>
                <!--<p>技术支持：汝州市人大常委会办公厅信息中心</p>-->
            </div>
        </div>
        <%@include  file="/inc/js.html" %>
        <script>
            $("#message").click(function() {
                location.href="/delegatexweb/infopage/suggestsubmit.jsp?myid=<% out.print(entity.get("relationid"));%>";
            })

            $("#viewActivity").click(function() {
//                location.href="/delegatexweb/infopage/activityList.jsp?myid=<% out.print(entity.get("relationid"));%>";
                location.href="/delegatexweb2/activity.htm?myid=<% out.print(entity.get("relationid"));%>" + "&substationid=" + <% out.print(entity.get("divisionid"));%>;

            })
            
          $("#report").click(function() {
                location.href="/delegatexweb2/report.htm?myid=<% out.print(entity.get("relationid"));%>" + "&substationid=" + <% out.print(entity.get("divisionid"));%>;

            })   
            
        </script>
    </body>
</html>
