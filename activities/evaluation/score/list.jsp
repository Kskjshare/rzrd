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
            if (score_detail.get("action").equals("append")) {
                score_detail.timestamp();
                score_detail.keyvalue("officerid", UserList.MyID(request));
                if (!score_detail.get("scoredetailid").equals("")) {
                    score_detail.update().where("id="+score_detail.get("scoredetailid")).submit();
                } else {
                    score_detail.keyvalue("scoregroupid", usertype);
                    score_detail.append().submit();
                }
                score.keyvalue("scorestate" + usertype, "1");
                score.update().where("id=" + req.get("scoreid")).submit();
                score.select().where("id=" + req.get("scoreid")).get_first_rows();
                if (score.get("scorestate1").equals("1") && score.get("scorestate2").equals("1") && score.get("scorestate3").equals("1") && score.get("scorestate4").equals("1")) {
                    score.keyvalue("state", "1");
                    score.update().where("id=" + req.get("scoreid")).submit();
                }
                out.print("<script>alert('提交成功！')</script>");
//                out.print("<script>window.location.href='list.jsp';</script>");
            }

            batch.select("id,count(*) as num").where("state=1").get_first_rows();
            if (batch.get("num").equals("0")) {
                out.print("<script>window.location.href='close.jsp'</script>");
                return;
            }
            String sql = "1=1";
            if (usertype.equals("1")) {
                sql += " and myid=" + cookie.Get("myid") + " and batchid=" + batch.get("id");
            } else if (usertype.equals("2") || usertype.equals("3") || usertype.equals("4")) {
                sql += " and id=" + req.get("scoreid");
            } else {
                sql += " and batchid=" + batch.get("id");
            }
            System.out.println(sql + "!!!");
            scoreview.select().where(sql).get_first_rows();

//            if (scoreview.totalrows!=0) {
            standard.select().where("id=" + scoreview.get("standardid")).get_first_rows();
            System.out.println(standard.get("title") + "!!!");
//            }
        %>
        <form method="post" id="mainwrap">
            <%if (usertype.equals("1")) {%><input type="hidden" name="scoreid" value="<%scoreview.write("id");%>"><%}%>
            <div class="toolbar">
                <button type="button" transadapter="butview" class="butview" select="false">计分标准详情</button>
                <%if (!usertype.equals("1")) {%><button type="button" class="res">返回上一级</button><%}%>
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
                        <%if (usertype.equals("1") && scoreview.get("scorestate1").equals("0")) {%>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score1" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score2"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score3"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score4"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score5"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score6"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score7"  ></td>
                        <td><input readonly="true" type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="3" name="score"  ></td>
                            <%} else {
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
                        <%score_detail.clear();
                            }%>
                    </tr>
                    <tr class="FistRow">
                        <td rowspan="3">组织评定</td>
                        <td colspan="2">小组评定</td>
                        <%if (usertype.equals("2") && scoreview.get("scorestate2").equals("0")) {%>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score1" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score2"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score3"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score4"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score5"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score6"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score7"  ></td>
                        <td><input readonly="true" type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="3" name="score"  ></td>
                            <%} else {
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
                        <%score_detail.clear();
                            }%>
                    </tr>
                    <tr>
                        <td colspan="2">乡镇街道评定</td>
                        <%if (usertype.equals("3") && scoreview.get("scorestate3").equals("0")) {%>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score1" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score2"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score3"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score4"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score5"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score6"  ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score7"  ></td>
                        <td><input readonly="true" type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="3" name="score"  ></td>
                            <%} else {
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
                        <%score_detail.clear();
                            }%>
                    </tr>
                    <tr>
                        <td colspan="2">代表部门评定</td>
                        <% score_detail.select().where("scoreid=" + scoreview.get("id") + " and scoregroupid=4").get_first_rows();%>

                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score1" value="<%score_detail.write("score1");%>"></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score2" value="<%score_detail.write("score2");%>" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score3" value="<%score_detail.write("score3");%>" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score4" value="<%score_detail.write("score4");%>" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score5" value="<%score_detail.write("score5");%>" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score6" value="<%score_detail.write("score6");%>" ></td>
                        <td><input type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="2" name="score7" value="<%score_detail.write("score7");%>" ></td>
                        <td><input readonly="true" type="text" oninput = "value=value.replace(/[^\d]/g,'')" maxlength="3" name="score" value="<%score_detail.write("score");%>"  ></td>
                    <input type="hidden" name="scoredetailid" value="<%score_detail.write("id");%>">
                    <%score_detail.clear();%>
                    </tr>
                </table>
            </div>
            <div class="footer">
                <%if (scoreview.get("scorestate" + usertype).equals("0") || usertype.equals("4")) {%>
                <input type="hidden" name="action" value="append" />
                <button type="submit">确定</button>
                <%}%>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script>
            $(".res").click(function () {
//                history.go(-1);
                window.location.href = "/activities/evaluation/evaluate/list.jsp";
            });
            var standarid = <%scoreview.write("standardid");%>;
            $("table input[name^=score][name!=score]").focus(function () {
                if ($(this).val() == '0') {
                    $(this).val('')
                }
            })
            $("table input[name^=score][name!=score]").blur(function () {
                if ($(this).val() == '') {
                    $(this).val('0')
                }
                var score = 0;
                $('table input[name^=score][name!=score]').each(function () {
                    score += Number($(this).val())
                });
                $("input[name=score]").val(score)
            })
            $(".footer>button").click(function () {
                var verify = true;
                $('table input[name^=score][name!=score]').each(function () {
                    if ($(this).val() == undefined || $(this).val() == '') {
                        alert("请填写分数！");
                        $(this).focus();
                        verify = false;
                        return false;
                    }
                    //开始判断是否超过预设分数（计分标准）
                    var name = $(this).attr("name");
                    var num = name.substring(name.length - 1);
                    if (Number($(this).val()) > Number($("#score_std" + num).text())) {
                        alert("填写分数不能超过考核标准分值！")
                        $(this).focus();
                        verify = false;
                        return false;
                    }
                });
                return verify;
            })
        </script>
        <script src="controller.js"></script>
    </body>
</html>