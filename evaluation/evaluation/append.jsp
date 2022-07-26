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
    RssList entity = new RssList(pageContext, "cbdw_evaluation");
    RssList user = new RssList(pageContext, "user");
    RssList yearDW = new RssList(pageContext, "yearDW");
    entity.request();
    if (!entity.get("result").isEmpty() && !entity.get("year").isEmpty() && !entity.get("note").isEmpty()) {
        entity.remove("id");
        entity.remove("year");
        entity.delete().where("companyid=" + entity.get("id")).submit();
        entity.keyvalue("companyid", entity.get("id"));
        user.keyvalue("zxallscore", entity.get("result"));
//        entity.timestamp();
        entity.append().submit();
        yearDW.delete().where("myid=" + entity.get("id")).submit();
        yearDW.keyvalue("myid", entity.get("id"));
        yearDW.keyvalue("year", entity.get("year"));
        yearDW.append().submit();
        user.update().where("myid=" + entity.get("id")).submit();
        PoPupHelper.adapter(out).iframereload();
        PoPupHelper.adapter(out).showSucceed();
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="mui.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="jquery.js"></script>
	 
        <style>
            .w75{width: 75px;}
            .w75,.w100{text-align: center}
            td>input{width: 80%;border: none}
            td[colspan]{text-align: center;}
            
        </style>
    </head>
    <body>
        <form method="post" class="popupwrap cellbor">
            <table>
                <tr>
                    <th rowspan="2">承办建议单位</th>
                    <!--                    <th colspan="3">办理程序(30分)</th>
                                        <th colspan="3">测评情况(70分)</th>-->
                    <th rowspan="2">结果评定</th>
                    <th rowspan="2">备注</th>
                    <th rowspan="2">年份</th>
                </tr>
                <tr>
                    <!--                    <th>领导重视5分</th>
                                        <th>制度建设5分</th>
                                        <th>办理情况20分</th>
                                        <th>常委会测评占30%</th>
                                        <th>全体代表测评占20%</th>
                                        <th>提建议代表测评占20%</th>-->
                </tr>
                <%
                    RssListView list = new RssListView(pageContext, "user_cbdweval");
                    list.request();
                    list.select().where("myid=" + list.get("id")).get_first_rows();
                %>
                <tr>
                    <td><%=list.get("allname")%></td>
                    <!--                    <td><input id="chqk" class="jia" name='impsorce' type="text" onkeyup="maxval(this.id, 5)"></td>
                                        <td><input id="hybx" class="jia" name='sysscore' type="text" onkeyup="maxval(this.id, 5)"></td>
                                        <td><input id="zlqk" class="jia" name='scorescore' type="text" onkeyup="maxval(this.id, 20)"></td>
                                        <td><input id="pxxx" class="jia" name='cwheval' type="text" onkeyup="maxval(this.id, 30)"></td>
                                        <td><input id="zfxm" class="jia" name='qtdbeval' type="text" onkeyup="maxval(this.id, 20)"></td>
                                        <td><input id="wmbs" class="jia" name='tjydbeval' type="text" onkeyup="maxval(this.id, 20)"></td>-->
                    <td ><input oninput="value=value.replace(/[^\d]/g,'');if(value>100)value=100" type="text" name="result"></td>
                    <td><input name="note" type="text"></td>
                    <!--<td><input  name="year" type="date"></td>--> 
                    <td>
                        <!--<input  name="year" type="hidden">-->
                        <select id="select" name="year"></select>
                    </td> 
                  <!--张迎新修改-->  
                </tr>
            </table>
            <div class="footer">
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
        <script type="text/javascript" src="jquery.jSelectDate.js"></script>
        <script>
            $(function(){
                let nYear = getNowYear();
                for(let i = 0; i<130; i++){
                    let years = 1970 + i;
                    var option = document.createElement("option");
                    option.value = years;
                    option.innerHTML = years;
                    $("#select").append(option);
                    if (years === nYear) {
                        option.selected = true;
                    }
                }
            });
            var getNowYear = function(){
                /* 得到现在的年 */
                var date = new Date();
                return date.getFullYear();
            }
//             张迎新修改 
            function maxval(e, v) {
                var inputdata = $("#" + e).val().replace(/\D/g, '');
                if (inputdata != '' && inputdata < 1) {
                    inputdata = 1;
                }
                if (inputdata != '' && inputdata > v) {
                    inputdata = v;
                }
                $("#" + e).val(inputdata);
                var all = 0;
                $(".jia").each(function () {
                    var fen = $(this).val();
                    if (fen != '') {
                        all = all + parseInt(fen);
                    }
                })
//                if ($("#kf").val() != "") {
//                    var kf = parseInt($("#kf").val());
//                    if (kf > all) {
//                        alert("总分不能为负数")
//                        kf= all;
//                        $("#kf").val(all)
//                    }
//                    all = all -kf;
//                }
                $("[name='result']").val(all);
            }
            $(".footer>button").click(function () {
                if ($("[name='result']").val() == "") {
                    alert("请填写得分情况");
                    return false;
                }
            })
           


        </script>
    </body>
</html>
