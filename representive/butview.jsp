<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.MySql.RssListView"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView entity = new RssListView(pageContext, "user_delegation");
    entity.request();
    entity.select().where("myid=?", entity.get("relationid")).get_first_rows();
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
                    <tr><td colspan="7" id="tabheader">代表信息</td></tr>
                    <tr><td rowspan="4"><img src="/upfile/<% entity.write("avatar"); %>"></td><td class="w100 dce">编号</td><td><% entity.write("code"); %></td><td class="w100 dce">姓名</td><td><% entity.write("realname"); %></td><td class="w100 dce">代表团</td><td><% out.print(entity.get("delegationname"));%></td></tr>
                    <tr><td class="w100 dce">性别</td><td sex="<% entity.write("sex"); %>"></td><td class="w100 dce">民族</td><td id="nationid"></td><td class="w100 dce">党派</td><td clan="<% entity.write("clan"); %>"></td></tr>
                    <tr><td class="w100 dce">层次</td><td><%
                        String[] circleslist = {"乡镇人大代表", "县人大代表", "市人大代表", "区人大代表", "全国人大代表"};
                        String[] arry = entity.get("circleslist").split(",");
                        String arrylist = "";
                        for (int ind = 0; ind < arry.length; ind++) {
                            if (!arry[ind].equals("") && !arry[ind].equals("undefined")) {
                                int arryint = Integer.valueOf(arry[ind]);
                                arrylist += circleslist[arryint] + ",";
                            }
                        }
                        if (!arrylist.equals("")) {
                            arrylist = arrylist.substring(0, arrylist.length() - 1);
                        }
                        out.print(arrylist);

                            %></td><td class="w100 dce">学历</td><td eduid="<% entity.write("eduid"); %>"></td><td class="w100 dce">学位</td><td degree="<% entity.write("degree"); %>"></td></tr>
                    <tr><td class="w100 dce">电子邮箱</td><td><% entity.write("email"); %></td><td class="w100 dce">出生年月</td><td rssdate="<% entity.write("birthday"); %>,yyyy-MM"></td><td class="w100 dce">职业</td><td><% entity.write("profession"); %></td></tr>
                    <tr>
                        <td class="w100 dce">手机</td><td colspan="2" class="liuchengyingxiang"><% entity.write("telphone"); %></td>
                        <!--梁小竹添加 人大主席团-->
                        <td class="liucheng w100 dce">人大主席团</td>
                        <td class="liucheng" colspan="3">
                            <%
                                RssListView entity1 = new RssListView(pageContext, "userrole");
                                if(entity.get("presidium") != null && !"".equals(entity.get("presidium"))){
                                    entity1.select().where(" myid = " + entity.get("presidium")).get_first_rows();
                                    out.print(entity1.get("realname"));
                                }else{
                                    out.print("无");
                                }
                            %>
                        </td>
                    </tr>
                    <tr><td class="w100 dce">单位名称</td><td colspan="6"><% entity.write("daibiaoDWname"); %></td>
                        <!--<td class="w100 dce">单位电话</td><td ><% entity.write("daibiaoDWtel"); %></td>-->
                    </tr>
                    <tr><td class="w100 dce">登录账号</td><td colspan="6"><% entity.write("account"); %></td></tr>
                    <tr><td class="w100 dce">职务</td><td colspan="6"><% entity.write("daibiaoDWjob"); %></td></tr>
                    <tr><td class="w100 dce">通讯地址</td><td colspan="4"><% entity.write("daibiaoDWaddress"); %></td><td class="w100 dce">邮编</td><td><% entity.write("daibiaoDWpostcode"); %></td></tr>
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
                            <h1>代表简历</h1>
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