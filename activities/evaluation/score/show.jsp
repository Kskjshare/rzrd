<%@page import="RssEasy.Core.PoPupHelper"%>
<%@page import="RssEasy.Core.HttpRequestHelper"%>
<%@page import="RssEasy.Core.CookieHelper"%>
<%@page import="RssEasy.MySql.User.UserList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="RssEasy.MySql.RssListView"%>
<%@page import="RssEasy.MySql.RssList"%>
<%@page import="RssEasy.MySql.Staff.StaffList"%>
<%@page import="RssEasy.DAL.Pagination"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    StaffList.IsLogin(request, response);
    RssListView scoreview = new RssListView(pageContext, "evaluation_score");
    RssList score = new RssList(pageContext, "evaluation_score");
    RssList standard = new RssList(pageContext, "evaluation_standard");
    RssList batch = new RssList(pageContext, "evaluation_batch");
    RssList score_detail = new RssList(pageContext, "evaluation_score_detail");

    CookieHelper cookie = new CookieHelper(request, response);
    HttpRequestHelper req = new HttpRequestHelper(pageContext).request();
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
            tbody tr:hover{background-color: gainsboro;}
            table th{
                font-weight: normal;
            }
            table,th,td{
                font-family: 仿宋;
                font-size: large;
                /*border: 1px solid #000;*/
                height: 53px;
                /* width: 100px; */
            }
            .FistRow>td:first-child{
                box-sizing: border-box;
                width: 40px!important;
                padding: 4px 20px!important;
            }
            .FistRow>td:nth-child(2){
                width: 100px;
            }
            #tabheader{background: #82bee9de;text-align: center; color: #fff; height: 10px;
            }
            #section th:nth-of-type(2n+1){
                font-weight: bold;
            }
            .details td:last-child{
                width: 100px;
            }
            #section tr th{
                font-size: large;
            }
            .userData{ height: 70px;}
            tr td>input{
                width: 90%;
                height: 100%;
                border: none;
                background-color: transparent;
                text-align: center;
            }
            .res{float: right;}
        </style>
    </head>
    <body>
        <%
            String usertype = "0";
            if (cookie.Get("powergroupid").equals("5")) {
                usertype = "1";
            } else if (cookie.Get("powergroupid").equals("32")) {
                usertype = "2";
            } else if (cookie.Get("powergroupid").equals("22")) {
                usertype = "3";
            } else if (cookie.Get("powergroupid").equals("33")) {
                usertype = "4";
            }
            score_detail.request();

            batch.select("id,count(*) as num").where("state=1").get_first_rows();
            String sql = "1=1";
            sql += " and id=" + req.get("scoreid");
            scoreview.select().where(sql).get_first_rows();
            standard.select().where("id=" + scoreview.get("standardid")).get_first_rows();
        %>
        <form method="post" id="mainwrap">
            <div class="toolbar">
                <button type="button" transadapter="butview" class="butview" select="false">计分标准详情</button>
                <button type="button" class="res">返回上一级</button>
            </div>
            <div class="bodywrap">
                <table  class="wp100 tc cellbor" id="section"> 
                    <tr>
                        <td colspan="11" id="tabheader">个人信息</td>
                    </tr>
                    <tr class="FistRow userData">
                        <th >姓名</th>
                        <th colspan="2" style="width: 200px;"><%scoreview.write("realname");%></th>
                        <th >性别</th>
                        <th colspan="2" sex="<%scoreview.write("sex");%>"></th>
                        <th>民族</th>
                        <th nationid="<%scoreview.write("nationid");%>"></th>
                        <th>原选举单位</th>
                        <th colspan="2" daibiaoDWname="<%scoreview.write("daibiaoDWname");%>"></th>
                    </tr>
                    <tr class="FistRow">
                        <td>单位及职务</td>
                        <td colspan="6" ><%scoreview.write("daibiaoDWname");%></td>
                        <td colspan="2">代表联络站</td>
                        <td colspan="2"><%scoreview.write("allname");%></td>
                    </tr>
                    <tr>
                        <td colspan="11" id="tabheader">评定打分</td>
                    </tr>
                    <tr class="FistRow">
                        <td></td>
                        <td colspan="2">- - -</td>
                        <td colspan="3">会议期间履职情况</td>
                        <td colspan="4">闭会期间履职情况</td>
                        <td>- - -</td>
                    </tr>
                    <tr class="FistRow details">
                        <td></td>
                        <td colspan="2">- - -</td>
                        <td >参加市人代会会议情况</td>
                        <td >会议审议、发言情况</td>
                        <td >提出议案、建议情况</td>
                        <td >列席会议及参加其他活动情况</td>
                        <td >参加视察、专题调研和执法检查情况</td>
                        <td >参加代表小组活动情况</td>
                        <td >与原选举单位和人民群众保持密切联系情况</td>
                        <td >考核总分</td>
                    </tr>
                    <tr class="FistRow">
                        <td rowspan="2"></td>
                        <td colspan="2">考核分值</td>
                        <td id="score_std1"><%standard.write("score_std1");%></td>
                        <td id="score_std2"><%standard.write("score_std2");%></td>
                        <td id="score_std3"><%standard.write("score_std3");%></td>
                        <td id="score_std4"><%standard.write("score_std4");%></td>
                        <td id="score_std5"><%standard.write("score_std5");%></td>
                        <td id="score_std6"><%standard.write("score_std6");%></td>
                        <td id="score_std7"><%standard.write("score_std7");%></td>
                        <td id="score_std"><%standard.write("score_std");%></td>
                    </tr>
                    <tr>
                        <td colspan="2">代表自评</td>
                        <%
                            score_detail.select().where("scoreid=" + scoreview.get("id") + " and scoregroupid=1").get_first_rows();
                        %>
                        <td><%score_detail.write("score1");%></td>
                        <td><%score_detail.write("score2");%></td>
                        <td><%score_detail.write("score3");%></td>
                        <td><%score_detail.write("score4");%></td>
                        <td><%score_detail.write("score5");%></td>
                        <td><%score_detail.write("score6");%></td>
                        <td><%score_detail.write("score7");%></td>
                        <td><%score_detail.write("score");%></td>
                        <%score_detail.clear();%>
                    </tr>
                    <tr class="FistRow">
                        <td rowspan="3">组织评定</td>
                        <td colspan="2">小组评定</td>
                        <%
                            score_detail.select().where("scoreid=" + scoreview.get("id") + " and scoregroupid=2").get_first_rows();
                        %>
                        <td><%score_detail.write("score1");%></td>
                        <td><%score_detail.write("score2");%></td>
                        <td><%score_detail.write("score3");%></td>
                        <td><%score_detail.write("score4");%></td>
                        <td><%score_detail.write("score5");%></td>
                        <td><%score_detail.write("score6");%></td>
                        <td><%score_detail.write("score7");%></td>
                        <td><%score_detail.write("score");%></td>
                        <%score_detail.clear();%>
                    </tr>
                    <tr>
                        <td colspan="2">乡镇街道评定</td>
                        <%
                            score_detail.select().where("scoreid=" + scoreview.get("id") + " and scoregroupid=3").get_first_rows();
                        %>
                        <td><%score_detail.write("score1");%></td>
                        <td><%score_detail.write("score2");%></td>
                        <td><%score_detail.write("score3");%></td>
                        <td><%score_detail.write("score4");%></td>
                        <td><%score_detail.write("score5");%></td>
                        <td><%score_detail.write("score6");%></td>
                        <td><%score_detail.write("score7");%></td>
                        <td><%score_detail.write("score");%></td>
                        <%score_detail.clear();%>
                    </tr>
                    <tr>
                        <td colspan="2">代表部门评定</td>
                        <%
                            score_detail.select().where("scoreid=" + scoreview.get("id") + " and scoregroupid=4").get_first_rows();
                        %>
                        <td><%score_detail.write("score1");%></td>
                        <td><%score_detail.write("score2");%></td>
                        <td><%score_detail.write("score3");%></td>
                        <td><%score_detail.write("score4");%></td>
                        <td><%score_detail.write("score5");%></td>
                        <td><%score_detail.write("score6");%></td>
                        <td><%score_detail.write("score7");%></td>
                        <td><%score_detail.write("score");%></td>
                        <%score_detail.clear();%>
                    </tr>
                </table>
            </div> 
            <div class="footer">

            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".res").click(function () {
                history.go(-1);
            });
            var standarid = <%scoreview.write("standardid");%>;
        </script>
        <script src="controller.js"></script>
    </body>
</html>