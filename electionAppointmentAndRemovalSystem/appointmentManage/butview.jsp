<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();    
    RssList entity = new RssList(pageContext, "appointment");
    entity.request();
    entity.select().where("id=?", req.get("id")).get_first_rows();    
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
            .cellbor td img{width: 100%}
            .cellbor>tbody>tr>td{border: #6caddc solid thin;line-height: 34px;}
            .cellbor{width: 100%}
            .cellbor>tbody>tr>.uetd{padding:8px 0;background: #dce6f5}
            .uetd>div>p{min-height: 100px;background: #FFF;margin: 0 0.9%;padding: 3px;border: #6caddc solid thin;}
            .popupwrap>div:first-child{height: 100%;}
            td>h1{text-align: center;margin:0;}
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap">           
            <div>
                <table class="wp100 cellbor">
                    <tr><td colspan="7" id="tabheader">任免信息</td></tr>
                    <tr><td rowspan="4"><img src="/upfile/<% entity.write("avatar"); %>"></td><td class="w100 dce">姓名</td><td><% entity.write("realname"); %></td><td class="w100 dce">性别</td colspan="2" ><td><% entity.write("sex"); %></td><td class="w100 dce">出生日期</td><td rssdate="<% entity.write("birthday"); %>,yyyy-MM-dd"></td></tr>
                    <tr><td class="w100 dce">民族</td><td id="nationid"></td ><td colspan="2"  class="w100 dce">党派</td><td clan="<% entity.write("clan"); %>"></td><td class="w100 dce">学历</td><td clan="<% entity.write("eduid"); %>"></td></tr>
                    
                    <tr><td class="w100 dce">电子邮箱</td><td><% entity.write("email"); %></td> <td class="w100 dce">手机</td><td colspan="2" class="liuchengyingxiang"><% entity.write("telphone"); %></td><td class="w100 dce">学位</td><td clan="<% entity.write("degree"); %>"></td></tr>
                    <tr><td class="w100 dce">出生日期</td><td rssdate="<% entity.write("appointshijian"); %>,yyyy-MM-dd"></td><td class="w100 dce">会议届次</td><td clan="<% entity.write("session"); %>"></td><td class="w100 dce">会议次数</td><td clan="<% entity.write("meetingnum"); %>"></td></tr>
                    <tr><td class="w100 dce">职务</td><td><% entity.write("post"); %></td> <td class="w100 dce">任免书编号</td><td colspan="2" class="liuchengyingxiang"><% entity.write("appointNo"); %></td><td class="w100 dce">通知文号</td><td clan="<% entity.write("noticeNo"); %>"></td></tr>

                  
                    <tr><td class="w100 dce">通讯地址</td><td colspan="4"><% entity.write("address"); %></td><td class="w100 dce">邮编</td><td><% entity.write("postcode"); %></td></tr>
                    <tr><td class="w100 dce">届次</td>
                        <td colspan="4">
                            <%
                                String[] arry1 = entity.get("sessionlist").split(",");
                                for (int ind = 0; ind < arry1.length; ind++) {
                                    if (!arry1[ind].equals("") && !arry1[ind].equals("undefined")) {
                                        int arryint = Integer.valueOf(arry1[ind]);
                                        out.print("<span sessionclassify='" + arryint + "'></span>，");
                                    }
                                }
                            %>
                        </td>
                        <td class="w100 dce">状态</td><td enabled="<% out.print(entity.get("enabled")); %>"></td></tr>

                    <tr>
                        <td colspan="7" class="marginauto uetd">
                            <h1>个人履历</h1>
                            <div><% entity.write("matter"); %></div>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <script src="/data/suggest.js" type="text/javascript"></script>
        <%@include  file="/inc/js.html" %>
        <script src="/data/nationality.js"></script>
        <script src="/data/session.js"></script>
        <script src="/data/dictdata.js"></script>
        <script>
            $(".uetd>ul>li").click(function () {
                $(this).addClass("sel").siblings("li").removeClass("sel");
            })
            if (<% entity.write("nationid"); %>) {
                $("#nationid").text(dictdata["nationid"][<% entity.write("nationid");%>][0])
            }

        </script>
        
                <!--
            添加开始
            修改人:梁小竹
            时间:2021.02.24
            说明:用于控制添加代表时的人大主席团选项的显示与不显示
        -->
        <script src="../liuChengSwitch.js"></script>
        <script>
            $(function(){
                if(liuchengflog === 2){
                    //如果是2，则议案建议流程不分开会闭会期间,界面显示做调整
//                    alert(liuchengflog);
                    $(".liucheng").remove();
                    $(".liuchengyingxiang").attr("colSpan","6");
                    
                }else{
                    //                    alert(liuchengflog);
                    //如果是1，则议案建议流程分开会闭会期间
                }
            });
        </script>
        
        <!--梁小竹修改结束-->
    </body>
</html>