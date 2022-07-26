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
    RssList entity = new RssList(pageContext, "delegation_score");
    RssList list1 = new RssList(pageContext, "user");
    RssList list2 = new RssList(pageContext, "userYear");
    entity.request();
//    if (!entity.get("delegate_score").isEmpty()) {
    if (!entity.get("delegate_score").isEmpty() && !entity.get("year").isEmpty() && !entity.get("note").isEmpty()) {
        entity.remove("id");
        entity.remove("note");
        entity.remove("year");
        entity.delete().where("myid=" + entity.get("id")).submit();
        entity.keymyid(entity.get("id"));
        entity.timestamp();
        entity.append().submit();
//        年份
//        list2.keyvalue("note", entity.get("note"));
//        list2.keyvalue("delegation_score", entity.get("delegation_score"));
        list2.delete().where("myid=" + entity.get("id")).submit();
        list2.keyvalue("year", entity.get("year"));
        list2.keyvalue("myid", entity.get("id"));
        list2.append().submit();
        list1.keyvalue("note", entity.get("note"));
        list1.update().where("myid=" + req.get("id")).submit();
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
                    <td rowspan="2" class="w100">代表姓名</td>
                    <td rowspan="2" class="w100">您给出的评分</td>
                    <td rowspan="2" class="w100">备注</td>
                    <td rowspan="2" class="w100">年份</td>
                    <!--                    <td colspan="2">会议期间(20分)</td><td colspan="8">闭会期间(80分)</td><td rowspan="2" class="w75">扣分</td><td rowspan="2" class="w75">实得分</td>-->
                </tr>
                <tr>
                    <!--                    <td class="w50">一、代表参会情况(5分)</td>
                                        <td class="w50">二、会议表现情况(15分)</td>
                                        <td class="w50">一、遵纪守法廉洁自律情况(10分)</td>
                                        <td class="w50">二、代表培训学习(10分)</td>
                                        <td class="w50">三、代表联系走访选民(10分)</td>
                                        <td class="w50">四、为民办实事(10分)</td>
                                        <td class="w50">五、代表带领带头致富情况(10分)</td>
                                        <td class="w50">六、代表参与社会事务管理(10分)</td>
                                        <td class="w50">七、闭会提建议(10分)</td>
                                        <td class="w50">代表向选民述职(10分)</td>-->
                </tr>
                <%
                    RssList list = new RssList(pageContext, "user");
                    list.request();
                    list.select().where("myid=" + list.get("id")).get_first_rows();
                %>
                <tr>
                    <td><%=list.get("realname")%></td>
                    <!--                    <td><input id="chqk" class="jia" type="text" onkeyup="maxval(this.id, 5)"></td>
                                        <td><input id="hybx" class="jia" type="text" onkeyup="maxval(this.id, 15)"></td>
                                        <td><input id="zlqk" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="pxxx" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="zfxm" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="wmbs" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="dtzf" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="cysh" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="bhjy" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="xmsz" class="jia" type="text" onkeyup="maxval(this.id, 10)"></td>
                                        <td><input id="kf" type="text" onkeyup="maxval(this.id, 100)"></td>-->
                    <td ><input oninput="value=value.replace(/[^\d]/g,'');if(value>100)value=100" type="text" name="delegate_score"></td>
                    <td><input name="note" type="text"></td>
                    <!--<td><input  name="year" type="text"></td>--> 
                    <td>
                        <!--<input  name="year" type="hidden">-->
                        <select id="select" name="year"></select>
                    </td> 
                </tr>
            </table>
            <div class="footer">
                <button type="submit">提交</button>
            </div>
        </form>
        <%@include  file="/inc/js.html" %>
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
                if ($("#kf").val() != "") {
                    var kf = parseInt($("#kf").val());
                    if (kf > all) {
                        alert("总分不能为负数")
                        kf = all;
                        $("#kf").val(all)
                    }
                    all = all - kf;
                }
                $("[name='delegate_score']").val(all);
            }
            $(".footer>button").click(function () {
                if ($("[name='delegate_score']").val() == "") {
                    alert("请填写得分情况");
                    return false;
                }
            })
        </script>
    </body>
</html>
